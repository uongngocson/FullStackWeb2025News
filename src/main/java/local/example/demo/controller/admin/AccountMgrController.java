package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String saveAccount(@ModelAttribute("account") @Valid Account account,
            BindingResult result,
            Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            // Handle validation errors
            model.addAttribute("roles", roleService.getAllRoles());
            return "admin/account-mgr/form-account";
        }

        try {
            if (account.getAccountId() == null) {
                // Trường hợp thêm mới
                account.setPassword(passwordEncoder.encode(account.getPassword()));
                try {
                    accountService.saveAccount(account);
                    redirectAttributes.addFlashAttribute("successMessage", "Thêm mới tài khoản thành công!");
                } catch (AccountInUseException e) {
                    model.addAttribute("roles", roleService.getAllRoles());
                    model.addAttribute("errorMessage", e.getMessage());
                    return "admin/account-mgr/form-account";
                }
            } else {
                // Trường hợp cập nhật
                Account existingAccount = accountService.getAccountById(account.getAccountId());
                if (existingAccount != null) {
                    if (!account.getLoginName().equals(existingAccount.getLoginName())) {
                        // Update other fields
                        existingAccount.setLoginName(account.getLoginName());
                        existingAccount.setRole(account.getRole());

                        // Check if password is changed
                        if (!account.getPassword().isEmpty()
                                && !account.getPassword().equals(existingAccount.getPassword())) {
                            existingAccount.setPassword(passwordEncoder.encode(account.getPassword()));
                        }
                        try {
                            accountService.saveAccount(account);
                            redirectAttributes.addFlashAttribute("successMessage",
                                    "Cập nhật thông tin tài khoản thành công!");
                        } catch (AccountInUseException e) {
                            model.addAttribute("roles", roleService.getAllRoles());
                            model.addAttribute("errorMessage", e.getMessage());
                            return "admin/account-mgr/form-account";
                        }
                    } else {
                        // Update other fields
                        existingAccount.setLoginName(account.getLoginName());
                        existingAccount.setRole(account.getRole());

                        // Check if password is changed
                        if (!account.getPassword().isEmpty()
                                && !account.getPassword().equals(existingAccount.getPassword())) {
                            existingAccount.setPassword(passwordEncoder.encode(account.getPassword()));
                        }
                        accountService.updateAccount(existingAccount);
                        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật tài khoản thành công!");
                    }
                }
            }
            return "redirect:/admin/account-mgr/list";
        } catch (AccountInUseException e) {
            // Xử lý lỗi login name trùng
            model.addAttribute("roles", roleService.getAllRoles());
            model.addAttribute("errorMessage", e.getMessage());
            return "admin/account-mgr/form-account";
        } catch (IllegalArgumentException e) {
            // Xử lý lỗi không tìm thấy tài khoản
            model.addAttribute("roles", roleService.getAllRoles());
            model.addAttribute("errorMessage", e.getMessage());
            return "admin/account-mgr/form-account";
        } catch (Exception e) {
            // Xử lý các lỗi khác
            model.addAttribute("roles", roleService.getAllRoles());
            model.addAttribute("errorMessage", "Có lỗi xảy ra trong quá trình xử lý. Vui lòng thử lại!");
            return "admin/account-mgr/form-account";
        }
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