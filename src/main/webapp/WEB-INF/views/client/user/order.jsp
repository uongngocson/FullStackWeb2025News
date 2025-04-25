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
                <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body class="min-h-screen">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Header -->
                <header class="text-center mb-12 pt-[64px]">
                    <h1 class="serif text-4xl font-medium mb-2">Checkout</h1>
                    <p class="text-gray-500">Complete your purchase with elegance</p>
                </header>
                <form action="/user/submit" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <!-- Main Content Grid -->
                    <div class="grid checkout-grid gap-12 md:grid-cols-2">
                        <!-- Left Column - Billing & Shipping -->
                        <div class="space-y-8 p-[40px]">
                            <!-- Contact Information -->
                            <section>
                                <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Contact Information
                                </h2>
                                <div class="space-y-4">
                                    <div>
                                        <label for="fullName" class="block text-sm text-gray-600 mb-1">First Name</label>
                                        <input type="text" id="firstName" name="firstName"
                                            value="${customer.firstName != null ? customer.firstName : ''}"
                                            class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="First Name" />
                                    </div>
                                    <div>
                                        <label for="fullName" class="block text-sm text-gray-600 mb-1">Last Name</label>
                                        <input type="text" id="lastName" name="lastName"
                                            value="${customer.lastName != null ? customer.lastName : ''}"
                                            class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="Last Name" />
                                    </div>
                                    <div>
                                        <label for="email" class="block text-sm text-gray-600 mb-1">Email Address</label>
                                        <input type="email" id="email" name="email"
                                            value="${customer.email != null ? customer.email : ''}"
                                            class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="john@example.com"
                                            ${customer.email != null ? 'readonly' : ''} />
                                    </div>
                                    <div>
                                        <label for="phone" class="block text-sm text-gray-600 mb-1">Phone Number</label>
                                        <input type="tel" id="phone" name="phone"
                                            value="${customer.phone != null ? customer.phone : ''}"
                                            class="input-field w-full py-2 px-1 bg-transparent"
                                            placeholder="+1 (123) 456-7890" />
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
                                            <input type="text" id="street" name="street" class="input-field w-full py-2 px-1 bg-transparent"
                                                placeholder="123 Main St">
                                        </div>
                                        <div class="grid grid-cols-2 gap-4">
                                            <div>
                                                <label for="city" class="block text-sm text-gray-600 mb-1">City</label>
                                                <input type="text" id="city" name="city" class="input-field w-full py-2 px-1 bg-transparent"
                                                    placeholder="New York">
                                            </div>
                                            <div>
                                                <label for="state"
                                                    class="block text-sm text-gray-600 mb-1">District</label>
                                                <input type="text" id="district" name="district"
                                                    class="input-field w-full py-2 px-1 bg-transparent" placeholder="NY">
                                            </div>
                                        </div>
                                        <div class="grid grid-cols-2 gap-4">
                                            <div>
                                                <label for="country" class="block text-sm text-gray-600 mb-1">Country</label>
                                                <select id="country" name="country" class="input-field w-full py-2 px-1 bg-transparent">
                                                    <option value="">Select Country</option>
                                                    <option value="US">VietNam</option>                              
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                
                            </section>
                            <!-- Payment Method -->
                            <section>
                                <h2 class="serif text-xl font-medium mb-6 pb-2 border-b border-gray-200">Payment Method</h2>
                                <div class="space-y-4">


                                    <div class="payment-methods space-y-3">
                                        <label class="payment-method p-4 border rounded cursor-pointer flex items-center hover:border-blue-500">
                                          <div class="w-8 h-8 rounded-full border flex items-center justify-center mr-3 peer-checked:border-blue-500">
                                            <input type="radio" name="paymentMethod" value="online" class="hidden peer">
                                            <span class="w-4 h-4 rounded-full bg-transparent peer-checked:bg-blue-500"></span>
                                          </div>
                                          <span>Thanh toán online</span>
                                        </label>
                                      
                                        <label class="payment-method p-4 border rounded cursor-pointer flex items-center hover:border-blue-500">
                                          <div class="w-8 h-8 rounded-full border flex items-center justify-center mr-3 peer-checked:border-blue-500">
                                            <input type="radio" name="paymentMethod" value="cod" class="hidden peer">
                                            <span class="w-4 h-4 rounded-full bg-transparent peer-checked:bg-blue-500"></span>
                                          </div>
                                          <span>Thanh toán khi nhận hàng</span>
                                        </label>
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
                                    <c:forEach var="item" items="${items}">
                                        <div class="flex items-center py-3 border-b border-gray-100">
                                            <div class="w-16 h-16 bg-gray-100 mr-4">
                                                <img src="${item.variant.imageUrl}" alt="" />
                                            </div>
                                            <div class="flex-1">
                                                <h3 class="text-sm font-medium">${item.variant.product.productName}</h3>
                                                <p class="text-xs text-gray-500">${item.variant.color.colorName} / ${item.variant.size.sizeName}</p>
                                            </div>
                                            <div class="text-right">
                                                <p class="text-sm">${item.variant.product.price}</p>
                                                <p class="text-xs text-gray-500">Qty: ${item.quantity}</p>
                                            </div>
                                        </div>
                                        <input type="hidden" name="variantIds" value="${item.variant.productVariantId}" />
                                        <input type="hidden" name="quantities" value="${item.quantity}" />
                                    </c:forEach>

                                </div>

                                <!-- Promo Code
                                <div class="mb-6">
                                    <label for="promoCode" class="block text-sm text-gray-600 mb-2">Promo Code</label>
                                    <div class="flex">
                                        <input type="text" id="promoCode"
                                            class="input-field flex-1 py-2 px-3 bg-transparent border"
                                            placeholder="Enter code">
                                        <button class="bg-black text-white px-4 py-2 text-sm ml-2">Apply</button>
                                    </div>
                                </div> -->

                                <!-- Order Totals -->
                                <div class="space-y-3 mb-6">
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Subtotal</span>
                                        <span>${orderTotal}</span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Shipping</span>
                                        <span>Free</span>
                                    </div>
                                    <div class="flex justify-between text-lg font-medium pt-3 border-t border-gray-200">
                                        <span>Total</span>
                                        <span>${orderTotal}</span>
                                    </div>
                                </div>
                                <input type="hidden" name="totalPrice" value="${orderTotal}" />

                                <!-- Place Order Button -->
                                <button  type="submit" class="checkout-btn w-full bg-black text-white py-3 px-4 font-medium">Place
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
                </form>
                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <script src="${ctx}/resources/assets/client/js/order.js">
                </script>
            </body>

            </html>