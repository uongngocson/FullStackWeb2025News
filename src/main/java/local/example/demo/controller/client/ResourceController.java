// package local.example.demo.controller.client;

// import org.springframework.http.MediaType;
// import org.springframework.stereotype.Controller;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.ResponseBody;

// @Controller
// @RequestMapping("/resources")
// public class ResourceController {
    
//     /**
//      * Serve JavaScript files from resources
//      */
//     @GetMapping(value = "/js/{fileName:.+\\.js}", produces = "application/javascript")
//     @ResponseBody
//     public String serveJavaScript(@PathVariable String fileName) {
//         // This would typically read from a file, but for this example we'll return content for ghn-integration.js
//         if ("ghn-integration.js".equals(fileName)) {
//             return getGhnIntegrationJs();
//         }
//         return "// File not found: " + fileName;
//     }
    
//     /**
//      * Get the content of the GHN integration JavaScript file
//      */
//     private String getGhnIntegrationJs() {
//         return "/**\n" +
//                " * GHN Shipping API Integration for Luxury Boutique\n" +
//                " * This file contains functions to interact with GHN API through our Java backend\n" +
//                " */\n\n" +
//                "// Initialize GHN state\n" +
//                "let ghnState = {\n" +
//                "    loading: false,\n" +
//                "    provinces: [],\n" +
//                "    districts: [],\n" +
//                "    wards: [],\n" +
//                "    selectedFromDistrict: 1454, // Default: Go Vap District in HCMC\n" +
//                "    selectedToProvince: null,\n" +
//                "    selectedToDistrict: null,\n" +
//                "    selectedToWard: null,\n" +
//                "    selectedService: 53320, // Default standard service\n" +
//                "    packageDetails: {\n" +
//                "        weight: 500, // 500g\n" +
//                "        length: 20,\n" +
//                "        width: 15,\n" +
//                "        height: 15,\n" +
//                "        insurance_value: 500000\n" +
//                "    },\n" +
//                "    shippingFeeValue: null\n" +
//                "};\n\n" +
//                "// DOM Elements\n" +
//                "const provinceSelect = document.getElementById('province');\n" +
//                "const districtSelect = document.getElementById('district');\n" +
//                "const wardSelect = document.getElementById('ward');\n" +
//                "const addressDetail = document.getElementById('addressDetail');\n" +
//                "const addressPreview = document.getElementById('addressPreview');\n" +
//                "const fullAddress = document.getElementById('fullAddress');\n" +
//                "const shippingCostSummary = document.getElementById('shipping-cost-summary');\n\n" +
//                "/**\n" +
//                " * Initialize GHN integration\n" +
//                " * @param {string} token - GHN API token\n" +
//                " * @param {string} shopId - GHN Shop ID\n" +
//                " */\n" +
//                "function initGHNIntegration(token, shopId) {\n" +
//                "    // Store token and shop ID\n" +
//                "    ghnState.token = token;\n" +
//                "    ghnState.shopId = shopId;\n" +
//                "    \n" +
//                "    // Set up event listeners\n" +
//                "    if (provinceSelect) {\n" +
//                "        provinceSelect.addEventListener('change', handleProvinceChange);\n" +
//                "    }\n" +
//                "    \n" +
//                "    if (districtSelect) {\n" +
//                "        districtSelect.addEventListener('change', handleDistrictChange);\n" +
//                "    }\n" +
//                "    \n" +
//                "    if (wardSelect) {\n" +
//                "        wardSelect.addEventListener('change', handleWardChange);\n" +
//                "    }\n" +
//                "    \n" +
//                "    if (addressDetail) {\n" +
//                "        addressDetail.addEventListener('input', updateAddressPreview);\n" +
//                "    }\n" +
//                "    \n" +
//                "    console.log('GHN integration initialized with token and shop ID');\n" +
//                "}\n\n" +
//                "/**\n" +
//                " * Handle province selection change\n" +
//                " */\n" +
//                "function handleProvinceChange() {\n" +
//                "    const selectedProvinceId = provinceSelect.value;\n" +
//                "    \n" +
//                "    // Reset district and ward\n" +
//                "    districtSelect.innerHTML = '<option value=\"\">Select District</option>';\n" +
//                "    wardSelect.innerHTML = '<option value=\"\">Select Ward</option>';\n" +
//                "    districtSelect.disabled = !selectedProvinceId;\n" +
//                "    wardSelect.disabled = true;\n" +
//                "    \n" +
//                "    // Update GHN state\n" +
//                "    ghnState.selectedToProvince = selectedProvinceId ? parseInt(selectedProvinceId) : null;\n" +
//                "    ghnState.selectedToDistrict = null;\n" +
//                "    ghnState.selectedToWard = null;\n" +
//                "    \n" +
//                "    if (selectedProvinceId) {\n" +
//                "        // Show loading state\n" +
//                "        districtSelect.classList.add('loading');\n" +
//                "        \n" +
//                "        // Fetch districts from our controller\n" +
//                "        fetch(`/api/ghn/districts/${selectedProvinceId}`)\n" +
//                "            .then(response => {\n" +
//                "                if (!response.ok) {\n" +
//                "                    throw new Error('Network response was not ok');\n" +
//                "                }\n" +
//                "                return response.json();\n" +
//                "            })\n" +
//                "            .then(data => {\n" +
//                "                districtSelect.classList.remove('loading');\n" +
//                "                console.log('Districts data:', data);\n" +
//                "                \n" +
//                "                if (data.districts && data.districts.length > 0) {\n" +
//                "                    // Store districts in state\n" +
//                "                    ghnState.districts = data.districts;\n" +
//                "                    \n" +
//                "                    // Populate select options\n" +
//                "                    data.districts.forEach(district => {\n" +
//                "                        const option = document.createElement('option');\n" +
//                "                        option.value = district.DistrictID;\n" +
//                "                        option.textContent = district.DistrictName;\n" +
//                "                        districtSelect.appendChild(option);\n" +
//                "                    });\n" +
//                "                    \n" +
//                "                    districtSelect.disabled = false;\n" +
//                "                } else {\n" +
//                "                    console.error('No districts found in response data');\n" +
//                "                }\n" +
//                "            })\n" +
//                "            .catch(error => {\n" +
//                "                console.error('Error fetching districts:', error);\n" +
//                "                districtSelect.classList.remove('loading');\n" +
//                "                \n" +
//                "                // Show an error message\n" +
//                "                const option = document.createElement('option');\n" +
//                "                option.value = \"\";\n" +
//                "                option.textContent = \"Error loading districts\";\n" +
//                "                districtSelect.innerHTML = '';\n" +
//                "                districtSelect.appendChild(option);\n" +
//                "                districtSelect.disabled = false;\n" +
//                "            });\n" +
//                "    }\n" +
//                "    \n" +
//                "    updateAddressPreview();\n" +
//                "}\n\n" +
//                "/**\n" +
//                " * Handle district selection change\n" +
//                " */\n" +
//                "function handleDistrictChange() {\n" +
//                "    const selectedDistrictId = districtSelect.value;\n" +
//                "    \n" +
//                "    // Reset ward\n" +
//                "    wardSelect.innerHTML = '<option value=\"\">Select Ward</option>';\n" +
//                "    wardSelect.disabled = true;\n" +
//                "    \n" +
//                "    // Update GHN state\n" +
//                "    ghnState.selectedToDistrict = selectedDistrictId ? parseInt(selectedDistrictId) : null;\n" +
//                "    ghnState.selectedToWard = null;\n" +
//                "    \n" +
//                "    if (selectedDistrictId) {\n" +
//                "        // Show loading state\n" +
//                "        wardSelect.classList.add('loading');\n" +
//                "        \n" +
//                "        // Fetch wards from our controller\n" +
//                "        fetch(`/api/ghn/wards/${selectedDistrictId}`)\n" +
//                "            .then(response => {\n" +
//                "                if (!response.ok) {\n" +
//                "                    throw new Error('Network response was not ok');\n" +
//                "                }\n" +
//                "                return response.json();\n" +
//                "            })\n" +
//                "            .then(data => {\n" +
//                "                wardSelect.classList.remove('loading');\n" +
//                "                console.log('Wards data:', data);\n" +
//                "                \n" +
//                "                if (data.wards && data.wards.length > 0) {\n" +
//                "                    // Store wards in state\n" +
//                "                    ghnState.wards = data.wards;\n" +
//                "                    \n" +
//                "                    // Populate select options\n" +
//                "                    data.wards.forEach(ward => {\n" +
//                "                        const option = document.createElement('option');\n" +
//                "                        option.value = ward.WardCode;\n" +
//                "                        option.textContent = ward.WardName;\n" +
//                "                        wardSelect.appendChild(option);\n" +
//                "                    });\n" +
//                "                    \n" +
//                "                    wardSelect.disabled = false;\n" +
//                "                } else {\n" +
//                "                    console.error('No wards found in response data');\n" +
//                "                }\n" +
//                "            })\n" +
//                "            .catch(error => {\n" +
//                "                console.error('Error fetching wards:', error);\n" +
//                "                wardSelect.classList.remove('loading');\n" +
//                "                \n" +
//                "                // Show an error message\n" +
//                "                const option = document.createElement('option');\n" +
//                "                option.value = \"\";\n" +
//                "                option.textContent = \"Error loading wards\";\n" +
//                "                wardSelect.innerHTML = '';\n" +
//                "                wardSelect.appendChild(option);\n" +
//                "                wardSelect.disabled = false;\n" +
//                "            });\n" +
//                "    }\n" +
//                "    \n" +
//                "    updateAddressPreview();\n" +
//                "}\n\n" +
//                "/**\n" +
//                " * Handle ward selection change\n" +
//                " */\n" +
//                "function handleWardChange() {\n" +
//                "    const selectedWardCode = wardSelect.value;\n" +
//                "    \n" +
//                "    // Update GHN state\n" +
//                "    ghnState.selectedToWard = selectedWardCode || null;\n" +
//                "    \n" +
//                "    updateAddressPreview();\n" +
//                "}\n\n" +
//                "/**\n" +
//                " * Update address preview based on selected location\n" +
//                " */\n" +
//                "function updateAddressPreview() {\n" +
//                "    const detail = addressDetail ? addressDetail.value.trim() : '';\n" +
//                "    const provinceId = provinceSelect ? provinceSelect.value : '';\n" +
//                "    const districtId = districtSelect ? districtSelect.value : '';\n" +
//                "    const wardCode = wardSelect ? wardSelect.value : '';\n" +
//                "\n" +
//                "    if (detail || provinceId || districtId || wardCode) {\n" +
//                "        let addressParts = [];\n" +
//                "        \n" +
//                "        if (detail) addressParts.push(detail);\n" +
//                "        \n" +
//                "        if (wardCode) {\n" +
//                "            const wardName = wardSelect.options[wardSelect.selectedIndex]?.text;\n" +
//                "            if (wardName && wardName !== 'Select Ward') addressParts.push(wardName);\n" +
//                "        }\n" +
//                "        \n" +
//                "        if (districtId) {\n" +
//                "            const districtName = districtSelect.options[districtSelect.selectedIndex]?.text;\n" +
//                "            if (districtName && districtName !== 'Select District') addressParts.push(districtName);\n" +
//                "        }\n" +
//                "        \n" +
//                "        if (provinceId) {\n" +
//                "            const provinceName = provinceSelect.options[provinceSelect.selectedIndex]?.text;\n" +
//                "            if (provinceName && provinceName !== 'Select Province') addressParts.push(provinceName);\n" +
//                "        }\n" +
//                "\n" +
//                "        if (addressParts.length > 0 && fullAddress) {\n" +
//                "            fullAddress.textContent = addressParts.join(', ');\n" +
//                "            if (addressPreview) addressPreview.classList.remove('hidden');\n" +
//                "            \n" +
//                "            // If we have complete address information, calculate shipping fee\n" +
//                "            if (provinceId && districtId && wardCode) {\n" +
//                "                calculateShippingFee(districtId, wardCode);\n" +
//                "            }\n" +
//                "        } else if (addressPreview) {\n" +
//                "            addressPreview.classList.add('hidden');\n" +
//                "        }\n" +
//                "    } else if (addressPreview) {\n" +
//                "        addressPreview.classList.add('hidden');\n" +
//                "    }\n" +
//                "}\n\n" +
//                "/**\n" +
//                " * Calculate shipping fee using GHN API\n" +
//                " * @param {string} toDistrictId - Destination district ID\n" +
//                " * @param {string} toWardCode - Destination ward code\n" +
//                " */\n" +
//                "function calculateShippingFee(toDistrictId, toWardCode) {\n" +
//                "    // Default from district: Go Vap, Ho Chi Minh City\n" +
//                "    const fromDistrictId = ghnState.selectedFromDistrict;\n" +
//                "    \n" +
//                "    // Prepare request data\n" +
//                "    const requestData = {\n" +
//                "        from_district_id: parseInt(fromDistrictId),\n" +
//                "        service_id: parseInt(ghnState.selectedService),\n" +
//                "        to_district_id: parseInt(toDistrictId),\n" +
//                "        to_ward_code: toWardCode,\n" +
//                "        height: parseInt(ghnState.packageDetails.height),\n" +
//                "        length: parseInt(ghnState.packageDetails.length),\n" +
//                "        weight: parseInt(ghnState.packageDetails.weight),\n" +
//                "        width: parseInt(ghnState.packageDetails.width),\n" +
//                "        insurance_value: parseInt(ghnState.packageDetails.insurance_value),\n" +
//                "        coupon: null\n" +
//                "    };\n" +
//                "    \n" +
//                "    // Show loading for shipping calculation\n" +
//                "    if (shippingCostSummary) {\n" +
//                "        shippingCostSummary.textContent = 'Calculating...';\n" +
//                "        shippingCostSummary.classList.add('pulse-animation');\n" +
//                "    }\n" +
//                "    \n" +
//                "    // Call our controller to calculate shipping fee\n" +
//                "    fetch('/api/ghn/shipping-fee', {\n" +
//                "        method: 'POST',\n" +
//                "        headers: {\n" +
//                "            'Content-Type': 'application/json'\n" +
//                "        },\n" +
//                "        body: JSON.stringify(requestData)\n" +
//                "    })\n" +
//                "    .then(response => response.json())\n" +
//                "    .then(data => {\n" +
//                "        if (shippingCostSummary) {\n" +
//                "            shippingCostSummary.classList.remove('pulse-animation');\n" +
//                "            \n" +
//                "            if (data.shippingFee && data.shippingFee.total) {\n" +
//                "                // Convert to USD for display (assuming 23,000 VND = 1 USD)\n" +
//                "                const shippingFeeVND = data.shippingFee.total;\n" +
//                "                const shippingFeeUSD = (shippingFeeVND / 23000).toFixed(2);\n" +
//                "                \n" +
//                "                shippingCostSummary.textContent = '$' + shippingFeeUSD;\n" +
//                "                \n" +
//                "                // Store the shipping fee for later use\n" +
//                "                ghnState.shippingFeeValue = parseFloat(shippingFeeUSD);\n" +
//                "                \n" +
//                "                // Update the order total if function exists\n" +
//                "                if (typeof updatePricing === 'function') {\n" +
//                "                    updatePricing();\n" +
//                "                }\n" +
//                "            } else {\n" +
//                "                shippingCostSummary.textContent = 'Not available';\n" +
//                "            }\n" +
//                "        }\n" +
//                "    })\n" +
//                "    .catch(error => {\n" +
//                "        console.error('Error calculating shipping fee:', error);\n" +
//                "        if (shippingCostSummary) {\n" +
//                "            shippingCostSummary.classList.remove('pulse-animation');\n" +
//                "            shippingCostSummary.textContent = 'Error';\n" +
//                "        }\n" +
//                "    });\n" +
//                "}\n\n" +
//                "// Export functions for global use\n" +
//                "window.ghnState = ghnState;\n" +
//                "window.initGHNIntegration = initGHNIntegration;\n" +
//                "window.calculateShippingFee = calculateShippingFee;\n" +
//                "window.updateAddressPreview = updateAddressPreview;";
//     }
// } 