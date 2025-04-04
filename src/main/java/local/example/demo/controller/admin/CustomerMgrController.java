package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Customer;
import local.example.demo.service.CustomerService;

@Controller
@RequestMapping("/customer-mgr/")
public class CustomerMgrController {
    @Autowired
    private final CustomerService customerService;

    public CustomerMgrController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping("list")
    public String getCustomerList(Model model) {
        List<Customer> customers = customerService.findAllCustomers();
        model.addAttribute("customers", customers);
        return "admin/customer-mgr/all-customers";
    }

    @GetMapping("create")
    public String createCustomer(Model model) {
        model.addAttribute("customer", new Customer());
        return "admin/customer-mgr/form-customer";
    }

    @GetMapping("update/{customerId}")
    public String updateCustomer(Model model, @PathVariable("customerId") Integer customerId) {
        Customer customer = customerService.findCustomerById(customerId);
        if (customer == null) {
            return "redirect:/customer-mgr/list";
        }
        model.addAttribute("customer", customer);
        return "admin/customer-mgr/form-customer";
    }

    @PostMapping("save")
    public String saveCustomer(@ModelAttribute("customer") @Valid Customer customer, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "admin/customer-mgr/form-customer";
        }
        customerService.saveCustomer(customer);
        return "redirect:/customer-mgr/list";
    }

    @PostMapping("/delete/{customerId}")
    public String deleteCustomer(@PathVariable Integer customerId, Model model) {
        try {
            customerService.deleteCustomerById(customerId);
            model.addAttribute("message", "Deleted successfully");
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", "Lỗi: " + e.getMessage());
        } catch (RuntimeException e) {
            model.addAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        return "redirect:/customer-mgr/list";
    }
}
