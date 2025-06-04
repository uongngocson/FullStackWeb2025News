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
import java.util.TimeZone;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpServletRequest;
import local.example.demo.config.PayConfig;

@Controller
@RequestMapping("/api/payment")
public class PayController {
    @GetMapping("/create_payment")
    public String createPayment(@RequestParam(defaultValue = "0") long amount) throws UnsupportedEncodingException {

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
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", "orther");
        vnp_Params.put("vnp_ReturnUrl", PayConfig.vnp_ReturnUrl);
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
    }
    
    @GetMapping("/vnpay/payment-result")
    public String paymentResult(HttpServletRequest request, Model model) {
        Map<String, String> vnp_Params = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            if (paramValue != null && paramValue.length() > 0) {
                vnp_Params.put(paramName, paramValue);
            }
        }
        
        // Remove vnp_SecureHash to validate hash
        if (vnp_Params.containsKey("vnp_SecureHash")) {
            String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
            vnp_Params.remove("vnp_SecureHash");
            
            // Remove vnp_SecureHashType if present
            if (vnp_Params.containsKey("vnp_SecureHashType")) {
                vnp_Params.remove("vnp_SecureHashType");
            }
            
            // Check if the hash is valid
            String signValue = PayConfig.hashAllFields(vnp_Params);
            
            // Add data to model for display
            model.addAttribute("txnRef", vnp_Params.get("vnp_TxnRef"));
            model.addAttribute("amount", String.format("%,.2f", Double.parseDouble(vnp_Params.get("vnp_Amount"))/100));
            model.addAttribute("orderInfo", vnp_Params.get("vnp_OrderInfo"));
            model.addAttribute("responseCode", vnp_Params.get("vnp_ResponseCode"));
            model.addAttribute("transactionNo", vnp_Params.get("vnp_TransactionNo"));
            model.addAttribute("bankCode", vnp_Params.get("vnp_BankCode"));
            model.addAttribute("payDate", vnp_Params.get("vnp_PayDate"));
            
            // Check the response code - 00 means success
            boolean paymentSuccess = "00".equals(vnp_Params.get("vnp_ResponseCode"));
            model.addAttribute("paymentSuccess", paymentSuccess);
            
            // Hash validation result
            boolean validSignature = signValue.equals(vnp_SecureHash);
            model.addAttribute("validSignature", validSignature);
            
            if (paymentSuccess && validSignature) {
                // Payment success and valid signature
                return "client/payment/payment-success";
            } else if (!paymentSuccess && validSignature) {
                // Payment failed but valid signature
                return "client/payment/payment-failed";
            } else {
                // Invalid signature - potential security issue
                return "client/payment/payment-error";
            }
        } else {
            // Missing hash - potential security issue
            model.addAttribute("errorMessage", "Invalid payment data");
            return "client/payment/payment-error";
        }
    }
}
