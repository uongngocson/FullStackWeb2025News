package local.example.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import local.example.demo.model.entity.Account;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    // Define methods for CRUD operations on Account entity
    // For example:
    // List<Account> findAll();
    // Account findById(Integer id);
    // void save(Account account);
    // void deleteById(Integer id);

    boolean existsByLoginName(String loginName);

    Account findByLoginName(String loginName);

    @Query("SELECT a FROM Account a LEFT JOIN FETCH a.role WHERE a.loginName = :loginName")
    Optional<Account> findByLoginNameWithRole(@Param("loginName") String loginName);

    // Phương thức phân trang cho tài khoản với eager loading của role
    @Query(value = "SELECT a FROM Account a LEFT JOIN FETCH a.role",
           countQuery = "SELECT COUNT(a) FROM Account a")
    Page<Account> findAllAccountsPaginated(Pageable pageable);

    // Corrected Query - sử dụng OR thay vì AND để logic chính xác hơn, và thêm index hint
    @Query("SELECT a FROM Account a WHERE (a.role.roleName = 'EMPLOYEE' OR a.role.roleName = 'ADMIN') AND a.accountId NOT IN (SELECT e.account.accountId FROM Employee e WHERE e.account IS NOT NULL)")
    List<Account> findAccountsNotLinkedToEmployee();

    // Phương thức tối ưu để lấy tài khoản theo ID với eager loading của role
    @Query("SELECT a FROM Account a LEFT JOIN FETCH a.role WHERE a.accountId = :accountId")
    Optional<Account> findByIdWithRole(@Param("accountId") Integer accountId);
}
