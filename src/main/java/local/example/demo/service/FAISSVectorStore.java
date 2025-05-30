package local.example.demo.service;

import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.FloatBuffer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class FAISSVectorStore {

    // Path to store index and metadata on disk
    private static final String INDEX_PATH = "faiss_indexes/";
    private static final String METADATA_PATH = "faiss_indexes/metadata/";
    
    // Flag to enable/disable saving metadata to disk
    private boolean saveMetadataToDisk = false;

    // JSON mapper for serialization
    private final ObjectMapper objectMapper = new ObjectMapper();

    // In-memory vector store for now (we'll simulate the vector search)
    private Map<String, float[]> vectors = new ConcurrentHashMap<>();

    // Metadata storage for documents
    private Map<String, Map<String, Object>> documentMetadata = new ConcurrentHashMap<>();

    public FAISSVectorStore() {
        try {
            // Create directories if they don't exist
            Files.createDirectories(Paths.get(INDEX_PATH));
            Files.createDirectories(Paths.get(METADATA_PATH));

            // Load any existing metadata
            loadMetadata();

            System.out.println("FAISSVectorStore initialized with " + documentMetadata.size() + " documents");
        } catch (IOException e) {
            System.err.println("Error initializing FAISSVectorStore: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void loadMetadata() {
        try {
            // Load metadata from disk
            File metadataDir = new File(METADATA_PATH);
            if (metadataDir.exists()) {
                File[] files = metadataDir.listFiles((dir, name) -> name.endsWith(".json"));
                if (files != null) {
                    for (File file : files) {
                        try {
                            String docId = file.getName().replace(".json", "");
                            // Use Jackson to parse JSON
                            Map<String, Object> metadata = objectMapper.readValue(file, Map.class);
                            documentMetadata.put(docId, metadata);
                        } catch (Exception e) {
                            System.err.println("Error loading metadata file " + file.getName() + ": " + e.getMessage());
                        }
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error loading metadata: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Add a document to the vector store
     * 
     * @param text      The text content
     * @param embedding The embedding vector
     * @param metadata  Additional metadata about the document
     * @return The ID of the added document
     */
    public String addDocument(String text, float[] embedding, Map<String, Object> metadata) {
        try {
            // Generate a unique ID for the document
            String docId = UUID.randomUUID().toString();

            // Store vector
            vectors.put(docId, embedding);

            // Store metadata
            Map<String, Object> docMetadata = new HashMap<>(metadata);
            docMetadata.put("text", text);
            documentMetadata.put(docId, docMetadata);

            // Save metadata to disk if enabled
            saveMetadata(docId, docMetadata);

            return docId;
        } catch (Exception e) {
            System.err.println("Error adding document to vector store: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Search for similar documents
     * 
     * @param embedding The query embedding
     * @param k         Number of results to return
     * @return List of documents with similarity scores
     */
    public List<Map<String, Object>> similaritySearch(float[] embedding, int k) {
        try {
            // Simple vector search implementation
            List<DocSimilarity> similarities = new ArrayList<>();

            // Calculate similarity for each vector
            for (Map.Entry<String, float[]> entry : vectors.entrySet()) {
                String docId = entry.getKey();
                float[] vector = entry.getValue();

                // Calculate cosine similarity
                float similarity = cosineSimilarity(embedding, vector);
                similarities.add(new DocSimilarity(docId, similarity));
            }

            // Sort by similarity (descending)
            similarities.sort((a, b) -> Float.compare(b.similarity, a.similarity));

            // Take top k results
            List<Map<String, Object>> results = new ArrayList<>();
            for (int i = 0; i < Math.min(k, similarities.size()); i++) {
                DocSimilarity docSim = similarities.get(i);
                String docId = docSim.docId;

                if (documentMetadata.containsKey(docId)) {
                    Map<String, Object> result = new HashMap<>(documentMetadata.get(docId));
                    result.put("score", docSim.similarity);
                    result.put("id", docId);
                    results.add(result);
                }
            }

            return results;
        } catch (Exception e) {
            System.err.println("Error in similarity search: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * Calculate cosine similarity between two vectors
     */
    private float cosineSimilarity(float[] vec1, float[] vec2) {
        float dotProduct = 0.0f;
        float norm1 = 0.0f;
        float norm2 = 0.0f;

        for (int i = 0; i < vec1.length; i++) {
            dotProduct += vec1[i] * vec2[i];
            norm1 += vec1[i] * vec1[i];
            norm2 += vec2[i] * vec2[i];
        }

        if (norm1 <= 0.0 || norm2 <= 0.0) {
            return 0.0f;
        } else {
            return dotProduct / (float) (Math.sqrt(norm1) * Math.sqrt(norm2));
        }
    }

    private void saveMetadata(String docId, Map<String, Object> metadata) {
        // Skip saving metadata to disk if disabled
        if (!saveMetadataToDisk) {
            return;
        }
        
        try {
            // Use Jackson to serialize to JSON
            objectMapper.writeValue(new File(METADATA_PATH + docId + ".json"), metadata);
        } catch (Exception e) {
            System.err.println("Error saving metadata: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Enable or disable saving metadata to disk
     * @param enable True to enable, false to disable
     */
    public void setSaveMetadataToDisk(boolean enable) {
        this.saveMetadataToDisk = enable;
    }

    /**
     * Check if saving metadata to disk is enabled
     * @return True if enabled, false if disabled
     */
    public boolean isSaveMetadataToDisk() {
        return saveMetadataToDisk;
    }

    /**
     * Helper class for document similarity results
     */
    private static class DocSimilarity {
        public String docId;
        public float similarity;

        public DocSimilarity(String docId, float similarity) {
            this.docId = docId;
            this.similarity = similarity;
        }
    }

    /**
     * Save the metadata when the service is shutting down
     */
    public void shutdown() {
        try {
            System.out.println("Shutting down FAISSVectorStore...");
            // Metadata is already saved document-by-document, no need to do anything here
        } catch (Exception e) {
            System.err.println("Error during FAISSVectorStore shutdown: " + e.getMessage());
            e.printStackTrace();
        }
    }
}