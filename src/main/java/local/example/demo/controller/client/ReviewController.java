package local.example.demo.controller.client;

import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Review;
import local.example.demo.service.CustomerService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.HashMap;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private ProductService productService;

    /**
     * Hiển thị tất cả đánh giá của khách hàng hiện tại
     */
    @GetMapping("/all")
    public String getAllReviews(Model model) {
        // Lấy thông tin người dùng đã đăng nhập
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
            return "redirect:/login";
        }
        
        // Lấy customer từ username
        Customer customer = customerService.findByUsername(authentication.getName());
        if (customer == null) {
            return "redirect:/login";
        }
        
        // Debug log
        System.out.println("Customer found: " + customer.getCustomerId() + " - " + customer.getFirstName() + " " + customer.getLastName());
        
        // Lấy tất cả đánh giá của khách hàng
        List<Review> reviews = reviewService.getReviewsByCustomerId(customer.getCustomerId());
        System.out.println("Reviews found: " + (reviews != null ? reviews.size() : "null"));
        
        if (reviews != null && !reviews.isEmpty()) {
            for (Review review : reviews) {
                System.out.println("Review ID: " + review.getReviewId() + ", Product: " + 
                    (review.getProduct() != null ? review.getProduct().getProductId() : "null") + 
                    ", Date: " + review.getReviewDate());
            }
        }
        
        // Lấy thông tin sản phẩm cho mỗi đánh giá
        Map<Integer, Product> productMap = new HashMap<>();
        if (reviews != null && !reviews.isEmpty()) {
            for (Review review : reviews) {
                if (review.getProduct() != null) {
                    productMap.put(review.getProduct().getProductId(), review.getProduct());
                }
            }
        }
        
        model.addAttribute("reviews", reviews);
        model.addAttribute("productMap", productMap);
        model.addAttribute("customer", customer);
        
        return "client/auth/allreview";
    }
    
    /**
     * Xóa đánh giá
     */
    @PostMapping("/delete")
    public String deleteReview(
            @RequestParam("reviewId") Integer reviewId,
            RedirectAttributes redirectAttributes) {
        
        // Lấy thông tin người dùng đã đăng nhập
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Bạn cần đăng nhập để thực hiện thao tác này.");
            return "redirect:/login";
        }
        
        // Lấy customer từ username
        Customer customer = customerService.findByUsername(authentication.getName());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin khách hàng.");
            return "redirect:/review/all";
        }
        
        // Kiểm tra xem đánh giá có thuộc về khách hàng này không
        Review review = reviewService.getReviewById(reviewId);
        if (review == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đánh giá.");
            return "redirect:/review/all";
        }
        
        if (!review.getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền xóa đánh giá này.");
            return "redirect:/review/all";
        }
        
        // Xóa đánh giá
        boolean deleted = reviewService.deleteReview(reviewId);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Đã xóa đánh giá thành công.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa đánh giá. Vui lòng thử lại sau.");
        }
        
        return "redirect:/review/all";
    }
    
    /**
     * Cập nhật đánh giá
     */
    @PostMapping("/update")
    public String updateReview(
            @RequestParam("reviewId") Integer reviewId,
            @RequestParam("rating") Integer rating,
            @RequestParam("comment") String comment,
            @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage,
            RedirectAttributes redirectAttributes) {
        
        // Lấy thông tin người dùng đã đăng nhập
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Bạn cần đăng nhập để thực hiện thao tác này.");
            return "redirect:/login";
        }
        
        // Lấy customer từ username
        Customer customer = customerService.findByUsername(authentication.getName());
        if (customer == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin khách hàng.");
            return "redirect:/review/all";
        }
        
        // Kiểm tra xem đánh giá có thuộc về khách hàng này không
        Review review = reviewService.getReviewById(reviewId);
        if (review == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đánh giá.");
            return "redirect:/review/all";
        }
        
        if (!review.getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền cập nhật đánh giá này.");
            return "redirect:/review/all";
        }
        
        // Validate rating
        if (rating == null || rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đánh giá không hợp lệ. Vui lòng chọn từ 1 đến 5 sao.");
            return "redirect:/review/all";
        }
        
        // Cập nhật đánh giá
        try {
            Review updatedReview = reviewService.updateReview(reviewId, rating, comment, reviewImage);
            if (updatedReview != null) {
                redirectAttributes.addFlashAttribute("successMessage", "Đã cập nhật đánh giá thành công.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể cập nhật đánh giá. Vui lòng thử lại sau.");
            }
        } catch (MaxUploadSizeExceededException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Kích thước hình ảnh quá lớn. Vui lòng chọn hình ảnh nhỏ hơn 1MB.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
        }
        
        return "redirect:/review/all";
    }

    /**
     * Handle review submission
     */
    @PostMapping("/submit")
    public String submitReview(
            @RequestParam("productId") Integer productId,
            @RequestParam(value = "customerId", required = false) Integer customerId,
            @RequestParam("rating") Integer rating,
            @RequestParam("comment") String comment,
            @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        try {
            // Lấy thông tin người dùng đã đăng nhập từ Spring Security
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication == null || !authentication.isAuthenticated() || "anonymousUser".equals(authentication.getPrincipal())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn cần đăng nhập để đánh giá sản phẩm.");
                return "redirect:/login";
            }
            
            // Lấy username từ thông tin xác thực
            String username = authentication.getName();
            System.out.println("Authenticated username: " + username);
            
            // Lấy customer từ username
            Customer customer = customerService.findByUsername(username);
            if (customer == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin khách hàng.");
                return "redirect:/management/historyorder";
            }
            
            // Sử dụng customerId từ customer object
            customerId = customer.getCustomerId();
            System.out.println("Customer ID from authentication: " + customerId);
    
            // Validate rating
            if (rating == null || rating < 1 || rating > 5) {
                redirectAttributes.addFlashAttribute("errorMessage", "Đánh giá không hợp lệ. Vui lòng chọn từ 1 đến 5 sao.");
                return "redirect:/management/historyorder";
            }
    
            // Submit the review
            Review review = reviewService.submitReview(customerId, productId, rating, comment, reviewImage);
    
            if (review == null) {
                // Check if the customer has already reviewed this product
                if (reviewService.hasCustomerReviewedProduct(customerId, productId)) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Bạn đã đánh giá sản phẩm này rồi.");
                    return "redirect:/management/historyorder";
                } else {
                    redirectAttributes.addFlashAttribute("errorMessage", "Không thể đánh giá sản phẩm. Vui lòng thử lại sau.");
                    return "redirect:/management/historyorder";
                }
            } else {
                redirectAttributes.addFlashAttribute("successMessage", "Cảm ơn bạn đã đánh giá sản phẩm!");
                return "redirect:/review/all"; // Chuyển đến trang hiển thị tất cả đánh giá
            }
        } catch (MaxUploadSizeExceededException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Kích thước hình ảnh quá lớn. Vui lòng chọn hình ảnh nhỏ hơn 1MB.");
            return "redirect:/management/historyorder";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            return "redirect:/management/historyorder";
        }
    }
} 