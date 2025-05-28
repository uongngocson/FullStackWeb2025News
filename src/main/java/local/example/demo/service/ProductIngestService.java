package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProductIngestService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private DataIngestionService ingestionService;

    @Autowired
    private ProductLoadRandom productLoadRandom;

    /**
     * Initialize the service and ingest initial data
     */
    @PostConstruct
    public void init() {
        try {
            // Wait a few seconds for other services to initialize
            Thread.sleep(5000);

            // Ingest initial product data
            ingestAllProducts();
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
        try {
            System.out.println("Starting scheduled product data ingestion");
            ingestAllProducts();
        } catch (Exception e) {
            System.err.println("Error during scheduled product ingestion: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Ingest all products from the database
     */
    public void ingestAllProducts() {
        try {
            System.out.println("Starting product data ingestion...");

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
            int batchSize = 100;
            int processedCount = 0;

            for (int offset = 0; offset < totalProducts; offset += batchSize) {
                // Get batch of products
                List<Map<String, Object>> products = jdbcTemplate.queryForList(
                        "SELECT p.productId as productId, p.productName as productName, p.description as description, p.price as price, "
                                +
                                "c.categoryName as categoryName, b.brandName as brandName " +
                                "FROM dbo.Products p " +
                                "LEFT JOIN dbo.Categories c ON p.category_id = c.category_id " +
                                "LEFT JOIN dbo.Brands b ON p.brand_id = b.brand_id " +
                                "ORDER BY p.productId " +
                                "OFFSET " + offset + " ROWS " +
                                "FETCH NEXT " + batchSize + " ROWS ONLY");

                // Ingest products
                List<Map<String, Object>> documents = prepareProductDocuments(products);
                int ingestedCount = ingestionService.ingestDocuments(documents);

                processedCount += products.size();
                System.out.println("Processed " + processedCount + "/" + totalProducts +
                        " products, ingested " + ingestedCount + " documents");
            }

            System.out.println("Product data ingestion completed");
        } catch (Exception e) {
            System.err.println("Error ingesting products: " + e.getMessage());
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
                String categoryName = (String) product.get("categoryName");
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
        try {
            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

            // Get product details
            List<Map<String, Object>> products = jdbcTemplate.queryForList(
                    "SELECT p.productId as productId, p.productName as productName, p.description as description, p.price as price, "
                            +
                            "c.categoryName as categoryName, b.brandName as brandName " +
                            "FROM dbo.Products p " +
                            "LEFT JOIN dbo.Categories c ON p.category_id = c.category_id " +
                            "LEFT JOIN dbo.Brands b ON p.brand_id = b.brand_id " +
                            "WHERE p.productId = ?",
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