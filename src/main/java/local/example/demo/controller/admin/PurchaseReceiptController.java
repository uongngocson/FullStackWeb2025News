package local.example.demo.controller.admin;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpSession;
import local.example.demo.model.dto.ProductVariantDto;
import local.example.demo.model.dto.PurchaseReceiptDetailDto;
import local.example.demo.model.entity.Employee;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.model.entity.PurchaseReceipt;
import local.example.demo.model.entity.PurchaseReceiptDetail;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.ProductService;
import local.example.demo.service.PurchaseReceiptService;
import local.example.demo.service.SupplierService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/receipt-mgr")
@RequiredArgsConstructor
public class PurchaseReceiptController {

    private final PurchaseReceiptService purchaseReceiptService;
    private final SupplierService supplierService;
    private final ProductService productService; // Cần ProductService để lấy ProductVariant
    private final EmployeeService employeeService;

    private final com.fasterxml.jackson.databind.ObjectMapper objectMapper; // Thêm dependency này

    @GetMapping("/list")
    public String getAllReceipts(Model model) {
        try {
            List<PurchaseReceipt> receipts = purchaseReceiptService.getAllReceipts();
            model.addAttribute("receipts", receipts);
            return "admin/receipt-mgr/receipt-list";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Lỗi khi tải danh sách phiếu nhập: " + e.getMessage());
            return "admin/receipt-mgr/receipt-list";
        }
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        PurchaseReceipt purchaseReceipt = new PurchaseReceipt();
        // Tạo mã phiếu nhập ngẫu nhiên và gán vào đối tượng purchaseReceipt
        String newReceiptCode = purchaseReceiptService.generateUniqueReceiptCode();
        purchaseReceipt.setReceiptCode(newReceiptCode);

        model.addAttribute("purchaseReceipt", purchaseReceipt);
        model.addAttribute("suppliers", supplierService.findAllSuppliers());
        model.addAttribute("products", productService.findAllProducts());

        List<ProductVariant> allVariants = productService.findAllProductVariants();
        model.addAttribute("allProductVariantsList", allVariants);
        return "admin/receipt-mgr/create-receipt";
    }

    // Thêm phương thức để lấy sản phẩm theo nhà cung cấp
    @GetMapping("/get-products-by-supplier")
    public String getProductsBySupplier(@RequestParam("supplierId") Integer supplierId, Model model) {
        model.addAttribute("products", productService.findProductsBySupplier(supplierId));
        return "admin/receipt-mgr/product-list-fragment";
    }

    // Thêm phương thức hiển thị chi tiết phiếu nhập
    @GetMapping("/detail/{receiptId}")
    public String showReceiptDetail(@PathVariable Integer receiptId, Model model,
            RedirectAttributes redirectAttributes) {
        try {
            Optional<PurchaseReceipt> receiptOpt = purchaseReceiptService.getReceiptById(receiptId);
            if (!receiptOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phiếu nhập với ID: " + receiptId);
                return "redirect:/admin/receipt-mgr/list";
            }
            PurchaseReceipt receipt = receiptOpt.get();
            List<PurchaseReceiptDetail> details = purchaseReceiptService.getReceiptDetails(receiptId);

            model.addAttribute("receipt", receipt);
            model.addAttribute("details", details);
            return "admin/receipt-mgr/detail-receipt"; // Cần tạo file JSP này
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tải chi tiết phiếu nhập: " + e.getMessage());
            return "redirect:/admin/receipt-mgr/list";
        }
    }

