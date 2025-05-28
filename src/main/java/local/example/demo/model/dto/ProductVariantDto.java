package local.example.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariantDto {
    private Integer productVariantId;
    private String SKU;
    private String imageUrl;
    private String image_url3d;
    private Integer quantityStock;

    // Chỉ lấy thông tin cần thiết từ các đối tượng liên quan
    private Integer productId;
    private String productName;

    private Integer sizeId;
    private String sizeName;

    private Integer colorId;
    private String colorName;

    // Constructor để chuyển đổi từ entity sang DTO
    public ProductVariantDto(local.example.demo.model.entity.ProductVariant variant) {
        this.productVariantId = variant.getProductVariantId();
        this.SKU = variant.getSKU();
        this.imageUrl = variant.getImageUrl();
        this.quantityStock = variant.getQuantityStock();

        if (variant.getProduct() != null) {
            this.productId = variant.getProduct().getProductId();
            this.productName = variant.getProduct().getProductName();
        }

        if (variant.getSize() != null) {
            this.sizeId = variant.getSize().getSizeId();
            this.sizeName = variant.getSize().getSizeName();
        }

        if (variant.getColor() != null) {
            this.colorId = variant.getColor().getColorId();
            this.colorName = variant.getColor().getColorName();
        }
    }
}
