package local.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Shipment;

@Repository
public interface ShipmentRepository extends JpaRepository<Shipment, Integer>  {
        boolean existsByOrder_OrderId(String orderId);
}
