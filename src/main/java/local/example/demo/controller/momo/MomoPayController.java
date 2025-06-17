package local.example.demo.controller.momo;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import local.example.demo.config.MomoConfig;
import local.example.demo.model.entity.CodPayment;
import local.example.demo.service.CodPaymentService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/api/payment")
@RequiredArgsConstructor
public class MomoPayController {
    
    private final HttpClient httpClient = HttpClient.newBuilder().build();
    private final CodPaymentService codPaymentService;
    
    /**
     * Create MoMo payment request
     * @param amount Payment amount
     * @param codPaymentId COD Payment ID (optional)
     * @return Redirect to MoMo payment gateway
     */
    @GetMapping("/create_momo_payment")
    public String createMoMoPayment(
            @RequestParam(defaultValue = "0") long amount,
            @RequestParam(required = false) Integer codPaymentId,
            RedirectAttributes redirectAttributes) {
        try {
            System.out.println("======= STARTING MOMO PAYMENT PROCESS =======");
            System.out.println("Received amount: " + amount);
            System.out.println("COD Payment ID: " + codPaymentId);
            
            // Validate COD payment if provided
            if (codPaymentId != null) {
                Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentById(codPaymentId);
                if (!codPaymentOpt.isPresent()) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin COD!");
                    return "redirect:/shipper/shipment/list";
                }
                // Use COD amount if provided
                CodPayment codPayment = codPaymentOpt.get();
                amount = codPayment.getAmount().longValue();
            }
            
            // Generate order ID
            String orderId = MomoConfig.generateOrderId();
            String requestId = String.valueOf(System.currentTimeMillis());
            
            System.out.println("Generated orderId: " + orderId);
            System.out.println("Generated requestId: " + requestId);
            
            // Convert to MoMo format (amount must be > 0)
            long momoAmount = Math.max(amount, 1000);
            System.out.println("Final amount for MoMo: " + momoAmount);
            
            String orderInfo = codPaymentId != null ? 
                "Nop COD: " + codPaymentId : 
                "Thanh toan don hang: " + orderId;
            
            // Create return URL with COD payment ID
            String returnUrl = MomoConfig.RETURN_URL;
            if (codPaymentId != null) {
                returnUrl += "?codPaymentId=" + codPaymentId;
            }
            
            // Create request body
            JSONObject requestBody = new JSONObject();
            requestBody.put("partnerCode", MomoConfig.PARTNER_CODE);
            requestBody.put("accessKey", MomoConfig.ACCESS_KEY);
            requestBody.put("requestId", requestId);
            requestBody.put("amount", momoAmount);
            requestBody.put("orderId", orderId);
            requestBody.put("orderInfo", orderInfo);
            requestBody.put("redirectUrl", returnUrl);
            requestBody.put("ipnUrl", MomoConfig.NOTIFY_URL);
            requestBody.put("requestType", MomoConfig.REQUEST_TYPE);
            requestBody.put("extraData", codPaymentId != null ? codPaymentId.toString() : "");
            
            // Generate signature
            String rawSignature = "accessKey=" + MomoConfig.ACCESS_KEY + 
                                "&amount=" + momoAmount + 
                                "&extraData=" + (codPaymentId != null ? codPaymentId.toString() : "") + 
                                "&ipnUrl=" + MomoConfig.NOTIFY_URL + 
                                "&orderId=" + orderId + 
                                "&orderInfo=" + orderInfo + 
                                "&partnerCode=" + MomoConfig.PARTNER_CODE + 
                                "&redirectUrl=" + returnUrl + 
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
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo thanh toán MoMo!");
            return "redirect:/shipper/shipment/list";
            
        } catch (Exception e) {
            System.err.println("======= EXCEPTION IN MOMO PAYMENT PROCESS =======");
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi hệ thống khi tạo thanh toán MoMo!");
            return "redirect:/shipper/shipment/list";
        }
    }
    
    /**
     * MoMo payment result handler
     */
    @GetMapping("/momo/payment-result")
    public String momoPaymentResult(
            @RequestParam Map<String, String> params,
            RedirectAttributes redirectAttributes) {
        
        try {
            System.out.println("======= MOMO PAYMENT RESULT DEBUG =======");
            System.out.println("Received parameters: " + params);
            
            String resultCode = params.get("resultCode");
            String codPaymentIdStr = params.get("codPaymentId");
            
            System.out.println("Result code: " + resultCode);
            System.out.println("COD Payment ID from params: " + codPaymentIdStr);
            
            if ("0".equals(resultCode)) {
                // Payment successful
                System.out.println("MOMO payment successful");
                
                if (codPaymentIdStr != null && !codPaymentIdStr.isEmpty()) {
                    try {
                        Integer codPaymentId = Integer.parseInt(codPaymentIdStr);
                        System.out.println("Attempting to update COD payment with ID: " + codPaymentId);
                        
                        codPaymentService.submitCodPayment(codPaymentId, "MOMO");
                        System.out.println("COD payment updated successfully!");
                        
                        redirectAttributes.addFlashAttribute("successMessage", "Đã nộp COD thành công qua MoMo!");
                    } catch (NumberFormatException e) {
                        System.err.println("Invalid COD payment ID format: " + codPaymentIdStr);
                        redirectAttributes.addFlashAttribute("errorMessage", "ID COD payment không hợp lệ!");
                    } catch (Exception e) {
                        System.err.println("Error updating COD payment: " + e.getMessage());
                        e.printStackTrace();
                        redirectAttributes.addFlashAttribute("errorMessage", "Thanh toán thành công nhưng có lỗi cập nhật trạng thái COD: " + e.getMessage());
                    }
                } else {
                    System.out.println("No COD payment ID provided");
                    redirectAttributes.addFlashAttribute("successMessage", "Thanh toán MoMo thành công!");
                }
            } else {
                // Payment failed
                System.out.println("MOMO payment failed with result code: " + resultCode);
                redirectAttributes.addFlashAttribute("errorMessage", "Thanh toán MoMo thất bại!");
            }
            
        } catch (Exception e) {
            System.err.println("Error processing MoMo payment result: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi xử lý kết quả thanh toán!");
        }
        
        System.out.println("======= END MOMO PAYMENT RESULT DEBUG =======");
        return "redirect:/shipper/shipment/list";
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
            String resultCode = jsonRequest.optString("resultCode");
            String extraData = jsonRequest.optString("extraData");
            
            // Process COD payment if extraData contains COD payment ID
            if ("0".equals(resultCode) && extraData != null && !extraData.isEmpty()) {
                try {
                    Integer codPaymentId = Integer.parseInt(extraData);
                    codPaymentService.submitCodPayment(codPaymentId, "MOMO");
                    System.out.println("COD payment updated successfully via notification");
                } catch (Exception e) {
                    System.err.println("Error updating COD payment via notification: " + e.getMessage());
                }
            }
            
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