package local.example.demo.model.dto;

import java.math.BigDecimal;

import local.example.demo.model.entity.ProductVariant;

public class OrderItemDTO {
    private ProductVariant variant;
    private int quantity;

    public OrderItemDTO(ProductVariant variant, int quantity) {
        this.variant = variant;
        this.quantity = quantity;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public int getQuantity() {
        return quantity;
    }

    public BigDecimal getTotalPrice() {
        return variant.getProduct().getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
