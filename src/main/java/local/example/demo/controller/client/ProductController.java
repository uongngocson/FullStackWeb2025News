package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {

    @GetMapping("/item")
    public String getProductItemPage() {
        return "client/product/item";
    }

    @GetMapping("/detail")
    public String getProductDetailPage() {
        return "client/product/detail";
    }

}
