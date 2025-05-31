package local.example.demo.service;

import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.translate.TranslateClient;
import software.amazon.awssdk.services.translate.model.TranslateTextRequest;
import software.amazon.awssdk.services.translate.model.TranslateTextResponse;

@Service
public class TranslationService {

    private final TranslateClient translateClient;

    public TranslationService(TranslateClient translateClient) {
        this.translateClient = translateClient;
    }

    public String translateText(String text, String sourceLang, String targetLang) {
        try {
            TranslateTextRequest request = TranslateTextRequest.builder()
                    .text(text)
                    .sourceLanguageCode(sourceLang)
                    .targetLanguageCode(targetLang)
                    .build();
            TranslateTextResponse response = translateClient.translateText(request);
            return response.translatedText();
        } catch (Exception e) {
            throw new RuntimeException("Translation failed: " + e.getMessage());
        }
    }
}
