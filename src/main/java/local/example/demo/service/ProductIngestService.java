package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Service
public class ProductIngestService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private DataIngestionService ingestionService;

    @Autowired
    private ProductLoadRandom productLoadRandom;
    
    @Value("${app.product-ingestion.enabled:true}")
    private boolean productIngestionEnabled;
    
    @Value("${app.product-ingestion.startup:false}")
    private boolean ingestOnStartup;
    
    @Value("${app.product-ingestion.batch-size:100}")
    private int batchSize;
    
    @Value("${app.product-ingestion.initial-categories:10}")
    private int initialCategoriesToIngest;
    
    @Value("${app.product-ingestion.startup-delay-seconds:30}")
    private int startupDelaySeconds;
    
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    
    /**
     * Initialize the service with delayed startup if enabled
     */
    @PostConstruct
    public void init() {
        if (!productIngestionEnabled) {
            System.out.println("Product ingestion is disabled. Skipping initialization.");
            return;
        }

        if (ingestOnStartup) {
            System.out.println("Scheduling initial product ingestion with " + startupDelaySeconds + " seconds delay");
            scheduler.schedule(this::startupIngestion, startupDelaySeconds, TimeUnit.SECONDS);
        } else {
            System.out.println("Automatic product ingestion at startup is disabled. Use the admin panel to trigger ingestion.");
        }
    }
    
    /**
     * Perform startup ingestion asynchronously after application is fully started
     */
    private void startupIngestion() {
        try {
            System.out.println("Starting initial product ingestion...");
            // Only ingest products from top categories initially
            ingestProductsByTopCategories(initialCategoriesToIngest);
        } catch (Exception e) {
            System.err.println("Error during initial product ingestion: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Schedule periodic re-ingestion of product data (once per day)
     */
    @Scheduled(cron = "0 0 0 * * ?") // Run at midnight every day
    public void scheduledIngestion() {
        if (!productIngestionEnabled) {
            System.out.println("Product ingestion is disabled. Skipping scheduled ingestion.");
            return;
        }
        
        try {
            System.out.println("Starting scheduled product data ingestion");
            // Run in a separate thread to avoid blocking the scheduler
            CompletableFuture.runAsync(this::ingestAllProducts);
        } catch (Exception e) {
            System.err.println("Error during scheduled product ingestion: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Ingest products from top N categories (by product count)
     * This is more efficient for startup than ingesting all products
     */
    @Async
    public void ingestProductsByTopCategories(int categoryCount) {
        try {
            System.out.println("Starting product data ingestion for top " + categoryCount + " categories...");

            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
            
            // Get top categories by product count
            List<Integer> topCategoryIds = jdbcTemplate.queryForList(
                "SELECT TOP " + categoryCount + " c.category_id " +
                "FROM dbo.Categories c " +
                "JOIN dbo.Products p ON c.category_id = p.category_id " +
                "GROUP BY c.category_id " +
                "ORDER BY COUNT(p.product_id) DESC", 
                Integer.class);
            
            if (topCategoryIds.isEmpty()) {
                System.out.println("No categories found for ingestion");
                return;
            }
            
            System.out.println("Found " + topCategoryIds.size() + " top categories for ingestion");
            
            // Process each category
            for (Integer categoryId : topCategoryIds) {
                ingestProductsByCategory(categoryId);
            }
            
            System.out.println("Top categories product ingestion completed");
        } catch (Exception e) {
            System.err.println("Error ingesting products by categories: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Ingest products for a specific category
     */
    @Async
    public void ingestProductsByCategory(int categoryId) {
        try {
            System.out.println("Starting product data ingestion for category ID " + categoryId);

            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
            
            // Get total number of products in this category
            Integer totalProducts = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM dbo.Products WHERE category_id = ?", 
                Integer.class, 
                categoryId);

            if (totalProducts == null || totalProducts == 0) {
                System.out.println("No products found in category " + categoryId);
                return;
            }

            System.out.println("Found " + totalProducts + " products in category " + categoryId);
            
            // Process in batches
            int processedCount = 0;

            for (int offset = 0; offset < totalProducts; offset += batchSize) {
                // Get batch of products
                List<Map<String, Object>> products = jdbcTemplate.queryForList(
                    "SELECT p.product_id as productId, p.product_name as productName, p.description as description, p.price as price, " +
                    "c.category_name as category_name, b.brand_name as brandName " +
                    "FROM dbo.Products p " +
                    "LEFT JOIN dbo.Categories c ON p.category_id = c.category_id " +
                    "LEFT JOIN dbo.Brands b ON p.brand_id = b.brand_id " +
                    "WHERE p.category_id = ? " +
                    "ORDER BY p.product_id " +
                    "OFFSET " + offset + " ROWS " +
                    "FETCH NEXT " + batchSize + " ROWS ONLY",
                    categoryId);

                // Ingest products
                List<Map<String, Object>> documents = prepareProductDocuments(products);
                int ingestedCount = ingestionService.ingestDocuments(documents);

                processedCount += products.size();
                System.out.println("Category " + categoryId + ": Processed " + processedCount + "/" + totalProducts +
                    " products, ingested " + ingestedCount + " documents");
            }
        } catch (Exception e) {
            System.err.println("Error ingesting products for category " + categoryId + ": " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Ingest all products from the database
     * This is a heavyweight operation and should be used carefully
     */
    @Async
    public void ingestAllProducts() {
        if (!productIngestionEnabled) {
            System.out.println("Product ingestion is disabled. Skipping full ingestion.");
            return;
        }
        
        try {
            System.out.println("Starting full product data ingestion...");

            // Use JDBC to query products
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

            // Get total number of products
            Integer totalProducts = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM dbo.Products", Integer.class);

            if (totalProducts == null || totalProducts == 0) {
                System.out.println("No products found to ingest");
                return;
            }

            System.out.println("Found " + totalProducts + " products to ingest");

            // Process in batches
            int processedCount = 0;

            for (int offset = 0; offset < totalProducts; offset += batchSize) {
                // Get batch of products
                List<Map<String, Object>> products = jdbcTemplate.queryForList(
                        "SELECT p.product_id as productId, p.product_name as productName, p.description as description, p.price as price, " +
                        "c.category_name as category_name, b.brand_name as brandName " +
                        "FROM dbo.Products p " +
                        "LEFT JOIN dbo.Categories c ON p.category_id = c.category_id " +
                        "LEFT JOIN dbo.Brands b ON p.brand_id = b.brand_id " +
                        "ORDER BY p.product_id " +
                        "OFFSET " + offset + " ROWS " +
                        "FETCH NEXT " + batchSize + " ROWS ONLY");

                // Ingest products
                List<Map<String, Object>> documents = prepareProductDocuments(products);
                int ingestedCount = ingestionService.ingestDocuments(documents);

                processedCount += products.size();
                System.out.println("Processed " + processedCount + "/" + totalProducts +
                        " products, ingested " + ingestedCount + " documents");
                
                // Small delay to prevent overwhelming the system
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
            }

            System.out.println("Full product data ingestion completed");
        } catch (Exception e) {
            System.err.println("Error ingesting all products: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Create document objects for each product for ingestion
     */
    private List<Map<String, Object>> prepareProductDocuments(List<Map<String, Object>> products) {
        List<Map<String, Object>> documents = new ArrayList<>();

        for (Map<String, Object> product : products) {
            try {
                Integer productId = (Integer) product.get("productId");
                String productName = (String) product.get("productName");
                String description = (String) product.get("description");
                Object price = product.get("price");
                String categoryName = (String) product.get("category_name");
                String brandName = (String) product.get("brandName");

                // Skip products with missing critical information
                if (productName == null || productName.isEmpty()) {
                    continue;
                }

                // Create document text
                StringBuilder documentText = new StringBuilder();
                documentText.append("Product: ").append(productName).append("\n");

                if (categoryName != null && !categoryName.isEmpty()) {
                    documentText.append("Category: ").append(categoryName).append("\n");
                }

                if (brandName != null && !brandName.isEmpty()) {
                    documentText.append("Brand: ").append(brandName).append("\n");
                }

                if (price != null) {
                    documentText.append("Price: ").append(price).append("\n");
                }

                if (description != null && !description.isEmpty()) {
                    documentText.append("Description: ").append(description).append("\n");
                }

                // Create document
                Map<String, Object> document = new HashMap<>();
                document.put("text", documentText.toString());
                document.put("productId", productId);
                document.put("productName", productName);
                document.put("category", categoryName);
                document.put("brand", brandName);
                document.put("price", price != null ? price.toString() : null);
                document.put("type", "product");

                documents.add(document);
            } catch (Exception e) {
                System.err.println("Error preparing product document: " + e.getMessage());
                e.printStackTrace();
            }
        }

        return documents;
    }

    /**
     * Manually ingest product data for a specific product ID
     */
    public boolean ingestProduct(int productId) {
        if (!productIngestionEnabled) {
            System.out.println("Product ingestion is disabled. Skipping product " + productId);
            return false;
        }
        
        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

            // Get product details
            List<Map<String, Object>> products = jdbcTemplate.queryForList(
                    "SELECT p.product_id as productId, p.product_name as productName, p.description as description, p.price as price, " +
                    "c.category_name as category_name, b.brand_name as brandName " +
                    "FROM dbo.Products p " +
                    "LEFT JOIN dbo.Categories c ON p.category_id = c.category_id " +
                    "LEFT JOIN dbo.Brands b ON p.brand_id = b.brand_id " +
                    "WHERE p.product_id = ?",
                    productId);

            if (products.isEmpty()) {
                System.out.println("Product not found: " + productId);
                return false;
            }

            // Prepare and ingest product document
            List<Map<String, Object>> documents = prepareProductDocuments(products);
            int ingestedCount = ingestionService.ingestDocuments(documents);

            System.out.println("Ingested " + ingestedCount + " documents for product ID " + productId);
            return ingestedCount > 0;
        } catch (Exception e) {
            System.err.println("Error ingesting product " + productId + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}