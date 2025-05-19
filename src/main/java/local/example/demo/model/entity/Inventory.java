package local.example.demo.model.entity;

import java.time.Instant;
import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Inventories")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Inventory {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer inventoryId;

    @ManyToOne
    @JoinColumn(name = "product_variant_id")
    @NotNull(message = "Product variant required")
    private ProductVariant productVariant;

    @NotNull(message = "Last Date update cannot be null")
    private Date lastUpdate;

    // attribute
    @NotNull(message = "Quantity stock cannot be null")
    @Min(value = 0, message = "Quantity stock must be greater than or equal to 0")
    private Integer quantityStock;

    @PrePersist
    public void prePersist() {
        lastUpdate = Date.from(Instant.now());
    }

    @PreUpdate
    public void preUpdate() {
        lastUpdate = Date.from(Instant.now());
    }
}
