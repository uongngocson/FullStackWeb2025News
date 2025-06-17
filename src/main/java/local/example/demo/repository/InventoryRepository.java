package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Inventory;

@Repository
public interface InventoryRepository extends JpaRepository<Inventory, Integer> {

    boolean existsByProductVariant_ProductVariantId(Integer id);

    Inventory findByProductVariant_ProductVariantId(Integer id);

}
