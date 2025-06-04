package local.example.demo.config;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
@EnableConfigurationProperties
public class AppConfig {
    // This class enables @ConfigurationProperties scanning

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
} 