package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Account;

@Controller
public class UserController {

    @GetMapping("/")
    public String getHome(Model model , HttpSession session) {
    Account account = (Account) session.getAttribute("loggedInUser");
    if (account != null) {
        // Nếu đã login thì chuyển hướng theo quyền
        if (account.getRole().getRoleName().equals("Customer")) {
            return "redirect:/client/home";
        } else if(account.getRole().getRoleName().equals("Employee")) {
            return "redirect:/account-mgr/list";
        }
    }
    model.addAttribute("account", new Account());
    // Nếu chưa login thì vào trang login
    return "client/auth/login";
}

}
