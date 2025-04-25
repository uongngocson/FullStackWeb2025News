package local.example.demo.service;

import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityNotFoundException;

import org.springframework.security.access.AccessDeniedException;
import local.example.demo.model.entity.CartDetail;
import local.example.demo.model.entity.Customer;
import local.example.demo.repository.CartDetailRepository;

@Service
public class CartDetailService {
    
    private final CartDetailRepository cartDetailRepository;

    // Constructor injection to initialize the repository
    public CartDetailService(CartDetailRepository cartDetailRepository) {
        this.cartDetailRepository = cartDetailRepository;
    }

    @Transactional
    public void removeCartDetail(Integer cartDetailId, Customer customer) {
        // Verify customer is not null
        if (customer == null) {
            throw new AccessDeniedException("Customer not authenticated");
        }

        // Find the cart detail with verification
        Optional<CartDetail> cartDetailOpt = cartDetailRepository.findById(cartDetailId);
        
        if (!cartDetailOpt.isPresent()) {
            throw new EntityNotFoundException("Cart detail not found");
        }

        CartDetail cartDetail = cartDetailOpt.get();
        
        // Verify the cart belongs to the customer
        if (!cartDetail.getCart().getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            throw new AccessDeniedException("Not authorized to modify this cart");
        }
        
        cartDetailRepository.delete(cartDetail);
    }
}