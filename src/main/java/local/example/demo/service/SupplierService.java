package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.exception.SupplierInUseException;
import local.example.demo.model.entity.Supplier;
import local.example.demo.repository.ProductRepository;
import local.example.demo.repository.SupplierRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
@Transactional(readOnly = true)
public class SupplierService {
    private final SupplierRepository supplierRepository;
    private final ProductRepository productRepository;

    public List<Supplier> findAllSuppliers() {
        return supplierRepository.findAll();
    }

    public Supplier findSupplierById(Integer supplierId) {
        return supplierRepository.findById(supplierId).orElse(null);
    }

    // save supplier
    @Transactional
    public void saveSupplier(Supplier supplier) {
        supplierRepository.save(supplier);
    }

    // delete supplier by id
    @Transactional(rollbackFor = { SupplierInUseException.class, RuntimeException.class })
    public void deleteSupplierById(Integer supplierId) {
        Supplier supplier = supplierRepository.findById(supplierId).orElse(null);
        if (supplier == null) {
            throw new RuntimeException("Không tìm thấy nhà cung cấp với ID: " + supplierId);
        }
        if (productRepository.existsBySupplier(supplier)) {
            // Nếu có sản phẩm thuộc nhà cung cấp này, không cho phép xóa
            throw new SupplierInUseException("Không thể xóa nhà cung cấp '" + supplier.getSupplierName()
                    + "' vì có sản phẩm thuộc nhà cung cấp này.");
        }
        supplierRepository.deleteById(supplierId);
    }

    public boolean existingNameSupplier(String name) {
        return supplierRepository.existsBySupplierName(name);
    }

    public Supplier findSupplierByName(String name) {
        return supplierRepository.findBySupplierName(name);
    }
}
