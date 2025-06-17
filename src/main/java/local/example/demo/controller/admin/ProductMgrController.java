package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import local.example.demo.exception.ProductInUseException;
import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Category;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Supplier;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ProductService;
import local.example.demo.service.SupplierService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/product-mgr/")
public class ProductMgrController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final SupplierService supplierService;
    
    private static final int DEFAULT_PAGE_SIZE = 10;

    // admin navigation to product list with pagination
    @GetMapping("list")
    public String getProductList(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            Model model) {
        
        // Ensure size doesn't exceed reasonable limits for performance
        size = Math.min(size, 100);
        
        Page<Product> productPage = productService.findAllProductsPaginated(page, size);
        
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalItems", productPage.getTotalElements());
        model.addAttribute("pageSize", size);
        
        return "admin/product-mgr/all-products";
    }

    // This method is kept for backward compatibility with other parts of the application
    // that might expect products to be populated via @ModelAttribute
    @ModelAttribute("allProducts")
    public List<Product> populateProducts() {
        // Return a limited number of products to avoid performance issues
        Page<Product> productPage = productService.findAllProductsPaginated(0, DEFAULT_PAGE_SIZE);
        return productPage.getContent();
    }

    // get all category
    @ModelAttribute("categories")
    public List<Category> populateCategories() {
        return categoryService.findAllCategories();
    }

    // get all brand
    @ModelAttribute("brands")
    public List<Brand> populateBrands() {
        return brandService.findAllBrands();
    }

    // get all supplier
    @ModelAttribute("suppliers")
    public List<Supplier> populateSuppliers() {
        return supplierService.findAllSuppliers();
    }

    // Show product details
    @GetMapping("detail/{productId}")
    public String viewProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        if (product == null) {
            return "redirect:/admin/product-mgr/list";
        }
        model.addAttribute("totalQuantity", productService.getTotalStock(productId));
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
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "admin/product-mgr/form-product";
        }
        productService.saveProduct(product);
        return "redirect:/admin/product-mgr/list";
    }

    @PostMapping("delete/{productId}")
    public String deleteProduct(Model model, @PathVariable("productId") Integer productId,
            RedirectAttributes redirectAttributes) {
        try {
            productService.deleteProductById(productId);
            redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully.");
        } catch (ProductInUseException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to delete product. An unexpected error occurred.");
        }
        return "redirect:/admin/product-mgr/list";
    }
}