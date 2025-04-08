package local.example.demo.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;

import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;

@Service
public class RegisterService {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private JavaMailSender mailSender;

    public void sendVerificationCode(String toEmail, String code) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject("Mã xác nhận đăng ký");
        message.setText("Mã xác nhận của bạn là: " + code);
        mailSender.send(message);
    }


    public String generateVerificationCode() {
        return String.valueOf((int) (Math.random() * 900000) + 100000); // Mã 6 chữ số
    }

    public Account saveAccount(Account account) {
        return accountRepository.save(account);
    }

    public Customer saveCustomer(String email, Account account) {
        Customer customer = new Customer();
        customer.setAccount(account);
        customer.setEmail(email);
        customer.setRegistrationDate(LocalDate.now());
        return customerRepository.save(customer);
    }
}
