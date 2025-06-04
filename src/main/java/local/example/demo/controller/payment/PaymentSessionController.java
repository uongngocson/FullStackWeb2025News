package local.example.demo.controller.payment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/payment")
public class PaymentSessionController {

    /**
     * Store order data in session before redirecting to payment gateway
     * 
     * @param orderData The order data to store
     * @param session   The HTTP session
     * @return Response indicating success or failure
     */
    @PostMapping("/store-order-data")
    public ResponseEntity<Map<String, Object>> storeOrderData(@RequestBody Map<String, Object> orderData,
            HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Store order data in session
            session.setAttribute("pendingOrderData", orderData);
            
            // Log for debugging
            System.out.println("Order data stored in session: " + orderData);
            
            response.put("success", true);
            response.put("message", "Order data stored in session successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to store order data: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
} 