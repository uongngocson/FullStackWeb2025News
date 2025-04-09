package local.example.demo.controller.admin;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Category;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Shop;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.FileService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ShopService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/product-mgr/")
public class ProductMgrController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final ShopService shopService;
    // Inject FileService
    private final FileService fileService;

    // admin navigation to product list
    @GetMapping("list")
    public String getProductList(Model model) {
        List<Product> products = productService.findAllProduct();
        model.addAttribute("products", products);
        return "admin/product-mgr/all-products";
    }

    @ModelAttribute("categories")
    public List<Category> populateCategories() {
        return categoryService.findAllCategories();
    }

    @ModelAttribute("brands")
    public List<Brand> populateBrands() {
        return brandService.findAllBrands();
    }

    @ModelAttribute("shops")
    public List<Shop> populateShops() {
        return shopService.findAllShops();
    }

    // Show product details
    @GetMapping("detail/{productId}")
    public String viewProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        if (product == null) {
            return "redirect:/admin/product-mgr/list";
        }
        model.addAttribute("product", product);
        return "admin/product-mgr/detail-product";
    }

    @GetMapping("create")
    public String createProduct(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product-mgr/form-product";
    }

    @GetMapping("update/{productId}")
    public String updateProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        model.addAttribute("product", product);
        return "admin/product-mgr/form-product";
    }

    // Process save product
    @PostMapping("save")
    public String saveProduct(Model model, @Valid @ModelAttribute("product") Product product,
            BindingResult bindingResult,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            RedirectAttributes redirectAttributes) throws IOException {

        if (bindingResult.hasErrors()) {
            return "admin/product-mgr/form-product";
        }

        // Handle image upload
        if (fileService.isValidFile(imageFile)) {
            String imagePath = fileService.handleSaveUploadFile(imageFile, "product");
            product.setImageUrl("resources/images-upload/product/" + imagePath);
        }

        productService.saveProduct(product);
        return "redirect:/admin/product-mgr/list";
    }

    @GetMapping("delete/{productId}")
    public String deleteProduct(Model model, @PathVariable("productId") Integer productId) {
        productService.deleteProductById(productId);
        return "redirect:/admin/product-mgr/list";
    }
}