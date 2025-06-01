package local.example.demo.controller.client;

import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.OrderService;
import local.example.demo.service.ReviewService;
import lombok.RequiredArgsConstructor;

import org.apache.logging.log4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Controller
@RequestMapping("/management")
public class ManagementController {
    private final CustomerService customerService;
    private final OrderService orderService;
    private final ReviewService reviewService;
    private final AccountService accountService;

    @GetMapping("/profile")
    public String getProfilePage(Model model, HttpSession session) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            return "redirect:/login";
        }

        Customer customer = customerService.findById(customerId);
        if (customer == null) {
            session.removeAttribute("customerId");
            return "redirect:/login";
        }
        List<Address> addresses = customerService.findAddressesByCustomer(customer);
        customer.setAddresses(addresses);
        model.addAttribute("customer", customer);
        return "client/auth/profile";
    }

    @GetMapping("/profile/update")
    public String getUpdateProfilePage(Model model) {
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            return "redirect:/login";
        }
        model.addAttribute("customer", customer);
        return "client/auth/update_profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@Valid @ModelAttribute("customer") Customer updatedCustomer,
            BindingResult bindingResult,
            @RequestParam("image") MultipartFile image,
            RedirectAttributes redirectAttributes,
            Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("error", "Vui lòng sửa các lỗi trong form trước khi gửi.");
            return "client/auth/update_profile";
        }
        try {
            customerService.updateCustomerProfile(updatedCustomer, image);
            redirectAttributes.addFlashAttribute("success", "Cập nhật hồ sơ thành công!");
        } catch (IOException e) {
            model.addAttribute("error", "Cập nhật hồ sơ thất bại: Lỗi khi xử lý ảnh.");
            return "client/auth/update_profile";
        } catch (Exception e) {
            model.addAttribute("error", "Cập nhật hồ sơ thất bại: " + e.getMessage());
            return "client/auth/update_profile";
        }
        return "redirect:/management/profile";
    }

    @GetMapping("/profile/change-password")
    public String getChangePasswordPage() {
        return "client/auth/change_password";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes redirectAttributes) {
        try {
            customerService.changePassword(oldPassword, newPassword, confirmPassword);
            redirectAttributes.addFlashAttribute("passwordSuccess", "Thay đổi mật khẩu thành công!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: " + e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: Lỗi không xác định.");
        }
        return "redirect:/management/profile/change-password";
    }

    @GetMapping("/historyorder")
    public String getHistoryOrderPage(@RequestParam(defaultValue = "0") int page, Model model, HttpSession session) {
        // Lấy customerId từ session
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            System.out.println("Không tìm thấy customerId trong session, chuyển hướng đến trang đăng nhập");
            return "redirect:/login";
        }

        // Tìm customer bằng ID từ session
        Customer customer = customerService.findById(customerId);
        if (customer == null) {
            return "redirect:/login";
        }
        Page<Order> orderPage = orderService.findPaginatedOrdersByCustomer(customer, page, 7);
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("totalItems", orderPage.getTotalElements());
        return "client/auth/orderhis";
    }

    @PostMapping("/order/cancel/{orderId}")
    public String cancelOrder(@PathVariable String orderId,
            @RequestParam(defaultValue = "0") int page,
            RedirectAttributes redirectAttributes) {
        try {
            Customer customer = customerService.getCurrentLoggedInCustomer();
            if (customer == null) {
                return "redirect:/login";
            }
            orderService.cancelOrder(orderId, customer);
            redirectAttributes.addFlashAttribute("success", "Đơn hàng đã được hủy thành công!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Hủy đơn hàng thất bại: Lỗi không xác định.");
        }
        return "redirect:/management/historyorder?page=" + page;
    }

    @GetMapping("/order/details/{orderId}")
    public String getOrderDetails(@PathVariable String orderId,
            @RequestParam(defaultValue = "0") int page,
            Model model,
            HttpServletRequest request,
            Authentication authentication) {

        // Lấy session hiện tại (nếu có). Không tạo mới nếu không tồn tại.
        HttpSession session = request.getSession(false);
        if (session == null) {
            // Nếu không có session => chưa đăng nhập => chuyển hướng về trang login
            return "redirect:/login";
        }

        // Lấy customerId từ session
        Integer customerIdFromSession = (Integer) session.getAttribute("customerId");
        Customer customer = null;

        if (customerIdFromSession != null) {
            // Nếu session có customerId thì tìm khách hàng tương ứng
            customer = customerService.findById(customerIdFromSession);

            // Nếu không tìm thấy customer theo ID => có thể ID sai hoặc đã bị xóa
            if (customer == null) {
                // Xóa attribute lỗi khỏi session và yêu cầu đăng nhập lại
                session.removeAttribute("customerId");
                return "redirect:/login";
            }
        }

        // Nếu customer vẫn null, thử lấy từ thông tin đăng nhập (authentication)
        if (customer == null && authentication != null && authentication.isAuthenticated()) {
            // Lấy account từ thông tin đăng nhập
            Account account = accountService.getAccountByLoginName(authentication.getName());
            if (account != null) {
                // Lấy customer theo account
                customer = customerService.getCustomerByAccount(account);

                if (customer != null) {
                    // Nếu session đang thiếu customerId thì nạp lại (tùy chọn)
                    session.setAttribute("customerId", customer.getCustomerId());
                }
            }
        }

        // Nếu vẫn không có customer => không xác thực được => quay lại login
        if (customer == null) {
            return "redirect:/login";
        }

        // Lấy danh sách chi tiết đơn hàng theo orderId
        List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);

        if (orderDetails.isEmpty()) {
            // Nếu không có dữ liệu đơn hàng nào khớp => hiển thị thông báo lỗi
            model.addAttribute("errorMessage", "Không tìm thấy đơn hàng với mã: " + orderId);
            return "client/auth/error";
        }

        // Kiểm tra quyền truy cập: đảm bảo đơn hàng thuộc về customer đang đăng nhập
        final Integer currentCustomerId = customer.getCustomerId();

        boolean isAuthorized = orderDetails.stream()
                .anyMatch(detail -> detail.getCustomerId().equals(currentCustomerId));

        if (!isAuthorized) {
            // Nếu không có quyền xem đơn hàng => hiển thị thông báo lỗi
            model.addAttribute("errorMessage", "Bạn không có quyền xem chi tiết đơn hàng này.");
            return "client/auth/error";
        }

        // Lấy danh sách sản phẩm đã được đánh giá bởi khách hàng
        Set<Long> reviewedProducts = new HashSet<>();

        // Lấy tất cả productId từ orderDetails
        List<Long> productIds = orderDetails.stream()
                .map(OrderDetailDTO::getProductId)
                .collect(Collectors.toList());

        // Kiểm tra từng sản phẩm xem đã được đánh giá chưa
        for (Long productId : productIds) {
            if (reviewService.hasCustomerReviewedProduct(customer.getCustomerId(), productId.intValue())) {
                reviewedProducts.add(productId);
            }
        }

        System.out.println("Sản phẩm đã được đánh giá: " + reviewedProducts);

        System.out.println("Lấy chi tiết đơn hàng thành công cho orderId: " + orderId);
        System.out.println("orderDetails: " + orderDetails);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("reviewedProducts", reviewedProducts);
        return "client/auth/order-details";
    }

}