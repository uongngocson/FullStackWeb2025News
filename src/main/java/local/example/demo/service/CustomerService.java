package local.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.hibernate.TransientObjectException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.repository.CartDetailRepository;
import local.example.demo.repository.CartRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.OrderRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class CustomerService {

    private final CustomerRepository customerRepository;
    private final OrderRepository orderRepository;
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;

    @Transactional(readOnly = true)
    public List<Customer> findAllCustomers() {
        return customerRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Customer findCustomerById(Integer customerId) {
        return customerRepository.findById(customerId).orElse(null);
    }

    @Transactional
    public void saveCustomer(Customer customer) {
        customerRepository.save(customer);
    }

    @Transactional
    public void deleteCustomerById(Integer customerId) {
        Optional<Customer> customerOpt = customerRepository.findById(customerId);

        if (customerOpt.isEmpty()) {
            throw new IllegalArgumentException("Không tìm thấy khách hàng có ID: " + customerId);
        }

        Customer customer = customerOpt.get();

        try {
            customerRepository.delete(customer);
        } catch (TransientObjectException e) {
            throw new RuntimeException("Lỗi Hibernate (TransientObjectException): " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi xóa khách hàng: " + e.getMessage(), e);
        }
    }

    @Transactional(readOnly = true)
    public List<Order> findOrdersByCustomerId(Integer customerId) {
        return orderRepository.findByCustomerId(customerId);
    }

    public boolean existsByEmail(String email) {
        return customerRepository.existsByEmail(email);
    }

    // find customer by account
    public Customer getCustomerByAccount(Account account) {
        return customerRepository.findByAccount(account);
    }

    // get cart detail count by cart
    public int getCartDetailCountByCart(Customer customer) {
        return cartDetailRepository.countByCart(customer.getCart());
    }

        // get cart by customer
    public Cart getCartByCustomer(Customer customer) {
        return cartRepository.findByCustomer(customer);
    }


    // mapper registerDTO to customer
    public Customer mapRegisterDTOToCustomer(RegisterDTO registerDTO) {
        Customer customer = new Customer();
        customer.setFirstName(registerDTO.getFirstName());
        customer.setLastName(registerDTO.getLastName());
        customer.setEmail(registerDTO.getEmail());
        customer.setPhone(registerDTO.getPhoneNumber());
        return customer;
    }

}
