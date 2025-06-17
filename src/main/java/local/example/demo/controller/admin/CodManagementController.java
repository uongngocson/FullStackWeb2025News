package local.example.demo.controller.admin;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import local.example.demo.model.entity.CodPayment;
import local.example.demo.model.entity.Employee;
import local.example.demo.service.CodPaymentService;
import local.example.demo.service.EmployeeService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/cod-management/")
public class CodManagementController {
    
    private final CodPaymentService codPaymentService;
    private final EmployeeService employeeService;
    
    @GetMapping("dashboard")
    public String dashboard(Model model) {
        // Get all shippers for dashboard overview
        List<Employee> shippers = employeeService.getAllEmployees().stream()
                .filter(employee -> employee.getAccount() != null 
                        && employee.getAccount().getRole() != null 
                        && "SHIPPER".equals(employee.getAccount().getRole().getRoleName()))
                .collect(Collectors.toList());
        
        // Calculate statistics for each shipper
        Map<Employee, Map<String, BigDecimal>> shipperStats = shippers.stream()
                .collect(Collectors.toMap(
                    shipper -> shipper,
                    shipper -> {
                        List<CodPayment> payments = codPaymentService.getCodPaymentsByShipper(shipper);
                        BigDecimal totalCollected = payments.stream()
                                .map(CodPayment::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);
                        BigDecimal totalPending = payments.stream()
                                .filter(payment -> "NOT_SUBMITTED".equals(payment.getSubmittedStatus()))
                                .map(CodPayment::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);
                        BigDecimal totalSubmitted = payments.stream()
                                .filter(payment -> !"NOT_SUBMITTED".equals(payment.getSubmittedStatus()) 
                                        && !"SUBMITTED_CASH".equals(payment.getSubmittedStatus()))
                                .map(CodPayment::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);
                        // Add submitted cash pending approval
                        BigDecimal totalSubmittedPendingApproval = payments.stream()
                                .filter(payment -> "SUBMITTED_CASH".equals(payment.getSubmittedStatus()))
                                .map(CodPayment::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);
                        
                        Map<String, BigDecimal> stats = Map.of(
                            "totalCollected", totalCollected,
                            "totalPending", totalPending,
                            "totalSubmitted", totalSubmitted,
                            "totalSubmittedPendingApproval", totalSubmittedPendingApproval
                        );
                        return stats;
                    }
                ));
        
        model.addAttribute("shippers", shippers);
        model.addAttribute("shipperStats", shipperStats);
        
        return "admin/shipper-mgr/status-shipping";
    }
    
    @GetMapping("shipper/{shipperId}")
    public String getShipperCodDetails(@PathVariable("shipperId") Integer shipperId,
                                     @RequestParam(defaultValue = "0") int page,
                                     @RequestParam(defaultValue = "10") int size,
                                     @RequestParam(defaultValue = "collectedDate") String sortBy,
                                     @RequestParam(defaultValue = "desc") String sortDir,
                                     @RequestParam(required = false) String status,
                                     Model model) {
        
        Employee shipper = employeeService.getEmployeeById(shipperId);
        if (shipper == null) {
            return "redirect:/admin/cod-management/dashboard";
        }
        
        // Get shipper's COD payments with pagination
        Sort sort = sortDir.equals("desc") ? Sort.by(sortBy).descending() : Sort.by(sortBy).ascending();
        Pageable pageable = PageRequest.of(page, size, sort);
        
        List<CodPayment> codPayments;
        if (status != null && !status.isEmpty()) {
            codPayments = codPaymentService.getCodPaymentsByShipper(shipper).stream()
                    .filter(payment -> payment.getSubmittedStatus().equals(status))
                    .collect(Collectors.toList());
        } else {
            codPayments = codPaymentService.getCodPaymentsByShipper(shipper);
        }
        
        // Calculate statistics
        BigDecimal totalCollected = codPayments.stream()
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal totalPending = codPayments.stream()
                .filter(payment -> "NOT_SUBMITTED".equals(payment.getSubmittedStatus()))
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal totalSubmitted = codPayments.stream()
                .filter(payment -> !payment.getSubmittedStatus().equals("NOT_SUBMITTED")
                        && !payment.getSubmittedStatus().equals("SUBMITTED_CASH"))
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        // Add submitted cash pending approval
        BigDecimal totalSubmittedPendingApproval = codPayments.stream()
                .filter(payment -> "SUBMITTED_CASH".equals(payment.getSubmittedStatus()))
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("shipper", shipper);
        model.addAttribute("codPayments", codPayments);
        model.addAttribute("totalCollected", totalCollected);
        model.addAttribute("totalPending", totalPending);
        model.addAttribute("totalSubmitted", totalSubmitted);
        model.addAttribute("totalSubmittedPendingApproval", totalSubmittedPendingApproval);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", (codPayments.size() + size - 1) / size);
        model.addAttribute("currentStatus", status);
        model.addAttribute("sortBy", sortBy);
        model.addAttribute("sortDir", sortDir);
        
        return "admin/shipper-mgr/status-shipping";
    }
    
