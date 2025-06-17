package local.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.PurchaseReceiptDetail;

@Repository
public interface PurchaseReceiptDetailsRepository extends JpaRepository<PurchaseReceiptDetail, Integer> {

    // 1. Tính tổng giá trị nhập của tất cả phiếu nhập
    @Query(value = "EXEC sp_GetTotalImportValue", nativeQuery = true)
    Object getTotalImportValue();

    List<PurchaseReceiptDetail> findByPurchaseReceiptId(Integer receiptId);

    // Add a custom query to calculate the total value for a purchase receipt
    @Query("SELECT SUM(pd.quantity * pd.unitPrice) FROM PurchaseReceiptDetail pd WHERE pd.purchaseReceipt.id = :receiptId")
    Double calculateReceiptTotal(Integer receiptId);

}
