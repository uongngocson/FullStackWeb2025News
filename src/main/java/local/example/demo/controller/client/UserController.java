package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user/")
public class UserController {

    @GetMapping("profile")
    public String getProfilePage() {
        return "client/user/profile";
    }
    @GetMapping("cart")
    public String getCartPage() {
        return "client/user/cart";
    }

    @GetMapping("order")
    public String getOrderPage() {
        return "client/user/order";
    }

}