    @PostMapping("approve/{codPaymentId}")
    public String approveCodPayment(@PathVariable("codPaymentId") Integer codPaymentId,
                                   RedirectAttributes redirectAttributes) {
        try {
            CodPayment codPayment = codPaymentService.getCodPaymentById(codPaymentId)
                    .orElseThrow(() -> new RuntimeException("COD payment not found"));
            
            // Use the new admin approval method
            codPaymentService.adminApproveCodPayment(codPaymentId);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                    "Đã duyệt thành công thanh toán COD của shipper " + 
                    codPayment.getShipper().getFirstName() + " " + codPayment.getShipper().getLastName() +
                    " với số tiền " + codPayment.getAmount() + "₫");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                    "Có lỗi xảy ra khi duyệt thanh toán: " + e.getMessage());
        }
        
        return "redirect:/admin/cod-management/dashboard";
    }
    
    @PostMapping("bulk-approve")
    public String bulkApproveCodPayments(@RequestParam("codPaymentIds") List<Integer> codPaymentIds,
                                        RedirectAttributes redirectAttributes) {
        try {
            int approvedCount = 0;
            int errorCount = 0;
            StringBuilder errorMessages = new StringBuilder();
            
            for (Integer codPaymentId : codPaymentIds) {
                try {
                    codPaymentService.adminApproveCodPayment(codPaymentId);
                    approvedCount++;
                } catch (Exception e) {
                    errorCount++;
                    errorMessages.append("ID ").append(codPaymentId).append(": ").append(e.getMessage()).append("; ");
                }
            }
            
            if (approvedCount > 0) {
                redirectAttributes.addFlashAttribute("successMessage", 
                        "Đã duyệt thành công " + approvedCount + " thanh toán COD");
            }
            
            if (errorCount > 0) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                        "Có " + errorCount + " thanh toán không thể duyệt: " + errorMessages.toString());
            }
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                    "Có lỗi xảy ra khi duyệt thanh toán: " + e.getMessage());
        }
        
        return "redirect:/admin/cod-management/dashboard";
    }
    
    @GetMapping("statistics")
    public String getStatistics(@RequestParam(required = false) LocalDate fromDate,
                               @RequestParam(required = false) LocalDate toDate,
                               Model model) {
        
        final LocalDate finalFromDate = fromDate != null ? fromDate : LocalDate.now().minusDays(30);
        final LocalDate finalToDate = toDate != null ? toDate : LocalDate.now();
        
        List<Employee> shippers = employeeService.getAllEmployees().stream()
                .filter(employee -> employee.getAccount() != null 
                        && employee.getAccount().getRole() != null 
                        && "SHIPPER".equals(employee.getAccount().getRole().getRoleName()))
                .collect(Collectors.toList());
        
        Map<Employee, BigDecimal> shipperTotals = shippers.stream()
                .collect(Collectors.toMap(
                    shipper -> shipper,
                    shipper -> {
                        List<CodPayment> payments = codPaymentService.getCodPaymentsByShipper(shipper);
                        return payments.stream()
                                .filter(payment -> !payment.getCollectedDate().isBefore(finalFromDate) 
                                        && !payment.getCollectedDate().isAfter(finalToDate))
                                .map(CodPayment::getAmount)
                                .reduce(BigDecimal.ZERO, BigDecimal::add);
                    }
                ));
        
        model.addAttribute("shipperTotals", shipperTotals);
        model.addAttribute("fromDate", finalFromDate);
        model.addAttribute("toDate", finalToDate);
        
        return "admin/shipper-mgr/status-shipping";
    }
    
    /**
     * Get COD payments requiring approval dashboard
     */
    @GetMapping("pending-approval")
    public String getPendingApprovalDashboard(Model model) {
        List<CodPayment> pendingApprovalPayments = codPaymentService.getCodPaymentsRequiringApproval();
        
        BigDecimal totalPendingApprovalAmount = pendingApprovalPayments.stream()
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("pendingApprovalPayments", pendingApprovalPayments);
        model.addAttribute("totalPendingApprovalAmount", totalPendingApprovalAmount);
        model.addAttribute("pendingApprovalCount", pendingApprovalPayments.size());
        
        return "admin/shipper-mgr/pending-approval";
    }
} 