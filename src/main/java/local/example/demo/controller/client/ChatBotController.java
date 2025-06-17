package local.example.demo.controller.client;

import local.example.demo.config.PerformanceConfig;
import local.example.demo.service.ChatbotService;
import local.example.demo.service.ProductLoadRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class ChatBotController {

    @Autowired
    private ChatbotService chatbotService;

    @Autowired
    private ProductLoadRandom productLoadRandom;
    
    @Autowired
    private PerformanceConfig performanceConfig;

    // Category-specific keywords for better filtering
    private final Map<String, List<String>> categoryKeywords = new HashMap<String, List<String>>() {
        {
            put("pants", List.of("quần", "quần jeans", "quần dài", "quần short", "quần đùi", "pants", "trousers",
                    "jeans", "shorts"));
            put("shirts", List.of("áo", "áo sơ mi", "áo thun", "áo khoác", "áo len", "shirt", "t-shirt", "hoodie",
                    "jacket", "sweater"));
            put("shoes", List.of("giày", "giày dép", "dép", "shoes", "sneakers", "footwear", "sandals"));
            put("accessories", List.of("phụ kiện", "mũ", "túi", "ví", "thắt lưng", "kính", "accessories", "hat", "cap",
                    "bag", "wallet", "belt", "glasses"));
        }
    };

    @GetMapping("/chatbot")
    public String chatboxPage() {
        return "client/layout/chatbox";
    }

    @GetMapping("/chatbot/demo")
    public String chatbotDemo() {
        return "client/chatbot-demo";
    }

    @GetMapping("/chatbot/test")
    public String chatbotTest() {
        return "client/chatbot-test";
    }

    @PostMapping("/chatbot/send")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> sendMessage(@RequestParam("message") String message) {
        try {
            // Log để debug
            System.out.println("Nhận được request với message: " + message);

            // Format thời gian hiện tại để hiển thị
            String currentTime = new SimpleDateFormat("HH:mm").format(new Date());

            // Check if RAG features are enabled
            Map<String, Object> ragResult;
            String botResponse;
            boolean usedRag = false;
            List<Map<String, Object>> sources = new ArrayList<>();
            
            if (performanceConfig.isChatbotRagEnabled()) {
                // Use RAG for response if enabled
                ragResult = chatbotService.getResponseWithSources(message);
                botResponse = (String) ragResult.get("response");
                usedRag = (boolean) ragResult.getOrDefault("usedRag", false);
                sources = (List<Map<String, Object>>) ragResult.getOrDefault("sources", new ArrayList<>());
            } else {
                // Use a simple response if RAG is disabled
                botResponse = getSimpleResponse(message);
                ragResult = new HashMap<>();
                ragResult.put("response", botResponse);
            }

            // Trích xuất metadata từ sources để cải thiện phân tích ngữ cảnh
            Map<String, Object> extractedMetadata = extractMetadataFromSources(sources);

            // Phân loại chính xác ý định của truy vấn với context từ RAG
            QueryIntent queryIntent = analyzeQueryIntent(message, botResponse);

            // Tinh chỉnh phân loại dựa trên metadata nếu có
            if (!extractedMetadata.isEmpty()) {
                queryIntent = refineQueryIntentWithMetadata(queryIntent, extractedMetadata, message);
            }

            // Trường hợp là truy vấn TƯ VẤN về sản phẩm (không phải tìm kiếm sản phẩm)
            if (queryIntent == QueryIntent.PRODUCT_ADVICE) {
                // Trả về phản hồi từ RAG mà không hiển thị sản phẩm
                Map<String, Object> response = new HashMap<>();
                response.put("message", botResponse);
                response.put("time", currentTime);
                response.put("usedRag", usedRag);

                // Add formatted sources if RAG was used
                if (usedRag && sources != null && !sources.isEmpty()) {
                    response.put("sources", formatSources(sources));
                }

                // Thêm metadata đã trích xuất vào phản hồi để frontend có thể sử dụng
                if (!extractedMetadata.isEmpty()) {
                    response.put("extractedMetadata", extractedMetadata);
                }

                return ResponseEntity.ok(response);
            }
            // Trường hợp là truy vấn TÌM KIẾM sản phẩm cụ thể
            else if (queryIntent == QueryIntent.PRODUCT_SEARCH) {
                // Extract search term from the message
                String searchTerm = extractSearchTerm(message);
                System.out.println("Extracted search term: " + searchTerm);

                // Determine the product category if possible
                String category = determineProductCategory(message);

                // Sử dụng category từ metadata nếu không xác định được
                if (category == null && extractedMetadata.containsKey("category")) {
                    category = (String) extractedMetadata.get("category");
                }

                System.out.println("Determined category: " + (category != null ? category : "none"));

                // Get product results
                Map<String, Object> productResults = productLoadRandom.searchProductsByName(searchTerm, 1, 8, 20);
                List<Map<String, Object>> rawProducts = productLoadRandom.getProductResults(productResults);
                int totalRecords = productLoadRandom.getTotalRecords(productResults);

                System.out.println("Found " + (rawProducts != null ? rawProducts.size() : 0) + " products out of "
                        + totalRecords + " total");

                // Process and filter products based on category
                List<Map<String, Object>> processedProducts = processAndFilterProductData(rawProducts, category);

                // Áp dụng bộ lọc thêm từ metadata nếu có
                if (!extractedMetadata.isEmpty()) {
                    processedProducts = applyMetadataFilters(processedProducts, extractedMetadata);
                }

                int filteredCount = processedProducts.size();

                // Tạo response object
                Map<String, Object> response = new HashMap<>();

                // Thêm thông tin RAG vào kết quả truy vấn sản phẩm
                response.put("usedRag", usedRag);
                if (usedRag && sources != null && !sources.isEmpty()) {
                    response.put("sources", formatSources(sources));
                }

                // Thêm metadata đã trích xuất vào phản hồi
                if (!extractedMetadata.isEmpty()) {
                    response.put("extractedMetadata", extractedMetadata);
                }

                // Add user-friendly message
                if (processedProducts != null && !processedProducts.isEmpty()) {
                    // Sử dụng phản hồi RAG nếu có thể
                    if (usedRag && !botResponse.isEmpty()) {
                        response.put("message", botResponse);
                    } else {
                        // Sử dụng phản hồi có định dạng cũ nếu không có RAG
                        if (category != null) {
                            response.put("message",
                                    "Here are some " + getCategoryDisplayName(category) + " products that match \""
                                            + searchTerm + "\". I found " + filteredCount + " products for you:");
                        } else {
                            response.put("message", "Here are some products that match \"" + searchTerm + "\". I found "
                                    + totalRecords + " products in total:");
                        }
                    }
                } else {
                    if (usedRag && !botResponse.isEmpty()) {
                        response.put("message", botResponse);
                    } else {
                        if (category != null) {
                            response.put("message",
                                    "I couldn't find any " + getCategoryDisplayName(category) + " products matching \""
                                            + searchTerm + "\". Try a different search term or browse our categories.");
                        } else {
                            response.put("message", "I couldn't find any products matching \"" + searchTerm
                                    + "\". Try a different search term or browse our categories.");
                        }
                    }
                }

                response.put("products", processedProducts);
                response.put("time", currentTime);
                response.put("totalRecords", filteredCount);

                return ResponseEntity.ok(response);
            }
            // Trường hợp là các truy vấn thông thường khác
            else {
                // Tạo response object cho truy vấn không phải sản phẩm
                Map<String, Object> response = new HashMap<>();
                response.put("message", botResponse);
                response.put("time", currentTime);
                response.put("usedRag", usedRag);

                // Add formatted sources if RAG was used
                if (usedRag && sources != null && !sources.isEmpty()) {
                    response.put("sources", formatSources(sources));
                }

                // Thêm metadata đã trích xuất vào phản hồi
                if (!extractedMetadata.isEmpty()) {
                    response.put("extractedMetadata", extractedMetadata);
                }

                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            // Log lỗi
            e.printStackTrace();

            // Trả về thông báo lỗi
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("message", "Xảy ra lỗi: " + e.getMessage());
            errorResponse.put("time", new SimpleDateFormat("HH:mm").format(new Date()));
            errorResponse.put("usedRag", false);

            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * Provide a simple response when RAG is disabled
     */
    private String getSimpleResponse(String message) {
        String lowerMessage = message.toLowerCase();
        
        // Simple keyword-based responses
        if (lowerMessage.contains("xin chào") || lowerMessage.contains("hello") || lowerMessage.contains("hi")) {
            return "Xin chào! Tôi là trợ lý ảo của cửa hàng. Tôi có thể giúp gì cho bạn? (RAG hiện đang tắt)";
        }
        
        if (lowerMessage.contains("sản phẩm") || lowerMessage.contains("quần") || 
            lowerMessage.contains("áo") || lowerMessage.contains("giày")) {
            return "Tôi có thể giúp bạn tìm kiếm các sản phẩm. Vui lòng cho tôi biết bạn đang tìm kiếm loại sản phẩm nào? (RAG hiện đang tắt)";
        }
        
        if (lowerMessage.contains("giá") || lowerMessage.contains("bao nhiêu")) {
            return "Giá sản phẩm phụ thuộc vào loại sản phẩm cụ thể. Vui lòng cho tôi biết bạn quan tâm đến sản phẩm nào? (RAG hiện đang tắt)";
        }
        
        if (lowerMessage.contains("khuyến mãi") || lowerMessage.contains("giảm giá") || lowerMessage.contains("sale")) {
            return "Hiện tại cửa hàng có một số chương trình khuyến mãi đang diễn ra. Bạn có thể xem chi tiết trong mục 'Khuyến mãi' trên trang web. (RAG hiện đang tắt)";
        }
        
        if (lowerMessage.contains("cảm ơn") || lowerMessage.contains("thank")) {
            return "Không có gì! Rất vui được giúp đỡ bạn. (RAG hiện đang tắt)";
        }
        
        // Default response
        return "Tôi hiểu bạn đang hỏi về '" + message + "'. Hiện tại tính năng RAG đang bị tắt để tối ưu hiệu suất. Bạn có thể tìm kiếm sản phẩm hoặc hỏi về các dịch vụ cơ bản của cửa hàng.";
    }

    /**
     * Format source documents for display in the frontend
     */
    private List<Map<String, Object>> formatSources(List<Map<String, Object>> rawSources) {
        List<Map<String, Object>> formattedSources = new ArrayList<>();

        for (Map<String, Object> source : rawSources) {
            Map<String, Object> formatted = new HashMap<>();

            // Extract text content
            String text = (String) source.get("text");
            if (text != null) {
                // Truncate if too long
                if (text.length() > 300) {
                    text = text.substring(0, 300) + "...";
                }
                formatted.put("text", text);
            } else {
                formatted.put("text", "No text available");
            }

            // Extract document type
            String type = (String) source.get("type");
            formatted.put("type", type != null ? type : "Document");

            // Extract title
            String title = (String) source.get("title");
            formatted.put("title", title != null ? title : "Untitled Source");

            // Add metadata if available
            if (source.containsKey("metadata")) {
                formatted.put("metadata", source.get("metadata"));
            }

            formattedSources.add(formatted);
        }

        return formattedSources;
    }

    /**
     * Get a user-friendly display name for a category
     */
    private String getCategoryDisplayName(String category) {
        switch (category) {
            case "pants":
                return "pants";
            case "shirts":
                return "shirts";
            case "shoes":
                return "shoes";
            case "accessories":
                return "accessories";
            default:
                return "products";
        }
    }

    /**
     * Determine the product category based on the user's query
     */
    private String determineProductCategory(String message) {
        String lowercaseMessage = message.toLowerCase();

        // Check each category's keywords
        for (Map.Entry<String, List<String>> entry : categoryKeywords.entrySet()) {
            for (String keyword : entry.getValue()) {
                if (lowercaseMessage.contains(keyword)) {
                    return entry.getKey();
                }
            }
        }

        return null; // No specific category determined
    }

    /**
     * Process raw product data and filter by category if specified
     */
    private List<Map<String, Object>> processAndFilterProductData(List<Map<String, Object>> rawProducts,
            String category) {
        if (rawProducts == null || rawProducts.isEmpty()) {
            return new ArrayList<>();
        }

        List<Map<String, Object>> processedProducts = new ArrayList<>();

        for (Map<String, Object> product : rawProducts) {
            // Create a new map for each product with consistent keys
            Map<String, Object> processedProduct = new HashMap<>();

            // Look for product ID in various possible formats
            Integer productId = null;
            if (product.containsKey("ProductID")) {
                productId = (Integer) product.get("ProductID");
            } else if (product.containsKey("productId")) {
                productId = (Integer) product.get("productId");
            } else if (product.containsKey("product_id")) {
                productId = (Integer) product.get("product_id");
            }

            // Only include products with valid IDs
            if (productId != null) {
                processedProduct.put("productId", productId);

                // Process product name
                String productName = "Product";
                if (product.containsKey("ProductName")) {
                    productName = (String) product.get("ProductName");
                } else if (product.containsKey("productName")) {
                    productName = (String) product.get("productName");
                } else if (product.containsKey("product_name")) {
                    productName = (String) product.get("product_name");
                }
                processedProduct.put("productName", productName);

                // Process price
                Object price = "0.00";
                if (product.containsKey("Price")) {
                    price = product.get("Price");
                } else if (product.containsKey("price")) {
                    price = product.get("price");
                }
                processedProduct.put("price", price);

                // Process image URL
                String imageUrl = "https://via.placeholder.com/150";
                if (product.containsKey("ImageURL")) {
                    imageUrl = (String) product.get("ImageURL");
                } else if (product.containsKey("imageUrl")) {
                    imageUrl = (String) product.get("imageUrl");
                } else if (product.containsKey("image_url")) {
                    imageUrl = (String) product.get("image_url");
                }
                processedProduct.put("imageUrl", imageUrl);

                // Category filtering: only add the product if it matches the requested category
                // or if no category filter
                if (category == null || doesProductMatchCategory(productName, category)) {
                    processedProducts.add(processedProduct);
                    System.out.println("Added product: " + productName + " to results");
                } else {
                    System.out
                            .println("Filtered out product: " + productName + " - doesn't match category: " + category);
                }
            } else {
                System.out.println("Skipping product without ID: " + product);
            }
        }

        return processedProducts;
    }

    /**
     * Check if a product name matches the specified category
     */
    private boolean doesProductMatchCategory(String productName, String category) {
        if (productName == null || category == null) {
            return false;
        }

        String lowercaseName = productName.toLowerCase();

        // Check if the product name contains any keywords for this category
        List<String> keywords = categoryKeywords.get(category);
        if (keywords != null) {
            for (String keyword : keywords) {
                if (lowercaseName.contains(keyword)) {
                    return true;
                }
            }
        }

        // Additional logic for common product naming patterns
        switch (category) {
            case "pants":
                return lowercaseName.contains("quần") ||
                        lowercaseName.contains("pant") ||
                        lowercaseName.contains("jean") ||
                        lowercaseName.contains("trouser") ||
                        lowercaseName.contains("short");
            case "shirts":
                return lowercaseName.contains("áo") ||
                        lowercaseName.contains("shirt") ||
                        lowercaseName.contains("hoodie") ||
                        lowercaseName.contains("sweater") ||
                        lowercaseName.contains("jacket");
            case "shoes":
                return lowercaseName.contains("giày") ||
                        lowercaseName.contains("dép") ||
                        lowercaseName.contains("shoe") ||
                        lowercaseName.contains("sneaker") ||
                        lowercaseName.contains("sandal");
            case "accessories":
                return lowercaseName.contains("phụ kiện") ||
                        lowercaseName.contains("mũ") ||
                        lowercaseName.contains("túi") ||
                        lowercaseName.contains("ví") ||
                        lowercaseName.contains("thắt lưng") ||
                        lowercaseName.contains("kính") ||
                        lowercaseName.contains("accessory") ||
                        lowercaseName.contains("accessorie") ||
                        lowercaseName.contains("hat") ||
                        lowercaseName.contains("cap") ||
                        lowercaseName.contains("bag") ||
                        lowercaseName.contains("wallet") ||
                        lowercaseName.contains("belt") ||
                        lowercaseName.contains("glass");
            default:
                return false;
        }
    }

    /**
     * Determines if a message is likely a product search query by analyzing message
     * and context.
     * Uses both keyword and intent-based detection.
     */
    private boolean isProductQuery(String message) {
        // Convert message to lowercase for case-insensitive matching
        String lowercaseMessage = message.toLowerCase();

        // Check for product search intent keywords
        String[] productKeywords = {
                "product", "products", "show me", "find", "search", "looking for",
                "where can i find", "do you have", "show", "i want", "i need",
                "i'm looking for", "recommend", "suggest", "áo", "quần", "giày", "phụ kiện",
                "túi", "mũ", "shirt", "shoes", "pants", "jacket", "hoodie", "dress",
                "what products", "display", "list", "available", "buy", "purchase"
        };

        // Tìm kiếm từ khóa sản phẩm trong truy vấn
        for (String keyword : productKeywords) {
            if (lowercaseMessage.contains(keyword)) {
                return true;
            }
        }

        // Kiểm tra xem truy vấn có ý định tìm kiếm sản phẩm không (phân tích ngữ nghĩa)
        boolean hasSearchIntent = lowercaseMessage.contains("tìm") ||
                lowercaseMessage.contains("mua") ||
                lowercaseMessage.contains("kiếm") ||
                (lowercaseMessage.contains("có") && lowercaseMessage.contains("không"));

        boolean mentionsClothing = false;
        // Kiểm tra tất cả các từ khóa danh mục để xem liệu có đề cập đến quần áo không
        for (List<String> categoryKeywordList : categoryKeywords.values()) {
            for (String keyword : categoryKeywordList) {
                if (lowercaseMessage.contains(keyword)) {
                    mentionsClothing = true;
                    break;
                }
            }
            if (mentionsClothing)
                break;
        }

        // Kết hợp ý định tìm kiếm với đề cập đến quần áo
        return hasSearchIntent && mentionsClothing;
    }

    /**
     * Extracts the search term from the message
     */
    private String extractSearchTerm(String message) {
        // Remove common prefixes that indicate product search intent
        String[] prefixes = {
                "show me ", "find ", "search for ", "looking for ", "where can i find ",
                "do you have ", "show ", "i want ", "i need ", "i'm looking for ",
                "recommend ", "suggest ", "what products ", "display ", "list "
        };

        String cleanedMessage = message;
        for (String prefix : prefixes) {
            if (message.toLowerCase().startsWith(prefix)) {
                cleanedMessage = message.substring(prefix.length());
                break;
            }
        }

        // Remove common question endings
        String[] suffixes = {
                "?", "please", "thank you", "thanks"
        };

        for (String suffix : suffixes) {
            if (cleanedMessage.toLowerCase().endsWith(suffix)) {
                cleanedMessage = cleanedMessage.substring(0,
                        cleanedMessage.length() - suffix.length()).trim();
            }
        }

        // If the cleaned message is too short, use the original message
        if (cleanedMessage.length() < 2) {
            // Extract core terms using a simple regex pattern
            Pattern pattern = Pattern.compile("\\b\\w+\\b");
            Matcher matcher = pattern.matcher(message);
            StringBuilder terms = new StringBuilder();

            while (matcher.find()) {
                String term = matcher.group();
                if (term.length() > 2 && !isStopWord(term)) {
                    if (terms.length() > 0) {
                        terms.append(" ");
                    }
                    terms.append(term);
                }
            }

            return terms.toString();
        }

        return cleanedMessage;
    }

    /**
     * Check if a word is a common stop word
     */
    private boolean isStopWord(String word) {
        String[] stopWords = {
                "the", "a", "an", "and", "or", "but", "is", "are", "was", "were",
                "for", "of", "in", "on", "at", "to", "me", "you", "he", "she", "it",
                "we", "they", "this", "that", "these", "those", "my", "your", "his",
                "her", "its", "our", "their", "do", "does", "did", "have", "has", "had",
                "by", "with", "from", "about"
        };

        String lowercaseWord = word.toLowerCase();
        for (String stopWord : stopWords) {
            if (lowercaseWord.equals(stopWord)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Phân loại ý định của truy vấn
     */
    private enum QueryIntent {
        PRODUCT_SEARCH, // Tìm kiếm sản phẩm để mua
        PRODUCT_ADVICE, // Tư vấn về sản phẩm (phong cách, xu hướng, cách chọn)
        GENERAL_QUERY // Các truy vấn thông thường khác
    }

    /**
     * Phân tích ý định của truy vấn dựa trên nội dung tin nhắn và phản hồi RAG
     */
    private QueryIntent analyzeQueryIntent(String message, String ragResponse) {
        String lowerMessage = message.toLowerCase();
        String lowerResponse = ragResponse.toLowerCase();

        // Phát hiện và trích xuất các thuộc tính từ truy vấn
        Map<String, String> extractedAttributes = extractProductAttributes(lowerMessage);

        // Đánh giá chất lượng phản hồi RAG
        boolean ragContainsHighQualityInfo = evaluateRagResponseQuality(lowerResponse);

        // Nhận biết câu hỏi trực tiếp về sản phẩm cụ thể (ưu tiên cao nhất)
        boolean isDirectProductQuestion = (lowerMessage.contains("có") && lowerMessage.contains("không")
                && mentionsClothingCategory(lowerMessage)) ||
                (lowerMessage.contains("bán") && lowerMessage.contains("không")
                        && mentionsClothingCategory(lowerMessage))
                ||
                ((lowerMessage.contains("shop") || lowerMessage.contains("cửa hàng") || lowerMessage.contains("bạn")) &&
                        lowerMessage.contains("có") && mentionsClothingCategory(lowerMessage));

        // Nhận biết các mẫu TƯ VẤN sản phẩm
        boolean isAdviceQuery = lowerMessage.contains("tư vấn") ||
                lowerMessage.contains("gợi ý") ||
                lowerMessage.contains("nên chọn") ||
                lowerMessage.contains("nên mua") ||
                lowerMessage.contains("phù hợp với") ||
                lowerMessage.contains("hợp với") ||
                lowerMessage.contains("xu hướng") ||
                lowerMessage.contains("trend") ||
                lowerMessage.contains("style") ||
                lowerMessage.contains("phong cách") ||
                lowerMessage.contains("fashion") ||
                lowerMessage.contains("outfit") ||
                lowerMessage.contains("kết hợp") ||
                lowerMessage.contains("match") ||
                lowerMessage.contains("coordinate") ||
                lowerMessage.contains("advice") ||
                // Các mẫu câu hỏi tư vấn
                lowerMessage.matches(".*\\b(nên|should)\\b.*\\b(mặc|wear|đi)\\b.*") ||
                lowerMessage.matches(".*\\b(cách|how)\\b.*\\b(chọn|select|pick)\\b.*") ||
                lowerMessage.matches(".*\\b(như thế nào|what)\\b.*\\b(phù hợp|suitable)\\b.*") ||
                // Các câu hỏi về chất lượng, đặc điểm sản phẩm (không phải tìm kiếm)
                ((lowerMessage.contains("chất lượng") || lowerMessage.contains("quality")) && !isDirectProductQuestion)
                ||
                ((lowerMessage.contains("đặc điểm") || lowerMessage.contains("feature")) && !isDirectProductQuestion) ||
                ((lowerMessage.contains("so sánh") || lowerMessage.contains("compare")) && !isDirectProductQuestion) ||
                ((lowerMessage.contains("khác nhau") || lowerMessage.contains("difference"))
                        && !isDirectProductQuestion);

        // Nhận biết các mẫu TÌM KIẾM sản phẩm cụ thể
        boolean isExplicitSearchQuery = isDirectProductQuestion ||
                (lowerMessage.contains("tìm") && !lowerMessage.contains("tư vấn")) ||
                lowerMessage.contains("search") ||
                lowerMessage.contains("find") ||
                lowerMessage.contains("show me") ||
                lowerMessage.contains("hiển thị") ||
                lowerMessage.contains("liệt kê") ||
                lowerMessage.contains("list") ||
                lowerMessage.contains("các sản phẩm") ||
                lowerMessage.contains("sản phẩm nào") ||
                lowerMessage.contains("bán ") ||
                lowerMessage.contains("mua ở đâu") ||
                lowerMessage.contains("order") ||
                // Câu hỏi trực tiếp về mua bán
                lowerMessage.matches(".*\\b(có bán|sell)\\b.*") ||
                lowerMessage.matches(".*\\b(giá|price|cost)\\b.*") ||
                (lowerMessage.contains("có") && lowerMessage.contains("không") &&
                        (lowerMessage.contains("bán") || lowerMessage.contains("sell")));

        // Truy vấn ngầm định là tìm kiếm sản phẩm
        boolean isImplicitSearchQuery = !isAdviceQuery &&
                !lowerMessage.contains("?") &&
                extractedAttributes.size() >= 2 &&
                mentionsClothingCategory(lowerMessage);

        boolean isSearchQuery = isExplicitSearchQuery || isImplicitSearchQuery;

        // Xem xét cả nội dung phản hồi RAG để đưa ra quyết định tốt hơn
        boolean responseContainsAdvice = lowerResponse.contains("nên chọn") ||
                lowerResponse.contains("phù hợp") ||
                lowerResponse.contains("gợi ý") ||
                lowerResponse.contains("xu hướng") ||
                lowerResponse.contains("phong cách") ||
                lowerResponse.contains("kết hợp") ||
                lowerResponse.contains("style") ||
                lowerResponse.contains("thời trang") ||
                lowerResponse.contains("fashion") ||
                lowerResponse.contains("thiết kế") ||
                lowerResponse.contains("outfit");

        // Phát hiện nếu câu trả lời của RAG đã có đề cập đến sản phẩm cụ thể
        boolean responseContainsProducts = lowerResponse.contains("sản phẩm") ||
                lowerResponse.contains("product") ||
                lowerResponse.contains("item") ||
                lowerResponse.contains("collection");

        // Log phân tích
        System.out.println("Query analysis - isAdviceQuery: " + isAdviceQuery +
                ", isSearchQuery: " + isSearchQuery +
                ", isDirectProductQuestion: " + isDirectProductQuestion +
                ", extractedAttributes: " + extractedAttributes +
                ", responseContainsAdvice: " + responseContainsAdvice +
                ", ragContainsHighQualityInfo: " + ragContainsHighQualityInfo);

        // Ưu tiên phân loại theo thứ tự:
        // 0. Nếu là câu hỏi trực tiếp về sản phẩm cụ thể
        if (isDirectProductQuestion) {
            return QueryIntent.PRODUCT_SEARCH;
        }
        // 1. Nếu rõ ràng là truy vấn tư vấn
        else if (isAdviceQuery) {
            return QueryIntent.PRODUCT_ADVICE;
        }
        // 2. Nếu rõ ràng là truy vấn tìm kiếm
        else if (isExplicitSearchQuery && !isAdviceQuery) {
            return QueryIntent.PRODUCT_SEARCH;
        }
        // 3. Nếu RAG trả về thông tin chất lượng cao và không rõ ràng là tìm kiếm, ưu
        // tiên tư vấn
        else if (ragContainsHighQualityInfo && responseContainsAdvice) {
            return QueryIntent.PRODUCT_ADVICE;
        }
        // 4. Dựa vào phản hồi RAG để quyết định
        else if (responseContainsAdvice && !responseContainsProducts) {
            return QueryIntent.PRODUCT_ADVICE;
        }
        // 5. Nếu là truy vấn tìm kiếm ngầm định
        else if (isImplicitSearchQuery) {
            return QueryIntent.PRODUCT_SEARCH;
        }
        // 6. Các truy vấn không rõ ràng khác
        else {
            return QueryIntent.GENERAL_QUERY;
        }
    }

    /**
     * Đánh giá chất lượng phản hồi RAG
     */
    private boolean evaluateRagResponseQuality(String response) {
        if (response == null || response.isEmpty()) {
            return false;
        }

        // Kiểm tra độ dài phản hồi
        boolean hasGoodLength = response.length() > 100;

        // Kiểm tra có chứa từ khóa chuyên ngành thời trang
        boolean containsFashionTerms = response.contains("thời trang") ||
                response.contains("phong cách") ||
                response.contains("xu hướng") ||
                response.contains("fashion") ||
                response.contains("style") ||
                response.contains("trend");

        // Kiểm tra có chứa từ khóa chuyên sâu về sản phẩm
        boolean containsDetailedInfo = response.contains("chất liệu") ||
                response.contains("thiết kế") ||
                response.contains("mẫu mã") ||
                response.contains("kết cấu") ||
                response.contains("material") ||
                response.contains("design") ||
                response.contains("texture");

        // Kiểm tra có chứa cấu trúc đánh giá, đề xuất
        boolean containsRecommendation = response.contains("nên") ||
                response.contains("phù hợp") ||
                response.contains("recommend") ||
                response.contains("suitable");

        // Tính điểm chất lượng
        int qualityScore = 0;
        if (hasGoodLength)
            qualityScore += 1;
        if (containsFashionTerms)
            qualityScore += 2;
        if (containsDetailedInfo)
            qualityScore += 2;
        if (containsRecommendation)
            qualityScore += 1;

        return qualityScore >= 3; // Điểm chất lượng từ 3 trở lên được coi là cao
    }

    /**
     * Trích xuất các thuộc tính sản phẩm từ truy vấn
     */
    private Map<String, String> extractProductAttributes(String query) {
        Map<String, String> attributes = new HashMap<>();
        String lowerQuery = query.toLowerCase();

        // Trích xuất màu sắc
        extractColorAttribute(lowerQuery, attributes);

        // Trích xuất kích thước
        extractSizeAttribute(lowerQuery, attributes);

        // Trích xuất phong cách
        extractStyleAttribute(lowerQuery, attributes);

        // Trích xuất mùa
        extractSeasonAttribute(lowerQuery, attributes);

        // Trích xuất giá
        extractPriceAttribute(lowerQuery, attributes);

        // Trích xuất thương hiệu
        extractBrandAttribute(lowerQuery, attributes);

        // Trích xuất danh mục
        String category = determineProductCategory(query);
        if (category != null) {
            attributes.put("category", category);
        }

        return attributes;
    }

    /**
     * Trích xuất thông tin màu sắc từ truy vấn
     */
    private void extractColorAttribute(String query, Map<String, String> attributes) {
        String[] colors = { "đen", "trắng", "đỏ", "xanh", "vàng", "tím", "hồng", "nâu", "xám", "cam",
                "black", "white", "red", "blue", "yellow", "purple", "pink", "brown", "gray", "orange",
                "xanh dương", "xanh lá", "navy", "beige", "cream" };

        for (String color : colors) {
            if (query.contains(color)) {
                attributes.put("color", color);
                break;
            }
        }
    }

    /**
     * Trích xuất thông tin kích thước từ truy vấn
     */
    private void extractSizeAttribute(String query, Map<String, String> attributes) {
        // Kích thước chuẩn
        String[] standardSizes = { "xs", "s", "m", "l", "xl", "xxl", "size s", "size m", "size l" };
        for (String size : standardSizes) {
            if (query.contains(size)) {
                attributes.put("size", size);
                return;
            }
        }

        // Kích thước số
        Pattern sizePattern = Pattern.compile("\\b(size)? ?\\d{1,2}\\b");
        Matcher matcher = sizePattern.matcher(query);
        if (matcher.find()) {
            attributes.put("size", matcher.group());
        }
    }

    /**
     * Trích xuất thông tin phong cách từ truy vấn
     */
    private void extractStyleAttribute(String query, Map<String, String> attributes) {
        String[] styles = { "casual", "formal", "sport", "business", "vintage", "retro", "streetwear",
                "thể thao", "công sở", "dự tiệc", "đi chơi", "hàng ngày", "lịch sự", "vintage",
                "đường phố", "thời trang", "basic", "cơ bản", "minimalist", "tối giản" };

        for (String style : styles) {
            if (query.contains(style)) {
                attributes.put("style", style);
                break;
            }
        }
    }

    /**
     * Trích xuất thông tin mùa từ truy vấn
     */
    private void extractSeasonAttribute(String query, Map<String, String> attributes) {
        String[] seasons = { "summer", "winter", "spring", "fall", "autumn",
                "mùa hè", "mùa đông", "mùa xuân", "mùa thu" };

        for (String season : seasons) {
            if (query.contains(season)) {
                attributes.put("season", season);
                break;
            }
        }
    }

    /**
     * Trích xuất thông tin giá từ truy vấn
     */
    private void extractPriceAttribute(String query, Map<String, String> attributes) {
        // Mẫu "dưới X đồng/VND/k/nghìn/USD/$"
        Pattern underPattern = Pattern.compile("(dưới|under|less than|<) ?(\\d+)[kK]? ?(đồng|vnd|nghìn|ngàn|\\$|usd)?");
        Matcher underMatcher = underPattern.matcher(query);
        if (underMatcher.find()) {
            String price = underMatcher.group(2);
            attributes.put("price_max", price);
            return;
        }

        // Mẫu "trên X đồng/VND/k/nghìn/USD/$"
        Pattern overPattern = Pattern.compile("(trên|over|more than|>) ?(\\d+)[kK]? ?(đồng|vnd|nghìn|ngàn|\\$|usd)?");
        Matcher overMatcher = overPattern.matcher(query);
        if (overMatcher.find()) {
            String price = overMatcher.group(2);
            attributes.put("price_min", price);
            return;
        }

        // Mẫu "từ X đến Y đồng/VND/k/nghìn/USD/$"
        Pattern rangePattern = Pattern
                .compile("(từ|from) ?(\\d+)[kK]? ?(đến|to) ?(\\d+)[kK]? ?(đồng|vnd|nghìn|ngàn|\\$|usd)?");
        Matcher rangeMatcher = rangePattern.matcher(query);
        if (rangeMatcher.find()) {
            String minPrice = rangeMatcher.group(2);
            String maxPrice = rangeMatcher.group(4);
            attributes.put("price_min", minPrice);
            attributes.put("price_max", maxPrice);
        }
    }

    /**
     * Trích xuất thông tin thương hiệu từ truy vấn
     */
    private void extractBrandAttribute(String query, Map<String, String> attributes) {
        String[] brands = { "nike", "adidas", "puma", "gucci", "zara", "h&m", "louis vuitton", "balenciaga",
                "uniqlo", "levi's", "calvin klein", "tommy hilfiger", "lacoste", "dior" };

        for (String brand : brands) {
            if (query.toLowerCase().contains(brand.toLowerCase())) {
                attributes.put("brand", brand);
                break;
            }
        }
    }

    /**
     * Kiểm tra xem tin nhắn có đề cập đến danh mục quần áo không
     */
    private boolean mentionsClothingCategory(String message) {
        // Tìm từ khóa danh mục trong tin nhắn
        for (List<String> keywords : categoryKeywords.values()) {
            for (String keyword : keywords) {
                if (message.toLowerCase().contains(keyword.toLowerCase())) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * Trích xuất metadata từ sources để cải thiện phân tích ngữ cảnh
     */
    private Map<String, Object> extractMetadataFromSources(List<Map<String, Object>> sources) {
        Map<String, Object> extractedMetadata = new HashMap<>();

        for (Map<String, Object> source : sources) {
            if (source.containsKey("metadata")) {
                extractedMetadata.putAll((Map<String, Object>) source.get("metadata"));
            }
        }

        return extractedMetadata;
    }

    /**
     * Tinh chỉnh phân loại dựa trên metadata nếu có
     */
    private QueryIntent refineQueryIntentWithMetadata(QueryIntent queryIntent, Map<String, Object> extractedMetadata,
            String message) {
        String lowerMessage = message.toLowerCase();

        // Nếu đã là truy vấn tìm kiếm rõ ràng, thì giữ nguyên
        if (queryIntent == QueryIntent.PRODUCT_SEARCH) {
            // Kiểm tra các mẫu câu hỏi trực tiếp về việc cửa hàng có sản phẩm hay không
            boolean isDirectProductAvailabilityQuestion = (lowerMessage.contains("có")
                    && lowerMessage.contains("không")) ||
                    lowerMessage.contains("bán không") ||
                    lowerMessage.contains("có bán") ||
                    lowerMessage.contains("có hàng") ||
                    (lowerMessage.contains("shop") && lowerMessage.contains("có")) ||
                    (lowerMessage.contains("bạn") && lowerMessage.contains("có")) ||
                    lowerMessage.matches(".*\\b(sell|available|in stock)\\b.*");

            // Nếu là câu hỏi về tính sẵn có của sản phẩm, đảm bảo nó được phân loại là
            // PRODUCT_SEARCH
            if (isDirectProductAvailabilityQuestion && mentionsClothingCategory(lowerMessage)) {
                return QueryIntent.PRODUCT_SEARCH;
            }

            return QueryIntent.PRODUCT_SEARCH;
        }

        // Nếu là truy vấn chung nhưng có metadata với từ khóa sản phẩm rõ ràng
        if (queryIntent == QueryIntent.GENERAL_QUERY) {
            boolean mentionsClothing = mentionsClothingCategory(message);

            boolean hasProductSearchKeywords = lowerMessage.contains("tìm") ||
                    lowerMessage.contains("mua") ||
                    lowerMessage.contains("bán") ||
                    lowerMessage.contains("có không") ||
                    lowerMessage.contains("shop có") ||
                    lowerMessage.contains("bán không");

            if (mentionsClothing && hasProductSearchKeywords) {
                return QueryIntent.PRODUCT_SEARCH;
            }
        }

        return queryIntent;
    }

    /**
     * Áp dụng bộ lọc thêm từ metadata nếu có
     */
    private List<Map<String, Object>> applyMetadataFilters(List<Map<String, Object>> products,
            Map<String, Object> metadata) {
        List<Map<String, Object>> filteredProducts = new ArrayList<>();

        for (Map<String, Object> product : products) {
            Map<String, Object> filteredProduct = new HashMap<>(product);

            // Apply filters based on metadata
            for (Map.Entry<String, Object> entry : metadata.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                if (product.containsKey(key)) {
                    Object productValue = product.get(key);
                    if (productValue instanceof String) {
                        String productStringValue = (String) productValue;
                        if (!productStringValue.contains(value.toString())) {
                            continue;
                        }
                    } else if (productValue instanceof Number) {
                        Number productNumberValue = (Number) productValue;
                        Number valueNumber = (Number) value;
                        if (productNumberValue.doubleValue() < valueNumber.doubleValue()) {
                            continue;
                        }
                    } else if (productValue instanceof List) {
                        List<String> productListValue = (List<String>) productValue;
                        if (!productListValue.contains(value.toString())) {
                            continue;
                        }
                    }
                }
            }

            filteredProducts.add(filteredProduct);
        }

        return filteredProducts;
    }
}
