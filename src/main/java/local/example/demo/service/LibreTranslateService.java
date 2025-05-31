package local.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LibreTranslateService {

    @Value("${libretranslate.api.url}")
    private String apiBaseUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    public String translate(String text, String sourceLang, String targetLang) {
        if (text == null || text.trim().isEmpty()) {
            return text;
        }

        String apiUrl = apiBaseUrl + "/translate";

        try {
            Map<String, Object> request = new HashMap<>();
            request.put("q", text);
            request.put("source", sourceLang);
            request.put("target", targetLang);
            request.put("format", "text");

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(request, headers);

            // Gọi API LibreTranslate
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, entity, Map.class);
            Map body = response.getBody();

            if (body != null && body.get("translatedText") != null) {
                return body.get("translatedText").toString();
            } else {
                // Kiểm tra xem có lỗi trả về từ API không
                if (body != null && body.containsKey("error")) {
                    System.err.println("LibreTranslate API error: " + body.get("error"));
                } else {
                    System.err.println("Empty or unexpected translation response!");
                }
                return text; // Trả về text gốc nếu có lỗi hoặc không có bản dịch
            }
        } catch (Exception e) {
            System.err.println("Translate API call failed: " + e.getMessage());
            // Bạn có thể muốn log chi tiết hơn ở đây nếu cần
            // e.printStackTrace();
            return text; // Trả về text gốc nếu gọi API thất bại
        }
    }

    public boolean isLanguageSupported(String languageCode) {
        String apiUrl = apiBaseUrl + "/languages";
        try {
            // Expect a List of Maps (or Objects) instead of a single Map
            ResponseEntity<List> response = restTemplate.getForEntity(apiUrl, List.class);
            List<Map<String, String>> languagesList = response.getBody(); // Cast to List<Map<String, String>>

            if (languagesList != null) {
                // Iterate through the list of language objects
                for (Map<String, String> langMap : languagesList) {
                    // Check if the 'code' field matches the languageCode
                    if (langMap != null && languageCode.equals(langMap.get("code"))) {
                        return true; // Language code found
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching or processing supported languages: " + e.getMessage());
            e.printStackTrace(); // Keep logging the error for debugging
        }
        // Return false if not found or if an error occurred
        return false;
    }

}
