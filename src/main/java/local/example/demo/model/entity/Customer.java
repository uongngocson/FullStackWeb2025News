package local.example.demo.model.entity;

import java.time.LocalDate;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

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
    private String firstName;


    @Column(name = "LastName")
    private String lastName;


    @Pattern(regexp = "^\\d{10,11}$", message = "Phone number must be 10-11 digits")
    @Column(name = "PhoneNumber")
    private String phoneNumber;

    @NotBlank(message = "Email is required")
    @Email(message = "Email is not valid")
    @Column(name = "Email")
    private String email;

    @Past(message = "Date of birth must be in the past")
    @Column(name = "DateOfBirth")
    private LocalDate dateOfBirth;

    // Có thể cho tự động set ngày hiện tại nên không cần nhập
    @Column(name = "RegistrationDate")
    private LocalDate registrationDate;

    @Column(name = "Gender")
    private boolean gender;


    private String profileImage;

    @Column(name = "Status")
    private boolean status;
}
