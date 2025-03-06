package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserManagementController {

    @GetMapping("/admin/user")
    public String getUserManagementPage() {
        return "admin/user/manage";
    }

}
