// /**
//  * Order Controller
//  * Handles order form submission and processing
//  */

// // Configuration
// const API_ENDPOINTS = {
//     CREATE_ORDER: '/api/orders/create',
//     ORDER_CONFIRMATION: '/order/confirmation'
// };

// // Order controller object
// const OrderController = {
//     /**
//      * Initialize the order controller
//      */
//     init: function() {
//         console.log('Initializing Order Controller...');
//         this.bindEvents();
//     },
    
//     /**
//      * Bind event listeners
//      */
//     bindEvents: function() {
//         const placeOrderBtn = document.getElementById('test-order-data');
        
//         if (placeOrderBtn) {
//             placeOrderBtn.addEventListener('click', this.handlePlaceOrderClick.bind(this));
//         }
//     },
    
//     /**
//      * Handle place order button click
//      * @param {Event} event - Click event
//      */
//     handlePlaceOrderClick: async function(event) {
//         event.preventDefault();
        
//         try {
//             // First validate the form
//             const validation = this.validateOrderForm();
//             if (!validation.isValid) {
//                 window.showNotification(validation.message, 'error');
//                 return;
//             }
            
//             // Show loading overlay
//             this.showLoadingOverlay(true);
            
//             // Prepare order data
//             const orderData = this.prepareOrderData();
//             if (!orderData.success) {
//                 window.showNotification(orderData.message, 'error');
//                 this.showLoadingOverlay(false);
//                 return;
//             }
            
//             // Submit the order
//             const result = await this.submitOrder(orderData.data);
            
//             // Handle the result
//             if (result.success) {
//                 window.showNotification('Order placed successfully!', 'success');
                
//                 // Redirect to order confirmation page after a short delay
//                 setTimeout(() => {
//                     window.location.href = `${API_ENDPOINTS.ORDER_CONFIRMATION}/${result.orderId}`;
//                 }, 2000);
//             } else {
//                 window.showNotification(result.message || 'Failed to place order', 'error');
//             }
//         } catch (error) {
//             console.error('Error in order processing:', error);
//             window.showNotification(`Error: ${error.message}`, 'error');
//         } finally {
//             // Hide loading overlay
//             this.showLoadingOverlay(false);
//         }
//     },
    
//     /**
//      * Show or hide loading overlay
//      * @param {boolean} show - Whether to show or hide the overlay
//      */
//     showLoadingOverlay: function(show) {
//         const loadingOverlay = document.getElementById('loadingOverlay');
//         if (loadingOverlay) {
//             if (show) {
//                 loadingOverlay.classList.add('active');
//             } else {
//                 loadingOverlay.classList.remove('active');
//             }
//         }
//     },
    
//     /**
//      * Validate the order form
//      * @returns {Object} Validation result
//      */
//     validateOrderForm: function() {
//         // Use the validateOrderForm function from ghn-integration.js if available
//         if (typeof window.validateOrderForm === 'function') {
//             return window.validateOrderForm();
//         }
        
//         // Fallback validation if the function is not available
//         const fullName = document.getElementById('fullName')?.value || '';
//         if (!fullName.trim()) {
//             return { isValid: false, message: 'Please enter your full name' };
//         }
        
//         const email = document.getElementById('email')?.value || '';
//         if (!email.trim() || !email.includes('@')) {
//             return { isValid: false, message: 'Please enter a valid email address' };
//         }
        
//         const phone = document.getElementById('phone')?.value || '';
//         if (!phone.trim() || phone.length < 10) {
//             return { isValid: false, message: 'Please enter a valid phone number' };
//         }
        
//         // Validate shipping address
//         const ghnState = window.ghnState || {};
//         if (!ghnState.selectedAddressId || !ghnState.savedAddresses?.some(addr => addr.id === ghnState.selectedAddressId)) {
//             return { isValid: false, message: 'Please select a shipping address' };
//         }
        
//         // Validate payment method
//         if (!document.querySelector('.payment-method.selected')) {
//             return { isValid: false, message: 'Please select a payment method' };
//         }
        
//         return { isValid: true };
//     },
    
//     /**
//      * Prepare order data for submission
//      * @returns {Object} Order data
//      */
//     prepareOrderData: function() {
//         // Use the prepareOrderDataForAPI function from ghn-integration.js if available
//         if (typeof window.prepareOrderDataForAPI === 'function') {
//             return window.prepareOrderDataForAPI();
//         }
        
//         // Fallback implementation if the function is not available
//         try {
//             const ghnState = window.ghnState || {};
//             const discountState = window.discountState || { totalDiscountAmount: 0, selectedDiscounts: {} };
            
