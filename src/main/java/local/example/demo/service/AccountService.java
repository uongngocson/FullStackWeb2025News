package local.example.demo.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.exception.AccountInUseException;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Employee;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;

import java.security.SecureRandom;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final RoleService roleService;
    private final CustomerRepository customerRepository; // Inject CustomerRepository
    private final EmployeeRepository employeeRepository; // Inject EmployeeRepository
    
    private static final int DEFAULT_PAGE_SIZE = 20;

    // Phương thức cũ - giữ lại để tương thích ngược
    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }
    
    // Phương thức mới với phân trang
    public Page<Account> getAllAccountsPaginated(int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("accountId").ascending());
        return accountRepository.findAllAccountsPaginated(pageable);
    }

    public Account getAccountById(Integer id) {
        // Sử dụng phương thức tối ưu để lấy tài khoản với role đã được nạp
        return accountRepository.findByIdWithRole(id).orElse(null);
    }

    private final PasswordEncoder passwordEncoder;

    public void saveAccount(Account account) {
        accountRepository.save(account);
    }

    @Transactional // Thêm @Transactional để đảm bảo tính nhất quán
    public void deleteAccountById(Integer id) {
        Account account = accountRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Account not found with ID: " + id));

        // Kiểm tra liên kết với Customer
        Customer customer = customerRepository.findByAccount(account);
        if (customer != null) {
            throw new AccountInUseException("Cannot delete account: It is associated with customer "
                    + customer.getFirstName() + " " + customer.getLastName());
        }

        // Kiểm tra liên kết với Employee
        Employee employee = employeeRepository.findByAccount(account);
        if (employee != null) {
            throw new AccountInUseException("Cannot delete account: It is associated with employee "
                    + employee.getFirstName() + " " + employee.getLastName());
        }

        accountRepository.deleteById(id);
    }

    public boolean existsByLoginName(String loginName) {
        return accountRepository.existsByLoginName(loginName);
    }

    public Account getAccountByLoginName(String loginName) {
        return accountRepository.findByLoginName(loginName);
    }

    public Optional<Account> getAccountWithRoleByLoginName(String loginName) {
        return accountRepository.findByLoginNameWithRole(loginName);
    }

    public Customer mapOAuth2UserToCustomer(OAuth2User principal, String provider) {
        Customer customer = new Customer();

        // Full name
        String name = principal.getAttribute("name");
        if (name != null) {
            String[] nameParts = name.split(" ");
            if (nameParts.length >= 1)
                customer.setFirstName(nameParts[0]);
            if (nameParts.length >= 2)
                customer.setLastName(nameParts[nameParts.length - 1]);
        }

        // Nếu provider là Google
        if ("google".equalsIgnoreCase(provider)) {
            String email = principal.getAttribute("email");
            String firstName = principal.getAttribute("given_name");
            String lastName = principal.getAttribute("family_name");
            String picture = principal.getAttribute("picture");

            if (email != null)
                customer.setEmail(email);
            if (firstName != null)
                customer.setFirstName(firstName);
            if (lastName != null)
                customer.setLastName(lastName);
            if (picture != null)
                customer.setImageUrl(picture);
        }

        // Nếu provider là Facebook
        else if ("facebook".equalsIgnoreCase(provider)) {
            String email = principal.getAttribute("email");
            String firstName = principal.getAttribute("first_name");
            String lastName = principal.getAttribute("last_name");

            if (email != null)
                customer.setEmail(email);
            if (firstName != null)
                customer.setFirstName(firstName);
            if (lastName != null)
                customer.setLastName(lastName);

            // Lấy ảnh đại diện từ Facebook
            try {
                Map<String, Object> pictureObj = principal.getAttribute("picture");
                if (pictureObj != null && pictureObj instanceof Map) {
                    Map<String, Object> pictureData = (Map<String, Object>) ((Map<String, Object>) pictureObj).get("data");
                    if (pictureData != null) {
                        String avatarUrl = (String) pictureData.get("url");
                        if (avatarUrl != null) {
                            customer.setImageUrl(avatarUrl);
                        }
                    }
                }
            } catch (Exception e) {
                // Trường hợp Facebook không trả ảnh
                System.out.println("Không lấy được ảnh đại diện từ Facebook: " + e.getMessage());
            }
        }

        customer.setRegistrationDate(LocalDate.now()); // Gán ngày đăng ký

        return customer;
    }

    @Transactional
    public Account findOrCreateAccount(OAuth2User principal, String provider) {
        String email = principal.getAttribute("email");
        String id = null;
        boolean isFacebook = false;

        if ("google".equalsIgnoreCase(provider)) {
            id = principal.getAttribute("sub");
            // Đảm bảo email luôn có giá trị khi đăng nhập bằng Google
            if (email == null || email.isBlank()) {
                throw new IllegalStateException("Email is required for Google authentication");
            }
        } else if ("facebook".equalsIgnoreCase(provider)) {
            id = principal.getAttribute("id");
            isFacebook = true;
            
            // Log để debug
            System.out.println("Facebook login - ID: " + id);
            System.out.println("Facebook login - Email: " + email);
            System.out.println("Facebook login - Name: " + principal.getAttribute("name"));
        }

        // Tìm tài khoản theo email hoặc ID
        Account account = null;
        
        // Nếu có email, thử tìm theo email trước
        if (email != null && !email.isBlank()) {
            account = accountRepository.findByLoginName(email);
        }
        
        // Nếu không tìm thấy bằng email và đây là Facebook, thử tìm bằng ID
        if (account == null && isFacebook && id != null) {
            account = accountRepository.findByLoginName(id);
        }

        if (account != null) {
            System.out.println("Found existing account: " + account.getLoginName());
            return account;
        }

        // Tạo tài khoản mới
        String loginName;
        if (email != null && !email.isBlank()) {
            // Ưu tiên sử dụng email làm loginName
            loginName = email;
        } else if (isFacebook && id != null) {
            // Nếu không có email và là Facebook, sử dụng ID
            loginName = id;
        } else {
            throw new IllegalStateException("Cannot create account: No email or ID available");
        }
        
        String rawPassword;
        if ("google".equalsIgnoreCase(provider) && email != null && email.length() >= 7) {
            // Lấy 7 ký tự đầu của email làm mật khẩu cho Google
            rawPassword = email.substring(0, 7);
        } else if ("google".equalsIgnoreCase(provider)) {
            // Trường hợp email ngắn hơn 7 ký tự (hiếm gặp)
            rawPassword = email;
        } else if (isFacebook && id != null && id.length() >= 7) {
            // Lấy 7 ký tự đầu của ID Facebook làm mật khẩu
            rawPassword = id.substring(0, 7);
        } else if (isFacebook && id != null) {
            // Trường hợp ID Facebook ngắn hơn 7 ký tự (hiếm gặp)
            rawPassword = id;
        } else {
            // Fallback - tạo mật khẩu ngẫu nhiên
            rawPassword = generateRandomPassword();
        }
        
        System.out.println("Creating new account with login name: " + loginName);
        String encodedPassword = passwordEncoder.encode(rawPassword);

        Account newAccount = new Account();
        newAccount.setLoginName(loginName);
        newAccount.setPassword(encodedPassword);
        newAccount.setRole(roleService.getRoleById(1)); // CUSTOMER mặc định

        Account savedAccount = accountRepository.save(newAccount);

        // Tạo và lưu Customer
        Customer customer = mapOAuth2UserToCustomer(principal, provider);
        customer.setAccount(savedAccount);
        customerRepository.save(customer);

        return savedAccount;
    }

    // Tối ưu phương thức này để sử dụng phân trang nếu cần
    public List<Account> findAccountsNotLinkedToEmployee() {
        return accountRepository.findAccountsNotLinkedToEmployee();
    }

    // mapper registerDTO to account
    public Account mapRegisterDTOToAccount(RegisterDTO registerDTO) {
        Account account = new Account();
        account.setLoginName(registerDTO.getLoginName());
        account.setPassword(registerDTO.getPassword());
        return account;
    }

    @Autowired
    private JavaMailSender mailSender;

    public void sendNewPassword(String toEmail, String code) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("New Password");

            String htmlContent = "<!DOCTYPE html>" +
                    "<html><head><style>" +
                    "body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #f4f4f4; padding: 20px; }" +
                    ".container { background-color: #ffffff; max-width: 600px; margin: auto; padding: 30px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }"
                    +
                    ".title { font-size: 24px; font-weight: bold; color: #333; margin-bottom: 20px; }" +
                    ".text { font-size: 16px; color: #555; line-height: 1.5; }" +
                    ".password-box { margin: 30px 0; padding: 15px; background-color: #007BFF; color: white; font-size: 20px; font-weight: bold; border-radius: 8px; text-align: center; letter-spacing: 2px; }"
                    +
                    ".footer { font-size: 12px; color: #aaa; text-align: center; margin-top: 30px; }" +
                    "</style></head><body>" +
                    "<div class='container'>" +
                    "<div class='title'>🔐 Mật khẩu mới của bạn</div>" +
                    "<div class='text'>Chào bạn,<br><br>Mật khẩu mới đã được tạo cho tài khoản của bạn. Vui lòng sử dụng mật khẩu dưới đây để đăng nhập:</div>"
                    +
                    "<div class='password-box'>" + code + "</div>" +
                    "<div class='text'>Sau khi đăng nhập, bạn nên đổi mật khẩu này để đảm bảo an toàn.<br><br>Nếu bạn không yêu cầu cấp lại mật khẩu, hãy bỏ qua email này.</div>"
                    +
                    "<div class='footer'>&copy; 2025 AlphaMart - Bảo mật là ưu tiên hàng đầu của chúng tôi.</div>" +
                    "</div></body></html>";

            helper.setText(htmlContent, true); // Enable HTML

            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send new password", e);
        }
    }

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int PASSWORD_LENGTH = 10;

    public static String generateRandomPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(PASSWORD_LENGTH);
        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            password.append(CHARACTERS.charAt(index));
        }
        return password.toString();
    }
}
