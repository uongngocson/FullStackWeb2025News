package local.example.demo.controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.exception.CustomerInUseException;
import local.example.demo.service.CustomerService;
import local.example.demo.service.FileService;
import local.example.demo.service.FileUploadS3Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/customer-mgr/")
public class CustomerMgrController {

    private final CustomerService customerService;
    private final FileService fileService;
    private final FileUploadS3Service fileUploadS3Service;

    @GetMapping("list")
    public String getCustomersList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "registrationDate") String sortField,
            @RequestParam(defaultValue = "DESC") String sortDirection,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) Boolean status,
            Model model) {
        
        Sort.Direction direction = sortDirection.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Sort sort = Sort.by(direction, sortField);
        
        Pageable pageable = PageRequest.of(page, size, sort);
        Page<Customer> customerPage = customerService.findCustomersPaginated(pageable, keyword, status);
        
        model.addAttribute("customers", customerPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", customerPage.getTotalPages());
        model.addAttribute("totalItems", customerPage.getTotalElements());
        model.addAttribute("pageSize", size);
        model.addAttribute("sortField", sortField);
        model.addAttribute("sortDirection", sortDirection);
        model.addAttribute("reverseSortDirection", sortDirection.equals("ASC") ? "DESC" : "ASC");
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        
        // Tính toán phạm vi trang để hiển thị
        int totalPages = customerPage.getTotalPages();
        int currentPageZeroBased = page;
        
        // Xử lý hiển thị phân trang
        int startPage = Math.max(0, currentPageZeroBased - 2);
        int endPage = Math.min(totalPages - 1, currentPageZeroBased + 2);
        
        // Tạo danh sách các trang để hiển thị
        List<Integer> pageNumbers = new ArrayList<>();
        for (int i = 0; i < totalPages; i++) {
            if (i == 0 || i == totalPages - 1 || (i >= startPage && i <= endPage)) {
                pageNumbers.add(i);
            } else if (i == startPage - 1 || i == endPage + 1) {
                // Đánh dấu vị trí cần hiển thị dấu "..."
                pageNumbers.add(-1);
            }
        }
        
        // Loại bỏ các giá trị trùng lặp trong danh sách
        List<Integer> uniquePageNumbers = new ArrayList<>();
        int lastPageNumber = -2; // Giá trị không thể có để bắt đầu
        for (Integer pageNumber : pageNumbers) {
            if (pageNumber != lastPageNumber) {
                uniquePageNumbers.add(pageNumber);
                lastPageNumber = pageNumber;
            }
        }
        
        model.addAttribute("pageNumbers", uniquePageNumbers);
        
        return "admin/customer-mgr/all-customers";
    }

    @GetMapping("detail/{customerId}")
    public String getCustomerDetail(Model model, @PathVariable("customerId") Integer customerId) {
        Customer customer = customerService.findCustomerById(customerId);
        if (customer == null) {
            return "redirect:/admin/customer-mgr/list";
        }
        List<Address> addresses = customerService.findAddressesByCustomerId(customerId);
        List<Order> orders = customerService.findOrdersByCustomerId(customerId);
        model.addAttribute("orders", orders);
        model.addAttribute("addresses", addresses);
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
            @RequestParam("imageFile") MultipartFile imageFile) {

        if (bindingResult.hasErrors()) {
            return "admin/customer-mgr/form-customer";
        }
        // if (fileService.isValidFile(imageFile)) {
        // String nameImageFile = fileService.handleSaveUploadFile(imageFile,
        // "customer");
        // customer.setImageUrl("/resources/images-upload/customer/" + nameImageFile);
        // }
        try {
            if (fileUploadS3Service.isValidFile(imageFile)) {
                String nameImageFile = fileUploadS3Service.uploadFile(imageFile, "customers");
                customer.setImageUrl(nameImageFile);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (customer.getCustomerId() == null) {
            customer.setRegistrationDate(LocalDate.now());
        }
        customerService.saveCustomer(customer);
        return "redirect:/admin/customer-mgr/list";
    }

    @GetMapping("delete/{customerId}")
    public String deleteCustomer(@PathVariable("customerId") Integer customerId,
            RedirectAttributes redirectAttributes) {
        Customer customer = customerService.findCustomerById(customerId);
        if (customer.isStatus()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Khách hàng đang hoạt động không thể xóa.");
            return "redirect:/admin/customer-mgr/list";
        }
        try {
            customerService.deleteCustomerById(customerId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa khách hàng thành công!");
        } catch (CustomerInUseException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Không tìm thấy khách hàng để xóa hoặc lỗi không xác định.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi không mong muốn khi xóa khách hàng.");
        }
        return "redirect:/admin/customer-mgr/list";
    }
}
