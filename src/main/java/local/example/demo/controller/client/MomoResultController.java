package local.example.demo.controller.client;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
public class MomoResultController {

    @Autowired
    private RestTemplate restTemplate;

    /**
     * Handle MoMo payment result
     * @param orderId Order ID
     * @param requestId Request ID
     * @param amount Payment amount
     * @param orderInfo Order information
     * @param orderType Order type
     * @param transId Transaction ID
     * @param resultCode Result code (0: Success)
     * @param message Message
     * @param payType Payment type
     * @param responseTime Response time
     * @param extraData Extra data
     * @param signature Signature
     * @param model Spring model
     * @param session HTTP session
     * @return View name
     */
    @GetMapping("/momo-result")
    public String momoResult(
            @RequestParam(required = false) String orderId,
            @RequestParam(required = false) String requestId,
            @RequestParam(required = false) Long amount,
            @RequestParam(required = false) String orderInfo,
            @RequestParam(required = false) String orderType,
            @RequestParam(required = false) String transId,
            @RequestParam(required = false) Integer resultCode,
            @RequestParam(required = false) String message,
            @RequestParam(required = false) String payType,
            @RequestParam(required = false) String responseTime,
            @RequestParam(required = false) String extraData,
            @RequestParam(required = false) String signature,
            Model model,
            HttpSession session
    ) {
        System.out.println("======= MOMO PAYMENT RESULT RECEIVED =======");
        System.out.println("orderId: " + orderId);
        System.out.println("requestId: " + requestId);
        System.out.println("amount: " + amount);
        System.out.println("resultCode: " + resultCode);
        System.out.println("message: " + message);
        System.out.println("transId: " + transId);
        System.out.println("payType: " + payType);
        System.out.println("responseTime: " + responseTime);
        
        // Check if payment was successful
        boolean success = resultCode != null && resultCode == 0;
        System.out.println("Payment success: " + success);
        
        // Add payment result to model
        model.addAttribute("success", success);
        model.addAttribute("orderId", orderId);
        model.addAttribute("amount", amount);
        model.addAttribute("message", message);
        
        if (success) {
            // Payment successful
            System.out.println("======= MOMO PAYMENT SUCCESSFUL =======");
            
            try {
                // Get order data from session
                @SuppressWarnings("unchecked")
                Map<String, Object> orderData = (Map<String, Object>) session.getAttribute("pendingOrderData");
                
                if (orderData != null) {
                    // Set payment_id to 3 (MOMO)
                    orderData.put("payment_id", 3);
                    
                    // Set payment_status to true for online payments
                    orderData.put("payment_status", true);
                    
                    // Add transaction information from MOMO
                    orderData.put("momo_TransactionId", transId);
                    orderData.put("momo_OrderId", orderId);
                    orderData.put("momo_PayType", payType);
                    orderData.put("momo_ResponseTime", responseTime);
                    
                    // Create headers
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.APPLICATION_JSON);
                    
                    // Create request entity with orderData
                    HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(orderData, headers);
                    
                    // Make API call to submit order
                    ResponseEntity<Map> response = restTemplate.postForEntity(
                            "http://localhost:8080/api/handle/submit", 
                            requestEntity, 
                            Map.class);
                    
                    // Check if API call was successful
                    if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                        Map<String, Object> responseBody = response.getBody();
                        if (Boolean.TRUE.equals(responseBody.get("success"))) {
                            // Get the order ID from the response
                            Object apiOrderId = responseBody.get("orderId");
                            if (apiOrderId != null) {
                                // Use the order ID from the API response instead of MOMO's orderId
                                System.out.println("Order successfully submitted with ID: " + apiOrderId);
                                
                                // Clear the pending order data from session
                                session.removeAttribute("pendingOrderData");
                                
                                // Redirect to order confirmation page with the order ID from API
                                return "redirect:/order/confirmation/" + apiOrderId;
                            }
                        } else {
                            System.err.println("API returned success=false: " + responseBody.get("message"));
                        }
                    } else {
                        System.err.println("Failed to submit order to API: " + response.getStatusCode());
                    }
                } else {
                    System.err.println("No pending order data found in session");
                }
            } catch (Exception e) {
                System.err.println("Error submitting order to API: " + e.getMessage());
                e.printStackTrace();
            }
            
            // If we reach here, something went wrong with the API call
            // Show the payment success page with the transaction details
            return "client/payment/payment-success";
        } else {
            // Payment failed
            System.out.println("======= MOMO PAYMENT FAILED =======");
            return "client/payment/payment-failed";
        }
    }
} 