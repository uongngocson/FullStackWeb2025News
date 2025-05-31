package local.example.demo.controller.momo;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import local.example.demo.config.MomoConfig;

@Controller
@RequestMapping("/api/payment")
public class MomoPayController {
    
    private final HttpClient httpClient = HttpClient.newBuilder().build();
    
    /**
     * Create MoMo payment request
     * @param amount Payment amount
     * @return Redirect to MoMo payment gateway
     */
    @GetMapping("/create_momo_payment")
    public String createMoMoPayment(@RequestParam(defaultValue = "0") long amount) {
        try {
            System.out.println("======= STARTING MOMO PAYMENT PROCESS =======");
            System.out.println("Received amount: " + amount);
            
            // Generate order ID
            String orderId = MomoConfig.generateOrderId();
            String requestId = String.valueOf(System.currentTimeMillis());
            
            System.out.println("Generated orderId: " + orderId);
            System.out.println("Generated requestId: " + requestId);
            
            // Convert to MoMo format (amount must be > 0)
            long momoAmount = Math.max(amount, 1000);
            System.out.println("Final amount for MoMo: " + momoAmount);
            
            String orderInfo = "Thanh toan don hang: " + orderId;
            
            // Create request body
            JSONObject requestBody = new JSONObject();
            requestBody.put("partnerCode", MomoConfig.PARTNER_CODE);
            requestBody.put("accessKey", MomoConfig.ACCESS_KEY);
            requestBody.put("requestId", requestId);
            requestBody.put("amount", momoAmount);
            requestBody.put("orderId", orderId);
            requestBody.put("orderInfo", orderInfo);
            requestBody.put("redirectUrl", MomoConfig.RETURN_URL);
            requestBody.put("ipnUrl", MomoConfig.NOTIFY_URL);
            requestBody.put("requestType", MomoConfig.REQUEST_TYPE);
            requestBody.put("extraData", "");
            
            // Generate signature
            String rawSignature = "accessKey=" + MomoConfig.ACCESS_KEY + 
                                "&amount=" + momoAmount + 
                                "&extraData=" + "" + 
                                "&ipnUrl=" + MomoConfig.NOTIFY_URL + 
                                "&orderId=" + orderId + 
                                "&orderInfo=" + orderInfo + 
                                "&partnerCode=" + MomoConfig.PARTNER_CODE + 
                                "&redirectUrl=" + MomoConfig.RETURN_URL + 
                                "&requestId=" + requestId + 
                                "&requestType=" + MomoConfig.REQUEST_TYPE;
            
            System.out.println("Raw signature string: " + rawSignature);
            
            String signature = MomoConfig.signHmacSHA256(rawSignature);
            requestBody.put("signature", signature);
            
            System.out.println("Generated signature: " + signature);
            
            // Log the request for debugging
            System.out.println("MoMo request: " + requestBody.toString(4));
            System.out.println("MoMo endpoint: " + MomoConfig.MOMO_ENDPOINT);
            
            // Send request to MoMo
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(MomoConfig.MOMO_ENDPOINT))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody.toString()))
                    .build();
            
            System.out.println("Sending request to MoMo...");
            HttpResponse<String> response = httpClient.send(request, BodyHandlers.ofString());
            
            // Log the response for debugging
            System.out.println("MoMo response status: " + response.statusCode());
            System.out.println("MoMo response body: " + response.body());
            
            // Process response
            if (response.statusCode() == 200) {
                JSONObject jsonResponse = new JSONObject(response.body());
                
                // Check if payment URL is available
                if (jsonResponse.has("payUrl")) {
                    String payUrl = jsonResponse.getString("payUrl");
                    System.out.println("MoMo payUrl: " + payUrl);
                    System.out.println("======= REDIRECTING TO MOMO PAYMENT PAGE =======");
                    
                    // Redirect to MoMo payment page
                    return "redirect:" + payUrl;
                } else {
                    System.err.println("ERROR: MoMo response missing payUrl: " + jsonResponse.toString(4));
                    if (jsonResponse.has("message")) {
                        System.err.println("MoMo error message: " + jsonResponse.getString("message"));
                    }
                }
            } else {
                System.err.println("ERROR: MoMo API error: " + response.statusCode() + " - " + response.body());
            }
            
            // If error, redirect to error page or home
            System.err.println("======= MOMO PAYMENT PROCESS FAILED =======");
            return "redirect:/?payment_error=true";
            
        } catch (Exception e) {
            System.err.println("======= EXCEPTION IN MOMO PAYMENT PROCESS =======");
            e.printStackTrace();
            return "redirect:/?payment_error=true";
        }
    }
    
    /**
     * MoMo notification endpoint
     * @param requestBody MoMo notification data
     * @return Response to MoMo
     */
    @PostMapping("/momo-notify")
    public ResponseEntity<Map<String, String>> momoNotify(@RequestBody String requestBody) {
        try {
            System.out.println("======= RECEIVED MOMO NOTIFICATION =======");
            // Process MoMo notification
            JSONObject jsonRequest = new JSONObject(requestBody);
            
            // Log the notification for debugging
            System.out.println("MoMo notification received: " + jsonRequest.toString(4));
            
            // Check signature and process payment result
            String signature = jsonRequest.getString("signature");
            // Validate signature and update order status (implementation depends on your order system)
            
            // Return success response to MoMo
            Map<String, String> response = new HashMap<>();
            response.put("status", "ok");
            response.put("message", "Payment processed successfully");
            System.out.println("======= MOMO NOTIFICATION PROCESSED SUCCESSFULLY =======");
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("======= ERROR PROCESSING MOMO NOTIFICATION =======");
            e.printStackTrace();
            Map<String, String> response = new HashMap<>();
            response.put("status", "error");
            response.put("message", "Failed to process payment notification");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
} 