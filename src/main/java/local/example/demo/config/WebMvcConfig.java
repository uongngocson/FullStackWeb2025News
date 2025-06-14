package local.example.demo.config;

import java.util.Locale;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    // *** ĐA NGÔN NGỮ *******
    // Bean định nghĩa LocaleResolver để xác định ngôn ngữ hiện tại của người dùng
    @Bean
    public LocaleResolver localeResolver() {
        // Using our custom AutoLocaleResolver that automatically detects browser
        // language
        AutoLocaleResolver resolver = new AutoLocaleResolver();

        // Thiết lập ngôn ngữ mặc định là tiếng Anh
        resolver.setDefaultLocale(Locale.ENGLISH);
        return resolver;
    }

    // Interceptor để bắt tham số "lang" trên URL và thay đổi ngôn ngữ tương ứng
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
        // Cấu hình tên tham số truyền trên URL để thay đổi ngôn ngữ, ví dụ ?lang=vi
        lci.setParamName("lang");
        return lci;
    }

    // Đăng ký interceptor để Spring có thể xử lý thay đổi locale khi có tham số
    // lang
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }
    // **********
}
