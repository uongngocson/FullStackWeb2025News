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
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Shop;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.FileService;
import local.example.demo.service.ShopService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/employee-mgr/")
public class EmployeeMgrController {
    private final EmployeeService employeeService;
    private final ShopService shopService;
    private final FileService fileService;

    @GetMapping("list")
    public String index() {
        return "admin/employee-mgr/all-employees";
    }

    @ModelAttribute("employees")
    public List<Employee> getAllEmployees() {
        return employeeService.getAllEmployees();
    }

    @ModelAttribute("managers")
    public List<Employee> getAllManagers() {
        return employeeService.getAllEmployees();
    }

    @ModelAttribute("shops")
    public List<Shop> getAllShops() {
        return shopService.findAllShops();
    }

    @GetMapping("detail/{employeeId}")
    public String detail(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        model.addAttribute("employee", employee);
        return "admin/employee-mgr/detail-employee";
    }

    @GetMapping("create")
    public String create(Model model) {
        model.addAttribute("employee", new Employee());
        return "admin/employee-mgr/form-employee";
    }

    @GetMapping("update/{employeeId}")
    public String update(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        model.addAttribute("employee", employee);
        return "admin/employee-mgr/form-employee";
    }

    // save employee
    @PostMapping("save")
    public String save(@ModelAttribute("employee") @Valid Employee employee, BindingResult bindingResult,
            @RequestParam("profileImageFile") MultipartFile profileImageFile, Model model) {
        if (bindingResult.hasErrors()) {
            return "admin/employee-mgr/form-employee";
        }

        if (fileService.isValidFile(profileImageFile)) {
            String imageUrl = fileService.handleSaveUploadFile(profileImageFile, "employee");
            employee.setProfileImage("/resources/images-upload/employee/" + imageUrl);
        }

        employeeService.saveEmployee(employee);
        return "redirect:/admin/employee-mgr/list";
    }

    @GetMapping("delete/{employeeId}")
    public String delete(@PathVariable("employeeId") Integer employeeId) {
        employeeService.deleteEmployee(employeeId);
        return "redirect:/admin/employee-mgr/list";
    }
}
