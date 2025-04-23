<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>ÉLÉGANCE | Women's Collection</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/category.css">
            </head>

            <body class="bg-white text-gray-900">
                <!-- Sticky Navigation -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Filter and Sort Bar -->
                <section class="py-6 border-b border-gray-100 pt-[64px]">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                            <div class="text-sm">Showing 1-12 of 48 products</div>

                            <div class="flex flex-wrap gap-3">
                                <!-- Category Dropdown -->
                                <div class="dropdown relative">
                                    <button
                                        class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                        Category <i class="fa-solid fa-chevron-down text-xs"></i>
                                    </button>
                                    <div
                                        class="dropdown-menu absolute hidden mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">All</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Dresses</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Tops</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Bottoms</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Outerwear</a>
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
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">XS</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">S</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">M</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">L</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">XL</a>
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
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Black</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">White</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Beige</a>
                                        <a href="#" class="block px-4 py-2 text-sm hover:bg-gray-50">Gray</a>
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
                            <!-- Product 1 -->
                            <div class="product-card group">
                                <div class="relative overflow-hidden mb-4 h-96">
                                    <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Cashmere Coat"
                                        class="w-full h-full object-cover product-image transition duration-500">
                                    <div class="absolute bottom-4 left-0 right-0 flex justify-center quick-view">
                                        <button
                                            class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                            <a href="/product/detail>QUICK VIEW</a>
                                        </button>
                                    </div>
                                </div>
                                <div class=" text-center">
                                                <h3 class="font-serif text-xl mb-1">Cashmere Overcoat</h3>
                                                <p class="text-gray-500">$1,250</p>
                                    </div>
                                </div>

                                <!-- Product 2 -->
                                <div class="product-card group">
                                    <div class="relative overflow-hidden mb-4 h-96">
                                        <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Silk Dress"
                                            class="w-full h-full object-cover product-image transition duration-500">
                                        <div class="absolute bottom-4 left-0 right-0 flex justify-center quick-view">
                                            <button
                                                class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                <a href="/product/detail">QUICK VIEW</a>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <h3 class="font-serif text-xl mb-1">Silk Evening Dress</h3>
                                        <p class="text-gray-500">$980</p>
                                    </div>
                                </div>


                            </div>

                            <!-- Pagination -->
                            <div class="mt-16 flex justify-center">
                                <nav class="flex items-center gap-1">
                                    <a href="#"
                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">
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
                                    <a href="#"
                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full">
                                        <i class="fa-solid fa-chevron-right text-xs"></i>
                                    </a>
                                </nav>
                            </div>
                        </div>
                </section>

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>