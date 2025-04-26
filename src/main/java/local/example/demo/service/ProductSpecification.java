package local.example.demo.service;

import org.springframework.data.jpa.domain.Specification;

import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Product_;

public class ProductSpecification {
    public static Specification<Product> nameBrandLike(String nameBrand) {
        return null;
        
    }
    
}
