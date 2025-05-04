package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.math.BigDecimal; // Thêm import này

import local.example.demo.model.entity.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Category;
import local.example.demo.model.entity.Color;
import local.example.demo.model.entity.Size;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ColorService;
import local.example.demo.service.LibreTranslateService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.SizeService;
import lombok.RequiredArgsConstructor;
import local.example.demo.model.entity.ProductImage; // Thêm import
import local.example.demo.service.ProductImageService; // Thêm import service ảnh

@RequiredArgsConstructor
@Controller
@RequestMapping("/product/")
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final SizeService sizeService;
    private final ColorService colorService;
    private final BrandService brandService;
    private final ProductVariantService productVariantService;
    private final ProductImageService productImageService; // Inject ProductImageService
    private final LibreTranslateService translateService;


    @GetMapping("category")
    public String getProductCategoryPage(Model model,
            @RequestParam(value = "page", required = false, defaultValue = "1") int page,
            @RequestParam(required = false) Optional<Integer> brandId,
            @RequestParam(required = false) Optional<Integer> categoryId,
            @RequestParam(required = false) Optional<Integer> sizeId,
            @RequestParam(required = false) Optional<Integer> colorId,
            @RequestParam(required = false) Optional<String> priceRange, // Giữ nguyên là String
            @RequestParam(required = false) Optional<Boolean> type, // Thêm RequestParam cho type
            @RequestParam(required = false) Optional<String> sortBy) {
    
        int currentPage = Math.max(1, page);
        int pageSize = 8; // Kích thước trang
    
        // Xử lý priceRange thành BigDecimal
        Optional<BigDecimal> minPrice = Optional.empty();
        Optional<BigDecimal> maxPrice = Optional.empty();
        String selectedPriceRange = priceRange.orElse("all"); // Mặc định là "all"
    
        if (priceRange.isPresent() && !selectedPriceRange.equals("all")) {
            String rangeValue = selectedPriceRange;
            try {
                if (rangeValue.contains("+")) { // Xử lý trường hợp "200+"
                    String minStr = rangeValue.replace("+", "");
                    minPrice = Optional.of(new BigDecimal(minStr));
                    maxPrice = Optional.empty(); // Không có giới hạn trên
                } else if (rangeValue.contains("-")) { // Xử lý trường hợp "0-50", "50-100"
                    String[] parts = rangeValue.split("-");
                    if (parts.length == 2) {
                        if (!parts[0].isEmpty()) {
                            minPrice = Optional.of(new BigDecimal(parts[0]));
                        }
                        if (!parts[1].isEmpty()) {
                            maxPrice = Optional.of(new BigDecimal(parts[1]));
                        }
                    } else if (parts.length == 1 && rangeValue.startsWith("-")) { // Xử lý trường hợp "-50" (Under 50) nếu có
                         maxPrice = Optional.of(new BigDecimal(parts[0]));
                         minPrice = Optional.of(BigDecimal.ZERO); // Giả sử giá nhỏ nhất là 0
                    }
                }
                // Bạn có thể thêm các trường hợp khác nếu cần
            } catch (NumberFormatException e) {
                // Xử lý lỗi nếu định dạng không đúng
                System.err.println("Invalid price range format: " + rangeValue);
                selectedPriceRange = "all"; // Reset về mặc định nếu lỗi
                minPrice = Optional.empty();
                maxPrice = Optional.empty();
            }
        }
    
    
        Page<Product> productPage = productService.findFilteredAndSortedProducts(
                brandId,
                categoryId,
                sizeId,
                colorId,
                minPrice, // Truyền BigDecimal minPrice
                maxPrice, // Truyền BigDecimal maxPrice
                type, // Truyền tham số type
                sortBy,
                PageRequest.of(currentPage - 1, pageSize)
        );
    
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalElements", productPage.getTotalElements());
        model.addAttribute("pageSize", pageSize);

        // Giữ lại các tham số đã chọn
        model.addAttribute("selectedBrandId", brandId.orElse(null));
        model.addAttribute("selectedCategoryId", categoryId.orElse(null));
        model.addAttribute("selectedSizeId", sizeId.orElse(null));
        model.addAttribute("selectedColorId", colorId.orElse(null));
        model.addAttribute("selectedPriceRange", selectedPriceRange); // Thêm selectedPriceRange
        model.addAttribute("selectedType", type.orElse(null)); // Thêm selectedType vào model
        model.addAttribute("selectedSortBy", sortBy.orElse("newest"));

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
    public String getProductItemMalePage(Model model,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page) { // Make 'page' optional with default value 1
        // Ensure page is at least 1
        if (page < 1) {
            page = 1;
        }
        Pageable pageable = PageRequest.of(page - 1, 8); // page index is 0-based
        Page<Product> productPage = productService.findProductsByTypeMen(pageable);
        List<Product> products = productPage.getContent();
        model.addAttribute("product", products);
        model.addAttribute("currentPage", page); // Add current page number
        model.addAttribute("totalPages", productPage.getTotalPages()); // Add total pages for pagination UI
        // No need to add categories, sizes, colors, brands here if using @ModelAttribute
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("brands", brandService.findAllBrands());
        return "client/product/item-male";
    }

    @GetMapping("item-female")
    public String getProductItemFemalePage(Model model,
        @RequestParam(value = "page", required = false, defaultValue = "1") int page) { // Make 'page' optional with default value 1
        // Ensure page is at least 1
        if (page < 1) {
            page = 1;
        }
        Pageable pageable = PageRequest.of(page - 1, 8); // page index is 0-based
        Page<Product> productPage = productService.findProductsByTypeWomen(pageable);
        List<Product> products = productPage.getContent();
        model.addAttribute("product", products);
        model.addAttribute("currentPage", page); // Add current page number
        model.addAttribute("totalPages", productPage.getTotalPages()); // Add total pages for pagination UI
        // No need to add categories, sizes, colors, brands here if using @ModelAttribute
        model.addAttribute("products", products);
        model.addAttribute("categories", categoryService.findAllCategories());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("brands", brandService.findAllBrands());
        return "client/product/item-female";
    }


     @GetMapping("detail")
    public String showProductDetail(
            @RequestParam("id") Integer productId,
            @RequestParam(defaultValue = "en") String lang, // Default language is now 'en'
            Model model) {

        Product product = productService.findProductById(productId);
        if (product == null) {
            return "redirect:/page-not-found";
        }

        // --- Translation Logic Update ---
        // Ngôn ngữ gốc trong DB bây giờ là 'en'
        String baseLang = "en";

        // Chỉ thực hiện dịch nếu ngôn ngữ yêu cầu (lang) khác với ngôn ngữ gốc (baseLang)
        if (!lang.equals(baseLang)) {
            // Gọi service dịch với sourceLang là "en"
            String translatedName = translateService.translate(product.getProductName(), baseLang, lang);
            String translatedDesc = translateService.translate(product.getDescription(), baseLang, lang);

            Map<String, String> translation = new HashMap<>();
            translation.put("name", translatedName);
            translation.put("description", translatedDesc);
            model.addAttribute("translation", translation);
        }
        // --- End Translation Logic Update ---


        List<ProductVariant> variants = productVariantService.findVariantsByProductId(product.getProductId());
        // Lấy danh sách ảnh từ Product entity thay vì variant
        List<ProductImage> productImages = product.getProductImages(); // Lấy ảnh theo productId

        // Lọc các variant có hình ảnh (Phần này có thể không cần thiết nếu bạn hiển thị ảnh từ productImages)
        // variants = variants.stream()
        //         .filter(v -> v.getImageUrl() != null && !v.getImageUrl().isEmpty())
        //         .collect(Collectors.toList());
        // System.out.println("variants size = " + variants.size());
        //         for (ProductVariant v : variants) {
        //             System.out.println("Variant: " + v.getProductVariantId() + ", Color: " + v.getColor() + ", Size: " + v.getSize());
        //         }

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
                // Kiểm tra null trước khi truy cập
                if (v.getColor() != null) {
                    map.put("color", Map.of(
                            "colorId", v.getColor().getColorId(),
                            "name", v.getColor().getColorName(),
                            "hex", v.getColor().getColorHex()
                    ));
                }
                if (v.getSize() != null) {
                    map.put("size", Map.of(
                            "sizeId", v.getSize().getSizeId(),
                            "name", v.getSize().getSizeName()
                    ));
                }
                return map;
            }).collect(Collectors.toList());
            ObjectMapper mapper = new ObjectMapper();
            String variantsJson = "";
            try {
                variantsJson = mapper.writeValueAsString(variantDTOs);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
                variantsJson = "[]"; // Gán giá trị mặc định nếu có lỗi
            }

        model.addAttribute("product", product);
        model.addAttribute("variants", variants); // Có thể không cần nếu không dùng trực tiếp
        model.addAttribute("colors", colors);
        model.addAttribute("sizes", sizes);
        model.addAttribute("variantsJson", variantsJson);
        model.addAttribute("productImages", productImages); // Truyền danh sách ảnh sản phẩm
        model.addAttribute("currentLang", lang);
        return "client/product/detail";
    }
}