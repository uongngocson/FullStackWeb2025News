package local.example.demo.model.dto;

import local.example.demo.model.entity.PurchaseReceiptDetail;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor // Cần constructor mặc định cho Jackson (objectMapper) khi parse JSON từ form
public class PurchaseReceiptDetailDto {
    private Integer id; // Thêm ID để xử lý cập nhật chi tiết
    private Integer productVariantId;
    private Integer quantity;
    private Double unitPrice;

    // Constructor để chuyển đổi từ Entity sang DTO
    public PurchaseReceiptDetailDto(PurchaseReceiptDetail detail) {
        this.id = detail.getId(); // Lấy ID từ entity
        this.productVariantId = detail.getProductVariant() != null ? detail.getProductVariant().getProductVariantId()
                : null;
        this.quantity = detail.getQuantity();
        this.unitPrice = detail.getUnitPrice();
    }
}