//             // Get customer information
//             const customerId = parseInt(document.getElementById('customerId')?.value || '0');
//             const fullName = document.getElementById('fullName')?.value || '';
//             const email = document.getElementById('email')?.value || '';
//             const phone = document.getElementById('phone')?.value || '';
            
//             // Get selected address
//             const selectedAddress = ghnState.savedAddresses?.find(addr => addr.id === ghnState.selectedAddressId);
//             if (!selectedAddress) {
//                 throw new Error('Please select a shipping address');
//             }
            
//             // Extract address components
//             const addressParts = selectedAddress.address.split(',');
//             const street = addressParts[0]?.trim() || '';
            
//             // Get payment method (1 = Online Payment, 2 = COD)
//             const paymentId = document.getElementById('payment-method-1').classList.contains('selected') ? 1 : 2;
            
//             // Get order items
//             const orderItems = [];
            
//             document.querySelectorAll('.cart-item').forEach(item => {
//                 const variantId = parseInt(item.getAttribute('data-variant-id'));
//                 const quantity = parseInt(item.getAttribute('data-quantity') || '1');
                
//                 if (!isNaN(variantId) && !isNaN(quantity)) {
//                     orderItems.push({
//                         product_variant_id: variantId,
//                         quantity: quantity
//                     });
//                 }
//             });
            
//             if (orderItems.length === 0) {
//                 throw new Error('No items in cart');
//             }
            
//             // Get variant IDs with applied discounts
//             const productVariantIdsWithDiscount = [];
            
//             // Get variant IDs that have discounts applied from discountState.selectedDiscounts
//             for (const variantId in discountState.selectedDiscounts) {
//                 if (discountState.selectedDiscounts.hasOwnProperty(variantId)) {
//                     productVariantIdsWithDiscount.push(variantId);
//                 }
//             }
            
//             console.log('Variants with applied discounts:', productVariantIdsWithDiscount);
            
//             // Calculate total amount
//             const subtotalElement = document.getElementById('cart-subtotal');
//             let subtotal = 0;
            
//             if (subtotalElement) {
//                 const subtotalText = subtotalElement.textContent;
//                 // Extract numeric value from format like "$498.00"
//                 subtotal = parseFloat(subtotalText.replace(/[^\d.-]/g, '')) || 0;
//             }
            
//             // Get shipping fee
//             const shippingFee = ghnState.shippingFeeValue || 0;
            
//             // Check if VAT is applied
//             const hasVat = document.getElementById('vatBtn').classList.contains('active');
//             const tax = hasVat ? (subtotal + shippingFee) * 0.08 : 0;
            
//             // Get discount amount
//             const discount = discountState.totalDiscountAmount || 0;
            
//             // Calculate final total
//             const totalAmount = subtotal + shippingFee + tax - discount;
            
//             // Prepare final order data object
//             const orderData = {
//                 customer_id: customerId,
//                 payment_id: paymentId,
//                 TotalAmount: totalAmount,
//                 OrderItems: orderItems,
//                 AddressId: selectedAddress.id,
//                 recipient_name: fullName,
//                 recipient_phone: phone,
//                 Street: street,
//                 ProvinceId: selectedAddress.provinceId,
//                 DistrictId: selectedAddress.districtId,
//                 WardId: selectedAddress.wardCode,
//                 Country: 'Việt Nam',
//                 ProductVariantIds: productVariantIdsWithDiscount.join(',')
//             };
            
//             console.log('Order data prepared successfully:', orderData);
//             return {
//                 success: true,
//                 data: orderData
//             };
//         } catch (error) {
//             console.error('Error preparing order data:', error);
//             return {
//                 success: false,
//                 message: error.message
//             };
//         }
//     },
    
//     /**
//      * Submit order to the API
//      * @param {Object} orderData - Order data to submit
//      * @returns {Promise<Object>} API response
//      */
//     submitOrder: async function(orderData) {
//         try {
//             // Submit order to API
//             const response = await fetch(API_ENDPOINTS.CREATE_ORDER, {
//                 method: 'POST',
//                 headers: {
//                     'Content-Type': 'application/json'
//                 },
//                 body: JSON.stringify(orderData)
//             });
            
//             const responseData = await response.json();
            
//             if (response.ok && responseData.success) {
//                 return {
//                     success: true,
//                     orderId: responseData.orderId,
//                     message: responseData.message || 'Order placed successfully'
//                 };
//             } else {
//                 return {
//                     success: false,
//                     message: responseData.message || 'Failed to place order'
//                 };
//             }
//         } catch (error) {
//             console.error('Error submitting order:', error);
//             return {
//                 success: false,
//                 message: error.message || 'Network error while submitting order'
//             };
//         }
//     }
// };

// // Initialize the controller when the DOM is loaded
// document.addEventListener('DOMContentLoaded', function() {
//     OrderController.init();
// }); 