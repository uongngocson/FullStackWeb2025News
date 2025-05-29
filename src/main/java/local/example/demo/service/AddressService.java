package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Address;
import local.example.demo.repository.AddressRepository;
//import local.example.demo.model.entity.Addressv2;
//import local.example.demo.repository.Addressv2Repository;
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

        // Lấy địa chỉ từ bảng mới với thông tin chi tiết
        List<Address> addresses = addressRepository.findByCustomerIdWithDetails(customerId);
        // List<Addressv2> addresses =
        // addressv2Repository.findByCustomerIdWithDetails(customerId);

        StringBuilder result = new StringBuilder();
        result.append("Retrieved ").append(addresses.size()).append(" addresses for customerId ").append(customerId)
                .append(":\n");

        for (Address address : addresses) {
            // for (Addressv2 address : addresses) {
            result.append("\nAddress ID: ").append(address.getAddressId())
                    .append("\nStreet: ").append(address.getStreet())
                    .append("\nWard: ").append(address.getWard() != null ? address.getWard().getWardName() : "N/A")
                    .append("\nDistrict: ")
                    .append(address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A")
                    .append("\nProvince: ")
                    .append(address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A")
                    .append("\nCountry: ").append(address.getCountry())
                    .append("\n-----------------------");

            log.info("Address found: ID={}, Street={}, Ward={}, District={}, Province={}, Country={}",
                    address.getAddressId(),
                    address.getStreet(),
                    address.getWard() != null ? address.getWard().getWardName() : "N/A",
                    address.getDistrict() != null ? address.getDistrict().getDistrictName() : "N/A",
                    address.getProvince() != null ? address.getProvince().getProvinceName() : "N/A",
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

    // public List<Addressv2> getAddressesv2ForCustomer(Integer customerId) {
    // log.info("Retrieving addressesv2 for customerId: {}", customerId);
    // return addressv2Repository.findByCustomerIdWithDetails(customerId);
    // }

}
