package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "PurchaseReceiptDetails")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PurchaseReceiptDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "purchase_receipt_detail_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "purchase_receipt_id")
    @NotNull(message = "Purchase receipt is required") // Uncomment this
    private PurchaseReceipt purchaseReceipt;

    @ManyToOne
    @JoinColumn(name = "product_id")
    @NotNull(message = "Product is required") // Uncomment this
    private Product product;

    @ManyToOne
    @JoinColumn(name = "product_variant_id")
    @NotNull(message = "Product variant is required") // Uncomment this
    private ProductVariant productVariant;

    @NotNull(message = "Quantity is required") // Uncomment this
    @Min(value = 1, message = "Quantity must be greater than 0") // Uncomment this
    private Integer quantity;

    @NotNull(message = "Unit price is required") // Uncomment this
    @Min(value = 0, message = "Unit price must be greater than or equal to 0") // Uncomment this
    private Double unitPrice;
}
