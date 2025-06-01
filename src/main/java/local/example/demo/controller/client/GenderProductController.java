package local.example.demo.controller.client;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import local.example.demo.model.entity.*;
import local.example.demo.service.*;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/gender-product/")
public class GenderProductController {
    private final ProductService productService;
    private final CategoryService categoryService;

    @GetMapping("men")
    public String getMenFashionPage(Model model) {
        Boolean type = true; // Men
        List<Category> menCategories = categoryService.findAllCategories()
                .stream()
                .filter(c -> List.of(1, 2, 3, 4, 7, 9, 10, 13, 14, 15).contains(c.getCategoryId()))
                .filter(c -> productService.hasProductsForCategoryAndType(c.getCategoryId(), type))
                .collect(Collectors.toList());
        model.addAttribute("categories", menCategories);
        model.addAttribute("gender", "men");
        return "client/product/gender-categories";
    }

    @GetMapping("women")
    public String getWomenFashionPage(Model model) {
        Boolean type = false; // Women
        List<Category> womenCategories = categoryService.findAllCategories()
                .stream()
                .filter(c -> List.of(1, 2, 3, 4, 5, 6, 9, 10, 13, 14, 15).contains(c.getCategoryId()))
                .filter(c -> productService.hasProductsForCategoryAndType(c.getCategoryId(), type))
                .collect(Collectors.toList());
        model.addAttribute("categories", womenCategories);
        model.addAttribute("gender", "women");
        return "client/product/gender-categories";
    }

    @GetMapping("products")
    public String getProductsByGenderAndCategory(
            @RequestParam("gender") String gender,
            @RequestParam("categoryId") Integer categoryId,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "sortBy", required = false) String[] sortByValues, // Xử lý mảng sortBy
            Model model) {
        // Lấy giá trị sortBy cuối cùng nếu có nhiều giá trị
        Optional<String> sortBy = sortByValues != null && sortByValues.length > 0
                ? Optional.of(sortByValues[sortByValues.length - 1])
                : Optional.empty();
        return getProducts(gender, Optional.of(categoryId), page, sortBy, model);
    }

    @GetMapping("men-products")
    public String getAllMenProducts(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "sortBy", required = false) String[] sortByValues, // Xử lý mảng sortBy
            Model model) {
        Optional<String> sortBy = sortByValues != null && sortByValues.length > 0
                ? Optional.of(sortByValues[sortByValues.length - 1])
                : Optional.empty();
        return getProducts("men", Optional.empty(), page, sortBy, model);
    }

    @GetMapping("women-products")
    public String getAllWomenProducts(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "sortBy", required = false) String[] sortByValues, // Xử lý mảng sortBy
            Model model) {
        Optional<String> sortBy = sortByValues != null && sortByValues.length > 0
                ? Optional.of(sortByValues[sortByValues.length - 1])
                : Optional.empty();
        return getProducts("women", Optional.empty(), page, sortBy, model);
    }

    private String getProducts(
            String gender,
            Optional<Integer> categoryId,
            int page,
            Optional<String> sortBy,
            Model model) {
        int currentPage = Math.max(1, page);
        int pageSize = 6;
        Pageable pageable = PageRequest.of(currentPage - 1, pageSize);

        Boolean type = "men".equalsIgnoreCase(gender);

        // Xác thực sortBy
        String validatedSortBy = sortBy.orElse("priceAsc");
        if (!"priceAsc".equals(validatedSortBy) && !"priceDesc".equals(validatedSortBy)) {
            validatedSortBy = "priceAsc"; // Mặc định priceAsc cho sortBy không hợp lệ
        }

        // Lấy sản phẩm đã sắp xếp
        Page<Product> productPage = productService.findSortedProducts(
                categoryId, Optional.of(type), Optional.of(validatedSortBy), pageable);

        // Đặt danh mục
        Category category = categoryId.isPresent() ? categoryService.findById(categoryId.get())
                .orElseThrow(() -> new IllegalArgumentException("Danh mục không tìm thấy: " + categoryId.get())) : null;

        // Thêm thuộc tính model
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("totalElements", productPage.getTotalElements());
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("category", category);
        model.addAttribute("gender", gender);
        model.addAttribute("selectedSortBy", validatedSortBy);

        return "client/product/gender-products";
    }
}
