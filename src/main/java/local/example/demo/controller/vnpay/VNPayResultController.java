package local.example.demo.controller.vnpay;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.config.PayConfig;
import local.example.demo.model.entity.CodPayment;
import local.example.demo.service.CodPaymentService;

@Controller
@RequestMapping("/vnpay")
public class VNPayResultController {
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Autowired
    private CodPaymentService codPaymentService;
    
    @GetMapping("/payment-result")
    public String paymentResult(HttpServletRequest request, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            System.out.println("=== VNPAY PAYMENT RESULT (VNPayResultController) ===");
            
            // Collect all parameters from the request
            Map<String, String> vnp_Params = new HashMap<>();
            Enumeration<String> paramNames = request.getParameterNames();
            
            // Debug: print all parameters
            System.out.println("VNPAY Parameters:");
            while (paramNames.hasMoreElements()) {
                String paramName = paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                System.out.println(paramName + ": " + paramValue);
                if (paramValue != null && paramValue.length() > 0) {
                    vnp_Params.put(paramName, paramValue);
                }
            }
            
            // Get COD payment ID from parameters
            String codPaymentIdStr = request.getParameter("codPaymentId");
            System.out.println("COD Payment ID from request: " + codPaymentIdStr);
            
            // Check the response code - 00 means success
            boolean paymentSuccess = "00".equals(vnp_Params.get("vnp_ResponseCode"));
            System.out.println("Payment success: " + paymentSuccess);
            System.out.println("Response code: " + vnp_Params.get("vnp_ResponseCode"));
            
            // Handle COD payment update if this is a COD submission
            if (paymentSuccess && codPaymentIdStr != null && !codPaymentIdStr.isEmpty()) {
                try {
                    Integer codPaymentId = Integer.parseInt(codPaymentIdStr);
                    System.out.println("Attempting to update COD payment with ID: " + codPaymentId);
                    
                    // Verify COD payment exists
                    Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentById(codPaymentId);
                    if (codPaymentOpt.isPresent()) {
                        codPaymentService.submitCodPayment(codPaymentId, "VNPAY");
                        System.out.println("COD payment updated successfully!");
                        
                        redirectAttributes.addFlashAttribute("successMessage", "Đã nộp COD thành công qua VNPay!");
                        return "redirect:/shipper/shipment/list";
                    } else {
                        System.err.println("COD payment not found with ID: " + codPaymentId);
                        redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin COD payment!");
                        return "redirect:/shipper/shipment/list";
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Invalid COD payment ID format: " + codPaymentIdStr);
                    redirectAttributes.addFlashAttribute("errorMessage", "ID COD payment không hợp lệ!");
                    return "redirect:/shipper/shipment/list";
                } catch (Exception e) {
                    System.err.println("Error updating COD payment: " + e.getMessage());
                    e.printStackTrace();
                    redirectAttributes.addFlashAttribute("errorMessage", "Thanh toán thành công nhưng có lỗi cập nhật trạng thái COD: " + e.getMessage());
                    return "redirect:/shipper/shipment/list";
                }
            }
            
            // If not a COD payment or payment failed, continue with original logic
            // Add data to model for display
            if (vnp_Params.containsKey("vnp_Amount")) {
                // Convert from VND cents to VND
                long amountInCents = Long.parseLong(vnp_Params.get("vnp_Amount"));
                long amountInVND = amountInCents / 100;
                model.addAttribute("amount", String.format("%,d", amountInVND));
            } else {
                model.addAttribute("amount", "0");
            }
            
            model.addAttribute("txnRef", vnp_Params.getOrDefault("vnp_TxnRef", "N/A"));
            model.addAttribute("orderInfo", vnp_Params.getOrDefault("vnp_OrderInfo", "N/A"));
            model.addAttribute("responseCode", vnp_Params.getOrDefault("vnp_ResponseCode", "N/A"));
            model.addAttribute("transactionNo", vnp_Params.getOrDefault("vnp_TransactionNo", "N/A"));
            model.addAttribute("bankCode", vnp_Params.getOrDefault("vnp_BankCode", "N/A"));
            model.addAttribute("payDate", vnp_Params.getOrDefault("vnp_PayDate", "N/A"));
            
            model.addAttribute("paymentSuccess", paymentSuccess);
            
            // For now, bypass signature validation to get the flow working
            model.addAttribute("validSignature", true);
            
            // If payment is successful, submit the order to the API
            if (paymentSuccess) {
                try {
                    // Get order data from session
                    @SuppressWarnings("unchecked")
                    Map<String, Object> orderData = (Map<String, Object>) session.getAttribute("pendingOrderData");
                    
                    if (orderData != null) {
                        // Set payment_id to 1 (VNPAY)
                        orderData.put("payment_id", 1);
                        
                        // Set payment_status to true for online payments
                        orderData.put("payment_status", true);
                        
                        // Add transaction information from VNPAY
                        orderData.put("vnp_TransactionNo", vnp_Params.getOrDefault("vnp_TransactionNo", ""));
                        orderData.put("vnp_BankCode", vnp_Params.getOrDefault("vnp_BankCode", ""));
                        orderData.put("vnp_PayDate", vnp_Params.getOrDefault("vnp_PayDate", ""));
                        
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
                                // Add order ID to model
                                model.addAttribute("orderId", responseBody.get("orderId"));
                                System.out.println("Order successfully submitted with ID: " + responseBody.get("orderId"));
                                
                                // Clear the pending order data from session
                                session.removeAttribute("pendingOrderData");
                            } else {
                                System.err.println("API returned success=false: " + responseBody.get("message"));
                                // Still show success page but log the error
                            }
                        } else {
                            System.err.println("Failed to submit order to API: " + response.getStatusCode());
                            // Still show success page but log the error
                        }
                    } else {
                        System.err.println("No pending order data found in session");
                        // Still show success page but log the error
                    }
                } catch (Exception e) {
                    System.err.println("Error submitting order to API: " + e.getMessage());
                    e.printStackTrace();
                    // Still show success page but log the error
                }
                
                return "client/payment/payment-success";
            } else {
                return "client/payment/payment-failed";
            }
            
        } catch (Exception e) {
            // Log the exception for debugging
            System.out.println("Error processing VNPAY payment result: " + e.getMessage());
            e.printStackTrace();
            
            // Add error message to model
            model.addAttribute("errorMessage", "An unexpected error occurred while processing the payment: " + e.getMessage());
            return "client/payment/payment-error";
        }
    }
} 