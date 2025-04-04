package local.example.demo.model.entity;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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

@Entity
@Table(name = "Color")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ColorId")
    private Integer colorId;

    @Column(name = "ColorName")
    @NotBlank(message = "Color name cannot be blank")
    private String colorName;

    @OneToMany(mappedBy = "color")
    private List<ProductColor> productColors;
}
