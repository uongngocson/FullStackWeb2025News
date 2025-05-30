package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.service.AccountService;
import local.example.demo.service.RoleService;
import lombok.RequiredArgsConstructor;
import local.example.demo.exception.AccountInUseException;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/account-mgr/")
public class AccountMgrController {

    private final AccountService accountService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("list")
    public String listAccounts(Model model) {
        List<Account> accounts = accountService.getAllAccounts();
        model.addAttribute("accounts", accounts);
        return "admin/account-mgr/all-account";
    }

    @GetMapping("create")
    public String createAccount(Model model) {
        model.addAttribute("roles", roleService.getAllRoles());
        model.addAttribute("account", new Account());
        return "admin/account-mgr/form-account";
    }

    @GetMapping("update/{accountId}")
    public String updateAccount(Model model, @PathVariable("accountId") Integer accountId) {
        Account account = accountService.getAccountById(accountId);
        if (account == null || account.getRole() == null) {
            return "redirect:/admin/account-mgr/list";
        }
        model.addAttribute("roles", roleService.getAllRoles());
        model.addAttribute("account", account);
        return "admin/account-mgr/form-account";
    }

    @PostMapping("/save")
    public String saveAccount(@ModelAttribute("account") @Valid Account account, BindingResult result, Model model) {
        if (result.hasErrors()) {
            // Handle validation errors
            model.addAttribute("roles", roleService.getAllRoles());
            return "admin/account-mgr/form-account";
        }

        if (account.getAccountId() == null) {
            account.setPassword(passwordEncoder.encode(account.getPassword()));
            accountService.saveAccount(account);
        } else {
            // This is an existing account, handle password update conditionally
            Account existingAccount = accountService.getAccountById(account.getAccountId());
            if (existingAccount != null) {
                // Update other fields
                existingAccount.setLoginName(account.getLoginName());
                existingAccount.setRole(account.getRole());

                // Check if password is changed
                if (!account.getPassword().isEmpty() && !account.getPassword().equals(existingAccount.getPassword())) {
                    existingAccount.setPassword(passwordEncoder.encode(account.getPassword()));
                }
                accountService.saveAccount(existingAccount);
            }
        }
        return "redirect:/admin/account-mgr/list";
    }

    @PostMapping("delete/{accountId}")
    @ResponseBody
    public ResponseEntity<?> deleteAccount(@PathVariable("accountId") Integer accountId) {
        try {
            accountService.deleteAccountById(accountId);
            return ResponseEntity.ok().body("Account deleted successfully.");
        } catch (AccountInUseException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred.");
        }
    }
}