# Performance Optimization Guide

This document explains how to optimize application startup and runtime performance by disabling certain heavyweight features.

## Problem

The application was experiencing slow startup times due to several heavyweight services:
- TextEmbeddingService: Makes API calls to Gemini for text embeddings
- FAISSVectorStore: Loads and maintains a vector database for similarity search
- ChatbotRAG: Uses the above services for retrieval-augmented generation

## Solution

We've implemented a feature flag system that allows you to enable/disable these services as needed. This can significantly improve startup time during development or when these features are not required.

## How to Use

### Option 1: Use the fast profile

The easiest way to disable heavyweight services is to use the `fast` profile:

```bash
# For Maven
mvn spring-boot:run -Dspring-boot.run.profiles=fast

# For running the JAR directly
java -jar your-application.jar --spring.profiles.active=fast
```

### Option 2: Configure individual settings

You can selectively enable/disable services by adding these properties to your `application.properties` or passing them as command-line arguments:

```properties
# Disable text embedding service
app.performance.text-embedding-enabled=false

# Disable vector store service
app.performance.vector-store-enabled=false

# Disable chatbot RAG features
app.performance.chatbot-rag-enabled=false
```

Example with command-line arguments:

```bash
java -jar your-application.jar --app.performance.text-embedding-enabled=false
```

## Service Behavior When Disabled

When services are disabled:

1. **TextEmbeddingService**: Returns null for embedding requests and logs a message
2. **FAISSVectorStore**: Returns empty results for searches and skips document addition
3. **ChatBotController**: Uses simple keyword-based responses instead of RAG

## Impact on Functionality

- When RAG is disabled, the chatbot will use simpler, rule-based responses
- Search functionality will still work but won't use vector-based semantic search
- All basic website functionality remains intact

## Re-enabling Services

To re-enable all services, either:
1. Remove the `fast` profile and restart the application
2. Explicitly set the properties to `true` in your configuration 