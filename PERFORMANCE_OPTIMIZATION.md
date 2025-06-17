# Performance Optimization Guide

This document explains how to optimize application startup and runtime performance by disabling certain heavyweight features.

## Problem

The application was experiencing slow startup times due to several heavyweight services:
- TextEmbeddingService: Makes API calls to Gemini for text embeddings
- FAISSVectorStore: Loads and maintains a vector database for similarity search
- ChatbotRAG: Uses the above services for retrieval-augmented generation
- ProductIngestService: Loads all products into the vector store on startup

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

# Product ingestion settings
app.product-ingestion.enabled=false         # Disable product ingestion completely
app.product-ingestion.startup=false         # Don't ingest products on startup
app.product-ingestion.batch-size=100        # Number of products to process per batch
app.product-ingestion.initial-categories=5  # Number of top categories to ingest on startup
app.product-ingestion.startup-delay-seconds=30  # Delay before starting ingestion
```

Example with command-line arguments:

```bash
java -jar your-application.jar --app.performance.text-embedding-enabled=false --app.product-ingestion.startup=false
```

## Service Behavior When Disabled

When services are disabled:

1. **TextEmbeddingService**: Returns null for embedding requests and logs a message
2. **FAISSVectorStore**: Returns empty results for searches and skips document addition
3. **ChatBotController**: Uses simple keyword-based responses instead of RAG
4. **ProductIngestService**: Skips product ingestion on startup and scheduled tasks

## Impact on Functionality

- When RAG is disabled, the chatbot will use simpler, rule-based responses
- Search functionality will still work but won't use vector-based semantic search
- All basic website functionality remains intact
- When product ingestion is disabled, the chatbot won't have product information

## Optimized Product Ingestion

For large product catalogs, we've implemented smarter ingestion strategies:

1. **Lazy Loading**: Products are not loaded on startup by default
2. **Category-based Loading**: Only ingest products from top categories
3. **Admin Controls**: Use the admin panel to trigger specific ingestion tasks
4. **Scheduled Updates**: Products are refreshed automatically at midnight

## Re-enabling Services

To re-enable all services, either:
1. Remove the `fast` profile and restart the application
2. Explicitly set the properties to `true` in your configuration 