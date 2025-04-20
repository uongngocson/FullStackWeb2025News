package local.example.demo.controller.client;

import javax.naming.Binding;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.validation.Valid;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.RoleService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/client/auth/")
public class AuthenticationController {

    private final AccountService accountService;
    private final CustomerService customerService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    @PostMapping("login")
    public String login() {
        return "client/auth/login";
    }

    @GetMapping("register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("register")
    public String register(Model model, @Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "REGISTRATION FAILED!");
            return "client/auth/register";
        }
        // hashing password
        registerDTO.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        // save account and customer object
        Account account = this.accountService.mapRegisterDTOToAccount(registerDTO);
        Customer customer = this.customerService.mapRegisterDTOToCustomer(registerDTO);
        account.setRole(roleService.getRoleById(1)); // set role for account object default is 1-CUSTOMER
        this.accountService.saveAccount(account);
        accountService.getAccountByLoginName(account.getLoginName());
        customer.setAccount(account); // set account for customer object
        this.customerService.saveCustomer(customer);
        return "redirect:/client/auth/register";
    }
}
