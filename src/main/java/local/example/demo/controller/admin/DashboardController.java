package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashboard/")
public class DashboardController {

    @GetMapping("")
    public String getDashboardPage(Model model) {
        return "admin/dashboard/index";
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
