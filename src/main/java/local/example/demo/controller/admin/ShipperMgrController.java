package local.example.demo.controller.admin;

import java.util.List;
import java.util.stream.Collectors;

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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Employee;
import local.example.demo.service.AccountService;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.FileService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/shipper-mgr/")
public class ShipperMgrController {
    private final EmployeeService employeeService;
    private final FileService fileService;
    private final AccountService accountService;

    @GetMapping("list")
    public String getEmployeesList() {
        return "admin/shipper-mgr/all-employees";
    }

    // get all employees with SHIPPER role
    @ModelAttribute("employees")
    public List<Employee> getAllEmployees() {
        // Get all employees then filter those with SHIPPER role
        return employeeService.getAllEmployees().stream()
                .filter(employee -> employee.getAccount() != null 
                        && employee.getAccount().getRole() != null 
                        && "SHIPPER".equals(employee.getAccount().getRole().getRoleName()))
                .collect(Collectors.toList());
    }

    // get managers with SHIPPER role
    @ModelAttribute("managers")
    public List<Employee> getManager() {
        // Get all employees then filter those with SHIPPER role
        return employeeService.getAllEmployees().stream()
                .filter(employee -> employee.getAccount() != null 
                        && employee.getAccount().getRole() != null 
                        && "SHIPPER".equals(employee.getAccount().getRole().getRoleName()))
                .collect(Collectors.toList());
    }

    @ModelAttribute("accounts")
    public List<Account> getAccountsNotLinkedToEmployee() {
        // Get accounts not linked to employee but filter those with SHIPPER role
        return accountService.findAccountsNotLinkedToEmployee().stream()
                .filter(account -> account.getRole() != null 
                        && "SHIPPER".equals(account.getRole().getRoleName()))
                .collect(Collectors.toList());
    }

    @GetMapping("detail/{employeeId}")
    public String detailEmployee(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        // Verify that the employee has the SHIPPER role
        if (employee != null && employee.getAccount() != null 
                && employee.getAccount().getRole() != null 
                && "SHIPPER".equals(employee.getAccount().getRole().getRoleName())) {
            model.addAttribute("employee", employee);
            return "admin/shipper-mgr/detail-employee";
        }
        // Redirect if not a shipper
        return "redirect:/admin/shipper-mgr/list";
    }

    @GetMapping("create")
    public String createEmployee(Model model) {
        model.addAttribute("employee", new Employee());
        return "admin/shipper-mgr/form-employee";
    }

    @GetMapping("update/{employeeId}")
    public String updateEmployee(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        
        // Verify that the employee has the SHIPPER role
        if (employee != null && employee.getAccount() != null 
                && employee.getAccount().getRole() != null 
                && "SHIPPER".equals(employee.getAccount().getRole().getRoleName())) {
            
            model.addAttribute("employee", employee);
    
            // Lấy danh sách các tài khoản chưa được liên kết và có role SHIPPER
            List<Account> availableAccounts = accountService.findAccountsNotLinkedToEmployee().stream()
                    .filter(account -> account.getRole() != null 
                            && "SHIPPER".equals(account.getRole().getRoleName()))
                    .collect(Collectors.toList());
    
            // Nếu nhân viên hiện tại đã có tài khoản, và tài khoản đó không có trong danh
            // sách availableAccounts,
            // thì thêm nó vào để nó có thể được chọn trên form.
            if (employee.getAccount() != null) {
                boolean accountExistsInList = availableAccounts.stream()
                        .anyMatch(acc -> acc.getAccountId().equals(employee.getAccount().getAccountId()));
                if (!accountExistsInList) {
                    availableAccounts.add(employee.getAccount());
                }
            }
            model.addAttribute("accounts", availableAccounts);
    
            return "admin/shipper-mgr/form-employee";
        }
        
        // Redirect if not a shipper
        return "redirect:/admin/shipper-mgr/list";
    }

    // save employee
    @PostMapping("save")
    public String saveEmployee(@ModelAttribute("employee") @Valid Employee employee, BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile, Model model) {
        if (bindingResult.hasErrors()) {
            return "admin/shipper-mgr/form-employee";
        }

        // Ensure the employee has an account with SHIPPER role
        if (employee.getAccount() != null && employee.getAccount().getRole() != null 
                && !"SHIPPER".equals(employee.getAccount().getRole().getRoleName())) {
            model.addAttribute("errorMessage", "Chỉ có thể lưu nhân viên với vai trò SHIPPER.");
            return "admin/shipper-mgr/form-employee";
        }

        if (fileService.isValidFile(imageFile)) {
            String imageUrl = fileService.handleSaveUploadFile(imageFile, "employee");
            employee.setImageUrl("/resources/images-upload/employee/" + imageUrl);
        }

        employeeService.saveEmployee(employee);
        return "redirect:/admin/shipper-mgr/list";
    }

    // delete employee
    @PostMapping("delete/{employeeId}")
    public String deleteEmployee(HttpServletRequest request, @PathVariable("employeeId") Integer employeeId,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        try {
            Employee employee = employeeService.getEmployeeById(employeeId);
            
            // Verify that the employee has the SHIPPER role
            if (employee == null || employee.getAccount() == null 
                    || employee.getAccount().getRole() == null 
                    || !"SHIPPER".equals(employee.getAccount().getRole().getRoleName())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Chỉ có thể xóa nhân viên với vai trò SHIPPER.");
                return "redirect:/admin/shipper-mgr/list";
            }
            
            // Lấy ID của nhân viên đang đăng nhập từ session
            Integer loggedInEmployeeId = (Integer) session.getAttribute("employeeId");

            // Kiểm tra nếu nhân viên đang cố gắng xóa chính mình
            if (loggedInEmployeeId != null && loggedInEmployeeId.equals(employeeId)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không thể xóa chính mình.");
                return "redirect:/admin/shipper-mgr/list";
            }

            // Kiểm tra xem nhân viên có đang quản lý nhân viên khác không
            // Hoặc có ràng buộc nào khác không cho phép xóa (ví dụ: đang có task
            // active,...)
            // Ví dụ đơn giản: nếu nhân viên có status là active thì không cho xóa
            if (employee.isStatus()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa nhân viên đang hoạt động.");
                return "redirect:/admin/shipper-mgr/list";
            }

            employeeService.deleteEmployee(employeeId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhân viên thành công!");
        } catch (Exception e) {
            // Log lỗi ở đây nếu cần thiết
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi khi xóa nhân viên: " + e.getMessage());
        }
        return "redirect:/admin/shipper-mgr/list";
    }
}
