/**
 * GHN Shipping API Integration for Luxury Boutique
 * This file contains functions to interact with GHN API through our Java backend
 */

// Initialize GHN state
let ghnState = {
    loading: false,
    provinces: [],
    districts: [],
    wards: [],
    selectedFromDistrict: 1454, // Default: Go Vap District in HCMC
    selectedToProvince: null,
    selectedToDistrict: null,
    selectedToWard: null,
    selectedService: 53320, // Default standard service
    packageDetails: {
        weight: 500, // 500g
        length: 20,
        width: 15,
        height: 15,
        insurance_value: 500000
    },
    shippingFeeValue: null
};

// DOM Elements
const provinceSelect = document.getElementById('province');
const districtSelect = document.getElementById('district');
const wardSelect = document.getElementById('ward');
const addressDetail = document.getElementById('addressDetail');
const addressPreview = document.getElementById('addressPreview');
const fullAddress = document.getElementById('fullAddress');
const shippingCostSummary = document.getElementById('shipping-cost-summary');
const shippingFeeContainer = document.getElementById('shipping-fee-container');

/**
 * Show notification to user
 * @param {string} message - Message to display
 * @param {string} type - Type of notification (success, error, info)
 */
function showNotification(message, type = 'success') {
    // Create notification element
    const notification = document.createElement('div');
    notification.style.position = 'fixed';
    notification.style.top = '20px';
    notification.style.right = '20px';
    notification.style.padding = '15px';
    notification.style.borderRadius = '8px';
    notification.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    notification.style.zIndex = '9999';
    
    // Set styling based on type
    if (type === 'success') {
        notification.style.background = '#d1fae5';
        notification.style.border = '1px solid #10b981';
    } else if (type === 'error') {
        notification.style.background = '#fee2e2';
        notification.style.border = '1px solid #ef4444';
    } else {
        notification.style.background = '#e0f2fe';
        notification.style.border = '1px solid #3b82f6';
    }
    
    notification.innerHTML = `<p style="margin: 0; font-weight: bold;">${message}</p>`;
    
    document.body.appendChild(notification);
    
    // Remove notification after 4 seconds
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transition = 'opacity 0.5s ease';
        setTimeout(() => notification.remove(), 500);
    }, 4000);
}

/**
 * Initialize GHN integration
 * @param {string} token - GHN API token
 * @param {string} shopId - GHN Shop ID
 */
function initGHNIntegration(token, shopId) {
    // Store token and shop ID
    ghnState.token = token;
    ghnState.shopId = shopId;
    
    // Set up event listeners
    if (provinceSelect) {
        provinceSelect.addEventListener('change', handleProvinceChange);
    }
    
    if (districtSelect) {
        districtSelect.addEventListener('change', handleDistrictChange);
    }
    
    if (wardSelect) {
        wardSelect.addEventListener('change', handleWardChange);
    }
    
    if (addressDetail) {
        addressDetail.addEventListener('input', updateAddressPreview);
    }
    
    console.log('GHN integration initialized with token and shop ID');
}

/**
 * Handle province selection change
 */
