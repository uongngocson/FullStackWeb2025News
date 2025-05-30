package local.example.demo.service;

import java.util.Collections;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Employee;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomUserDetailService implements UserDetailsService {
    private final AccountService accountService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private EmployeeService employeeService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Find account with role
        Account account = accountService.getAccountByLoginName(username);
        if (account == null) {
            throw new UsernameNotFoundException("User not found with username: " + username);
        }
        boolean isCustomer = false;
        boolean isEmployee = false;
        // Check if the account is a valid customer
        Customer customer = customerService.getCustomerByAccount(account);
        if (customer != null && customer.isStatus()) {
            isCustomer = true;
        }

        // Check if the account is a valid employee only if not a valid customer
        if (!isCustomer) {
            Employee employee = employeeService.getEmployeeByAccount(account);
            if (employee != null && employee.isStatus()) {
                isEmployee = true;
            }
        }

        if (!isCustomer && !isEmployee) {
            throw new UsernameNotFoundException("Invalid account: " + username);
        }

        // Create authorities
        return new User(
                account.getLoginName(),
                account.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + account.getRole().getRoleName())));
    }
}
