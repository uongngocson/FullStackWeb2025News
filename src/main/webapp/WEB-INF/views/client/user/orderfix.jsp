<%@page contentType="text/html" pageEncoding="UTF-8" deferredSyntaxAllowedAsLiteral="true" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Checkout | Luxury Boutique</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Cormorant+Garamond:wght@400;500;600&display=swap" rel="stylesheet">
            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
            
            <!-- Add Axios for API calls -->
            <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
            
            <style>
                * {
                    font-family: 'Inter', sans-serif;
                }
                
                .serif {
                    font-family: 'Cormorant Garamond', serif;
                }
                
                .input-field {
                    border: 1px solid #e5e7eb;
                    border-radius: 12px;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    background: linear-gradient(145deg, #ffffff, #f8fafc);
                    backdrop-filter: blur(10px);
                }
                
                .input-field:focus {
                    outline: none;
                    border-color: #3b82f6;
                    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1), 0 8px 25px -5px rgba(0, 0, 0, 0.1);
                    transform: translateY(-1px);
                }
                
                .glass-card {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(20px);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                }
                
                .payment-method {
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    background: linear-gradient(145deg, #ffffff, #f8fafc);
                    border: 2px solid #e5e7eb;
                }
                
                .payment-method:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                    border-color: #3b82f6;
                }
                
                .payment-method.selected {
                    border-color: #3b82f6;
                    background: linear-gradient(145deg, #eff6ff, #dbeafe);
                    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
                }
                
                .payment-method.selected .radio-dot {
                    background: linear-gradient(145deg, #3b82f6, #1d4ed8);
                    transform: scale(1);
                }
                
                .radio-dot {
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    transform: scale(0);
                }
                
                .select-wrapper {
                    position: relative;
                }
                
                .select-wrapper select {
                    appearance: none;
                    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
                    background-position: right 12px center;
                    background-repeat: no-repeat;
                    background-size: 16px;
                    padding-right: 40px;
                }
                
                .floating-label {
                    position: absolute;
                    left: 12px;
                    top: 50%;
                    transform: translateY(-50%);
                    background: white;
                    padding: 0 8px;
                    color: #6b7280;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    pointer-events: none;
                    font-size: 14px;
                }
                
                .input-field:focus + .floating-label,
                .input-field:not(:placeholder-shown) + .floating-label {
                    top: 0;
                    font-size: 12px;
                    color: #3b82f6;
                    transform: translateY(-50%);
                }
                
                .address-section {
                    background: linear-gradient(145deg, #f8fafc, #ffffff);
                    border: 1px solid #e5e7eb;
                    border-radius: 16px;
                    position: relative;
                    overflow: hidden;
                }
                
                .address-section::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 4px;
                    background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
                }
                
                .btn-primary {
                    background: linear-gradient(145deg, #3b82f6, #1d4ed8);
                    border: none;
                    border-radius: 12px;
                    color: white;
                    font-weight: 600;
                    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    box-shadow: 0 10px 20px -5px rgba(59, 130, 246, 0.3);
                }
                
                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 20px 25px -5px rgba(59, 130, 246, 0.4);
                }
                
                .btn-primary:active {
                    transform: translateY(0);
                }
                
                .order-summary {
                    background: linear-gradient(145deg, #ffffff, #f8fafc);
                    border: 1px solid rgba(255, 255, 255, 0.2);
                    border-radius: 20px;
                    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
                    position: sticky;
                    top: 100px;
                }
                
                .checkout-grid {
                    max-width: 1400px;
                    margin: 0 auto;
                    padding: 0 24px;
                }
                
                .loading-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(0, 0, 0, 0.5);
                    backdrop-filter: blur(4px);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    z-index: 9999;
                    opacity: 0;
                    visibility: hidden;
                    transition: all 0.3s ease;
                }
                
                .loading-overlay.active {
                    opacity: 1;
                    visibility: visible;
                }
                
                .spinner {
                    width: 40px;
                    height: 40px;
                    border: 4px solid #f3f4f6;
                    border-top: 4px solid #3b82f6;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                }
                
                @keyframes spin {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }
                
                .cart-item {
                    transition: all 0.3s ease;
                    border-radius: 12px;
                    padding: 16px;
                    margin-bottom: 12px;
                    background: linear-gradient(145deg, #ffffff, #f8fafc);
                }
                
                .cart-item:hover {
                    transform: translateX(4px);
                    box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.1);
                }
                
                .tax-option-btn {
                    border-radius: 8px;
                    transition: all 0.3s ease;
                    border: 2px solid #e5e7eb;
                }
                
                .tax-option-btn.active {
                    background: linear-gradient(145deg, #1f2937, #111827);
                    color: white;
                    border-color: #1f2937;
                    transform: translateY(-1px);
                    box-shadow: 0 10px 20px -5px rgba(31, 41, 55, 0.3);
                }
                
                .section-header {
                    position: relative;
                    padding-bottom: 12px;
                    margin-bottom: 24px;
                }
                
                .section-header::after {
                    content: '';
                    position: absolute;
                    bottom: 0;
                    left: 0;
                    width: 60px;
                    height: 3px;
                    background: linear-gradient(90deg, #3b82f6, #8b5cf6);
                    border-radius: 2px;
                }
                
                .form-row {
                    display: grid;
                    grid-template-columns: 1fr 1fr 1fr;
                    gap: 16px;
                }
                
                @media (max-width: 768px) {
                    .form-row {
                        grid-template-columns: 1fr;
                    }
                    
                    .checkout-grid {
                        grid-template-columns: 1fr;
                    }
                }
                
                .pulse-animation {
                    animation: pulse 2s infinite;
                }
                
                @keyframes pulse {
                    0%, 100% { opacity: 1; }
                    50% { opacity: 0.7; }
                }
                
                /* Add loading animation for selects */
                .select-wrapper .loading {
                    background-image: 
                        linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%) !important;
                    background-size: 200% 100% !important;
                    animation: loading 1.5s infinite !important;
                }
                
                @keyframes loading {
                    0% { background-position: 200% 0; }
                    100% { background-position: -200% 0; }
                }
            </style>
        </head>
        
        
        <body class="min-h-screen bg-gradient-to-br from-gray-50 via-blue-50 to-purple-50">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Loading Overlay -->
            <div class="loading-overlay" id="loadingOverlay">
                <div class="text-center">
                    <div class="spinner"></div>
                    <p class="text-white mt-4 font-medium">Processing your order...</p>
                </div>
            </div>
        
            <!-- Header -->
            <header class="text-center mb-12 pt-16">
                <h1 class="serif text-5xl font-bold mb-4 bg-gradient-to-r from-gray-900 via-blue-900 to-purple-900 bg-clip-text text-transparent">
                    Luxury Checkout
                </h1>
                <p class="text-gray-600 text-lg">Complete your purchase with elegance and style</p>
                
                <!-- Error message display -->
                <c:if test="${not empty errorMessage}">
                    <div class="mt-4 mx-auto max-w-md p-4 bg-red-50 border border-red-200 rounded-xl text-red-700">
                        <p class="font-medium">
                            <span class="mr-2">⚠️</span>
                            ${errorMessage}
                        </p>
                    </div>
                </c:if>
            </header>

            
        
            <!-- Main Content Grid -->
            <div class="grid checkout-grid gap-12 lg:grid-cols-2">
                <!-- Left Column - Billing & Shipping -->
                <div class="space-y-8">
                    <!-- Contact Information -->
                    <section class="glass-card p-8 rounded-2xl">
                        <h2 class="serif text-2xl font-semibold mb-6 section-header">Contact Information</h2>
                        <div class="space-y-6">
                            <div class="relative">
                                <input type="text" id="fullName" class="input-field w-full py-4 px-4 bg-transparent" 
                                       placeholder=" " value="John Smith">
                                <label class="floating-label">Full Name</label>
                            </div>
                            
                            <input type="hidden" id="customerId" value="123">
                            
                            <div class="relative">
                                <input type="email" id="email" class="input-field w-full py-4 px-4 bg-transparent" 
                                       placeholder=" " value="john@example.com">
                                <label class="floating-label">Email Address</label>
                            </div>
                            
                            <div class="relative">
                                <input type="tel" id="phone" class="input-field w-full py-4 px-4 bg-transparent" 
                                       placeholder=" " value="+1 (123) 456-7890">
                                <label class="floating-label">Phone Number</label>
                            </div>
                        </div>
                    </section>
        
                    <!-- Shipping Address Section -->
                    <section class="address-section p-8">
                        <h2 class="serif text-2xl font-semibold mb-6 section-header">Shipping Address</h2>
                        
                        <!-- Address Detail -->
                        <div class="mb-6">
                            <div class="relative">
                                <textarea id="addressDetail" class="input-field w-full py-4 px-4 bg-transparent resize-none" 
                                          rows="3" placeholder=" "></textarea>
                                <label class="floating-label">Address Detail (Street, Building, Apartment)</label>
                            </div>
                        </div>
        
                        <!-- Location Selects - Updated for GHN API -->
                        <div class="form-row">
                            <div class="relative select-wrapper">
                                <select id="province" class="input-field w-full py-4 px-4 bg-transparent">
                                    <option value="">Select Province</option>
                                    <c:forEach items="${provinces}" var="province">
                                        <option value="${province.provinceId}">${province.provinceName}</option>
                                    </c:forEach>
                                </select>
                                <label class="floating-label">Province/City</label>
                            </div>
                            
                            <div class="relative select-wrapper">
                                <select id="district" class="input-field w-full py-4 px-4 bg-transparent" disabled>
                                    <option value="">Select District</option>
                                </select>
                                <label class="floating-label">District</label>
                            </div>
                            
                            <div class="relative select-wrapper">
                                <select id="ward" class="input-field w-full py-4 px-4 bg-transparent" disabled>
                                    <option value="">Select Ward</option>
                                </select>
                                <label class="floating-label">Ward</label>
                            </div>
                        </div>
        
                        <!-- Address Preview -->
                        <div id="addressPreview" class="mt-6 p-4 bg-blue-50 border border-blue-200 rounded-xl hidden">
                            <h4 class="font-semibold text-blue-900 mb-2">📍 Complete Address:</h4>
                            <p id="fullAddress" class="text-blue-800"></p>
                        </div>
                        
                        <!-- GHN Shipping Fee Status (Hidden initially) -->
                        <div id="shipping-fee-container" class="mt-4 p-4 bg-green-50 border border-green-200 rounded-xl hidden">
                            <h4 class="font-semibold text-green-900 mb-2">🚚 Shipping Information:</h4>
                            <p class="text-green-800">
                                Service: <span id="shipping-service-name">Standard</span><br>
                                Estimated delivery: <span id="shipping-delivery-time">2-3 days</span>
                            </p>
                        </div>
                    </section>
        
                    <!-- Payment Method -->
                    <section class="glass-card p-8 rounded-2xl">
                        <h2 class="serif text-2xl font-semibold mb-6 section-header">Payment Method</h2>
                        <div class="space-y-4">
                            <div id="payment-method-1" class="payment-method p-6 rounded-xl cursor-pointer">
                                <div class="flex items-center">
                                    <div class="w-6 h-6 rounded-full border-2 border-gray-300 flex items-center justify-center mr-4">
                                        <div class="w-3 h-3 rounded-full radio-dot"></div>
                                    </div>
                                    <div class="flex-1">
                                        <div class="font-semibold text-gray-900">💳 Online Payment</div>
                                        <p class="text-sm text-gray-600 mt-1">Pay securely with your credit card or digital wallet</p>
                                    </div>
                                    <div class="text-2xl">🔒</div>
                                </div>
                            </div>
        
                            <div id="payment-method-2" class="payment-method p-6 rounded-xl cursor-pointer">
                                <div class="flex items-center">
                                    <div class="w-6 h-6 rounded-full border-2 border-gray-300 flex items-center justify-center mr-4">
                                        <div class="w-3 h-3 rounded-full radio-dot"></div>
                                    </div>
                                    <div class="flex-1">
                                        <div class="font-semibold text-gray-900">🚚 Cash on Delivery</div>
                                        <p class="text-sm text-gray-600 mt-1">Pay when you receive your order</p>
                                    </div>
                                    <div class="text-2xl">💵</div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
        
                <!-- Right Column - Order Summary -->
                <div>
                    <div class="order-summary p-8">
                        <h2 class="serif text-2xl font-semibold mb-6 section-header">Order Summary</h2>
        
                        <!-- Cart Items -->
                         
                        <div class="space-y-4 mb-8">
                            <c:forEach items="${items}" var="item">
                            <div class="cart-item">
                                <div class="flex items-center">
                                    <div class="w-20 h-20 bg-gradient-to-br from-gray-200 to-gray-300 rounded-xl mr-4 overflow-hidden">
                                        <img src="${item.variant.imageUrl}" 
                                             alt="Product" class="w-full h-full object-cover">
                                    </div>
                                    <div class="flex-1">
                                        <h3 class="font-semibold text-gray-900">                                            ${item.variant.product.productName}
                                        </h3>
                                        <p class="text-sm text-gray-600">${item.variant.color.colorName} /
                                            ${item.variant.size.sizeName}</p>
                                        <p class="text-sm text-gray-500 mt-1">Qty: ${item.quantity}</p>
                                    </div>
                                    <div class="text-right">
                                        <p class="font-semibold">$${item.variant.product.price}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>        
                            
                      
        
                        <!-- Tax Options -->
                        <div class="mb-8">
                            <label class="block text-sm font-medium text-gray-700 mb-3">Tax Options</label>
                            <div class="flex space-x-3">
                                <button id="noVatBtn" class="tax-option-btn px-6 py-3 text-sm font-medium">
                                    No VAT
                                </button>
                                <button id="vatBtn" class="tax-option-btn px-6 py-3 text-sm font-medium active">
                                    With VAT (8%)
                                </button>
                            </div>
                        </div>
        
                        <!-- Order Totals -->
                        <div class="space-y-4 mb-8">
                            <div class="flex justify-between text-gray-600">
                                <span>Subtotal</span>
                                <span id="cart-subtotal">$498.00</span>
                            </div>
        
                            <div class="flex justify-between text-gray-600">
                                <span>Shipping</span>
                                <span id="shipping-cost-summary">$0</span>
                            </div>
        
                            <div class="flex justify-between text-gray-600">
                                <span>Tax (8%)</span>
                                <span id="tax-amount">$39.84</span>
                            </div>

                            <!-- Coupon Code Section -->
                            <div class="mt-6 mb-4">
                                <div class="flex items-center">
                                    <h3 class="text-sm font-medium text-gray-700 mb-2">Discount Code</h3>
                                    <div id="coupon-badge" class="hidden ml-2 px-2 py-1 text-xs font-medium rounded-full"></div>
                                </div>
                                <div class="flex">
                                    <div class="relative flex-grow">
                                        <input type="text" id="coupon-code" 
                                            class="input-field w-full py-3 px-4 bg-transparent pr-12" 
                                            placeholder="Enter code">
                                        <div id="coupon-status" class="absolute right-3 top-1/2 transform -translate-y-1/2 hidden">
                                            <span id="coupon-valid" class="text-green-500 hidden">✓</span>
                                            <span id="coupon-invalid" class="text-red-500 hidden">✗</span>
                                        </div>
                                    </div>
                                    <button id="apply-coupon" 
                                        class="ml-2 px-4 py-2 bg-gradient-to-br from-gray-800 to-gray-900 text-white rounded-lg text-sm font-medium hover:from-gray-700 hover:to-gray-800 transition-all">
                                        Apply
                                    </button>
                                </div>
                                <div id="coupon-message" class="mt-2 text-xs hidden"></div>
                            </div>
        
                            <div class="flex justify-between text-gray-600">
                                <span>Discount</span>
                                <span id="discount-amount" class="text-green-600">-$0.00</span>
                            </div>
        
                            <div class="border-t border-gray-200 pt-4">
                                <div class="flex justify-between text-xl font-bold text-gray-900">
                                    <span>Total</span>
                                    <span id="total-with-discount">$552.84</span>
                                </div>
                            </div>
                        </div>
        
                        <!-- Place Order Button -->
                        <button id="test-order-data" class="btn-primary w-full py-4 px-6 text-lg font-semibold">
                            🛍️ Place Order
                        </button>
        
                        <!-- Security Notice -->
                        <div class="mt-6 text-center">
                            <div class="flex items-center justify-center space-x-2 text-sm text-gray-500">
                                <span>🔒</span>
                                <span>Secure checkout. Your information is protected.</span>
                            </div>
                        </div>
                    </div>
        
                    <!-- Policies -->
                    <div class="mt-8 text-center text-sm text-gray-500">
                        <p class="mb-3">
                            By placing your order, you agree to our 
                            <a href="#" class="text-blue-600 hover:underline">Terms of Service</a> and 
                            <a href="#" class="text-blue-600 hover:underline">Privacy Policy</a>.
                        </p>
                        <p>
                            Need help? 
                            <a href="#" class="text-blue-600 hover:underline font-medium">Contact our support team</a>
                        </p>
                    </div>
                </div>

                
            </div>

            </div>
            <jsp:include page="../layout/footer.jsp" />




            


               
            

            
            <!-- Main script with initialization functions and event handlers -->
            <script>
                // Tax button handlers
                const noVatBtn = document.getElementById('noVatBtn');
                const vatBtn = document.getElementById('vatBtn');
                let selectedPaymentMethod = null;
                
                // Define updatePricing function first
                function updatePricing() {
                    const subtotal = 498.00;
                    const shipping = window.ghnState && window.ghnState.shippingFeeValue ? 
                        window.ghnState.shippingFeeValue : 0;
                    
                    const hasVat = vatBtn.classList.contains('active');
                    const tax = hasVat ? subtotal * 0.08 : 0;
                    
                    // Calculate discount if present
                    const discountElement = document.getElementById('discount-amount');
                    const discountText = discountElement ? discountElement.textContent : '-$0.00';
                    const discount = parseFloat(discountText.replace(/[^\d.-]/g, '')) || 0;
                    
                    const total = subtotal + shipping + tax - discount;
                    
                    document.getElementById('cart-subtotal').textContent = '$' + subtotal.toFixed(2);
                    document.getElementById('shipping-cost-summary').textContent = '$' + shipping.toFixed(2);
                    document.getElementById('tax-amount').textContent = '$' + tax.toFixed(2);
                    document.getElementById('total-with-discount').textContent = '$' + total.toFixed(2);
                }
                
                // Payment method selection
                document.addEventListener('DOMContentLoaded', function() {
                    // Setup payment method selection
                    const paymentMethods = document.querySelectorAll('.payment-method');
                    
                    paymentMethods.forEach(method => {
                        method.addEventListener('click', function() {
                            paymentMethods.forEach(m => m.classList.remove('selected'));
                            this.classList.add('selected');
                            selectedPaymentMethod = this.id;
                        });
                    });
                    
                    // VAT button event listeners
                    if (noVatBtn) {
                        noVatBtn.addEventListener('click', function() {
                            noVatBtn.classList.add('active');
                            vatBtn.classList.remove('active');
                            updatePricing(); // Update pricing when VAT option changes
                        });
                    }
                    
                    if (vatBtn) {
                        vatBtn.addEventListener('click', function() {
                            vatBtn.classList.add('active');
                            noVatBtn.classList.remove('active');
                            updatePricing(); // Update pricing when VAT option changes
                        });
                    }
                    
                    // Initialize pricing on page load
                    updatePricing();
                });
            </script>
            
            <!-- Import GHN Integration JavaScript -->
            <script src="/resources/js/ghn-integration.js"></script>
        
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    // Initialize GHN integration with token and shop ID
                    if (typeof initGHNIntegration === 'function') {
                        initGHNIntegration("${ghnToken}", "${shopId}");
                        console.log('GHN integration initialized');
                    } else {
                        console.error('GHN integration script not loaded properly');
                    }
                });
            </script>

            
        </body>
        
        </html>

        