package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.util.List;

@Entity
@Table(name = "Colors")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "color_id")
    private Integer colorId;

    @NotBlank(message = "Color name cannot be blank")
    @Column(name = "color_name")
    private String colorName;

    @NotBlank(message = "Color hex cannot be blank")
    @Column(name = "color_hex")
    private String colorHex;

    @OneToMany(mappedBy = "color", fetch = FetchType.LAZY)
    private List<ProductVariant> productVariants;
}
