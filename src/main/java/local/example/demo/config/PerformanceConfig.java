package local.example.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

/**
 * Configuration properties to control enabled/disabled features
 * for performance optimization
 */
@Component
@ConfigurationProperties(prefix = "app.performance")
public class PerformanceConfig {
    
    /**
     * Enable/disable text embedding service
     */
    private boolean textEmbeddingEnabled = true;
    
    /**
     * Enable/disable vector store service
     */
    private boolean vectorStoreEnabled = true;
    
    /**
     * Enable/disable chatbot RAG features
     */
    private boolean chatbotRagEnabled = true;

    public boolean isTextEmbeddingEnabled() {
        return textEmbeddingEnabled;
    }

    public void setTextEmbeddingEnabled(boolean textEmbeddingEnabled) {
        this.textEmbeddingEnabled = textEmbeddingEnabled;
    }

    public boolean isVectorStoreEnabled() {
        return vectorStoreEnabled;
    }

    public void setVectorStoreEnabled(boolean vectorStoreEnabled) {
        this.vectorStoreEnabled = vectorStoreEnabled;
    }

    public boolean isChatbotRagEnabled() {
        return chatbotRagEnabled;
    }

    public void setChatbotRagEnabled(boolean chatbotRagEnabled) {
        this.chatbotRagEnabled = chatbotRagEnabled;
    }
} 