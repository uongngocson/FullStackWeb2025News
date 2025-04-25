package local.example.demo.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Integer>  {
    // Tìm sản phẩm đã có trong giỏ hàng chưa
    CartDetail findByCartAndProductVariant(Cart cart, ProductVariant productVariant);
    
    // Đếm số lượng sản phẩm trong giỏ hàng
    int countByCart(Cart cart);
    @Query("SELECT cd FROM CartDetail cd JOIN cd.cart c WHERE cd.id = :cartDetailId AND c.customer = :customer")
    Optional<CartDetail> findByIdAndCustomer(@Param("cartDetailId") Integer cartDetailId, 
                                           @Param("customer") Customer customer);
    
    // Xóa CartDetail theo ID
    void deleteById(Integer cartDetailId);
}
