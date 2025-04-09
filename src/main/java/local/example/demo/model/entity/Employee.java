package local.example.demo.model.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
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
    @NotBlank(message = "First name cannot be blank")
    private String firstName;

    @Column(name = "LastName")
    @NotBlank(message = "Last name cannot be blank")
    private String lastName;

    @Column(name = "ProfileImage")
    private String profileImage;

    @Column(name = "Address")
    private String address;

    @Column(name = "DateOfBirth")
    @NotNull(message = "Date of birth cannot be null")
    private LocalDate dateOfBirth;

    @Column(name = "Gender")
    private boolean gender;

    @Column(name = "Email")
    @NotBlank(message = "Email cannot be blank")
    private String email;

    @Column(name = "PhoneNumber")
    @NotBlank(message = "Phone number cannot be blank")
    private String phoneNumber;

    @Column(name = "HireDate")
    private LocalDate hireDate = LocalDate.now();

    @Column(name = "Salary")
    @NotNull(message = "Salary cannot be null")
    private BigDecimal salary;

    @Column(name = "Status")
    private boolean status;

    @ManyToOne
    @JoinColumn(name = "ManagerId")
    private Employee manager;

    @Column(length = 20)
    private boolean employeeType = false;

    public Date getHireDateAsDate() {
        if (this.hireDate == null)
            return null;
        return Date.from(this.hireDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }
}