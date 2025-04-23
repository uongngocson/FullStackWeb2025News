package local.example.demo.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product/")
public class ProductController {

    @GetMapping("category")
    public String getProductCategoryPage() {
        return "client/product/category";
    }
    
    @GetMapping("item-male")
    public String getProductItemMalePage() {
        return "client/product/item-male";
    }

    @GetMapping("item-female")
    public String getProductItemFemalePage() {
        return "client/product/item-female";
    }



    @GetMapping("detail")
    public String getProductDetailPage() {
        return "client/product/detail";
    }

}
