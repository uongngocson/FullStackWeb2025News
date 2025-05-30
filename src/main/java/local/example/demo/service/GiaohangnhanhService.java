package local.example.demo.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class GiaohangnhanhService {
    
    private static final String GHN_TOKEN = "a00c1fc5-2454-11f0-8c8d-faf19a0e6e5b";
    private static final String SHOP_ID = "5754757";
    private static final String GHN_API_BASE = "https://online-gateway.ghn.vn/shiip/public-api";
    
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    
    public GiaohangnhanhService() {
        this.restTemplate = new RestTemplate();
        this.objectMapper = new ObjectMapper();
    }
    
    /**
     * Lấy danh sách tỉnh/thành phố từ GHN API
     */
    public List<Map<String, Object>> getProvinces() {
        try {
            HttpHeaders headers = createHeaders();
            HttpEntity<String> entity = new HttpEntity<>(headers);
            
            System.out.println("Calling GHN API to get provinces");
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/master-data/province",
                HttpMethod.GET,
                entity,
                String.class
            );
            
            return parseResponseData(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    /**
     * Lấy danh sách quận/huyện từ GHN API theo provinceId
     */
    public List<Map<String, Object>> getDistricts(int provinceId) {
        try {
            HttpHeaders headers = createHeaders();
            
            // Create a request body for the district API
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("province_id", provinceId);
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            
            System.out.println("Calling GHN API to get districts for province: " + provinceId);
            System.out.println("Request URL: " + GHN_API_BASE + "/master-data/district");
            
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/master-data/district",
                HttpMethod.POST,
                entity,
                String.class
            );
            
            System.out.println("District API Response: " + response.getStatusCode());
            return parseResponseData(response.getBody());
        } catch (Exception e) {
            System.out.println("Error fetching districts: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    /**
     * Lấy danh sách phường/xã từ GHN API theo districtId
     */
    public List<Map<String, Object>> getWards(int districtId) {
        try {
            HttpHeaders headers = createHeaders();
            
            // Create a request body for the ward API
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("district_id", districtId);
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            
            System.out.println("Calling GHN API to get wards for district: " + districtId);
            
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/master-data/ward",
                HttpMethod.POST,
                entity,
                String.class
            );
            
            return parseResponseData(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    /**
     * Lấy dịch vụ vận chuyển có sẵn
     */
    public List<Map<String, Object>> getAvailableServices(int fromDistrictId, int toDistrictId) {
        try {
            HttpHeaders headers = createHeaders();
            HttpEntity<String> entity = new HttpEntity<>(headers);
            
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/v2/shipping-order/available-services?shop_id=" + SHOP_ID +
                "&from_district=" + fromDistrictId + "&to_district=" + toDistrictId,
                HttpMethod.GET,
                entity,
                String.class
            );
            
            return parseResponseData(response.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    /**
     * Tính phí vận chuyển
     */
    public Map<String, Object> calculateShippingFee(Map<String, Object> requestData) {
        try {
            // Trước khi tính phí, kiểm tra xem service_id có tồn tại cho tuyến đường này không
            Integer fromDistrictId = Integer.parseInt(requestData.get("from_district_id").toString());
            Integer toDistrictId = Integer.parseInt(requestData.get("to_district_id").toString());
            Integer requestedServiceId = Integer.parseInt(requestData.get("service_id").toString());
            
            // Lấy danh sách dịch vụ có sẵn cho tuyến đường này
            List<Map<String, Object>> availableServices = getAvailableServices(fromDistrictId, toDistrictId);
            
            // Kiểm tra xem service_id được yêu cầu có nằm trong danh sách dịch vụ có sẵn không
            boolean serviceAvailable = false;
            Integer firstAvailableServiceId = null;
            
            for (Map<String, Object> service : availableServices) {
                Integer serviceId = (Integer) service.get("service_id");
                if (serviceId != null) {
                    if (firstAvailableServiceId == null) {
                        firstAvailableServiceId = serviceId;
                    }
                    
                    if (serviceId.equals(requestedServiceId)) {
                        serviceAvailable = true;
                        break;
                    }
                }
            }
            
            // Nếu service_id không có sẵn, sử dụng dịch vụ đầu tiên có sẵn (nếu có)
            if (!serviceAvailable && firstAvailableServiceId != null) {
                System.out.println("Service ID " + requestedServiceId + " không có sẵn cho tuyến đường này. Thay thế bằng service ID: " + firstAvailableServiceId);
                requestData.put("service_id", firstAvailableServiceId);
            } else if (!serviceAvailable) {
                throw new RuntimeException("Không có dịch vụ vận chuyển nào khả dụng cho tuyến đường này");
            }
            
            HttpHeaders headers = createHeaders();
            headers.add("ShopId", SHOP_ID);
            headers.add("Content-Type", "application/json");
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestData, headers);
            
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/v2/shipping-order/fee",
                HttpMethod.POST,
                entity,
                String.class
            );
            
            List<Map<String, Object>> dataList = parseResponseData(response.getBody());
            return dataList.isEmpty() ? new HashMap<>() : dataList.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }
    
    /**
     * Hủy đơn hàng
     */
    public Map<String, Object> cancelOrder(String orderCode) {
        try {
            HttpHeaders headers = createHeaders();
            
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("order_codes", new String[] { orderCode });
            
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            
            ResponseEntity<String> response = restTemplate.exchange(
                GHN_API_BASE + "/v2/switch-status/cancel",
                HttpMethod.POST,
                entity,
                String.class
            );
            
            List<Map<String, Object>> dataList = parseResponseData(response.getBody());
            return dataList.isEmpty() ? new HashMap<>() : dataList.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }
    
    /**
     * Tạo HTTP headers với GHN token
     */
    private HttpHeaders createHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Token", GHN_TOKEN);
        return headers;
    }
    
    /**
     * Parse response JSON to List of Maps
     */
    private List<Map<String, Object>> parseResponseData(String responseBody) {
        List<Map<String, Object>> result = new ArrayList<>();
        try {
            JsonNode rootNode = objectMapper.readTree(responseBody);
            if (rootNode.has("code") && rootNode.get("code").asInt() == 200 && rootNode.has("data")) {
                JsonNode dataNode = rootNode.get("data");
                if (dataNode.isArray()) {
                    for (JsonNode item : dataNode) {
                        result.add(objectMapper.convertValue(item, Map.class));
                    }
                } else {
                    result.add(objectMapper.convertValue(dataNode, Map.class));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public String getShopId() {
        return SHOP_ID;
    }
    
    public String getGhnToken() {
        return GHN_TOKEN;
    }
}
