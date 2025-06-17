package local.example.demo.controller.employee;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import local.example.demo.model.entity.Inventory;
import local.example.demo.service.InventoryService;
import lombok.RequiredArgsConstructor;

@Controller("employeeInventoryController")
@RequestMapping("/employee/inventory-mgr")
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService inventoryService;

    @GetMapping("/list")
    public String getAllInventories(Model model) {
        try {
            List<Inventory> inventories = inventoryService.getAllInventories();
            model.addAttribute("inventories", inventories);
            return "employee/inventory-mgr/inventory-list";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Lỗi khi tải danh sách kho: " + e.getMessage());
            return "employee/inventory-mgr/inventory-list";
        }
    }
}