package local.example.demo.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.JoinType;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.InventoryRepository;
import local.example.demo.repository.ProductRepository;
import local.example.demo.repository.ProductVariantRepository;
import lombok.RequiredArgsConstructor;

import java.math.BigDecimal;
import java.util.Optional;

import local.example.demo.exception.ProductInUseException;
import local.example.demo.model.entity.*;

import jakarta.persistence.criteria.Predicate;

@RequiredArgsConstructor
@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final ProductVariantRepository productVariantRepository;
    private final InventoryRepository inventoryRepository;

    // get all product
    public List<Product> findAllProducts() {
        return productRepository.findAllProducts();
    }

    // total stock product
    public long getTotalStock(Integer productId) {
        List<ProductVariant> productVariants = productVariantRepository.findByProduct_ProductId(productId);
        long sumQuantity = 0;
        for (ProductVariant productVariant : productVariants) {
            Inventory inventory = inventoryRepository
                    .findByProductVariant_ProductVariantId(productVariant.getProductVariantId());
            // Check if inventory is null before accessing quantityStock
            if (inventory != null) {
                Integer quantity = inventory.getQuantityStock();
                if (quantity != null) {
                    sumQuantity += quantity;
                }
            }
        }
        return sumQuantity;
    }

    // get all product by page
    public Page<Product> fetchProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    // public Page<Product> fetchProducts(String name, Pageable pageable) {
    // return productRepository.findAll(this.nameLike(name), pageable);
    // }

    // private Specification<Product> nameLike(String name){
    // return (root, query, criteriaBuilder) ->
    // criteriaBuilder.like(root.get(Product_.PRODUCT_NAME), "%"+name+"%");

    // }

    // save product
    public void saveProduct(Product product) {
        productRepository.save(product);
    }

    public Product findProductById(Integer productId) {
        return productRepository.findById(productId).orElse(null);
    }

    // delete product by id
    public void deleteProductById(Integer productId) {
        if (productVariantRepository.existsByProduct_ProductId(productId)) {
            throw new ProductInUseException("Không thể xóa! Sản phẩm này đang đại diện cho nhiều sản phầm");
        }
        Product product = productRepository.findById(productId).orElse(null);
        if (product.getProductVariant().size() > 0) {
            throw new ProductInUseException("Không thể xóa! Sản phẩm này đang có trong kho hàng");
        }
        productRepository.deleteById(productId);
    }

    // find product by id
    public Page<Product> findFilteredAndSortedProducts(
            Optional<Integer> brandId,
            Optional<Integer> categoryId,
            Optional<Integer> sizeId,
            Optional<Integer> colorId,
            Optional<BigDecimal> minPrice, // Thay đổi thành BigDecimal
            Optional<BigDecimal> maxPrice, // Thay đổi thành BigDecimal
            Optional<Boolean> type, // Thêm tham số type
            Optional<String> sortByOpt,
            Pageable pageable) {

        Specification<Product> spec = Specification.where(null); // Start with an empty specification

        // Chain the .and() conditions, reassigning to spec
        if (brandId.isPresent()) {
            spec = spec.and(brandIdEquals(brandId.get()));
        }
        if (categoryId.isPresent()) {
            spec = spec.and(categoryIdEquals(categoryId.get()));
        }
        // Lọc qua ProductVariant
        if (sizeId.isPresent()) {
            spec = spec.and(hasVariantWithSize(sizeId.get()));
        }
        if (colorId.isPresent()) {
            spec = spec.and(hasVariantWithColor(colorId.get()));
        }
        // Lọc theo giá (sử dụng BigDecimal)
        if (minPrice.isPresent()) {
            spec = spec.and(priceGreaterThanOrEqualTo(minPrice.get()));
        }
        if (maxPrice.isPresent()) {
            spec = spec.and(priceLessThanOrEqualTo(maxPrice.get()));
        }
        // Thêm lọc theo type
        if (type.isPresent()) {
            spec = spec.and(typeEquals(type.get()));
        }

        // Xử lý sắp xếp
        String sortBy = sortByOpt.orElse("newest"); // Mặc định là newest
        Sort sort;
        switch (sortBy) {
            case "priceAsc":
                sort = Sort.by(Sort.Direction.ASC, "price");
                break;
            case "priceDesc":
                sort = Sort.by(Sort.Direction.DESC, "price");
                break;
            case "bestSellers":
                sort = Sort.by(Sort.Direction.DESC, "quantitySold");
                break;
            case "newest":
            default:
                sort = Sort.by(Sort.Direction.DESC, "productId"); // Sắp xếp theo ID giảm dần (mới nhất)
                break;
        }

        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

        // Create a final variable for the spec to be used in the lambda
        final Specification<Product> finalSpec = spec;

        // Define the specification, using the finalSpec variable
        Specification<Product> specification = (root, query, cb) -> {
            Predicate predicate = null;
            if (finalSpec != null) {
                predicate = finalSpec.toPredicate(root, query, cb);
            }

            // Apply distinct only if filtering by size or color to avoid duplicates from
            // joins
            // if (sizeId.isPresent() || colorId.isPresent()) {
            // query.distinct(true);
            // }

            return predicate;
        };

        // Pass the specification to the repository
        return productRepository.findAll(specification, sortedPageable);
    }

    // --- Specification Helper Methods ---

    private Specification<Product> brandIdEquals(Integer brandId) {
        return (root, query, cb) -> cb.equal(root.get("brand").get("brandId"), brandId);
    }

    private Specification<Product> categoryIdEquals(Integer categoryId) {
        return (root, query, cb) -> cb.equal(root.get("category").get("categoryId"), categoryId);
    }

    // Specification để kiểm tra Product có variant với sizeId cụ thể
    private Specification<Product> hasVariantWithSize(Integer sizeId) {
        return (root, query, cb) -> {
            // Join Product với ProductVariant
            Join<Product, ProductVariant> variantJoin = root.join("productVariant", JoinType.INNER);
            // Join ProductVariant với Size
            Join<ProductVariant, Size> sizeJoin = variantJoin.join("size", JoinType.INNER);
            // Điều kiện lọc theo sizeId
            return cb.equal(sizeJoin.get("sizeId"), sizeId);
        };
    }

    // Specification để kiểm tra Product có variant với colorId cụ thể
    private Specification<Product> hasVariantWithColor(Integer colorId) {
        return (root, query, cb) -> {
            // Join Product với ProductVariant
            Join<Product, ProductVariant> variantJoin = root.join("productVariant", JoinType.INNER);
            // Join ProductVariant với Color
            Join<ProductVariant, Color> colorJoin = variantJoin.join("color", JoinType.INNER);
            // Điều kiện lọc theo colorId
            return cb.equal(colorJoin.get("colorId"), colorId);
        };
    }

    // Specification để kiểm tra giá >= minPrice (sử dụng BigDecimal)
    private Specification<Product> priceGreaterThanOrEqualTo(BigDecimal minPrice) {
        return (root, query, cb) -> cb.greaterThanOrEqualTo(root.get("price"), minPrice);
    }

    // Specification để kiểm tra giá <= maxPrice (sử dụng BigDecimal)
    private Specification<Product> priceLessThanOrEqualTo(BigDecimal maxPrice) {
        return (root, query, cb) -> cb.lessThanOrEqualTo(root.get("price"), maxPrice);
    }

    // Specification để lọc theo type (Boolean)
    private Specification<Product> typeEquals(Boolean type) {
        return (root, query, cb) -> cb.equal(root.get("type"), type);
    }

    // get product by supplierId
    public List<Product> findProductsBySupplierId(Integer supplierId) {
        return productRepository.findProductsBySupplierId(supplierId);
    }

    // get product type men
    public List<Product> findProductsByTypeMen() {
        return productRepository.findProductsByTypeMen();
    }

    // get product type men by page
    public Page<Product> findProductsByTypeMen(Pageable pageable) {
        return productRepository.findProductsByTypeMen(pageable);
    }

    // get product type women
    public List<Product> findProductsByTypeWomen() {
        return productRepository.findProductsByTypeWomen();
    }

    // get product type women by page
    public Page<Product> findProductsByTypeWomen(Pageable pageable) {
        return productRepository.findProductsByTypeWomen(pageable);
    }

    public List<ProductVariant> findVariantsByProductId(Integer productId) {
        return productVariantRepository.findByProduct_ProductId(productId);
    }

    public List<ProductVariant> findAllProductVariants() {
        return productVariantRepository.findAll();
    }

    public ProductVariant findProductVariantById(Integer productVariantId) {
        return productVariantRepository.findByProductVariantId(productVariantId);
    }

    // Thêm phương thức để lấy sản phẩm theo nhà cung cấp
    public List<Product> findProductsBySupplier(Integer supplierId) {
        return productRepository.findProductsBySupplierId(supplierId);
    }

    public Page<Product> findSortedProducts(
            Optional<Integer> categoryId,
            Optional<Boolean> type,
            Optional<String> sortByOpt,
            Pageable pageable) {

        Specification<Product> spec = Specification.where(null);

        // Áp dụng bộ lọc danh mục và loại
        if (categoryId.isPresent()) {
            spec = spec.and(categoryIdEquals(categoryId.get()));
        }
        if (type.isPresent()) {
            spec = spec.and(typeEquals(type.get()));
        }

        // Xử lý sắp xếp (chỉ priceAsc và priceDesc)
        String sortBy = sortByOpt.orElse("priceAsc");
        Sort sort = "priceDesc".equals(sortBy)
                ? Sort.by(Sort.Direction.DESC, "price")
                : Sort.by(Sort.Direction.ASC, "price");

        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);

        // Gán spec vào biến final để sử dụng trong lambda
        final Specification<Product> finalSpec = spec;

        Specification<Product> specification = (root, query, cb) -> finalSpec.toPredicate(root, query, cb);

        return productRepository.findAll(specification, sortedPageable);
    }

    // Find products by type and category
    public Page<Product> findProductsByTypeAndCategory(Boolean type, Integer categoryId, Pageable pageable) {
        Specification<Product> spec = Specification.where(typeEquals(type))
                .and(categoryIdEquals(categoryId));
        return productRepository.findAll(spec, pageable);
    }

    // Check if a category has products for a specific gender
    public boolean hasProductsForCategoryAndType(Integer categoryId, Boolean type) {
        Specification<Product> spec = Specification.where(categoryIdEquals(categoryId))
                .and(typeEquals(type));
        return productRepository.count(spec) > 0;
    }

}
