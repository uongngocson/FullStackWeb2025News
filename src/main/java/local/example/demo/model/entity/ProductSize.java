package local.example.demo.model.entity;

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
@Table(name = "Product_Size")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductSize {
    @Id
    @ManyToOne
    @JoinColumn(name = "ProductId")
    private Product product;

    @Id
    @ManyToOne
    @JoinColumn(name = "SizeId")
    private Size size;
}
