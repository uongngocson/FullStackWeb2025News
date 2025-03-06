package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @GetMapping("/")
    public String getHomePage() {
        return "client/home";
    }

    @GetMapping("/login")
    public String getLoginPage() {
        return "client/auth/login";
    }   

    @GetMapping("/register")
    public String getRegisterPage() {
        return "client/auth/register";
    }

}