function handleProvinceChange() {
    const selectedProvinceId = provinceSelect.value;
    
    // Reset district and ward
    districtSelect.innerHTML = '<option value="">Select District</option>';
    wardSelect.innerHTML = '<option value="">Select Ward</option>';
    districtSelect.disabled = !selectedProvinceId;
    wardSelect.disabled = true;
    
    // Update GHN state
    ghnState.selectedToProvince = selectedProvinceId ? parseInt(selectedProvinceId) : null;
    ghnState.selectedToDistrict = null;
    ghnState.selectedToWard = null;
    
    if (selectedProvinceId) {
        // Show loading state
        districtSelect.classList.add('loading');
        
        // Fetch districts from our controller
        fetch(`/api/ghn/districts/${selectedProvinceId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                districtSelect.classList.remove('loading');
                console.log('Districts data:', data);
                
                if (data.success && data.districts && data.districts.length > 0) {
                    // Store districts in state
                    ghnState.districts = data.districts;
                    
                    // Populate select options
                    data.districts.forEach(district => {
                        const option = document.createElement('option');
                        option.value = district.DistrictID;
                        option.textContent = district.DistrictName;
                        districtSelect.appendChild(option);
                    });
                    
                    districtSelect.disabled = false;
                } else {
                    const errorMsg = data.message || 'No districts found in response data';
                    console.error(errorMsg);
                    showNotification('Could not load district data', 'error');
                }
            })
            .catch(error => {
                console.error('Error fetching districts:', error);
                districtSelect.classList.remove('loading');
                showNotification('Error loading districts', 'error');
                
                // Show an error message
                const option = document.createElement('option');
                option.value = "";
                option.textContent = "Error loading districts";
                districtSelect.innerHTML = '';
                districtSelect.appendChild(option);
                districtSelect.disabled = false;
            });
    }
    
    updateAddressPreview();
}

/**
 * Handle district selection change
 */
function handleDistrictChange() {
    const selectedDistrictId = districtSelect.value;
    
    // Reset ward
    wardSelect.innerHTML = '<option value="">Select Ward</option>';
    wardSelect.disabled = true;
    
    // Update GHN state
    ghnState.selectedToDistrict = selectedDistrictId ? parseInt(selectedDistrictId) : null;
    ghnState.selectedToWard = null;
    
    if (selectedDistrictId) {
        // Show loading state
        wardSelect.classList.add('loading');
        
        // Fetch wards from our controller
        fetch(`/api/ghn/wards/${selectedDistrictId}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                wardSelect.classList.remove('loading');
                console.log('Wards data:', data);
                
                if (data.success && data.wards && data.wards.length > 0) {
                    // Store wards in state
                    ghnState.wards = data.wards;
                    
                    // Populate select options
                    data.wards.forEach(ward => {
                        const option = document.createElement('option');
                        option.value = ward.WardCode;
                        option.textContent = ward.WardName;
                        wardSelect.appendChild(option);
                    });
                    
                    wardSelect.disabled = false;
                } else {
                    const errorMsg = data.message || 'No wards found in response data';
                    console.error(errorMsg);
                    showNotification('Could not load ward data', 'error');
                }
            })
            .catch(error => {
                console.error('Error fetching wards:', error);
                wardSelect.classList.remove('loading');
                showNotification('Error loading wards', 'error');
                
                // Show an error message
                const option = document.createElement('option');
                option.value = "";
                option.textContent = "Error loading wards";
                wardSelect.innerHTML = '';
                wardSelect.appendChild(option);
                wardSelect.disabled = false;
            });
    }
    
    updateAddressPreview();
}

/**
 * Handle ward selection change
 */
function handleWardChange() {
    const selectedWardCode = wardSelect.value;
    
    // Update GHN state
    ghnState.selectedToWard = selectedWardCode || null;
    
    updateAddressPreview();
}

/**
 * Update address preview based on selected location
 */
function updateAddressPreview() {
    const detail = addressDetail ? addressDetail.value.trim() : '';
    const provinceId = provinceSelect ? provinceSelect.value : '';
    const districtId = districtSelect ? districtSelect.value : '';
    const wardCode = wardSelect ? wardSelect.value : '';

    if (detail || provinceId || districtId || wardCode) {
        let addressParts = [];
        
        if (detail) addressParts.push(detail);
        
        if (wardCode) {
            const wardName = wardSelect.options[wardSelect.selectedIndex]?.text;
            if (wardName && wardName !== 'Select Ward') addressParts.push(wardName);
        }
        
        if (districtId) {
            const districtName = districtSelect.options[districtSelect.selectedIndex]?.text;
            if (districtName && districtName !== 'Select District') addressParts.push(districtName);
        }
        
        if (provinceId) {
            const provinceName = provinceSelect.options[provinceSelect.selectedIndex]?.text;
            if (provinceName && provinceName !== 'Select Province') addressParts.push(provinceName);
        }

        if (addressParts.length > 0 && fullAddress) {
            fullAddress.textContent = addressParts.join(', ');
            if (addressPreview) addressPreview.classList.remove('hidden');
            
            // If we have complete address information, calculate shipping fee
            if (provinceId && districtId && wardCode) {
                calculateShippingFee(districtId, wardCode);
            }
        } else if (addressPreview) {
            addressPreview.classList.add('hidden');
        }
    } else if (addressPreview) {
        addressPreview.classList.add('hidden');
    }
}

