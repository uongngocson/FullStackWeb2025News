package local.example.demo.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
// @Table(name = "Address")
@Table(name = "Addresses")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer addressId;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    private String street;

    private String country;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ward_id", insertable = false, updatable = false)
    private GHNWard ward;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "district_id", insertable = false, updatable = false)
    private GHNDistrict district;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "province_id", insertable = false, updatable = false)
    private GHNProvince province;

    // @Column(name = "recipientName", length = 100)
    // private String recipientName;

    // @Column(name = "recipientPhone", length = 15)
    // private String recipientPhone;

    // Helper method để lấy địa chỉ đầy đủ
    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();

        if (street != null && !street.isEmpty()) {
            sb.append(street);
        }

        if (ward != null && ward.getWardName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(ward.getWardName());
        }

        if (district != null && district.getDistrictName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(district.getDistrictName());
        }

        if (province != null && province.getProvinceName() != null) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(province.getProvinceName());
        }

        if (country != null && !country.isEmpty()) {
            if (sb.length() > 0)
                sb.append(", ");
            sb.append(country);
        }
        return sb.toString();
    }
}