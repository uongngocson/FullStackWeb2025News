package local.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Role;
import local.example.demo.service.LoginService;

@Controller
@RequestMapping("/client/auth/")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("login")
    public String showLoginForm(Model model) {
        model.addAttribute("account", new Account());
        return "client/auth/login"; // đường dẫn đến file login.jsp
    }

    @PostMapping("login")
    public String doLogin(@Valid @ModelAttribute("account") Account account,
                    BindingResult bindingResult,
                    HttpSession session,
                    Model model) {
        if (bindingResult.hasErrors()) {
            return "client/auth/login";
        }

        Account loggedInAccount = loginService.login(account.getLoginName(), account.getPassword());
        
        if (loggedInAccount != null) {
            session.setAttribute("loggedInUser", loggedInAccount);

            // Kiểm tra quyền
            Role role = loggedInAccount.getRole(); 

            if ("Customer".equalsIgnoreCase(role.getRoleName())) {
                return "redirect:/client/home";
            } else if ("Employee".equalsIgnoreCase(role.getRoleName())) {
                return "redirect:/account-mgr/list";
            } 
        }

        model.addAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
        return "client/auth/login";
    }

}