    // Thêm phương thức hiển thị form cập nhật phiếu nhập
    @GetMapping("/update/{receiptId}")
    public String showUpdateForm(@PathVariable Integer receiptId, Model model, RedirectAttributes redirectAttributes) {
        try {
            Optional<PurchaseReceipt> receiptOpt = purchaseReceiptService.getReceiptById(receiptId);
            if (!receiptOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phiếu nhập với ID: " + receiptId);
                return "redirect:/admin/receipt-mgr/list";
            }
            PurchaseReceipt purchaseReceipt = receiptOpt.get();
            List<PurchaseReceiptDetail> details = purchaseReceiptService.getReceiptDetails(receiptId);

            model.addAttribute("purchaseReceipt", purchaseReceipt);
            model.addAttribute("details", details); // Truyền chi tiết hiện có
            model.addAttribute("suppliers", supplierService.findAllSuppliers());
            model.addAttribute("products", productService.findAllProducts());
            model.addAttribute("allProductVariantsList", productService.findAllProductVariants()); // Cần cho dropdown
                                                                                                   // biến thể

            // Chuyển đổi details thành JSON string để dễ dàng xử lý ở frontend
            String detailsJson = objectMapper.writeValueAsString(
                    details.stream().map(PurchaseReceiptDetailDto::new).collect(Collectors.toList()));
            model.addAttribute("detailsJson", detailsJson);

            return "admin/receipt-mgr/update-receipt"; // Sử dụng file JSP đã cung cấp
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Lỗi khi tải form cập nhật phiếu nhập: " + e.getMessage());
            e.printStackTrace(); // Log lỗi chi tiết
            return "redirect:/admin/receipt-mgr/list";
        }
    }

    @PostMapping("/save")
    public String saveReceipt(
            @ModelAttribute("purchaseReceipt") PurchaseReceipt purchaseReceipt,
            @RequestParam(value = "detailsJson", required = false) String detailsJson, // Nhận chuỗi JSON
            @RequestParam(value = "totalAmount", required = false) Double totalAmount, // Nhận totalAmount từ form
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        try {
            // Debug: Log the received data
            System.out.println("Received purchaseReceipt: " + purchaseReceipt);
            System.out.println("Received detailsJson: " + detailsJson); // Log chuỗi JSON
            System.out.println("Received totalAmount: " + totalAmount); // Log totalAmount

            // Kiểm tra mã phiếu nhập đã tồn tại chưa (trường hợp người dùng có thể thay đổi
            // mã trên form nếu không disable)
            // Hoặc kiểm tra lại để đảm bảo tính duy nhất trước khi lưu
            // Logic này chỉ áp dụng cho tạo mới, không áp dụng cho cập nhật
            if (purchaseReceipt.getId() == null && purchaseReceipt.getReceiptCode() != null
                    && purchaseReceiptService.isReceiptCodeExists(purchaseReceipt.getReceiptCode())) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi: Mã phiếu nhập '" + purchaseReceipt.getReceiptCode() + "' đã tồn tại. Vui lòng thử lại.");
                return "redirect:/admin/receipt-mgr/create";
            }

            // Retrieve the logged-in employee from the session
            Integer employeeId = (Integer) session.getAttribute("employeeId");
            if (employeeId == null) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi: Không tìm thấy thông tin nhân viên trong phiên. Vui lòng đăng nhập lại.");
                return "redirect:/admin/login";
            }
            Employee loggedInEmployee = employeeService.getEmployeeById(employeeId);

            if (loggedInEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi: Phiên đăng nhập đã hết hạn hoặc người dùng chưa đăng nhập. Vui lòng đăng nhập lại.");
                return "redirect:/login"; // Assuming login page is at /login
            }

            // Set the employee on the purchase receipt
            purchaseReceipt.setEmployee(loggedInEmployee);

            // Set the total amount received from the form
            if (totalAmount != null) {
                purchaseReceipt.setTotalAmount(totalAmount);
            } else {
                // Handle case where totalAmount is not received (e.g., form error)
                // You might want to calculate it server-side or add validation
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi: Không nhận được tổng tiền phiếu nhập.");
                // Redirect based on whether it's create or update
                return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                        : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
            }

            // Parse JSON string into a list of DTOs
            List<PurchaseReceiptDetailDto> detailDtos = new ArrayList<>();
            if (detailsJson != null && !detailsJson.isEmpty()) {
                // Sử dụng TypeReference để parse List<PurchaseReceiptDetailDto>
                detailDtos = objectMapper.readValue(detailsJson,
                        new com.fasterxml.jackson.core.type.TypeReference<List<PurchaseReceiptDetailDto>>() {
                        });
                System.out.println("Parsed detail DTOs: " + detailDtos.size()); // Log số lượng DTO
            }

