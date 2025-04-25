package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.util.List;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Products")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @NotBlank(message = "Product name cannot be blank")
    @Column(name = "product_name")
    private String productName;

    @Column(name = "description")
    private String description;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    @Column(name = "price")
    private BigDecimal price;

    @NotNull(message = "Quantity sold cannot be null")
    @Min(value = 0, message = "Quantity sold must be greater than or equal to 0")
    @Column(name = "quantity_sold")
    private Integer quantitySold;

    @NotBlank(message = "Warranty cannot be blank")
    @Column(name = "warranty")
    private String warranty;

    @NotBlank(message = "Return policy cannot be blank")
    @Column(name = "return_policy")
    private String returnPolicy;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "rating")
    private Integer rating;

    @Column(name = "type")
    private Boolean type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supplier_id")
    @NotNull(message = "Supplier cannot be null")
    private Supplier supplier;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    @NotNull(message = "Category cannot be null")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "brand_id")
    @NotNull(message = "Brand cannot be null")
    private Brand brand;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<Review> reviews;
}
