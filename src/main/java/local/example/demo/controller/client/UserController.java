package local.example.demo.controller.client;

import java.util.ArrayList;
import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.ProductVariantService;

@Controller
@RequestMapping("/user/")
public class UserController {

    UserController(ProductVariantService productVariantService) {
        this.productVariantService = productVariantService;
    }

    @GetMapping("profile")
    public String getProfilePage() {
        return "client/user/profile";
    }
    @GetMapping("cart")
    public String getCartPage() {
        return "client/user/cart";
    }
    private final ProductVariantService productVariantService ;
    @GetMapping("order")
    public String showOrderPage(
            @RequestParam(value = "variantId", required = false) Integer variantId,
            @RequestParam(value = "quantity", required = false) Integer quantity,
            @RequestParam(value = "variantIds", required = false) List<Integer> variantIds,
            @RequestParam(value = "quantities", required = false) List<Integer> quantities,
            Model model
    ) {
        List<OrderItemDTO> items = new ArrayList<>();

        //Trường hợp: Đặt 1 sản phẩm từ trang detail
        if (variantId != null && quantity != null) {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant != null) {
                items.add(new OrderItemDTO(variant, quantity));
            }
        }

        //Trường hợp: Giỏ hàng có nhiều sản phẩm
        if (variantIds != null && quantities != null && variantIds.size() == quantities.size()) {
            for (int i = 0; i < variantIds.size(); i++) {
                Integer vId = variantIds.get(i);
                Integer qty = quantities.get(i);

                if (vId != null && qty != null && qty > 0) {
                    ProductVariant variant = productVariantService.findById(vId);
                    if (variant != null) {
                        items.add(new OrderItemDTO(variant, qty));
                    }
                }
            }
        }
        System.out.println("variantId = " + variantId);
        System.out.println("quantity = " + quantity);

        model.addAttribute("items", items);
        return "client/user/order";
    }



}
