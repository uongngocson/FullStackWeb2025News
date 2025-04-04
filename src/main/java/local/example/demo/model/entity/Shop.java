package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Entity
@Table(name = "Shop")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Shop {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShopId")
    private Integer shopId;

    @Column(name = "ShopName")
    @NotBlank(message = "Shop name cannot be blank")
    private String shopName;

    @Column(name = "ContactPerson")
    @NotBlank(message = "Contact person cannot be blank")
    private String contactPerson;

    @Column(name = "ShopAddress")
    @NotBlank(message = "Shop address cannot be blank")
    private String shopAddress;

    @Column(name = "ShopDescription")
    @NotBlank(message = "Shop description cannot be blank")
    private String shopDescription;

    @Column(name = "OperatingHours")
    @NotBlank(message = "Operating hours cannot be blank")
    private String operatingHours;
}