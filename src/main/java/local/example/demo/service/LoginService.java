package local.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Account;
import local.example.demo.repository.LoginRepository;

@Service
public class LoginService {

    @Autowired
    private LoginRepository loginRepository;

    public Account login(String loginName, String password) {
        return loginRepository.findByLoginName(loginName).orElse(null);
    }
}

