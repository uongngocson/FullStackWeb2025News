package local.example.demo.model.entity;

import java.time.Instant;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "purchase_receipt")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseReceipt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "purchase_receipt_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "supplier_id")
    @NotNull(message = "Supplier cannot be null") // Corrected message
    private Supplier supplier;

    @NotNull(message = "Receipt code cannot be null")
    private String receiptCode;

    @NotNull(message = "Total amount cannot be null")
    @Min(value = 0, message = "Total amount must be a positive number")
    private Double totalAmount;

    @Lob
    private String note;

    @ManyToOne(fetch = jakarta.persistence.FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    @NotNull(message = "Employee cannot be null")
    private Employee employee;

    @NotNull(message = "Created at cannot be null")
    @DateTimeFormat(pattern = "dd-MM-yyyy")
    private Date createAt;

    @OneToMany(mappedBy = "purchaseReceipt")
    private List<PurchaseReceiptDetail> purchaseReceiptDetails;

    @PrePersist
    public void prePersist() {
        createAt = Date.from(Instant.now());
    }
}
