package local.example.demo.service;

import java.util.List;


import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.ProductRepository;
import local.example.demo.repository.ProductVariantRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductVariantRepository productVariantRepository ;



    // get all product
    public List<Product> findAllProducts() {
        return productRepository.findAllProducts();
    }

    // save product
    public void saveProduct(Product product) {
        productRepository.save(product);
    }

    // find product by id
    public Product findProductById(Integer productId) {
        return productRepository.findProductById(productId);
    }

    // delete product by id
    public void deleteProductById(Integer productId) {
        productRepository.deleteById(productId);
    }

    // get product by supplierId
    public List<Product> findProductsBySupplierId(Integer supplierId) {
        return productRepository.findProductsBySupplierId(supplierId);
    }

    // get product type men
    public List<Product> findProductsByTypeMen() {
        return productRepository.findProductsByTypeMen();
    }

    // get product type women
    public List<Product> findProductsByTypeWomen() {
        return productRepository.findProductsByTypeWomen();
    }
    public List<ProductVariant> findVariantsByProductId(Integer productId) {
        return productVariantRepository.findByProduct_ProductId(productId);
    }

    
}
