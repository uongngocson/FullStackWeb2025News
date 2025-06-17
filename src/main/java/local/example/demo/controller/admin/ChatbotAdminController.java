package local.example.demo.controller.admin;

import local.example.demo.service.DataIngestionService;
import local.example.demo.service.ProductIngestService;
import local.example.demo.service.FAISSVectorStore;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/chatbot")
public class ChatbotAdminController {

    @Autowired
    private DataIngestionService dataIngestionService;

    @Autowired
    private ProductIngestService productIngestService;

    @Autowired
    private FAISSVectorStore vectorStore;

    /**
     * Admin page for chatbot management
     */
    @GetMapping
    public String adminPage(Model model) {
        // Add total documents count to the model
        model.addAttribute("totalDocuments", vectorStore.getDocumentCount());
        return "admin/chatbot/index";
    }

    /**
     * Ingest a custom document for the chatbot
     */
    @PostMapping("/ingest/document")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestDocument(
            @RequestParam("text") String text,
            @RequestParam("title") String title,
            @RequestParam("type") String type) {

        Map<String, Object> response = new HashMap<>();

        try {
            // Create metadata
            Map<String, Object> metadata = new HashMap<>();
            metadata.put("title", title);
            metadata.put("type", type);

            // Ingest document
            String docId = dataIngestionService.ingestDocument(text, metadata);

            if (docId != null) {
                response.put("success", true);
                response.put("documentId", docId);
                response.put("message", "Document ingested successfully");
            } else {
                response.put("success", false);
                response.put("message", "Failed to ingest document");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Manually trigger product data ingestion
     */
    @PostMapping("/ingest/products")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestProducts() {
        Map<String, Object> response = new HashMap<>();

        try {
            // Run product ingestion in a separate thread to avoid blocking
            new Thread(() -> {
                try {
                    productIngestService.ingestAllProducts();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();

            response.put("success", true);
            response.put("message", "Product ingestion started successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Ingest products from top categories
     */
    @PostMapping("/ingest/top-categories/{count}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestTopCategories(@PathVariable("count") int count) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Validate count
            if (count <= 0) {
                count = 5; // Default to 5 if invalid
            } else if (count > 50) {
                count = 50; // Cap at 50 to prevent excessive load
            }
            
            // Run ingestion in a separate thread
            final int categoryCount = count;
            new Thread(() -> {
                try {
                    productIngestService.ingestProductsByTopCategories(categoryCount);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();

            response.put("success", true);
            response.put("message", "Started ingestion for top " + count + " categories");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }
    
    /**
     * Ingest products for a specific category
     */
    @PostMapping("/ingest/category/{categoryId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestCategory(@PathVariable("categoryId") int categoryId) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Run ingestion in a separate thread
            new Thread(() -> {
                try {
                    productIngestService.ingestProductsByCategory(categoryId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }).start();

            response.put("success", true);
            response.put("message", "Started ingestion for category ID " + categoryId);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Ingest a specific product
     */
    @PostMapping("/ingest/product/{productId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestProduct(@PathVariable("productId") int productId) {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean success = productIngestService.ingestProduct(productId);

            if (success) {
                response.put("success", true);
                response.put("message", "Product " + productId + " ingested successfully");
            } else {
                response.put("success", false);
                response.put("message", "Failed to ingest product " + productId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Ingest chunked text data
     */
    @PostMapping("/ingest/chunked")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> ingestChunkedText(
            @RequestParam("text") String text,
            @RequestParam("title") String title,
            @RequestParam("chunkSize") int chunkSize,
            @RequestParam("overlap") int overlap,
            @RequestParam("type") String type) {

        Map<String, Object> response = new HashMap<>();

        try {
            // Create metadata
            Map<String, Object> metadata = new HashMap<>();
            metadata.put("title", title);
            metadata.put("type", type);

            // Ingest with chunking
            var docIds = dataIngestionService.ingestTextWithChunking(text, chunkSize, overlap, metadata);

            if (docIds != null && !docIds.isEmpty()) {
                response.put("success", true);
                response.put("documentCount", docIds.size());
                response.put("message", "Text ingested successfully in " + docIds.size() + " chunks");
            } else {
                response.put("success", false);
                response.put("message", "Failed to ingest chunked text");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Enable or disable saving metadata to disk
     */
    @PostMapping("/metadata/save-to-disk")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> setSaveMetadataToDisk(@RequestParam("enable") boolean enable) {
        Map<String, Object> response = new HashMap<>();

        try {
            vectorStore.setSaveMetadataToDisk(enable);
            
            response.put("success", true);
            response.put("enabled", vectorStore.isSaveMetadataToDisk());
            response.put("message", "Metadata saving to disk " + (enable ? "enabled" : "disabled") + " successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * Get the current status of metadata saving to disk
     */
    @GetMapping("/metadata/save-to-disk/status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getSaveMetadataToDiskStatus() {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean isEnabled = vectorStore.isSaveMetadataToDisk();
            
            response.put("success", true);
            response.put("enabled", isEnabled);
            response.put("message", "Metadata saving to disk is currently " + (isEnabled ? "enabled" : "disabled"));
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }
}