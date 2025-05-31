package local.example.demo.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import java.math.BigDecimal;
import java.util.List;

public class HandleSubmitDTO {
    private Integer customer_id;
    private Integer payment_id;
    
    @JsonProperty("TotalAmount")
    private BigDecimal totalAmount;
    
    @JsonProperty("OrderItems")
    private List<OrderItemDTO> orderItems;
    
    @JsonProperty("AddressId")
    private Integer addressId;
    
    private String recipient_name;
    private String recipient_phone;
    
    @JsonProperty("Street")
    private String street;
    
    @JsonProperty("ProvinceId")
    private Integer provinceId;
    
    @JsonProperty("DistrictId")
    private Integer districtId;
    
    @JsonProperty("WardId")
    private String wardId;
    
    @JsonProperty("Country")
    private String country;
    
    @JsonProperty("ProductVariantIds")
    private String productVariantIds;

    // Inner class for order items
    public static class OrderItemDTO {
        private Integer product_variant_id;
        private Integer quantity;

        public Integer getProduct_variant_id() {
            return product_variant_id;
        }

        public void setProduct_variant_id(Integer product_variant_id) {
            this.product_variant_id = product_variant_id;
        }

        public Integer getQuantity() {
            return quantity;
        }

        public void setQuantity(Integer quantity) {
            this.quantity = quantity;
        }
    }

    // Getters and setters
    public Integer getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(Integer customer_id) {
        this.customer_id = customer_id;
    }

    public Integer getPayment_id() {
        return payment_id;
    }

    public void setPayment_id(Integer payment_id) {
        this.payment_id = payment_id;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<OrderItemDTO> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItemDTO> orderItems) {
        this.orderItems = orderItems;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public String getRecipient_name() {
        return recipient_name;
    }

    public void setRecipient_name(String recipient_name) {
        this.recipient_name = recipient_name;
    }

    public String getRecipient_phone() {
        return recipient_phone;
    }

    public void setRecipient_phone(String recipient_phone) {
        this.recipient_phone = recipient_phone;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    public String getWardId() {
        return wardId;
    }

    public void setWardId(String wardId) {
        this.wardId = wardId;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getProductVariantIds() {
        return productVariantIds;
    }

    public void setProductVariantIds(String productVariantIds) {
        this.productVariantIds = productVariantIds;
    }
}
