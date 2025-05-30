package local.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.exception.EmployeeInUseException;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Employee;

import local.example.demo.repository.EmployeeRepository;
import local.example.demo.repository.PurchaseReceiptRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
@Transactional
public class EmployeeService {
    private final EmployeeRepository employeeRepository;
    private final PurchaseReceiptRepository purchaseReceiptRepository;

    // get all employees
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    // get employee by id
    public Employee getEmployeeById(Integer id) {
        return employeeRepository.findByEmployeeId(id);
    }

    // save employee
    public Employee saveEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    // delete employee
    public void deleteEmployee(Integer id) {
        if (purchaseReceiptRepository.existsByEmployee(employeeRepository.findByEmployeeId(id))) {
            throw new EmployeeInUseException("Nhân viên này đã tạo phiếu nhập, Không thể xóa.");
        }
        employeeRepository.deleteById(id);
    }

    // get employee by account
    public Employee getEmployeeByAccount(Account account) {
        return employeeRepository.findByAccount(account);
    }
}
