package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import local.example.demo.exception.SupplierInUseException;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Supplier;
import local.example.demo.service.FileUploadS3Service;
import local.example.demo.service.ProductService;
import local.example.demo.service.SupplierService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("admin/supplier-mgr/")
public class SupplierMgrController {
    private final SupplierService supplierService;
    private final ProductService productService;
    private final FileUploadS3Service fileUploadS3Service;

    // Example method to get the list of Suppliers
    @GetMapping("list")
    public String getSupplierList() {
        return "admin/supplier-mgr/all-suppliers";
    }

    // Example method to get the list of Suppliers
    @ModelAttribute("suppliers")
    public List<Supplier> populateSuppliers() {
        return supplierService.findAllSuppliers();
    }

    // Example method to get the details of a specific Supplier
    @GetMapping("detail/{supplierId}")
    public String getSupplierDetail(@PathVariable("supplierId") Integer supplierId, Model model) {
        Supplier supplier = supplierService.findSupplierById(supplierId);
        List<Product> products = productService.findProductsBySupplierId(supplierId);
        if (supplier == null) {
            return "redirect:/admin/supplier-mgr/list";
        }
        model.addAttribute("products", products);
        model.addAttribute("supplier", supplier);
        return "admin/supplier-mgr/detail-supplier";
    }

    // Example method to create a new supplier
    @GetMapping("create")
    public String createSupplier(Model model) {
        model.addAttribute("supplier", new Supplier());
        return "admin/supplier-mgr/form-supplier";
    }

    // update the supplier
    @GetMapping("update/{supplierId}")
    public String updateSupplier(Model model, @PathVariable("supplierId") Integer supplierId) {
        Supplier supplier = supplierService.findSupplierById(supplierId);
        if (supplier == null) {
            return "redirect:/admin/supplier-mgr/list";
        }
        model.addAttribute("supplier", supplier);
        return "admin/supplier-mgr/form-supplier";
    }

    // Example method to handle the creation of a new supplier
    @PostMapping("save")
    public String saveSupplier(@ModelAttribute("supplier") @Valid Supplier supplier, BindingResult bindingResult,
            @RequestParam("logoFile") MultipartFile logoFile, RedirectAttributes redirectAttributes) {

        // Check for existing supplier name considering create vs update
        Supplier existingSupplierByName = supplierService.findSupplierByName(supplier.getSupplierName());
        if (existingSupplierByName != null &&
                (supplier.getSupplierId() == null
                        || !existingSupplierByName.getSupplierId().equals(supplier.getSupplierId()))) {
            // Name exists and it's either a new supplier OR it's an existing supplier with
            // a different ID
            bindingResult.rejectValue("supplierName", "error.supplier", "Tên nhà cung cấp đã tồn tại");
        }

        if (bindingResult.hasErrors()) {
            return "admin/supplier-mgr/form-supplier";
        }
        // if (fileService.isValidFile(logoFile)) {
        // String fileName = fileService.handleSaveUploadFile(logoFile, "supplier");
        // supplier.setLogoUrl("/resources/images-upload/supplier/" + fileName);
        // }
        try {
            if (fileUploadS3Service.isValidFile(logoFile)) {
                String fileName = fileUploadS3Service.uploadFile(logoFile, "suppliers");
                supplier.setLogoUrl(fileName);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (supplier.getSupplierId() != null) {
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhà cung cấp thành công");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Thêm mới nhà cung cấp thành công");
        }
        // Save the supplier to the database
        supplierService.saveSupplier(supplier);
        return "redirect:/admin/supplier-mgr/list";
    }

    // delete the supplier
    @PostMapping("delete/{supplierId}")
    public String deleteSupplier(@PathVariable("supplierId") Integer supplierId,
            RedirectAttributes redirectAttributes) {
        Supplier supplier = supplierService.findSupplierById(supplierId);
        if (supplier != null && supplier.getStatus()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thế xóa nhà cung cấp đang hoạt động");
            return "redirect:/admin/supplier-mgr/list";
        }
        try {
            supplierService.deleteSupplierById(supplierId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhà cung cấp thành công");
        } catch (SupplierInUseException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/supplier-mgr/list";
    }

}
