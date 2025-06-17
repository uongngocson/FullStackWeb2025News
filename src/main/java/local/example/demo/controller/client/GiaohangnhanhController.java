package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import local.example.demo.model.dto.GiaohangnhanhDTO;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.AddressService;
import local.example.demo.service.CartDetailService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.GiaohangnhanhService;
import local.example.demo.service.ProductDiscount;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.OrderService;
import local.example.demo.model.dto.OrderConfirmItemDTO;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class GiaohangnhanhController {
    
    @Autowired
    private GiaohangnhanhService giaohangnhanhService;
    
    @Autowired
    private ProductVariantService productVariantService;
    
    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private AddressService addressService;
    
    @Autowired
    private CartDetailService cartDetailService;
    
    @Autowired
    private ProductDiscount productDiscountService;
    
    @Autowired
    private Gson gson;
    
    @Autowired
    private OrderService orderService;
    
    /**
     * Setup model with GHN data for any checkout page
     * @param model Spring UI model
     */
    private void setupOrderPageModel(Model model) {
        try {
            // Lấy danh sách tỉnh/thành phố từ GHN API
            List<Map<String, Object>> provinces = giaohangnhanhService.getProvinces();
            
            // Chuyển đổi dữ liệu để sử dụng trong JSP
            List<GiaohangnhanhDTO> provinceList = GiaohangnhanhDTO.fromMapList(provinces);
            
            // Thêm dữ liệu vào model để JSP có thể truy cập
            model.addAttribute("provinces", provinceList);
            model.addAttribute("ghnToken", giaohangnhanhService.getGhnToken());
            model.addAttribute("shopId", giaohangnhanhService.getShopId());
            
            // Mặc định cài đặt gói hàng
            model.addAttribute("defaultPackage", GiaohangnhanhDTO.createDefaultPackage());
            
            System.out.println("Provinces loaded: " + provinceList.size());
        } catch (Exception e) {
            System.out.println("Error loading checkout page: " + e.getMessage());
            e.printStackTrace();
            
            // Add error message to model
            model.addAttribute("errorMessage", "Could not load shipping data. Please try again later.");
        }
    }
    
    /**
     * Helper method to get current customer from session
     */
    private Customer getCurrentCustomer(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("customerId") != null) {
            Customer customer = new Customer();
            customer.setCustomerId((Integer) session.getAttribute("customerId"));
            return customer;
        }
        return null;
    }
    
    /**
     * Get the first address for a customer
     * @param customerId Customer ID
     * @return First address or null if none exists
     */
    private Address getFirstCustomerAddress(Integer customerId) {
        List<Address> addresses = addressService.getAddressesForCustomer(customerId);
        if (addresses != null && !addresses.isEmpty()) {
            return addresses.get(0);
        }
        return null;
    }
    
    /**
     * Format addresses for display in the view
     */
    private String formatAddressesForView(List<Address> addresses) {
        StringBuilder result = new StringBuilder();

        for (Address address : addresses) {
            result.append("\nAddress ID: ").append(address.getAddressId())
                    .append("\nRecipient: ").append(address.getRecipientName())
                    .append("\nPhone: ").append(address.getRecipientPhone())
                    .append("\nStreet: ").append(address.getStreet())
                    .append("\nWard: ").append(address.getWard())
                    .append("\nWard GHN: ").append(address.getGhnWard() != null ? address.getGhnWard().getWardName() : "N/A")
                    .append("\nDistrict: ").append(address.getDistrict())
                    .append("\nDistrict GHN: ").append(address.getGhnDistrict() != null ? address.getGhnDistrict().getDistrictName() : "N/A")
                    .append("\nProvince: ").append(address.getProvince())
                    .append("\nProvince GHN: ").append(address.getGhnProvince() != null ? address.getGhnProvince().getProvinceName() : "N/A")
                    .append("\nCountry: ").append(address.getCountry())
                    .append("\n-----------------------");

            log.info("Address formatted: ID={}, Recipient={}, Phone={}, Street={}, Ward={}, District={}, Province={}, Country={}",
                    address.getAddressId(),
                    address.getRecipientName(),
                    address.getRecipientPhone(),
                    address.getStreet(),
                    address.getWard(),
                    address.getDistrict(),
                    address.getProvince(),
                    address.getCountry());

            log.info("GHN data: Ward={}, District={}, Province={}",
                    address.getGhnWard() != null ? address.getGhnWard().getWardName() : "N/A",
                    address.getGhnDistrict() != null ? address.getGhnDistrict().getDistrictName() : "N/A",
                    address.getGhnProvince() != null ? address.getGhnProvince().getProvinceName() : "N/A");
        }

        if (addresses.isEmpty()) {
            result.append("No addresses found for this customer.");
        }

        return result.toString();
    }
    
    /**
     * Endpoint for "/order/orderfix" - Combined implementation from both controllers
     */
    @GetMapping("/order/orderfix")
    public String getOrderFixPage(
            @RequestParam(value = "variantId", required = false) Integer variantId,
            @RequestParam(value = "quantity", required = false) Integer quantity,
            @RequestParam(value = "variantIds", required = false) List<Integer> variantIds,
            @RequestParam(value = "quantities", required = false) List<Integer> quantities,
            @RequestParam(value = "productId", required = false) Integer productId,
            Model model, HttpServletRequest request) {
        
        // Setup GHN data
        setupOrderPageModel(model);
        
        // Get current customer - redirect to login if not authenticated
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            return "redirect:/login";
        }
        
        // Lấy thông tin chi tiết của customer từ DB
        Customer customerDetails = customerService.findCustomerById(currentCustomer.getCustomerId());
        model.addAttribute("customer", customerDetails);
        
        // Get customer addresses and pass them directly to the view
        List<Address> addresses = addressService.getAddressesForCustomer(customerDetails.getCustomerId());
        model.addAttribute("customerAddresses", addresses);

        // Get the first address for default display
        Address defaultAddress = null;
        if (addresses != null && !addresses.isEmpty()) {
            defaultAddress = addresses.get(0);
            model.addAttribute("defaultAddress", defaultAddress);
            
            // Log default address details for debugging
            log.info("Default address: {}", defaultAddress);
            log.info("Address details - ID: {}, Street: {}, Recipient: {}, Phone: {}, Ward: {}, District: {}, Province: {}, Country: {}",
                defaultAddress.getAddressId(),
                defaultAddress.getStreet(),
                defaultAddress.getRecipientName(),
                defaultAddress.getRecipientPhone(),
                defaultAddress.getWardId(),
                defaultAddress.getDistrictId(),
                defaultAddress.getProvinceId(),
                defaultAddress.getCountry());
        }

       
        
        List<OrderItemDTO> items = new ArrayList<>();
        List<Integer> allProductIds = new ArrayList<>();

        // Trường hợp: Đặt 1 sản phẩm từ trang detail
        if (variantId != null && quantity != null) {
            ProductVariant variant = productVariantService.findById(variantId);
            if (variant != null) {
                items.add(new OrderItemDTO(variant, quantity));
                
                // Set productId if not provided but we have a variant
                if (variant.getProduct() != null) {
                    Integer currentProductId = variant.getProduct().getProductId();
                    if (productId == null) {
                        productId = currentProductId;
                    }
                    
                    // Add to list of all product IDs
                    if (!allProductIds.contains(currentProductId)) {
                        allProductIds.add(currentProductId);
                    }
                }
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
                        
                        // Add product ID to the list if not already present
                        if (variant.getProduct() != null) {
                            Integer currentProductId = variant.getProduct().getProductId();
                            
                            // Set productId if not provided but we have a variant
                            if (productId == null) {
                                productId = currentProductId;
                            }
                            
                            // Add to list of all product IDs
                            if (!allProductIds.contains(currentProductId)) {
                                allProductIds.add(currentProductId);
                            }
                        }
                    }
                }
            }
        }
        
        log.info("variantId = {}", variantId);
        log.info("quantity = {}", quantity);
        log.info("productId = {}", productId);
        log.info("allProductIds = {}", allProductIds);

        // Log chi tiết địa chỉ để kiểm tra
        for (Address address : addresses) {
            log.info("Address ID: {}, Street: {}, Full Address: {}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getFullAddress());

            log.info("Ward: ID={}, Name={}",
                    address.getWardId(),
                    (address.getGhnWard() != null) ? address.getGhnWard().getWardName() : address.getWard());

            log.info("District: ID={}, Name={}",
                    address.getDistrictId(),
                    (address.getGhnDistrict() != null) ? address.getGhnDistrict().getDistrictName() : address.getDistrict());

            log.info("Province: ID={}, Name={}",
                    address.getProvinceId(),
                    (address.getGhnProvince() != null) ? address.getGhnProvince().getProvinceName() : address.getProvince());
        }
        
        // Tạo Map để lưu trữ discounts cho từng sản phẩm
        Map<Integer, List<Map<String, Object>>> allProductDiscounts = new HashMap<>();
        
        // Fetch discount information for each product ID
        int customerId = currentCustomer.getCustomerId();
        
        for (Integer prodId : allProductIds) {
            try {
                // Fetch discount information
                List<Map<String, Object>> discounts = productDiscountService
                        .getVariantsWithAccountsByProductId(prodId, customerId);
                
                if (discounts != null && !discounts.isEmpty()) {
                    allProductDiscounts.put(prodId, discounts);
                    log.info("Found {} discounts for product ID {}", discounts.size(), prodId);
                }
            } catch (Exception e) {
                log.error("Error fetching product discounts for product ID {}: {}", prodId, e.getMessage(), e);
            }
        }
        
        // Add all product discounts to model
        model.addAttribute("allProductDiscounts", allProductDiscounts);
        model.addAttribute("allProductDiscountsJson", gson.toJson(allProductDiscounts));
        log.info("allProductDiscounts = {}", allProductDiscounts);
        
        // For backward compatibility, also add discounts for the primary product ID
        if (productId != null) {
            try {
                List<Map<String, Object>> discounts = productDiscountService
                        .getVariantsWithAccountsByProductId(productId, customerId);
                log.info("discounts for primary product = {}", discounts);
                model.addAttribute("discounts", discounts);
                model.addAttribute("discountsJson", gson.toJson(discounts));
            } catch (Exception e) {
                log.error("Error fetching product discounts for primary product: {}", e.getMessage(), e);
                model.addAttribute("discounts", new ArrayList<>());
                model.addAttribute("error", "Failed to fetch product discounts. Please try again.");
            }
        } else {
            model.addAttribute("discounts", new ArrayList<>());
        }
        
        // Add all product IDs to model for use in JSP
        model.addAttribute("allProductIds", allProductIds);
        model.addAttribute("allProductIdsJson", gson.toJson(allProductIds));
        
        model.addAttribute("items", items);
        
        // Tính tổng tiền cho trang order
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
    
    /**
     * Process checkout from cart and redirect to order page
     */
    @PostMapping("/order/orderfix")
    public String processCheckout(@RequestParam(value = "selectedItems", required = false) List<Integer> selectedCartDetailIds,
            Model model, HttpServletRequest request) {
        // Get current customer
        Customer currentCustomer = getCurrentCustomer(request);
        if (currentCustomer == null) {
            return "redirect:/login";
        }
        
        // Handle empty or null selectedItems (direct access to orderfix page)
        if (selectedCartDetailIds == null || selectedCartDetailIds.isEmpty()) {
            // Fetch customer addresses and add them to model
            Customer customerDetails = customerService.findCustomerById(currentCustomer.getCustomerId());
            
            // Setup GHN data
            setupOrderPageModel(model);
            
            // Get customer addresses and pass them directly to the view
            List<Address> addresses = addressService.getAddressesForCustomer(customerDetails.getCustomerId());
            model.addAttribute("customerAddresses", addresses);
            model.addAttribute("customer", customerDetails);

            // Get the first address for default display
            if (addresses != null && !addresses.isEmpty()) {
                Address defaultAddress = addresses.get(0);
                model.addAttribute("defaultAddress", defaultAddress);
                
                // Log default address details
                log.info("Default address for customer {}: ID={}, Recipient={}", 
                    customerDetails.getCustomerId(),
                    defaultAddress.getAddressId(),
                    defaultAddress.getRecipientName());
            }
            
            // Return directly to the order page
            return "client/user/orderfix";
        }

        // Process selected cart items
        List<Integer> variantIds = new ArrayList<>();
        List<Integer> quantities = new ArrayList<>();
        Integer productId = null;

        // Get selected cart details and convert to the format needed for the order page
        for (Integer cartDetailId : selectedCartDetailIds) {
            try {
                CartDetail cartDetail = cartDetailService.findById(cartDetailId);
                if (cartDetail != null) {
                    variantIds.add(cartDetail.getProductVariant().getProductVariantId());
                    quantities.add(cartDetail.getQuantity());
                    
                    // Get productId from the first item if not set yet
                    if (productId == null && cartDetail.getProductVariant().getProduct() != null) {
                        productId = cartDetail.getProductVariant().getProduct().getProductId();
                    }
                }
            } catch (Exception e) {
                log.error("Error finding cart detail with ID: {}", cartDetailId, e);
            }
        }

        // Debug logging
        log.info("Selected Cart Detail IDs: {}", selectedCartDetailIds);
        log.info("Variant IDs: {}", variantIds);
        log.info("Quantities: {}", quantities);
        log.info("Product ID: {}", productId);

        // Redirect to the GET method with parameters
        StringBuilder redirectUrl = new StringBuilder("redirect:/order/orderfix");

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
            
            // Add productId if available
            if (productId != null) {
                redirectUrl.append("&productId=").append(productId);
            }
        }

        log.info("Redirect URL: {}", redirectUrl.toString());
        return redirectUrl.toString();
    }
   
    /**
     * Hiển thị trang order với dữ liệu GHN - API endpoint
     */
    @GetMapping("/api/ghn/checkout")
    public String showCheckoutPage(Model model) {
        setupOrderPageModel(model);
        return "client/user/orderfix";
    }
    
    /**
     * API endpoint để lấy danh sách tỉnh/thành phố
     */
    @GetMapping("/api/ghn/provinces")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getProvinces() {
        try {
            List<Map<String, Object>> provinces = giaohangnhanhService.getProvinces();
            Map<String, Object> response = new HashMap<>();
            response.put("provinces", provinces);
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load provinces: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy danh sách quận/huyện theo provinceId
     */
    @GetMapping("/api/ghn/districts/{provinceId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDistricts(@PathVariable int provinceId) {
        try {
            System.out.println("Getting districts for province: " + provinceId);
            List<Map<String, Object>> districts = giaohangnhanhService.getDistricts(provinceId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("districts", districts);
            response.put("success", true);
            
            System.out.println("Found " + districts.size() + " districts");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load districts: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy danh sách phường/xã theo districtId
     */
    @GetMapping("/api/ghn/wards/{districtId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getWards(@PathVariable int districtId) {
        try {
            System.out.println("Getting wards for district: " + districtId);
            List<Map<String, Object>> wards = giaohangnhanhService.getWards(districtId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("wards", wards);
            response.put("success", true);
            
            System.out.println("Found " + wards.size() + " wards");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load wards: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy dịch vụ vận chuyển có sẵn
     */
    @GetMapping("/api/ghn/services/{fromDistrictId}/{toDistrictId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAvailableServices(
            @PathVariable int fromDistrictId,
            @PathVariable int toDistrictId) {
        try {
            List<Map<String, Object>> services = giaohangnhanhService.getAvailableServices(fromDistrictId, toDistrictId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("services", services);
            response.put("success", true);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load shipping services: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để tính phí vận chuyển
     */
    @PostMapping("/api/ghn/shipping-fee")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> calculateShippingFee(@RequestBody Map<String, Object> requestData) {
        try {
            Map<String, Object> shippingFee = giaohangnhanhService.calculateShippingFee(requestData);
            
            Map<String, Object> response = new HashMap<>();
            response.put("shippingFee", shippingFee);
            response.put("success", true);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to calculate shipping fee: " + e.getMessage());
            // In chi tiết lỗi ra console để gỡ lỗi
            System.out.println("Error calculating shipping fee: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.ok(errorResponse);
        }
    }

    /**
     * Endpoint to handle order confirmation redirect after successful order placement
     * @param orderId Order ID to display details for
     * @param model Spring model for view data
     * @return View name for order confirmation page
     */
    @GetMapping("/order/confirmation/{orderId}")
    public String showOrderConfirmation(@PathVariable String orderId, Model model) {
        // Check if we have an order ID
        if (orderId == null || orderId.isEmpty()) {
            model.addAttribute("error", "Không tìm thấy thông tin đơn hàng. Vui lòng kiểm tra lại.");
            return "client/user/orderconfirm";
        }

        try {
            // Fetch order details from database
            Order order = orderService.getOrderById(orderId);

            if (order == null) {
                model.addAttribute("error", "Đơn hàng #" + orderId + " không tồn tại.");
                return "client/user/orderconfirm";
            }

            // Fetch order items
            List<OrderDetail> orderDetails = orderService.getOrderDetailByOrderId(orderId);
            List<OrderConfirmItemDTO> orderItems = new ArrayList<>();

            // Process order details into DTOs for the view
            BigDecimal subtotal = BigDecimal.ZERO;
            for (OrderDetail detail : orderDetails) {
                OrderConfirmItemDTO itemDTO = new OrderConfirmItemDTO();
                
                // Set basic details
                itemDTO.setName(detail.getProductVariant().getProduct().getProductName());
                itemDTO.setQuantity(detail.getQuantity());
                itemDTO.setPrice(detail.getPrice());
                
                // Calculate subtotal for this item
                BigDecimal itemTotal = detail.getPrice().multiply(new BigDecimal(detail.getQuantity()));
                itemDTO.setSubtotal(itemTotal);
                subtotal = subtotal.add(itemTotal);
                
                // Set variant details if available
                if (detail.getProductVariant() != null) {
                    if (detail.getProductVariant().getColor() != null) {
                        itemDTO.setColor(detail.getProductVariant().getColor().getColorName());
                    }
                    if (detail.getProductVariant().getSize() != null) {
                        itemDTO.setSize(detail.getProductVariant().getSize().getSizeName());
                    }
                    itemDTO.setImageUrl(detail.getProductVariant().getImageUrl());
                }
                
                orderItems.add(itemDTO);
            }

            // Format date for display
            String formattedDate = order.getOrderDate().format(
                    DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"));

            // Prepare shipping address
            String shippingAddress = "";
            if (order.getShippingAddress() != null) {
                Address address = order.getShippingAddress();
                shippingAddress = String.format("%s, %s, %s, %s, %s",
                        address.getStreet(),
                        address.getWard(),
                        address.getDistrict(),
                        address.getProvince(),
                        address.getCountry());
            }

            // Get customer details
            String customerName = "";
            String customerEmail = "";
            if (order.getCustomer() != null) {
                Customer customer = order.getCustomer();
                customerName = customer.getFirstName() + " " + customer.getLastName();
                customerEmail = customer.getEmail();
            }

            // Calculate order totals
            // Since Order class might not have direct discount and shipping fee fields,
            // we'll calculate or set default values
            BigDecimal discount = BigDecimal.ZERO; // Default or calculated value
            BigDecimal total = order.getTotalAmount();
            
            // Tính phí vận chuyển dựa trên chênh lệch giữa tổng tiền và subtotal
            // Shipping = TotalAmount - Subtotal + Discount
            BigDecimal shipping = total.subtract(subtotal);
            
            // Nếu shipping âm (do tổng tiền thấp hơn subtotal do có discount), set về 0
            if (shipping.compareTo(BigDecimal.ZERO) < 0) {
                shipping = BigDecimal.ZERO;
            }
            
            // Log giá trị để debug
            log.info("Order calculation - OrderID: {}, Subtotal: {}, Shipping: {}, Total: {}", 
                    orderId, subtotal, shipping, total);

            // Calculate discount percentage if needed
            Integer discountPercentage = 0;
            if (discount.compareTo(BigDecimal.ZERO) > 0 && subtotal.compareTo(BigDecimal.ZERO) > 0) {
                discountPercentage = discount.multiply(new BigDecimal(100))
                        .divide(subtotal, 0, BigDecimal.ROUND_HALF_UP).intValue();
            }

            // Add all data to the model
            model.addAttribute("orderId", orderId);
            model.addAttribute("orderDate", formattedDate);
            model.addAttribute("customerName", customerName);
            model.addAttribute("customerEmail", customerEmail);
            model.addAttribute("shippingAddress", shippingAddress);
            model.addAttribute("subtotal", subtotal);
            model.addAttribute("discount", discount);
            model.addAttribute("discountPercentage", discountPercentage);
            model.addAttribute("shipping", shipping);
            model.addAttribute("total", total);
            model.addAttribute("orderItems", orderItems);

            return "client/user/orderconfirm";

        } catch (Exception e) {
            // Log error and add error message to model
            log.error("Error processing order confirmation: " + e.getMessage(), e);
            model.addAttribute("error", "Đã xảy ra lỗi khi xử lý thông tin đơn hàng của bạn");
            return "client/user/orderconfirm";
        }
    }
}
