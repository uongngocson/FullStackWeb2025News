package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Address;
import local.example.demo.repository.AddressRepository;
// import local.example.demo.model.entity.Addressv2;
// import local.example.demo.repository.Addressv2Repository;
import local.example.demo.service.CustomerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class AddressService {

    private final CustomerService customerService;
    private final AddressRepository addressRepository;
    // private final Addressv2Repository addressv2Repository;

    public String getFormattedAddressesForCustomer(Integer customerId) {
        log.info("Retrieving addresses for customerId: {}", customerId);

        // Lấy địa chỉ từ repository
        List<Address> addresses = addressRepository.findByCustomerCustomerId(customerId);

        StringBuilder result = new StringBuilder();
        result.append("Retrieved ").append(addresses.size()).append(" addresses for customerId ").append(customerId)
                .append(":\n");

        for (Address address : addresses) {
            result.append("\nAddress ID: ").append(address.getAddressId())
                    .append("\nStreet: ").append(address.getStreet())
                    .append("\nWard: ")
                    .append(address.getGhnWard() != null ? address.getGhnWard().getWardName() : address.getWard())
                    .append("\nDistrict: ")
                    .append(address.getGhnDistrict() != null ? address.getGhnDistrict().getDistrictName()
                            : address.getDistrict())
                    .append("\nProvince: ")
                    .append(address.getGhnProvince() != null ? address.getGhnProvince().getProvinceName()
                            : address.getProvince())
                    .append("\nCountry: ").append(address.getCountry())
                    .append("\n-----------------------");

            log.info("Address found: ID={}, Street={}, Ward={}, District={}, Province={}, Country={}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getGhnWard() != null ? address.getGhnWard().getWardName() : address.getWard(),
                    address.getGhnDistrict() != null ? address.getGhnDistrict().getDistrictName()
                            : address.getDistrict(),
                    address.getGhnProvince() != null ? address.getGhnProvince().getProvinceName()
                            : address.getProvince(),
                    address.getCountry());
        }

        if (addresses.isEmpty()) {
            log.info("No addresses found for customerId: {}", customerId);
        }

        return result.toString();
    }

    public List<Address> getAddressesForCustomer(Integer customerId) {
        log.info("Retrieving addresses for customerId: {}", customerId);
        return customerService.findAddressesByCustomerId(customerId);
    }

    /**
     * Phương thức tương thích với Addressv2 cũ nhưng sử dụng Address mới
     * 
     * @param customerId The ID of the customer
     * @return List of addresses for the customer
     */
    public List<Address> getAddressesv2ForCustomer(Integer customerId) {
        log.info("Retrieving addresses for customerId (compatibility method): {}", customerId);
        return addressRepository.findByCustomerCustomerId(customerId);
    }
}
