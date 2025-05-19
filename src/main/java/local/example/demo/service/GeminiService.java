package local.example.demo.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.auth.oauth2.GoogleCredentials;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.Collections;

@Service
@Slf4j
public class GeminiService {

    private final RestTemplate restTemplate = new RestTemplate();
    private final String PROJECT_ID = "clothing-website-456115"; // TODO: thay bằng project thật
    private final String LOCATION = "us-central1";
    private final String MODEL = "gemini-pro";
    private final String SERVICE_ACCOUNT_FILE = "clothing-website-456115-a99ef35ca6aa.json"; // TODO: thay bằng tên file .json thật

    public String callGemini(String prompt) {
        try {
            // 1. Lấy access token từ service account
            String token = getAccessToken();

            // 2. Chuẩn bị URL
            String url = String.format(
                    "https://%s-aiplatform.googleapis.com/v1/projects/%s/locations/%s/publishers/google/models/%s:generateContent",
                    LOCATION, PROJECT_ID, LOCATION, MODEL);

            // 3. Tạo header và body
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(token);

            String body = """
            {
              "contents": [{
                "role": "user",
                "parts": [{ "text": "%s" }]
              }]
            }
            """.formatted(prompt);

            HttpEntity<String> request = new HttpEntity<>(body, headers);

            // 4. Gửi request
            ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
            return parseResponse(response.getBody());

        } catch (Exception e) {
            log.error("Error calling Gemini API", e);
            return "Lỗi khi gọi Gemini: " + e.getMessage();
        }
    }

    private String parseResponse(String jsonResponse) {
        try {
            JsonNode root = new ObjectMapper().readTree(jsonResponse);
            return root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
        } catch (Exception e) {
            log.error("Error parsing Gemini response", e);
            return jsonResponse;
        }
    }

    private String getAccessToken() throws IOException {
        GoogleCredentials credentials = GoogleCredentials
                .fromStream(new ClassPathResource(SERVICE_ACCOUNT_FILE).getInputStream())
                .createScoped(Collections.singleton("https://www.googleapis.com/auth/cloud-platform"));

        credentials.refreshIfExpired();
        return credentials.getAccessToken().getTokenValue();
    }
}
