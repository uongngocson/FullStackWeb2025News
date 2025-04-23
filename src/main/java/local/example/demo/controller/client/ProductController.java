package local.example.demo.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Category;
import local.example.demo.model.entity.Color;
import local.example.demo.model.entity.Size;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ColorService;
import local.example.demo.service.ProductService;
import local.example.demo.service.SizeService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/product/")
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final SizeService sizeService;
    private final ColorService colorService;
    private final BrandService brandService;


    @GetMapping("category")
    public String getProductCategoryPage(Model model) {
        model.addAttribute("product", productService.findAllProducts());
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("brands", brandService.findAllBrands());
        return "client/product/category";
    }

    // get all categories
    @ModelAttribute("categories")
    public List<Category> getAllCategories() {
        return categoryService.findAllCategories();
    }

    // get all sizes
    @ModelAttribute("sizes")
    public List<Size> getAllSizes() {
        return sizeService.getAllSizes();
    }

    // get all colors
    @ModelAttribute("colors")
    public List<Color> getAllColors() {
        return colorService.getAllColors();
    }

    // get all brands
    @ModelAttribute("brands")
    public List<Brand> getAllBrands() {
        return brandService.findAllBrands();
    }
      
    @GetMapping("item-male")
    public String getProductItemMalePage(Model model) {
        model.addAttribute("products", productService.findProductsByTypeMen());
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("brands", brandService.findAllBrands());
        return "client/product/item-male";
    }

    @GetMapping("item-female")
    public String getProductItemFemalePage(Model model) {
        model.addAttribute("products", productService.findProductsByTypeWomen());
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("brands", brandService.findAllBrands());
        return "client/product/item-female";
    }



    @GetMapping("detail")
    public String getProductDetailPage() {
        return "client/product/detail";
    }

}
