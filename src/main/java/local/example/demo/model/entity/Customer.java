package local.example.demo.model.entity;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Customer")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CustomerId")
    private Integer customerId;

    @OneToOne
    @JoinColumn(name = "AccountId")
    private Account account;

    @OneToOne(mappedBy = "customer")
    private Cart cart;

    @Column(name = "FirstName")
    @NotBlank(message = "First name is required")
    private String firstName;

    @Column(name = "LastName")
    @NotBlank(message = "Last name is required")
    private String lastName;

    @Column(name = "PhoneNumber")
    @NotBlank(message = "Phone number is required")
    private String phoneNumber;

    @Column(name = "Email")
    @NotBlank(message = "Email is required")
    private String email;

    @Column(name = "DateOfBirth")
    @Past(message = "Date of birth must be in the past")
    @NotNull(message = "Date of birth is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateOfBirth;

    @Column(name = "RegistrationDate")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate registrationDate;

    @Column(name = "Gender")
    private boolean gender;

    @Column(length = 255)
    private String profileImage;

    @Column(name = "Status")
    private boolean status = true;

    public Date getDateOfBirthAsDate() {
        if (this.dateOfBirth == null)
            return null;
        return Date.from(this.dateOfBirth.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public Date getRegistrationDateAsDate() {
        if (this.registrationDate == null)
            return null;
        return Date.from(this.registrationDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

}
