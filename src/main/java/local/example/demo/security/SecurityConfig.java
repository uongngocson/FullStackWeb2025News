package local.example.demo.security;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    return http
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/", "/client/auth/login", "/oauth2/**").permitAll() // Các đường link này không cần đăng nhập vẫn truy cập được
            .anyRequest().authenticated()
        )
        .oauth2Login(oauth -> oauth
            
            .defaultSuccessUrl("/client/home", true) //Sau khi đăng nhập bằng Google xong, sẽ chuyển hướng đến trang /account-mgr/list
        )
        .logout(logout -> logout
            .logoutUrl("/logout") // URL để logout
            .logoutSuccessUrl("/client/auth/login") // Khi logout xong thì chuyển về đâu
            .invalidateHttpSession(true) // Invalidate session luôn
            .clearAuthentication(true)
        )

        .build();
}

}