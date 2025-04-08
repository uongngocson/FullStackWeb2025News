package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Product;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ShopService;

@Controller
@RequestMapping("/product-mgr/")
public class ProductMgrController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final ShopService shopService;

    public ProductMgrController(ProductService productService, CategoryService categoryService,
            BrandService brandService,
            ShopService shopService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.brandService = brandService;
        this.shopService = shopService;
    }

    // admin navigation to product list
    @GetMapping("list")
    public String getProductList(Model model) {
        List<Product> products = productService.findAllProduct();
        model.addAttribute("products", products);
        return "admin/product-mgr/all-products";
    }

    @GetMapping("create")
    public String createProduct(Model model) {
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("brands", brandService.findAllBrands());
        model.addAttribute("shops", shopService.findAllShops());
        model.addAttribute("product", new Product());
        return "admin/product-mgr/create-product";
    }

    @PostMapping("create")
    public String createProduct(Model model, @ModelAttribute("product") @Valid Product product,
            BindingResult bindingResult) {
        // Validate the product object
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("brands", brandService.findAllBrands());
            model.addAttribute("shops", shopService.findAllShops());
            return "admin/product-mgr/create-product";
        }
        productService.saveProduct(product);
        return "redirect:/product-mgr/list";
    }

    @GetMapping("update/{productId}")
    public String updateProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("brands", brandService.findAllBrands());
        model.addAttribute("shops", shopService.findAllShops());
        return "admin/product-mgr/update-product";
    }

    @PostMapping("update/{productId}")
    public String updateProduct(Model model, @ModelAttribute("product") @Valid Product product,
            BindingResult bindingResult,
            @PathVariable("productId") Integer productId) {
        // Validate the product object
        if (bindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.findAllCategories());
            model.addAttribute("brands", brandService.findAllBrands());
            model.addAttribute("shops", shopService.findAllShops());
            return "admin/product-mgr/update-product";
        }
        // Update the product object with the new values
        product.setProductId(productId); // Set the productId to the product object
        // Save the updated product object
        productService.saveProduct(product);
        return "redirect:/product-mgr/list";
    }

    @GetMapping("delete/{productId}")
    public String deleteProduct(Model model, @PathVariable("productId") Integer productId) {
        productService.deleteProductById(productId);
        return "redirect:/product-mgr/list";
    }
}