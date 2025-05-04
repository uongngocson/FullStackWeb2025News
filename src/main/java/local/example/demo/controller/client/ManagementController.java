package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/management")
public class ManagementController {

    @GetMapping("profile")
    public String getProfilePage() {
        return "client/auth/profile";
    }

    @GetMapping("historyorder")
    public String getHistoryOrderPage() {
        return "client/auth/orderhis";
    }

}
