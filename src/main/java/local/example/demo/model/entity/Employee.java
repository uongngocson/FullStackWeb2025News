package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Employee")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "EmployeeId")
    private Integer employeeId;

    @OneToOne
    @JoinColumn(name = "AccountId")
    private Account account;

    @ManyToOne
    @JoinColumn(name = "ShopId")
    private Shop shop;

    @Column(name = "FirstName")
    private String firstName;

    @Column(name = "LastName")
    private String lastName;

    @Column(name = "Address")
    private String address;

    @Column(name = "DateOfBirth")
    private String dateOfBirth;

    @Column(name = "Gender")
    private boolean gender;

    @Column(name = "Email")
    private String email;

    @Column(name = "PhoneNumber")
    private LocalDate phoneNumber;

    @Column(name = "HireDate")
    private LocalDate hireDate;

    @Column(name = "Salary")
    private BigDecimal salary;

    @Column(name = "Status")
    private boolean status;

    @ManyToOne
    @JoinColumn(name = "managerId")
    private Employee manager;

    @Column(length = 20)
    private String employeeType;
}