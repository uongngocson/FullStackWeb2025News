package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.service.ProductVariantService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/product-variant/")
public class ProductVariantController {
    private final ProductVariantService productVariantService;

    @PostMapping("/add-to-cart/{productVariantId}")
    public String addToCart(@PathVariable("productVariantId") Integer productVariantId, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            productVariantService.handleAddToCart((String) session.getAttribute("email"), productVariantId);
        }

        return "redirect:/user/cart";
    }
    
}
