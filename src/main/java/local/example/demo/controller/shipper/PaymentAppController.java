package local.example.demo.controller.shipper;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.model.entity.CodPayment;
import local.example.demo.model.entity.Employee;
import local.example.demo.service.CodPaymentService;
import local.example.demo.service.EmployeeService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/app/payment")
@CrossOrigin(origins = "*")
public class PaymentAppController {
    
    private final CodPaymentService codPaymentService;
    private final EmployeeService employeeService;

    /**
     * API Response wrapper
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
            this.success = success;
            this.message = message;
            this.data = data;
            this.meta = new HashMap<>();
        }

        public ApiResponse<T> addMeta(String key, Object value) {
            if (this.meta == null) {
                this.meta = new HashMap<>();
            }
            this.meta.put(key, value);
            return this;
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
    }

    /**
     * COD Payment DTO for mobile app
     */
    public static class CodPaymentAppDTO {
        private Integer codPaymentId;
        private Integer shipmentId;
        private String orderId;
        private String customerName;
        private BigDecimal amount;
        private String collectedDate;
        private String submittedDate;
        private String submittedStatus;
        private String submittedMethod;
        private ShipmentInfoDTO shipment;

        public CodPaymentAppDTO() {}

        public CodPaymentAppDTO(CodPayment codPayment) {
            this.codPaymentId = codPayment.getCodPaymentId();
            this.amount = codPayment.getAmount();
            this.collectedDate = codPayment.getCollectedDate() != null ? 
                codPayment.getCollectedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
            this.submittedStatus = codPayment.getSubmittedStatus();
            this.submittedDate = codPayment.getSubmittedDate() != null ? 
                codPayment.getSubmittedDate().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : null;
            
            // Determine submitted method from status
            if (codPayment.getSubmittedStatus() != null) {
                switch (codPayment.getSubmittedStatus()) {
                    case "SUBMITTED_CASH":
                        this.submittedMethod = "CASH";
                        break;
                    case "SUBMITTED_MOMO":
                        this.submittedMethod = "MOMO";
                        break;
                    case "SUBMITTED_VNPAY":
                        this.submittedMethod = "VNPAY";
                        break;
                    default:
                        this.submittedMethod = null;
                        break;
                }
            }

            // Set shipment info if available
            if (codPayment.getShipment() != null) {
                this.shipmentId = codPayment.getShipment().getShipmentId();
                this.orderId = codPayment.getShipment().getOrder().getOrderId();
                this.customerName = codPayment.getShipment().getOrder().getCustomer().getFirstName() + 
                    " " + codPayment.getShipment().getOrder().getCustomer().getLastName();
                this.shipment = new ShipmentInfoDTO(codPayment.getShipment());
            }
        }

        // Getters and setters
        public Integer getCodPaymentId() { return codPaymentId; }
        public void setCodPaymentId(Integer codPaymentId) { this.codPaymentId = codPaymentId; }
        public Integer getShipmentId() { return shipmentId; }
        public void setShipmentId(Integer shipmentId) { this.shipmentId = shipmentId; }
        public String getOrderId() { return orderId; }
        public void setOrderId(String orderId) { this.orderId = orderId; }
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
        public String getCollectedDate() { return collectedDate; }
        public void setCollectedDate(String collectedDate) { this.collectedDate = collectedDate; }
        public String getSubmittedDate() { return submittedDate; }
        public void setSubmittedDate(String submittedDate) { this.submittedDate = submittedDate; }
        public String getSubmittedStatus() { return submittedStatus; }
        public void setSubmittedStatus(String submittedStatus) { this.submittedStatus = submittedStatus; }
        public String getSubmittedMethod() { return submittedMethod; }
        public void setSubmittedMethod(String submittedMethod) { this.submittedMethod = submittedMethod; }
        public ShipmentInfoDTO getShipment() { return shipment; }
        public void setShipment(ShipmentInfoDTO shipment) { this.shipment = shipment; }
    }

    /**
     * Shipment Info DTO for mobile app
     */
    public static class ShipmentInfoDTO {
        private Integer shipmentId;
        private String orderId;
        private String customerFirstName;
        private String customerLastName;
        private String customerEmail;
        private String shippingAddress;
        private String status;
        private String paymentMethod;

        public ShipmentInfoDTO() {}

