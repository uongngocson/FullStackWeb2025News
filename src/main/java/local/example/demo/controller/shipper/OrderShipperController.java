package local.example.demo.controller.shipper;

import local.example.demo.model.dto.OrderDetailDTO;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.Shipment;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.CodPayment;
import local.example.demo.service.OrderService;
import local.example.demo.service.ShipperService;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.CodPaymentService;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/shipper/orders")
@CrossOrigin(origins = "*")
public class OrderShipperController {

    private final OrderService orderService;
    private final ShipperService shipperService;
    private final EmployeeService employeeService;
    private final CodPaymentService codPaymentService;

    /**
     * API Response wrapper for consistent response structure
     */
    public static class ApiResponse<T> {
        private boolean success;
        private String message;
        private T data;
        private Map<String, Object> meta;

        public ApiResponse() {
            this.meta = new HashMap<>();
        }

        public ApiResponse(boolean success, String message, T data) {
            this();
            this.success = success;
            this.message = message;
            this.data = data;
        }

        // Getters and setters
        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public T getData() { return data; }
        public void setData(T data) { this.data = data; }
        public Map<String, Object> getMeta() { return meta; }
        public void setMeta(Map<String, Object> meta) { this.meta = meta; }
        
        public ApiResponse<T> addMeta(String key, Object value) {
            this.meta.put(key, value);
            return this;
        }
    }

    /**
     * Order Summary DTO for list view
     */
    public static class OrderSummaryDTO {
        private String orderId;
        private String orderDate;
        private String totalAmount;
        private String orderStatus;
        private boolean paymentStatus;
        private CustomerInfo customer;
        private String shippingAddress;

        // Constructors, getters and setters
        public OrderSummaryDTO() {}

        public OrderSummaryDTO(Order order) {
            this.orderId = order.getOrderId();
            this.orderDate = order.getOrderDate() != null ? 
                order.getOrderDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")) : null;
            this.totalAmount = order.getTotalAmount() != null ? order.getTotalAmount().toString() : "0";
            this.orderStatus = order.getOrderStatus();
            this.paymentStatus = Boolean.TRUE.equals(order.getPaymentStatus());
            
            if (order.getCustomer() != null) {
                this.customer = new CustomerInfo(
                    order.getCustomer().getCustomerId(),
                    order.getCustomer().getFirstName(),
                    order.getCustomer().getLastName(),
                    order.getCustomer().getEmail(),
                    order.getCustomer().getPhone()
                );
            }
            
            if (order.getShippingAddress() != null) {
                this.shippingAddress = order.getShippingAddress().getFullAddress();
            }
        }

