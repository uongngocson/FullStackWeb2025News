package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Product;
import local.example.demo.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // findby all product
    public List<Product> findAllProduct() {
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
}