        public ShipmentInfoDTO(local.example.demo.model.entity.Shipment shipment) {
            this.shipmentId = shipment.getShipmentId();
            this.status = shipment.getStatus();
            this.paymentMethod = shipment.getPaymentMethod();
            
            if (shipment.getOrder() != null) {
                this.orderId = shipment.getOrder().getOrderId();
                if (shipment.getOrder().getCustomer() != null) {
                    this.customerFirstName = shipment.getOrder().getCustomer().getFirstName();
                    this.customerLastName = shipment.getOrder().getCustomer().getLastName();
                    this.customerEmail = shipment.getOrder().getCustomer().getEmail();
                }
                if (shipment.getOrder().getShippingAddress() != null) {
                    this.shippingAddress = shipment.getOrder().getShippingAddress().getFullAddress();
                }
            }
        }

        // Getters and setters
        public Integer getShipmentId() { return shipmentId; }
        public void setShipmentId(Integer shipmentId) { this.shipmentId = shipmentId; }
        public String getOrderId() { return orderId; }
        public void setOrderId(String orderId) { this.orderId = orderId; }
        public String getCustomerFirstName() { return customerFirstName; }
        public void setCustomerFirstName(String customerFirstName) { this.customerFirstName = customerFirstName; }
        public String getCustomerLastName() { return customerLastName; }
        public void setCustomerLastName(String customerLastName) { this.customerLastName = customerLastName; }
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        public String getShippingAddress() { return shippingAddress; }
        public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public String getPaymentMethod() { return paymentMethod; }
        public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    }

    /**
     * COD Summary Statistics DTO
     */
    public static class CodSummaryDTO {
        private BigDecimal totalPending;
        private BigDecimal totalSubmitted;
        private BigDecimal totalAmount;
        private Integer pendingCount;
        private Integer submittedCount;
        private Integer totalTransactions;
        private Map<String, BigDecimal> amountByMethod;
        private Map<String, Integer> countByMethod;

        public CodSummaryDTO() {
            this.amountByMethod = new HashMap<>();
            this.countByMethod = new HashMap<>();
        }

        // Getters and setters
        public BigDecimal getTotalPending() { return totalPending; }
        public void setTotalPending(BigDecimal totalPending) { this.totalPending = totalPending; }
        public BigDecimal getTotalSubmitted() { return totalSubmitted; }
        public void setTotalSubmitted(BigDecimal totalSubmitted) { this.totalSubmitted = totalSubmitted; }
        public BigDecimal getTotalAmount() { return totalAmount; }
        public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
        public Integer getPendingCount() { return pendingCount; }
        public void setPendingCount(Integer pendingCount) { this.pendingCount = pendingCount; }
        public Integer getSubmittedCount() { return submittedCount; }
        public void setSubmittedCount(Integer submittedCount) { this.submittedCount = submittedCount; }
        public Integer getTotalTransactions() { return totalTransactions; }
        public void setTotalTransactions(Integer totalTransactions) { this.totalTransactions = totalTransactions; }
        public Map<String, BigDecimal> getAmountByMethod() { return amountByMethod; }
        public void setAmountByMethod(Map<String, BigDecimal> amountByMethod) { this.amountByMethod = amountByMethod; }
        public Map<String, Integer> getCountByMethod() { return countByMethod; }
        public void setCountByMethod(Map<String, Integer> countByMethod) { this.countByMethod = countByMethod; }
    }

    /**
     * Payment Methods DTO
     */
    public static class PaymentMethodsDTO {
        private List<PaymentMethodOptionDTO> availableMethods;
        private boolean canSubmitAll;

        public PaymentMethodsDTO() {
            this.availableMethods = new ArrayList<>();
        }

        public List<PaymentMethodOptionDTO> getAvailableMethods() { return availableMethods; }
        public void setAvailableMethods(List<PaymentMethodOptionDTO> availableMethods) { this.availableMethods = availableMethods; }
        public boolean isCanSubmitAll() { return canSubmitAll; }
        public void setCanSubmitAll(boolean canSubmitAll) { this.canSubmitAll = canSubmitAll; }
    }

    /**
     * Payment Method Option DTO
     */
    public static class PaymentMethodOptionDTO {
        private String method;
        private String displayName;
        private String icon;
        private String description;
        private boolean isOnline;

        public PaymentMethodOptionDTO(String method, String displayName, String icon, String description, boolean isOnline) {
            this.method = method;
            this.displayName = displayName;
            this.icon = icon;
            this.description = description;
            this.isOnline = isOnline;
        }

        // Getters and setters
        public String getMethod() { return method; }
        public void setMethod(String method) { this.method = method; }
        public String getDisplayName() { return displayName; }
        public void setDisplayName(String displayName) { this.displayName = displayName; }
        public String getIcon() { return icon; }
        public void setIcon(String icon) { this.icon = icon; }
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        public boolean isOnline() { return isOnline; }
        public void setOnline(boolean online) { isOnline = online; }
    }

