package local.example.demo.controller.client;

import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.service.CustomerService;
import local.example.demo.service.OrderService;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.validation.Valid;

import java.io.IOException;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/management")
public class ManagementController {

    private static final Logger logger = LoggerFactory.getLogger(ManagementController.class);

    private final CustomerService customerService;
    private final OrderService orderService;

    @GetMapping("/profile")
    public String getProfilePage(Model model) {
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            return "redirect:/login";
        }
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
        logger.debug("Processing GET /management/profile/change-password");
        return "client/auth/change_password";
    }

    @PostMapping("/profile/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes redirectAttributes) {
        logger.debug("Processing POST /management/profile/change-password");
        try {
            customerService.changePassword(oldPassword, newPassword, confirmPassword);
            logger.info("Password changed successfully");
            redirectAttributes.addFlashAttribute("passwordSuccess", "Thay đổi mật khẩu thành công!");
        } catch (IllegalArgumentException e) {
            logger.error("Failed to change password: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: " + e.getMessage());
        } catch (Exception e) {
            logger.error("Unexpected error during password change: {}", e.getMessage());
            redirectAttributes.addFlashAttribute("passwordError", "Thay đổi mật khẩu thất bại: Lỗi không xác định.");
        }
        return "redirect:/management/profile/change-password";
    }

    // @GetMapping("/historyorder")
    // public String getHistoryOrderPage(Model model) {
    // Customer customer = customerService.fetchCurrentLoggedInCustomer();
    // if (customer == null) {
    // System.out
    // .println("Không tìm thấy khách hàng đăng nhập cho /historyorder, chuyển hướng
    // đến trang đăng nhập");
    // return "redirect:/login";
    // }
    // System.out.println("Lấy danh sách đơn hàng cho khách hàng ID: " +
    // customer.getCustomerId());
    // List<Order> orders = orderService.findOrdersByCustomer(customer);
    // model.addAttribute("orders", orders);
    // return "client/auth/orderhis";
    // }

    // @PostMapping("/order/cancel/{orderId}")
    // public String cancelOrder(@PathVariable String orderId, RedirectAttributes
    // redirectAttributes) {
    // try {
    // System.out.println("Nhận yêu cầu hủy đơn hàng: /management/order/cancel/" +
    // orderId);
    // Customer customer = customerService.fetchCurrentLoggedInCustomer();
    // if (customer == null) {
    // System.out.println(
    // "Không tìm thấy khách hàng đăng nhập cho /order/cancel, chuyển hướng đến
    // trang đăng nhập");
    // return "redirect:/login";
    // }
    // System.out.println("Hủy đơn hàng " + orderId + " cho khách hàng ID: " +
    // customer.getCustomerId());
    // orderService.cancelOrder(orderId, customer);
    // redirectAttributes.addFlashAttribute("error", "Đơn hàng đã được hủy thành
    // công!");
    // return "redirect:/management/historyorder";
    // } catch (IllegalArgumentException e) {
    // System.out.println("Lỗi khi hủy đơn hàng: " + e.getMessage());
    // redirectAttributes.addFlashAttribute("error", e.getMessage());
    // return "redirect:/management/historyorder";
    // }
    // }

    // @GetMapping("/order/details/{orderId}")
    // public String getOrderDetails(@PathVariable String orderId, Model model) {
    // System.out.println("Xử lý yêu cầu cho /management/order/details/" + orderId);
    // Customer customer = customerService.fetchCurrentLoggedInCustomer();
    // if (customer == null) {
    // System.out.println("Không tìm thấy khách hàng đăng nhập, chuyển hướng đến
    // trang đăng nhập");
    // return "redirect:/login";
    // }
    // System.out.println("ID khách hàng đăng nhập: " + customer.getCustomerId());

    // List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);
    // if (orderDetails.isEmpty()) {
    // System.out.println("Không tìm thấy chi tiết đơn hàng cho orderId: " +
    // orderId);
    // model.addAttribute("errorMessage", "Không tìm thấy đơn hàng với mã: " +
    // orderId);
    // return "client/auth/error";
    // }

    // boolean isAuthorized = orderDetails.stream()
    // .anyMatch(detail -> detail.getCustomerId().equals(customer.getCustomerId()));
    // if (!isAuthorized) {
    // System.out.println("Khách hàng " + customer.getCustomerId() + " không có
    // quyền xem đơn hàng " + orderId);
    // model.addAttribute("errorMessage", "Bạn không có quyền xem chi tiết đơn hàng
    // này.");
    // return "client/auth/error";
    // }

    // System.out.println("Lấy chi tiết đơn hàng thành công cho orderId: " +
    // orderId);
    // model.addAttribute("orderDetails", orderDetails);
    // return "client/auth/order-details";
    // }

    @GetMapping("/historyorder")
    public String getHistoryOrderPage(@RequestParam(defaultValue = "0") int page,
            Model model) {
        logger.debug("Processing GET /management/historyorder?page={}", page);
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            logger.warn("No authenticated customer found, redirecting to login");
            return "redirect:/login";
        }
        logger.debug("Fetching orders for customer ID: {}", customer.getCustomerId());

        Page<Order> orderPage = orderService.findPaginatedOrdersByCustomer(customer, page, 7);
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("totalItems", orderPage.getTotalElements());
        logger.debug("Found {} orders for customer ID: {}", orderPage.getTotalElements(), customer.getCustomerId());
        return "client/auth/orderhis";
    }

    @PostMapping("/order/cancel/{orderId}")
    public String cancelOrder(@PathVariable String orderId,
            @RequestParam(defaultValue = "0") int page,
            RedirectAttributes redirectAttributes) {
        logger.debug("Processing POST /management/order/cancel/{}", orderId);
        try {
            Customer customer = customerService.getCurrentLoggedInCustomer();
            if (customer == null) {
                logger.warn("No authenticated customer found, redirecting to login");
                return "redirect:/login";
            }
            logger.debug("Cancelling order {} for customer ID: {}", orderId, customer.getCustomerId());
            orderService.cancelOrder(orderId, customer);
            logger.info("Order {} cancelled successfully", orderId);
            redirectAttributes.addFlashAttribute("success", "Đơn hàng đã được hủy thành công!");
        } catch (IllegalArgumentException e) {
            logger.error("Failed to cancel order {}: {}", orderId, e.getMessage());
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (Exception e) {
            logger.error("Unexpected error cancelling order {}: {}", orderId, e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Hủy đơn hàng thất bại: Lỗi không xác định.");
        }
        return "redirect:/management/historyorder?page=" + page;
    }

    @GetMapping("/order/details/{orderId}")
    public String getOrderDetails(@PathVariable String orderId,
            @RequestParam(defaultValue = "0") int page,
            Model model) {
        logger.debug("Processing GET /management/order/details/{}", orderId);
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            logger.warn("No authenticated customer found, redirecting to login");
            return "redirect:/login";
        }
        logger.debug("Fetching order details for order ID: {} by customer ID: {}", orderId, customer.getCustomerId());

        List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);
        if (orderDetails.isEmpty()) {
            logger.warn("No order details found for order ID: {}", orderId);
            model.addAttribute("errorMessage", "Không tìm thấy đơn hàng với mã: " + orderId);
            return "client/auth/error";
        }

        boolean isAuthorized = orderDetails.stream()
                .anyMatch(detail -> detail.getCustomerId().equals(customer.getCustomerId()));
        if (!isAuthorized) {
            logger.warn("Customer ID: {} not authorized to view order ID: {}", customer.getCustomerId(), orderId);
            model.addAttribute("errorMessage", "Bạn không có quyền xem chi tiết đơn hàng này.");
            return "client/auth/error";
        }

        logger.debug("Order details retrieved successfully for order ID: {}", orderId);
        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("currentPage", page);
        return "client/auth/order-details";
    }
}