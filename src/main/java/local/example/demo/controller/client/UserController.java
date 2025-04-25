package local.example.demo.controller.client;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.AddressRepository;
import local.example.demo.repository.CartRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.service.ProductVariantService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Address;
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
    @Autowired
    private final CustomerRepository customerRepository ;
    private final AddressRepository addressRepository ;
    private final CartRepository cartRepository;
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
    
    @PostMapping("/product-variant/add-to-cart")
    public String addToCart(@RequestParam("productVariantId") Integer variantId,
                            @RequestParam("quantity") Integer quantity,
                            HttpServletRequest request) {

        Customer customer = getCurrentCustomer(request);
        if (customer == null) {
            return "redirect:/login";
        }

        ProductVariant variant = productVariantService.findById(variantId);
        if (variant == null) {
            return "redirect:/error";
        }

        customerService.addToCart(customer, variant, quantity);

        return "redirect:/user/cart"; // hoặc redirect:/product/detail?id=... nếu muốn quay lại
    }
    @GetMapping("order")
    public String showOrderPage(
            @RequestParam(value = "variantId") Integer variantId,
            @RequestParam(value = "quantity") Integer quantity,
            Model model, HttpServletRequest request
    ) {
        List<OrderItemDTO> items = new ArrayList<>();

        ProductVariant variant = productVariantService.findById(variantId);
        if (variant != null && quantity > 0) {
            items.add(new OrderItemDTO(variant, quantity));
        } else {
            return "redirect:/"; // Redirect về trang chủ nếu thiếu thông tin
        }

        return prepareOrderPage(model, request, items);
    }
    @PostMapping("order")
    public String showOrderPagePost(
            @RequestParam("variantIds") List<Integer> variantIds,
            @RequestParam("quantities") List<Integer> quantities,
            Model model, HttpServletRequest request
    ) {
        List<OrderItemDTO> items = new ArrayList<>();

        if (variantIds.size() == quantities.size()) {
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

        if (items.isEmpty()) {
            return "redirect:/user/cart";
        }
        
        return prepareOrderPage(model, request, items);
    }
    private String prepareOrderPage(Model model, HttpServletRequest request, List<OrderItemDTO> items) {
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            return "redirect:/login";
        }
    
        Customer customerDetails = customerService.findCustomerById(currentCustomer.getCustomerId());
        model.addAttribute("customer", customerDetails);
        model.addAttribute("items", items);
    
        // Tính tổng tiền
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItemDTO item : items) {
            if (item.getVariant() != null && item.getVariant().getProduct().getPrice() != null) {
                orderTotal = orderTotal.add(item.getVariant().getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }
    
        model.addAttribute("orderTotal", orderTotal);
        return "client/user/order";
    }
    @PostMapping("submit")
    public String submitOrder(
        HttpServletRequest request,
        @RequestParam String firstName,
        @RequestParam String lastName,
        @RequestParam String email,
        @RequestParam String phone,
        @RequestParam String street,
        @RequestParam(required = false) String city,
        @RequestParam(required = false) String district,
        @RequestParam(required = false) String country,
        @RequestParam String paymentMethod,
        @RequestParam List<Integer> variantIds,
        @RequestParam List<Integer> quantities,
        @RequestParam BigDecimal totalPrice
) {
    Customer customer = getCurrentCustomer(request);
    if (customer == null) return "redirect:/login";
    // Lưu địa chỉ mới
    Address address = new Address();
    address.setStreet(street);
    address.setCity(city);
    address.setDistrict(district);
    address.setCustomer(customer);
    addressRepository.save(address);

    // Kiểm tra xem đơn hàng là từ giỏ hàng hay không
    Cart cart = cartRepository.findByCustomer(customer);
    boolean isFromCart = isFromCart(cart.getCartDetails(), variantIds, quantities);

    if ("cod".equals(paymentMethod)) {
        // Đơn từ giỏ → xóa cart
        if (isFromCart) {
            cart.getCartDetails().clear();
            cartRepository.save(cart);
            request.getSession().setAttribute("successMessage", "Đặt hàng thành công từ giỏ hàng!");
        } else {
            request.getSession().setAttribute("successMessage", "Đặt hàng thành công!");
        }
        return "redirect:/orderSuccess";
    } else if ("online".equals(paymentMethod)) {
        // Chuyển hướng sang cổng thanh toán
        return "redirect:/api/payment/create_payment?amount=" + totalPrice.longValue();
    }

    return "client/user/order";
}
private boolean isFromCart(List<CartDetail> cartDetails, List<Integer> variantIds, List<Integer> quantities) {
    if (cartDetails.size() != variantIds.size()) return false;

    for (int i = 0; i < variantIds.size(); i++) {
        final Integer variantId = variantIds.get(i);
        final Integer quantity = quantities.get(i);

        boolean matched = cartDetails.stream().anyMatch(cd ->
            cd.getProductVariant().getProductVariantId().equals(variantId) &&
            cd.getQuantity().equals(quantity)
        );

        if (!matched) return false;
    }
    return true;
}

}   
