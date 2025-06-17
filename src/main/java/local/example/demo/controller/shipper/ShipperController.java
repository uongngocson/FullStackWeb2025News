package local.example.demo.controller.shipper;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import local.example.demo.model.entity.CodPayment;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Order;
import local.example.demo.model.entity.OrderDetail;
import local.example.demo.model.entity.Shipment;
import local.example.demo.service.CodPaymentService;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.ShipperService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/shipper/")
public class ShipperController {

    private final ShipperService shipperService;
    private final EmployeeService employeeService;
    private final CodPaymentService codPaymentService;

    // Hiển thị trang danh sách đơn hàng và vận đơn
    @GetMapping("order/list")
    public String getOrderList(Model model) {
        // Lấy danh sách đơn hàng có trạng thái CONFIRMED
        List<Order> confirmedOrders = shipperService.getConfirmedOrders();
        model.addAttribute("confirmedOrders", confirmedOrders);
        return "shipper/order/list";
    }

    // Hiển thị chi tiết đơn hàng
    @GetMapping("order/detail")
    public String getOrderDetail(@RequestParam("orderId") String orderId, Model model,
            RedirectAttributes redirectAttributes) {
        Optional<Order> orderOpt = shipperService.getOrderById(orderId);
        if (!orderOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng!");
            return "redirect:/shipper/order/list";
        }

        Order order = orderOpt.get();
        List<OrderDetail> orderDetails = shipperService.getOrderDetails(orderId);

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);

