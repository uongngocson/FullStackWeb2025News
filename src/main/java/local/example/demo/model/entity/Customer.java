package local.example.demo.model.entity;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
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

    @Column(name = "PhoneNumber")
    private String phoneNumber;

    @Column(name = "Email")
    private String email;

    @Column(name = "DateOfBirth")
    private LocalDate dateOfBirth;

    @Column(name = "RegistrationDate")
    private LocalDate registrationDate;

    @Column(name = "Gender")
    private boolean gender;

    @Column(length = 255)
    private String profileImage;

    @Column(name = "Status")
    private boolean status;
}
