package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    
    @GetMapping("")
    public String getHomePage() {
        return "client/home";
    }

    @GetMapping("about")
    public String getAboutPage() {
        return "client/about";
    }
    
}
