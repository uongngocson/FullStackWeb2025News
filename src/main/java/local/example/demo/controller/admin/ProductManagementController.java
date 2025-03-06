package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProductManagementController {
    @GetMapping("/admin/product")
    public String getProductManagementPage() {
        return "admin/product/manage";
    }
}
