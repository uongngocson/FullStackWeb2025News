package local.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.ProductVariantRepository;

@Service
public class ProductVariantService {

    @Autowired
    private ProductVariantRepository productVariantRepository;

   
    public List<ProductVariant> findVariantsByProductId(Integer productId) {
        return productVariantRepository.findByProduct_ProductId(productId);
    }

    public ProductVariant findById(Integer id) {
        return productVariantRepository.findById(id).orElse(null);
    }

    public void save(ProductVariant variant) {
        productVariantRepository.save(variant);
    }

    public void deleteById(Integer id) {
        productVariantRepository.deleteById(id);
    }

    public List<ProductVariant> findAll() {
        return productVariantRepository.findAll();
    }
}
