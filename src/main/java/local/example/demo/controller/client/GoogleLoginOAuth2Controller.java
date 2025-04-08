package local.example.demo.controller.client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import local.example.demo.model.entity.Account;
import local.example.demo.service.AccountService;

@Controller
public class GoogleLoginOAuth2Controller {

    @Autowired
    private AccountService accountService;

    @GetMapping("/client/home")
    public String accountList(Model model, @AuthenticationPrincipal OAuth2User principal) {
        if (principal != null) {
            String email = principal.getAttribute("email");
            String name = principal.getAttribute("name");
            String googleId = principal.getAttribute("sub"); // ID duy nhất từ Google

            // Đồng bộ với database
            Account account = accountService.findOrCreateAccount(googleId, email, name);

        }
        return "client/home"; // Trả về trang danh sách account
    }
    
}