            // Manually create PurchaseReceiptDetail objects from DTOs
            List<PurchaseReceiptDetail> details = new ArrayList<>();
            if (detailDtos.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi: Phiếu nhập phải có ít nhất một chi tiết sản phẩm.");
                // Redirect based on whether it's create or update
                return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                        : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
            }

            for (PurchaseReceiptDetailDto dto : detailDtos) {
                // Basic validation on DTO data
                if (dto.getProductVariantId() == null || dto.getQuantity() == null || dto.getUnitPrice() == null
                        || dto.getQuantity() <= 0 || dto.getUnitPrice() < 0) {
                    redirectAttributes.addFlashAttribute("errorMessage",
                            "Lỗi: Dữ liệu chi tiết phiếu nhập không hợp lệ.");
                    // Redirect based on whether it's create or update
                    return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                            : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
                }

                ProductVariant productVariant = productService.findProductVariantById(dto.getProductVariantId());
                if (productVariant == null) {
                    redirectAttributes.addFlashAttribute("errorMessage",
                            "Lỗi: Không tìm thấy biến thể sản phẩm với ID " + dto.getProductVariantId());
                    // Redirect based on whether it's create or update
                    return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                            : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
                }

                PurchaseReceiptDetail detail = new PurchaseReceiptDetail();
                // detail.setPurchaseReceipt(purchaseReceipt); // Link detail back to the
                // receipt - This will be set in service
                detail.setProductVariant(productVariant);
                detail.setProduct(productVariant.getProduct()); // Set product from variant
                detail.setQuantity(dto.getQuantity());
                detail.setUnitPrice(dto.getUnitPrice());
                // Set detail ID if it exists (for update)
                detail.setId(dto.getId());

                details.add(detail);
            }

            // Validation: Ensure the number of details matches the DTOs processed
            if (details.size() != detailDtos.size()) {
                // This case should ideally not happen if validation passes, but good for safety
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Lỗi xử lý chi tiết phiếu nhập.");
                // Redirect based on whether it's create or update
                return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                        : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
            }

            // Use saveReceiptWithDetails for both create and update
            // The service method should handle updating existing details or creating new
            // ones
            // and updating inventory accordingly.

            // Determine if it's a create or update before saving
            boolean isCreate = purchaseReceipt.getId() == null;

            purchaseReceiptService.saveReceiptWithDetails(purchaseReceipt, details);

            // Set success message based on whether it was a create or update
            redirectAttributes.addFlashAttribute("successMessage",
                    isCreate ? "Tạo phiếu nhập hàng thành công"
                            : "Cập nhật phiếu nhập hàng thành công");
            return "redirect:/admin/receipt-mgr/list";
        } catch (com.fasterxml.jackson.core.JsonProcessingException e) {
            // Handle JSON parsing errors
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Lỗi xử lý dữ liệu chi tiết phiếu nhập: " + e.getMessage());
            e.printStackTrace();
            // Redirect based on whether it's create or update
            return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                    : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
            e.printStackTrace();
            // Redirect based on whether it's create or update
            return purchaseReceipt.getId() == null ? "redirect:/admin/receipt-mgr/create"
                    : "redirect:/admin/receipt-mgr/update/" + purchaseReceipt.getId();
        }
    }

    // New endpoint to fetch product variants by product ID
    @GetMapping("/api/products/{productId}/variants")
    @ResponseBody
    public List<ProductVariantDto> getProductVariantsByProductId(@PathVariable Integer productId) {
        List<ProductVariant> variants = productService.findVariantsByProductId(productId);
        return variants.stream()
                .map(ProductVariantDto::new)
                .collect(Collectors.toList());
    }

    // Hoàn thiện phương thức xóa phiếu nhập
    @PostMapping("/delete/{receiptId}")
    public String deleteReceipt(@PathVariable Integer receiptId, RedirectAttributes redirectAttributes) {
        try {
            purchaseReceiptService.deleteReceipt(receiptId); // Gọi service để xóa
            redirectAttributes.addFlashAttribute("successMessage", "Xóa phiếu nhập thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa phiếu nhập: " + e.getMessage());
            e.printStackTrace(); // Log lỗi chi tiết
        }
        return "redirect:/admin/receipt-mgr/list";
    }
}
