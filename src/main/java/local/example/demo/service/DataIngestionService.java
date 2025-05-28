package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@Service
public class DataIngestionService {

    @Autowired
    private TextEmbeddingService embeddingService;

    @Autowired
    private FAISSVectorStore vectorStore;

    /**
     * Process and ingest a document into the vector store
     * 
     * @param text     The text content of the document
     * @param metadata Additional metadata about the document
     * @return The document ID if successful, or null if failed
     */
    public String ingestDocument(String text, Map<String, Object> metadata) {
        try {
            // Generate embedding for the document
            float[] embedding = embeddingService.generateEmbedding(text);
            if (embedding == null) {
                System.err.println("Failed to generate embedding for document");
                return null;
            }

            // Add document to vector store
            String docId = vectorStore.addDocument(text, embedding, metadata);
            System.out.println("Ingested document with ID: " + docId);

            return docId;
        } catch (Exception e) {
            System.err.println("Error ingesting document: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Ingest multiple documents at once
     * 
     * @param documents List of documents to ingest
     * @return Number of successfully ingested documents
     */
    public int ingestDocuments(List<Map<String, Object>> documents) {
        int successCount = 0;

        for (Map<String, Object> document : documents) {
            String text = (String) document.get("text");
            if (text == null || text.isEmpty()) {
                System.err.println("Skipping document with empty text");
                continue;
            }

            // Create metadata map
            Map<String, Object> metadata = new HashMap<>();
            for (Map.Entry<String, Object> entry : document.entrySet()) {
                if (!entry.getKey().equals("text")) {
                    metadata.put(entry.getKey(), entry.getValue());
                }
            }

            // Ingest document
            String docId = ingestDocument(text, metadata);
            if (docId != null) {
                successCount++;
            }
        }

        return successCount;
    }

    /**
     * Process longer text by breaking it into chunks and ingesting each chunk
     * 
     * @param text      The text to chunk and ingest
     * @param chunkSize The size of each chunk
     * @param overlap   The overlap between chunks
     * @param metadata  Shared metadata for all chunks
     * @return List of document IDs for ingested chunks
     */
    public List<String> ingestTextWithChunking(String text, int chunkSize, int overlap, Map<String, Object> metadata) {
        List<String> docIds = new ArrayList<>();

        // Skip if text is too short
        if (text == null || text.length() < chunkSize) {
            String docId = ingestDocument(text, metadata);
            if (docId != null) {
                docIds.add(docId);
            }
            return docIds;
        }

        // Split text into chunks
        List<String> chunks = chunkText(text, chunkSize, overlap);
        for (int i = 0; i < chunks.size(); i++) {
            String chunk = chunks.get(i);

            // Add chunk-specific metadata
            Map<String, Object> chunkMetadata = new HashMap<>(metadata);
            chunkMetadata.put("chunk_index", i);
            chunkMetadata.put("total_chunks", chunks.size());

            // Ingest chunk
            String docId = ingestDocument(chunk, chunkMetadata);
            if (docId != null) {
                docIds.add(docId);
            }
        }

        return docIds;
    }

    /**
     * Split text into overlapping chunks
     * 
     * @param text      The text to chunk
     * @param chunkSize The size of each chunk
     * @param overlap   The overlap between chunks
     * @return List of text chunks
     */
    private List<String> chunkText(String text, int chunkSize, int overlap) {
        List<String> chunks = new ArrayList<>();

        if (text == null || text.isEmpty()) {
            return chunks;
        }

        // Split by paragraphs first
        String[] paragraphs = text.split("\n\n");
        StringBuilder currentChunk = new StringBuilder();

        for (String paragraph : paragraphs) {
            // If adding this paragraph exceeds chunk size, finalize current chunk
            if (currentChunk.length() + paragraph.length() > chunkSize) {
                if (currentChunk.length() > 0) {
                    chunks.add(currentChunk.toString());

                    // Keep overlap from previous chunk
                    if (overlap > 0 && currentChunk.length() > overlap) {
                        currentChunk = new StringBuilder(
                                currentChunk.substring(currentChunk.length() - overlap));
                    } else {
                        currentChunk = new StringBuilder();
                    }
                }
            }

            // Add paragraph to current chunk
            if (currentChunk.length() > 0) {
                currentChunk.append("\n\n");
            }
            currentChunk.append(paragraph);
        }

        // Add final chunk if not empty
        if (currentChunk.length() > 0) {
            chunks.add(currentChunk.toString());
        }

        return chunks;
    }
}