        // Getters and setters
        public String getOrderId() { return orderId; }
        public void setOrderId(String orderId) { this.orderId = orderId; }
        public String getOrderDate() { return orderDate; }
        public void setOrderDate(String orderDate) { this.orderDate = orderDate; }
        public String getTotalAmount() { return totalAmount; }
        public void setTotalAmount(String totalAmount) { this.totalAmount = totalAmount; }
        public String getOrderStatus() { return orderStatus; }
        public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }
        public boolean isPaymentStatus() { return paymentStatus; }
        public void setPaymentStatus(boolean paymentStatus) { this.paymentStatus = paymentStatus; }
        public CustomerInfo getCustomer() { return customer; }
        public void setCustomer(CustomerInfo customer) { this.customer = customer; }
        public String getShippingAddress() { return shippingAddress; }
        public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
    }

    /**
     * Customer Info DTO
     */
    public static class CustomerInfo {
        private Integer customerId;
        private String firstName;
        private String lastName;
        private String email;
        private String phone;

        public CustomerInfo() {}

        public CustomerInfo(Integer customerId, String firstName, String lastName, String email, String phone) {
            this.customerId = customerId;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phone = phone;
        }

        // Getters and setters
        public Integer getCustomerId() { return customerId; }
        public void setCustomerId(Integer customerId) { this.customerId = customerId; }
        public String getFirstName() { return firstName; }
        public void setFirstName(String firstName) { this.firstName = firstName; }
        public String getLastName() { return lastName; }
        public void setLastName(String lastName) { this.lastName = lastName; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
    }

    /**
     * Orders grouped by status DTO
     */
    public static class OrdersByStatusDTO {
        private Map<String, List<OrderSummaryDTO>> ordersByStatus;
        private Map<String, Integer> statusCounts;
        private List<String> possibleStatuses;

        public OrdersByStatusDTO() {
            this.ordersByStatus = new HashMap<>();
            this.statusCounts = new HashMap<>();
            this.possibleStatuses = List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED", "RETURNED");
        }

        // Getters and setters
        public Map<String, List<OrderSummaryDTO>> getOrdersByStatus() { return ordersByStatus; }
        public void setOrdersByStatus(Map<String, List<OrderSummaryDTO>> ordersByStatus) { this.ordersByStatus = ordersByStatus; }
        public Map<String, Integer> getStatusCounts() { return statusCounts; }
        public void setStatusCounts(Map<String, Integer> statusCounts) { this.statusCounts = statusCounts; }
        public List<String> getPossibleStatuses() { return possibleStatuses; }
        public void setPossibleStatuses(List<String> possibleStatuses) { this.possibleStatuses = possibleStatuses; }
    }

    /**
     * Pagination metadata DTO
     */
    public static class PaginationMeta {
        private int currentPage;
        private int totalPages;
        private long totalElements;
        private int pageSize;
        private boolean hasNext;
        private boolean hasPrevious;

        public PaginationMeta(Page<?> page) {
            this.currentPage = page.getNumber();
            this.totalPages = page.getTotalPages();
            this.totalElements = page.getTotalElements();
            this.pageSize = page.getSize();
            this.hasNext = page.hasNext();
            this.hasPrevious = page.hasPrevious();
        }

        // Getters and setters
        public int getCurrentPage() { return currentPage; }
        public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
        public int getTotalPages() { return totalPages; }
        public void setTotalPages(int totalPages) { this.totalPages = totalPages; }
        public long getTotalElements() { return totalElements; }
        public void setTotalElements(long totalElements) { this.totalElements = totalElements; }
        public int getPageSize() { return pageSize; }
        public void setPageSize(int pageSize) { this.pageSize = pageSize; }
        public boolean isHasNext() { return hasNext; }
        public void setHasNext(boolean hasNext) { this.hasNext = hasNext; }
        public boolean isHasPrevious() { return hasPrevious; }
        public void setHasPrevious(boolean hasPrevious) { this.hasPrevious = hasPrevious; }
    }

    /**
     * Shipment DTO for API responses
     */
    public static class ShipmentDTO {
        private Integer shipmentId;
        private String orderId;
        private String customerName;
        private String shipmentDate;
        private String status;
        private String paymentMethod;
        private String paymentStatus;
        private BigDecimal totalAmount;
        private String shippingAddress;
        private CodPaymentDTO codPayment;

        public ShipmentDTO() {}

        public ShipmentDTO(Shipment shipment) {
            this.shipmentId = shipment.getShipmentId();
            this.orderId = shipment.getOrder().getOrderId();
            this.shipmentDate = shipment.getAssignedDate() != null ? 
                shipment.getAssignedDate().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDateTime()
                    .format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")) : null;
            this.status = shipment.getStatus();
            this.paymentMethod = shipment.getPaymentMethod();
            this.paymentStatus = shipment.getPaymentStatus();
            this.totalAmount = shipment.getOrder().getTotalAmount();
            
            if (shipment.getOrder().getCustomer() != null) {
                this.customerName = shipment.getOrder().getCustomer().getFirstName() + " " + 
                                 shipment.getOrder().getCustomer().getLastName();
            }
            
            if (shipment.getOrder().getShippingAddress() != null) {
                this.shippingAddress = shipment.getOrder().getShippingAddress().getFullAddress();
            }
        }

        // Getters and setters
        public Integer getShipmentId() { return shipmentId; }
        public void setShipmentId(Integer shipmentId) { this.shipmentId = shipmentId; }
        public String getOrderId() { return orderId; }
        public void setOrderId(String orderId) { this.orderId = orderId; }
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public String getShipmentDate() { return shipmentDate; }
        public void setShipmentDate(String shipmentDate) { this.shipmentDate = shipmentDate; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
        public String getPaymentStatus() { return paymentStatus; }
        public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
        public BigDecimal getTotalAmount() { return totalAmount; }
        public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
        public String getShippingAddress() { return shippingAddress; }
        public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
        public CodPaymentDTO getCodPayment() { return codPayment; }
        public void setCodPayment(CodPaymentDTO codPayment) { this.codPayment = codPayment; }
    }

    /**
     * COD Payment DTO
     */
    public static class CodPaymentDTO {
        private Integer codPaymentId;
        private BigDecimal amount;
        private String collectedDate;
        private String submittedStatus;
        private String submittedDate;
        private String submittedMethod;

        public CodPaymentDTO() {}

        public CodPaymentDTO(CodPayment codPayment) {
            this.codPaymentId = codPayment.getCodPaymentId();
            this.amount = codPayment.getAmount();
            this.collectedDate = codPayment.getCollectedDate() != null ? 
                codPayment.getCollectedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
            this.submittedStatus = codPayment.getSubmittedStatus();
            this.submittedDate = codPayment.getSubmittedDate() != null ? 
                codPayment.getSubmittedDate().atStartOfDay().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")) : null;
            this.submittedMethod = null;
        }

        // Getters and setters
        public Integer getCodPaymentId() { return codPaymentId; }
        public void setCodPaymentId(Integer codPaymentId) { this.codPaymentId = codPaymentId; }
        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
        public String getCollectedDate() { return collectedDate; }
        public void setCollectedDate(String collectedDate) { this.collectedDate = collectedDate; }
        public String getSubmittedStatus() { return submittedStatus; }
        public void setSubmittedStatus(String submittedStatus) { this.submittedStatus = submittedStatus; }
        public String getSubmittedDate() { return submittedDate; }
        public void setSubmittedDate(String submittedDate) { this.submittedDate = submittedDate; }
        public String getSubmittedMethod() { return submittedMethod; }
        public void setSubmittedMethod(String submittedMethod) { this.submittedMethod = submittedMethod; }
    }

    /**
     * GET /api/shipper/orders
     * Get all orders grouped by status (equivalent to all-orders.jsp data)
     */
    @GetMapping
    public ResponseEntity<ApiResponse<OrdersByStatusDTO>> getAllOrders() {
        try {
            List<Order> orders = orderService.getAllOrders();
            
            // Convert to DTOs
            List<OrderSummaryDTO> orderDTOs = orders.stream()
                    .map(OrderSummaryDTO::new)
                    .collect(Collectors.toList());
            
            // Group by status
            Map<String, List<OrderSummaryDTO>> ordersByStatus = orderDTOs.stream()
                    .collect(Collectors.groupingBy(OrderSummaryDTO::getOrderStatus));
            
            // Calculate counts
            Map<String, Integer> statusCounts = new HashMap<>();
            List<String> possibleStatuses = List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED", "RETURNED");
            
            for (String status : possibleStatuses) {
                int count = ordersByStatus.getOrDefault(status, List.of()).size();
                statusCounts.put(status, count);
            }
            
            OrdersByStatusDTO responseData = new OrdersByStatusDTO();
            responseData.setOrdersByStatus(ordersByStatus);
            responseData.setStatusCounts(statusCounts);
            
            ApiResponse<OrdersByStatusDTO> response = new ApiResponse<>(true, "Orders retrieved successfully", responseData);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("totalOrders", orders.size());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<OrdersByStatusDTO> errorResponse = new ApiResponse<>(false, "Failed to retrieve orders: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/orders/paginated
     * Get orders with pagination and filtering
     */
    @GetMapping("/paginated")
    public ResponseEntity<ApiResponse<List<OrderSummaryDTO>>> getOrdersPaginated(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "orderDate") String sortBy,
            @RequestParam(defaultValue = "DESC") String sortDirection,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String customerName) {
        
        try {
            Sort.Direction direction = sortDirection.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC;
            Sort sort = Sort.by(direction, sortBy);
            Pageable pageable = PageRequest.of(page, size, sort);
            
            // Here you would implement filtering logic in your service
            // For now, we'll get all orders and filter manually for demonstration
            List<Order> allOrders = orderService.getAllOrders();
            
            // Apply filters
            List<Order> filteredOrders = allOrders.stream()
                    .filter(order -> status == null || order.getOrderStatus().equalsIgnoreCase(status))
                    .filter(order -> customerName == null || 
                            (order.getCustomer() != null && 
                             (order.getCustomer().getFirstName() + " " + order.getCustomer().getLastName())
                                     .toLowerCase().contains(customerName.toLowerCase())))
                    .collect(Collectors.toList());
            
            // Manual pagination (in real implementation, this should be done at database level)
            int start = page * size;
            int end = Math.min(start + size, filteredOrders.size());
            List<Order> paginatedOrders = filteredOrders.subList(start, end);
            
            List<OrderSummaryDTO> orderDTOs = paginatedOrders.stream()
                    .map(OrderSummaryDTO::new)
                    .collect(Collectors.toList());
            
            ApiResponse<List<OrderSummaryDTO>> response = new ApiResponse<>(true, "Orders retrieved successfully", orderDTOs);
            
            // Add pagination metadata
            response.addMeta("pagination", Map.of(
                "currentPage", page,
                "totalPages", (int) Math.ceil((double) filteredOrders.size() / size),
                "totalElements", filteredOrders.size(),
                "pageSize", size,
                "hasNext", end < filteredOrders.size(),
                "hasPrevious", page > 0
            ));
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<List<OrderSummaryDTO>> errorResponse = new ApiResponse<>(false, "Failed to retrieve orders: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/orders/{orderId}
     * Get order details by ID (equivalent to detail-order.jsp data)
     */
    @GetMapping("/{orderId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getOrderDetails(@PathVariable String orderId) {
        try {
            List<OrderDetailDTO> orderDetails = orderService.getOrderDetails(orderId);
            
            if (orderDetails == null || orderDetails.isEmpty()) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Order not found or no details available", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
            
            OrderDetailDTO firstDetail = orderDetails.get(0);
            
            // Prepare response data structure matching the JSP view
            Map<String, Object> responseData = new HashMap<>();
            
            // Order information
            Map<String, Object> orderInfo = new HashMap<>();
            orderInfo.put("orderId", firstDetail.getOrderId());
            orderInfo.put("orderDate", firstDetail.getOrderDate() != null ? 
                firstDetail.getOrderDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")) : null);
            orderInfo.put("totalAmount", firstDetail.getTotalAmount() != null ? firstDetail.getTotalAmount().toString() : "0");
            orderInfo.put("orderStatus", firstDetail.getOrderStatus());
            orderInfo.put("paymentStatus", firstDetail.getPaymentStatus());
            orderInfo.put("shippingAddress", firstDetail.getShippingAddress());
            
            // Customer information
            Map<String, Object> customerInfo = new HashMap<>();
            customerInfo.put("customerId", firstDetail.getCustomerId());
            customerInfo.put("firstName", firstDetail.getFirstName());
            customerInfo.put("lastName", firstDetail.getLastName());
            customerInfo.put("email", firstDetail.getEmail());
            
            // Order items
            List<Map<String, Object>> orderItems = orderDetails.stream()
                    .map(detail -> {
                        Map<String, Object> item = new HashMap<>();
                        item.put("orderDetailId", detail.getOrderDetailId());
                        item.put("productId", detail.getProductId());
                        item.put("productName", detail.getProductName());
                        item.put("description", detail.getDescription());
                        item.put("imageUrl", detail.getImageUrl());
                        item.put("quantity", detail.getQuantity());
                        item.put("orderDetailPrice", detail.getOrderDetailPrice() != null ? detail.getOrderDetailPrice().toString() : "0");
                        item.put("subtotal", detail.getSubtotal() != null ? detail.getSubtotal().toString() : "0");
                        return item;
                    })
                    .collect(Collectors.toList());
            
            responseData.put("order", orderInfo);
            responseData.put("customer", customerInfo);
            responseData.put("orderItems", orderItems);
            
            ApiResponse<Map<String, Object>> response = new ApiResponse<>(true, "Order details retrieved successfully", responseData);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("itemCount", orderItems.size());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(false, "Failed to retrieve order details: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/orders/status/{status}
     * Get orders by specific status
     */
    @GetMapping("/status/{status}")
    public ResponseEntity<ApiResponse<List<OrderSummaryDTO>>> getOrdersByStatus(@PathVariable String status) {
        try {
            List<Order> orders = orderService.getAllOrders();
            
            List<OrderSummaryDTO> filteredOrders = orders.stream()
                    .filter(order -> order.getOrderStatus().equalsIgnoreCase(status))
                    .map(OrderSummaryDTO::new)
                    .collect(Collectors.toList());
            
            ApiResponse<List<OrderSummaryDTO>> response = new ApiResponse<>(true, 
                "Orders with status '" + status + "' retrieved successfully", filteredOrders);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("status", status.toUpperCase());
            response.addMeta("count", filteredOrders.size());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<List<OrderSummaryDTO>> errorResponse = new ApiResponse<>(false, 
                "Failed to retrieve orders by status: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * PUT /api/shipper/orders/{orderId}/status
     * Update order status and payment status
     */
    @PutMapping("/{orderId}/status")
    public ResponseEntity<ApiResponse<Map<String, Object>>> updateOrderStatus(
            @PathVariable String orderId,
            @RequestBody Map<String, Object> updateRequest) {
        
        try {
            String orderStatus = (String) updateRequest.get("orderStatus");
            Boolean paymentStatus = null;
            
            // Handle paymentStatus conversion from various input types
            Object paymentStatusObj = updateRequest.get("paymentStatus");
            if (paymentStatusObj != null) {
                if (paymentStatusObj instanceof Boolean) {
                    paymentStatus = (Boolean) paymentStatusObj;
                } else if (paymentStatusObj instanceof Integer) {
                    paymentStatus = ((Integer) paymentStatusObj) == 1;
                } else if (paymentStatusObj instanceof String) {
                    paymentStatus = "true".equalsIgnoreCase((String) paymentStatusObj) || "1".equals(paymentStatusObj);
                }
            }
            
            if (orderStatus == null) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Order status is required", null);
                return ResponseEntity.badRequest().body(response);
            }
            
            Order existingOrder = orderService.getOrderById(orderId);
            if (existingOrder == null) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Order not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
            
            orderService.updateOrderStatusAndPayment(orderId, orderStatus, paymentStatus);
            
            // Return updated order information
            Order updatedOrder = orderService.getOrderById(orderId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("orderId", updatedOrder.getOrderId());
            responseData.put("orderStatus", updatedOrder.getOrderStatus());
            responseData.put("paymentStatus", updatedOrder.getPaymentStatus());
            responseData.put("updatedAt", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            ApiResponse<Map<String, Object>> response = new ApiResponse<>(true, "Order updated successfully", responseData);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(false, "Failed to update order: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/orders/statistics
     * Get order statistics summary
     */
    @GetMapping("/statistics")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getOrderStatistics() {
        try {
            List<Order> orders = orderService.getAllOrders();
            
            Map<String, Long> statusCounts = orders.stream()
                    .collect(Collectors.groupingBy(Order::getOrderStatus, Collectors.counting()));
            
            long totalOrders = orders.size();
            long paidOrders = orders.stream()
                    .filter(order -> Boolean.TRUE.equals(order.getPaymentStatus()))
                    .count();
            long unpaidOrders = totalOrders - paidOrders;
            
            Map<String, Object> statistics = new HashMap<>();
            statistics.put("totalOrders", totalOrders);
            statistics.put("statusCounts", statusCounts);
            statistics.put("paidOrders", paidOrders);
            statistics.put("unpaidOrders", unpaidOrders);
            statistics.put("possibleStatuses", List.of("PENDING", "CONFIRMED", "SHIPPING", "COMPLETED", "CANCELLED", "RETURNED"));
            
            ApiResponse<Map<String, Object>> response = new ApiResponse<>(true, "Order statistics retrieved successfully", statistics);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(false, "Failed to retrieve order statistics: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/orders/confirmed
     * Get only CONFIRMED orders for shipper (ready for delivery)
     */
    @GetMapping("/confirmed")
    public ResponseEntity<ApiResponse<List<OrderSummaryDTO>>> getConfirmedOrders(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "orderDate") String sortBy,
            @RequestParam(defaultValue = "ASC") String sortDirection) {
        
        try {
            List<Order> allOrders = orderService.getAllOrders();
            
            // Filter only CONFIRMED orders
            List<Order> confirmedOrders = allOrders.stream()
                    .filter(order -> "CONFIRMED".equalsIgnoreCase(order.getOrderStatus()))
                    .collect(Collectors.toList());
            
            // Apply sorting
            if ("orderDate".equals(sortBy)) {
                if ("DESC".equalsIgnoreCase(sortDirection)) {
                    confirmedOrders.sort((a, b) -> b.getOrderDate().compareTo(a.getOrderDate()));
                } else {
                    confirmedOrders.sort((a, b) -> a.getOrderDate().compareTo(b.getOrderDate()));
                }
            } else if ("totalAmount".equals(sortBy)) {
                if ("DESC".equalsIgnoreCase(sortDirection)) {
                    confirmedOrders.sort((a, b) -> b.getTotalAmount().compareTo(a.getTotalAmount()));
                } else {
                    confirmedOrders.sort((a, b) -> a.getTotalAmount().compareTo(b.getTotalAmount()));
                }
            }
            
            // Manual pagination
            int start = page * size;
            int end = Math.min(start + size, confirmedOrders.size());
            
            if (start >= confirmedOrders.size()) {
                // Return empty list if page is beyond available data
                ApiResponse<List<OrderSummaryDTO>> response = new ApiResponse<>(true, "No more confirmed orders available", List.of());
                response.addMeta("pagination", Map.of(
                    "currentPage", page,
                    "totalPages", (int) Math.ceil((double) confirmedOrders.size() / size),
                    "totalElements", confirmedOrders.size(),
                    "pageSize", size,
                    "hasNext", false,
                    "hasPrevious", page > 0
                ));
                response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
                response.addMeta("status", "CONFIRMED");
                return ResponseEntity.ok(response);
            }
            
            List<Order> paginatedOrders = confirmedOrders.subList(start, end);
            
            // Convert to DTOs
            List<OrderSummaryDTO> orderDTOs = paginatedOrders.stream()
                    .map(OrderSummaryDTO::new)
                    .collect(Collectors.toList());
            
            ApiResponse<List<OrderSummaryDTO>> response = new ApiResponse<>(true, 
                "Confirmed orders retrieved successfully", orderDTOs);
            
            // Add pagination metadata
            response.addMeta("pagination", Map.of(
                "currentPage", page,
                "totalPages", (int) Math.ceil((double) confirmedOrders.size() / size),
                "totalElements", confirmedOrders.size(),
                "pageSize", size,
                "hasNext", end < confirmedOrders.size(),
                "hasPrevious", page > 0
            ));
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("status", "CONFIRMED");
            response.addMeta("totalConfirmedOrders", confirmedOrders.size());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<List<OrderSummaryDTO>> errorResponse = new ApiResponse<>(false, 
                "Failed to retrieve confirmed orders: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * POST /api/shipper/orders/{orderId}/create-shipment
     * Create a new shipment for confirmed order (equivalent to createShipment)
     */
    @PostMapping("/{orderId}/create-shipment")
    public ResponseEntity<ApiResponse<ShipmentDTO>> createShipment(
            @PathVariable String orderId,
            @RequestParam Integer shipperId) {
        
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Shipper not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            Shipment shipment = shipperService.createShipment(orderId, shipper);
            if (shipment == null) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Order not found or cannot create shipment", null);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
            }

            ShipmentDTO shipmentDTO = new ShipmentDTO(shipment);
            
            ApiResponse<ShipmentDTO> response = new ApiResponse<>(true, "Shipment created successfully", shipmentDTO);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);
            
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
            
        } catch (Exception e) {
            ApiResponse<ShipmentDTO> errorResponse = new ApiResponse<>(false, "Failed to create shipment: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/shipments
     * Get all shipments for a specific shipper (equivalent to shipment list.jsp)
     */
    @GetMapping("/shipments")
    public ResponseEntity<ApiResponse<List<ShipmentDTO>>> getShipmentsByShipper(@RequestParam Integer shipperId) {
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                ApiResponse<List<ShipmentDTO>> response = new ApiResponse<>(false, "Shipper not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            List<Shipment> shipments = shipperService.getShipmentsByShipper(shipper);
            List<ShipmentDTO> shipmentDTOs = shipments.stream()
                    .map(shipment -> {
                        ShipmentDTO dto = new ShipmentDTO(shipment);
                        
                        // Add COD payment info if applicable
                        if ("COD".equals(shipment.getPaymentMethod())) {
                            Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentByShipment(shipment);
                            if (codPaymentOpt.isPresent()) {
                                dto.setCodPayment(new CodPaymentDTO(codPaymentOpt.get()));
                            }
                        }
                        
                        return dto;
                    })
                    .collect(Collectors.toList());

            ApiResponse<List<ShipmentDTO>> response = new ApiResponse<>(true, "Shipments retrieved successfully", shipmentDTOs);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);
            response.addMeta("totalShipments", shipmentDTOs.size());
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<List<ShipmentDTO>> errorResponse = new ApiResponse<>(false, "Failed to retrieve shipments: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/shipments/{shipmentId}
     * Get shipment details by ID (equivalent to shipment edit form data)
     */
    @GetMapping("/shipments/{shipmentId}")
    public ResponseEntity<ApiResponse<ShipmentDTO>> getShipmentById(@PathVariable Integer shipmentId) {
        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (!shipmentOpt.isPresent()) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Shipment not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            Shipment shipment = shipmentOpt.get();
            ShipmentDTO shipmentDTO = new ShipmentDTO(shipment);
            
            // Add COD payment info if applicable
            if ("COD".equals(shipment.getPaymentMethod())) {
                Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentByShipment(shipment);
                if (codPaymentOpt.isPresent()) {
                    shipmentDTO.setCodPayment(new CodPaymentDTO(codPaymentOpt.get()));
                }
            }

            ApiResponse<ShipmentDTO> response = new ApiResponse<>(true, "Shipment details retrieved successfully", shipmentDTO);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<ShipmentDTO> errorResponse = new ApiResponse<>(false, "Failed to retrieve shipment details: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * PUT /api/shipper/shipments/{shipmentId}/status
     * Update shipment status and payment status (equivalent to updateShipment)
     */
    @PutMapping("/shipments/{shipmentId}/status")
    public ResponseEntity<ApiResponse<ShipmentDTO>> updateShipmentStatus(
            @PathVariable Integer shipmentId,
            @RequestBody Map<String, Object> updateRequest,
            @RequestParam Integer shipperId) {
        
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Shipper not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (!shipmentOpt.isPresent()) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Shipment not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            Shipment shipment = shipmentOpt.get();
            Order order = shipment.getOrder();
            
            String status = (String) updateRequest.get("status");
            String paymentStatus = (String) updateRequest.get("paymentStatus");

            if (status == null || status.trim().isEmpty()) {
                ApiResponse<ShipmentDTO> response = new ApiResponse<>(false, "Status is required", null);
                return ResponseEntity.badRequest().body(response);
            }

            // Update shipment status
            shipment.setStatus(status);

            // Update payment status if provided
            if (paymentStatus != null && !paymentStatus.trim().isEmpty()) {
                shipment.setPaymentStatus(paymentStatus);
            }

            // Handle COD payment when shipment is completed
            if ("COMPLETED".equals(status) && "COD".equals(shipment.getPaymentMethod())) {
                if (!codPaymentService.codPaymentExistsForShipment(shipment)) {
                    BigDecimal codAmount = order.getTotalAmount();
                    codPaymentService.createCodPayment(shipment, shipper, codAmount);
                }
            }

            // Update order status based on shipment status
            switch (status) {
                case "COMPLETED":
                    order.setOrderStatus("COMPLETED");
                    break;
                case "RETURNED":
                    order.setOrderStatus("RETURNED");
                    break;
                case "SHIPPING":
                    order.setOrderStatus("SHIPPING");
                    break;
            }

            // Save order and shipment
            shipperService.saveOrder(order);
            shipperService.updateShipment(shipment);

            // Prepare response with updated shipment data
            ShipmentDTO shipmentDTO = new ShipmentDTO(shipment);
            
            // Add COD payment info if applicable
            if ("COD".equals(shipment.getPaymentMethod())) {
                Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentByShipment(shipment);
                if (codPaymentOpt.isPresent()) {
                    shipmentDTO.setCodPayment(new CodPaymentDTO(codPaymentOpt.get()));
                }
            }

            ApiResponse<ShipmentDTO> response = new ApiResponse<>(true, "Shipment status updated successfully", shipmentDTO);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("updatedStatus", status);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<ShipmentDTO> errorResponse = new ApiResponse<>(false, "Failed to update shipment status: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * DELETE /api/shipper/shipments/{shipmentId}
     * Delete shipment and reset order status to CONFIRMED
     */
    @DeleteMapping("/shipments/{shipmentId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> deleteShipment(@PathVariable Integer shipmentId) {
        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (!shipmentOpt.isPresent()) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Shipment not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            Shipment shipment = shipmentOpt.get();
            Order order = shipment.getOrder();
            String orderId = order.getOrderId();

            // Reset order status to CONFIRMED
            order.setOrderStatus("CONFIRMED");
            shipperService.saveOrder(order);

            // Delete shipment
            shipperService.deleteShipment(shipmentId);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("deletedShipmentId", shipmentId);
            responseData.put("orderId", orderId);
            responseData.put("orderStatus", "CONFIRMED");

            ApiResponse<Map<String, Object>> response = new ApiResponse<>(true, "Shipment deleted successfully and order reset to CONFIRMED", responseData);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(false, "Failed to delete shipment: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * POST /api/shipper/cod/{codPaymentId}/submit
     * Submit COD payment (equivalent to submitCodPayment)
     */
    @PostMapping("/cod/{codPaymentId}/submit")
    public ResponseEntity<ApiResponse<CodPaymentDTO>> submitCodPayment(
            @PathVariable Integer codPaymentId,
            @RequestBody Map<String, String> paymentRequest) {
        
        try {
            String paymentMethod = paymentRequest.get("paymentMethod");
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                ApiResponse<CodPaymentDTO> response = new ApiResponse<>(false, "Payment method is required", null);
                return ResponseEntity.badRequest().body(response);
            }

            codPaymentService.submitCodPayment(codPaymentId, paymentMethod);
            
            Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentById(codPaymentId);
            if (codPaymentOpt.isPresent()) {
                CodPaymentDTO codPaymentDTO = new CodPaymentDTO(codPaymentOpt.get());
                
                ApiResponse<CodPaymentDTO> response = new ApiResponse<>(true, "COD payment submitted successfully", codPaymentDTO);
                response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
                response.addMeta("paymentMethod", paymentMethod);
                
                return ResponseEntity.ok(response);
            } else {
                ApiResponse<CodPaymentDTO> response = new ApiResponse<>(false, "COD payment not found after submission", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }
            
        } catch (Exception e) {
            ApiResponse<CodPaymentDTO> errorResponse = new ApiResponse<>(false, "Failed to submit COD payment: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/shipper/{shipperId}/cod-payments
     * Get COD payments by shipper with optional filters (equivalent to statusshipping.jsp)
     */
    @GetMapping("/{shipperId}/cod-payments")
    public ResponseEntity<ApiResponse<List<CodPaymentDTO>>> getCodPaymentsByShipper(
            @PathVariable Integer shipperId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String dateFrom,
            @RequestParam(required = false) String dateTo) {
        
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                ApiResponse<List<CodPaymentDTO>> response = new ApiResponse<>(false, "Shipper not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            List<CodPayment> codPayments = codPaymentService.getCodPaymentsByShipper(shipper);

            // Apply status filter
            if (status != null && !status.trim().isEmpty()) {
                codPayments = codPayments.stream()
                        .filter(cod -> cod.getSubmittedStatus().equals(status))
                        .collect(Collectors.toList());
            }

            // Apply date filters
            if (dateFrom != null && !dateFrom.trim().isEmpty()) {
                java.time.LocalDate fromDate = java.time.LocalDate.parse(dateFrom);
                codPayments = codPayments.stream()
                        .filter(cod -> !cod.getCollectedDate().isBefore(fromDate))
                        .collect(Collectors.toList());
            }

            if (dateTo != null && !dateTo.trim().isEmpty()) {
                java.time.LocalDate toDate = java.time.LocalDate.parse(dateTo);
                codPayments = codPayments.stream()
                        .filter(cod -> !cod.getCollectedDate().isAfter(toDate))
                        .collect(Collectors.toList());
            }

            // Sort by collection date (newest first)
            codPayments.sort((a, b) -> b.getCollectedDate().compareTo(a.getCollectedDate()));

            List<CodPaymentDTO> codPaymentDTOs = codPayments.stream()
                    .map(CodPaymentDTO::new)
                    .collect(Collectors.toList());

            ApiResponse<List<CodPaymentDTO>> response = new ApiResponse<>(true, "COD payments retrieved successfully", codPaymentDTOs);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);
            response.addMeta("totalCodPayments", codPaymentDTOs.size());
            response.addMeta("appliedFilters", Map.of(
                "status", status != null ? status : "all",
                "dateFrom", dateFrom != null ? dateFrom : "none",
                "dateTo", dateTo != null ? dateTo : "none"
            ));
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<List<CodPaymentDTO>> errorResponse = new ApiResponse<>(false, "Failed to retrieve COD payments: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * POST /api/shipper/{shipperId}/cod-payments/submit-all
     * Submit all pending COD payments for a shipper (equivalent to submitAllCodPayments)
     */
    @PostMapping("/{shipperId}/cod-payments/submit-all")
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitAllCodPayments(
            @PathVariable Integer shipperId,
            @RequestBody Map<String, String> paymentRequest) {
        
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Shipper not found", null);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
            }

            String paymentMethod = paymentRequest.get("paymentMethod");
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "Payment method is required", null);
                return ResponseEntity.badRequest().body(response);
            }

            List<CodPayment> pendingPayments = codPaymentService.getPendingCodPaymentsByShipper(shipper);

            if (pendingPayments.isEmpty()) {
                ApiResponse<Map<String, Object>> response = new ApiResponse<>(false, "No pending COD payments found", null);
                return ResponseEntity.ok(response);
            }

            int submittedCount = 0;
            BigDecimal totalAmount = BigDecimal.ZERO;

            for (CodPayment codPayment : pendingPayments) {
                try {
                    codPaymentService.submitCodPayment(codPayment.getCodPaymentId(), paymentMethod);
                    submittedCount++;
                    totalAmount = totalAmount.add(codPayment.getAmount());
                } catch (Exception e) {
                    // Log error but continue with other payments
                    System.out.println("Error submitting COD payment " + codPayment.getCodPaymentId() + ": " + e.getMessage());
                }
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("submittedCount", submittedCount);
            responseData.put("totalAmount", totalAmount);
            responseData.put("paymentMethod", paymentMethod);
            responseData.put("totalPendingPayments", pendingPayments.size());

            String message = String.format("Successfully submitted %d out of %d COD payments with total amount %s", 
                submittedCount, pendingPayments.size(), totalAmount.toString());

            ApiResponse<Map<String, Object>> response = new ApiResponse<>(true, message, responseData);
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(false, "Failed to submit all COD payments: " + e.getMessage(), null);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
}
