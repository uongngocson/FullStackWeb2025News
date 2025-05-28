package local.example.demo.controller.admin;

import local.example.demo.service.DataIngestionService;
import local.example.demo.service.ProductIngestService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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

    /**
     * Admin page for chatbot management
     */
    @GetMapping
    public String adminPage() {
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
}