package local.example.demo.model.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "Reviews")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Reviews {
    @Id
    @ManyToOne
    @JoinColumn(name = "OrderDetailId")
    private OrderDetail orderDetail;

    @Id
    @ManyToOne
    @JoinColumn(name = "CustomerId")
    private Customer customer;

    @Column(name = "Rating")
    private int rating;

    @Column(name = "Comment")
    private String comment;

    @Column(name = "ReviewDate")
    private LocalDateTime reviewDate;

    @Column(name = "ReviewImages")
    private String reviewImages;
}