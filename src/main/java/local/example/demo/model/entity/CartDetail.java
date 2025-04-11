package local.example.demo.model.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "CartDetails")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cartDetailId;

    // attributes
    @NotBlank(message = "Quantity is required")
    private Integer quantity;

    @NotNull(message = "Add date is required")
    private Date addedDate;

    // relationships with cart
    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart;

    // relationships with product variant
    @ManyToOne
    @JoinColumn(name = "product_variant_id")
    private ProductVariant productVariant;
}
