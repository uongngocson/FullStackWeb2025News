package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
@Table(name = "Orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    @Id
    @Column(name = "OrderId")
    private String orderId;

    @ManyToOne
    @JoinColumn(name = "CustomerId")
    @NotNull(message = "Customer is required")
    private Customer customer;

    @Column(name = "OrderDate", columnDefinition = "DATETIME DEFAULT CURRENT_TIMESTAMP")
    @NotNull(message = "Order date is required")
    private LocalDateTime orderDate;

    @Column(name = "ExpectedDeliveryDate")
    private LocalDate expectedDeliveryDate;

    @Column(name = "TotalAmount")
    @NotNull(message = "Total amount is required")
    private BigDecimal totalAmount;

    @Column(name = "DiscountAmount")
    @Min(value = 0, message = "Discount amount must be non-negative")
    private BigDecimal discountAmount;

    @Column(name = "ShippingFee")
    @NotNull(message = "Shipping fee is required")
    private BigDecimal shippingFee;

    @Column(name = "OrderStatus")
    private String orderStatus;

    @ManyToOne
    @JoinColumn(name = "ShippingAddressID")
    private Address shippingAddress;

    @ManyToOne
    @JoinColumn(name = "PaymentId")
    @NotNull(message = "Payment is required")
    private Payment payment;

    @Column(name = "PaymentStatus")
    private String paymentStatus;
}
