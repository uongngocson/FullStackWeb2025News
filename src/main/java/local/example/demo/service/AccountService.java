package local.example.demo.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Role;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;

@Service
public class AccountService {
    // Add your service methods here
    // For example:
    @Autowired
    private final CustomerRepository customerRepository;
    @Autowired
    private final AccountRepository accountRepository;


    public AccountService(AccountRepository accountRepository, CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
        this.accountRepository = accountRepository;
    }

    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    public Account getAccountById(Integer id) {
        return accountRepository.findById(id).orElse(null);
    }

    public void saveAccount(Account account) {
        accountRepository.save(account);
    }

    public void deleteAccountById(Integer id) {
        accountRepository.deleteById(id);
    }
    @Transactional
    public Account findOrCreateAccount(String googleId, String email, String name) {
        return accountRepository.findByLoginName(email)
            .orElseGet(() -> {
                Account newAccount = new Account();
                newAccount.setLoginName(email); // Dùng email làm loginName
                newAccount.setRoleId(new Role(2,"Customer")); // Vai trò mặc định
                newAccount.setPassword("oauth2_" + googleId); // Password không cần thiết cho OAuth2
                Account savedAccount = accountRepository.save(newAccount);

                // Tạo Customer
                Customer customer = new Customer();
                customer.setAccount(savedAccount);
                customer.setEmail(email);
                customer.setRegistrationDate(LocalDate.now());
                customerRepository.save(customer);

                return savedAccount;
            });
    }
}
