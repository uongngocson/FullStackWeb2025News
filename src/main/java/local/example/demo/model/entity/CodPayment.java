package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "COD_Payments")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CodPayment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cod_payment_id")
    private Integer codPaymentId;
    
    @ManyToOne
    @JoinColumn(name = "shipment_id")
    @NotNull(message = "Shipment cannot be null")
    private Shipment shipment;
    
    @ManyToOne
    @JoinColumn(name = "shipper_id")
    @NotNull(message = "Shipper cannot be null")
    private Employee shipper;
    
    @NotNull(message = "Amount cannot be null")
    @Column(name = "amount")
    private BigDecimal amount;
    
    @NotNull(message = "Collected date cannot be null")
    @Column(name = "collected_date")
    private LocalDate collectedDate;
    
    @Column(name = "submitted_date")
    private LocalDate submittedDate;
    
    @Column(name = "submitted_status")
    private String submittedStatus;
    
    @PrePersist
    public void prePersist() {
        if (submittedStatus == null) {
            submittedStatus = "NOT_SUBMITTED";
        }
        if (collectedDate == null) {
            collectedDate = LocalDate.now();
        }
    }
}
