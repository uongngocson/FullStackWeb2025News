package local.example.demo.service;

import local.example.demo.model.dto.HandleSubmitDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

@Service
public class HandleSubmitService {
    private static final Logger logger = LoggerFactory.getLogger(HandleSubmitService.class);
    
    private final JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall createOrderProcedure;
    
    @Autowired
    public HandleSubmitService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        setupProcedure();
    }
    
    private void setupProcedure() {
        // Configure the stored procedure call
        this.createOrderProcedure = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("usp_CreateOrderFull")
                .declareParameters(
                        new SqlParameter("customer_id", Types.INTEGER),
                        new SqlParameter("payment_id", Types.INTEGER),
                        new SqlParameter("TotalAmount", Types.DECIMAL),
                        // Using Types.OTHER for structured type
                        new SqlParameter("OrderItems", Types.OTHER),
                        new SqlParameter("AddressId", Types.INTEGER),
                        new SqlParameter("recipient_name", Types.NVARCHAR),
                        new SqlParameter("recipient_phone", Types.NVARCHAR),
                        new SqlParameter("Street", Types.NVARCHAR),
                        new SqlParameter("ProvinceId", Types.INTEGER),
                        new SqlParameter("DistrictId", Types.INTEGER),
                        new SqlParameter("WardId", Types.NVARCHAR),
                        new SqlParameter("Country", Types.NVARCHAR),
                        new SqlParameter("ProductVariantIds", Types.NVARCHAR),
                        new SqlOutParameter("new_order_id", Types.NVARCHAR),
                        new SqlOutParameter("ErrorCode", Types.INTEGER),
                        new SqlOutParameter("ErrorMessage", Types.NVARCHAR)
                );
    }
    
    @Transactional
    public Map<String, Object> submitOrder(HandleSubmitDTO orderData) {
        logger.info("Processing order submission for customer ID: {}", orderData.getCustomer_id());
        
        try {
            // Since using structured types directly is complex, we'll use the direct SQL approach
            Map<String, Object> result = executeCreateOrderProcedure(orderData);
            
            logger.info("Order submission completed. Order ID: {}", result.get("new_order_id"));
            return result;
            
        } catch (Exception e) {
            logger.error("Error submitting order", e);
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("ErrorCode", -1);
            errorResult.put("ErrorMessage", "System error: " + e.getMessage());
            return errorResult;
        }
    }
    
    private Map<String, Object> executeCreateOrderProcedure(HandleSubmitDTO orderData) {
        // Direct SQL execution approach
        StringBuilder sql = new StringBuilder();
        sql.append("DECLARE @OrderItems dbo.OrderDetailType; ");
        
        // Insert order items into the table variable
        for (HandleSubmitDTO.OrderItemDTO item : orderData.getOrderItems()) {
            sql.append("INSERT INTO @OrderItems (product_variant_id, quantity) VALUES (")
               .append(item.getProduct_variant_id()).append(", ")
               .append(item.getQuantity()).append("); ");
        }
        
        // Declare output parameters
        sql.append("DECLARE @new_order_id CHAR(10); ")
           .append("DECLARE @ErrorCode INT; ")
           .append("DECLARE @ErrorMessage NVARCHAR(500); ");
        
        // Execute the stored procedure
        sql.append("EXEC dbo.usp_CreateOrderFull ")
           .append("@customer_id = ").append(orderData.getCustomer_id()).append(", ")
           .append("@payment_id = ").append(orderData.getPayment_id()).append(", ")
           .append("@TotalAmount = ").append(orderData.getTotalAmount()).append(", ")
           .append("@OrderItems = @OrderItems, ")
           .append("@AddressId = ").append(orderData.getAddressId()).append(", ")
           .append("@recipient_name = N'").append(orderData.getRecipient_name()).append("', ")
           .append("@recipient_phone = '").append(orderData.getRecipient_phone()).append("', ")
           .append("@Street = N'").append(orderData.getStreet()).append("', ")
           .append("@ProvinceId = ").append(orderData.getProvinceId()).append(", ")
           .append("@DistrictId = ").append(orderData.getDistrictId()).append(", ")
           .append("@WardId = '").append(orderData.getWardId()).append("', ")
           .append("@Country = N'").append(orderData.getCountry()).append("', ")
           .append("@ProductVariantIds = '").append(orderData.getProductVariantIds()).append("', ")
           .append("@new_order_id = @new_order_id OUTPUT, ")
           .append("@ErrorCode = @ErrorCode OUTPUT, ")
           .append("@ErrorMessage = @ErrorMessage OUTPUT; ");
        
        // Select output parameters and also the result set that the stored procedure returns
        sql.append("SELECT @new_order_id AS new_order_id, @ErrorCode AS ErrorCode, @ErrorMessage AS ErrorMessage; ");
        
        // In SQL Server, when a stored procedure itself returns a result set with SELECT,
        // we need to capture both the output parameters and the result set
        // Let's add a final SELECT to get the complete result including NewOrderID
        sql.append("SELECT @new_order_id AS GeneratedOrderID; ");
        
        logger.info("Executing stored procedure with SQL: {}", sql.toString());
        
        try {
            // Execute the SQL and get the result map
            Map<String, Object> result = jdbcTemplate.queryForMap(sql.toString());
            
            // Log all returned values for debugging
            logger.info("Stored procedure result: {}", result);
            
            // Try to get order ID from different possible keys
            Object orderId = result.get("new_order_id");
            if (orderId == null) {
                orderId = result.get("NewOrderID");
            }
            if (orderId == null) {
                orderId = result.get("GeneratedOrderID");
            }
            
            // Update the result with the found order ID
            if (orderId != null) {
                result.put("new_order_id", orderId);
                logger.info("Found order ID: {}", orderId);
            } else {
                logger.warn("No order ID found in the stored procedure result");
            }
            
            // Add success flag based on error code
            Integer errorCode = (Integer) result.get("ErrorCode");
            result.put("success", errorCode != null && errorCode == 0);
            
            return result;
        } catch (Exception e) {
            logger.error("Error executing stored procedure: {}", e.getMessage(), e);
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("ErrorCode", -999);
            errorResult.put("ErrorMessage", "Database error: " + e.getMessage());
            return errorResult;
        }
    }
}
