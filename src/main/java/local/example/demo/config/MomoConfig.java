package local.example.demo.config;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Formatter;

public class MomoConfig {
    // Sandbox environment endpoint
    public static final String MOMO_ENDPOINT = "https://test-payment.momo.vn/v2/gateway/api/create";
    
    // Test account credentials
    public static final String PARTNER_CODE = "";
    public static final String ACCESS_KEY = "";
    public static final String SECRET_KEY = "";
    
    // Return URLs
    public static final String RETURN_URL = "http://localhost:8080/order/momo-result";
    public static final String NOTIFY_URL = "http://localhost:8080/api/payment/momo-notify";
    
    // Payment type (standard wallet payment)
    public static final String REQUEST_TYPE = "captureWallet";
    
    /**
     * Generate a random order ID
     * @return Random string of 10 characters
     */
    public static String generateOrderId() {
        Random random = new Random();
        return String.valueOf(100000 + random.nextInt(900000)) + random.nextInt(10000);
    }
    
    /**
     * Generate HMAC SHA256 signature
     * @param data Data to sign
     * @return Hex encoded signature
     */
    public static String signHmacSHA256(String data) {
        try {
            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            sha256_HMAC.init(secret_key);
            
            return bytesToHex(sha256_HMAC.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            e.printStackTrace();
            return "";
        }
    }
    
    /**
     * Convert bytes to hexadecimal string
     * @param bytes Byte array
     * @return Hex string
     */
    private static String bytesToHex(byte[] bytes) {
        try (Formatter formatter = new Formatter()) {
            for (byte b : bytes) {
                formatter.format("%02x", b);
            }
            return formatter.toString();
        }
    }
} 