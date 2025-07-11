<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Document</title>
                        <script src="https://cdn.tailwindcss.com"></script>

                        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                        <link rel="preconnect" href="https://fonts.googleapis.com">
                        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                        <link rel="stylesheet" href="../../../../resources/assets/client/css/sontest.css">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                            rel="stylesheet">
                        <!-- <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/resources/assets/client/css/style.css"> -->

                        <link rel="icon"
                            href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                            type="image/icon type">

                    </head>


                    <body>

                        <header>
                            <div class="offer">
                                <a href="">
                                    <spring:message code="navbar.offer.discount" />
                                </a>
                                <a href=""><i class="uil uil-truck"></i>
                                    <spring:message code="navbar.offer.shipping" />
                                </a>
                            </div>
                            <div class="header-menu">
                                <a href="">
                                    <spring:message code="navbar.menu.help" />
                                </a>
                                <a href="">
                                    <spring:message code="navbar.menu.exchangesReturns" />
                                </a>
                                <a href="">
                                    <spring:message code="navbar.menu.orderTracker" />
                                </a>
                                <a href="">
                                    <spring:message code="navbar.menu.joinAdiclub" />
                                </a>
                            </div>
                            <nav>
                                <i class="uil uil-bars"></i>
                                <a href="/" class="logo">
                                    <img src="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                                        alt="">
                                </a>


                                <script src="//unpkg.com/alpinejs"></script>
                                <nav x-data="{
                                            navigationMenuOpen: false,
                                            navigationMenu: '',
                                            navigationMenuCloseDelay: 200,
                                            navigationMenuCloseTimeout: null,
                                            navigationMenuLeave() {
                                            let that = this;
                                            this.navigationMenuCloseTimeout = setTimeout(() => {
                                            that.navigationMenuClose();
                                            }, this.navigationMenuCloseDelay);
                                            },
                                            navigationMenuReposition(navElement) {
                                            this.navigationMenuClearCloseTimeout();
                                            this.$refs.navigationDropdown.style.left = navElement.offsetLeft + 'px';
                                            this.$refs.navigationDropdown.style.marginLeft = (navElement.offsetWidth/2) + 'px';
                                            },
                                            navigationMenuClearCloseTimeout(){
                                            clearTimeout(this.navigationMenuCloseTimeout);
                                            },
                                            navigationMenuClose(){
                                            this.navigationMenuOpen = false;
                                            this.navigationMenu = '';
                                            }
                                            }" class="relative z-10 w-auto">
                                    <div class="relative">
                                        <ul
                                            class="flex items-center justify-center flex-1 p-1 space-x-1 list-none border rounded-md text-black group border-neutral-200/80 border-none">
                                            <!-- home -->
                                            <li>
                                                <a href="/"
                                                    class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                    HOME
                                                </a>
                                            </li>
                                            <!-- Thời trang nam -->
                                            <li>
                                                <button
                                                    :class="{ 'bg-neutral-100' : navigationMenu=='fashionMen', 'hover:bg-neutral-100' : navigationMenu!='fashionMen' }"
                                                    @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='fashionMen'"
                                                    @mouseleave="navigationMenuLeave()"
                                                    class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                    <span>
                                                        <a href="${pageContext.request.contextPath}/gender-product/men"
                                                            class="active">
                                                            <spring:message code="navbar.men" />
                                                        </a>
                                                    </span>
                                                    <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'fashionMen' }"
                                                        class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                                                        fill="none" stroke="currentColor" stroke-width="2"
                                                        stroke-linecap="round" stroke-linejoin="round"
                                                        aria-hidden="true">
                                                        <polyline points="6 9 12 15 18 9"></polyline>
                                                    </svg>
                                                </button>
                                            </li>

                                            <!-- Thời trang nữ -->
                                            <li>
                                                <button
                                                    :class="{ 'bg-neutral-100' : navigationMenu=='women-section', 'hover:bg-neutral-100' : navigationMenu!='women-section' }"
                                                    @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='women-section'"
                                                    @mouseleave="navigationMenuLeave()"
                                                    class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                    <span>
                                                        <a href="${pageContext.request.contextPath}/gender-product/women"
                                                            class="active">
                                                            <spring:message code="navbar.women" />
                                                        </a>
                                                    </span>
                                                    <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'women-section' }"
                                                        class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"
                                                        fill="none" stroke="currentColor" stroke-width="2"
                                                        stroke-linecap="round" stroke-linejoin="round"
                                                        aria-hidden="true">
                                                        <polyline points="6 9 12 15 18 9"></polyline>
                                                    </svg>
                                                </button>
                                            </li>
                                            <!-- danh mục -->
                                            <li>
                                                <button
                                                    :class="{ 'bg-neutral-100' : navigationMenu=='categories', 'hover:bg-neutral-100' : navigationMenu!='categories' }"
                                                    @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='categories'"
                                                    @mouseleave="navigationMenuLeave()"
                                                    class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                    <span>
                                            <li><a href="/product/category" class="active">
                                                    <spring:message code="navbar.categories" />
                                                </a></li></span>
                                            <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'categories' }"
                                                class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                stroke-linejoin="round" aria-hidden="true">
                                                <polyline points="6 9 12 15 18 9"></polyline>
                                            </svg>
                                            </button>
                                            </li>
                                            <!-- blog -->
                                            <li>
                                                <button
                                                    :class="{ 'bg-neutral-100' : navigationMenu=='getting-started', 'hover:bg-neutral-100' : navigationMenu!='getting-started' }"
                                                    @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='getting-started'"
                                                    @mouseleave="navigationMenuLeave()"
                                                    class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none group w-max">
                                                    <span>
                                            <li>
                                                <a href="/blog" class="active">
                                                    BLOG
                                                </a>
                                            </li>
                                            </span>
                                            <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'getting-started' }"
                                                class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                stroke-linejoin="round" aria-hidden="true">
                                                <polyline points="6 9 12 15 18 9"></polyline>
                                            </svg>
                                            </button>
                                            </li>

                                        </ul>
                                    </div>
                                    <div x-ref="navigationDropdown" x-show="navigationMenuOpen"
                                        x-transition:enter="transition ease-out duration-100"
                                        x-transition:enter-start="opacity-0 scale-90"
                                        x-transition:enter-end="opacity-100 scale-100"
                                        x-transition:leave="transition ease-in duration-100"
                                        x-transition:leave-start="opacity-100 scale-100"
                                        x-transition:leave-end="opacity-0 scale-90"
                                        @mouseover="navigationMenuClearCloseTimeout()"
                                        @mouseleave="navigationMenuLeave()"
                                        class="absolute top-0 pt-3 duration-200 ease-out -translate-x-1/2 translate-y-11"
                                        x-cloak>
                                        <div
                                            class="flex justify-center w-auto h-auto overflow-hidden bg-white border rounded-md shadow-sm border-neutral-200/70">

                                            <div x-show="navigationMenu == 'fashionMen'"
                                                class="flex items-stretch justify-center w-full p-6">
                                                <div class="w-72">
                                                    <a href="/product/item-female?category=tops"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Áo</span>
                                                        <span class="block font-light leading-5 opacity-50">Tất cả các
                                                            loại áo dành cho nam.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=bottoms"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Quần</span>
                                                        <span class="block font-light leading-5 opacity-50">Quần dài,
                                                            quần ngắn và các loại quần khác cho nam.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=dresses"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Áo</span>
                                                        <span class="block leading-5 opacity-50">Các loại áo và phụ kiện
                                                            dành cho nam.</span>
                                                    </a>
                                                </div>
                                                <div class="w-72">
                                                    <a href="/product/item-female?category=shoes"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Giày</span>
                                                        <span class="block font-light leading-5 opacity-50">Các loại
                                                            giày dành cho nam.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=accessories"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Phụ kiện</span>
                                                        <span class="block leading-5 opacity-50">Túi xách, mũ và các
                                                            loại phụ kiện khác cho nam.</span>
                                                    </a>
                                                    <a href="/product/item-male" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Tất cả sản
                                                            phẩm</span>
                                                        <span class="block leading-5 opacity-50">Xem tất cả các sản phẩm
                                                            thời trang nam.</span>
                                                    </a>
                                                </div>
                                            </div>
                                            <div x-show="navigationMenu == 'getting-started'"
                                                class="flex items-stretch justify-center w-full max-w-2xl p-6 gap-x-3">
                                                <div
                                                    class="flex-shrink-0 w-48 rounded pt-28 pb-7 bg-gradient-to-br from-neutral-800 to-black">
                                                    <div class="relative px-7 space-y-1.5 text-white">
                                                        <svg class="block w-auto h-9" viewBox="0 0 180 180" fill="none"
                                                            xmlns="http://www.w3.org/2000/svg">
                                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                                d="M67.683 89.217h44.634l30.9 53.218H36.783l30.9-53.218Z"
                                                                fill="currentColor" />
                                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                                d="M77.478 120.522h21.913v46.956H77.478v-46.956Zm-34.434-29.74 45.59-78.26 46.757 78.26H43.044Z"
                                                                fill="currentColor" />
                                                        </svg>
                                                        <span class="block font-bold">Pines UI</span>
                                                        <span class="block text-sm opacity-60">An Alpine and Tailwind UI
                                                            library</span>
                                                    </div>
                                                </div>
                                                <div class="w-72">
                                                    <a href="#_" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Giới
                                                            thiệu</span>
                                                        <span class="block font-light leading-5 opacity-50">Khám phá bộ
                                                            sưu
                                                            tập thời trang nam đẳng cấp và hiện đại.</span>
                                                    </a>
                                                    <a href="#_" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Cách phối
                                                            đồ</span>
                                                        <span class="block leading-5 opacity-50">Hướng dẫn phối đồ đơn
                                                            giản,
                                                            phong cách và phù hợp từng dịp.</span>
                                                    </a>
                                                    <a href="#_" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Bộ sưu tập
                                                            mới</span>
                                                        <span class="block leading-5 opacity-50">Cập nhật những xu hướng
                                                            thời trang nam mới nhất từ các nhà thiết kế nổi
                                                            tiếng.</span>
                                                    </a>
                                                </div>

                                            </div>
                                            <div x-show="navigationMenu == 'women-section'"
                                                class="flex items-stretch justify-center w-full p-6">
                                                <div class="w-72">
                                                    <a href="/product/item-female?category=tops"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Áo</span>
                                                        <span class="block font-light leading-5 opacity-50">Tất cả các
                                                            loại áo dành cho nữ.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=bottoms"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Quần</span>
                                                        <span class="block font-light leading-5 opacity-50">Quần dài,
                                                            quần ngắn và các loại quần khác cho nữ.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=dresses"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Váy đầm</span>
                                                        <span class="block leading-5 opacity-50">Các loại váy và đầm
                                                            dành cho nữ.</span>
                                                    </a>
                                                </div>
                                                <div class="w-72">
                                                    <a href="/product/item-female?category=shoes"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Giày</span>
                                                        <span class="block font-light leading-5 opacity-50">Các loại
                                                            giày dành cho nữ.</span>
                                                    </a>
                                                    <a href="/product/item-female?category=accessories"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Phụ kiện</span>
                                                        <span class="block leading-5 opacity-50">Túi xách, mũ và các
                                                            loại phụ kiện khác cho nữ.</span>
                                                    </a>
                                                    <a href="/product/item-female" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Tất cả sản
                                                            phẩm</span>
                                                        <span class="block leading-5 opacity-50">Xem tất cả các sản phẩm
                                                            thời trang nữ.</span>
                                                    </a>
                                                </div>
                                            </div>
                                            <div x-show="navigationMenu == 'categories'"
                                                class="flex items-stretch justify-center w-full p-6">
                                                <div class="w-72">
                                                    <a href="/product/category?type=clothing"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Quần áo</span>
                                                        <span class="block font-light leading-5 opacity-50">Tất cả các
                                                            loại quần áo.</span>
                                                    </a>
                                                    <a href="/product/category?type=footwear"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Giày dép</span>
                                                        <span class="block font-light leading-5 opacity-50">Các loại
                                                            giày và dép.</span>
                                                    </a>
                                                    <a href="/product/category?type=accessories"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Phụ kiện</span>
                                                        <span class="block leading-5 opacity-50">Túi xách, mũ và các phụ
                                                            kiện khác.</span>
                                                    </a>
                                                </div>
                                                <div class="w-72">
                                                    <a href="/product/category?gender=men"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Nam</span>
                                                        <span class="block font-light leading-5 opacity-50">Tất cả sản
                                                            phẩm dành cho nam.</span>
                                                    </a>
                                                    <a href="/product/category?gender=women"
                                                        @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Nữ</span>
                                                        <span class="block leading-5 opacity-50">Tất cả sản phẩm dành
                                                            cho nữ.</span>
                                                    </a>
                                                    <a href="/product/category" @click="navigationMenuClose()"
                                                        class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                        <span class="block mb-1 font-medium text-black">Tất cả danh
                                                            mục</span>
                                                        <span class="block leading-5 opacity-50">Xem tất cả các danh mục
                                                            sản phẩm.</span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </nav>

                                <div class="user">
                                    <div class="search ">
                                        <div class=" relative search-more flex flex-col items-center">
                                            <form class="flex items-center" id="searchForm"
                                                action="${pageContext.request.contextPath}/products/search"
                                                method="get">
                                                <input type="text" name="keyword" id="searchInput"
                                                    placeholder="Search..."
                                                    value="${searchKeyword != null ? searchKeyword : ''}">
                                                <button type="submit"
                                                    style="background: none; border: none; cursor: pointer;">
                                                    <i class="uil uil-search"></i>
                                                </button>

                                            </form>

                                            <div class="absolute top-10 z-50 right-2 w-full h-full">
                                                <div
                                                    class="flex flex-col min-w-[350px] h-auto bg-[#E9ECEF] p-4 space-y-4">
                                                    <c:choose>
                                                        <c:when test="${empty searchProducts}">
                                                            <div
                                                                class="flex items-center justify-center bg-white p-4 rounded-lg">
                                                                <p class="text-gray-500">
                                                                    <spring:message code="navbar.noProductsFound" />
                                                                </p>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${searchProducts}" var="product" begin="0"
                                                                end="3">
                                                                <div
                                                                    class="flex items-center bg-white p-4 rounded-lg shadow-md hover:shadow-lg hover:scale-105 hover:bg-gray-100 transition-all duration-300 relative group">
                                                                    <img src="${product.image_url != null ? product.image_url : 'https://via.placeholder.com/60'}"
                                                                        alt="${product.product_name}"
                                                                        class="w-16 h-16 object-cover rounded-md mr-4">
                                                                    <div class="flex flex-col">
                                                                        <span
                                                                            class="text-lg font-semibold text-gray-800">${product.product_name}</span>
                                                                        <span
                                                                            class="text-sm text-gray-500 mt-1">$${product.price}</span>
                                                                    </div>

                                                                    <!-- Quick View Button -->
                                                                    <div
                                                                        class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300 bg-black bg-opacity-50 rounded-lg">
                                                                        <c:url var="detailUrl" value="/product/detail">
                                                                            <c:param name="id"
                                                                                value="${product.product_id}" />
                                                                        </c:url>
                                                                        <a href="${detailUrl}"
                                                                            class="bg-white px-4 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300 rounded">
                                                                            <spring:message code="category.quickView" />
                                                                        </a>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>


                                        <!-- <i class="cusmore uil uil-times-circle"></i> -->
                                    </div>

                                    <c:if test="${not empty pageContext.request.userPrincipal}">
                                        <a class="relative  " href="/user/cart">
                                            <i class="uil uil-shopping-bag "></i>
                                            <span
                                                class="absolute -top-1  -right-1 bg-blue-200 rounded-full flex items-center justify-center text-dark px-1 h-5 w-5 text-xs"
                                                id="sumCart">
                                                ${sessionScope.cartItemCount}
                                            </span>
                                        </a>
                                        <div class="relative my-auto group">
                                            <i class="uil uil-user"></i>
                                            <div id="user-dropdown"
                                                class="absolute right-0 w-72 z-50 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 ease-in-out transform origin-top-right scale-95 group-hover:scale-100"
                                                style="background: white; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15); margin-top: 20px; border-radius: 12px; overflow: hidden; padding: 20px;">
                                                <div class=""> <!-- Tăng padding lên -->
                                                    <div class="flex flex-col items-center">
                                                        <c:if test="${not empty customer.imageUrl}">
                                                            <div>
                                                                <p class="text-gray-500 text-sm">Profile Image</p>
                                                                <img src="${ctx}${customer.imageUrl}"
                                                                    alt="Profile Image"
                                                                    class="w-24 h-24 rounded-full object-cover">
                                                            </div>
                                                        </c:if>
                                                        <div
                                                            class="text-center font-semibold text-gray-800 text-lg mt-3">
                                                            <c:out value="${sessionScope.fullName}" />
                                                        </div>
                                                    </div>
                                                    <div class="mt-6 border-t border-gray-200" style="margin-top:5px;">
                                                        <a href="/management/profile"
                                                            class="block px-5 py-3 text-gray-700 hover:bg-gray-100 hover:text-blue-600 text-sm font-medium uppercase transition rounded-none">
                                                            <spring:message code="navbar.account" />
                                                        </a>
                                                        <a href="/management/historyorder"
                                                            class="block px-5 py-3 text-gray-700 hover:bg-gray-100 hover:text-blue-600 text-sm font-medium uppercase transition rounded-none">
                                                            <spring:message code="navbar.orderHistory" />
                                                        </a>
                                                    </div>
                                                    <div class="border-t border-gray-200">
                                                        <form method="post" action="/logout" id="logoutForm">
                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                            <button type="submit" onclick="clearAddressData()"
                                                                class="w-full text-left block px-5 py-3 text-gray-700 hover:bg-gray-100 hover:text-red-600 text-sm font-medium uppercase transition">
                                                                <spring:message code="navbar.logout" />
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </c:if>

                                    <c:if test="${empty pageContext.request.userPrincipal}">
                                        <a href="/login"><i class="uil uil-user"></i></a>
                                    </c:if>

                                    <a href="/user/productfavriote"> <i class="uil uil-heart"></i></a>

                                    <c:if test="${empty pageContext.request.userPrincipal}">
                                        <i class="uil uil-shopping-bag"></i>
                                    </c:if>
                                </div>
                                <!-- language -->
                                <!-- language -->
                                <div class="user flex gap-2 sm:gap-10 items-center justify-center">
                                    <c:url var="viUrl" value="${requestScope['javax.servlet.forward.request_uri']}">
                                        <c:param name="lang" value="vi" />
                                        <c:if test="${not empty param.id}">
                                            <c:param name="id" value="${param.id}" />
                                        </c:if>
                                    </c:url>
                                    <a class="flex gap-2 ${pageContext.response.locale == 'vi' ? 'font-bold' : ''}"
                                        href="${viUrl}">
                                        <img src="${pageContext.request.contextPath}/resources/assets/client/images/vi.jpg"
                                            alt=""> VN
                                    </a>

                                    <c:url var="enUrl" value="${requestScope['javax.servlet.forward.request_uri']}">
                                        <c:param name="lang" value="en" />
                                        <c:if test="${not empty param.id}">
                                            <c:param name="id" value="${param.id}" />
                                        </c:if>
                                    </c:url>
                                    <a class="flex gap-2 ${pageContext.response.locale == 'en' ? 'font-bold' : ''}"
                                        href="${enUrl}">
                                        <img src="${pageContext.request.contextPath}/resources/assets/client/images/en.jpg"
                                            alt=""> EN
                                    </a>
                                </div>
                            </nav>
                        </header>

                        <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>
                        <script src="${pageContext.request.contextPath}/resources/assets/client/js/mainson.js"></script>

                        <!-- Script to update cart count automatically -->
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const sumCartElement = document.getElementById('sumCart');
                                if (sumCartElement) {
                                    fetch('${pageContext.request.contextPath}/api/cart/count')
                                        .then(response => response.json())
                                        .then(data => {
                                            if (data && data.count !== undefined) {
                                                sumCartElement.textContent = data.count;
                                            }
                                        })
                                        .catch(error => console.error('Error fetching cart count:', error));
                                }
                            });
                        </script>

                        <!-- AJAX Search Script -->
                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                const searchInput = document.getElementById('searchInput');
                                const searchForm = document.getElementById('searchForm');
                                const searchDropdown = document.querySelector('.search-more .flex.flex-col.min-w-\\[350px\\]');
                                let debounceTimer;
                                let dropdownVisible = false;
                                const contextPath = '${pageContext.request.contextPath}';

                                if (searchInput) {
                                    // Show/hide dropdown based on focus
                                    searchInput.addEventListener('focus', function () {
                                        if (searchInput.value.trim().length > 1) {
                                            showDropdown();
                                        }
                                    });

                                    // Hide dropdown when clicking outside
                                    document.addEventListener('click', function (e) {
                                        if (!e.target.closest('.search-more') && dropdownVisible) {
                                            hideDropdown();
                                        }
                                    });

                                    // Add input event listener with debouncing
                                    searchInput.addEventListener('input', function (e) {
                                        clearTimeout(debounceTimer);

                                        const keyword = e.target.value.trim();

                                        // Set a debounce delay of 300ms to avoid too many requests
                                        debounceTimer = setTimeout(function () {
                                            if (keyword.length >= 2) {
                                                // Show dropdown when typing
                                                showDropdown();
                                                // Fetch dropdown search results
                                                fetchDropdownResults(keyword);

                                                // Only perform main search if we're on the search page
                                                if (window.location.href.includes('products/search')) {
                                                    performSearch(keyword, false);
                                                }
                                            } else if (keyword.length === 0) {
                                                // Hide dropdown when search is empty
                                                hideDropdown();
                                            } else {
                                                // Hide dropdown when less than 2 characters
                                                hideDropdown();
                                            }
                                        }, 300);
                                    });

                                    // Handle form submission
                                    searchForm.addEventListener('submit', function (e) {
                                        e.preventDefault(); // Always prevent default form submission
                                        const keyword = searchInput.value.trim();

                                        if (keyword.length > 0) {
                                            // Redirect to search page with the keyword
                                            window.location.href = contextPath + '/products/search?keyword=' + encodeURIComponent(keyword);
                                        }
                                    });
                                }

                                function showDropdown() {
                                    if (searchDropdown && searchDropdown.parentElement) {
                                        searchDropdown.parentElement.style.display = 'block';
                                        dropdownVisible = true;
                                    }
                                }

                                function hideDropdown() {
                                    if (searchDropdown && searchDropdown.parentElement) {
                                        searchDropdown.parentElement.style.display = 'none';
                                        dropdownVisible = false;
                                    }
                                }

                                // Initially hide the dropdown
                                hideDropdown();

                                function fetchDropdownResults(keyword) {
                                    // Make AJAX request to search API for dropdown results
                                    fetch(contextPath + '/api/products/search?keyword=' + encodeURIComponent(keyword) + '&limit=4')
                                        .then(response => {
                                            if (!response.ok) {
                                                throw new Error('Network response was not ok');
                                            }
                                            return response.json();
                                        })
                                        .then(data => {
                                            // Update dropdown with search results
                                            updateDropdownResults(data);
                                        })
                                        .catch(error => {
                                            console.error('Error fetching dropdown search results:', error);
                                            // Show error in dropdown
                                            if (searchDropdown) {
                                                searchDropdown.innerHTML = `
                                                <div class="flex items-center justify-center bg-white p-4 rounded-lg">
                                                    <p class="text-red-500">Error loading results. Please try again.</p>
                                                </div>
                                            `;
                                            }
                                        });
                                }

                                function updateDropdownResults(data) {
                                    if (!searchDropdown) return;

                                    if (!data.products || data.products.length === 0) {
                                        // No results found
                                        searchDropdown.innerHTML = `
                                        <div class="flex items-center justify-center bg-white p-4 rounded-lg">
                                            <p class="text-gray-500">No products found</p>
                                        </div>
                                    `;
                                    } else {
                                        // Build HTML for dropdown results
                                        let resultsHTML = '';

                                        // Loop through up to 4 products
                                        data.products.slice(0, 4).forEach(product => {
                                            const imageUrl = product.image_url != null ? product.image_url : 'https://via.placeholder.com/60';
                                            const productName = product.product_name;
                                            const productPrice = product.price;
                                            const productId = product.product_id;

                                            resultsHTML += `
                                            <div class="flex items-center bg-white p-4 rounded-lg shadow-md hover:shadow-lg hover:scale-105 hover:bg-gray-100 transition-all duration-300 relative group">
                                                <img src="${'${imageUrl}'}" 
                                                    alt="${'${productName}'}"
                                                    class="w-16 h-16 object-cover rounded-md mr-4">
                                                <div class="flex flex-col">
                                                    <span class="text-lg font-semibold text-gray-800">${'${productName}'}</span>
                                                    <span class="text-sm text-gray-500 mt-1">$${'${productPrice}'}</span>
                                                </div>
                                                
                                                <!-- Quick View Button -->
                                                <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300 bg-black bg-opacity-50 rounded-lg">
                                                    <a href="${'${contextPath}'}/product/detail?id=${'${productId}'}"
                                                        class="bg-white px-4 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300 rounded">
                                                        Quick View
                                                    </a>
                                                </div>
                                            </div>
                                        `;
                                        });

                                        // Update dropdown content
                                        searchDropdown.innerHTML = resultsHTML;
                                    }
                                }

                                function performSearch(keyword, shouldUpdateUrl = true) {
                                    // Show loading indicator
                                    const searchSection = document.querySelector('.search-results-container');
                                    if (searchSection) {
                                        // Add loading state if needed
                                        searchSection.classList.add('loading');
                                        searchSection.innerHTML = '<div class="text-center py-8"><p>Loading results...</p></div>';
                                    }

                                    // Update the URL to reflect the search if requested
                                    if (shouldUpdateUrl) {
                                        const url = new URL(window.location.href);
                                        url.searchParams.set('keyword', keyword);
                                        window.history.pushState({}, '', url);
                                    }

                                    // Make AJAX request to search API
                                    fetch(contextPath + '/api/products/search?keyword=' + encodeURIComponent(keyword))
                                        .then(response => {
                                            if (!response.ok) {
                                                throw new Error('Network response was not ok');
                                            }
                                            return response.json();
                                        })
                                        .then(data => {
                                            // Update page content with search results
                                            updateSearchResults(data, keyword);
                                        })
                                        .catch(error => {
                                            console.error('Error fetching search results:', error);
                                            // Handle errors gracefully - show error message
                                            if (searchSection) {
                                                searchSection.innerHTML = `
                                                <div class="text-center py-8">
                                                    <p class="text-red-500">An error occurred while searching. Please try again.</p>
                                                </div>
                                            `;
                                            }
                                        })
                                        .finally(() => {
                                            // Remove loading state
                                            if (searchSection) {
                                                searchSection.classList.remove('loading');
                                            }
                                        });
                                }

                                function updateSearchResults(data, keyword) {
                                    // Get the section where we'll display search results
                                    const searchSection = document.querySelector('.search-results-container');

                                    if (!searchSection) {
                                        console.error('Search results container not found');
                                        return;
                                    }

                                    // Build HTML for search results
                                    let searchResultsHTML = `
                                    <div class="text-center mb-16">
                                        <h2 class="text-3xl font-light mb-4">
                                            Search Results for: "${'${keyword}'}"
                                        </h2>
                                        <div class="w-20 h-px bg-black mx-auto"></div>
                                        <p class="mt-4">
                                            Found ${'${data.totalRecords}'} results
                                        </p>
                                    </div>
                                `;

                                    // Add products grid
                                    searchResultsHTML += '<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">';

                                    if (!data.products || data.products.length === 0) {
                                        // No results found
                                        searchResultsHTML += `
                                        <div class="col-span-4 text-center py-10">
                                            <p>No results found</p>
                                        </div>
                                    `;
                                    } else {
                                        // Display products
                                        data.products.forEach(product => {
                                            const imageUrl = product.image_url || 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/e3956afad4ca48a3a33f6ee339a93a31_9366/manchester-united-ubp-tee.jpg';
                                            const hoverImageUrl = product.image_url || 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/170eb3f87f1e44c5ac8599ddb9b19969_9366/manchester-united-ubp-tee.jpg';
                                            const productName = product.product_name;
                                            const productPrice = product.price;
                                            const productId = product.product_id;
                                            const searchRank = product.search_rank;

                                            searchResultsHTML += `
                                            <div class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                                <div class="relative overflow-hidden h-96">
                                                    <img src="${'${imageUrl}'}"
                                                        alt="${'${productName}'}"
                                                        class="product-primary-image w-full h-full object-cover transition-opacity duration-300 ease-in-out group-hover:opacity-0">
                                                    <img src="${'${hoverImageUrl}'}"
                                                        alt="${'${productName}'} Hover"
                                                        class="product-hover-image absolute inset-0 w-full h-full object-cover opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
                                                    
                                                    <!-- Quick View Button -->
                                                    <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                                        <a href="${'${contextPath}'}/product/detail?id=${'${productId}'}"
                                                            class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                            Quick View
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <h3 class="text-lg font-light">${'${productName}'}</h3>
                                                    <p class="text-sm text-gray-600">$${'${productPrice}'}</p>
                                                    <p class="text-xs text-gray-500">
                                                        Rank: ${'${searchRank}'}
                                                    </p>
                                                </div>
                                            </div>
                                        `;
                                        });
                                    }

                                    searchResultsHTML += '</div>';

                                    // Add pagination if needed
                                    if (data.totalRecords > data.pageSize) {
                                        const totalPages = Math.ceil(data.totalRecords / data.pageSize);
                                        const currentPage = data.currentPage;
                                        const pageSize = data.pageSize;

                                        searchResultsHTML += `
                                        <div class="flex justify-center mt-10">
                                            <div class="flex items-center space-x-1">
                                    `;

                                        for (let i = 1; i <= totalPages; i++) {
                                            const isCurrentPage = i == currentPage;
                                            searchResultsHTML += `
                                            <a href="javascript:void(0)" 
                                               onclick="searchPage(${'${i}'}, ${'${pageSize}'}, '${'${keyword}'}')"
                                               class="${'${isCurrentPage ? "bg-black text-white" : "bg-white text-black"}'} px-4 py-2 border hover:bg-gray-200 transition">
                                                ${'${i}'}
                                            </a>
                                        `;
                                        }

                                        searchResultsHTML += `
                                            </div>
                                        </div>
                                    `;
                                    }

                                    // Update content
                                    searchSection.innerHTML = searchResultsHTML;
                                }

                                // Check if we're on search page and run search
                                if (window.location.href.includes('products/search')) {
                                    const urlParams = new URLSearchParams(window.location.search);
                                    const keyword = urlParams.get('keyword');

                                    if (keyword) {
                                        // Set the search input value
                                        if (searchInput) {
                                            searchInput.value = keyword;
                                        }

                                        // Perform the search
                                        setTimeout(() => {
                                            performSearch(keyword, false);
                                        }, 100);
                                    }
                                }

                                // Expose search page function globally
                                window.searchPage = function (page, size, keyword) {
                                    const url = new URL(window.location.href);
                                    url.searchParams.set('keyword', keyword);
                                    url.searchParams.set('page', page);
                                    url.searchParams.set('size', size);
                                    window.history.pushState({}, '', url);

                                    fetch(contextPath + '/api/products/search?keyword=' + encodeURIComponent(keyword) + '&page=' + page + '&size=' + size)
                                        .then(response => response.json())
                                        .then(data => {
                                            updateSearchResults(data, keyword);
                                        })
                                        .catch(error => {
                                            console.error('Error fetching paginated results:', error);
                                        });
                                };
                            });
                        </script>
                        <script>
                            function clearAddressData() {
                                // Clear GHN address data from localStorage
                                localStorage.removeItem('ghn_saved_addresses');
                                localStorage.removeItem('ghn_selected_address_id');
                                localStorage.removeItem('ghn_customer_id');
                                console.log('GHN address data cleared from localStorage');
                            }
                        </script>
                    </body>
                    <script>
                        // Expose search page function globally
                        window.searchPage = function (page, size, keyword) {
                            const url = new URL(window.location.href);
                            url.searchParams.set('keyword', keyword);
                            url.searchParams.set('page', page);
                            url.searchParams.set('size', size);
                            window.history.pushState({}, '', url);

                            fetch(contextPath + '/api/products/search?keyword=' + encodeURIComponent(keyword) + '&page=' + page
                                + '&size=' + size)
                                .then(response => response.json())
                                .then(data => {
                                    updateSearchResults(data, keyword);
                                })
                                .catch(error => {
                                    console.error('Error fetching paginated results:', error);
                                });
                        };
                    </script>
                    <script>
                        function clearAddressData() {
                            // Clear GHN address data from localStorage
                            localStorage.removeItem('ghn_saved_addresses');
                            localStorage.removeItem('ghn_selected_address_id');
                            localStorage.removeItem('ghn_customer_id');
                            console.log('GHN address data cleared from localStorage');
                        }
                    </script>
                    <script>
                        // Language dropdown toggle
                        document.addEventListener('DOMContentLoaded', function () {
                            const languageButton = document.getElementById('languageDropdownButton');
                            const languageDropdown = document.getElementById('languageDropdown');

                            if (languageButton && languageDropdown) {
                                // Toggle dropdown
                                languageButton.addEventListener('click', function (e) {
                                    e.stopPropagation();
                                    languageDropdown.classList.toggle('hidden');
                                });

                                // Close dropdown when clicking outside
                                document.addEventListener('click', function () {
                                    languageDropdown.classList.add('hidden');
                                });

                                // Prevent dropdown from closing when clicking inside it
                                languageDropdown.addEventListener('click', function (e) {
                                    e.stopPropagation();
                                });
                            }
                        });

                        // Function to change language
                        function changeLanguage(lang) {
                            // Create a hidden form to submit the language change
                            const form = document.createElement('form');
                            form.method = 'GET';
                            form.action = window.location.pathname;

                            // Add current query parameters except lang
                            const urlParams = new URLSearchParams(window.location.search);
                            urlParams.delete('lang');

                            urlParams.forEach((value, key) => {
                                const input = document.createElement('input');
                                input.type = 'hidden';
                                input.name = key;
                                input.value = value;
                                form.appendChild(input);
                            });

                            // Add the lang parameter
                            const langInput = document.createElement('input');
                            langInput.type = 'hidden';
                            langInput.name = 'lang';
                            langInput.value = lang;
                            form.appendChild(langInput);

                            // Submit the form
                            document.body.appendChild(form);
                            form.submit();
                        }
                    </script>
                    </body>

                    </html>
                    <!-- Font Awesome -->
                    <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>