<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>ÉLÉGANCE | Men's Collection</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/category.css">

            </head>

            <body class="bg-white text-gray-900">
                <!-- Sticky Navigation -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Hero Banner -->
                <section class="pt-24 pb-16 pt-[64px]">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="relative h-96 w-full bg-gray-50 flex items-center justify-center">
                            <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Women's Collection"
                                class="absolute inset-0 w-full h-full object-cover opacity-90">
                            <div class="relative z-10 text-center px-6">
                                <h1 class="font-serif text-5xl md:text-6xl font-light mb-4">Women's Collection</h1>
                                <p class="max-w-2xl mx-auto text-lg">Timeless pieces crafted for the modern woman</p>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Filter and Sort Bar -->
                <section class="py-6 border-b border-gray-100">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                            <div class="text-sm">Showing 1-12 of 48 products</div>

                            <div class="flex flex-wrap gap-3">
                                <!-- Brand Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Brand <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">All</a>
                                        <c:forEach items="${brands}" var="brand">
                                            <a href="#"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50">${brand.brandName}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Category Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Category <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">All</a>
                                        <c:forEach items="${categories}" var="category">
                                            <a href="#"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50">${category.categoryName}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Size Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Size <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">All</a>
                                        <c:forEach items="${sizes}" var="size">
                                            <a href="#"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50">${size.sizeName}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Color Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Color <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">All</a>
                                        <c:forEach items="${colors}" var="color">
                                            <a href="#"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50">${color.colorName}</a>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Sort Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Sort By <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">New Arrivals</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Price: Low to
                                            High</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Price: High to
                                            Low</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Best Sellers</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Product Grid -->
                <section class="py-12">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                            <c:forEach items="${products}" var="product">
                                <div class="product-card group relative">
                                    <div class="relative overflow-hidden mb-4 h-96">
                                        <!-- Product Image -->
                                        <img src="${ctx}/${product.imageUrl}" alt="${product.productName}"
                                            class="w-full h-full object-cover transition duration-500 group-hover:opacity-75">

                                        <!-- Dark Overlay (appears on hover) -->
                                        <div
                                            class="absolute inset-0 bg-black bg-opacity-0 transition duration-500 group-hover:bg-opacity-60">
                                        </div>

                                        <!-- Quick View Button -->
                                        <div
                                            class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                            <a href="${ctx}/product/detail/${product.productId}"
                                                class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                QUICK VIEW
                                            </a>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <h3 class="font-serif text-xl mb-1">${product.productName}</h3>
                                        <p class="text-gray-500">$${product.price}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </section>

                <!-- Pagination -->
                <div class="mt-16 flex justify-center">
                    <nav class="flex items-center gap-1">
                        <a href="#" class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">
                            <i class="fa-solid fa-chevron-left text-xs"></i>
                        </a>
                        <a href="#"
                            class="pagination-item active w-10 h-10 flex items-center justify-center rounded-full">1</a>
                        <a href="#"
                            class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">2</a>
                        <a href="#"
                            class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">3</a>
                        <a href="#"
                            class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">4</a>
                        <a href="#" class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">
                            <i class="fa-solid fa-chevron-right text-xs"></i>
                        </a>
                    </nav>
                </div>
                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- Scripts -->
                </div>

            </html>