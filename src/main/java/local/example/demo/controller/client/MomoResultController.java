package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/order")
public class MomoResultController {

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
            Model model
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
            System.out.println("Redirecting to order confirmation: /order/confirmation/" + orderId);
            return "redirect:/order/confirmation/" + orderId;
        } else {
            // Payment failed
            System.out.println("======= MOMO PAYMENT FAILED =======");
            System.out.println("Redirecting to home with error: /?payment_error=true");
            return "redirect:/?payment_error=true";
        }
    }
} 