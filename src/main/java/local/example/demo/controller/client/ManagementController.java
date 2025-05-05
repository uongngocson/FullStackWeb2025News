package local.example.demo.controller.client;

import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Customer;
import local.example.demo.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/management")
public class ManagementController {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/profile")
    public String getProfilePage(Model model) {
        Customer customer = customerService.getCurrentLoggedInCustomer();
        if (customer == null) {
            return "redirect:/login";
        }
        // Nạp addresses để hiển thị
        List<Address> addresses = customerService.findAddressesByCustomer(customer);
        customer.setAddresses(addresses);
        model.addAttribute("customer", customer);
        return "client/auth/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @Valid @ModelAttribute("customer") Customer customer,
            BindingResult result,
            @RequestParam("image") MultipartFile image,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("customer", customer);
            return "client/auth/profile";
        }

        try {
            customerService.updateCustomerProfile(customer, image);
            redirectAttributes.addFlashAttribute("success", "Hồ sơ đã được cập nhật thành công!");
            return "redirect:/management/profile";
        } catch (IllegalArgumentException | IllegalStateException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("customer", customer);
            return "client/auth/profile";
        } catch (IOException e) {
            model.addAttribute("error", "Lỗi khi tải lên ảnh: " + e.getMessage());
            model.addAttribute("customer", customer);
            return "client/auth/profile";
        }
    }

    @PostMapping("/profile/change-password")
    public String changePassword(
            @RequestParam("oldPassword") String oldPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            RedirectAttributes redirectAttributes) {
        try {
            customerService.changePassword(oldPassword, newPassword, confirmPassword);
            redirectAttributes.addFlashAttribute("passwordSuccess", "Password changed successfully!");
            return "redirect:/management/profile";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("passwordError", e.getMessage());
            return "redirect:/management/profile";
        }
    }

    @GetMapping("/historyorder")
    public String getHistoryOrderPage() {
        return "client/auth/orderhis";
    }
}