package local.example.demo.controller.client;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Arrays;
import java.util.HashMap;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.CartDetailService;
import local.example.demo.service.ProductDiscount;

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
    private final ProductVariantService productVariantService;
    private final CartDetailService cartDetailService;
    private final ProductDiscount productDiscountService;
    private final Gson gson = new Gson();

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

    @GetMapping("productfavriote")
    public String getProductFavriotePage() {
        return "client/layout/productfavriote";
    }

    // productfavriote

    @GetMapping("cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            // Xử lý khi người dùng chưa đăng nhập, ví dụ chuyển hướng đến trang login
            return "redirect:/login";
        }

        Cart cart = customerService.getCartByCustomer(currentCustomer);
        List<CartDetail> cartDetails = (cart != null && cart.getCartDetails() != null) ? cart.getCartDetails()
                : new ArrayList<>();
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

        // Get product discount data for all products in the cart
        try {
            // Use customer ID from session, default to 1017 if not available
            int customerId = currentCustomer != null ? currentCustomer.getCustomerId() : 1017;

            // Create a map to store discounts by product ID
            Map<Integer, List<Map<String, Object>>> allProductDiscounts = new HashMap<>();

            // Get unique product IDs from cart
            List<Integer> productIds = new ArrayList<>();
            for (CartDetail cd : cartDetails) {
                if (cd.getProductVariant() != null && cd.getProductVariant().getProduct() != null) {
                    Integer productId = cd.getProductVariant().getProduct().getProductId();
                    if (productId != null && !productIds.contains(productId)) {
                        productIds.add(productId);
                    }
                }
            }

            System.out.println("Fetching discounts for " + productIds.size() + " unique products in cart");

            // Fetch discounts for each product
            for (Integer productId : productIds) {
                List<Map<String, Object>> productDiscounts = productDiscountService.getVariantsWithAccountsByProductId(
                        productId, customerId);

                if (productDiscounts != null && !productDiscounts.isEmpty()) {
                    allProductDiscounts.put(productId, productDiscounts);
                    System.out.println("Found " + productDiscounts.size() + " discounts for product ID " + productId);
                }
            }

            // Convert the map to JSON and add to model
            String allDiscountsJson = gson.toJson(allProductDiscounts);
            System.out.println("Adding all product discounts to model: "
                    + allDiscountsJson.substring(0, Math.min(100, allDiscountsJson.length())) + "...");

            model.addAttribute("allProductDiscounts", allDiscountsJson);

            // Keep the original attribute for backward compatibility
            if (!productIds.isEmpty()) {
                List<Map<String, Object>> firstProductDiscounts = productDiscountService
                        .getVariantsWithAccountsByProductId(
                                productIds.get(0), customerId);
                String productDiscountsJson = gson.toJson(firstProductDiscounts);
                model.addAttribute("productDiscounts", productDiscountsJson);
            } else {
                model.addAttribute("productDiscounts", "[]");
            }

        } catch (Exception e) {
            System.err.println("Error fetching product discounts: " + e.getMessage());
            e.printStackTrace();
            // Add empty arrays to model to avoid null
            model.addAttribute("productDiscounts", "[]");
            model.addAttribute("allProductDiscounts", "{}");
            System.out.println("Added empty collections for product discounts due to error: " + e.getMessage());
        }

        // Add cart item count to session
        HttpSession session = request.getSession();
        session.setAttribute("cartItemCount", cartDetails.size());

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

        // Trường hợp: Đặt 1 sản phẩm từ trang detail
        if (variantId != null && quantity != null) {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant != null) {
                items.add(new OrderItemDTO(variant, quantity));
            }
        }

        // Trường hợp: Giỏ hàng có nhiều sản phẩm
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
            // model.addAttribute("addresses",
            // addressService.getAddressesByCustomer(currentCustomer));
        } else {
            return "redirect:/login"; // Chuyển hướng nếu chưa đăng nhập
        }

        model.addAttribute("items", items);
        // Tính tổng tiền cho trang order (nếu cần)
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItemDTO item : items) {
            if (item.getVariant() != null && item.getVariant().getProduct() != null
                    && item.getVariant().getProduct().getPrice() != null) {
                orderTotal = orderTotal.add(
                        item.getVariant().getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }
        model.addAttribute("orderTotal", orderTotal);

        return "client/user/order";
    }

    // bản fix lại

    @GetMapping("orderfix")
    public String showOrderPageFix(
            @RequestParam(value = "variantId", required = false) Integer variantId,
            @RequestParam(value = "quantity", required = false) Integer quantity,
            @RequestParam(value = "variantIds", required = false) List<Integer> variantIds,
            @RequestParam(value = "quantities", required = false) List<Integer> quantities,
            Model model, HttpServletRequest request // Thêm HttpServletRequest
    ) {
        List<OrderItemDTO> items = new ArrayList<>();

        // Trường hợp: Đặt 1 sản phẩm từ trang detail
        if (variantId != null && quantity != null) {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant != null) {
                items.add(new OrderItemDTO(variant, quantity));
            }
        }

        // Trường hợp: Giỏ hàng có nhiều sản phẩm
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
            // model.addAttribute("addresses",
            // addressService.getAddressesByCustomer(currentCustomer));
        } else {
            return "redirect:/login"; // Chuyển hướng nếu chưa đăng nhập
        }

        model.addAttribute("items", items);
        // Tính tổng tiền cho trang order (nếu cần)
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItemDTO item : items) {
            if (item.getVariant() != null && item.getVariant().getProduct() != null
                    && item.getVariant().getProduct().getPrice() != null) {
                orderTotal = orderTotal.add(
                        item.getVariant().getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
            }
        }
        model.addAttribute("orderTotal", orderTotal);

        return "client/user/orderfix";
    }

    @PostMapping("checkout")
    public String processCheckout(@RequestParam("selectedItems") List<Integer> selectedCartDetailIds,
            Model model, HttpServletRequest request) {
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            return "redirect:/login";
        }

        List<CartDetail> selectedCartDetails = new ArrayList<>();
        List<Integer> variantIds = new ArrayList<>();
        List<Integer> quantities = new ArrayList<>();

        // Get selected cart details
        for (Integer cartDetailId : selectedCartDetailIds) {
            try {
                CartDetail cartDetail = cartDetailService.findById(cartDetailId);
                if (cartDetail != null) {
                    selectedCartDetails.add(cartDetail);
                    variantIds.add(cartDetail.getProductVariant().getProductVariantId());
                    quantities.add(cartDetail.getQuantity());
                }
            } catch (Exception e) {
                // Log error and continue
                System.err.println("Error finding cart detail with ID: " + cartDetailId);
            }
        }

        // Debug logging
        System.out.println("Selected Cart Detail IDs: " + selectedCartDetailIds);
        System.out.println("Variant IDs: " + variantIds);
        System.out.println("Quantities: " + quantities);

        // Redirect to the order page with the selected items
        StringBuilder redirectUrl = new StringBuilder("redirect:/user/order");

        // Add variantIds
        if (!variantIds.isEmpty()) {
            redirectUrl.append("?");
            for (int i = 0; i < variantIds.size(); i++) {
                if (i > 0) {
                    redirectUrl.append("&");
                }
                redirectUrl.append("variantIds=").append(variantIds.get(i));
            }

            // Add quantities
            for (int i = 0; i < quantities.size(); i++) {
                redirectUrl.append("&quantities=").append(quantities.get(i));
            }
        }

        System.out.println("Redirect URL: " + redirectUrl.toString());
        return redirectUrl.toString();
    }

    // New method that replaces the API approach with a server-side rendering
    // approach
    @GetMapping("product-discounts")
    public String getProductDiscountsPage(
            @RequestParam("productId") Integer productId,
            Model model, HttpServletRequest request) {

        try {
            // Get current customer ID from session
            Customer currentCustomer = getCurrentCustomer(request);
            int customerId = (currentCustomer != null) ? currentCustomer.getCustomerId() : 0;

            if (customerId == 0 || productId == null) {
                model.addAttribute("discounts", new ArrayList<>());
            } else {
                // Fetch discount information
                List<Map<String, Object>> discounts = productDiscountService
                        .getVariantsWithAccountsByProductId(productId, customerId);
                System.out.println("discounts = " + discounts);
                model.addAttribute("discounts", discounts);

                // Convert discounts to JSON for client-side convenience
                model.addAttribute("discountsJson", gson.toJson(discounts));
                System.out.println("discountsJson = " + gson.toJson(discounts));
            }

            // Return JSP view for the fragment
            return "client/user/fragments/product-discounts";

        } catch (Exception e) {
            System.err.println("Error fetching product discounts via page: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("discounts", new ArrayList<>());
            model.addAttribute("error", "Failed to fetch product discounts. Please try again.");
            return "client/user/fragments/product-discounts";
        }
    }

}
