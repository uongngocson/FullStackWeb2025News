package local.example.demo.controller.vnpay;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TimeZone;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import local.example.demo.config.PayConfig;
import local.example.demo.model.entity.CodPayment;
import local.example.demo.service.CodPaymentService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/api/payment")
@RequiredArgsConstructor
public class PayController {
    
    private final CodPaymentService codPaymentService;
    
    @GetMapping("/create_payment")
    public String createPayment(
            @RequestParam(defaultValue = "0") long amount,
            @RequestParam(required = false) Integer codPaymentId,
            RedirectAttributes redirectAttributes) throws UnsupportedEncodingException {

        try {
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

            String vnp_TxnRef = PayConfig.getRandomNumber(8);
            // String vnp_IpAddr = PayConfig.getIpAddress(req);

            String vnp_TmnCode = PayConfig.vnp_TmnCode;
            // Convert to VNPay format (amount in cents)
            long vnpAmount = amount * 100;
            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", PayConfig.vnp_Version);
            vnp_Params.put("vnp_Command", PayConfig.vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(vnpAmount));
            vnp_Params.put("vnp_CurrCode", "VND");
            vnp_Params.put("vnp_BankCode", "NCB");
            vnp_Params.put("vnp_Locale", "vn");
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            
            String orderInfo = codPaymentId != null ? 
                "Nop COD:" + codPaymentId : 
                "Thanh toan don hang:" + vnp_TxnRef;
            vnp_Params.put("vnp_OrderInfo", orderInfo);
            vnp_Params.put("vnp_OrderType", "orther");
            
            // Create return URL with COD payment ID
            String returnUrl = PayConfig.vnp_ReturnUrl;
            if (codPaymentId != null) {
                returnUrl += "?codPaymentId=" + codPaymentId;
            }
            vnp_Params.put("vnp_ReturnUrl", returnUrl);
            vnp_Params.put("vnp_IpAddr", "127.0.0.1");

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    // Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = PayConfig.hmacSHA512(PayConfig.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = PayConfig.vnp_PayUrl + "?" + queryUrl;

            return "redirect:" + paymentUrl;
            
        } catch (Exception e) {
            System.err.println("Error creating VNPay payment: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo thanh toán VNPay!");
            return "redirect:/shipper/shipment/list";
        }
    }
    
    @GetMapping("/vnpay/payment-result")
    public String paymentResult(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
        System.out.println("=== VNPAY PAYMENT RESULT DEBUG ===");
        
        Map<String, String> vnp_Params = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        
        // Log all parameters
        System.out.println("All request parameters:");
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            System.out.println(paramName + " = " + paramValue);
            if (paramValue != null && paramValue.length() > 0) {
                vnp_Params.put(paramName, paramValue);
            }
        }
        
        // Get COD payment ID from parameters
        String codPaymentIdStr = request.getParameter("codPaymentId");
        System.out.println("COD Payment ID from request: " + codPaymentIdStr);
        
        // Remove vnp_SecureHash to validate hash
        if (vnp_Params.containsKey("vnp_SecureHash")) {
            String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
            vnp_Params.remove("vnp_SecureHash");
            
            // Remove vnp_SecureHashType if present
            if (vnp_Params.containsKey("vnp_SecureHashType")) {
                vnp_Params.remove("vnp_SecureHashType");
            }
            
            // Remove codPaymentId from vnp_Params for hash validation
            if (vnp_Params.containsKey("codPaymentId")) {
                vnp_Params.remove("codPaymentId");
            }
            
            // Check if the hash is valid
            String signValue = PayConfig.hashAllFields(vnp_Params);
            System.out.println("Generated signature: " + signValue);
            System.out.println("Received signature: " + vnp_SecureHash);
            
            // Check the response code - 00 means success
            boolean paymentSuccess = "00".equals(vnp_Params.get("vnp_ResponseCode"));
            boolean validSignature = signValue.equals(vnp_SecureHash);
            
            System.out.println("Payment success: " + paymentSuccess);
            System.out.println("Valid signature: " + validSignature);
            System.out.println("Response code: " + vnp_Params.get("vnp_ResponseCode"));
            
            if (paymentSuccess && validSignature) {
                // Payment success and valid signature
                System.out.println("Payment successful and signature valid");
                
                if (codPaymentIdStr != null && !codPaymentIdStr.isEmpty()) {
                    try {
                        Integer codPaymentId = Integer.parseInt(codPaymentIdStr);
                        System.out.println("Attempting to update COD payment with ID: " + codPaymentId);
                        
                        codPaymentService.submitCodPayment(codPaymentId, "VNPAY");
                        System.out.println("COD payment updated successfully!");
                        
                        redirectAttributes.addFlashAttribute("successMessage", "Đã nộp COD thành công qua VNPay!");
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
                    redirectAttributes.addFlashAttribute("successMessage", "Thanh toán VNPay thành công!");
                }
                return "redirect:/shipper/shipment/list";
            } else if (!paymentSuccess && validSignature) {
                // Payment failed but valid signature
                System.out.println("Payment failed but signature valid");
                redirectAttributes.addFlashAttribute("errorMessage", "Thanh toán VNPay thất bại!");
                return "redirect:/shipper/shipment/list";
            } else {
                // Invalid signature - potential security issue
                System.out.println("Invalid signature - security issue");
                redirectAttributes.addFlashAttribute("errorMessage", "Lỗi bảo mật trong thanh toán!");
                return "redirect:/shipper/shipment/list";
            }
        } else {
            // Missing hash - potential security issue
            System.out.println("Missing hash - security issue");
            redirectAttributes.addFlashAttribute("errorMessage", "Dữ liệu thanh toán không hợp lệ!");
            return "redirect:/shipper/shipment/list";
        }
    }
}
