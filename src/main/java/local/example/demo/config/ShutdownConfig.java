package local.example.demo.config;

import local.example.demo.service.FAISSVectorStore;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.stereotype.Component;

@Component
public class ShutdownConfig implements ApplicationListener<ContextClosedEvent> {

    @Autowired
    private FAISSVectorStore vectorStore;

    @Override
    public void onApplicationEvent(ContextClosedEvent event) {
        System.out.println("Application is shutting down. Cleaning up resources...");

        // Save vector store data
        if (vectorStore != null) {
            vectorStore.shutdown();
        }

        System.out.println("Cleanup completed. Goodbye!");
    }
}