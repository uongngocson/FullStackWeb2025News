package local.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.repository.AccountRepository;

@Service
public class AccountService {
    // Add your service methods here
    // For example:
    @Autowired
    private final AccountRepository accountRepository;

    public AccountService(AccountRepository accountRepository) {
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

    public boolean existsByLoginName(String loginName) {
        return accountRepository.existsByLoginName(loginName);
    }

    public Account getAccountByLoginName(String loginName) {
        return accountRepository.findByLoginName(loginName);
    }

    // mapper registerDTO to account
    public Account mapRegisterDTOToAccount(RegisterDTO registerDTO) {
        Account account = new Account();
        account.setLoginName(registerDTO.getLoginName());
        account.setPassword(registerDTO.getPassword());
        return account;
    }

}
