package local.example.demo.controller.client;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import local.example.demo.model.dto.GiaohangnhanhDTO;
import local.example.demo.service.GiaohangnhanhService;

@Controller
public class GiaohangnhanhController {
    
    @Autowired
    private GiaohangnhanhService giaohangnhanhService;
    
    /**
     * Setup model with GHN data for any checkout page
     * @param model Spring UI model
     */
    private void setupOrderPageModel(Model model) {
        try {
            // Lấy danh sách tỉnh/thành phố từ GHN API
            List<Map<String, Object>> provinces = giaohangnhanhService.getProvinces();
            
            // Chuyển đổi dữ liệu để sử dụng trong JSP
            List<GiaohangnhanhDTO> provinceList = GiaohangnhanhDTO.fromMapList(provinces);
            
            // Thêm dữ liệu vào model để JSP có thể truy cập
            model.addAttribute("provinces", provinceList);
            model.addAttribute("ghnToken", giaohangnhanhService.getGhnToken());
            model.addAttribute("shopId", giaohangnhanhService.getShopId());
            
            // Mặc định cài đặt gói hàng
            model.addAttribute("defaultPackage", GiaohangnhanhDTO.createDefaultPackage());
            
            System.out.println("Provinces loaded: " + provinceList.size());
        } catch (Exception e) {
            System.out.println("Error loading checkout page: " + e.getMessage());
            e.printStackTrace();
            
            // Add error message to model
            model.addAttribute("errorMessage", "Could not load shipping data. Please try again later.");
        }
    }
    
    /**
     * Hiển thị trang order với dữ liệu GHN - Endpoint trực tiếp (/orderfix)
     */
    // @GetMapping("/orderfix")
    // public String showOrderPage(Model model) {
    //     setupOrderPageModel(model);
    //     return "client/user/orderfix";
    // }
    
    /**
     * Endpoint for "/order/orderfix" (moved from OrderFixController)
     */
    @GetMapping("/order/orderfix")
    public String getOrderFixPage(Model model) {
        setupOrderPageModel(model);
        return "client/user/orderfix";
    }
    
    /**
     * Hiển thị trang order với dữ liệu GHN - API endpoint
     */
    @GetMapping("/api/ghn/checkout")
    public String showCheckoutPage(Model model) {
        setupOrderPageModel(model);
        return "client/user/orderfix";
    }
    
    /**
     * API endpoint để lấy danh sách tỉnh/thành phố
     */
    @GetMapping("/api/ghn/provinces")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getProvinces() {
        try {
            List<Map<String, Object>> provinces = giaohangnhanhService.getProvinces();
            Map<String, Object> response = new HashMap<>();
            response.put("provinces", provinces);
            response.put("success", true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load provinces: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy danh sách quận/huyện theo provinceId
     */
    @GetMapping("/api/ghn/districts/{provinceId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getDistricts(@PathVariable int provinceId) {
        try {
            System.out.println("Getting districts for province: " + provinceId);
            List<Map<String, Object>> districts = giaohangnhanhService.getDistricts(provinceId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("districts", districts);
            response.put("success", true);
            
            System.out.println("Found " + districts.size() + " districts");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load districts: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy danh sách phường/xã theo districtId
     */
    @GetMapping("/api/ghn/wards/{districtId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getWards(@PathVariable int districtId) {
        try {
            System.out.println("Getting wards for district: " + districtId);
            List<Map<String, Object>> wards = giaohangnhanhService.getWards(districtId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("wards", wards);
            response.put("success", true);
            
            System.out.println("Found " + wards.size() + " wards");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load wards: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để lấy dịch vụ vận chuyển có sẵn
     */
    @GetMapping("/api/ghn/services/{fromDistrictId}/{toDistrictId}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getAvailableServices(
            @PathVariable int fromDistrictId,
            @PathVariable int toDistrictId) {
        try {
            List<Map<String, Object>> services = giaohangnhanhService.getAvailableServices(fromDistrictId, toDistrictId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("services", services);
            response.put("success", true);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to load shipping services: " + e.getMessage());
            return ResponseEntity.ok(errorResponse);
        }
    }
    
    /**
     * API endpoint để tính phí vận chuyển
     */
    @PostMapping("/api/ghn/shipping-fee")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> calculateShippingFee(@RequestBody Map<String, Object> requestData) {
        try {
            Map<String, Object> shippingFee = giaohangnhanhService.calculateShippingFee(requestData);
            
            Map<String, Object> response = new HashMap<>();
            response.put("shippingFee", shippingFee);
            response.put("success", true);
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Failed to calculate shipping fee: " + e.getMessage());
            // In chi tiết lỗi ra console để gỡ lỗi
            System.out.println("Error calculating shipping fee: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.ok(errorResponse);
        }
    }
}
