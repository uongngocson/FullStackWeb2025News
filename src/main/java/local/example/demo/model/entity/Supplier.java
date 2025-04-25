package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Data
@Entity
@Table(name = "Suppliers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Supplier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_id") 
    private Integer supplierId;

    @Column(name = "supplier_name")
    @NotBlank(message = "Supplier name cannot be blank")
    private String supplierName;

    @Column(name = "contact_person")
    @NotBlank(message = "Contact person cannot be blank")
    private String contactPerson;

    @Column(name = "logo_url")
    private String logoUrl;

    @Column(name = "phone")
    @NotBlank(message = "Phone number cannot be blank")
    private String phone;

    @Column(name = "email")
    @NotBlank(message = "Email cannot be blank")
    @Email(message = "Please provide a valid email address")
    private String email;

    @Column(name = "address")
    @NotBlank(message = "supplier address cannot be blank")
    private String address;

    @Column(name = "status")
    @NotNull(message = "supplier status (active/inactive) must be specified")
    private Boolean status = true;

    // relationships
    @OneToMany(mappedBy = "supplier")
    private List<Product> products;
}

