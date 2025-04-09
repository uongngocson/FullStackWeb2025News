package local.example.demo.service;

import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Random;

@RequiredArgsConstructor
@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    public Order getOrderById(String orderId) {
        return orderRepository.findById(orderId).orElse(null);
    }

    @Transactional
    public void saveOrder(Order order) {
        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            // Trường hợp tạo mới
            order.setOrderId(generateRandomOrderId());
            orderRepository.save(order);
        } else {
            // Trường hợp cập nhật: lấy từ DB trước
            Order existingOrder = orderRepository.findById(order.getOrderId())
                    .orElseThrow(() -> new RuntimeException("Order not found: " + order.getOrderId()));
            orderRepository.save(existingOrder);
        }
    }

    public void deleteOrder(String orderId) {
        orderRepository.deleteById(orderId);
    }

    public List<OrderDetail> getOrderDetailByOrderId(String orderId) {
        return orderDetailRepository.findByOrderId(orderId);
    }

    /**
     * Generates a random 10-character order ID
     * 
     * @return A unique order ID string
     */
    private String generateRandomOrderId() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder orderId = new StringBuilder();
        Random random = new Random();

        // Generate a 10-character random string
        for (int i = 0; i < 10; i++) {
            orderId.append(characters.charAt(random.nextInt(characters.length())));
        }

        // Check if the generated ID already exists
        if (orderRepository.existsById(orderId.toString())) {
            // If it exists, generate a new one recursively
            return generateRandomOrderId();
        }

        return orderId.toString();
    }
}
