package local.example.demo.service;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.repository.CartDetailRepository;
import local.example.demo.repository.CartRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.ProductVariantRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductVariantService {
    private final ProductVariantRepository productVariantRepository;
    private final CustomerRepository customerRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;


        // handle add to cart
    public void handleAddToCart(String email, Integer productVariantId) {
        Customer customer = customerRepository.findByEmail(email);
        Cart cart = cartRepository.findByCustomer(customer);
        if (cart == null) {
            cart = new Cart();
            cart.setCustomer(customer);
            cartRepository.save(cart);
        }
        
        Optional<ProductVariant> productVariant = productVariantRepository.findById(productVariantId);
        if (productVariant.isPresent()) {
            ProductVariant productVariantHere = productVariant.get();
            CartDetail cartDetail = this.cartDetailRepository.findByCartAndProductVariant(cart, productVariant.get());
            if (cartDetail == null) {
                cartDetail = new CartDetail();
                cartDetail.setCart(cart);
                cartDetail.setProductVariant(productVariantHere);
                cartDetail.setPrice(productVariantHere.getProduct().getPrice());
                cartDetail.setQuantity(1);
                cartDetail.setAddedDate(LocalDateTime.now());
                cartDetailRepository.save(cartDetail);
            } else {
                cartDetail.setQuantity(cartDetail.getQuantity() + 1);
                cartDetailRepository.save(cartDetail);
            }

            
        }
    }
}
