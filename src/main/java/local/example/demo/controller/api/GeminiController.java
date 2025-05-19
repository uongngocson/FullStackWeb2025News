package local.example.demo.controller.api;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import local.example.demo.service.GeminiService;

@Controller
public class GeminiController {
    private final GeminiService geminiService;

    public GeminiController(GeminiService geminiService) {
        this.geminiService = geminiService;
    }

    @PostMapping("/ask")
    public String askGemini(@RequestParam String prompt, Model model) {
        String result = geminiService.callGemini(prompt);
        model.addAttribute("result", result);
        model.addAttribute("prompt", prompt);
        model.addAttribute("now", new Date());
        return "client/home"; // result.jsp
    }
}

