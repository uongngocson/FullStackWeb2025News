package local.example.demo.controller.client;

import java.math.BigDecimal;
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
    private final ProductVariantService productVariantService ;

    // Helper method to get current customer from session
    private Customer getCurrentCustomer(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("customerId") != null) {
            Customer customer = new Customer();
            customer.setCustomerId((Integer) session.getAttribute("customerId"));
            return customer;
        }
        return null; // Hoặc xử lý trường hợp chưa đăng nhập
    }

    @GetMapping("profile")
    public String getProfilePage() {
        return "client/user/profile";
    }

    @GetMapping("cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            // Xử lý khi người dùng chưa đăng nhập, ví dụ chuyển hướng đến trang login
            return "redirect:/login";
        }

        Cart cart = customerService.getCartByCustomer(currentCustomer); 
        List<CartDetail> cartDetails = (cart != null && cart.getCartDetails() != null) ? cart.getCartDetails() : new ArrayList<>();
        BigDecimal totalPrice = BigDecimal.ZERO;

        for (CartDetail cd : cartDetails) {
            // Đảm bảo productVariant và product không null trước khi truy cập
            if (cd.getProductVariant() != null && cd.getProductVariant().getProduct() != null) {
                BigDecimal price = cd.getProductVariant().getProduct().getPrice(); // Lấy giá từ Product
                int quantity = cd.getQuantity();
                if (price != null) {
                    totalPrice = totalPrice.add(price.multiply(BigDecimal.valueOf(quantity)));
                }
            }
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        // model.addAttribute("cartItemCount", cartDetailService.countItemsInCart(cart)); // Thêm số lượng item
        return "client/user/cart";
    }


    @GetMapping("order")
    public String showOrderPage(
            @RequestParam(value = "variantId", required = false) Integer variantId,
            @RequestParam(value = "quantity", required = false) Integer quantity,
            @RequestParam(value = "variantIds", required = false) List<Integer> variantIds,
            @RequestParam(value = "quantities", required = false) List<Integer> quantities,
            Model model, HttpServletRequest request // Thêm HttpServletRequest
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

        // Lấy thông tin khách hàng và địa chỉ (ví dụ)
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer != null) {
             // Lấy thông tin chi tiết của customer từ DB nếu cần
             Customer customerDetails = customerService.findCustomerById(currentCustomer.getCustomerId());
             model.addAttribute("customer", customerDetails);
             // Lấy danh sách địa chỉ của khách hàng
             // model.addAttribute("addresses", addressService.getAddressesByCustomer(currentCustomer));
        } else {
             return "redirect:/login"; // Chuyển hướng nếu chưa đăng nhập
        }


        model.addAttribute("items", items);
        // Tính tổng tiền cho trang order (nếu cần)
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItemDTO item : items) {
             if (item.getVariant() != null && item.getVariant().getProduct() != null && item.getVariant().getProduct().getPrice() != null) {
                 orderTotal = orderTotal.add(item.getVariant().getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
             }
        }
        model.addAttribute("orderTotal", orderTotal);

        return "client/user/order";
    }



}
