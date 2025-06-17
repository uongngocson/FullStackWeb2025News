package local.example.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.CodPayment;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Shipment;

@Repository
public interface CodPaymentRepository extends JpaRepository<CodPayment, Integer> {
    
    // Find COD payment by shipment
    Optional<CodPayment> findByShipment(Shipment shipment);
    
    // Find COD payments by shipper
    List<CodPayment> findByShipper(Employee shipper);
    
    // Find COD payments by status
    List<CodPayment> findBySubmittedStatus(String submittedStatus);
    
    // Find COD payments by shipper and status
    List<CodPayment> findByShipperAndSubmittedStatus(Employee shipper, String submittedStatus);
    
    // Check if COD payment exists for shipment
    boolean existsByShipment(Shipment shipment);
    
    // Find pending COD payments for a shipper
    @Query("SELECT cp FROM CodPayment cp WHERE cp.shipper = :shipper AND cp.submittedStatus = 'NOT_SUBMITTED'")
    List<CodPayment> findPendingCodPaymentsByShipper(@Param("shipper") Employee shipper);
} 