/**
 * Calculate shipping fee using GHN API
 * @param {string} toDistrictId - Destination district ID
 * @param {string} toWardCode - Destination ward code
 */
function calculateShippingFee(toDistrictId, toWardCode) {
    // Default from district: Go Vap, Ho Chi Minh City
    const fromDistrictId = ghnState.selectedFromDistrict;
    
    // Show loading for shipping calculation
    if (shippingCostSummary) {
        shippingCostSummary.textContent = 'Calculating...';
        shippingCostSummary.classList.add('pulse-animation');
    }
    
    // Trước khi tính phí, kiểm tra dịch vụ vận chuyển có sẵn
    fetch(`/api/ghn/services/${fromDistrictId}/${toDistrictId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success && data.services && data.services.length > 0) {
                console.log("Available services:", data.services);
                
                // Tìm dịch vụ phù hợp nhất
                let selectedService = null;
                
                // Tìm dịch vụ có từ khóa "value", "tiết kiệm" hoặc "chuẩn"
                selectedService = data.services.find(s => {
                    const serviceName = s.service_name || '';
                    return serviceName.toLowerCase().includes('value') ||
                        serviceName.toLowerCase().includes('tiết kiệm') ||
                        serviceName.toLowerCase().includes('chuẩn');
                });
                
                // Nếu không tìm thấy, sử dụng dịch vụ đầu tiên
                if (!selectedService && data.services.length > 0) {
                    selectedService = data.services[0];
                }
                
                if (selectedService) {
                    console.log(`Chọn dịch vụ: ${selectedService.service_name} (ID: ${selectedService.service_id})`);
                    ghnState.selectedService = selectedService.service_id;
                    
                    // Cập nhật thông tin dịch vụ được hiển thị
                    const serviceNameElement = document.getElementById('shipping-service-name');
                    if (serviceNameElement) {
                        serviceNameElement.textContent = selectedService.service_name || 'Standard';
                    }
                    
                    // Tiếp tục tính phí vận chuyển với dịch vụ đã chọn
                    performShippingCalculation(fromDistrictId, toDistrictId, toWardCode);
                } else {
                    if (shippingCostSummary) {
                        shippingCostSummary.classList.remove('pulse-animation');
                        shippingCostSummary.textContent = 'Not available';
                    }
                    showNotification('Không có dịch vụ vận chuyển khả dụng cho tuyến đường này', 'error');
                }
            } else {
                if (shippingCostSummary) {
                    shippingCostSummary.classList.remove('pulse-animation');
                    shippingCostSummary.textContent = 'Not available';
                }
                showNotification('Không thể tải dịch vụ vận chuyển', 'error');
            }
        })
        .catch(error => {
            console.error('Error fetching shipping services:', error);
            if (shippingCostSummary) {
                shippingCostSummary.classList.remove('pulse-animation');
                shippingCostSummary.textContent = 'Error';
            }
            showNotification('Lỗi khi tải dịch vụ vận chuyển', 'error');
        });
}

/**
 * Thực hiện tính phí vận chuyển với service_id đã chọn
 */
function performShippingCalculation(fromDistrictId, toDistrictId, toWardCode) {
    // Prepare request data
    const requestData = {
        from_district_id: parseInt(fromDistrictId),
        service_id: parseInt(ghnState.selectedService),
        to_district_id: parseInt(toDistrictId),
        to_ward_code: toWardCode,
        height: parseInt(ghnState.packageDetails.height),
        length: parseInt(ghnState.packageDetails.length),
        weight: parseInt(ghnState.packageDetails.weight),
        width: parseInt(ghnState.packageDetails.width),
        insurance_value: parseInt(ghnState.packageDetails.insurance_value),
        coupon: null
    };
    
    // Call our controller to calculate shipping fee
    fetch('/api/ghn/shipping-fee', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(requestData)
    })
    .then(response => response.json())
    .then(data => {
        if (shippingCostSummary) {
            shippingCostSummary.classList.remove('pulse-animation');
            
            if (data.success && data.shippingFee && data.shippingFee.total) {
                // Convert to USD for display (assuming 23,000 VND = 1 USD)
                const shippingFeeVND = data.shippingFee.total;
                const shippingFeeUSD = (shippingFeeVND / 23000).toFixed(2);
                
                shippingCostSummary.textContent = '$' + shippingFeeUSD;
                
                // Store the shipping fee for later use
                ghnState.shippingFeeValue = parseFloat(shippingFeeUSD);
                
                // Update the order total if function exists
                if (typeof updatePricing === 'function') {
                    updatePricing();
                }
                
                // Show shipping fee container if it exists
                if (shippingFeeContainer) {
                    shippingFeeContainer.classList.remove('hidden');
                    const deliveryTimeElement = document.getElementById('shipping-delivery-time');
                    if (deliveryTimeElement) {
                        deliveryTimeElement.textContent = '2-3 days';
                    }
                }
                
                // Show notification
                showShippingFeeNotification(shippingFeeUSD);
            } else {
                shippingCostSummary.textContent = 'Not available';
                const errorMsg = data.message || 'Could not calculate shipping fee';
                showNotification(errorMsg, 'error');
            }
        }
    })
    .catch(error => {
        console.error('Error calculating shipping fee:', error);
        if (shippingCostSummary) {
            shippingCostSummary.classList.remove('pulse-animation');
            shippingCostSummary.textContent = 'Error';
        }
        showNotification('Error calculating shipping fee', 'error');
    });
}

/**
 * Show a notification with shipping fee
 * @param {string} shippingFeeUSD - Shipping fee in USD
 */
function showShippingFeeNotification(shippingFeeUSD) {
    showNotification(`Shipping fee calculated: $${shippingFeeUSD} USD`, 'success');
}

/**
 * Update pricing with shipping fee
 * This function is called after shipping fee calculation
 */
function updatePricing() {
    if (!window.updatePricing) {
        const subtotal = 498.00;
        const shipping = ghnState.shippingFeeValue || 15.00;
        
        // Get VAT status from the UI - assuming the buttons exist
        const vatBtn = document.getElementById('vatBtn');
        const hasVat = vatBtn && vatBtn.classList.contains('active');
        
        const tax = hasVat ? subtotal * 0.08 : 0;
        
        // Calculate discount if present
        const discountAmount = document.getElementById('discount-amount');
        const discount = discountAmount ? 
            parseFloat(discountAmount.textContent.replace(/[^\d.-]/g, '')) || 0 : 0;
        
        const total = subtotal + shipping + tax - discount;
        
        // Update UI
        const subtotalElement = document.getElementById('cart-subtotal');
        const taxElement = document.getElementById('tax-amount');
        const totalElement = document.getElementById('total-with-discount');
        
        if (subtotalElement) subtotalElement.textContent = '$' + subtotal.toFixed(2);
        if (shippingCostSummary) shippingCostSummary.textContent = '$' + shipping.toFixed(2);
        if (taxElement) taxElement.textContent = '$' + tax.toFixed(2);
        if (totalElement) totalElement.textContent = '$' + total.toFixed(2);
    }
}

// Export functions for global use
window.ghnState = ghnState;
window.initGHNIntegration = initGHNIntegration;
window.calculateShippingFee = calculateShippingFee;
window.updateAddressPreview = updateAddressPreview; 