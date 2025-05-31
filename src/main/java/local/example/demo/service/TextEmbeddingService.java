package local.example.demo.service;

import local.example.demo.config.PerformanceConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@Service
@ConditionalOnProperty(name = "app.performance.text-embedding-enabled", havingValue = "true", matchIfMissing = true)
public class TextEmbeddingService {

    @Value("${gemini.api.key}")
    private String apiKey;

    private final String API_URL = "https://generativelanguage.googleapis.com/v1/models/embedding-001:embedContent?key=";

    private final RestTemplate restTemplate = new RestTemplate();
    
    @Autowired
    private PerformanceConfig performanceConfig;

    /**
     * Generate embedding vector for a text input
     * 
     * @param text The input text to generate embedding for
     * @return A float array representing the embedding vector, or null if failed
     */
    public float[] generateEmbedding(String text) {
        // Check if embedding service is enabled
        if (!performanceConfig.isTextEmbeddingEnabled()) {
            System.out.println("Text embedding service is disabled. Returning null embedding.");
            return null;
        }
        
        try {
            // Log message
            System.out.println(
                    "Generating embedding for text: " + (text.length() > 50 ? text.substring(0, 50) + "..." : text));

            if (apiKey == null || apiKey.isEmpty()) {
                System.err.println("API key is missing. Check application.properties.");
                return null;
            }

            // Build request headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Build request body according to Gemini API format
            Map<String, Object> requestBody = new HashMap<>();
            Map<String, Object> content = new HashMap<>();
            Map<String, Object> part = new HashMap<>();

            part.put("text", text);
            content.put("parts", List.of(part));
            requestBody.put("content", content);

            // Create HTTP request
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // Make API call
            ResponseEntity<Map> response = restTemplate.postForEntity(
                    API_URL + apiKey,
                    request,
                    Map.class);

            // Parse response
            if (response.getBody() != null) {
                Map<String, Object> responseBody = response.getBody();

                // Check for error in response
                if (responseBody.containsKey("error")) {
                    Map<String, Object> error = (Map<String, Object>) responseBody.get("error");
                    String errorMessage = (String) error.get("message");
                    System.err.println("API Error: " + errorMessage);
                    return null;
                }

                // Extract embedding
                Map<String, Object> embedding = (Map<String, Object>) responseBody.get("embedding");
                if (embedding != null) {
                    List<Double> values = (List<Double>) embedding.get("values");
                    if (values != null && !values.isEmpty()) {
                        // Convert List<Double> to float[]
                        float[] embeddingArray = new float[values.size()];
                        for (int i = 0; i < values.size(); i++) {
                            embeddingArray[i] = values.get(i).floatValue();
                        }
                        return embeddingArray;
                    }
                }
            }

            System.err.println("Failed to extract embedding from response");
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Exception when generating embedding: " + e.getMessage());
            return null;
        }
    }
}