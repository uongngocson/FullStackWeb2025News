package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.service.CustomerService;
import local.example.demo.service.FileService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/customer-mgr/")
public class CustomerMgrController {

    private final CustomerService customerService;
    private final FileService fileService;

    @GetMapping("list")
    public String getCustomerList(Model model) {
        List<Customer> customers = customerService.findAllCustomers();
        model.addAttribute("customers", customers);
        return "admin/customer-mgr/all-customers";
    }

    @GetMapping("detail/{customerId}")
    public String getCustomerDetail(Model model, @PathVariable("customerId") Integer customerId) {
        Customer customer = customerService.findCustomerById(customerId);

        if (customer == null) {
            return "redirect:/admin/customer-mgr/list";
        }

        List<Order> orders = customerService.findOrdersByCustomerId(customerId);
        model.addAttribute("orders", orders);
        model.addAttribute("customer", customer);
        return "admin/customer-mgr/detail-customer";
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
            return "redirect:/admin/customer-mgr/list";
        }
        model.addAttribute("customer", customer);
        return "admin/customer-mgr/form-customer";
    }

    @PostMapping("save")
    public String saveCustomer(@ModelAttribute("customer") @Valid Customer customer, BindingResult bindingResult,
            @RequestParam(value = "profileImageFile", required = false) MultipartFile profileImage) throws Exception {

        if (bindingResult.hasErrors()) {
            return "admin/customer-mgr/form-customer";
        }

        if (fileService.isValidFile(profileImage)) {
            String fileName = fileService.handleSaveUploadFile(profileImage, "customer");
            customer.setProfileImage("/resources/images-upload/customer/" + fileName);
        }
        customerService.saveCustomer(customer);
        return "redirect:/admin/customer-mgr/list";
    }

    @PostMapping("delete/{customerId}")
    public String deleteCustomer(@PathVariable("customerId") Integer customerId) {
        customerService.deleteCustomerById(customerId);
        return "redirect:/admin/customer-mgr/list";
    }
}
