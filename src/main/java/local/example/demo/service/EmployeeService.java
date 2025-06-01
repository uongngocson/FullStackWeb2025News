package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import local.example.demo.exception.EmployeeInUseException;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Employee;

import local.example.demo.repository.EmployeeRepository;
import local.example.demo.repository.PurchaseReceiptRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
@Transactional(readOnly = true)
public class EmployeeService {
    private final EmployeeRepository employeeRepository;
    private final PurchaseReceiptRepository purchaseReceiptRepository;

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    public Employee getEmployeeById(Integer id) {
        return employeeRepository.findByEmployeeId(id);
    }

    @Transactional
    public Employee saveEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    @Transactional(rollbackFor = { EmployeeInUseException.class })
    public void deleteEmployee(Integer id) {
        if (purchaseReceiptRepository.existsByEmployee(employeeRepository.findByEmployeeId(id))) {
            throw new EmployeeInUseException("Nhân viên này đã tạo phiếu nhập, Không thể xóa.");
        }
        employeeRepository.deleteById(id);
    }

    public Employee getEmployeeByAccount(Account account) {
        return employeeRepository.findByAccount(account);
    }
}
