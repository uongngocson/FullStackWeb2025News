package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ClientManagement {

    @GetMapping("/admin/product/list/clients")
    public String getDashboardPageClient(Model model) {
        return "admin/manageClients/allClinetRegister/allClientRegister";
    }
}
