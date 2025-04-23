<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Luxury fashion</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />

                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="${ctx}/resources/assets/client/css/home.css">

                </head>

                <body class="bg-white text-black">
                    <!-- navbar -->
                    <jsp:include page="layout/navbar.jsp" />

                    <!-- Hero Banner -->
                    <section class="relative h-screen flex items-center pt-[64px]">
                        <div class="absolute inset-0 hero-overlay z-10"></div>
                        <img src="${ctx}/resources/assets/client/images/image_i.jpg" alt="Luxury Fashion Model"
                            class="inset-0 w-full h-full object-cover">
                    </section>

                    <!-- Featured Collections -->
                    <section class="py-20 px-6 max-w-7xl mx-auto">
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <spring:message code="home.collections" />
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image1.avif" alt="Women's Collection"
                                    class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.women" />
                                        </h3>
                                        <a href="#"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Men's Collection"
                                    class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.men" />
                                        </h3>
                                        <a href="#"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="relative h-96 collection-hover">
                                <img src="${ctx}/resources/assets/client/images/image3.avif"
                                    alt="Accessories Collection" class="w-full h-full object-cover">
                                <div
                                    class="absolute inset-0 collection-overlay opacity-0 flex items-center justify-center">
                                    <div class="text-center text-white p-6">
                                        <h3 class="text-2xl mb-2">
                                            <spring:message code="home.accessories" />
                                        </h3>
                                        <a href="#"
                                            class="border border-white px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-white hover:text-black transition duration-300">
                                            <spring:message code="home.viewDetails" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Featured Products -->
                    <section class="py-20 bg-gray-50">
                        <div class="max-w-7xl mx-auto px-6">
                            <div class="text-center mb-16">
                                <h2 class="text-3xl font-light mb-4">
                                    <spring:message code="home.featuredProducts" />
                                </h2>
                                <div class="w-20 h-px bg-black mx-auto"></div>
                            </div>

                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                                <!-- Product 1 -->
                                <div class="product-card relative group">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="${ctx}/resources/assets/client/images/Ao_Khoac_Cashmere.jpg"
                                            alt="Cashmere Coat"
                                            class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                                        <div class="absolute inset-0 product-overlay opacity-0 flex items-end p-6">
                                            <div>
                                                <a href="#"
                                                    class="border border-black px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-black hover:text-white transition duration-300">
                                                    <spring:message code="home.quickView" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">
                                            <spring:message code="home.cashmereCoat" />
                                        </h3>
                                        <p class="text-sm text-gray-600">$1,250</p>
                                    </div>
                                </div>

                                <!-- Product 2 -->
                                <div class="product-card relative group">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="${ctx}/resources/assets/client/images/Vay_da_hoi.webp"
                                            alt="Silk Dress"
                                            class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                                        <div class="absolute inset-0 product-overlay opacity-0 flex items-end p-6">
                                            <div>
                                                <a href="#"
                                                    class="border border-black px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-black hover:text-white transition duration-300">
                                                    <spring:message code="home.quickView" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">
                                            <spring:message code="home.silkDress" />
                                        </h3>
                                        <p class="text-sm text-gray-600">$980</p>
                                    </div>
                                </div>

                                <!-- Product 3 -->
                                <div class="product-card relative group">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="${ctx}/resources/assets/client/images/image2.avif" alt="Wool Suit"
                                            class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                                        <div class="absolute inset-0 product-overlay opacity-0 flex items-end p-6">
                                            <div>
                                                <a href="#"
                                                    class="border border-black px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-black hover:text-white transition duration-300">
                                                    <spring:message code="home.quickView" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">
                                            <spring:message code="home.woolSuit" />
                                        </h3>
                                        <p class="text-sm text-gray-600">$1,450</p>
                                    </div>
                                </div>

                                <!-- Product 4 -->
                                <div class="product-card relative group">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="${ctx}/resources/assets/client/images/Tui_da.jpg" alt="Leather Bag"
                                            class="w-full h-full object-cover transition duration-500 group-hover:scale-105">
                                        <div class="absolute inset-0 product-overlay opacity-0 flex items-end p-6">
                                            <div>
                                                <a href="#"
                                                    class="border border-black px-6 py-2 inline-block uppercase text-xs tracking-wider hover:bg-black hover:text-white transition duration-300">
                                                    <spring:message code="home.quickView" />
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">
                                            <spring:message code="home.leatherBag" />
                                        </h3>
                                        <p class="text-sm text-gray-600">$650</p>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-12">
                                <a href="#"
                                    class="border border-black px-8 py-3 inline-block uppercase text-sm tracking-wider hover:bg-black hover:text-white transition duration-300">
                                    <spring:message code="home.viewAllProducts" />
                                </a>
                            </div>
                        </div>
                    </section>

                    <!-- Tạp chí -->
                    <section class="py-20 max-w-7xl mx-auto px-6">
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <spring:message code="home.magazine" />
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
                            <div class="flex flex-col md:flex-row gap-6">
                                <div class="md:w-1/2">
                                    <img src="https://images.unsplash.com/photo-1479064555552-3ef4979f8908?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                        alt="Biên tập thời trang" class="w-full h-64 object-cover">
                                </div>
                                <div class="md:w-1/2">
                                    <span class="text-xs tracking-wider">
                                        <spring:message code="home.editorial" />
                                    </span>
                                    <h3 class="text-xl font-light mt-2 mb-3">
                                        <spring:message code="home.minimalistFashion" />
                                    </h3>
                                    <p class="text-sm text-gray-600 mb-4">
                                        <spring:message code="home.minimalistFashionDesc" />
                                    </p>
                                    <a href="#"
                                        class="text-sm uppercase tracking-wider border-b border-black pb-1 hover:text-gray-600 hover:border-gray-600 transition duration-300">
                                        <spring:message code="home.readMore" />
                                    </a>
                                </div>
                            </div>

                            <div class="flex flex-col md:flex-row gap-6">
                                <div class="md:w-1/2">
                                    <img src="https://images.unsplash.com/photo-1561526116-e2460f4d40a8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
                                        alt="Thời trang bền vững" class="w-full h-64 object-cover">
                                </div>
                                <div class="md:w-1/2">
                                    <span class="text-xs tracking-wider">
                                        <spring:message code="home.sustainability" />
                                    </span>
                                    <h3 class="text-xl font-light mt-2 mb-3">
                                        <spring:message code="home.ethicalFashion" />
                                    </h3>
                                    <p class="text-sm text-gray-600 mb-4">
                                        <spring:message code="home.ethicalFashionDesc" />
                                    </p>
                                    <a href="#"
                                        class="text-sm uppercase tracking-wider border-b border-black pb-1 hover:text-gray-600 hover:border-gray-600 transition duration-300">
                                        <spring:message code="home.readMore" />
                                    </a>
                                </div>
                            </div>
                        </div>
                    </section>


                    <!-- Footer -->
                    <jsp:include page="layout/footer.jsp" />
                </body>

                </html>