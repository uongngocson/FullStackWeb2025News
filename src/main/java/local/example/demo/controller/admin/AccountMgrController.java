package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
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
    
    private static final int DEFAULT_PAGE_SIZE = 20;

    @GetMapping("list")
    public String listAccounts(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "20") int size,
            Model model) {
        
        // Giới hạn kích thước trang để tránh quá tải
        size = Math.min(size, 100);
        
        // Sử dụng phân trang để tải dữ liệu hiệu quả
        Page<Account> accountPage = accountService.getAllAccountsPaginated(page, size);
        
        model.addAttribute("accounts", accountPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", accountPage.getTotalPages());
        model.addAttribute("totalItems", accountPage.getTotalElements());
        model.addAttribute("pageSize", size);
        
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

    @PostMapping("save")
    public String saveAccount(@ModelAttribute("account") @Valid Account account, BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("roles", roleService.getAllRoles());
            return "admin/account-mgr/form-account";
        }
        
        // Chỉ mã hóa mật khẩu khi nó không rỗng (để tránh mã hóa lại mật khẩu đã mã hóa)
        if (account.getPassword() != null && !account.getPassword().isEmpty() && !account.getPassword().startsWith("$2a$")) {
            account.setPassword(passwordEncoder.encode(account.getPassword()));
        }
        
        accountService.saveAccount(account);
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