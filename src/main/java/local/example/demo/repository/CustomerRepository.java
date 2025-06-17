package local.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Account;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

    boolean existsByEmail(String email);

    Customer findByAccount(Account account);

    Customer findByEmail(String email);

    Customer findByAccountLoginName(String loginName);

    Boolean existsByAccount(Account account);
    
    // Phương thức tìm kiếm và phân trang
    Page<Customer> findAll(Pageable pageable);
    
    Page<Customer> findByStatus(Boolean status, Pageable pageable);
    
    @Query("SELECT c FROM Customer c WHERE (LOWER(c.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(c.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(c.email) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
           "AND c.status = :status")
    Page<Customer> findByFirstNameContainingOrLastNameContainingOrEmailContainingAndStatus(
            @Param("keyword") String firstName, 
            @Param("keyword") String lastName, 
            @Param("keyword") String email, 
            @Param("status") Boolean status, 
            Pageable pageable);
    
    @Query("SELECT c FROM Customer c WHERE LOWER(c.firstName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(c.lastName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
           "LOWER(c.email) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Customer> findByFirstNameContainingOrLastNameContainingOrEmailContaining(
            @Param("keyword") String firstName, 
            @Param("keyword") String lastName, 
            @Param("keyword") String email, 
            Pageable pageable);
}
