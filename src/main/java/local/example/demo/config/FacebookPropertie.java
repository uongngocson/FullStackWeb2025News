package local.example.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "facebook") 
public class FacebookPropertie {
    private String pageId;
    private String pageAccessToken;

    // Getter và Setter (bắt buộc)
    public String getPageId() {
        return pageId;
    }

    public void setPageId(String pageId) {
        this.pageId = pageId;
    }

    public String getPageAccessToken() {
        return pageAccessToken;
    }

    public void setPageAccessToken(String pageAccessToken) {
        this.pageAccessToken = pageAccessToken;
    }
}
