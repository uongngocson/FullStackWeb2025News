package local.example.demo.controller.shipper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import local.example.demo.model.dto.LoginRequest;
import local.example.demo.model.dto.ApiResponse;
import local.example.demo.model.dto.ForgotPasswordRequest;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Role;
import local.example.demo.repository.AccountRepository;
import local.example.demo.service.AccountService;
import local.example.demo.service.EmployeeService;
import lombok.RequiredArgsConstructor;
import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/shipper")
@RequiredArgsConstructor
public class LoginShipperController {
    
    private final AccountService accountService;
    private final PasswordEncoder passwordEncoder;
    private final EmployeeService employeeService;
    private final AccountRepository accountRepository;
    private final AuthenticationManager authenticationManager;
    
    /**
     * DTO for updating shipper profile
     */
    @Data
    public static class UpdateProfileRequest {
        @NotBlank(message = "First name is required")
        @Size(max = 50, message = "First name must not exceed 50 characters")
        private String firstName;
        
        @NotBlank(message = "Last name is required")
        @Size(max = 50, message = "Last name must not exceed 50 characters")
        private String lastName;
        
        @NotBlank(message = "Email is required")
        @Email(message = "Invalid email format")
        private String email;
        
        @Size(max = 15, message = "Phone number must not exceed 15 characters")
        private String phone;
        
        private String imageUrl;
    }
    
    /**
     * DTO for changing password
     */
    @Data
    public static class ChangePasswordRequest {
        @NotBlank(message = "Current password is required")
        private String currentPassword;
        
        @NotBlank(message = "New password is required")
        @Size(min = 6, message = "New password must be at least 6 characters")
        private String newPassword;
        
        @NotBlank(message = "Confirm password is required")
        private String confirmPassword;
    }
    
    /**
     * Endpoint for shipper login
     * @param loginRequest contains username and password
     * @return ResponseEntity with user data and status
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            // Authenticate user
            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                    loginRequest.getUsername(), 
                    loginRequest.getPassword()
                )
            );
            
            // Set authentication in security context
            SecurityContextHolder.getContext().setAuthentication(authentication);
            
            // Get account details
            Account account = accountService.getAccountByLoginName(loginRequest.getUsername());
            if (account == null) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(false, "Account not found"));
            }
            
            // Verify that this account belongs to an employee (shipper)
            Employee employee = employeeService.getEmployeeByAccount(account);
            if (employee == null) {
                return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(new ApiResponse(false, "Account is not associated with any employee"));
            }
            
            // Check if employee has a shipper role
            Role role = account.getRole();
            if (role == null || !role.getRoleName().equalsIgnoreCase("SHIPPER")) {
                return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(new ApiResponse(false, "Account does not have shipper privileges"));
            }
            
            // Prepare response data
            Map<String, Object> userData = new HashMap<>();
            userData.put("id", employee.getEmployeeId());
            userData.put("firstName", employee.getFirstName());
            userData.put("lastName", employee.getLastName());
            userData.put("fullName", employee.getFirstName() + " " + employee.getLastName());
            userData.put("email", employee.getEmail());
            userData.put("phone", employee.getPhone());
            userData.put("imageUrl", employee.getImageUrl());
            userData.put("role", role.getRoleName());
            
            return ResponseEntity.ok(new ApiResponse(true, "Login successful", userData));
            
        } catch (BadCredentialsException e) {
            return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .body(new ApiResponse(false, "Invalid username or password"));
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiResponse(false, "An error occurred: " + e.getMessage()));
        }
    }
    
    /**
     * Get shipper profile by ID
     * @param id the employee ID
     * @return ResponseEntity with shipper profile data
     */
    @GetMapping("/profile/{id}")
    public ResponseEntity<?> getProfile(@PathVariable Integer id) {
        try {
            Employee employee = employeeService.getEmployeeById(id);
            if (employee == null) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(false, "Shipper not found"));
            }
            
            // Verify this is a shipper
            Account account = employee.getAccount();
            if (account == null || account.getRole() == null || 
                !account.getRole().getRoleName().equalsIgnoreCase("SHIPPER")) {
                return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(new ApiResponse(false, "Employee is not a shipper"));
            }
            
            // Prepare response data
            Map<String, Object> profileData = new HashMap<>();
            profileData.put("id", employee.getEmployeeId());
            profileData.put("firstName", employee.getFirstName());
            profileData.put("lastName", employee.getLastName());
            profileData.put("fullName", employee.getFirstName() + " " + employee.getLastName());
            profileData.put("email", employee.getEmail());
            profileData.put("phone", employee.getPhone());
            profileData.put("imageUrl", employee.getImageUrl());
            profileData.put("role", account.getRole().getRoleName());
            
