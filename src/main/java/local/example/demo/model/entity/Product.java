package local.example.demo.model.entity;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Product")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ProductId")
    private Integer productId;

    @ManyToOne
    @JoinColumn(name = "ShopId")
    @NotNull(message = "Shop cannot be null")
    private Shop shop;

    @ManyToOne
    @JoinColumn(name = "CategoryId")
    @NotNull(message = "Category cannot be null")
    private Category category;

    @ManyToOne
    @JoinColumn(name = "BrandId")
    @NotNull(message = "Brand cannot be null")
    private Brand brand;

    @Column(name = "ProductName")
    @NotBlank(message = "Product name cannot be blank")
    private String productName;

    @Column(name = "Description")
    private String description;

    @Column(name = "Price")
    @DecimalMin(value = "0.0", message = "Price must be greater than or equal to 0")
    private BigDecimal price;

    @Column(name = "ImageUrl")
    private String imageUrl;

    @Column(name = "QuantityInStock")
    @Min(value = 0, message = "Quantity in stock must be greater than or equal to 0")
    private Integer quantityInStock;

    @Column(name = "Views")
    @Min(value = 0, message = "Views must be greater than or equal to 0")
    private Integer views;

    @Column(name = "Warranty")
    @NotBlank(message = "Warranty cannot be blank")
    private String warranty;

    @Column(name = "ReturnPolicy")
    @NotBlank(message = "Return policy cannot be blank")
    private String returnPolicy;
}
