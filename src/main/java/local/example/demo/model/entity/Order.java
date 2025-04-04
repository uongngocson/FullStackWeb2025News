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
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Order")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "OrderId")
    private Integer orderId;

    @ManyToOne
    @JoinColumn(name = "CustomerId")
    private Customer customer;

    @Column(name = "OrderDate", columnDefinition = "DATETIME DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime orderDate;

    @Column(name = "ExpectedDeliveryDate")
    private LocalDate expectedDeliveryDate;

    @Column(name = "TotalAmount")
    private BigDecimal totalAmount;

    @Column(name = "DiscountAmount")
    private BigDecimal discountAmount;

    @Column(name = "ShippingFee")
    private BigDecimal shippingFee;

    @Column(name = "OrderStatus")
    private String orderStatus;

    @ManyToOne
    @JoinColumn(name = "ShippingAddressID")
    private Address shippingAddress;

    @ManyToOne
    @JoinColumn(name = "PaymentId")
    private Payment payment;

    @Column(name = "PaymentStatus")
    private String paymentStatus;
}
