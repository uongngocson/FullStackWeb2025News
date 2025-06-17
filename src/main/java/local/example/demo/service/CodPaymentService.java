package local.example.demo.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.entity.CodPayment;
import local.example.demo.model.entity.Employee;
import local.example.demo.model.entity.Shipment;
import local.example.demo.repository.CodPaymentRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class CodPaymentService {
    
    private final CodPaymentRepository codPaymentRepository;
    
    /**
     * Create COD payment record when shipment is completed
     */
    public CodPayment createCodPayment(Shipment shipment, Employee shipper, BigDecimal amount) {
        // Check if COD payment already exists for this shipment
        if (codPaymentRepository.existsByShipment(shipment)) {
            throw new RuntimeException("COD payment already exists for this shipment");
        }
        
        CodPayment codPayment = new CodPayment();
        codPayment.setShipment(shipment);
        codPayment.setShipper(shipper);
        codPayment.setAmount(amount);
        codPayment.setCollectedDate(LocalDate.now());
        codPayment.setSubmittedStatus("NOT_SUBMITTED");
        
        return codPaymentRepository.save(codPayment);
    }
    
    /**
     * Submit COD payment (mark as submitted)
     */
    public CodPayment submitCodPayment(Integer codPaymentId, String paymentMethod) {
        Optional<CodPayment> codPaymentOpt = codPaymentRepository.findById(codPaymentId);
        if (!codPaymentOpt.isPresent()) {
            throw new RuntimeException("COD payment not found");
        }
        
        CodPayment codPayment = codPaymentOpt.get();
        
        // Validate current status - only allow submission from NOT_SUBMITTED status
        if ((!"NOT_SUBMITTED".equals(codPayment.getSubmittedStatus())) || (codPayment.getSubmittedStatus() == null)) {
            throw new RuntimeException("COD payment has already been submitted");
        }
        
        codPayment.setSubmittedDate(LocalDate.now());
        
        // Set status based on payment method
        switch (paymentMethod.toUpperCase()) {
            case "CASH":
                // SUBMITTED_CASH requires admin approval
                codPayment.setSubmittedStatus("SUBMITTED_CASH");
                break;
            case "MOMO":
                codPayment.setSubmittedStatus("SUBMITTED_MOMO");
                break;
            case "VNPAY":
                codPayment.setSubmittedStatus("SUBMITTED_VNPAY");
                break;
            case "ADMIN_APPROVED":
                // Only admin can directly approve
                codPayment.setSubmittedStatus("ADMIN_APPROVED");
                break;
            default:
                codPayment.setSubmittedStatus("SUBMITTED");
                break;
        }
        
        return codPaymentRepository.save(codPayment);
    }
    
    /**
     * Admin approve COD payment - specifically for SUBMITTED_CASH status
     */
    public CodPayment adminApproveCodPayment(Integer codPaymentId) {
        Optional<CodPayment> codPaymentOpt = codPaymentRepository.findById(codPaymentId);
        if (!codPaymentOpt.isPresent()) {
            throw new RuntimeException("COD payment not found");
        }
        
        CodPayment codPayment = codPaymentOpt.get();
        
        // Validate status - can only approve certain statuses
        if (!isEligibleForAdminApproval(codPayment.getSubmittedStatus())) {
            throw new RuntimeException("COD payment status '" + codPayment.getSubmittedStatus() + 
                    "' is not eligible for admin approval");
        }
        
        codPayment.setSubmittedStatus("ADMIN_APPROVED");
        codPayment.setSubmittedDate(LocalDate.now()); // Update submitted date to approval date
        
        return codPaymentRepository.save(codPayment);
    }
    
    /**
     * Check if a COD payment status is eligible for admin approval
     */
    public boolean isEligibleForAdminApproval(String submittedStatus) {
        // SUBMITTED_CASH requires admin approval
        // NOT_SUBMITTED can also be directly approved by admin
        return "SUBMITTED_CASH".equals(submittedStatus) || "NOT_SUBMITTED".equals(submittedStatus);
    }
    
    /**
     * Check if a COD payment requires admin approval
     */
    public boolean requiresAdminApproval(String submittedStatus) {
        return "SUBMITTED_CASH".equals(submittedStatus);
    }
    
    /**
     * Get COD payments that require admin approval
     */
    @Transactional(readOnly = true)
    public List<CodPayment> getCodPaymentsRequiringApproval() {
        return codPaymentRepository.findBySubmittedStatus("SUBMITTED_CASH");
    }
    
    /**
     * Get COD payments that require admin approval for a specific shipper
     */
    @Transactional(readOnly = true)
    public List<CodPayment> getCodPaymentsRequiringApprovalByShipper(Employee shipper) {
        return codPaymentRepository.findByShipperAndSubmittedStatus(shipper, "SUBMITTED_CASH");
    }
    
    /**
     * Get COD payment by shipment
     */
    @Transactional(readOnly = true)
    public Optional<CodPayment> getCodPaymentByShipment(Shipment shipment) {
        return codPaymentRepository.findByShipment(shipment);
    }
    
    /**
     * Get all COD payments for a shipper
     */
    @Transactional(readOnly = true)
    public List<CodPayment> getCodPaymentsByShipper(Employee shipper) {
        return codPaymentRepository.findByShipper(shipper);
    }
    
    /**
     * Get pending COD payments for a shipper (NOT_SUBMITTED only)
     */
    @Transactional(readOnly = true)
    public List<CodPayment> getPendingCodPaymentsByShipper(Employee shipper) {
        return codPaymentRepository.findPendingCodPaymentsByShipper(shipper);
    }
    
    /**
     * Get COD payment by ID
     */
    @Transactional(readOnly = true)
    public Optional<CodPayment> getCodPaymentById(Integer codPaymentId) {
        return codPaymentRepository.findById(codPaymentId);
    }
    
    /**
     * Check if COD payment exists for shipment
     */
    @Transactional(readOnly = true)
    public boolean codPaymentExistsForShipment(Shipment shipment) {
        return codPaymentRepository.existsByShipment(shipment);
    }
    
    /**
     * Calculate total pending COD amount for shipper (only NOT_SUBMITTED)
     */
    @Transactional(readOnly = true)
    public BigDecimal getTotalPendingCodAmount(Employee shipper) {
        List<CodPayment> pendingPayments = getPendingCodPaymentsByShipper(shipper);
        return pendingPayments.stream()
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    /**
     * Calculate total submitted but not approved COD amount for shipper (SUBMITTED_CASH)
     */
    @Transactional(readOnly = true)
    public BigDecimal getTotalSubmittedPendingApprovalAmount(Employee shipper) {
        List<CodPayment> submittedPendingPayments = getCodPaymentsRequiringApprovalByShipper(shipper);
        return submittedPendingPayments.stream()
                .map(CodPayment::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
    
    /**
     * Get all COD payments by status
     */
    @Transactional(readOnly = true)
    public List<CodPayment> getCodPaymentsByStatus(String status) {
        return codPaymentRepository.findBySubmittedStatus(status);
    }
    
    /**
     * Validate COD payment state transition
     */
    public boolean isValidStatusTransition(String currentStatus, String newStatus) {
        if (currentStatus == null || newStatus == null) {
            return false;
        }
        
        switch (currentStatus) {
            case "NOT_SUBMITTED":
                // Can transition to any submitted status or admin approved
                return "SUBMITTED_CASH".equals(newStatus) || 
                       "SUBMITTED_MOMO".equals(newStatus) || 
                       "SUBMITTED_VNPAY".equals(newStatus) ||
                       "ADMIN_APPROVED".equals(newStatus);
                       
            case "SUBMITTED_CASH":
                // Can only transition to admin approved
                return "ADMIN_APPROVED".equals(newStatus);
                
            case "SUBMITTED_MOMO":
            case "SUBMITTED_VNPAY":
            case "ADMIN_APPROVED":
                // Final states - no further transitions allowed
                return false;
                
            default:
                return false;
        }
    }
}
