package local.example.demo.repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.PurchaseReceipt;
import local.example.demo.model.entity.Supplier;

@Repository
public interface PurchaseReceiptRepository extends JpaRepository<PurchaseReceipt, Integer> {

    @Query(value = "EXEC sp_GetImportValueByDateRange :startDate, :endDate", nativeQuery = true)
    List<Object[]> getImportValueByDateRange(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    @Query(value = "EXEC sp_GetImportValueByWeekInMonth :year, :month", nativeQuery = true)
    List<Object[]> getImportValueByWeekInMonth(@Param("year") int year, @Param("month") int month);

    @Query(value = "EXEC sp_GetImportValueByMonth :year", nativeQuery = true)
    List<Object[]> getImportValueByMonth(@Param("year") int year);

    Optional<PurchaseReceipt> findByReceiptCode(String receiptCode);

    List<PurchaseReceipt> findBySupplier(Supplier supplier);

    List<PurchaseReceipt> findByCreateAtBetween(Date startDate, Date endDate);

    // Corrected method signature to reference supplierName property of Supplier
    // entity
    List<PurchaseReceipt> findByReceiptCodeContainingOrSupplier_SupplierNameContaining(String receiptCode,
            String supplierName);

    boolean existsByEmployee(Employee employee);

    @Query(value = "SELECT * FROM purchase_receipt", nativeQuery = true)
    List<PurchaseReceipt> findAllPurchaseReceipts();
}
