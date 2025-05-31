package local.example.demo.controller.client;

import local.example.demo.model.dto.HandleSubmitDTO;
import local.example.demo.service.HandleSubmitService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/handle")
public class HandleSubmitController {
    
    private static final Logger logger = LoggerFactory.getLogger(HandleSubmitController.class);
    
    private final HandleSubmitService handleSubmitService;
    
    @Autowired
    public HandleSubmitController(HandleSubmitService handleSubmitService) {
        this.handleSubmitService = handleSubmitService;
    }
    
    /**
     * Endpoint to handle order submission
     * @param orderData The order data from the client
     * @return Response with order result
     */
    @PostMapping("/submit")
    public ResponseEntity<Map<String, Object>> submitOrder(@RequestBody HandleSubmitDTO orderData) {
        // Debug logs to check received values
        System.out.println("============= ORDER DATA RECEIVED =============");
        System.out.println("Customer ID: " + orderData.getCustomer_id());
        System.out.println("Payment ID: " + orderData.getPayment_id());
        System.out.println("Total Amount: " + orderData.getTotalAmount());
        System.out.println("Address ID: " + orderData.getAddressId());
        System.out.println("Recipient Name: " + orderData.getRecipient_name());
        System.out.println("Recipient Phone: " + orderData.getRecipient_phone());
        System.out.println("Street: " + orderData.getStreet());
        System.out.println("Province ID: " + orderData.getProvinceId());
        System.out.println("District ID: " + orderData.getDistrictId());
        System.out.println("Ward ID: " + orderData.getWardId());
        
        if (orderData.getOrderItems() != null) {
            System.out.println("Order Items Count: " + orderData.getOrderItems().size());
            for (int i = 0; i < orderData.getOrderItems().size(); i++) {
                HandleSubmitDTO.OrderItemDTO item = orderData.getOrderItems().get(i);
                System.out.println("  Item " + (i+1) + ": Product Variant ID: " + item.getProduct_variant_id() + ", Quantity: " + item.getQuantity());
            }
        } else {
            System.out.println("Order Items: null");
        }
        System.out.println("===============================================");
        
        logger.info("Received order submission request for customer ID: {}", orderData.getCustomer_id());
        
        try {
            // Validate the request data
            Map<String, String> validationErrors = validateOrderData(orderData);
            if (!validationErrors.isEmpty()) {
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("message", "Validation failed");
                errorResponse.put("errors", validationErrors);
                return ResponseEntity.badRequest().body(errorResponse);
            }
            
            // Process the order
            Map<String, Object> result = handleSubmitService.submitOrder(orderData);
            
            // Check if order was successful
            if (Boolean.TRUE.equals(result.get("success"))) {
                // Return success response
                Map<String, Object> successResponse = new HashMap<>();
                successResponse.put("success", true);
                successResponse.put("orderId", result.get("new_order_id"));
                successResponse.put("message", "Order placed successfully");
                return ResponseEntity.ok(successResponse);
            } else {
                // Return error response with details from the stored procedure
                Map<String, Object> errorResponse = new HashMap<>();
                errorResponse.put("success", false);
                errorResponse.put("message", result.get("ErrorMessage"));
                errorResponse.put("errorCode", result.get("ErrorCode"));
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
            }
            
        } catch (Exception e) {
            logger.error("Error processing order submission", e);
            
            // Return error response
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "An unexpected error occurred while processing your order");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
    
    /**
     * Validate order data
     * @param orderData The order data to validate
     * @return Map of validation errors (empty if valid)
     */
    private Map<String, String> validateOrderData(HandleSubmitDTO orderData) {
        Map<String, String> errors = new HashMap<>();
        
        // Validate customer ID
        if (orderData.getCustomer_id() == null || orderData.getCustomer_id() <= 0) {
            errors.put("customer_id", "Valid customer ID is required");
        }
        
        // Validate payment method
        if (orderData.getPayment_id() == null || (orderData.getPayment_id() != 1 && orderData.getPayment_id() != 2)) {
            errors.put("payment_id", "Valid payment method is required (1 for online, 2 for COD)");
        }
        
        // Validate total amount
        if (orderData.getTotalAmount() == null || orderData.getTotalAmount().doubleValue() <= 0) {
            errors.put("TotalAmount", "Valid order total is required");
        }
        
        // Validate order items
        if (orderData.getOrderItems() == null || orderData.getOrderItems().isEmpty()) {
            errors.put("OrderItems", "Order must contain at least one item");
        } else {
            // Validate each order item
            for (int i = 0; i < orderData.getOrderItems().size(); i++) {
                HandleSubmitDTO.OrderItemDTO item = orderData.getOrderItems().get(i);
                if (item.getProduct_variant_id() == null || item.getProduct_variant_id() <= 0) {
                    errors.put("OrderItems[" + i + "].product_variant_id", "Valid product variant ID is required");
                }
                if (item.getQuantity() == null || item.getQuantity() <= 0) {
                    errors.put("OrderItems[" + i + "].quantity", "Valid quantity is required");
                }
            }
        }
        
        // Validate shipping address
        if (orderData.getAddressId() == null || orderData.getAddressId() <= 0) {
            errors.put("AddressId", "Valid address ID is required");
        }
        
        if (orderData.getRecipient_name() == null || orderData.getRecipient_name().trim().isEmpty()) {
            errors.put("recipient_name", "Recipient name is required");
        }
        
        if (orderData.getRecipient_phone() == null || orderData.getRecipient_phone().trim().isEmpty()) {
            errors.put("recipient_phone", "Recipient phone is required");
        }
        
        if (orderData.getStreet() == null || orderData.getStreet().trim().isEmpty()) {
            errors.put("Street", "Street address is required");
        }
        
        if (orderData.getProvinceId() == null || orderData.getProvinceId() <= 0) {
            errors.put("ProvinceId", "Valid province ID is required");
        }
        
        if (orderData.getDistrictId() == null || orderData.getDistrictId() <= 0) {
            errors.put("DistrictId", "Valid district ID is required");
        }
        
        if (orderData.getWardId() == null || orderData.getWardId().trim().isEmpty()) {
            errors.put("WardId", "Ward ID is required");
        }
        
        return errors;
    }
}
