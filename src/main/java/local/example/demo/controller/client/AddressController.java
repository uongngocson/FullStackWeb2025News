// package local.example.demo.controller.client;

// import java.util.List;

// import org.springframework.http.ResponseEntity;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RestController;

// import local.example.demo.model.entity.Address;
// import local.example.demo.service.AddressService;
// import lombok.RequiredArgsConstructor;

// @RestController
// @RequestMapping("/api/addresses")
// @RequiredArgsConstructor
// public class AddressController {

// private final AddressService addressService;

// @GetMapping("/customer/{customerId}")
// public ResponseEntity<List<Address>> getAddressesByCustomerId(@PathVariable
// Integer customerId) {
// List<Address> addresses = addressService.getAddressesForCustomer(customerId);
// return ResponseEntity.ok(addresses);
// }

// @GetMapping("/customer/{customerId}/formatted")
// public ResponseEntity<String> getFormattedAddressesByCustomerId(@PathVariable
// Integer customerId) {
// String formattedAddresses =
// addressService.getFormattedAddressesForCustomer(customerId);
// return ResponseEntity.ok(formattedAddresses);
// }

// @GetMapping("/view")
// public String viewAddresses(Model model) {
// // ID khách hàng cần truy vấn
// Integer customerId = 1017;
// List<Address> addresses = addressService.getAddressesForCustomer(customerId);
// // Truyền danh sách địa chỉ trực tiếp đến view
// model.addAttribute("addressesV2", addresses);

// // Format địa chỉ để hiển thị trong viewa
// String formattedAddresses = formatAddressesForView(addresses);
// model.addAttribute("formattedAddressesV2", formattedAddresses);

// // Trả về tên của view template
// return "customer/addresses-v2";
// }

// private String formatAddressesForView(List<Address> addresses) {
// StringBuilder formattedAddresses = new StringBuilder();

// for (Address address : addresses) {
// formattedAddresses.append(String.format(
// "Địa chỉ ID: %d, Đường: %s, Phường/Xã: %s, Quận/Huyện: %s, Tỉnh/Thành: %s,
// Quốc gia: %s<br>",
// address.getAddressId(),
// address.getStreet(),
// address.getWard() != null ? address.getWard().getWardName() : "N/A",
// address.getDistrict() != null ? address.getDistrict().getDistrictName() :
// "N/A",
// address.getProvince() != null ? address.getProvince().getProvinceName() :
// "N/A",
// address.getCountry()));
// }

// return formattedAddresses.toString();
// }
// }
