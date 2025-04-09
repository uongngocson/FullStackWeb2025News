package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

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

    @Column(name = "PhoneNumber")
    @NotBlank(message = "Phone number cannot be blank")
    private String phoneNumber;

    @Column(name = "Email")
    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Please provide a valid email address")
    private String email;

    @Column(name = "ShopAddress")
    @NotBlank(message = "Shop address cannot be blank")
    private String shopAddress;

    @Column(name = "ShopDescription")
    @NotBlank(message = "Shop description cannot be blank")
    private String shopDescription;

    @Column(name = "OperatingHours")
    @NotBlank(message = "Operating hours cannot be blank")
    private String operatingHours;

    @Column(name = "IsActive")
    @NotNull(message = "Shop status (active/inactive) must be specified")
    private Boolean isActive = true;

    @Column(name = "LogoUrl")
    private String logoUrl;

    @Column(name = "CoverImageUrl")
    private String coverImageUrl;

    @Column(name = "ShopCategory")
    private String shopCategory;

    @Column(name = "Rating")
    @PositiveOrZero(message = "Rating must be zero or positive")
    private Float rating;

    @Column(name = "TotalFollowers")
    @PositiveOrZero(message = "Followers count must be zero or positive")
    private Integer totalFollowers;

    @Column(name = "CreatedAt")
    private LocalDateTime createdAt;

    // Set default values for CreatedAt when the entity is created
    @PrePersist
    public void prePersist() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
    }
}
