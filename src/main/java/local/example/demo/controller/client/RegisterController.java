package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.repository.AccountRepository;
import local.example.demo.service.RegisterService;

@Controller
@RequestMapping("/client/auth/")
public class RegisterController {

    @Autowired
    private RegisterService registerService;

    @Autowired
    private AccountRepository accountRepository;

    @GetMapping("register")
    public String showRegisterForm(Model model) {
        model.addAttribute("account", new Account());
        return "client/auth/register"; // Trả về trang đăng ký
    }

    @PostMapping("register")
    public String doRegister(@Valid @ModelAttribute("account") Account account,
                            BindingResult bindingResult,
                            @RequestParam("confirmPassword") String confirmPassword,
                            @RequestParam("email") String email,
                            HttpSession session,
                            Model model) {

        // Map để lưu lỗi cho từng field
        Map<String, String> errors = new HashMap<>();

        // Kiểm tra validation từ BindingResult (cho loginName và password)
        if (bindingResult.hasErrors()) {
            bindingResult.getFieldErrors().forEach(error -> 
                errors.put(error.getField(), error.getDefaultMessage())
            );
            model.addAttribute("errors", errors);
            model.addAttribute("account", account);
            return "client/auth/register";
        }

        // Kiểm tra confirmPassword
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Xác nhận mật khẩu không được để trống");
        } else if (!account.getPassword().equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu không khớp");
        }

        // Kiểm tra email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.put("email", "Email không hợp lệ");
        }

        // Kiểm tra loginName đã tồn tại
        if (accountRepository.findByLoginName(account.getLoginName()).isPresent()) {
            errors.put("loginName", "Tên đăng nhập đã tồn tại");
        }

        // Nếu có lỗi, trả về form với các lỗi riêng
        if (!errors.isEmpty()) {
            model.addAttribute("errors", errors);
            model.addAttribute("account", account);
            return "client/auth/register";
        }

        // Lưu thông tin tạm vào session và gửi mã xác nhận
        String code = registerService.generateVerificationCode();
        session.setAttribute("verificationCode", code);
        session.setAttribute("pendingAccount", account);
        session.setAttribute("pendingEmail", email);


        try {
            registerService.sendVerificationCode(email, code);
        } catch (Exception e) {
            errors.put("email", "Không thể gửi email xác nhận. Vui lòng thử lại.");
            model.addAttribute("errors", errors);
            model.addAttribute("account", account);
            return "client/auth/register";
        }

        return "redirect:/client/auth/register-auth";
    }

    @GetMapping("register-auth")
    public String showVerificationForm() {
        return "client/auth/register-auth"; // Trả về trang nhập mã xác nhận
    }

    @PostMapping("register-auth")
    public String verifyCode(@RequestParam("verificationCode") String verificationCode,
                            HttpSession session,
                            Model model) {
        // Lấy thông tin từ session
        String storedCode = (String) session.getAttribute("verificationCode");
        Account pendingAccount = (Account) session.getAttribute("pendingAccount");
        String email = (String) session.getAttribute("pendingEmail");

        // Kiểm tra nếu session không có dữ liệu (hết hạn hoặc truy cập trực tiếp)
        if (storedCode == null || pendingAccount == null || email == null ) {
            model.addAttribute("verificationError", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại.");
            return "client/auth/register-auth";
        }

        // Kiểm tra mã xác nhận
        if (!storedCode.equals(verificationCode)) {
            model.addAttribute("verificationError", "Mã xác nhận không đúng");
            return "client/auth/register-auth";
        }

        // Lưu Account và Customer
        try {
            Account savedAccount = registerService.saveAccount(pendingAccount);
            registerService.saveCustomer(email, savedAccount);

            // Xóa session sau khi thành công
            session.removeAttribute("verificationCode");
            session.removeAttribute("pendingAccount");
            session.removeAttribute("pendingEmail");

            return "account-mgr/list";
        } catch (Exception e) {
            model.addAttribute("verificationError", "Đã xảy ra lỗi khi lưu tài khoản. Vui lòng thử lại." + e.getMessage());
            return "client/auth/register-auth";
        }

    }
    @GetMapping("resend-verification")
    public String resendVerificationCode(HttpSession session, Model model) {
        String email = (String) session.getAttribute("pendingEmail");
        Account pendingAccount = (Account) session.getAttribute("pendingAccount");

        // Kiểm tra session còn hợp lệ không
        if (email == null || pendingAccount == null ) {
            // Chuyển hướng về trang đăng ký khi session hết hạn
            model.addAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại.");
            model.addAttribute("account", new Account()); // Cần cho form
            return "client/auth/register"; // Redirect về trang đăng ký
        }

        // Tạo và gửi mã xác nhận mới
        String newCode = registerService.generateVerificationCode();
        session.setAttribute("verificationCode", newCode);

        try {
            registerService.sendVerificationCode(email, newCode);
            model.addAttribute("message", "Mã xác nhận mới đã được gửi đến email của bạn.");
        } catch (Exception e) {
            model.addAttribute("verificationError", "Không thể gửi mã xác nhận. Vui lòng thử lại.");
        }

        return "/account-mgr/list";
    }
}
