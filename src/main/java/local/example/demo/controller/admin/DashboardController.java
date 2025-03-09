package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

    @GetMapping("/admin")
    public String getDashboardPage(Model model) {
        return "admin/dashboard/show";
    }

    @GetMapping("/test")
    public String getDashboardPageTest(Model model) {
        return "admin/dashboard/test";
    }

    // admin navigation to home login
    @GetMapping("/admin/login")
    public String getDashboardPageLogin(Model model) {
        return "admin/login/login";
    }

    // admin navigation to home logout
    @GetMapping("/admin/register")
    public String getDashboardPageRegister(Model model) {
        model.addAttribute("message", "Chào mừng đến trang đăng ký!");
        model.addAttribute("username", "admin");
        return "admin/login/register";
    }

    
}
