package local.example.demo.controller.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.service.TranslationService;
import lombok.RequiredArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/translate")
@RequiredArgsConstructor
public class TranslationController {

    private final TranslationService translationService;

    @PostMapping("/text")
    public ResponseEntity<Map<String, String>> translateText(@RequestBody Map<String, String> request) {
        try {
            String text = request.get("text");
            String sourceLang = request.get("sourceLang");
            String targetLang = request.get("targetLang");

            if (text == null || text.isEmpty()) {
                Map<String, String> response = new HashMap<>();
                response.put("error", "Text is required");
                return ResponseEntity.badRequest().body(response);
            }

            String translatedText = translationService.translateText(text, sourceLang, targetLang);

            Map<String, String> response = new HashMap<>();
            response.put("translatedText", translatedText);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, String> response = new HashMap<>();
            response.put("error", "Translation failed: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
}