package local.example.demo.service;

import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Review;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.ProductRepository;
import local.example.demo.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private FileService fileService;
    
    @Autowired
    private S3FileService s3FileService;

    /**
     * Lấy đánh giá theo ID
     * 
     * @param reviewId ID của đánh giá
     * @return Đánh giá hoặc null nếu không tìm thấy
     */
    public Review getReviewById(Integer reviewId) {
        return reviewRepository.findById(reviewId).orElse(null);
    }

    /**
     * Get all reviews for a product
     * 
     * @param productId The product ID
     * @return List of reviews
     */
    public List<Review> getReviewsByProductId(Integer productId) {
        return reviewRepository.findByProduct_ProductId(productId);
    }

    /**
     * Get all reviews by a customer
     * 
     * @param customerId The customer ID
     * @return List of reviews
     */
    public List<Review> getReviewsByCustomerId(Integer customerId) {
        return reviewRepository.findByCustomer_CustomerId(customerId);
    }

    /**
     * Check if a customer has already reviewed a product
     * 
     * @param customerId The customer ID
     * @param productId The product ID
     * @return true if the customer has already reviewed the product
     */
    public boolean hasCustomerReviewedProduct(Integer customerId, Integer productId) {
        return reviewRepository.existsByCustomer_CustomerIdAndProduct_ProductId(customerId, productId);
    }

    /**
     * Submit a new product review
     * 
     * @param customerId The customer ID
     * @param productId The product ID
     * @param rating The rating (1-5)
     * @param comment The review comment
     * @param reviewImage Optional review image
     * @return The created review or null if failed
     */
    public Review submitReview(Integer customerId, Integer productId, Integer rating, 
                               String comment, MultipartFile reviewImage) {
        
        // Validate customer and product
        Optional<Customer> customerOpt = customerRepository.findById(customerId);
        Optional<Product> productOpt = productRepository.findById(productId);
        
        if (customerOpt.isEmpty() || productOpt.isEmpty()) {
            return null;
        }
        
        Customer customer = customerOpt.get();
        Product product = productOpt.get();
        
        // Check if customer has already reviewed this product
        if (hasCustomerReviewedProduct(customerId, productId)) {
            return null; // Customer has already reviewed this product
        }
        
        // Create new review
        Review review = new Review();
        review.setCustomer(customer);
        review.setProduct(product);
        review.setRating(rating);
        review.setComment(comment);
        review.setReviewDate(LocalDateTime.now());
        
        // Handle image upload if provided - using S3
        if (reviewImage != null && !reviewImage.isEmpty()) {
            try {
                // Upload to S3 and get the URL
                String s3FileUrl = s3FileService.uploadFile(reviewImage, "reviews");
                review.setImageUrl(s3FileUrl);
                System.out.println("Review image uploaded to S3: " + s3FileUrl);
            } catch (Exception e) {
                // Log error but continue with review submission
                System.err.println("Error uploading review image to S3: " + e.getMessage());
            }
        }
        
        // Save and return the review
        return reviewRepository.save(review);
    }
    
    /**
     * Cập nhật đánh giá
     * 
     * @param reviewId ID của đánh giá cần cập nhật
     * @param rating Đánh giá mới (1-5)
     * @param comment Nhận xét mới
     * @param reviewImage Hình ảnh mới (tùy chọn)
     * @return Đánh giá đã cập nhật hoặc null nếu thất bại
     */
    public Review updateReview(Integer reviewId, Integer rating, String comment, MultipartFile reviewImage) {
        // Tìm đánh giá cần cập nhật
        Optional<Review> reviewOpt = reviewRepository.findById(reviewId);
        if (reviewOpt.isEmpty()) {
            return null;
        }
        
        Review review = reviewOpt.get();
        
        // Cập nhật thông tin
        review.setRating(rating);
        review.setComment(comment);
        
        // Xử lý tải lên hình ảnh nếu có - using S3
        if (reviewImage != null && !reviewImage.isEmpty()) {
            try {
                // Lưu URL cũ để xóa sau khi cập nhật thành công
                String oldImageUrl = review.getImageUrl();
                
                // Upload to S3 and get the URL
                String s3FileUrl = s3FileService.uploadFile(reviewImage, "reviews");
                review.setImageUrl(s3FileUrl);
                System.out.println("Review image updated in S3: " + s3FileUrl);
                
                // Xóa hình ảnh cũ nếu có
                if (oldImageUrl != null && !oldImageUrl.isEmpty()) {
                    try {
                        s3FileService.deleteFile(oldImageUrl);
                        System.out.println("Old review image deleted from S3: " + oldImageUrl);
                    } catch (Exception e) {
                        System.err.println("Error deleting old review image from S3: " + e.getMessage());
                    }
                }
            } catch (Exception e) {
                // Log lỗi nhưng vẫn tiếp tục cập nhật đánh giá
                System.err.println("Error uploading review image to S3: " + e.getMessage());
            }
        }
        
        // Lưu và trả về đánh giá đã cập nhật
        return reviewRepository.save(review);
    }
    
    /**
     * Delete a review
     * 
     * @param reviewId The review ID
     * @return true if deleted successfully
     */
    public boolean deleteReview(Integer reviewId) {
        if (reviewRepository.existsById(reviewId)) {
            // Lấy thông tin đánh giá để xóa hình ảnh nếu có
            Optional<Review> reviewOpt = reviewRepository.findById(reviewId);
            if (reviewOpt.isPresent()) {
                Review review = reviewOpt.get();
                String imageUrl = review.getImageUrl();
                
                // Xóa đánh giá từ cơ sở dữ liệu
                reviewRepository.deleteById(reviewId);
                
                // Xóa hình ảnh nếu có từ S3
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    try {
                        s3FileService.deleteFile(imageUrl);
                        System.out.println("Review image deleted from S3: " + imageUrl);
                    } catch (Exception e) {
                        // Log lỗi nhưng vẫn trả về thành công vì đánh giá đã được xóa
                        System.err.println("Error deleting review image from S3: " + e.getMessage());
                    }
                }
                
                return true;
            }
            
            // Nếu không tìm thấy đánh giá, vẫn xóa theo ID
            reviewRepository.deleteById(reviewId);
            return true;
        }
        return false;
    }
} 