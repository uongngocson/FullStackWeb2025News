package local.example.demo.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Address")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Address {
    @Id
    @Column(name = "address_id")
    private Integer addressId;

    @Column(name = "street")
    private String street;

    @Column(name = "country")
    private String country;
    
    @Column(name = "recipientName")
    private String recipientName;
    
    @Column(name = "recipientPhone")
    private String recipientPhone;

    // Các trường để map với quan hệ
    @Column(name = "ward_id")
    private Integer wardId;

    @Column(name = "district_id")
    private Integer districtId;

    @Column(name = "province_id")
    private Integer provinceId;
    
    // Relationships
    @ManyToOne
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ward_id", insertable = false, updatable = false)
    private GHNWard ghnWard;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "district_id", insertable = false, updatable = false)
    private GHNDistrict ghnDistrict;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "province_id", insertable = false, updatable = false)
    private GHNProvince ghnProvince;

    // Helper method để lấy địa chỉ đầy đủ
    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();

        if (recipientName != null && !recipientName.isEmpty()) {
            sb.append(recipientName);
            if (recipientPhone != null && !recipientPhone.isEmpty()) {
                sb.append(" (").append(recipientPhone).append(")");
            }
            sb.append(" - ");
        }

        if (street != null && !street.isEmpty()) {
            sb.append(street);
        }

        // Ưu tiên sử dụng đối tượng GHN nếu có
        if (ghnWard != null && ghnWard.getWardName() != null) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(ghnWard.getWardName());
        }

        if (ghnDistrict != null && ghnDistrict.getDistrictName() != null) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(ghnDistrict.getDistrictName());
        }

        if (ghnProvince != null && ghnProvince.getProvinceName() != null) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(ghnProvince.getProvinceName());
        }

        if (country != null && !country.isEmpty()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(country);
        }

        return sb.toString();
    }
    
    // Các phương thức getter cho các trường không có trong bảng nhưng được sử dụng trong code
    public String getWard() {
        return ghnWard != null ? ghnWard.getWardName() : null;
    }
    
    public String getDistrict() {
        return ghnDistrict != null ? ghnDistrict.getDistrictName() : null;
    }
    
    public String getProvince() {
        return ghnProvince != null ? ghnProvince.getProvinceName() : null;
    }
}