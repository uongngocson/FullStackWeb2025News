package local.example.demo.model.dto;

import java.util.List;
import java.util.Map;

public class GiaohangnhanhDTO {
    
    // Province data
    private Integer provinceId;
    private String provinceName;
    
    // District data
    private Integer districtId;
    private String districtName;
    
    // Ward data
    private String wardCode;
    private String wardName;
    
    // Shipping fee data
    private Long total;
    private Long serviceId;
    private String serviceName;
    
    // Package data
    private Integer weight;
    private Integer length;
    private Integer width;
    private Integer height;
    private Long insuranceValue;
    
    // Constants for mapping
    public static final String PROVINCE_ID = "ProvinceID";
    public static final String PROVINCE_NAME = "ProvinceName";
    public static final String DISTRICT_ID = "DistrictID";
    public static final String DISTRICT_NAME = "DistrictName";
    public static final String WARD_CODE = "WardCode";
    public static final String WARD_NAME = "WardName";
    public static final String SERVICE_ID = "service_id";
    public static final String SERVICE_NAME = "service_name";
    
    // Empty constructor
    public GiaohangnhanhDTO() {
    }
    
    // Constructor from Map
    @SuppressWarnings("unchecked")
    public GiaohangnhanhDTO(Map<String, Object> data) {
        if (data.containsKey(PROVINCE_ID)) {
            this.provinceId = ((Number) data.get(PROVINCE_ID)).intValue();
        }
        
        if (data.containsKey(PROVINCE_NAME)) {
            this.provinceName = (String) data.get(PROVINCE_NAME);
        }
        
        if (data.containsKey(DISTRICT_ID)) {
            this.districtId = ((Number) data.get(DISTRICT_ID)).intValue();
        }
        
        if (data.containsKey(DISTRICT_NAME)) {
            this.districtName = (String) data.get(DISTRICT_NAME);
        }
        
        if (data.containsKey(WARD_CODE)) {
            this.wardCode = (String) data.get(WARD_CODE);
        }
        
        if (data.containsKey(WARD_NAME)) {
            this.wardName = (String) data.get(WARD_NAME);
        }
        
        if (data.containsKey(SERVICE_ID)) {
            this.serviceId = ((Number) data.get(SERVICE_ID)).longValue();
        }
        
        if (data.containsKey(SERVICE_NAME)) {
            this.serviceName = (String) data.get(SERVICE_NAME);
        }
        
        if (data.containsKey("total")) {
            this.total = ((Number) data.get("total")).longValue();
        }
    }
    
    // Static method to convert List<Map> to List<GiaohangnhanhDTO>
    public static List<GiaohangnhanhDTO> fromMapList(List<Map<String, Object>> dataList) {
        return dataList.stream()
                .map(GiaohangnhanhDTO::new)
                .toList();
    }
    
    // Getters and Setters
    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public Integer getDistrictId() {
        return districtId;
    }

    public void setDistrictId(Integer districtId) {
        this.districtId = districtId;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getWardCode() {
        return wardCode;
    }

    public void setWardCode(String wardCode) {
        this.wardCode = wardCode;
    }

    public String getWardName() {
        return wardName;
    }

    public void setWardName(String wardName) {
        this.wardName = wardName;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public Long getInsuranceValue() {
        return insuranceValue;
    }

    public void setInsuranceValue(Long insuranceValue) {
        this.insuranceValue = insuranceValue;
    }
    
    // Default package settings
    public static GiaohangnhanhDTO createDefaultPackage() {
        GiaohangnhanhDTO dto = new GiaohangnhanhDTO();
        dto.setWeight(500); // 500g
        dto.setLength(20);
        dto.setWidth(15);
        dto.setHeight(15);
        dto.setInsuranceValue(500000L);
        return dto;
    }
    
    @Override
    public String toString() {
        return "GiaohangnhanhDTO [provinceId=" + provinceId + ", provinceName=" + provinceName + ", districtId="
                + districtId + ", districtName=" + districtName + ", wardCode=" + wardCode + ", wardName=" + wardName
                + ", total=" + total + ", serviceId=" + serviceId + ", serviceName=" + serviceName + "]";
    }
}