    /**
     * Complete COD Status Response DTO
     */
    public static class CodStatusResponseDTO {
        private List<CodPaymentAppDTO> codPayments;
        private CodSummaryDTO summary;
        private PaymentMethodsDTO paymentMethods;
        private Map<String, Object> filters;

        public CodStatusResponseDTO() {}

        // Getters and setters
        public List<CodPaymentAppDTO> getCodPayments() { return codPayments; }
        public void setCodPayments(List<CodPaymentAppDTO> codPayments) { this.codPayments = codPayments; }
        public CodSummaryDTO getSummary() { return summary; }
        public void setSummary(CodSummaryDTO summary) { this.summary = summary; }
        public PaymentMethodsDTO getPaymentMethods() { return paymentMethods; }
        public void setPaymentMethods(PaymentMethodsDTO paymentMethods) { this.paymentMethods = paymentMethods; }
        public Map<String, Object> getFilters() { return filters; }
        public void setFilters(Map<String, Object> filters) { this.filters = filters; }
    }

    /**
     * GET /api/app/payment/cod-status/{shipperId}
     * Get complete COD payment status data equivalent to statusshipping.jsp
     */
    @GetMapping("/cod-status/{shipperId}")
    public ResponseEntity<ApiResponse<CodStatusResponseDTO>> getCodStatusData(
            @PathVariable Integer shipperId,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String dateFrom,
            @RequestParam(required = false) String dateTo) {

        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>(false, "Shipper not found", null));
            }

            // Get all COD payments for shipper
            List<CodPayment> allCodPayments = codPaymentService.getCodPaymentsByShipper(shipper);
            
            // Apply filters
            List<CodPayment> filteredCodPayments = allCodPayments.stream()
                .filter(cod -> status == null || status.isEmpty() || cod.getSubmittedStatus().equals(status))
                .filter(cod -> {
                    if (dateFrom == null || dateFrom.isEmpty()) return true;
                    try {
                        LocalDate fromDate = LocalDate.parse(dateFrom);
                        return !cod.getCollectedDate().isBefore(fromDate);
                    } catch (Exception e) {
                        return true;
                    }
                })
                .filter(cod -> {
                    if (dateTo == null || dateTo.isEmpty()) return true;
                    try {
                        LocalDate toDate = LocalDate.parse(dateTo);
                        return !cod.getCollectedDate().isAfter(toDate);
                    } catch (Exception e) {
                        return true;
                    }
                })
                .sorted((a, b) -> b.getCollectedDate().compareTo(a.getCollectedDate()))
                .collect(Collectors.toList());

            // Convert to DTOs
            List<CodPaymentAppDTO> codPaymentDTOs = filteredCodPayments.stream()
                .map(CodPaymentAppDTO::new)
                .collect(Collectors.toList());

            // Calculate summary statistics
            CodSummaryDTO summary = calculateSummary(filteredCodPayments);

            // Prepare payment methods
            PaymentMethodsDTO paymentMethods = preparePaymentMethods(
                summary.getPendingCount() > 0
            );

            // Prepare response
            CodStatusResponseDTO responseData = new CodStatusResponseDTO();
            responseData.setCodPayments(codPaymentDTOs);
            responseData.setSummary(summary);
            responseData.setPaymentMethods(paymentMethods);
            
            // Set filter information
            Map<String, Object> filterInfo = new HashMap<>();
            filterInfo.put("status", status);
            filterInfo.put("dateFrom", dateFrom);
            filterInfo.put("dateTo", dateTo);
            filterInfo.put("appliedFilters", (status != null && !status.isEmpty()) || 
                                             (dateFrom != null && !dateFrom.isEmpty()) || 
                                             (dateTo != null && !dateTo.isEmpty()));
            responseData.setFilters(filterInfo);

            ApiResponse<CodStatusResponseDTO> response = new ApiResponse<>(
                true, 
                "COD status data retrieved successfully", 
                responseData
            );
            
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);
            response.addMeta("totalRecords", filteredCodPayments.size());
            response.addMeta("totalAllRecords", allCodPayments.size());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            ApiResponse<CodStatusResponseDTO> errorResponse = new ApiResponse<>(
                false, 
                "Failed to retrieve COD status data: " + e.getMessage(), 
                null
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * POST /api/app/payment/cod/{codPaymentId}/submit
     * Submit individual COD payment
     */
    @PostMapping("/cod/{codPaymentId}/submit")
    public ResponseEntity<ApiResponse<CodPaymentAppDTO>> submitCodPayment(
            @PathVariable Integer codPaymentId,
            @RequestBody Map<String, Object> paymentRequest) {

        try {
            String paymentMethod = (String) paymentRequest.get("paymentMethod");
            String notes = (String) paymentRequest.getOrDefault("notes", "");

            if (paymentMethod == null || paymentMethod.isEmpty()) {
                return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Payment method is required", null));
            }

            codPaymentService.submitCodPayment(codPaymentId, paymentMethod);

            // Get updated COD payment
            Optional<CodPayment> updatedCodPayment = codPaymentService.getCodPaymentById(codPaymentId);
            if (!updatedCodPayment.isPresent()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>(false, "COD payment not found after update", null));
            }

            CodPaymentAppDTO responseData = new CodPaymentAppDTO(updatedCodPayment.get());

            ApiResponse<CodPaymentAppDTO> response = new ApiResponse<>(
                true, 
                String.format("COD payment submitted successfully via %s", getPaymentMethodText(paymentMethod)), 
                responseData
            );
            
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("submittedMethod", paymentMethod);
            response.addMeta("amount", updatedCodPayment.get().getAmount());

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            ApiResponse<CodPaymentAppDTO> errorResponse = new ApiResponse<>(
                false, 
                "Failed to submit COD payment: " + e.getMessage(), 
                null
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * POST /api/app/payment/cod/{shipperId}/submit-all
     * Submit all pending COD payments for shipper
     */
    @PostMapping("/cod/{shipperId}/submit-all")
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitAllCodPayments(
            @PathVariable Integer shipperId,
            @RequestBody Map<String, Object> paymentRequest) {

        try {
            String paymentMethod = (String) paymentRequest.get("paymentMethod");
            String notes = (String) paymentRequest.getOrDefault("notes", "");

            if (paymentMethod == null || paymentMethod.isEmpty()) {
                return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "Payment method is required", null));
            }

            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>(false, "Shipper not found", null));
            }

            List<CodPayment> pendingPayments = codPaymentService.getPendingCodPaymentsByShipper(shipper);

            if (pendingPayments.isEmpty()) {
                return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "No pending COD payments found", null));
            }

            int submittedCount = 0;
            BigDecimal totalAmount = BigDecimal.ZERO;
            List<String> errors = new ArrayList<>();

            for (CodPayment codPayment : pendingPayments) {
                try {
                    codPaymentService.submitCodPayment(codPayment.getCodPaymentId(), paymentMethod);
                    submittedCount++;
                    totalAmount = totalAmount.add(codPayment.getAmount());
                } catch (Exception e) {
                    errors.add("COD " + codPayment.getCodPaymentId() + ": " + e.getMessage());
                }
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("submittedCount", submittedCount);
            responseData.put("totalPendingCount", pendingPayments.size());
            responseData.put("totalAmount", totalAmount);
            responseData.put("paymentMethod", paymentMethod);
            responseData.put("errors", errors);
            responseData.put("successRate", pendingPayments.size() > 0 ? 
                (double) submittedCount / pendingPayments.size() * 100 : 0);

            String message;
            if (submittedCount == pendingPayments.size()) {
                message = String.format("Successfully submitted all %d COD payments totaling %s via %s", 
                    submittedCount, formatCurrency(totalAmount), getPaymentMethodText(paymentMethod));
            } else {
                message = String.format("Submitted %d out of %d COD payments. Total amount: %s via %s", 
                    submittedCount, pendingPayments.size(), formatCurrency(totalAmount), getPaymentMethodText(paymentMethod));
            }

            ApiResponse<Map<String, Object>> response = new ApiResponse<>(
                submittedCount > 0, 
                message, 
                responseData
            );
            
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            ApiResponse<Map<String, Object>> errorResponse = new ApiResponse<>(
                false, 
                "Failed to submit COD payments: " + e.getMessage(), 
                null
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/app/payment/cod/{shipperId}/summary
     * Get COD summary statistics only
     */
    @GetMapping("/cod/{shipperId}/summary")
    public ResponseEntity<ApiResponse<CodSummaryDTO>> getCodSummary(@PathVariable Integer shipperId) {
        try {
            Employee shipper = employeeService.getEmployeeById(shipperId);
            if (shipper == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>(false, "Shipper not found", null));
            }

            List<CodPayment> codPayments = codPaymentService.getCodPaymentsByShipper(shipper);
            CodSummaryDTO summary = calculateSummary(codPayments);

            ApiResponse<CodSummaryDTO> response = new ApiResponse<>(
                true, 
                "COD summary retrieved successfully", 
                summary
            );
            
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            response.addMeta("shipperId", shipperId);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            ApiResponse<CodSummaryDTO> errorResponse = new ApiResponse<>(
                false, 
                "Failed to retrieve COD summary: " + e.getMessage(), 
                null
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    /**
     * GET /api/app/payment/payment-methods
     * Get available payment methods
     */
    @GetMapping("/payment-methods")
    public ResponseEntity<ApiResponse<PaymentMethodsDTO>> getPaymentMethods(
            @RequestParam(defaultValue = "false") boolean hasPendingPayments) {
        
        try {
            PaymentMethodsDTO paymentMethods = preparePaymentMethods(hasPendingPayments);

            ApiResponse<PaymentMethodsDTO> response = new ApiResponse<>(
                true, 
                "Payment methods retrieved successfully", 
                paymentMethods
            );
            
            response.addMeta("timestamp", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            ApiResponse<PaymentMethodsDTO> errorResponse = new ApiResponse<>(
                false, 
                "Failed to retrieve payment methods: " + e.getMessage(), 
                null
            );
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    // Helper methods

    private CodSummaryDTO calculateSummary(List<CodPayment> codPayments) {
        CodSummaryDTO summary = new CodSummaryDTO();
        
        BigDecimal totalPending = BigDecimal.ZERO;
        BigDecimal totalSubmitted = BigDecimal.ZERO;
        int pendingCount = 0;
        int submittedCount = 0;
        
        Map<String, BigDecimal> amountByMethod = new HashMap<>();
        Map<String, Integer> countByMethod = new HashMap<>();
        
        // Initialize method maps
        amountByMethod.put("CASH", BigDecimal.ZERO);
        amountByMethod.put("MOMO", BigDecimal.ZERO);
        amountByMethod.put("VNPAY", BigDecimal.ZERO);
        countByMethod.put("CASH", 0);
        countByMethod.put("MOMO", 0);
        countByMethod.put("VNPAY", 0);

        for (CodPayment codPayment : codPayments) {
            if ("NOT_SUBMITTED".equals(codPayment.getSubmittedStatus())) {
                totalPending = totalPending.add(codPayment.getAmount());
                pendingCount++;
            } else {
                totalSubmitted = totalSubmitted.add(codPayment.getAmount());
                submittedCount++;
                
                // Track by method
                String method = getMethodFromStatus(codPayment.getSubmittedStatus());
                if (method != null) {
                    amountByMethod.put(method, amountByMethod.get(method).add(codPayment.getAmount()));
                    countByMethod.put(method, countByMethod.get(method) + 1);
                }
            }
        }

        summary.setTotalPending(totalPending);
        summary.setTotalSubmitted(totalSubmitted);
        summary.setTotalAmount(totalPending.add(totalSubmitted));
        summary.setPendingCount(pendingCount);
        summary.setSubmittedCount(submittedCount);
        summary.setTotalTransactions(codPayments.size());
        summary.setAmountByMethod(amountByMethod);
        summary.setCountByMethod(countByMethod);

        return summary;
    }

    private PaymentMethodsDTO preparePaymentMethods(boolean hasPendingPayments) {
        PaymentMethodsDTO paymentMethods = new PaymentMethodsDTO();
        
        List<PaymentMethodOptionDTO> methods = new ArrayList<>();
        methods.add(new PaymentMethodOptionDTO(
            "CASH", 
            "Tiền Mặt", 
            "banknote.fill", 
            "Nộp trực tiếp tại văn phòng", 
            false
        ));
        methods.add(new PaymentMethodOptionDTO(
            "MOMO", 
            "MoMo", 
            "cc-apple-pay", 
            "Thanh toán qua ví MoMo", 
            true
        ));
        methods.add(new PaymentMethodOptionDTO(
            "VNPAY", 
            "VNPay", 
            "credit-card", 
            "Thanh toán qua VNPay", 
            true
        ));
        
        paymentMethods.setAvailableMethods(methods);
        paymentMethods.setCanSubmitAll(hasPendingPayments);
        
        return paymentMethods;
    }

    private String getMethodFromStatus(String submittedStatus) {
        if (submittedStatus == null) return null;
        switch (submittedStatus) {
            case "SUBMITTED_CASH": return "CASH";
            case "SUBMITTED_MOMO": return "MOMO";
            case "SUBMITTED_VNPAY": return "VNPAY";
            default: return null;
        }
    }

    private String getPaymentMethodText(String method) {
        if (method == null) return "Unknown";
        switch (method.toUpperCase()) {
            case "CASH": return "tiền mặt";
            case "MOMO": return "MoMo";
            case "VNPAY": return "VNPay";
            default: return method;
        }
    }

    private String formatCurrency(BigDecimal amount) {
        if (amount == null) return "0 ₫";
        return String.format("%,.0f ₫", amount.doubleValue());
    }
}
