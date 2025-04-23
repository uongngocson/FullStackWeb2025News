<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Checkout | Luxury Boutique</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet"
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=Montserrat:wght@300;400;500&display=swap">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/order.css">
            </head>

            <body class="min-h-screen">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Header -->
                <header class="text-center mb-12 pt-[64px]">
                    <h1 class="serif text-4xl font-medium mb-2">Checkout</h1>
                    <p class="text-gray-500">Complete your purchase with elegance</p>
                </header>

                <!-- Main Content Grid -->
                <div class="grid checkout-grid gap-12 md:grid-cols-2">
                    <!-- Left Column - Billing & Shipping -->
                    <div class="space-y-8">
                        <!-- Contact Information -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Contact Information
                            </h2>
                            <div class="space-y-4">
                                <div>
                                    <label for="fullName" class="block text-sm text-gray-600 mb-1">Full Name</label>
                                    <input type="text" id="fullName" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="John Smith">
                                </div>
                                <div>
                                    <label for="email" class="block text-sm text-gray-600 mb-1">Email Address</label>
                                    <input type="email" id="email" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="john@example.com">
                                </div>
                                <div>
                                    <label for="phone" class="block text-sm text-gray-600 mb-1">Phone Number</label>
                                    <input type="tel" id="phone" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="+1 (123) 456-7890">
                                </div>
                            </div>
                        </section>

                        <!-- Shipping Address -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Shipping Address
                            </h2>
                            <div class="space-y-4">
                                <div>
                                    <label for="address" class="block text-sm text-gray-600 mb-1">Street Address</label>
                                    <input type="text" id="address" class="input-field w-full py-2 px-1 bg-transparent"
                                        placeholder="123 Main St">
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label for="city" class="block text-sm text-gray-600 mb-1">City</label>
                                        <input type="text" id="city" class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="New York">
                                    </div>
                                    <div>
                                        <label for="state"
                                            class="block text-sm text-gray-600 mb-1">State/Province</label>
                                        <input type="text" id="state"
                                            class="input-field w-full py-2 px-1 bg-transparent" placeholder="NY">
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label for="postalCode" class="block text-sm text-gray-600 mb-1">Postal
                                            Code</label>
                                        <input type="text" id="postalCode"
                                            class="input-field w-full py-2 px-1 bg-transparent" placeholder="10001">
                                    </div>
                                    <div>
                                        <label for="country" class="block text-sm text-gray-600 mb-1">Country</label>
                                        <select id="country" class="input-field w-full py-2 px-1 bg-transparent">
                                            <option value="">Select Country</option>
                                            <option value="US">United States</option>
                                            <option value="UK">United Kingdom</option>
                                            <option value="CA">Canada</option>
                                            <option value="AU">Australia</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Billing Address -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Billing Address
                            </h2>
                            <div class="flex items-center mb-4">
                                <input type="checkbox" id="sameAsShipping" class="mr-2">
                                <label for="sameAsShipping" class="text-sm text-gray-600">Same as shipping
                                    address</label>
                            </div>
                            <div id="billingFields" class="space-y-4 hidden">
                                <div>
                                    <label for="billingAddress" class="block text-sm text-gray-600 mb-1">Street
                                        Address</label>
                                    <input type="text" id="billingAddress"
                                        class="input-field w-full py-2 px-1 bg-transparent" placeholder="123 Main St">
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label for="billingCity" class="block text-sm text-gray-600 mb-1">City</label>
                                        <input type="text" id="billingCity"
                                            class="input-field w-full py-2 px-1 bg-transparent" placeholder="New York">
                                    </div>
                                    <div>
                                        <label for="billingState"
                                            class="block text-sm text-gray-600 mb-1">State/Province</label>
                                        <input type="text" id="billingState"
                                            class="input-field w-full py-2 px-1 bg-transparent" placeholder="NY">
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label for="billingPostalCode" class="block text-sm text-gray-600 mb-1">Postal
                                            Code</label>
                                        <input type="text" id="billingPostalCode"
                                            class="input-field w-full py-2 px-1 bg-transparent" placeholder="10001">
                                    </div>
                                    <div>
                                        <label for="billingCountry"
                                            class="block text-sm text-gray-600 mb-1">Country</label>
                                        <select id="billingCountry" class="input-field w-full py-2 px-1 bg-transparent">
                                            <option value="">Select Country</option>
                                            <option value="US">United States</option>
                                            <option value="UK">United Kingdom</option>
                                            <option value="CA">Canada</option>
                                            <option value="AU">Australia</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Payment Method -->
                        <section>
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Payment Method</h2>
                            <div class="space-y-4">


                                <div class="payment-method p-4 border rounded cursor-pointer">
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 rounded-full border flex items-center justify-center mr-3">
                                            <div class="w-4 h-4 rounded-full bg-transparent"></div>
                                        </div>
                                        <span>Thanh toán online</span>
                                    </div>
                                </div>

                                <div class="payment-method p-4 border rounded cursor-pointer">
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 rounded-full border flex items-center justify-center mr-3">
                                            <div class="w-4 h-4 rounded-full bg-transparent"></div>
                                        </div>
                                        <span>Thanh toán khi nhận hàng</span>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </div>

                    <!-- Right Column - Order Summary -->
                    <div>
                        <div class="bg-white p-6 shadow-sm">
                            <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Order Summary</h2>

                            <!-- Cart Items -->
                            <div class="space-y-4 mb-6">
                                <div class="flex items-center py-3 border-b border-gray-100">
                                    <div class="w-16 h-16 bg-gray-100 mr-4"></div>
                                    <div class="flex-1">
                                        <h3 class="text-sm font-medium">Cashmere Sweater</h3>
                                        <p class="text-xs text-gray-500">Black / L</p>
                                    </div>
                                    <div class="text-right">
                                        <p class="text-sm">$295.00</p>
                                        <p class="text-xs text-gray-500">Qty: 1</p>
                                    </div>
                                </div>
                                <div class="flex items-center py-3 border-b border-gray-100">
                                    <div class="w-16 h-16 bg-gray-100 mr-4"></div>
                                    <div class="flex-1">
                                        <h3 class="text-sm font-medium">Silk Scarf</h3>
                                        <p class="text-xs text-gray-500">Navy Blue</p>
                                    </div>
                                    <div class="text-right">
                                        <p class="text-sm">$125.00</p>
                                        <p class="text-xs text-gray-500">Qty: 2</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Promo Code -->
                            <div class="mb-6">
                                <label for="promoCode" class="block text-sm text-gray-600 mb-2">Promo Code</label>
                                <div class="flex">
                                    <input type="text" id="promoCode"
                                        class="input-field flex-1 py-2 px-3 bg-transparent border"
                                        placeholder="Enter code">
                                    <button class="bg-black text-white px-4 py-2 text-sm ml-2">Apply</button>
                                </div>
                            </div>

                            <!-- Order Totals -->
                            <div class="space-y-3 mb-6">
                                <div class="flex justify-between text-sm">
                                    <span class="text-gray-600">Subtotal</span>
                                    <span>$545.00</span>
                                </div>
                                <div class="flex justify-between text-sm">
                                    <span class="text-gray-600">Shipping</span>
                                    <span>Free</span>
                                </div>
                                <div class="flex justify-between text-sm">
                                    <span class="text-gray-600">Tax</span>
                                    <span>$43.60</span>
                                </div>
                                <div class="flex justify-between text-lg font-medium pt-3 border-t border-gray-200">
                                    <span>Total</span>
                                    <span>$588.60</span>
                                </div>
                            </div>

                            <!-- Place Order Button -->
                            <button class="checkout-btn w-full bg-black text-white py-3 px-4 font-medium">Place
                                Order</button>

                            <!-- Secure Checkout -->
                            <div class="mt-4 text-center text-xs text-gray-500">
                                <p>Secure checkout. Your information is protected.</p>
                            </div>
                        </div>

                        <!-- Policies -->
                        <div class="mt-6 text-center text-xs text-gray-500">
                            <p class="mb-2">By placing your order, you agree to our <a href="#" class="underline">Terms
                                    of Service</a> and <a href="#" class="underline">Privacy Policy</a>.</p>
                            <p>Need help? <a href="#" class="underline">Contact us</a></p>
                        </div>
                    </div>
                </div>
                </div>
                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <script src="${ctx}/resources/assets/client/js/order.js">
                </script>
            </body>

            </html>