            return ResponseEntity.ok(new ApiResponse(true, "Profile retrieved successfully", profileData));
            
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiResponse(false, "An error occurred: " + e.getMessage()));
        }
    }
    
    /**
     * Update shipper profile
     * @param id the employee ID
     * @param request the update profile request
     * @return ResponseEntity with updated profile data
     */
    @PutMapping("/profile/{id}")
    public ResponseEntity<?> updateProfile(@PathVariable Integer id, 
                                         @Valid @RequestBody UpdateProfileRequest request) {
        try {
            Employee employee = employeeService.getEmployeeById(id);
            if (employee == null) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(false, "Shipper not found"));
            }
            
            // Verify this is a shipper
            Account account = employee.getAccount();
            if (account == null || account.getRole() == null || 
                !account.getRole().getRoleName().equalsIgnoreCase("SHIPPER")) {
                return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(new ApiResponse(false, "Employee is not a shipper"));
            }
            
            // Update employee information
            employee.setFirstName(request.getFirstName());
            employee.setLastName(request.getLastName());
            employee.setEmail(request.getEmail());
            employee.setPhone(request.getPhone());
            if (request.getImageUrl() != null) {
                employee.setImageUrl(request.getImageUrl());
            }
            
            // Save updated employee
            Employee updatedEmployee = employeeService.saveEmployee(employee);
            
            // Prepare response data
            Map<String, Object> updatedData = new HashMap<>();
            updatedData.put("id", updatedEmployee.getEmployeeId());
            updatedData.put("firstName", updatedEmployee.getFirstName());
            updatedData.put("lastName", updatedEmployee.getLastName());
            updatedData.put("fullName", updatedEmployee.getFirstName() + " " + updatedEmployee.getLastName());
            updatedData.put("email", updatedEmployee.getEmail());
            updatedData.put("phone", updatedEmployee.getPhone());
            updatedData.put("imageUrl", updatedEmployee.getImageUrl());
            updatedData.put("role", account.getRole().getRoleName());
            
            return ResponseEntity.ok(new ApiResponse(true, "Profile updated successfully", updatedData));
            
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiResponse(false, "An error occurred: " + e.getMessage()));
        }
    }
    
    /**
     * Change shipper password
     * @param id the employee ID
     * @param request the change password request
     * @return ResponseEntity with status message
     */
    @PutMapping("/change-password/{id}")
    public ResponseEntity<?> changePassword(@PathVariable Integer id, 
                                          @Valid @RequestBody ChangePasswordRequest request) {
        try {
            Employee employee = employeeService.getEmployeeById(id);
            if (employee == null) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(false, "Shipper not found"));
            }
            
            // Verify this is a shipper
            Account account = employee.getAccount();
            if (account == null || account.getRole() == null || 
                !account.getRole().getRoleName().equalsIgnoreCase("SHIPPER")) {
                return ResponseEntity
                    .status(HttpStatus.FORBIDDEN)
                    .body(new ApiResponse(false, "Employee is not a shipper"));
            }
            
            // Validate new password confirmation
            if (!request.getNewPassword().equals(request.getConfirmPassword())) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body(new ApiResponse(false, "New password and confirm password do not match"));
            }
            
            // Verify current password
            if (!passwordEncoder.matches(request.getCurrentPassword(), account.getPassword())) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body(new ApiResponse(false, "Current password is incorrect"));
            }
            
            // Check if new password is the same as current password
            if (passwordEncoder.matches(request.getNewPassword(), account.getPassword())) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body(new ApiResponse(false, "New password must be different from current password"));
            }
            
            // Update password
            String encodedNewPassword = passwordEncoder.encode(request.getNewPassword());
            account.setPassword(encodedNewPassword);
            accountRepository.save(account);
            
            return ResponseEntity.ok(new ApiResponse(true, "Password changed successfully"));
            
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiResponse(false, "An error occurred: " + e.getMessage()));
        }
    }
    
    /**
     * Endpoint for password recovery
     * @param request contains username and email
     * @return ResponseEntity with status message
     */
    @PostMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request) {
        try {
            Account account = accountRepository.findByLoginName(request.getUsername());
            
            if (account == null) {
                return ResponseEntity
                    .status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(false, "Account not found with the provided username"));
            }
            
            // Verify email matches the employee record
            Employee employee = employeeService.getEmployeeByAccount(account);
            if (employee == null || !employee.getEmail().equals(request.getEmail())) {
                return ResponseEntity
                    .status(HttpStatus.BAD_REQUEST)
                    .body(new ApiResponse(false, "Email does not match records for this account"));
            }
            
            // Generate new password
            String newPassword = AccountService.generateRandomPassword();
            
            // Update password in database
            String encodedPassword = passwordEncoder.encode(newPassword);
            account.setPassword(encodedPassword);
            accountRepository.save(account);
            
            // Send email with new password
            accountService.sendNewPassword(request.getEmail(), newPassword);
            
            return ResponseEntity.ok(new ApiResponse(true, "A new password has been sent to your email"));
            
        } catch (Exception e) {
            return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ApiResponse(false, "An error occurred: " + e.getMessage()));
        }
    }
}
