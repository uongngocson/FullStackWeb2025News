package local.example.demo.service;

import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.sql.DataSource;

@RequiredArgsConstructor
@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

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
     * Calls the stored procedure to create a new order
     * 
     * @param customerId The ID of the customer
     * @param paymentId  The ID of the payment method
     * @param orderItems List of order items with product variant IDs and
     *                   quantities
     * @return CreateOrderResponse containing the result of the operation
     */
    @Transactional
    public CreateOrderResponse createOrderWithStoredProcedure(
            Integer customerId,
            Integer paymentId,
            List<OrderItemDTO> orderItems) {

        CreateOrderResponse response = new CreateOrderResponse();

        try {
            System.out.println("Creating order with params: customerId=" + customerId +
                    ", paymentId=" + paymentId);
            System.out.println("Order items:");
            for (OrderItemDTO item : orderItems) {
                System.out.println("- product_variant_id: " + item.getProduct_variant_id() +
                        ", quantity: " + item.getQuantity());
            }

            // Kiểm tra xem có orderItems nào không
            if (orderItems == null || orderItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No order items provided");
                return response;
            }

            // Lọc các orderItems không hợp lệ
            List<OrderItemDTO> validItems = orderItems.stream()
                    .filter(item -> item.getProduct_variant_id() != null && item.getProduct_variant_id() > 0
                            && item.getQuantity() > 0)
                    .toList();

            if (validItems.isEmpty()) {
                response.setErrorCode(-1);
                response.setErrorMessage("No valid order items found after filtering");
                return response;
            }

            // Thay vì gọi stored procedure với TVP, chúng ta sẽ tạo một câu SQL
            // tương tự như script gốc mà bạn đã cung cấp
            StringBuilder sql = new StringBuilder();

            // Phần khai báo các biến
            sql.append("DECLARE @CustomerID INT = ").append(customerId).append("; ");
            sql.append("DECLARE @PaymentMethodID INT = ").append(paymentId).append("; ");

            // Khai báo biến kiểu bảng và thêm dữ liệu chi tiết sản phẩm
            sql.append("DECLARE @OrderItems AS dbo.OrderDetailType; ");

            // Thêm các mục vào biến kiểu bảng
            for (OrderItemDTO item : validItems) {
                sql.append("INSERT INTO @OrderItems (product_variant_id, quantity) VALUES (")
                        .append(item.getProduct_variant_id()).append(", ")
                        .append(item.getQuantity()).append("); ");
            }

            // Khai báo biến output
            sql.append("DECLARE @OrderID CHAR(10); ");
            sql.append("DECLARE @ErrCode INT; ");
            sql.append("DECLARE @ErrMsg NVARCHAR(500); ");

            // Gọi Stored Procedure
            sql.append("EXEC dbo.usp_CreateOrder ")
                    .append("@customer_id = @CustomerID, ")
                    .append("@payment_id = @PaymentMethodID, ")
                    .append("@OrderItems = @OrderItems, ")
                    .append("@new_order_id = @OrderID OUTPUT, ")
                    .append("@ErrorCode = @ErrCode OUTPUT, ")
                    .append("@ErrorMessage = @ErrMsg OUTPUT; ");

            // Lấy kết quả
            sql.append("SELECT @OrderID AS NewOrderID, @ErrCode AS ErrorCode, @ErrMsg AS ErrorMessage;");

            System.out.println("Executing SQL: " + sql.toString());

            // Thực thi câu lệnh SQL
            jdbcTemplate.query(
                    sql.toString(),
                    (rs) -> {
                        if (rs.next()) {
                            response.setOrderId(rs.getString("NewOrderID"));
                            response.setErrorCode(rs.getInt("ErrorCode"));
                            response.setErrorMessage(rs.getString("ErrorMessage"));
                        }
                        return null;
                    });

            // Ghi log kết quả
            System.out.println("Stored procedure result:");
            System.out.println("Order ID: " + response.getOrderId());
            System.out.println("Error Code: " + response.getErrorCode());
            System.out.println("Error Message: " + response.getErrorMessage());

        } catch (Exception e) {
            e.printStackTrace();
            response.setErrorCode(-1);
            response.setErrorMessage("Error calling stored procedure: " + e.getMessage());
        }

        return response;
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
