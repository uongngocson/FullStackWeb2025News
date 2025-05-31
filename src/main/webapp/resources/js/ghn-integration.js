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
    shippingFeeValue: null,
    savedAddresses: [
        // This will be replaced with real data
    ],
    selectedAddressId: 1
};

// LocalStorage keys
const STORAGE_KEYS = {
    ADDRESSES: 'ghn_saved_addresses',
    SELECTED_ADDRESS_ID: 'ghn_selected_address_id',
    CUSTOMER_ID: 'ghn_customer_id'
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
const savedAddressesContainer = document.getElementById('saved-addresses-container');
const newAddressForm = document.getElementById('new-address-form');
const changeAddressBtn = document.getElementById('change-address-btn');
const cancelNewAddressBtn = document.getElementById('cancel-new-address');
const saveNewAddressBtn = document.getElementById('save-new-address');
const fullNameInput = document.getElementById('fullName');
const phoneInput = document.getElementById('phone');

/**
 * Save state to localStorage
 */
function saveStateToStorage() {
    try {
        // Get current customer ID
        const customerIdElement = document.getElementById('customerId');
        const currentCustomerId = customerIdElement ? parseInt(customerIdElement.value) || 0 : 0;
        
        localStorage.setItem(STORAGE_KEYS.ADDRESSES, JSON.stringify(ghnState.savedAddresses));
        localStorage.setItem(STORAGE_KEYS.SELECTED_ADDRESS_ID, ghnState.selectedAddressId);
        
        // Always update the customer ID when saving state
        if (currentCustomerId > 0) {
            localStorage.setItem(STORAGE_KEYS.CUSTOMER_ID, currentCustomerId.toString());
        }
        
        console.log('Address state saved to localStorage:', {
            addresses: ghnState.savedAddresses,
            selectedId: ghnState.selectedAddressId,
            customerId: currentCustomerId
        });
    } catch (error) {
        console.error('Error saving to localStorage:', error);
    }
}

/**
 * Initialize the address from server data
 * @param {Object} addressData - Address data from the server
 */
function initializeAddressFromServer(addressData) {
    if (!addressData) return false;
    
    try {
        // Create default address object
        const defaultAddress = {
            id: addressData.addressId || 1,
            name: addressData.recipientName || '',
            phone: addressData.recipientPhone || '',
            address: `${addressData.street}, ${addressData.ward}, ${addressData.district}, ${addressData.province}`,
            isDefault: true,
            provinceId: parseInt(addressData.provinceId) || 1,
            districtId: parseInt(addressData.districtId) || 1454,
            wardCode: addressData.wardId ? addressData.wardId.toString() : "21012"
        };
        
        console.log('Initializing with server address data:', defaultAddress);
        
        // Set as the only address
        ghnState.savedAddresses = [defaultAddress];
        ghnState.selectedAddressId = defaultAddress.id;
        
        // Set shipping values
        ghnState.selectedToProvince = defaultAddress.provinceId;
        ghnState.selectedToDistrict = defaultAddress.districtId;
        ghnState.selectedToWard = defaultAddress.wardCode;
        
        // Save to local storage
        saveStateToStorage();
        
        return true;
    } catch (error) {
        console.error('Error initializing address from server:', error);
        return false;
    }
}

/**
 * Load state from localStorage
 */
function loadStateFromStorage() {
    try {
        // Get current customer ID
        const customerIdElement = document.getElementById('customerId');
        const currentCustomerId = customerIdElement ? parseInt(customerIdElement.value) || 0 : 0;
        
        // Get stored customer ID
        const storedCustomerId = localStorage.getItem(STORAGE_KEYS.CUSTOMER_ID);
        
        // If user is logged in and IDs don't match, don't load stored data
        if (currentCustomerId > 0 && (!storedCustomerId || parseInt(storedCustomerId) !== currentCustomerId)) {
            console.log('Customer ID mismatch, not loading stored data');
            return false;
        }
        
        // Load saved addresses
        const savedAddresses = localStorage.getItem(STORAGE_KEYS.ADDRESSES);
        if (savedAddresses) {
            ghnState.savedAddresses = JSON.parse(savedAddresses);
            console.log('Loaded saved addresses from localStorage:', ghnState.savedAddresses);
        }
        
        // Load selected address ID
        const selectedAddressId = localStorage.getItem(STORAGE_KEYS.SELECTED_ADDRESS_ID);
        if (selectedAddressId) {
            ghnState.selectedAddressId = parseInt(selectedAddressId);
            console.log('Loaded selected address ID from localStorage:', ghnState.selectedAddressId);
        }
        
        // Ensure we have at least one address
        if (!ghnState.savedAddresses || ghnState.savedAddresses.length === 0) {
            console.log('No saved addresses found in localStorage, using default');
            return false; // Return false to indicate we need to use the server data
        }
        
        // Ensure the selected address exists in our list
        const selectedAddressExists = ghnState.savedAddresses.some(addr => addr.id === ghnState.selectedAddressId);
        if (!selectedAddressExists && ghnState.savedAddresses.length > 0) {
            console.log('Selected address not found in saved addresses, using first address');
            ghnState.selectedAddressId = ghnState.savedAddresses[0].id;
        }
        
        return true;
    } catch (error) {
        console.error('Error loading from localStorage:', error);
        return false;
    }
}

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
 * @param {Object} defaultAddress - Default address data from server
 */
function initGHNIntegration(token, shopId, defaultAddress) {
    console.log('Initializing GHN integration...');
    
    // Store token and shop ID
    ghnState.token = token;
    ghnState.shopId = shopId;
    
    // Get current customer ID
    const customerIdElement = document.getElementById('customerId');
    const currentCustomerId = customerIdElement ? parseInt(customerIdElement.value) || 0 : 0;
    console.log('Current customer ID:', currentCustomerId);
    
    // Check if we should use localStorage data
    let useStoredData = false;
    
    // Get stored customer ID from localStorage
    const storedCustomerId = localStorage.getItem(STORAGE_KEYS.CUSTOMER_ID);
    
    if (currentCustomerId > 0 && storedCustomerId && parseInt(storedCustomerId) === currentCustomerId) {
        // If the stored customer ID matches the current customer ID, we can use localStorage data
        console.log('Customer ID matches stored ID, can use localStorage data');
        useStoredData = true;
    } else if (currentCustomerId > 0) {
        // If customer IDs don't match, clear localStorage data to prevent using another user's addresses
        console.log('Customer ID mismatch or new login, clearing localStorage data');
        localStorage.removeItem(STORAGE_KEYS.ADDRESSES);
        localStorage.removeItem(STORAGE_KEYS.SELECTED_ADDRESS_ID);
        localStorage.removeItem(STORAGE_KEYS.CUSTOMER_ID);
    }
    
    // If customer is logged in and has default address from server, prioritize it
    if (currentCustomerId > 0 && defaultAddress && defaultAddress.addressId) {
        console.log('Using server-provided default address for logged-in user');
        initializeAddressFromServer(defaultAddress);
    } else if (useStoredData) {
        // Try to load state from localStorage if we determined it's safe to use
        const stateLoaded = loadStateFromStorage();
        console.log('State loaded from storage:', stateLoaded);
        
        // If no state was loaded from localStorage, initialize with server data
        if (!stateLoaded && defaultAddress) {
            console.log('Using server-provided default address data:', defaultAddress);
            initializeAddressFromServer(defaultAddress);
        }
    } else if (defaultAddress && (defaultAddress.addressId || defaultAddress.provinceId)) {
        // Default case: use server data if it has at least some minimal information
        console.log('Using server-provided default address data:', defaultAddress);
        initializeAddressFromServer(defaultAddress);
    } else {
        // No address data found - initialize with empty addresses array
        console.log('No address data found, initializing with empty addresses array');
        ghnState.savedAddresses = [];
        ghnState.selectedAddressId = null;
    }
    
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
    
    // Set up address selection event listeners
    if (changeAddressBtn) {
        changeAddressBtn.addEventListener('click', showNewAddressForm);
    }
    
    if (cancelNewAddressBtn) {
        cancelNewAddressBtn.addEventListener('click', hideNewAddressForm);
    }
    
    if (saveNewAddressBtn) {
        saveNewAddressBtn.addEventListener('click', saveNewAddress);
    }
    
    // Set up contact information sync
    setupContactInfoSync();
    
    // Initialize with default address
    initializeDefaultAddress();
    
    // Update UI
    updateSavedAddressesUI();
    
    // Sync contact info with address
    syncContactInfoWithAddress();
    
    // Add event listener for the Apply button
    const applyCouponBtn = document.getElementById('apply-coupon');
    if (applyCouponBtn) {
        applyCouponBtn.addEventListener('click', function() {
            const couponCodeInput = document.getElementById('coupon-code');
            const couponCode = couponCodeInput ? couponCodeInput.value.trim() : '';
            
            if (!couponCode) {
                showNotification('Please enter a discount code', 'error');
                return;
            }
            
            // Validate the discount code (this is a placeholder for actual validation logic)
            const validCodes = {
                'SAVE10': 10, // 10% discount
                'SAVE20': 20  // 20% discount
            };
            
            const discountPercentage = validCodes[couponCode.toUpperCase()];
            if (discountPercentage) {
                // Calculate discount
                const subtotal = 498.00; // Example subtotal
                const discountAmount = (subtotal * discountPercentage) / 100;
                
                // Update discount amount in the UI
                const discountElement = document.getElementById('discount-amount');
                if (discountElement) {
                    discountElement.textContent = '-$' + discountAmount.toFixed(2);
                }
                
                // Update pricing
                updatePricing();
                
                // Show success notification
                showNotification('Discount code applied successfully!', 'success');
                
                // Update coupon status
                const couponStatus = document.getElementById('coupon-status');
                if (couponStatus) {
                    couponStatus.classList.remove('hidden');
                    document.getElementById('coupon-valid').classList.remove('hidden');
                    document.getElementById('coupon-invalid').classList.add('hidden');
                }
            } else {
                // Show error notification
                showNotification('Invalid discount code', 'error');
                
                // Update coupon status
                const couponStatus = document.getElementById('coupon-status');
                if (couponStatus) {
                    couponStatus.classList.remove('hidden');
                    document.getElementById('coupon-valid').classList.add('hidden');
                    document.getElementById('coupon-invalid').classList.remove('hidden');
                }
            }
        });
    }
    
    console.log('GHN integration initialized with token and shop ID');
}

/**
 * Set up contact information synchronization with shipping address
 */
function setupContactInfoSync() {
    if (fullNameInput) {
        fullNameInput.addEventListener('input', function() {
            updateContactInfoInAddress();
        });
    }
    
    if (phoneInput) {
        phoneInput.addEventListener('input', function() {
            updateContactInfoInAddress();
        });
    }
    
    // Initial sync of contact info to address
    syncContactInfoWithAddress();
}

/**
 * Update contact information in the selected address
 */
function updateContactInfoInAddress() {
    const selectedAddress = ghnState.savedAddresses.find(addr => addr.id === ghnState.selectedAddressId);
    if (!selectedAddress) return;
    
    let updated = false;
    
    if (fullNameInput && fullNameInput.value.trim() !== selectedAddress.name) {
        selectedAddress.name = fullNameInput.value.trim();
        updated = true;
        
        // Add visual feedback
        addSyncAnimation(fullNameInput);
    }
    
    if (phoneInput && phoneInput.value.trim() !== selectedAddress.phone) {
        selectedAddress.phone = phoneInput.value.trim();
        updated = true;
        
        // Add visual feedback
        addSyncAnimation(phoneInput);
    }
    
    if (updated) {
        console.log('Contact information updated in address:', selectedAddress);
        saveStateToStorage();
        updateSavedAddressesUI();
    }
}

/**
 * Add a sync animation to an element
 * @param {HTMLElement} element - The element to animate
 */
function addSyncAnimation(element) {
    // Create a flash effect
    const flashOverlay = document.createElement('div');
    flashOverlay.style.position = 'absolute';
    flashOverlay.style.top = '0';
    flashOverlay.style.left = '0';
    flashOverlay.style.right = '0';
    flashOverlay.style.bottom = '0';
    flashOverlay.style.backgroundColor = 'rgba(59, 130, 246, 0.2)';
    flashOverlay.style.borderRadius = '12px';
    flashOverlay.style.pointerEvents = 'none';
    flashOverlay.style.opacity = '0';
    flashOverlay.style.transition = 'opacity 0.3s ease';
    
    // Add to parent container (which should be positioned relative)
    const parent = element.parentElement;
    if (parent) {
        parent.appendChild(flashOverlay);
        
        // Trigger animation
        setTimeout(() => {
            flashOverlay.style.opacity = '1';
            
            setTimeout(() => {
                flashOverlay.style.opacity = '0';
                
                // Remove after animation
                setTimeout(() => {
                    flashOverlay.remove();
                }, 300);
            }, 300);
        }, 10);
    }
}

/**
 * Sync contact information with the selected address
 */
function syncContactInfoWithAddress() {
    const selectedAddress = ghnState.savedAddresses.find(addr => addr.id === ghnState.selectedAddressId);
    if (!selectedAddress) return;
    
    if (fullNameInput && selectedAddress.name) {
        fullNameInput.value = selectedAddress.name;
    }
    
    if (phoneInput && selectedAddress.phone) {
        phoneInput.value = selectedAddress.phone;
    }
    
    console.log('Contact information synced from address:', selectedAddress);
}

/**
 * Initialize with default address
 */
function initializeDefaultAddress() {
    console.log('Initializing with default/selected address...');
    
    // Find selected address
    const selectedAddress = ghnState.savedAddresses.find(addr => addr.id === ghnState.selectedAddressId);
    
    if (selectedAddress) {
        console.log('Using selected address:', selectedAddress);
        
        // Set shipping values from selected address
        ghnState.selectedToProvince = selectedAddress.provinceId;
        ghnState.selectedToDistrict = selectedAddress.districtId;
        ghnState.selectedToWard = selectedAddress.wardCode;
        
        // Log shipping values
        console.log(`Setting shipping destination: Province=${ghnState.selectedToProvince}, District=${ghnState.selectedToDistrict}, Ward=${ghnState.selectedToWard}`);
        
        // Validate district and ward values
        if (!ghnState.selectedToDistrict || !ghnState.selectedToWard) {
            console.error('Invalid district ID or ward code in selected address:', selectedAddress);
            return;
        }
        
        // Calculate shipping fee for selected address
        calculateShippingFee(ghnState.selectedToDistrict, ghnState.selectedToWard);
    } else {
        // Fallback to default address
        const defaultAddress = ghnState.savedAddresses.find(addr => addr.isDefault);
        
        if (defaultAddress) {
            console.log('Using default address:', defaultAddress);
            
            // Set selected address
            ghnState.selectedAddressId = defaultAddress.id;
            
            // Set shipping values from default address
            ghnState.selectedToProvince = defaultAddress.provinceId;
            ghnState.selectedToDistrict = defaultAddress.districtId;
            ghnState.selectedToWard = defaultAddress.wardCode;
            
            // Log shipping values
            console.log(`Setting shipping destination (default): Province=${ghnState.selectedToProvince}, District=${ghnState.selectedToDistrict}, Ward=${ghnState.selectedToWard}`);
            
            // Validate district and ward values
            if (!ghnState.selectedToDistrict || !ghnState.selectedToWard) {
                console.error('Invalid district ID or ward code in default address:', defaultAddress);
                return;
            }
            
            // Calculate shipping fee for default address
            calculateShippingFee(defaultAddress.districtId, defaultAddress.wardCode);
        } else if (ghnState.savedAddresses.length > 0) {
            // Fallback to first address
            const firstAddress = ghnState.savedAddresses[0];
            console.log('Using first address:', firstAddress);
            
            ghnState.selectedAddressId = firstAddress.id;
            ghnState.selectedToProvince = firstAddress.provinceId;
            ghnState.selectedToDistrict = firstAddress.districtId;
            ghnState.selectedToWard = firstAddress.wardCode;
            
            // Log shipping values
            console.log(`Setting shipping destination (first available): Province=${ghnState.selectedToProvince}, District=${ghnState.selectedToDistrict}, Ward=${ghnState.selectedToWard}`);
            
            // Validate district and ward values
            if (!ghnState.selectedToDistrict || !ghnState.selectedToWard) {
                console.error('Invalid district ID or ward code in first address:', firstAddress);
                return;
            }
            
            calculateShippingFee(firstAddress.districtId, firstAddress.wardCode);
        } else {
            console.warn('No addresses available');
        }
    }
}

/**
 * Show the new address form with pre-filled values from selected address
 * @param {Event} event - The click event (optional)
 */
function showNewAddressForm(event) {
    console.log('Showing address form for editing');
    
    // Get the selected address
    const selectedAddress = ghnState.savedAddresses?.find(addr => addr.id === ghnState.selectedAddressId);
    
    if (selectedAddress && provinceSelect && districtSelect && wardSelect && addressDetail) {
        console.log('Pre-filling form with address:', selectedAddress);
        
        // Set address detail
        // Extract the street address (first part before the first comma)
        const addressParts = selectedAddress.address.split(',');
        if (addressParts.length > 0) {
            addressDetail.value = addressParts[0].trim();
        }
        
        // Set province (needs to trigger district loading)
        if (provinceSelect.querySelector(`option[value="${selectedAddress.provinceId}"]`)) {
            provinceSelect.value = selectedAddress.provinceId;
            
            // Trigger province change event to load districts
            const event = new Event('change');
            provinceSelect.dispatchEvent(event);
            
            // We need to wait for districts to load before setting district value
            const checkDistrictsLoaded = setInterval(() => {
                if (!districtSelect.disabled && districtSelect.options.length > 1) {
                    clearInterval(checkDistrictsLoaded);
                    
                    // Set district value
                    if (districtSelect.querySelector(`option[value="${selectedAddress.districtId}"]`)) {
                        districtSelect.value = selectedAddress.districtId;
                        
                        // Trigger district change event to load wards
                        const districtEvent = new Event('change');
                        districtSelect.dispatchEvent(districtEvent);
                        
                        // Wait for wards to load before setting ward value
                        const checkWardsLoaded = setInterval(() => {
                            if (!wardSelect.disabled && wardSelect.options.length > 1) {
                                clearInterval(checkWardsLoaded);
                                
                                // Set ward value
                                if (wardSelect.querySelector(`option[value="${selectedAddress.wardCode}"]`)) {
                                    wardSelect.value = selectedAddress.wardCode;
                                }
                            }
                        }, 100);
                    }
                }
            }, 100);
        }
    } else {
        // If no selected address, clear the form
        if (addressDetail) addressDetail.value = '';
        if (provinceSelect) provinceSelect.selectedIndex = 0;
        if (districtSelect) {
            districtSelect.innerHTML = '<option value="">Select District</option>';
            districtSelect.disabled = true;
        }
        if (wardSelect) {
            wardSelect.innerHTML = '<option value="">Select Ward</option>';
            wardSelect.disabled = true;
        }
    }
    
    if (savedAddressesContainer) {
        savedAddressesContainer.classList.add('hidden');
    }
    
    if (newAddressForm) {
        newAddressForm.classList.remove('hidden');
    }
}

/**
 * Hide the new address form
 */
function hideNewAddressForm() {
    console.log('Hiding new address form');
    if (savedAddressesContainer) {
        savedAddressesContainer.classList.remove('hidden');
    }
    
    if (newAddressForm) {
        newAddressForm.classList.add('hidden');
    }
}

/**
 * Save a new address or update existing one
 */
function saveNewAddress() {
    console.log('Saving address...');
    
    // Show loading indicator
    const loadingIndicator = document.getElementById('save-address-loading');
    if (loadingIndicator) {
        loadingIndicator.classList.remove('hidden');
    }
    
    const detail = addressDetail ? addressDetail.value.trim() : '';
    const provinceId = provinceSelect ? provinceSelect.value : '';
    const districtId = districtSelect ? districtSelect.value : '';
    const wardCode = wardSelect ? wardSelect.value : '';
    
    // Validate address
    if (!detail || !provinceId || !districtId || !wardCode) {
        console.error('Address validation failed: missing fields');
        showNotification('Please fill in all address fields', 'error');
        
        // Hide loading indicator
        if (loadingIndicator) {
            loadingIndicator.classList.add('hidden');
        }
        return;
    }
    
    // Get text values
    const provinceName = provinceSelect.options[provinceSelect.selectedIndex].text;
    const districtName = districtSelect.options[districtSelect.selectedIndex].text;
    const wardName = wardSelect.options[wardSelect.selectedIndex].text;
    
    // Create full address
    const fullAddressText = `${detail}, ${wardName}, ${districtName}, ${provinceName}`;
    
    // Get current selected address
    const selectedAddress = ghnState.savedAddresses.find(addr => addr.id === ghnState.selectedAddressId);
    
    // Get current contact info
    const currentName = fullNameInput ? fullNameInput.value : '';
    const currentPhone = phoneInput ? phoneInput.value : '';
    
    if (selectedAddress) {
        // Update existing address
        console.log('Updating existing address:', selectedAddress.id);
        
        selectedAddress.address = fullAddressText;
        selectedAddress.provinceId = parseInt(provinceId);
        selectedAddress.districtId = parseInt(districtId);
        selectedAddress.wardCode = wardCode;
        
        // Update contact info
        if (currentName) {
            selectedAddress.name = currentName;
        }
        
        if (currentPhone) {
            selectedAddress.phone = currentPhone;
        }
    } else {
        // Generate an ID that fits within Java's int range
        // Use a random number between 1 and 2 million (well below max int)
        const addressId = Math.floor(Math.random() * 2000000) + 1;
        
        // Create new address object
        const newAddress = {
            id: addressId,
            name: currentName || 'User',
            phone: currentPhone || '',
            address: fullAddressText,
            isDefault: ghnState.savedAddresses.length === 0, // Make default if it's the first address
            provinceId: parseInt(provinceId),
            districtId: parseInt(districtId),
            wardCode: wardCode
        };
        
        console.log('Creating new address:', newAddress);
        
        // Add to saved addresses
        ghnState.savedAddresses.push(newAddress);
        
        // Set as selected address
        ghnState.selectedAddressId = newAddress.id;
    }
    
    // Update GHN state with selected address values
    ghnState.selectedToProvince = parseInt(provinceId);
    ghnState.selectedToDistrict = parseInt(districtId);
    ghnState.selectedToWard = wardCode;
    
    // Save to localStorage
    saveStateToStorage();
    
    // Simulate a delay for better UX
    setTimeout(() => {
        // Update UI
        updateSavedAddressesUI();
        
        // Calculate shipping fee
        calculateShippingFee(districtId, wardCode);
        
        // Hide form
        hideNewAddressForm();
        
        // Hide loading indicator
        if (loadingIndicator) {
            loadingIndicator.classList.add('hidden');
        }
        
        // Show notification
        showNotification('Address saved successfully', 'success');
    }, 500);
}

/**
 * Update the saved addresses UI
 */
function updateSavedAddressesUI() {
    console.log('Updating saved addresses UI');
    
    if (!savedAddressesContainer) {
        console.warn('Saved addresses container not found in DOM');
        return;
    }
    
    // Clear container
    savedAddressesContainer.innerHTML = '';
    
    // Check if there are any saved addresses
    if (!ghnState.savedAddresses || ghnState.savedAddresses.length === 0) {
        // Create a message for no address
        const noAddressMessage = document.createElement('div');
        noAddressMessage.className = 'p-6 bg-yellow-50 border border-yellow-200 rounded-xl';
        noAddressMessage.innerHTML = `
            <div class="flex items-center mb-3">
                <div class="text-yellow-500 text-xl mr-3">⚠️</div>
                <h3 class="font-medium text-yellow-800">No shipping address selected</h3>
            </div>
            <p class="text-yellow-700 mb-4">Please add a shipping address to continue with your order.</p>
            <button type="button" id="add-new-address-btn" class="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">
                <span class="mr-2">+</span> Add New Address
            </button>
        `;
        
        // Add to container
        savedAddressesContainer.appendChild(noAddressMessage);
        
        // Add click event to add new address button
        const addNewAddressBtn = noAddressMessage.querySelector('#add-new-address-btn');
        if (addNewAddressBtn) {
            addNewAddressBtn.addEventListener('click', showNewAddressForm);
        }
        
        console.log('No saved addresses available, showing message');
        return;
    }
    
    // Add each address
    ghnState.savedAddresses.forEach(address => {
        const isSelected = address.id === ghnState.selectedAddressId;
        
        const addressCard = document.createElement('div');
        addressCard.className = `saved-address-card ${isSelected ? 'selected-address' : ''}`;
        addressCard.dataset.addressId = address.id;
        
        addressCard.innerHTML = `
            <div class="flex items-start">
                <div class="w-6 h-6 rounded-full border-2 ${isSelected ? 'border-blue-500' : 'border-gray-300'} flex items-center justify-center mr-4 mt-1">
                    <div class="w-3 h-3 rounded-full ${isSelected ? 'bg-blue-500' : ''}"></div>
                </div>
                <div class="flex-1">
                    <div class="flex justify-between items-start">
                        <div>
                            <div class="font-medium text-gray-900">${address.name} ${address.phone}</div>
                            <p class="text-gray-600 mt-1">${address.address}</p>
                            ${address.isDefault ? `
                                <div class="mt-2">
                                    <span class="inline-block px-2 py-1 bg-blue-100 text-blue-800 text-xs font-medium rounded">Mặc định</span>
                                </div>
                            ` : ''}
                        </div>
                        <button type="button" class="change-address-btn text-blue-600 font-medium hover:text-blue-800 transition-colors" data-address-id="${address.id}">
                            Thay đổi
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        // Add to container
        savedAddressesContainer.appendChild(addressCard);
        
        // Add click event to select this address
        addressCard.addEventListener('click', function(e) {
            // Check if the clicked element is not the change button
            if (!e.target.matches('.change-address-btn')) {
                selectAddress(address.id);
            }
        });
        
        // Add click event to change button
        const changeBtn = addressCard.querySelector('.change-address-btn');
        if (changeBtn) {
            changeBtn.addEventListener('click', function(e) {
                // First select this address
                selectAddress(address.id);
                // Then show the form
                showNewAddressForm(e);
            });
        }
    });
    
    console.log('Saved addresses UI updated with', ghnState.savedAddresses.length, 'addresses');
}

/**
 * Select an address by ID
 * @param {number} addressId - The ID of the address to select
 */
function selectAddress(addressId) {
    console.log('Selecting address with ID:', addressId);
    
    // Find the address
    const address = ghnState.savedAddresses.find(addr => addr.id === addressId);
    
    if (address) {
        console.log('Address found:', address);
        
        // Update selected address
        ghnState.selectedAddressId = address.id;
        
        // Update GHN state
        ghnState.selectedToProvince = address.provinceId;
        ghnState.selectedToDistrict = address.districtId;
        ghnState.selectedToWard = address.wardCode;
        
        // Sync contact info with address
        syncContactInfoWithAddress();
        
        // Save to localStorage
        saveStateToStorage();
        
        // Update UI
        updateSavedAddressesUI();
        
        // Calculate shipping fee
        calculateShippingFee(address.districtId, address.wardCode);
    } else {
        console.error('Address not found with ID:', addressId);
    }
}

/**
 * Handle province selection change
 */
function handleProvinceChange() {
    const selectedProvinceId = provinceSelect.value;
    console.log('Province changed to:', selectedProvinceId);
    
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
    // Ensure we have valid district ID and ward code
    if (!toDistrictId || !toWardCode) {
        console.error('Missing district ID or ward code for shipping calculation');
        if (shippingCostSummary) {
            shippingCostSummary.textContent = 'Missing data';
        }
        return;
    }
    
    console.log(`Calculating shipping fee to district ${toDistrictId}, ward ${toWardCode}`);
    
    // Default from district: Go Vap, Ho Chi Minh City
    const fromDistrictId = ghnState.selectedFromDistrict;
    
    // Show loading for shipping calculation
    if (shippingCostSummary) {
        shippingCostSummary.textContent = 'Calculating...';
        shippingCostSummary.classList.add('pulse-animation');
    }
    
    // Before calculating fee, check available shipping services
    fetch(`/api/ghn/services/${fromDistrictId}/${toDistrictId}`)
        .then(response => response.json())
        .then(data => {
            if (data.success && data.services && data.services.length > 0) {
                console.log("Available services:", data.services);
                
                // Find the most suitable service
                let selectedService = null;
                
                // Look for service with "value", "tiết kiệm" or "chuẩn" in the name
                selectedService = data.services.find(s => {
                    const serviceName = s.service_name || '';
                    return serviceName.toLowerCase().includes('value') ||
                        serviceName.toLowerCase().includes('tiết kiệm') ||
                        serviceName.toLowerCase().includes('chuẩn');
                });
                
                // If not found, use the first service
                if (!selectedService && data.services.length > 0) {
                    selectedService = data.services[0];
                }
                
                if (selectedService) {
                    console.log(`Selected service: ${selectedService.service_name} (ID: ${selectedService.service_id})`);
                    ghnState.selectedService = selectedService.service_id;
                    
                    // Update displayed service information
                    const serviceNameElement = document.getElementById('shipping-service-name');
                    if (serviceNameElement) {
                        serviceNameElement.textContent = selectedService.service_name || 'Standard';
                    }
                    
                    // Continue with shipping fee calculation using the selected service
                    performShippingCalculation(fromDistrictId, toDistrictId, toWardCode);
                } else {
                    if (shippingCostSummary) {
                        shippingCostSummary.classList.remove('pulse-animation');
                        shippingCostSummary.textContent = 'Not available';
                    }
                    showNotification('No shipping services available for this route', 'error');
                }
            } else {
                if (shippingCostSummary) {
                    shippingCostSummary.classList.remove('pulse-animation');
                    shippingCostSummary.textContent = 'Not available';
                }
                showNotification('Could not load shipping services', 'error');
            }
        })
        .catch(error => {
            console.error('Error fetching shipping services:', error);
            if (shippingCostSummary) {
                shippingCostSummary.classList.remove('pulse-animation');
                shippingCostSummary.textContent = 'Error';
            }
            showNotification('Error loading shipping services', 'error');
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
                const shippingFeeUSD = (shippingFeeVND / 1).toFixed(2);
                
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
    // Get the initial subtotal value from the cart-subtotal element
    // Extract the numeric value from the initial $${orderTotal} format
    const subtotalElement = document.getElementById('cart-subtotal');
    let subtotal = 498.00; // Default fallback value
    
    if (subtotalElement) {
        const subtotalText = subtotalElement.getAttribute('data-initial-value');
        if (subtotalText) {
            // Use the stored initial value
            subtotal = parseFloat(subtotalText);
        } else {
            // First time: get the current text content and store it as initial value
            const currentText = subtotalElement.textContent;
            if (currentText) {
                // Extract numeric value from the string (remove $ and other non-numeric chars)
                const extractedValue = parseFloat(currentText.replace(/[^\d.-]/g, ''));
                if (!isNaN(extractedValue)) {
                    subtotal = extractedValue;
                    // Store this as the initial value for future reference
                    subtotalElement.setAttribute('data-initial-value', extractedValue.toString());
                }
            }
        }
    }
    
    const shipping = window.ghnState && window.ghnState.shippingFeeValue ? 
        window.ghnState.shippingFeeValue : 0;
    
    const hasVat = document.getElementById('vatBtn').classList.contains('active');
    const tax = hasVat ? (subtotal+shipping) * 0.08 : 0;
    
    // Use discount from discount system
    console.log('discountState------------', discountState);
    const discount = discountState.totalDiscountAmount;

    console.log('discount------------', discount);
    
    const total = subtotal + shipping + tax - discount;
    
    document.getElementById('cart-subtotal').textContent = '$' + subtotal.toFixed(2);
    document.getElementById('shipping-cost-summary').textContent = '$' + shipping.toFixed(2);
    document.getElementById('tax-amount').textContent = '$' + tax.toFixed(2);
    document.getElementById('total-with-discount').textContent = '$' + total.toFixed(2);
}

/**
 * Prepare order data for API submission
 * This function collects all necessary data for the usp_CreateOrderFull stored procedure
 * @returns {Object} Object containing all order data
 */
function prepareOrderDataForAPI() {
    console.log('Preparing order data for API submission...');
    
    try {
        // Get customer information
        const customerId = parseInt(document.getElementById('customerId')?.value || '0');
        const fullName = document.getElementById('fullName')?.value || '';
        const email = document.getElementById('email')?.value || '';
        const phone = document.getElementById('phone')?.value || '';
        
        // Get selected address
        const selectedAddress = ghnState.savedAddresses.find(addr => addr.id === ghnState.selectedAddressId);
        if (!selectedAddress) {
            throw new Error('Please select a shipping address');
        }
        
        // Extract address components
        const addressParts = selectedAddress.address.split(',');
        const street = addressParts[0]?.trim() || '';
        
        // Get payment method (1 = Online Payment, 2 = COD)
        const paymentId = document.getElementById('payment-method-1').classList.contains('selected') ? 1 : 2;
        
        // Get order items
        const orderItems = [];
        
        document.querySelectorAll('.cart-item').forEach(item => {
            const variantId = parseInt(item.getAttribute('data-variant-id'));
            const quantity = parseInt(item.getAttribute('data-quantity') || '1');
            
            if (!isNaN(variantId) && !isNaN(quantity)) {
                orderItems.push({
                    product_variant_id: variantId,
                    quantity: quantity
                });
            }
        });
        
        if (orderItems.length === 0) {
            throw new Error('No items in cart');
        }
        
        // Get variant IDs with applied discounts
        const productVariantIdsWithDiscount = [];
        
        // Get variant IDs that have discounts applied from discountState.selectedDiscounts
        for (const variantId in discountState.selectedDiscounts) {
            if (discountState.selectedDiscounts.hasOwnProperty(variantId)) {
                productVariantIdsWithDiscount.push(variantId);
            }
        }
        
        console.log('Variants with applied discounts:', productVariantIdsWithDiscount);
        
        // Calculate total amount
        // Get subtotal from the DOM
        const subtotalElement = document.getElementById('cart-subtotal');
        let subtotal = 0;
        
        if (subtotalElement) {
            const subtotalText = subtotalElement.textContent;
            // Extract numeric value from format like "$498.00"
            subtotal = parseFloat(subtotalText.replace(/[^\d.-]/g, '')) || 0;
        }
        
        // Get shipping fee
        const shippingFee = ghnState.shippingFeeValue || 0;
        
        // Check if VAT is applied
        const hasVat = document.getElementById('vatBtn').classList.contains('active');
        const tax = hasVat ? (subtotal + shippingFee) * 0.08 : 0;
        
        // Get discount amount
        const discount = discountState.totalDiscountAmount || 0;
        
        // Calculate final total
        const totalAmount = subtotal + shippingFee + tax - discount;
        
        // Prepare final order data object
        const orderData = {
            customer_id: customerId,
            payment_id: paymentId,
            TotalAmount: totalAmount,
            OrderItems: orderItems,
            AddressId: selectedAddress.id,
            recipient_name: fullName,
            recipient_phone: phone,
            Street: street,
            ProvinceId: selectedAddress.provinceId,
            DistrictId: selectedAddress.districtId,
            WardId: selectedAddress.wardCode,
            Country: 'Việt Nam',
            ProductVariantIds: productVariantIdsWithDiscount.join(',')
        };
        
        console.log('Order data prepared successfully:', orderData);
        return {
            success: true,
            data: orderData
        };
    } catch (error) {
        console.error('Error preparing order data:', error);
        return {
            success: false,
            message: error.message
        };
    }
}

/**
 * Validate order form data
 * @returns {Object} Object containing validation result
 */
function validateOrderForm() {
    // Helper function to return validation result
    const fail = message => ({ isValid: false, message });

    // Validate customer information
    const fullName = (document.getElementById('fullName')?.value || '').trim();
    if (!fullName) return fail('Vui lòng nhập họ và tên đầy đủ');

    const email = (document.getElementById('email')?.value || '').trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!email || !emailRegex.test(email)) return fail('Vui lòng nhập địa chỉ email hợp lệ');

    const phone = (document.getElementById('phone')?.value || '').trim();
    const phoneRegex = /^\d{10,15}$/;
    if (!phone || !phoneRegex.test(phone)) return fail('Vui lòng nhập số điện thoại hợp lệ (10-15 chữ số)');

    // Validate shipping address
    const { selectedAddressId, savedAddresses, shippingFeeValue } = ghnState || {};
    
    // Check if savedAddresses exists and has items
    if (!Array.isArray(savedAddresses) || savedAddresses.length === 0) {
        return fail('Vui lòng thêm địa chỉ giao hàng trước khi đặt hàng');
    }
    
    if (!selectedAddressId) {
        return fail('Vui lòng chọn địa chỉ giao hàng');
    }

    const selectedAddress = savedAddresses.find(addr => addr.id === selectedAddressId);
    if (!selectedAddress) return fail('Địa chỉ giao hàng không hợp lệ');

    const { provinceId, districtId, wardCode } = selectedAddress;
    if (!provinceId || !districtId || !wardCode) {
        return fail('Vui lòng chọn đầy đủ tỉnh/thành, quận/huyện và phường/xã');
    }

    // Validate payment method
    const paymentSelected = document.querySelector('.payment-method.selected');
    if (!paymentSelected) return fail('Vui lòng chọn phương thức thanh toán');

    // Validate shipping fee
    if (typeof shippingFeeValue !== 'number' || shippingFeeValue <= 0) {
        return fail('Vui lòng tính phí vận chuyển trước khi đặt hàng');
    }

    // All validations passed
    return { isValid: true };
}

/**
 * Anti-Spam Protection System
 * This section implements protection against automated clicks and order spam
 */

// Anti-spam state
const antiSpamState = {
    lastClickTime: 0,
    clickCount: 0,
    isProcessing: false,
    cooldownPeriod: 3000, // 3 seconds cooldown between submissions
    maxClicksPerMinute: 5,
    challengeRequired: false,
    clickTimestamps: [],
    orderSubmissionBlocked: false,
    blockExpiration: 0,
    blockedIPs: new Set(),
    sessionToken: generateSessionToken(),
    orderHash: '',
    lastOrderHash: ''
};

/**
 * Generate a unique session token
 * @returns {string} Random session token
 */
function generateSessionToken() {
    // Create a token that doesn't rely on timestamp-based large numbers
    // Generate a 6-character random alphanumeric string
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let token = '';
    for (let i = 0; i < 6; i++) {
        token += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    
    // Add a smaller number (under 1 million)
    token += '-' + Math.floor(Math.random() * 1000000);
    
    return token;
}

/**
 * Create a hash from order data to detect duplicate submissions
 * @param {Object} orderData - The order data object
 * @returns {string} Hash representing the order
 */
function createOrderHash(orderData) {
    if (!orderData) return '';
    
    try {
        // Create a string representation of important order data
        const dataString = `${orderData.customer_id}-${orderData.payment_id}-${
            orderData.TotalAmount}-${orderData.AddressId}`;
        
        // Simple hash function that produces a number within int range
        let hash = 0;
        for (let i = 0; i < dataString.length; i++) {
            const char = dataString.charCodeAt(i);
            // Use a simple hash algorithm that stays within Java int range
            hash = ((hash << 5) + hash) ^ char;
            hash = hash & 0x7FFFFFFF; // Ensure positive and within 31 bits (max Java int)
        }
        
        return hash.toString();
    } catch (error) {
        console.error('Error creating order hash:', error);
        // Generate a safe fallback number within Java int range
        return Math.floor(Math.random() * 1000000).toString();
    }
}

/**
 * Check if current submission is a duplicate of recent order
 * @param {Object} orderData - The order data object
 * @returns {boolean} True if it's a duplicate submission
 */
function isDuplicateSubmission(orderData) {
    const newHash = createOrderHash(orderData);
    
    // Check if this is the same as the last order hash
    const isDuplicate = newHash === antiSpamState.lastOrderHash && 
                        antiSpamState.lastOrderHash !== '';
    
    // Update the last order hash
    antiSpamState.orderHash = newHash;
    
    return isDuplicate;
}

/**
 * Track click activity to detect potential spam patterns
 * @returns {boolean} True if spam pattern detected
 */
function trackClickActivity() {
    const now = Date.now();
    
    // Add current timestamp to the list
    antiSpamState.clickTimestamps.push(now);
    
    // Only keep timestamps from the last minute
    const oneMinuteAgo = now - 60000;
    antiSpamState.clickTimestamps = antiSpamState.clickTimestamps.filter(
        timestamp => timestamp > oneMinuteAgo
    );
    
    // Check if we've exceeded the maximum clicks per minute
    if (antiSpamState.clickTimestamps.length > antiSpamState.maxClicksPerMinute) {
        console.warn('Excessive click activity detected');
        return true;
    }
    
    return false;
}

/**
 * Block order submissions temporarily
 * @param {number} duration - Duration in milliseconds to block submissions
 */
function blockOrderSubmission(duration = 30000) {
    antiSpamState.orderSubmissionBlocked = true;
    antiSpamState.blockExpiration = Date.now() + duration;
    
    // Show notification to user
    showNotification(
        `Phát hiện hoạt động bất thường. Vui lòng thử lại sau ${duration/1000} giây.`, 
        'error'
    );
    
    // Disable the order button
    const orderButton = document.getElementById('test-order-data');
    if (orderButton) {
        orderButton.disabled = true;
        orderButton.classList.add('opacity-50', 'cursor-not-allowed');
        
        // Set a timer to re-enable the button
        setTimeout(() => {
            antiSpamState.orderSubmissionBlocked = false;
            orderButton.disabled = false;
            orderButton.classList.remove('opacity-50', 'cursor-not-allowed');
            showNotification('Bạn có thể tiếp tục đặt hàng.', 'success');
        }, duration);
    }
}

/**
 * Display a CAPTCHA challenge when suspicious activity is detected
 * @returns {Promise<boolean>} Resolves to true if challenge passed, false otherwise
 */
function showCaptchaChallenge() {
    return new Promise((resolve) => {
        // Create CAPTCHA modal
        const modal = document.createElement('div');
        modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
        modal.style.backdropFilter = 'blur(5px)';
        
        // Generate a simple math challenge
        const num1 = Math.floor(Math.random() * 10) + 1;
        const num2 = Math.floor(Math.random() * 10) + 1;
        const answer = num1 + num2;
        
        modal.innerHTML = `
            <div class="bg-white rounded-lg p-6 max-w-md w-full shadow-2xl">
                <h3 class="text-xl font-bold mb-4">Xác minh bạn không phải là robot</h3>
                <p class="mb-4">Để tiếp tục, vui lòng giải phép tính đơn giản sau:</p>
                <div class="text-center text-2xl font-bold mb-4">${num1} + ${num2} = ?</div>
                <div class="mb-4">
                    <input type="number" id="captcha-answer" class="w-full p-2 border border-gray-300 rounded" placeholder="Nhập câu trả lời">
                </div>
                <div class="flex justify-end space-x-3">
                    <button id="captcha-cancel" class="px-4 py-2 bg-gray-200 rounded">Hủy</button>
                    <button id="captcha-submit" class="px-4 py-2 bg-blue-600 text-white rounded">Xác nhận</button>
                </div>
            </div>
        `;
        
        // Add to DOM
        document.body.appendChild(modal);
        
        // Focus the input
        setTimeout(() => {
            const input = document.getElementById('captcha-answer');
            if (input) input.focus();
        }, 100);
        
        // Add event listeners
        document.getElementById('captcha-cancel').addEventListener('click', () => {
            document.body.removeChild(modal);
            resolve(false);
        });
        
        document.getElementById('captcha-submit').addEventListener('click', () => {
            const userAnswer = parseInt(document.getElementById('captcha-answer').value);
            if (userAnswer === answer) {
                document.body.removeChild(modal);
                resolve(true);
            } else {
                document.getElementById('captcha-answer').classList.add('border-red-500');
                document.getElementById('captcha-answer').value = '';
                document.getElementById('captcha-answer').placeholder = 'Sai rồi! Hãy thử lại.';
            }
        });
        
        // Allow Enter key to submit
        document.getElementById('captcha-answer').addEventListener('keyup', (e) => {
            if (e.key === 'Enter') {
                document.getElementById('captcha-submit').click();
            }
        });
    });
}

/**
 * Check for signs of automated submission or spam attempts
 * @param {Object} orderData - The order data to check
 * @returns {Promise<boolean>} Promise resolving to true if the submission is legitimate
 */
async function checkForSpam(orderData) {
    // If submission is currently blocked, prevent submission
    if (antiSpamState.orderSubmissionBlocked) {
        const remainingTime = Math.ceil((antiSpamState.blockExpiration - Date.now()) / 1000);
        if (remainingTime > 0) {
            showNotification(
                `Vui lòng đợi ${remainingTime} giây trước khi thử lại.`, 
                'error'
            );
            return false;
        }
        
        // Reset blocked state if expired
        antiSpamState.orderSubmissionBlocked = false;
    }
    
    // Check for duplicate submission based on order hash
    if (isDuplicateSubmission(orderData)) {
        showNotification('Đơn hàng đã được gửi. Vui lòng không gửi lại.', 'error');
        return false;
    }
    
    // Track click activity
    const excessiveClicks = trackClickActivity();
    
    // If we detect excessive clicks or a short time between submissions, show CAPTCHA
    const now = Date.now();
    const timeSinceLastClick = now - antiSpamState.lastClickTime;
    
    if (excessiveClicks || timeSinceLastClick < 1000) {
        console.warn('Suspicious activity detected, showing CAPTCHA challenge');
        antiSpamState.challengeRequired = true;
        
        // Show CAPTCHA challenge
        const challengePassed = await showCaptchaChallenge();
        if (!challengePassed) {
            showNotification('Xác thực thất bại. Vui lòng thử lại.', 'error');
            return false;
        }
        
        // Reset challenge required state
        antiSpamState.challengeRequired = false;
        // Reset click count after successful challenge
        antiSpamState.clickCount = 0;
    }
    
    // If we're already processing an order, prevent another submission
    if (antiSpamState.isProcessing) {
        showNotification('Đơn hàng của bạn đang được xử lý. Vui lòng đợi.', 'info');
        return false;
    }
    
    // Update anti-spam state
    antiSpamState.lastClickTime = now;
    antiSpamState.clickCount++;
    antiSpamState.lastOrderHash = antiSpamState.orderHash;
    
    // If too many clicks in a row, block submissions temporarily
    if (antiSpamState.clickCount > 10) {
        blockOrderSubmission(15000); // Block for 15 seconds
        return false;
    }
    
    return true;
}

/**
 * Enhanced submitOrderToAPI function with anti-spam protection
 * @returns {Promise} Promise resolving to API response
 */
function submitOrderToAPI() {
    return new Promise(async (resolve, reject) => {
        try {
            // Show loading overlay
            const loadingOverlay = document.getElementById('loadingOverlay');
            if (loadingOverlay) {
                loadingOverlay.classList.add('active');
            }
            
            // Prepare order data
            const orderDataResult = prepareOrderDataForAPI();
            
            if (!orderDataResult.success) {
                showNotification(orderDataResult.message, 'error');
                reject(new Error(orderDataResult.message));
                return;
            }
            
            const orderData = orderDataResult.data;
            
            // Run anti-spam checks
            const isLegitimate = await checkForSpam(orderData);
            if (!isLegitimate) {
                // Hide loading overlay
                if (loadingOverlay) {
                    loadingOverlay.classList.remove('active');
                }
                reject(new Error('Spam prevention measures triggered'));
                return;
            }
            
            // Mark as processing
            antiSpamState.isProcessing = true;
            
            console.log('Submitting order data:', orderData);
            
            // Add session token to the order data
            orderData.sessionToken = antiSpamState.sessionToken;
            
            // Submit order to API
            const response = await fetch('/api/handle/submit', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Anti-Spam-Token': antiSpamState.sessionToken
                },
                body: JSON.stringify(orderData)
            });
            
            const responseData = await response.json();
            
            // Mark as no longer processing
            antiSpamState.isProcessing = false;
            
            // Hide loading overlay
            if (loadingOverlay) {
                loadingOverlay.classList.remove('active');
            }
            
            if (response.ok && responseData.success) {
                showNotification('Order placed successfully!', 'success');
                
                // Update the order hash for the successful order
                antiSpamState.lastOrderHash = antiSpamState.orderHash;
                
                // Reset click count after successful order
                antiSpamState.clickCount = 0;
                
                // Return success response
                resolve({
                    success: true,
                    orderId: responseData.orderId,
                    message: responseData.message || 'Order placed successfully'
                });
                
                // Check payment method and redirect accordingly
                const paymentMethod = orderData.payment_id;
                const orderId = responseData.orderId;
                console.log('orderId-----------------------------', orderId);
                
                if (paymentMethod === 1) {
                    // Online payment - redirect to VNPAY
                    // Convert totalAmount to integer (remove decimal places)
                    const totalAmountInteger = Math.round(orderData.TotalAmount);
                    console.log('Redirecting to VNPAY with amount:', totalAmountInteger);
                    
                    // Redirect to payment gateway
                    window.location.href = `/api/payment/create_payment?amount=${totalAmountInteger}`;
                } else {
                    // COD payment - redirect to order confirmation page
                    console.log('COD payment selected, redirecting to order confirmation page');
                    setTimeout(() => {
                        window.location.href = "/order/confirmation/" + orderId;
                    }, 1000);
                }
            } else {
                const errorMessage = responseData.message || 'Failed to place order';
                showNotification(errorMessage, 'error');
                reject(new Error(errorMessage));
            }
        } catch (error) {
            console.error('Error submitting order:', error);
            
            // Mark as no longer processing
            antiSpamState.isProcessing = false;
            
            // Hide loading overlay
            const loadingOverlay = document.getElementById('loadingOverlay');
            if (loadingOverlay) {
                loadingOverlay.classList.remove('active');
            }
            
            showNotification('Error submitting order: ' + error.message, 'error');
            reject(error);
        }
    });
}

// Export functions for global use
window.ghnState = ghnState;
window.initGHNIntegration = initGHNIntegration;
window.calculateShippingFee = calculateShippingFee;
window.updateAddressPreview = updateAddressPreview;
window.showNewAddressForm = showNewAddressForm;
window.hideNewAddressForm = hideNewAddressForm;
window.saveNewAddress = saveNewAddress;
window.loadStateFromStorage = loadStateFromStorage;
window.saveStateToStorage = saveStateToStorage;
window.reinitializeItemPrices = reinitializeItemPrices;
window.prepareOrderDataForAPI = prepareOrderDataForAPI;
window.submitOrderToAPI = submitOrderToAPI;
window.validateOrderForm = validateOrderForm;

/**
 * Discount Management System
 * This section handles the display and application of discount codes
 */

// Discount state
let discountState = {
    // Map of variant ID to selected discount
    selectedDiscounts: {},
    // Total discount amount
    totalDiscountAmount: 0,
    // Original prices of items
    itemPrices: {}
};

/**
 * Initialize discount system
 */
function initDiscountSystem() {
    console.log('Initializing discount system...');
    
    // Try to get allProductDiscountsData from global scope
    let discountData = {};
    
    try {
        // Try to get from window object
        if (typeof window.allProductDiscountsData !== 'undefined') {
            discountData = window.allProductDiscountsData;
        } else {
            // Try to get from hidden input
            const discountDataInput = document.getElementById('allProductDiscountsJson');
            if (discountDataInput && discountDataInput.value) {
                discountData = JSON.parse(discountDataInput.value);
            }
        }
        
        console.log('Discount data loaded:', discountData);
        
        // Populate discount codes for each item
        populateDiscountCodes(discountData);
        
        // Set up event listeners
        setupDiscountEventListeners();
        
        // Ensure prices are correctly initialized
        setTimeout(() => {
            reinitializeItemPrices();
        }, 500);
        
    } catch (error) {
        console.error('Error initializing discount system:', error);
    }
}

/**
 * Populate discount codes for each item
 * @param {Object} discountData - Discount data keyed by product ID
 */
function populateDiscountCodes(discountData) {
    // Get all cart items
    const cartItems = document.querySelectorAll('.cart-item');
    
    cartItems.forEach(item => {
        const productId = item.getAttribute('data-product-id');
        const variantId = parseInt(item.getAttribute('data-variant-id'));
        const discountContainer = item.querySelector('.discount-codes-container');
        
        if (!discountContainer) return;
        
        // Clear loading placeholder
        discountContainer.innerHTML = '';
        
        // Store original price - FIX: Lấy giá từ data-price attribute và nhân với số lượng
        const price = parseFloat(item.getAttribute('data-price') || '0');
        const quantity = parseInt(item.getAttribute('data-quantity') || '1');
        const totalPrice = price * quantity;
        discountState.itemPrices[variantId] = totalPrice;
        console.log(`Stored price for variant ${variantId}: ${price} × ${quantity} = ${totalPrice}`);
        
        // Get discounts for this product
        const productDiscounts = discountData[productId] || [];
        
        // Filter discounts for this variant
        const variantDiscounts = productDiscounts.filter(discount => 
            parseInt(discount.product_variant_id) === variantId
        );
        
        if (variantDiscounts.length === 0) {
            discountContainer.innerHTML = '<span class="text-xs text-gray-400">Không có mã giảm giá</span>';
            return;
        }
        
        // Sort discounts by percentage (highest first)
        variantDiscounts.sort((a, b) => b.discount_percentage - a.discount_percentage);
        
        // Create discount badges
        variantDiscounts.forEach(discount => {
            const isExpired = new Date(discount.end_date) < new Date();
            const isUsed = discount.used_at && discount.status !== 'available';
            
            const badgeClass = isExpired || isUsed ? 
                'expired' : 'available';
            
            const badgeElement = document.createElement('div');
            badgeElement.className = `discount-code-badge ${badgeClass}`;
            badgeElement.dataset.code = discount.discount_code;
            badgeElement.dataset.variantId = variantId;
            badgeElement.dataset.percentage = discount.discount_percentage;
            badgeElement.dataset.maxAmount = discount.max_discount_amount;
            badgeElement.dataset.minAmount = discount.totalminmoney;
            badgeElement.dataset.name = discount.discount_name;
            badgeElement.dataset.startDate = discount.start_date;
            badgeElement.dataset.endDate = discount.end_date;
            
            badgeElement.innerHTML = `
                <span class="code">${discount.discount_code}</span>
                <span class="percentage">${discount.discount_percentage}%</span>
            `;
            
            // Add tooltip with discount details
            const validityPeriod = `${formatDate(discount.start_date)} - ${formatDate(discount.end_date)}`;
            const maxDiscountText = discount.max_discount_amount ? 
                `Giảm tối đa: ${formatCurrency(discount.max_discount_amount)}` : '';
            const minOrderText = discount.totalminmoney ? 
                `Đơn hàng tối thiểu: ${formatCurrency(discount.totalminmoney)}` : '';
            
            badgeElement.setAttribute('title', `
                ${discount.discount_name}
                Giảm: ${discount.discount_percentage}%
                ${maxDiscountText}
                ${minOrderText}
                Hiệu lực: ${validityPeriod}
                ${isExpired ? 'Đã hết hạn' : ''}
                ${isUsed ? 'Đã sử dụng' : ''}
            `.trim());
            
            // Add click handler for valid discounts
            if (!isExpired && !isUsed) {
                badgeElement.addEventListener('click', () => {
                    toggleDiscountSelection(badgeElement, variantId, discount);
                });
            }
            
            discountContainer.appendChild(badgeElement);
        });
    });
}

/**
 * Toggle discount selection
 * @param {HTMLElement} badgeElement - The discount badge element
 * @param {number} variantId - Variant ID
 * @param {Object} discount - Discount data
 */
function toggleDiscountSelection(badgeElement, variantId, discount) {
    const container = badgeElement.closest('.discount-codes-container');
    const allBadges = container.querySelectorAll('.discount-code-badge');
    
    // Check if this discount is already selected
    const isSelected = badgeElement.classList.contains('selected');
    
    // Remove selection from all badges in this container
    allBadges.forEach(badge => {
        badge.classList.remove('selected');
    });
    
    // If it wasn't selected before, select it now
    if (!isSelected) {
        badgeElement.classList.add('selected');
        
        // Store selected discount
        discountState.selectedDiscounts[variantId] = {
            code: discount.discount_code,
            percentage: discount.discount_percentage,
            maxAmount: discount.max_discount_amount,
            minAmount: discount.totalminmoney,
            name: discount.discount_name
        };
    } else {
        // Remove from selected discounts
        delete discountState.selectedDiscounts[variantId];
    }
    
    // Update discount summary
    updateDiscountSummary();
}

/**
 * Update discount summary
 */
function updateDiscountSummary() {
    const appliedDiscountsContainer = document.getElementById('applied-discounts-container');
    const appliedDiscountsList = document.getElementById('applied-discounts-list');
    const discountAmountElement = document.getElementById('discount-amount');
    
    if (!appliedDiscountsContainer || !appliedDiscountsList || !discountAmountElement) {
        console.error('Discount summary elements not found');
        return;
    }
    
    // Clear current summary
    appliedDiscountsList.innerHTML = '';
    
    // Calculate total discount
    let totalDiscount = 0;
    const appliedDiscounts = [];
    
    console.log('Current itemPrices in updateDiscountSummary:', discountState.itemPrices);
    
    for (const variantId in discountState.selectedDiscounts) {
        const discount = discountState.selectedDiscounts[variantId];
        const itemPrice = discountState.itemPrices[variantId] || 0;
        
        console.log(`Calculating discount for variant ${variantId}: price=${itemPrice}, percentage=${discount.percentage}%`);
        
        // Calculate discount amount for this item
        let discountAmount = (itemPrice * discount.percentage) / 100;
        
        // Apply max discount cap if specified
        if (discount.maxAmount && discountAmount > discount.maxAmount) {
            discountAmount = discount.maxAmount;
            console.log(`Discount amount capped at ${discount.maxAmount}`);
        }
        
        // Add to total
        totalDiscount += discountAmount;
        console.log(`Discount amount for variant ${variantId}: ${discountAmount}, running total: ${totalDiscount}`);
        
        // Add to applied discounts list
        appliedDiscounts.push({
            variantId,
            code: discount.code,
            percentage: discount.percentage,
            amount: discountAmount,
            name: discount.name
        });
    }
    
    // Update discount amount display
    discountState.totalDiscountAmount = totalDiscount;
    discountAmountElement.textContent = `-${formatCurrency(totalDiscount)}`;
    
    // Show or hide applied discounts container
    if (appliedDiscounts.length > 0) {
        appliedDiscountsContainer.classList.remove('hidden');
        
        // Create discount summary items
        appliedDiscounts.forEach(discount => {
            const discountItem = document.createElement('div');
            discountItem.className = 'flex justify-between text-xs bg-blue-50 p-2 rounded';
            discountItem.innerHTML = `
                <div>
                    <span class="font-medium">${discount.code}</span>
                    <span class="text-gray-500 ml-1">(${discount.percentage}%)</span>
                </div>
                <span class="text-green-600">-${formatCurrency(discount.amount)}</span>
            `;
            
            appliedDiscountsList.appendChild(discountItem);
        });
    } else {
        appliedDiscountsContainer.classList.add('hidden');
    }
    
    // Update order total
    if (typeof updatePricing === 'function') {
        updatePricing();
    }
}

/**
 * Set up discount event listeners
 */
function setupDiscountEventListeners() {
    // Set up tooltip functionality
    setupDiscountTooltips();
    
    // Set up coupon code application
    const applyButton = document.getElementById('apply-coupon');
    const couponInput = document.getElementById('coupon-code');
    
    if (applyButton && couponInput) {
        applyButton.addEventListener('click', () => {
            const code = couponInput.value.trim().toUpperCase();
            if (!code) return;
            
            // Find matching discount badge
            const allBadges = document.querySelectorAll('.discount-code-badge');
            let matchingBadge = null;
            
            for (const badge of allBadges) {
                if (badge.dataset.code === code && !badge.classList.contains('expired')) {
                    matchingBadge = badge;
                    break;
                }
            }
            
            if (matchingBadge) {
                // Simulate click on matching badge
                matchingBadge.click();
                
                // Show success message
                showCouponMessage(`Mã giảm giá ${code} đã được áp dụng!`, 'success');
                
                // Update coupon status
                updateCouponStatus(true);
            } else {
                // Show error message
                showCouponMessage(`Mã giảm giá ${code} không hợp lệ hoặc đã hết hạn.`, 'error');
                
                // Update coupon status
                updateCouponStatus(false);
            }
        });
    }
}

/**
 * Set up discount tooltips
 */
function setupDiscountTooltips() {
    // Create tooltip element
    const tooltip = document.createElement('div');
    tooltip.className = 'discount-tooltip';
    document.body.appendChild(tooltip);
    
    // Add event listeners to discount badges
    document.addEventListener('mouseover', (e) => {
        if (e.target.closest('.discount-code-badge')) {
            const badge = e.target.closest('.discount-code-badge');
            const rect = badge.getBoundingClientRect();
            
            // Set tooltip content
            tooltip.innerHTML = `
                <div class="font-medium">${badge.dataset.name || 'Mã giảm giá'}</div>
                <div>Giảm: ${badge.dataset.percentage}%</div>
                ${badge.dataset.maxAmount ? `<div>Tối đa: ${formatCurrency(badge.dataset.maxAmount)}</div>` : ''}
                ${badge.dataset.minAmount ? `<div>Đơn tối thiểu: ${formatCurrency(badge.dataset.minAmount)}</div>` : ''}
                <div>Hiệu lực: ${formatDate(badge.dataset.startDate)} - ${formatDate(badge.dataset.endDate)}</div>
            `;
            
            // Position tooltip
            tooltip.style.left = rect.left + (rect.width / 2) + 'px';
            tooltip.style.top = rect.bottom + 8 + 'px';
            
            // Show tooltip
            tooltip.classList.add('visible');
        }
    });
    
    document.addEventListener('mouseout', (e) => {
        if (e.target.closest('.discount-code-badge')) {
            tooltip.classList.remove('visible');
        }
    });
}

/**
 * Show coupon message
 * @param {string} message - Message to display
 * @param {string} type - Message type (success, error)
 */
function showCouponMessage(message, type) {
    const couponMessage = document.getElementById('coupon-message');
    if (couponMessage) {
        couponMessage.textContent = message;
        couponMessage.classList.remove('hidden', 'text-green-600', 'text-red-600');
        
        if (type === 'success') {
            couponMessage.classList.add('text-green-600');
        } else {
            couponMessage.classList.add('text-red-600');
        }
    }
}

/**
 * Update coupon status indicators
 * @param {boolean} isValid - Whether the coupon is valid
 */
function updateCouponStatus(isValid) {
    const couponStatus = document.getElementById('coupon-status');
    const couponValid = document.getElementById('coupon-valid');
    const couponInvalid = document.getElementById('coupon-invalid');
    
    if (couponStatus) {
        couponStatus.classList.remove('hidden');
        
        if (couponValid && couponInvalid) {
            if (isValid) {
                couponValid.classList.remove('hidden');
                couponInvalid.classList.add('hidden');
            } else {
                couponValid.classList.add('hidden');
                couponInvalid.classList.remove('hidden');
            }
        }
    }
}

/**
 * Format currency
 * @param {number} amount - Amount to format
 * @returns {string} Formatted currency string
 */
function formatCurrency(amount) {
    return '$' + parseFloat(amount).toFixed(2);
}

/**
 * Format date
 * @param {string} dateString - Date string
 * @returns {string} Formatted date string
 */
function formatDate(dateString) {
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('vi-VN', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    } catch (e) {
        return dateString;
    }
}

/**
 * Reinitialize item prices from DOM data-price attributes
 * This function can be called to ensure prices are correctly loaded
 */
function reinitializeItemPrices() {
    console.log('Reinitializing item prices from DOM...');
    
    // Get all cart items
    const cartItems = document.querySelectorAll('.cart-item');
    
    cartItems.forEach(item => {
        const variantId = parseInt(item.getAttribute('data-variant-id'));
        const price = parseFloat(item.getAttribute('data-price') || '0');
        const quantity = parseInt(item.getAttribute('data-quantity') || '1');
        const totalPrice = price * quantity;
        
        if (!isNaN(variantId) && !isNaN(price)) {
            discountState.itemPrices[variantId] = totalPrice;
            console.log(`Reinitialized price for variant ${variantId}: ${price} × ${quantity} = ${totalPrice}`);
        } else {
            console.warn(`Failed to reinitialize price for variant ${variantId}: Invalid price value`);
        }
    });
    
    console.log('Current item prices after reinitialization:', discountState.itemPrices);
    
    // Update discount calculations
    updateDiscountSummary();
}

// Initialize discount system when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    try {
        const discountsInput = document.getElementById('allProductDiscountsJson');
        const idsInput = document.getElementById('allProductIdsJson');
        
        if (discountsInput && discountsInput.value) {
            allProductDiscountsData = JSON.parse(discountsInput.value);
        }
        
        if (idsInput && idsInput.value) {
            allProductIdsData = JSON.parse(idsInput.value);
        }
        
        // Log dữ liệu để debug
        console.log('Product discounts data loaded:', allProductDiscountsData);
        console.log('Product IDs data loaded:', allProductIdsData);
        
        // Mẫu dữ liệu cho trường hợp không có dữ liệu thực
        if (Object.keys(allProductDiscountsData).length === 0) {
            // Dữ liệu mẫu cho mã giảm giá
            allProductDiscountsData = {
                "1": [
                    {
                        "end_date": "Nov 30, 2025",
                        "used_at": "May 22, 2025, 9:08:51 PM",
                        "totalminmoney": 50000,
                        "discount_code": "SHOPZ62MCQJP",
                        "discount_name": "Chào thành viên mới",
                        "discount_percentage": 10,
                        "product_variant_id": 1,
                        "customer_id": 1017,
                        "discount_id": 3,
                        "start_date": "Jan 1, 2025",
                        "status": "available",
                        "max_discount_amount": 20000
                    }
                ]
            };
            
            console.log('Using sample discount data');
        }
        
        // Khởi tạo hệ thống giảm giá
        if (typeof initDiscountSystem === 'function') {
            initDiscountSystem();
            console.log('Discount system initialized');
        }
    } catch (error) {
        console.error('Error parsing JSON data:', error);
    }
}); 