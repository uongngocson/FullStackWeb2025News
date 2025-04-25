<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>MONOCHROME | Your Shopping Bag</title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap"
                        rel="stylesheet">

                    <link rel="stylesheet" href="${ctx}/css/cart.css">

                </head>

                <body class="bg-white">
                    <!-- navbar -->
                    <jsp:include page="../layout/navbar.jsp" />

                    <!-- Hero Section -->
                    <div class="border-b border-gray-100 py-12 pt-[64px]">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                            <h1
                                class="heading-font text-3xl md:text-4xl lg:text-5xl text-center font-light tracking-tight">
                                <spring:message code="cart.title" />
                            </h1>
                            <p class="text-center text-gray-500 mt-2 text-sm">${cartDetails.size()}
                                <spring:message code="cart.items" />
                            </p>
                        </div>
                    </div>

                    <!-- Main Cart Content -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                        <div class="flex flex-col lg:flex-row gap-12">
                            <!-- Left Column - Cart Items -->
                            <div class="lg:w-2/3">
                                <!-- Cart Header -->
                                <div class="hidden md:grid grid-cols-12 gap-4 pb-4 mb-4 border-b border-gray-200">
                                    <div class="col-span-5 text-xs uppercase tracking-wider text-gray-500">
                                        <spring:message code="cart.product" />
                                    </div>
                                    <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500">
                                        <spring:message code="cart.color" />
                                    </div>
                                    <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500">
                                        <spring:message code="cart.size" />
                                    </div>
                                    <div class="col-span-2 text-xs uppercase tracking-wider text-gray-500">
                                        <spring:message code="cart.quantity" />
                                    </div>
                                    <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500 text-right">
                                        <spring:message code="cart.price" />
                                    </div>
                                    <div class="col-span-1 text-xs uppercase tracking-wider text-gray-500 text-right">
                                    </div>
                                </div>

                                <!-- Cart Items -->
                                <div class="space-y-6">
                                    <c:forEach items="${cartDetails}" var="item" varStatus="status">
                                        <div
                                            class="cart-item grid grid-cols-12 gap-4 items-center py-6 border-b border-gray-200">
                                            <div class="col-span-5 flex items-center">
                                                <div class="w-24 h-24 bg-gray-50 mr-4">
                                                    <img src="${ctx}/${item.productVariant.imageUrl}"
                                                        alt="${item.productVariant.product.productName}"
                                                        class="w-full h-full object-cover">
                                                </div>
                                                <div>
                                                    <h3 class="heading-font font-medium">
                                                        ${item.productVariant.product.productName}
                                                    </h3>
                                                    <p class="text-gray-500 text-sm mt-1">
                                                        ${item.productVariant.product.brand.brandName}</p>
                                                </div>
                                            </div>
                                            <div class="col-span-2 flex items-center">
                                                <div
                                                    class="w-4 h-4 rounded-full bg-${item.productVariant.color.colorName.toLowerCase()} mr-2">
                                                </div>
                                                <span class="text-sm">${item.productVariant.color.colorName}</span>
                                            </div>
                                            <div class="col-span-1">
                                                <span class="text-sm">${item.productVariant.size.sizeName}</span>
                                            </div>
                                            <div class="col-span-2">
                                                <div
                                                    class="quantity-selector flex items-center border border-gray-200 w-20">
                                                    <button class="px-2 py-1 text-gray-500 hover:bg-gray-100"
                                                        onclick="updateQuantity(this, -1)">-</button>
                                                    <span class="flex-1 text-center quantity-value"
                                                        data-cart-detail-id="${cartDetail.id}"
                                                        data-cart-detail-price="${cartDetail.price}"
                                                        data-cart-detail-index="${status.index}">${item.quantity}</span>
                                                    <button class="px-2 py-1 text-gray-500 hover:bg-gray-100"
                                                        onclick="updateQuantity(this, 1)">+</button>
                                                </div>
                                            </div>
                                            <div class="col-span-1 text-right">
                                                <span
                                                    class="font-medium">$${item.quantity*item.productVariant.product.price}</span>
                                            </div>
                                            <div class="col-span-1 text-right">
                                                <button class="remove-btn text-gray-400 hover:text-gray-600 text-sm">
                                                    <i class="far fa-trash-alt mr-1"></i>
                                                    <spring:message code="cart.remove" />
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
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
                                <div class="summary-card border border-gray-200 bg-white p-6">
                                    <h2 class="heading-font text-xl font-light mb-6">
                                        <spring:message code="cart.orderSummary" />
                                    </h2>
                                    <div class="space-y-4">
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-500">
                                                <spring:message code="cart.subtotal" />
                                            </span>
                                            <span class="text-sm"
                                                data-cart-total-price="${totalPrice}">$${totalPrice}</span>
                                        </div>
                                        <div class="flex justify-between">
                                            <span class="text-sm text-gray-500">
                                                <spring:message code="cart.shipping" />
                                            </span>
                                            <span class="text-sm">
                                                <spring:message code="cart.free" />
                                            </span>
                                        </div>
                                        <!-- <div class="flex justify-between">
                                            <span class="text-sm text-gray-500">
                                                <spring:message code="cart.tax" />
                                            </span>
                                            <span class="text-sm" data-cart-total-price="${totalPrice}">$${totalPrice * 0.1}</span>
                                        </div> -->
                                        <div class="border-t border-gray-200 my-4"></div>
                                        <div class="flex justify-between">
                                            <span class="font-medium">
                                                <spring:message code="cart.total" />
                                            </span>
                                            <span class="font-medium"
                                                data-cart-total-price="${totalPrice}">$${totalPrice}</span>
                                        </div>
                                    </div>

                                    <!-- Promo Code -->
                                    <div class="mt-6">
                                        <label for="promo-code" class="block text-sm text-gray-500 mb-2">Promo
                                            Code</label>
                                        <div class="flex">
                                            <input type="text" id="promo-code"
                                                class="flex-1 border border-gray-200 px-4 py-2 text-sm focus:outline-none focus:border-black"
                                                placeholder="Enter code">
                                            <button
                                                class="bg-black text-white px-4 py-2 text-sm ml-2 hover:bg-gray-800">Apply</button>
                                        </div>
                                    </div>

                                    <!-- Checkout Button -->
                                    <button
                                        class="btn-checkout w-full bg-black text-white py-3 mt-6 font-medium hover:bg-gray-800 transition-colors">
                                        PROCEED TO CHECKOUT
                                    </button>


                                </div>

                                <!-- Customer Service -->
                                <div class="mt-6 p-6 bg-gray-50 border border-gray-200">
                                    <h3 class="heading-font font-medium text-sm mb-3">NEED HELP?</h3>
                                    <p class="text-xs text-gray-500 mb-3">Our customer service is available to assist
                                        you
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

                    <script>
                        // Function to update quantity
                        function updateQuantity(button, change) {
                            const quantityContainer = button.closest('.quantity-selector');
                            const quantityElement = quantityContainer.querySelector('.quantity-value');
                            let currentQuantity = parseInt(quantityElement.textContent);
                            currentQuantity += change;

                            // Ensure quantity doesn't go below 1
                            if (currentQuantity < 1) currentQuantity = 1;

                            quantityElement.textContent = currentQuantity;

                            // Here you would typically update the cart total via AJAX
                            // updateCartTotal();
                        }

                        // Function to remove item
                        document.querySelectorAll('.remove-btn').forEach(button => {
                            button.addEventListener('click', function () {
                                const item = this.closest('.cart-item');
                                item.remove();

                                // Here you would typically update the cart via AJAX
                                // updateCartAfterRemoval();
                            });
                        });
                    </script>
                </body>

                </html>