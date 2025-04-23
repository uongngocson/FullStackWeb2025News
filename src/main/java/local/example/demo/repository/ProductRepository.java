package local.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    @Query("SELECT p FROM Product p JOIN FETCH p.brand b JOIN FETCH p.category c JOIN FETCH p.supplier s")
    List<Product> findAllProducts();

    @Query("SELECT p FROM Product p JOIN FETCH p.brand b JOIN FETCH p.category c JOIN FETCH p.supplier s WHERE p.productId = :productId")
    Product findProductById(Integer productId);

    // get product by supplierId
    @Query("SELECT p FROM Product p JOIN FETCH p.brand b JOIN FETCH p.category c JOIN FETCH p.supplier s WHERE s.supplierId = :supplierId")
    List<Product> findProductsBySupplierId(Integer supplierId);

    // get product type=1 - men
    @Query("SELECT p FROM Product p JOIN FETCH p.brand b JOIN FETCH p.category c JOIN FETCH p.supplier s WHERE p.type = true")
    List<Product> findProductsByTypeMen();

    // get product type=0 - women
    @Query("SELECT p FROM Product p JOIN FETCH p.brand b JOIN FETCH p.category c JOIN FETCH p.supplier s WHERE p.type = false")
    List<Product> findProductsByTypeWomen();
}
