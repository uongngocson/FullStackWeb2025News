package local.example.demo.service;

import local.example.demo.exception.OrderInUseException;
import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.dto.OrderItemDTO;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.repository.OrderDetailRepository;
import local.example.demo.repository.OrderRepository;
import local.example.demo.repository.ReturnRepository;
import local.example.demo.repository.ShipmentRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Types;
import java.time.LocalDateTime;
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
    private final ReturnRepository returnRepository;
    private final ShipmentRepository shipmentRepository;

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

            // Cập nhật các trường của existingOrder từ order (đối tượng từ form)
            existingOrder.setOrderDate(order.getOrderDate());
            existingOrder.setTotalAmount(order.getTotalAmount());
            existingOrder.setOrderStatus(order.getOrderStatus());
            existingOrder.setShippingAddress(order.getShippingAddress());
            existingOrder.setPayment(order.getPayment());
            existingOrder.setCustomer(order.getCustomer());
            // Thêm các trường khác nếu có

            orderRepository.save(existingOrder); // Lưu đối tượng đã được cập nhật
        }
    }

    public void deleteOrder(String orderId) {
        if (returnRepository.existsByOrder_OrderId(orderId)) {
            throw new OrderInUseException("Cannot delete order with associated returns");
        }
        if (shipmentRepository.existsByOrder_OrderId(orderId)) {
            throw new OrderInUseException("Cannot delete order with associated shipments");
        }
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

    public List<Order> findOrdersByCustomer(Customer customer) {
        List<Order> orders = orderRepository.findByCustomerId(customer.getCustomerId());
        System.out.println("Customer ID: " + customer.getCustomerId());
        System.out.println("Orders found: " + (orders != null ? orders.size() : 0));
        if (orders != null) {
            for (Order order : orders) {
                System.out.println("Order ID: " + order.getOrderId() + ", Status: " + order.getOrderStatus());
            }
        }
        return orders;
    }

    @Transactional
    public void cancelOrder(String orderId, Customer customer) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Đơn hàng không tồn tại"));
        if (!order.getCustomer().getCustomerId().equals(customer.getCustomerId())) {
            throw new IllegalArgumentException("Bạn không có quyền hủy đơn hàng này");
        }
        if (!order.getOrderStatus().equals("Pending")) {
            throw new IllegalArgumentException("Chỉ có thể hủy đơn hàng ở trạng thái Pending");
        }
        order.setOrderStatus("Cancel"); // Cập nhật trạng thái thành "Cancel"
        orderRepository.save(order);
    }

    public List<OrderDetailDTO> getOrderDetails(String orderId) {
        String sql = """
                    SELECT
                        o.order_id,
                        o.order_date,
                        o.total_amount,
                        o.order_status,
                        o.payment_status,
                        c.customer_id,
                        c.first_name,
                        c.last_name,
                        c.email,
                        od.order_detail_id,
                        od.product_variant_id,
                        p.product_id,
                        p.product_name,
                        p.description,
                        p.image_url,
                        p.rating,
                        p.price AS product_price,
                        od.quantity,
                        od.price AS order_detail_price,
                        (od.quantity * od.price) AS subtotal,
                        -- Lấy thông tin địa chỉ giao hàng từ bảng Addresses, sử dụng các cột có sẵn
                        CONCAT(a.street, ', ', a.ward, ', ', a.district, ', ', a.city, ', ', a.province, ', ', a.country) AS shipping_address
                    FROM
                        Orders o
                        INNER JOIN Customers c ON o.customer_id = c.customer_id
                        INNER JOIN order_details od ON o.order_id = od.order_id
                        LEFT JOIN Products p ON od.product_variant_id = p.product_id
                        LEFT JOIN Addresses a ON o.shipping_address_id = a.address_id
                    WHERE
                        o.order_id = ?
                """;

        System.out.println("Executing getOrderDetails for orderId: " + orderId);
        System.out.println("SQL Query: " + sql);

        List<OrderDetailDTO> orderDetails = jdbcTemplate.query(sql, new Object[] { orderId }, (rs, rowNum) -> {
            OrderDetailDTO dto = new OrderDetailDTO(
                    rs.getString("order_id"),
                    rs.getObject("order_date", LocalDateTime.class),
                    rs.getBigDecimal("total_amount"),
                    rs.getString("order_status"),
                    rs.getInt("payment_status"),
                    rs.getInt("customer_id"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("email"),
                    rs.getLong("order_detail_id"),
                    rs.getLong("product_variant_id"),
                    rs.getLong("product_id"),
                    rs.getString("product_name"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getInt("rating") != 0 ? rs.getInt("rating") : null,
                    rs.getBigDecimal("product_price"),
                    rs.getInt("quantity"),
                    rs.getBigDecimal("order_detail_price"),
                    rs.getBigDecimal("subtotal"),
                    rs.getString("shipping_address"));
            System.out.println("Fetched OrderDetailDTO: " + dto.getOrderId() + ", Product: " + dto.getProductName());
            return dto;
        });

        System.out.println("Number of order details fetched: " + (orderDetails != null ? orderDetails.size() : 0));
        return orderDetails;
    }
}
