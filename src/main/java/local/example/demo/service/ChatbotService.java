package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ChatbotService {

    @Value("${gemini.api.key}")
    private String apiKey;

    private final String API_URL = "https://generativelanguage.googleapis.com/v1/models/gemini-2.0-flash:generateContent?key=";

    private final RestTemplate restTemplate = new RestTemplate();

    @Autowired
    private TextEmbeddingService embeddingService;

    @Autowired
    private FAISSVectorStore vectorStore;

    /**
     * Get response using RAG (Retrieval-Augmented Generation) approach with sources
     * information
     * 
     * @param userMessage The user's message
     * @return Map containing the response and RAG information
     */
    public Map<String, Object> getResponseWithSources(String userMessage) {
        Map<String, Object> result = new HashMap<>();

        try {
            // Log message
            System.out.println("ChatbotService processing: " + userMessage);

            if (apiKey == null || apiKey.isEmpty()) {
                System.err.println("API key is missing. Check application.properties.");
                result.put("response", "Error: API key is missing. Please configure the application properly.");
                result.put("usedRag", false);
                return result;
            }

            // Step 1: Generate embedding for the user query
            float[] queryEmbedding = embeddingService.generateEmbedding(userMessage);
            if (queryEmbedding == null) {
                System.err.println("Failed to generate embedding for query, falling back to direct response");
                result.put("response", getDirectResponse(userMessage));
                result.put("usedRag", false);
                return result;
            }

            // Step 2: Search for relevant documents
            List<Map<String, Object>> relevantDocs = vectorStore.similaritySearch(queryEmbedding, 5);
            System.out.println("Found " + relevantDocs.size() + " relevant documents");

            String contextText = "";
            if (!relevantDocs.isEmpty()) {
                // Format relevant documents as context for the LLM
                contextText = formatRelevantDocuments(relevantDocs);
                System.out.println("Context for RAG: " +
                        (contextText.length() > 100 ? contextText.substring(0, 100) + "..." : contextText));

                // Add the relevant docs to the result
                result.put("sources", processRelevantDocuments(relevantDocs));
                result.put("usedRag", true);
            } else {
                result.put("usedRag", false);
            }

            // Step 3: Generate response with RAG context
            result.put("response", getAugmentedResponse(userMessage, contextText, relevantDocs.isEmpty()));
            return result;

        } catch (Exception e) {
            e.printStackTrace();
            result.put("response",
                    "Sorry, an error occurred while communicating with the AI service: " + e.getMessage());
            result.put("usedRag", false);
            return result;
        }
    }

    /**
     * Process relevant documents to extract structured information
     * 
     * @param relevantDocs List of documents from vector search
     * @return List of structured document information
     */
    private List<Map<String, Object>> processRelevantDocuments(List<Map<String, Object>> relevantDocs) {
        List<Map<String, Object>> processedDocs = new ArrayList<>();

        for (Map<String, Object> doc : relevantDocs) {
            Map<String, Object> processedDoc = new HashMap<>();

            // Extract text
            String text = (String) doc.get("text");
            if (text != null) {
                processedDoc.put("text", text);
            }

            // Extract type if available
            if (doc.containsKey("type")) {
                processedDoc.put("type", doc.get("type"));
            } else {
                processedDoc.put("type", "Knowledge Base");
            }

            // Extract title if available
            if (doc.containsKey("title")) {
                processedDoc.put("title", doc.get("title"));
            } else if (doc.containsKey("id")) {
                processedDoc.put("title", "Document " + doc.get("id"));
            } else {
                processedDoc.put("title", "Unknown Document");
            }

            // Extract score if available
            if (doc.containsKey("score")) {
                processedDoc.put("score", doc.get("score"));
            }

            // Extract metadata if available
            if (doc.containsKey("metadata")) {
                Map<String, Object> metadata = (Map<String, Object>) doc.get("metadata");
                processedDoc.put("metadata", metadata);

                // Thêm các trường metadata quan trọng vào cấp cao nhất để dễ hiển thị
                if (metadata != null) {
                    String[] keyFields = { "category", "brand", "style", "color", "price", "season" };
                    for (String field : keyFields) {
                        if (metadata.containsKey(field)) {
                            processedDoc.put(field, metadata.get(field));
                        }
                    }
                }
            }

            // Add to processed docs
            processedDocs.add(processedDoc);
        }

        return processedDocs;
    }

    /**
     * Get response using RAG (Retrieval-Augmented Generation) approach
     */
    public String getResponse(String userMessage) {
        try {
            // Log message
            System.out.println("ChatbotService processing: " + userMessage);

            if (apiKey == null || apiKey.isEmpty()) {
                System.err.println("API key is missing. Check application.properties.");
                return "Error: API key is missing. Please configure the application properly.";
            }

            // Step 1: Generate embedding for the user query
            float[] queryEmbedding = embeddingService.generateEmbedding(userMessage);
            if (queryEmbedding == null) {
                System.err.println("Failed to generate embedding for query, falling back to direct response");
                return getDirectResponse(userMessage);
            }

            // Step 2: Search for relevant documents
            List<Map<String, Object>> relevantDocs = vectorStore.similaritySearch(queryEmbedding, 5);
            System.out.println("Found " + relevantDocs.size() + " relevant documents");

            String contextText = "";
            if (!relevantDocs.isEmpty()) {
                // Format relevant documents as context for the LLM
                contextText = formatRelevantDocuments(relevantDocs);
                System.out.println("Context for RAG: " +
                        (contextText.length() > 100 ? contextText.substring(0, 100) + "..." : contextText));
            }

            // Step 3: Generate response with RAG context
            return getAugmentedResponse(userMessage, contextText, relevantDocs.isEmpty());

        } catch (Exception e) {
            e.printStackTrace();
            return "Sorry, an error occurred while communicating with the AI service: " + e.getMessage();
        }
    }

    /**
     * Format relevant documents as context for RAG
     */
    private String formatRelevantDocuments(List<Map<String, Object>> relevantDocs) {
        StringBuilder contextBuilder = new StringBuilder();
        contextBuilder.append("=== RELEVANT KNOWLEDGE ===\n\n");

        for (int i = 0; i < relevantDocs.size(); i++) {
            Map<String, Object> doc = relevantDocs.get(i);
            String text = (String) doc.get("text");

            if (text != null && !text.isEmpty()) {
                contextBuilder.append("Document ").append(i + 1).append(":\n");

                // Thêm metadata vào context nếu có
                Map<String, Object> metadata = doc.containsKey("metadata") ? (Map<String, Object>) doc.get("metadata")
                        : null;

                if (metadata != null && !metadata.isEmpty()) {
                    contextBuilder.append("Metadata: ");
                    metadata.forEach((key, value) -> {
                        if (value != null) {
                            contextBuilder.append(key).append(": ").append(value).append("; ");
                        }
                    });
                    contextBuilder.append("\n");
                }

                // Thêm title nếu có
                if (doc.containsKey("title")) {
                    contextBuilder.append("Title: ").append(doc.get("title")).append("\n");
                }

                // Thêm type nếu có
                if (doc.containsKey("type")) {
                    contextBuilder.append("Type: ").append(doc.get("type")).append("\n");
                }

                contextBuilder.append("Content: ").append(text).append("\n\n");
            }
        }

        return contextBuilder.toString();
    }

    /**
     * Get direct response from LLM without RAG context
     */
    private String getDirectResponse(String userMessage) {
        try {
            // Build request headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Build request body according to Gemini API format
            Map<String, Object> requestBody = new HashMap<>();

            // Create the content part with user's message
            Map<String, Object> part = new HashMap<>();
            part.put("text", userMessage);

            Map<String, Object> content = new HashMap<>();
            content.put("parts", List.of(part));
            content.put("role", "user");

            // Add to contents array
            requestBody.put("contents", List.of(content));

            // Configure generation parameters
            Map<String, Object> generationConfig = new HashMap<>();
            generationConfig.put("temperature", 0.7);
            generationConfig.put("maxOutputTokens", 800);
            generationConfig.put("topP", 0.95);
            requestBody.put("generationConfig", generationConfig);

            // Create HTTP request
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // Make API call
            ResponseEntity<Map> response = restTemplate.postForEntity(
                    API_URL + apiKey,
                    request,
                    Map.class);

            return extractResponseText(response);
        } catch (Exception e) {
            e.printStackTrace();
            return "Sorry, an error occurred: " + e.getMessage();
        }
    }

    /**
     * Get RAG-augmented response from LLM
     */
    private String getAugmentedResponse(String userMessage, String contextText, boolean fallbackToDirectResponse) {
        try {
            // Build request headers
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // Build request body
            Map<String, Object> requestBody = new HashMap<>();
            List<Map<String, Object>> contents = new ArrayList<>();

            // System prompt with instructions for RAG
            if (!contextText.isEmpty() && !fallbackToDirectResponse) {
                Map<String, Object> systemContent = new HashMap<>();
                systemContent.put("role", "model");

                // Create system prompt parts
                Map<String, Object> systemPart = new HashMap<>();
                String systemPrompt = "You are a helpful fashion retail assistant that answers questions about " +
                        "products, fashion trends, and shopping advice. You have access to relevant knowledge " +
                        "that helps you answer accurately. Pay special attention to metadata in the knowledge " +
                        "which contains structured information about products like categories, colors, styles, brands, "
                        +
                        "prices, and other attributes. When a user asks about specific products or fashion advice, " +
                        "use this metadata to provide precise and relevant responses. Base your response primarily " +
                        "on the provided knowledge and don't hallucinate details. If the user asks something outside " +
                        "your knowledge, politely indicate the limits of what you know.";
                systemPart.put("text", systemPrompt);

                systemContent.put("parts", List.of(systemPart));
                contents.add(systemContent);
            }

            // Add context if available
            if (!contextText.isEmpty() && !fallbackToDirectResponse) {
                Map<String, Object> contextContent = new HashMap<>();
                contextContent.put("role", "user");

                // Create context part
                Map<String, Object> contextPart = new HashMap<>();
                contextPart.put("text",
                        "Here is relevant knowledge to help answer the upcoming question. Pay careful attention to " +
                                "any metadata in the documents as it contains structured information about products:\n\n"
                                +
                                contextText);

                contextContent.put("parts", List.of(contextPart));
                contents.add(contextContent);

                // Add acknowledgment from model
                Map<String, Object> ackContent = new HashMap<>();
                ackContent.put("role", "model");

                Map<String, Object> ackPart = new HashMap<>();
                ackPart.put("text",
                        "Thank you for providing this knowledge with metadata. I'll use it to help answer the user's question accurately.");

                ackContent.put("parts", List.of(ackPart));
                contents.add(ackContent);
            }

            // Add user query
            Map<String, Object> userContent = new HashMap<>();
            userContent.put("role", "user");

            Map<String, Object> userPart = new HashMap<>();
            userPart.put("text", userMessage);

            userContent.put("parts", List.of(userPart));
            contents.add(userContent);

            // Add contents to request body
            requestBody.put("contents", contents);

            // Configure generation parameters
            Map<String, Object> generationConfig = new HashMap<>();
            generationConfig.put("temperature", 0.7);
            generationConfig.put("maxOutputTokens", 800);
            generationConfig.put("topP", 0.95);
            requestBody.put("generationConfig", generationConfig);

            // Create HTTP request
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);

            // Make API call
            ResponseEntity<Map> response = restTemplate.postForEntity(
                    API_URL + apiKey,
                    request,
                    Map.class);

            return extractResponseText(response);
        } catch (Exception e) {
            e.printStackTrace();
            return "Sorry, an error occurred: " + e.getMessage();
        }
    }

    /**
     * Extract text response from API response
     */
    private String extractResponseText(ResponseEntity<Map> response) {
        if (response.getBody() != null) {
            Map<String, Object> responseBody = response.getBody();
            System.out.println("API response received: " + responseBody);

            // Check for error in response
            if (responseBody.containsKey("error")) {
                Map<String, Object> error = (Map<String, Object>) responseBody.get("error");
                String errorMessage = (String) error.get("message");
                System.err.println("API Error: " + errorMessage);
                return "Sorry, there was an error with the AI service: " + errorMessage;
            }

            List<Map<String, Object>> candidates = (List<Map<String, Object>>) responseBody.get("candidates");

            if (candidates != null && !candidates.isEmpty()) {
                Map<String, Object> candidate = candidates.get(0);
                Map<String, Object> content = (Map<String, Object>) candidate.get("content");
                List<Map<String, Object>> parts = (List<Map<String, Object>>) content.get("parts");

                if (parts != null && !parts.isEmpty()) {
                    String responseText = (String) parts.get(0).get("text");
                    System.out.println("Gemini response: " + responseText);
                    return responseText;
                }
            }
        }

        return "Sorry, I couldn't process your request. The response format was unexpected.";
    }
}
