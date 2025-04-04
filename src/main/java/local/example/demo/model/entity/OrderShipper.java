package local.example.demo.model.entity;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Order_Shipper")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OrderShipper {
    @Id
    @ManyToOne
    @JoinColumn(name = "OrderId")
    private Order order;

    @Id
    @ManyToOne
    @JoinColumn(name = "ShipperId")
    private Shipper shipper;

    @Column(name = "ShippingDate")
    private LocalDate shippingDate;

    @Column(name = "TrackingNumber")
    private String trackingNumber;

    @Column(name = "DeliveryStatus")
    private String deliveryStatus;

    @Column(name = "EstimatedDeliveryTime")
    private LocalDate estimatedDeliveryTime;
}
