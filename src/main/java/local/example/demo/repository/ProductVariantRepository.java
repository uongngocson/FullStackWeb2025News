package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.ProductVariant;

@Repository
public interface ProductVariantRepository extends JpaRepository<ProductVariant, Integer> {


}
