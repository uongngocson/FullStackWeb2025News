package local.example.demo.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.service.CustomerService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user/")
public class UserController {
    private final CustomerService customerService;


    @GetMapping("profile")
    public String getProfilePage() {
        return "client/user/profile";
    }
    @GetMapping("cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        Customer currentCustomer = new Customer();
        HttpSession session = request.getSession();
        currentCustomer.setCustomerId((Integer) session.getAttribute("customerId"));
        Cart cart = this.customerService.getCartByCustomer(currentCustomer);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>():cart.getCartDetails();
        Double totalPrice = 0.0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getProductVariant().getProduct().getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/user/cart";
    }

    @GetMapping("order")
    public String getOrderPage() {
        return "client/user/order";
    }

}
