<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MONOCHROME | Your Shopping Bag</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap"
                    rel="stylesheet">
                <link href="${ctx}/resources/assets/clientcss/cart.css" rel="stylesheet">
            </head>

            <body class="bg-white">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Hero Section -->
                <div class="border-b border-gray-100 py-12 pt-[64px]">
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <h1 class="heading-font text-3xl md:text-4xl lg:text-5xl text-center font-light tracking-tight">
                            Your Shopping Bag</h1>
                        <p class="text-center text-gray-500 mt-2 text-sm">3 items</p>
                    </div>
                </div>

                <!-- Main Cart Content -->
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                    <div class="flex flex-col lg:flex-row gap-12">
                        <!-- Left Column - Cart Items -->
                        <div class="lg:w-2/3">
                            <!-- Cart Header -->
                            <div class="hidden md:grid grid-cols-12 gap-4 pb-4 mb-4 border-b border-gray-100">
                                <div class="col-span-6 text-xs uppercase tracking-wider text-gray-500">Product</div>
                                <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500">Color</div>
                                <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500">Size</div>
                                <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500">Quantity</div>
                                <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500 text-right">Price
                                </div>
                            </div>

                            <!-- Cart Items -->
                            <div class="space-y-8">
                                <!-- Item 1 -->
                                <div
                                    class="cart-item grid grid-cols-12 gap-4 items-center py-4 border-b border-gray-100">
                                    <div class="col-span-6 flex items-center">
                                        <div class="w-24 h-24 bg-gray-50 mr-4">
                                            <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80"
                                                alt="Oversized Blazer" class="w-full h-full object-cover">
                                        </div>
                                        <div>
                                            <h3 class="heading-font font-medium">Oversized Blazer</h3>
                                            <p class="text-gray-500 text-sm mt-1">MONOCHROME</p>
                                        </div>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="w-4 h-4 rounded-full bg-black"></div>
                                        <span class="text-xs text-gray-500 ml-2">Black</span>
                                    </div>
                                    <div class="col-span-1">
                                        <span class="text-sm">M</span>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="quantity-selector flex items-center w-20">
                                            <button class="px-2 py-1 text-gray-500">-</button>
                                            <span class="flex-1 text-center">1</span>
                                            <button class="px-2 py-1 text-gray-500">+</button>
                                        </div>
                                    </div>
                                    <div class="col-span-1 text-right">
                                        <span class="font-medium">$89.99</span>
                                        <button class="remove-btn block text-xs text-gray-400 mt-1 hover:text-gray-600">
                                            <i class="far fa-trash-alt mr-1"></i> Remove
                                        </button>
                                    </div>
                                </div>

                                <!-- Item 2 -->
                                <div
                                    class="cart-item grid grid-cols-12 gap-4 items-center py-4 border-b border-gray-100">
                                    <div class="col-span-6 flex items-center">
                                        <div class="w-24 h-24 bg-gray-50 mr-4">
                                            <img src="https://images.unsplash.com/photo-1551232864-3f0890e580d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80"
                                                alt="Silk Slip Dress" class="w-full h-full object-cover">
                                        </div>
                                        <div>
                                            <h3 class="heading-font font-medium">Silk Slip Dress</h3>
                                            <p class="text-gray-500 text-sm mt-1">MONOCHROME</p>
                                        </div>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="w-4 h-4 rounded-full bg-stone-200"></div>
                                        <span class="text-xs text-gray-500 ml-2">Ivory</span>
                                    </div>
                                    <div class="col-span-1">
                                        <span class="text-sm">S</span>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="quantity-selector flex items-center w-20">
                                            <button class="px-2 py-1 text-gray-500">-</button>
                                            <span class="flex-1 text-center">1</span>
                                            <button class="px-2 py-1 text-gray-500">+</button>
                                        </div>
                                    </div>
                                    <div class="col-span-1 text-right">
                                        <span class="font-medium">$129.99</span>
                                        <button class="remove-btn block text-xs text-gray-400 mt-1 hover:text-gray-600">
                                            <i class="far fa-trash-alt mr-1"></i> Remove
                                        </button>
                                    </div>
                                </div>

                                <!-- Item 3 -->
                                <div
                                    class="cart-item grid grid-cols-12 gap-4 items-center py-4 border-b border-gray-100">
                                    <div class="col-span-6 flex items-center">
                                        <div class="w-24 h-24 bg-gray-50 mr-4">
                                            <img src="https://images.unsplash.com/photo-1595341888016-a392ef81b7de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=200&q=80"
                                                alt="Wide Leg Trousers" class="w-full h-full object-cover">
                                        </div>
                                        <div>
                                            <h3 class="heading-font font-medium">Wide Leg Trousers</h3>
                                            <p class="text-gray-500 text-sm mt-1">MONOCHROME</p>
                                        </div>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="w-4 h-4 rounded-full bg-black"></div>
                                        <span class="text-xs text-gray-500 ml-2">Black</span>
                                    </div>
                                    <div class="col-span-1">
                                        <span class="text-sm">M</span>
                                    </div>
                                    <div class="col-span-2">
                                        <div class="quantity-selector flex items-center w-20">
                                            <button class="px-2 py-1 text-gray-500">-</button>
                                            <span class="flex-1 text-center">1</span>
                                            <button class="px-2 py-1 text-gray-500">+</button>
                                        </div>
                                    </div>
                                    <div class="col-span-1 text-right">
                                        <span class="font-medium">$79.99</span>
                                        <button class="remove-btn block text-xs text-gray-400 mt-1 hover:text-gray-600">
                                            <i class="far fa-trash-alt mr-1"></i> Remove
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Continue Shopping -->
                            <div class="mt-8">
                                <a href="#" class="text-sm underline flex items-center">
                                    <i class="fas fa-arrow-left mr-2"></i> Continue Shopping
                                </a>
                            </div>
                        </div>

                        <!-- Right Column - Order Summary -->
                        <div class="lg:w-1/3">
                            <div class="summary-card bg-white p-6">
                                <h2 class="heading-font text-xl font-light mb-6">Order Summary</h2>

                                <!-- Order Details -->
                                <div class="space-y-4">
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-500">Subtotal</span>
                                        <span class="text-sm">$299.97</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-500">Shipping</span>
                                        <span class="text-sm">Free</span>
                                    </div>
                                    <div class="flex justify-between">
                                        <span class="text-sm text-gray-500">Tax</span>
                                        <span class="text-sm">$26.40</span>
                                    </div>

                                    <div class="divider border-t my-4"></div>

                                    <div class="flex justify-between">
                                        <span class="font-medium">Total</span>
                                        <span class="font-medium">$326.37</span>
                                    </div>
                                </div>

                                <!-- Promo Code -->
                                <div class="mt-6">
                                    <label for="promo-code" class="block text-sm text-gray-500 mb-2">Promo Code</label>
                                    <div class="flex">
                                        <input type="text" id="promo-code"
                                            class="flex-1 border border-gray-200 px-4 py-2 text-sm focus:outline-none focus:border-black"
                                            placeholder="Enter code">
                                        <button
                                            class="bg-black text-white px-4 py-2 text-sm ml-2 hover:bg-gray-800">Apply</button>
                                    </div>
                                </div>

                                <!-- Checkout Button -->
                                <button class="btn-checkout w-full bg-black text-white py-3 mt-6 font-medium">
                                    PROCEED TO CHECKOUT
                                </button>

                                <!-- Payment Methods -->
                                <div class="mt-6 text-center">
                                    <p class="text-xs text-gray-500 mb-2">We accept</p>
                                    <div class="flex justify-center space-x-4">
                                        <i class="fab fa-cc-visa text-gray-400"></i>
                                        <i class="fab fa-cc-mastercard text-gray-400"></i>
                                        <i class="fab fa-cc-amex text-gray-400"></i>
                                        <i class="fab fa-cc-paypal text-gray-400"></i>
                                    </div>
                                </div>
                            </div>

                            <!-- Customer Service -->
                            <div class="mt-6 p-6 bg-gray-50">
                                <h3 class="heading-font font-medium text-sm mb-3">NEED HELP?</h3>
                                <p class="text-xs text-gray-500 mb-3">Our customer service is available to assist you
                                    with any questions about your order.</p>
                                <a href="#" class="text-xs underline flex items-center">
                                    <i class="fas fa-comment mr-2"></i> Contact Us
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>