        return "shipper/order/detail"; // Trả về view detail.jsp
    }

    // Hiển thị trang danh sách vận đơn của shipper
    @GetMapping("shipment/list")
    public String getShipmentList(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");

        if (employeeId == null) {
            return "redirect:/login";
        }
        Employee shipper = employeeService.getEmployeeById(employeeId);
        List<Shipment> shipments = shipperService.getShipmentsByShipper(shipper);
        
        // Load COD payment information for each shipment
        Map<Integer, CodPayment> codPaymentMap = new HashMap<>();
        for (Shipment shipment : shipments) {
            if ("COD".equals(shipment.getPaymentMethod())) {
                Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentByShipment(shipment);
                if (codPaymentOpt.isPresent()) {
                    codPaymentMap.put(shipment.getShipmentId(), codPaymentOpt.get());
                }
            }
        }
        
        model.addAttribute("shipments", shipments);
        model.addAttribute("codPaymentMap", codPaymentMap);

        return "shipper/shipment/list";
    }

    // Tạo vận đơn mới
    @GetMapping("shipment/create")
    public String createShipment(HttpServletRequest request,
            @RequestParam("orderId") String orderId,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");
        Employee shipper = employeeService.getEmployeeById(employeeId);

        try {
            // Tạo vận đơn mới
            Shipment shipment = shipperService.createShipment(orderId, shipper);
            if (shipment != null) { // Kiểm tra shipment có được tạo thành công không
                redirectAttributes.addFlashAttribute("successMessage", "Đã nhận đơn hàng thành công!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng để tạo vận đơn.");
            }
        } catch (Exception e) {
            System.out.println("lỗi" + e.getMessage());
            // Log chi tiết ngoại lệ
            // e.printStackTrace(); // In stack trace ra console/log
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo vận đơn: " + e.getMessage());

        }

        return "redirect:/shipper/order/list";
    }

    // Hiển thị form cập nhật vận đơn
    @GetMapping("shipment/edit")
    public String showUpdateForm(@RequestParam("shipmentId") Integer shipmentId,
            Model model, RedirectAttributes redirectAttributes) {

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                model.addAttribute("shipment", shipment);
                
                // Check if this is a COD shipment and get COD payment info
                if ("COD".equals(shipment.getPaymentMethod())) {
                    Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentByShipment(shipment);
                    model.addAttribute("codPayment", codPaymentOpt.orElse(null));
                }
                
                return "shipper/shipment/update";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tải thông tin vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }

    // Cập nhật trạng thái vận đơn
    @PostMapping("shipment/update")
    public String updateShipment(
            @RequestParam("shipmentId") Integer shipmentId,
            @RequestParam("status") String status,
            @RequestParam(value = "paymentStatus", required = false) String paymentStatus,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");
        Employee shipper = employeeService.getEmployeeById(employeeId);

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                Order order = shipment.getOrder();

                // Cập nhật trạng thái shipment
                shipment.setStatus(status);

                // Cập nhật payment status nếu có
                if (paymentStatus != null && !paymentStatus.isEmpty()) {
                    shipment.setPaymentStatus(paymentStatus);
                }

                // Xử lý COD payment khi shipment được hoàn thành
                if ("COMPLETED".equals(status) && "COD".equals(shipment.getPaymentMethod())) {
                    // Tạo COD payment record nếu chưa có
                    if (!codPaymentService.codPaymentExistsForShipment(shipment)) {
                        BigDecimal codAmount = order.getTotalAmount();
                        codPaymentService.createCodPayment(shipment, shipper, codAmount);
                    }
                }

                // Cập nhật trạng thái order tương ứng
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

                // Lưu order sau khi cập nhật trạng thái
                shipperService.saveOrder(order);

                // Lưu shipment
                shipperService.updateShipment(shipment);

                redirectAttributes.addFlashAttribute("successMessage", "Cập nhật trạng thái vận đơn thành công!");
                
                // Redirect back to edit page instead of list page
                return "redirect:/shipper/shipment/edit?shipmentId=" + shipmentId;
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/edit?shipmentId=" + shipmentId;
    }

    // Submit COD payment
    @PostMapping("cod/submit")
    public String submitCodPayment(
            @RequestParam("codPaymentId") Integer codPaymentId,
            @RequestParam("paymentMethod") String paymentMethod,
            RedirectAttributes redirectAttributes) {

        System.out.println("=== COD SUBMIT DEBUG ===");
        System.out.println("COD Payment ID: " + codPaymentId);
        System.out.println("Payment Method: " + paymentMethod);
        System.out.println("========================");

        try {
            codPaymentService.submitCodPayment(codPaymentId, paymentMethod);
            redirectAttributes.addFlashAttribute("successMessage", "Đã nộp COD thành công bằng " + paymentMethod + "!");
            System.out.println("COD submission successful");
        } catch (Exception e) {
            System.out.println("COD submission error: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi nộp COD: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }

    // Redirect to payment gateway for COD submission
    @GetMapping("cod/pay")
    public String payCod(
            @RequestParam("codPaymentId") Integer codPaymentId,
            @RequestParam("method") String method,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<CodPayment> codPaymentOpt = codPaymentService.getCodPaymentById(codPaymentId);
            if (!codPaymentOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin COD!");
                return "redirect:/shipper/shipment/list";
            }

            CodPayment codPayment = codPaymentOpt.get();
            long amount = codPayment.getAmount().longValue();

            // Redirect to appropriate payment gateway
            switch (method.toUpperCase()) {
                case "MOMO":
                    return "redirect:/api/payment/create_momo_payment?amount=" + amount + "&codPaymentId=" + codPaymentId;
                case "VNPAY":
                    return "redirect:/api/payment/create_payment?amount=" + amount + "&codPaymentId=" + codPaymentId;
                default:
                    redirectAttributes.addFlashAttribute("errorMessage", "Phương thức thanh toán không hợp lệ!");
                    return "redirect:/shipper/shipment/list";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi chuyển đến trang thanh toán: " + e.getMessage());
            return "redirect:/shipper/shipment/list";
        }
    }

    // Xóa vận đơn
    @GetMapping("shipment/delete")
    public String deleteShipment(@RequestParam("shipmentId") Integer shipmentId,
            RedirectAttributes redirectAttributes) {

        try {
            Optional<Shipment> shipmentOpt = shipperService.getShipmentById(shipmentId);
            if (shipmentOpt.isPresent()) {
                Shipment shipment = shipmentOpt.get();
                Order order = shipment.getOrder();

                // Đặt lại trạng thái order thành CONFIRMED
                order.setOrderStatus("CONFIRMED");

                // Lưu order trước khi xóa shipment
                shipperService.saveOrder(order);

                // Xóa shipment
                shipperService.deleteShipment(shipmentId);
                redirectAttributes.addFlashAttribute("successMessage",
                        "Xóa vận đơn thành công và đặt lại trạng thái đơn hàng!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy vận đơn!");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa vận đơn: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/list";
    }

    // COD Status Management Page
    @GetMapping("shipment/statusshipping")
    public String getCodStatusManagement(
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "dateFrom", required = false) String dateFrom,
            @RequestParam(value = "dateTo", required = false) String dateTo,
            HttpServletRequest request, 
            Model model) {
        
        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");

        if (employeeId == null) {
            return "redirect:/login";
        }

        Employee shipper = employeeService.getEmployeeById(employeeId);
        List<CodPayment> codPayments;

        try {
            // Get COD payments based on filters
            if (status != null && !status.isEmpty()) {
                codPayments = codPaymentService.getCodPaymentsByShipper(shipper)
                    .stream()
                    .filter(cod -> cod.getSubmittedStatus().equals(status))
                    .collect(java.util.stream.Collectors.toList());
            } else {
                codPayments = codPaymentService.getCodPaymentsByShipper(shipper);
            }

            // Apply date filters if provided
            if (dateFrom != null && !dateFrom.isEmpty()) {
                java.time.LocalDate fromDate = java.time.LocalDate.parse(dateFrom);
                codPayments = codPayments.stream()
                    .filter(cod -> !cod.getCollectedDate().isBefore(fromDate))
                    .collect(java.util.stream.Collectors.toList());
            }

            if (dateTo != null && !dateTo.isEmpty()) {
                java.time.LocalDate toDate = java.time.LocalDate.parse(dateTo);
                codPayments = codPayments.stream()
                    .filter(cod -> !cod.getCollectedDate().isAfter(toDate))
                    .collect(java.util.stream.Collectors.toList());
            }

            // Sort by collection date (newest first)
            codPayments.sort((a, b) -> b.getCollectedDate().compareTo(a.getCollectedDate()));

            model.addAttribute("codPayments", codPayments);
            System.out.println("=== COD PAYMENTS DEBUG ===");
            System.out.println("Total COD Payments found: " + codPayments.size());
            System.out.println("Shipper ID: " + shipper.getEmployeeId());
            System.out.println("Applied filters - Status: " + status + ", DateFrom: " + dateFrom + ", DateTo: " + dateTo);
            
            if (codPayments.isEmpty()) {
                System.out.println("NO COD PAYMENTS FOUND!");
            } else {
                for (int i = 0; i < Math.min(5, codPayments.size()); i++) {
                    CodPayment cod = codPayments.get(i);
                    System.out.println("COD[" + i + "]: ID=" + cod.getCodPaymentId() + 
                        ", Amount=" + cod.getAmount() + 
                        ", Status=" + cod.getSubmittedStatus() + 
                        ", CollectedDate=" + cod.getCollectedDate());
                }
                if (codPayments.size() > 5) {
                    System.out.println("... and " + (codPayments.size() - 5) + " more COD payments");
                }
            }
            System.out.println("=== END DEBUG ===");
            
            model.addAttribute("shipper", shipper);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Lỗi khi tải danh sách COD: " + e.getMessage());
            model.addAttribute("codPayments", new java.util.ArrayList<>());
        }

        return "shipper/shipment/statusshipping";
    }

    // Submit all pending COD payments
    @PostMapping("cod/submitAll")
    public String submitAllCodPayments(
            @RequestParam("paymentMethod") String paymentMethod,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");

        if (employeeId == null) {
            return "redirect:/login";
        }

        try {
            Employee shipper = employeeService.getEmployeeById(employeeId);
            List<CodPayment> pendingPayments = codPaymentService.getPendingCodPaymentsByShipper(shipper);

            if (pendingPayments.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không có giao dịch COD nào cần nộp!");
                return "redirect:/shipper/shipment/statusshipping";
            }

            int submittedCount = 0;
            java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;

            for (CodPayment codPayment : pendingPayments) {
                try {
                    codPaymentService.submitCodPayment(codPayment.getCodPaymentId(), paymentMethod);
                    submittedCount++;
                    totalAmount = totalAmount.add(codPayment.getAmount());
                } catch (Exception e) {
                    System.out.println("Error submitting COD payment " + codPayment.getCodPaymentId() + ": " + e.getMessage());
                }
            }

            if (submittedCount > 0) {
                String methodText = getPaymentMethodText(paymentMethod);
                redirectAttributes.addFlashAttribute("successMessage", 
                    String.format("Đã nộp thành công %d giao dịch COD bằng %s với tổng số tiền %,.0f ₫!", 
                    submittedCount, methodText, totalAmount));
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể nộp COD nào!");
            }

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi nộp COD: " + e.getMessage());
        }

        return "redirect:/shipper/shipment/statusshipping";
    }

    // Payment gateway for all pending COD
    @GetMapping("cod/payAll")
    public String payAllCod(
            @RequestParam("method") String method,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        Integer employeeId = (Integer) session.getAttribute("employeeId");

        if (employeeId == null) {
            return "redirect:/login";
        }

        try {
            Employee shipper = employeeService.getEmployeeById(employeeId);
            List<CodPayment> pendingPayments = codPaymentService.getPendingCodPaymentsByShipper(shipper);

            if (pendingPayments.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không có giao dịch COD nào cần thanh toán!");
                return "redirect:/shipper/shipment/statusshipping";
            }

            // Calculate total amount
            java.math.BigDecimal totalAmount = pendingPayments.stream()
                .map(CodPayment::getAmount)
                .reduce(java.math.BigDecimal.ZERO, java.math.BigDecimal::add);

            long amount = totalAmount.longValue();

            // Create comma-separated list of COD payment IDs for bulk payment
            String codPaymentIds = pendingPayments.stream()
                .map(cod -> cod.getCodPaymentId().toString())
                .collect(java.util.stream.Collectors.joining(","));

            // Redirect to appropriate payment gateway with bulk payment parameters
            switch (method.toUpperCase()) {
                case "MOMO":
                    return "redirect:/api/payment/create_momo_payment?amount=" + amount + "&codPaymentIds=" + codPaymentIds;
                case "VNPAY":
                    return "redirect:/api/payment/create_payment?amount=" + amount + "&codPaymentIds=" + codPaymentIds;
                default:
                    redirectAttributes.addFlashAttribute("errorMessage", "Phương thức thanh toán không hợp lệ!");
                    return "redirect:/shipper/shipment/statusshipping";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi chuyển đến trang thanh toán: " + e.getMessage());
            return "redirect:/shipper/shipment/statusshipping";
        }
    }

    // Helper method to get payment method text
    private String getPaymentMethodText(String method) {
        switch (method.toUpperCase()) {
            case "CASH":
                return "tiền mặt";
            case "MOMO":
                return "MoMo";
            case "VNPAY":
                return "VNPay";
            default:
                return method;
        }
    }
}
