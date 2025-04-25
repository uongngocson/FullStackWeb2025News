package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import local.example.demo.model.entity.*;

import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ColorService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ProductVariantService;
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



    @Autowired
    private ProductVariantService productVariantService;

    @GetMapping("detail")
    public String showProductDetail(@RequestParam("id") Integer productId, Model model) {
        Product product = productService.findProductById(productId);
        List<ProductVariant> variants = productVariantService.findVariantsByProductId(product.getProductId());

        // Lọc các variant có hình ảnh
        variants = variants.stream()
                .filter(v -> v.getImageUrl() != null && !v.getImageUrl().isEmpty())
                .collect(Collectors.toList());
        System.out.println("variants size = " + variants.size());
                for (ProductVariant v : variants) {
                    System.out.println("Variant: " + v.getProductVariantId() + ", Color: " + v.getColor() + ", Size: " + v.getSize());
                }
                
        Set<Color> colors = variants.stream()
                .map(ProductVariant::getColor)
                .filter(Objects::nonNull)
                .collect(Collectors.toCollection(LinkedHashSet::new));

        Set<Size> sizes = variants.stream()
                .map(ProductVariant::getSize)
                .filter(Objects::nonNull)
                .collect(Collectors.toCollection(LinkedHashSet::new));

                List<Map<String, Object>> variantDTOs = variants.stream().map(v -> {
                Map<String, Object> map = new HashMap<>();
                map.put("productVariantId", v.getProductVariantId());
                map.put("color", Map.of(
                        "colorId", v.getColor().getColorId(),
                        "name", v.getColor().getColorName(),
                        "hex", v.getColor().getColorHex()
                ));
                map.put("size", Map.of(
                        "sizeId", v.getSize().getSizeId(),
                        "name", v.getSize().getSizeName()
                ));
                return map;
            }).collect(Collectors.toList());
            ObjectMapper mapper = new ObjectMapper();
            String variantsJson = "";
            try {
                variantsJson = mapper.writeValueAsString(variantDTOs);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }

        model.addAttribute("product", product);
        model.addAttribute("variants", variants);
        model.addAttribute("colors", colors);
        model.addAttribute("sizes", sizes);
        model.addAttribute("variantsJson", variantsJson); // Add this line

        return "client/product/detail";
    }
}
