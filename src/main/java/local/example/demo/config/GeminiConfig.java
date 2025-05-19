package local.example.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
@Component
@ConfigurationProperties(prefix = "google.ai")
public class GeminiConfig {
    private String apiKey;
    private String projectId;
    private String location;
}
