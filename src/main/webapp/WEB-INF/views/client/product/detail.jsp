<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MONOCHROME | Product Detail</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/productDetail.css">
            </head>

            <body class="bg-white">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />
                <!-- Product Container -->
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-[64px] ">
                    <div class="product-container flex flex-col md:flex-row gap-8">
                        <!-- Left Column - Product Gallery -->
                        <div class="w-full md:w-1/2">
                            <div class="product-gallery flex flex-col-reverse md:flex-row">
                                <!-- Thumbnails -->
                                <div class="thumbnail-container flex md:flex-col gap-2 mt-4 md:mt-0 md:mr-4">
                                    <div
                                        class="w-16 h-16 md:w-20 md:h-20 bg-gray-100 cursor-pointer border border-transparent hover:border-gray-300">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                            alt="Product thumbnail 1" class="w-full h-full object-cover">
                                    </div>
                                    <div
                                        class="w-16 h-16 md:w-20 md:h-20 bg-gray-100 cursor-pointer border border-transparent hover:border-gray-300">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                            alt="Product thumbnail 2" class="w-full h-full object-cover">
                                    </div>
                                    <div
                                        class="w-16 h-16 md:w-20 md:h-20 bg-gray-100 cursor-pointer border border-transparent hover:border-gray-300">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                            alt="Product thumbnail 3" class="w-full h-full object-cover">
                                    </div>
                                    <div
                                        class="w-16 h-16 md:w-20 md:h-20 bg-gray-100 cursor-pointer border border-transparent hover:border-gray-300">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                            alt="Product thumbnail 4" class="w-full h-full object-cover">
                                    </div>
                                </div>

                                <!-- Main Image -->
                                <div class="flex-1 bg-gray-50 aspect-square">
                                    <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                        alt="MONOCHROME Oversized Blazer" class="w-full h-full object-cover">
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Product Info -->
                        <div class="w-full md:w-1/2">
                            <!-- Product Title -->
                            <h1 class="text-2xl md:text-3xl font-medium mb-2">MONOCHROME Oversized Blazer</h1>

                            <!-- Rating and Reviews -->
                            <div class="flex items-center mb-4">
                                <div class="flex items-center mr-2">
                                    <span class="text-yellow-400 mr-1">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </span>
                                    <span class="text-sm font-medium">4.7</span>
                                </div>
                                <span class="text-sm text-gray-500">(128 reviews)</span>
                                <span class="mx-2 text-gray-300">|</span>
                                <span class="text-sm text-gray-500">256 sold</span>
                            </div>

                            <!-- Pricing -->
                            <div class="mb-6">
                                <div class="flex items-center">
                                    <span class="text-2xl font-bold mr-3">$89.99</span>
                                    <span class="text-lg text-gray-500 line-through mr-2">$129.99</span>
                                    <span class="discount-badge text-xs text-white px-2 py-1 rounded">31% OFF</span>
                                </div>
                                <p class="text-sm text-gray-500 mt-1">Inclusive of all taxes</p>
                            </div>

                            <!-- Color Selection -->
                            <div class="mb-6">
                                <h3 class="text-sm font-medium mb-3">COLOR: <span class="font-normal">Black</span></h3>
                                <div class="flex gap-2">
                                    <div class="color-option w-8 h-8 rounded-full bg-black cursor-pointer selected">
                                    </div>
                                    <div class="color-option w-8 h-8 rounded-full bg-gray-400 cursor-pointer"></div>
                                    <div class="color-option w-8 h-8 rounded-full bg-stone-200 cursor-pointer"></div>
                                </div>
                            </div>

                            <!-- Size Selection -->
                            <div class="mb-8">
                                <h3 class="text-sm font-medium mb-3">SIZE:</h3>
                                <div class="grid grid-cols-5 gap-2">
                                    <div
                                        class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm">
                                        XS</div>
                                    <div
                                        class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm">
                                        S</div>
                                    <div
                                        class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm selected">
                                        M</div>
                                    <div
                                        class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm">
                                        L</div>
                                    <div
                                        class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm">
                                        XL</div>
                                </div>
                                <a href="#" class="text-xs text-gray-500 underline mt-2 inline-block">Size Guide</a>
                            </div>

                            <!-- Quantity -->
                            <div class="mb-8">
                                <h3 class="text-sm font-medium mb-3">QUANTITY:</h3>
                                <div class="flex items-center border border-gray-200 w-24">
                                    <button class="px-3 py-2 text-gray-500 hover:bg-gray-100">-</button>
                                    <span class="flex-1 text-center">1</span>
                                    <button class="px-3 py-2 text-gray-500 hover:bg-gray-100">+</button>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex flex-col sm:flex-row gap-3 mb-8">
                                <form action="/product-variant/add-to-cart/${2}" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button
                                        class="btn-primary flex-1 bg-black text-white py-3 font-medium hover:bg-gray-800">
                                        <i class="fas fa-shopping-cart mr-2"></i> ADD TO CART
                                    </button>
                                </form>
                                <button
                                    class="btn-secondary flex-1 bg-red-600 text-white py-3 font-medium hover:bg-red-700">
                                    BUY NOW
                                </button>
                            </div>

                            <!-- Wishlist & Share -->
                            <div class="flex items-center gap-4 mb-8">
                                <button class="flex items-center text-sm text-gray-700 hover:text-black">
                                    <i class="far fa-heart mr-2"></i> Add to Wishlist
                                </button>
                                <div class="flex items-center gap-3">
                                    <span class="text-sm text-gray-700">Share:</span>
                                    <a href="#" class="text-gray-500 hover:text-black"><i
                                            class="fab fa-facebook-f"></i></a>
                                    <a href="#" class="text-gray-500 hover:text-black"><i
                                            class="fab fa-twitter"></i></a>
                                    <a href="#" class="text-gray-500 hover:text-black"><i
                                            class="fab fa-pinterest-p"></i></a>
                                </div>
                            </div>

                            <!-- Promo Banner -->
                            <div class="border border-gray-200 p-4 mb-8">
                                <h3 class="text-sm font-medium mb-2">SPECIAL OFFER</h3>
                                <p class="text-xs text-gray-700 mb-2">Get 10% additional discount when you spend over
                                    $200</p>
                                <button class="text-xs text-red-600 font-medium underline">View All Vouchers</button>
                            </div>

                            <!-- Store Info -->

                        </div>
                    </div>

                    <!-- Product Details Section -->
                    <div class="mt-16">
                        <h2 class="text-xl font-medium mb-6">Product Details</h2>

                        <!-- Specifications Table -->
                        <div class="mb-12">
                            <h3 class="text-sm font-medium mb-4 uppercase tracking-wider">Specifications</h3>
                            <table class="specs-table w-full">
                                <tbody>
                                    <tr class="py-3">
                                        <td class="py-3 text-sm text-gray-500 w-1/4">Material</td>
                                        <td class="py-3 text-sm font-medium">100% Premium Wool</td>
                                    </tr>
                                    <tr class="py-3">
                                        <td class="py-3 text-sm text-gray-500">Style</td>
                                        <td class="py-3 text-sm font-medium">Oversized, Structured</td>
                                    </tr>
                                    <tr class="py-3">
                                        <td class="py-3 text-sm text-gray-500">Origin</td>
                                        <td class="py-3 text-sm font-medium">Italy</td>
                                    </tr>
                                    <tr class="py-3">
                                        <td class="py-3 text-sm text-gray-500">Available Sizes</td>
                                        <td class="py-3 text-sm font-medium">XS, S, M, L, XL</td>
                                    </tr>
                                    <tr class="py-3">
                                        <td class="py-3 text-sm text-gray-500">Shipping From</td>
                                        <td class="py-3 text-sm font-medium">United States</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Description -->
                        <div class="mb-12">
                            <h3 class="text-sm font-medium mb-4 uppercase tracking-wider">Description</h3>
                            <div class="prose max-w-none">
                                <p class="text-sm mb-4">The MONOCHROME Oversized Blazer is a contemporary take on
                                    classic tailoring, designed for the modern wardrobe. Featuring a relaxed silhouette
                                    with structured shoulders, this piece offers both comfort and sophistication.</p>

                                <h4 class="text-sm font-medium mt-6 mb-2">Key Features:</h4>
                                <ul class="text-sm list-disc pl-5 mb-4 space-y-1">
                                    <li>Premium 100% Italian wool fabric</li>
                                    <li>Unlined construction for year-round wear</li>
                                    <li>Signature oversized fit with notch lapels</li>
                                    <li>Functional welt pockets</li>
                                    <li>Single-button fastening</li>
                                </ul>

                                <h4 class="text-sm font-medium mt-6 mb-2">Care Instructions:</h4>
                                <p class="text-sm mb-4">Dry clean only. Store on a wide hanger to maintain shape.</p>

                                <div class="flex flex-wrap gap-2 mt-6">
                                    <span class="text-xs px-3 py-1 bg-gray-100 rounded-full">#modernTailoring</span>
                                    <span class="text-xs px-3 py-1 bg-gray-100 rounded-full">#oversizedBlazer</span>
                                    <span class="text-xs px-3 py-1 bg-gray-100 rounded-full">#luxuryWool</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>