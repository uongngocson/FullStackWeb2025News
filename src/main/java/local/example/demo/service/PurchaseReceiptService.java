package local.example.demo.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Random; // Import Random

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.entity.Inventory;
import local.example.demo.model.entity.PurchaseReceipt;
import local.example.demo.model.entity.PurchaseReceiptDetail;
import local.example.demo.model.entity.Supplier;
import local.example.demo.repository.InventoryRepository; // Import InventoryRepository
import local.example.demo.repository.PurchaseReceiptDetailsRepository;
import local.example.demo.repository.PurchaseReceiptRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class PurchaseReceiptService {
    private final PurchaseReceiptRepository purchaseReceiptRepository;
    private final PurchaseReceiptDetailsRepository purchaseReceiptDetailsRepository;
    private final InventoryRepository inventoryRepository; // Inject InventoryRepository

    // Lấy tất cả phiếu nhập
    public List<PurchaseReceipt> getAllReceipts() {
        return purchaseReceiptRepository.findAll();
    }

    // Tổng giá trị nhập toàn bộ
    public Object getTotalImportValue() {
        return purchaseReceiptDetailsRepository.getTotalImportValue();
    }

    // Thống kê theo ngày trong khoảng
    public List<Object[]> getImportValueByDateRange(LocalDate start, LocalDate end) {
        return purchaseReceiptRepository.getImportValueByDateRange(Date.valueOf(start), Date.valueOf(end));
    }

    // Thống kê theo tháng trong năm
    public List<Object[]> getImportValueByMonth(int year) {
        return purchaseReceiptRepository.getImportValueByMonth(year);
    }

    // Thống kê theo tuần trong tháng
    public List<Object[]> getImportValueByWeekInMonth(int year, int month) {
        return purchaseReceiptRepository.getImportValueByWeekInMonth(year, month);
    }

    // Lấy phiếu nhập theo ID
    public Optional<PurchaseReceipt> getReceiptById(Integer id) {
        return purchaseReceiptRepository.findById(id);
    }

    // Lấy phiếu nhập theo mã phiếu
    public Optional<PurchaseReceipt> getReceiptByCode(String receiptCode) {
        return purchaseReceiptRepository.findByReceiptCode(receiptCode);
    }

    // Phương thức kiểm tra mã phiếu nhập có tồn tại không
    public boolean isReceiptCodeExists(String receiptCode) {
        return purchaseReceiptRepository.findByReceiptCode(receiptCode).isPresent();
    }

    // Phương thức tạo mã phiếu nhập ngẫu nhiên 13 ký tự (chữ và số)
    public String generateUniqueReceiptCode() {
        String code;
        Random random = new Random();
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        int length = 13;

        do {
            StringBuilder codeBuilder = new StringBuilder(length);
            for (int i = 0; i < length; i++) {
                codeBuilder.append(characters.charAt(random.nextInt(characters.length())));
            }
            code = codeBuilder.toString();
        } while (isReceiptCodeExists(code)); // Lặp lại nếu mã đã tồn tại

        return code;
    }

    // Lấy phiếu nhập theo nhà cung cấp
    public List<PurchaseReceipt> getReceiptsBySupplier(Supplier supplier) {
        return purchaseReceiptRepository.findBySupplier(supplier);
    }

    // Lấy phiếu nhập theo khoảng thời gian
    public List<PurchaseReceipt> getReceiptsByDateRange(java.util.Date startDate, java.util.Date endDate) {
        return purchaseReceiptRepository.findByCreateAtBetween(startDate, endDate);
    }

    // Phân trang phiếu nhập
    public Page<PurchaseReceipt> getReceiptsWithPagination(Pageable pageable) {
        return purchaseReceiptRepository.findAll(pageable);
    }

    // Lưu phiếu nhập mới
    @Transactional
    public PurchaseReceipt saveReceipt(PurchaseReceipt receipt) {
        return purchaseReceiptRepository.save(receipt);
    }

    // Lưu phiếu nhập và chi tiết phiếu nhập
    @Transactional
    public PurchaseReceipt saveReceiptWithDetails(PurchaseReceipt receipt, List<PurchaseReceiptDetail> details) {
        PurchaseReceipt savedReceipt = purchaseReceiptRepository.save(receipt);

        for (PurchaseReceiptDetail detail : details) {
            detail.setPurchaseReceipt(savedReceipt);
            purchaseReceiptDetailsRepository.save(detail);

            // Cập nhật tồn kho
            Integer productVariantId = detail.getProductVariant().getProductVariantId();
            Integer quantityReceived = detail.getQuantity();

            // Tìm kiếm mục nhập tồn kho cho biến thể sản phẩm này
            Inventory inventory = inventoryRepository.findByProductVariant_ProductVariantId(productVariantId);

            if (inventory != null) {
                // Nếu đã tồn tại, tăng số lượng
                inventory.setQuantityStock(inventory.getQuantityStock() + quantityReceived);
            } else {
                // Nếu chưa tồn tại, tạo mới mục nhập tồn kho
                inventory = new Inventory();
                inventory.setProductVariant(detail.getProductVariant()); // Sử dụng ProductVariant từ detail
                inventory.setQuantityStock(quantityReceived);
                // lastUpdate sẽ được set tự động bởi @PrePersist/@PreUpdate
            }
            // Lưu hoặc cập nhật mục nhập tồn kho
            inventoryRepository.save(inventory);
        }

        return savedReceipt;
    }

    // Cập nhật phiếu nhập
    @Transactional
    public PurchaseReceipt updateReceipt(PurchaseReceipt receipt) {
        if (receipt.getId() == null || !purchaseReceiptRepository.existsById(receipt.getId())) {
            throw new IllegalArgumentException("Cannot update non-existent receipt");
        }
        return purchaseReceiptRepository.save(receipt);
    }

    // Xóa phiếu nhập
    @Transactional
    public void deleteReceipt(Integer id) {
        purchaseReceiptRepository.deleteById(id);
    }

    // Lấy chi tiết của một phiếu nhập
    public List<PurchaseReceiptDetail> getReceiptDetails(Integer receiptId) {
        return purchaseReceiptDetailsRepository.findByPurchaseReceiptId(receiptId);
    }

    // Tính tổng giá trị của một phiếu nhập
    public Double calculateReceiptTotal(Integer receiptId) {
        return purchaseReceiptDetailsRepository.calculateReceiptTotal(receiptId);
    }

    // Tìm kiếm phiếu nhập theo từ khóa (mã phiếu hoặc tên nhà cung cấp)
    public List<PurchaseReceipt> searchReceipts(String keyword) {
        return purchaseReceiptRepository.findByReceiptCodeContainingOrSupplier_SupplierNameContaining(keyword, keyword);
    }
}
