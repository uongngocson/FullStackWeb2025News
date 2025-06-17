<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


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
                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.png"
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
                                        <!-- thời trang nam -->

                                        <li>
                                            <button
                                                :class="{ 'bg-neutral-100' : navigationMenu=='fashionMen', 'hover:bg-neutral-100' : navigationMenu!='fashionMen' }"
                                                @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='fashionMen'"
                                                @mouseleave="navigationMenuLeave()"
                                                class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                <span>
                                                    <a href="/product/item-male" class="active">
                                                        <spring:message code="navbar.men" />
                                                    </a>
                                                </span>
                                                <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'fashionMen' }"
                                                    class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round" aria-hidden="true">
                                                    <polyline points="6 9 12 15 18 9"></polyline>
                                                </svg>
                                            </button>
                                        </li>

                                        <!-- thời trang nữ -->
                                        <li>
                                            <button
                                                :class="{ 'bg-neutral-100' : navigationMenu=='women-section', 'hover:bg-neutral-100' : navigationMenu!='women-section' }"
                                                @mouseover="navigationMenuOpen=true; navigationMenuReposition($el); navigationMenu='women-section'"
                                                @mouseleave="navigationMenuLeave()"
                                                class="inline-flex items-center justify-center h-10 px-4 py-2 text-sm font-medium transition-colors rounded-md hover:text-neutral-900 focus:outline-none disabled:opacity-50 disabled:pointer-events-none bg-background hover:bg-neutral-100 group w-max">
                                                <span>
                                                    <a href="/product/item-female" class="active">
                                                        <spring:message code="navbar.women" />
                                                    </a>
                                                </span>
                                                <svg :class="{ '-rotate-180' : navigationMenuOpen==true && navigationMenu == 'women-section' }"
                                                    class="relative top-[1px] ml-1 h-3 w-3 ease-out duration-300"
                                                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none"
                                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                    stroke-linejoin="round" aria-hidden="true">
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
                                                DANH MỤC
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
                                    @mouseover="navigationMenuClearCloseTimeout()" @mouseleave="navigationMenuLeave()"
                                    class="absolute top-0 pt-3 duration-200 ease-out -translate-x-1/2 translate-y-11"
                                    x-cloak>
                                    <div
                                        class="flex justify-center w-auto h-auto overflow-hidden bg-white border rounded-md shadow-sm border-neutral-200/70">

                                        <div x-show="navigationMenu == 'fashionMen'"
                                            class="flex items-stretch justify-center w-full p-6">
                                            <div class="w-72">
                                                <a href="/product/category?categoryId=2&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Áo</span>
                                                    <span class="block font-light leading-5 opacity-50">Tất cả các
                                                        loại áo dành cho nam.</span>
                                                </a>
                                                <a href="/product/category?categoryId=3&sortBy=newest&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Quần</span>
                                                    <span class="block font-light leading-5 opacity-50">Quần dài,
                                                        quần ngắn và các loại quần khác cho nam.</span>
                                                </a>
                                                <a href="/product/category?categoryId=1&sortBy=newest&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Áo</span>
                                                    <span class="block leading-5 opacity-50">Các loại áo và phụ kiện
                                                        dành cho nam.</span>
                                                </a>
                                            </div>
                                            <div class="w-72">
                                                <a href="/product/category?categoryId=10&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Giày</span>
                                                    <span class="block font-light leading-5 opacity-50">Các loại
                                                        giày dành cho nam.</span>
                                                </a>
                                                <a href="/product/category?categoryId=9&page=1"
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
                                                    <span class="block mb-1 font-medium text-black">Giới thiệu</span>
                                                    <span class="block font-light leading-5 opacity-50">Khám phá bộ sưu
                                                        tập thời trang nam đẳng cấp và hiện đại.</span>
                                                </a>
                                                <a href="#_" @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Cách phối đồ</span>
                                                    <span class="block leading-5 opacity-50">Hướng dẫn phối đồ đơn giản,
                                                        phong cách và phù hợp từng dịp.</span>
                                                </a>
                                                <a href="#_" @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Bộ sưu tập
                                                        mới</span>
                                                    <span class="block leading-5 opacity-50">Cập nhật những xu hướng
                                                        thời trang nam mới nhất từ các nhà thiết kế nổi tiếng.</span>
                                                </a>
                                            </div>

                                        </div>
                                        <div x-show="navigationMenu == 'women-section'"
                                            class="flex items-stretch justify-center w-full p-6">
                                            <div class="w-72">
                                                <a href="/product/category?categoryId=1&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Áo</span>
                                                    <span class="block font-light leading-5 opacity-50">Tất cả các
                                                        loại áo dành cho nữ.</span>
                                                </a>
                                                <a href="/product/category?categoryId=3&sortBy=newest&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Quần</span>
                                                    <span class="block font-light leading-5 opacity-50">Quần dài,
                                                        quần ngắn và các loại quần khác cho nữ.</span>
                                                </a>
                                                <a href="/product/category?categoryId=6&sortBy=newest&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Váy đầm</span>
                                                    <span class="block leading-5 opacity-50">Các loại váy và đầm
                                                        dành cho nữ.</span>
                                                </a>
                                            </div>
                                            <div class="w-72">
                                                <a href="/product/category?categoryId=10&sortBy=newest&page=1"
                                                    @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Giày</span>
                                                    <span class="block font-light leading-5 opacity-50">Các loại
                                                        giày dành cho nữ.</span>
                                                </a>
                                                <a href="/product/category?categoryId=15&sortBy=newest&page=1"
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
                                                <a href="/product/category?type=clothing" @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Quần áo</span>
                                                    <span class="block font-light leading-5 opacity-50">Tất cả các
                                                        loại quần áo.</span>
                                                </a>
                                                <a href="/product/category?type=footwear" @click="navigationMenuClose()"
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
                                                <a href="/product/category?gender=men" @click="navigationMenuClose()"
                                                    class="block px-3.5 py-3 text-sm rounded hover:bg-neutral-100">
                                                    <span class="block mb-1 font-medium text-black">Nam</span>
                                                    <span class="block font-light leading-5 opacity-50">Tất cả sản
                                                        phẩm dành cho nam.</span>
                                                </a>
                                                <a href="/product/category?gender=women" @click="navigationMenuClose()"
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
                                            action="${pageContext.request.contextPath}/products/search" method="get">
                                            <input type="text" name="keyword" id="searchInput" placeholder="Tìm kiếm"
                                                value="${searchKeyword != null ? searchKeyword : ''}">
                                            <button type="submit"
                                                style="background: none; border: none; cursor: pointer;">
                                                <i class="uil uil-search"></i>
                                            </button>

                                        </form>

                                        <div class="absolute top-10 z-50 right-2 w-full h-full">
                                            <div class="flex flex-col min-w-[350px] h-auto bg-[#E9ECEF] p-4 space-y-4">
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
                                    <a class="relative mt-[6px]  " href="/user/cart">
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
                                                        <c:choose>
                                                            <c:when test="${customer.imageUrl.startsWith('http')}">
                                                                <img src="${customer.imageUrl}" alt="Profile Image" class="w-10 h-10 rounded-full object-cover border-2 border-white">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${ctx}${customer.imageUrl}" alt="Profile Image" class="w-10 h-10 rounded-full object-cover border-2 border-white">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <div class="text-center font-semibold text-gray-800 text-lg mt-3">
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

                                <a class="mt-[7px]" href="/user/productfavriote"> <i class="uil uil-heart"></i></a>

                                <!-- notification -->
                                <div class="relative group">  
                                    <div class="flex items-center justify-center w-10 h-10 rounded-full hover:bg-gray-100 cursor-pointer transition-all duration-200">
                                        <i class="uil uil-bell text-xl"></i>
                                        <span class="absolute top-0 right-0 inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none text-red-100 transform translate-x-1/2 -translate-y-1/2 bg-red-600 rounded-full animate-pulse">3</span>
                                    </div>
                                    
                                    <!-- Notification dropdown -->
                                    <div class="absolute right-0 w-96 mt-2 origin-top-right bg-white divide-y divide-gray-100 rounded-lg shadow-2xl opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 z-50 transform scale-95 group-hover:scale-100">
                                        <!-- Header with notification count -->
                                        <div class="px-6 py-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-t-lg border-b border-gray-200">
                                            <div class="flex items-center justify-between">
                                                <h3 class="text-lg font-semibold text-gray-800">Thông báo</h3>
                                                <span class="inline-flex items-center justify-center px-2.5 py-0.5 text-xs font-medium bg-blue-100 text-blue-800 rounded-full">3 mới</span>
                                            </div>
                                        </div>
                                        
                                        <!-- Notification list with max height and scrolling -->
                                        <div class="py-2 max-h-96 overflow-y-auto scrollbar-thin scrollbar-thumb-gray-300 scrollbar-track-gray-100">
                                            <!-- Unread notification with highlight -->
                                            <a href="#" class="flex px-6 py-4 hover:bg-blue-50 transition-colors duration-200 border-l-4 border-blue-500">
                                                <div class="flex-shrink-0">
                                                    <div class="w-12 h-12 rounded-full bg-indigo-100 flex items-center justify-center">
                                                        <i class="uil uil-box text-indigo-500 text-xl"></i>
                                                    </div>
                                                </div>
                                                <div class="ml-4 w-0 flex-1">
                                                    <div class="flex items-center justify-between">
                                                        <p class="text-sm font-medium text-gray-900">Đơn hàng #1234 đã được xác nhận</p>
                                                        <span class="inline-block w-2 h-2 bg-blue-600 rounded-full"></span>
                                                    </div>
                                                    <p class="mt-1 text-sm text-gray-500 line-clamp-2">Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị giao đến bạn.</p>
                                                    <p class="mt-1 text-xs text-gray-400 flex items-center">
                                                        <i class="uil uil-clock-three mr-1"></i> 5 phút trước
                                                    </p>
                                                </div>
                                            </a>
                                            
                                            <!-- Promotion notification -->
                                            <a href="#" class="flex px-6 py-4 hover:bg-blue-50 transition-colors duration-200 border-l-4 border-green-500">
                                                <div class="flex-shrink-0">
                                                    <div class="w-12 h-12 rounded-full bg-green-100 flex items-center justify-center">
                                                        <i class="uil uil-percentage text-green-500 text-xl"></i>
                                                    </div>
                                                </div>
                                                <div class="ml-4 w-0 flex-1">
                                                    <div class="flex items-center justify-between">
                                                        <p class="text-sm font-medium text-gray-900">Giảm giá 20% cho tất cả sản phẩm</p>
                                                        <span class="inline-block w-2 h-2 bg-blue-600 rounded-full"></span>
                                                    </div>
                                                    <p class="mt-1 text-sm text-gray-500 line-clamp-2">Sử dụng mã SUMMER2023 để nhận ưu đãi đặc biệt khi mua sắm.</p>
                                                    <p class="mt-1 text-xs text-gray-400 flex items-center">
                                                        <i class="uil uil-clock-three mr-1"></i> 1 giờ trước
                                                    </p>
                                                </div>
                                            </a>
                                            
                                            <!-- Shipping notification -->
                                            <a href="#" class="flex px-6 py-4 hover:bg-blue-50 transition-colors duration-200 border-l-4 border-yellow-500">
                                                <div class="flex-shrink-0">
                                                    <div class="w-12 h-12 rounded-full bg-yellow-100 flex items-center justify-center">
                                                        <i class="uil uil-truck text-yellow-500 text-xl"></i>
                                                    </div>
                                                </div>
                                                <div class="ml-4 w-0 flex-1">
                                                    <div class="flex items-center justify-between">
                                                        <p class="text-sm font-medium text-gray-900">Đơn hàng #1189 đang được vận chuyển</p>
                                                        <span class="inline-block w-2 h-2 bg-blue-600 rounded-full"></span>
                                                    </div>
                                                    <p class="mt-1 text-sm text-gray-500 line-clamp-2">Đơn hàng của bạn đang trên đường giao và sẽ đến trong vòng 2-3 ngày tới.</p>
                                                    <p class="mt-1 text-xs text-gray-400 flex items-center">
                                                        <i class="uil uil-clock-three mr-1"></i> 1 ngày trước
                                                    </p>
                                                </div>
                                            </a>
                                            
                                            <!-- Read notification (gray) -->
                                            <a href="#" class="flex px-6 py-4 hover:bg-gray-50 transition-colors duration-200 border-l-4 border-transparent">
                                                <div class="flex-shrink-0">
                                                    <div class="w-12 h-12 rounded-full bg-gray-100 flex items-center justify-center">
                                                        <i class="uil uil-envelope-check text-gray-500 text-xl"></i>
                                                    </div>
                                                </div>
                                                <div class="ml-4 w-0 flex-1">
                                                    <p class="text-sm font-medium text-gray-700">Xác nhận email thành công</p>
                                                    <p class="mt-1 text-sm text-gray-500 line-clamp-2">Tài khoản của bạn đã được xác minh thành công.</p>
                                                    <p class="mt-1 text-xs text-gray-400 flex items-center">
                                                        <i class="uil uil-clock-three mr-1"></i> 3 ngày trước
                                                    </p>
                                                </div>
                                            </a>
                                        </div>
                                        
                                        <!-- Footer with view all link -->
                                        <div class="py-2 bg-gradient-to-r from-gray-50 to-gray-100 rounded-b-lg">
                                            <a href="#" class="block px-6 py-3 text-sm text-center font-medium text-indigo-600 hover:text-indigo-800 hover:bg-gray-100 transition-colors duration-200 rounded-md mx-2">
                                                <div class="flex items-center justify-center">
                                                    <span>Xem tất cả thông báo</span>
                                                    <i class="uil uil-arrow-right ml-2"></i>
                                                </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- language -->
                            <div class="user flex gap-2 sm:gap-6 items-center justify-center">
                                <div class="language-selector relative">
                                    <button id="languageDropdownButton" class="flex items-center gap-2 focus:outline-none">
                                        <c:choose>
                                            <c:when test="${pageContext.response.locale.language == 'vi'}">
                                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/vi.jpg" alt="Vietnamese" class="w-5 h-5 rounded-sm">
                                                <span class="hidden sm:inline">VN</span>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/resources/assets/client/images/en.jpg" alt="English" class="w-5 h-5 rounded-sm">
                                                <span class="hidden sm:inline">EN</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <i class="uil uil-angle-down text-xs"></i>
                                    </button>
                                    <div id="languageDropdown" class="absolute right-0 mt-2 bg-white rounded-md shadow-lg py-1 z-50 hidden">
                                        <a href="javascript:void(0)" onclick="changeLanguage('vi')" class="language-option flex items-center gap-2 px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale.language == 'vi' ? 'font-bold bg-gray-50' : ''}">
                                            <img src="${pageContext.request.contextPath}/resources/assets/client/images/vi.jpg" alt="Vietnamese" class="w-5 h-5 rounded-sm">
                                            <span>Tiếng Việt</span>
                                        </a>
                                        <a href="javascript:void(0)" onclick="changeLanguage('en')" class="language-option flex items-center gap-2 px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale.language == 'en' ? 'font-bold bg-gray-50' : ''}">
                                            <img src="${pageContext.request.contextPath}/resources/assets/client/images/en.jpg" alt="English" class="w-5 h-5 rounded-sm">
                                            <span>English</span>
                                        </a>
                                    </div>
                                </div>
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
                            window.searchPage = function(page, size, keyword) {
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
                    <script>
                        // Language dropdown toggle
                        document.addEventListener('DOMContentLoaded', function() {
                            const languageButton = document.getElementById('languageDropdownButton');
                            const languageDropdown = document.getElementById('languageDropdown');
                            
                            if (languageButton && languageDropdown) {
                                // Toggle dropdown
                                languageButton.addEventListener('click', function(e) {
                                    e.stopPropagation();
                                    languageDropdown.classList.toggle('hidden');
                                });
                                
                                // Close dropdown when clicking outside
                                document.addEventListener('click', function() {
                                    languageDropdown.classList.add('hidden');
                                });
                                
                                // Prevent dropdown from closing when clicking inside it
                                languageDropdown.addEventListener('click', function(e) {
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
                    
                    <!-- AJAX Navigation Script -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function() {
                            // Main content container where we'll load the AJAX content
                            const mainContentId = 'ajax-main-content';
                            
                            // Create main content container if it doesn't exist
                            if (!document.getElementById(mainContentId)) {
                                const mainContent = document.createElement('div');
                                mainContent.id = mainContentId;
                                
                                // Find the appropriate place to insert the main content container
                                // Right after the header
                                const header = document.querySelector('header');
                                if (header && header.nextSibling) {
                                    document.body.insertBefore(mainContent, header.nextSibling);
                                } else {
                                    document.body.appendChild(mainContent);
                                }
                                
                                // Move all content after header into the main content container
                                let currentNode = mainContent.nextSibling;
                                const nodesToMove = [];
                                
                                while (currentNode && currentNode !== document.querySelector('script:last-of-type').previousElementSibling) {
                                    nodesToMove.push(currentNode);
                                    currentNode = currentNode.nextSibling;
                                }
                                
                                nodesToMove.forEach(node => {
                                    if (node.nodeName !== 'SCRIPT') {
                                        mainContent.appendChild(node);
                                    }
                                });
                            }
                            
                            // Store the current URL to detect navigation changes
                            let currentUrl = window.location.href;
                            
                            // Function to load content via AJAX
                            function loadContent(url, pushState = true) {
                                // Show loading indicator
                                const loadingIndicator = document.createElement('div');
                                loadingIndicator.id = 'ajax-loading-indicator';
                                loadingIndicator.innerHTML = '<div class="flex justify-center items-center p-10"><div class="animate-spin rounded-full h-12 w-12 border-b-2 border-black"></div></div>';
                                
                                const mainContent = document.getElementById(mainContentId);
                                if (mainContent) {
                                    // Only show loading indicator for non-fragment navigation
                                    if (!url.includes('#')) {
                                        mainContent.innerHTML = '';
                                        mainContent.appendChild(loadingIndicator);
                                    }
                                }
                                
                                // Store original URL for error handling
                                const originalUrl = url;
                                
                                // Add cache busting parameter to prevent caching issues
                                const cacheBuster = '_=' + new Date().getTime();
                                url = url.includes('?') ? `${url}&${cacheBuster}` : `${url}?${cacheBuster}`;
                                
                                // Make the AJAX request with proper headers and credentials
                                fetch(url, {
                                    headers: {
                                        'X-Requested-With': 'XMLHttpRequest',
                                        'Accept': 'text/html, */*',
                                        'Cache-Control': 'no-cache, no-store, must-revalidate'
                                    },
                                    credentials: 'same-origin', // Include cookies for session maintenance
                                    cache: 'no-store' // Prevent caching
                                })
                                .then(response => {
                                    // Check for redirects (could indicate session timeout or auth issues)
                                    if (response.redirected) {
                                        window.location.href = response.url;
                                        return null;
                                    }
                                    
                                    if (!response.ok) {
                                        throw new Error(`Network response error: ${response.status} ${response.statusText}`);
                                    }
                                    
                                    // Get both the response text and the final URL (in case of redirects)
                                    return response.text().then(text => ({
                                        html: text,
                                        finalUrl: response.url
                                    }));
                                })
                                .then(data => {
                                    // If the request was aborted or redirected
                                    if (!data) return;
                                    
                                    const { html, finalUrl } = data;
                                    
                                    // Verify we actually got HTML content
                                    if (!html || html.trim() === '') {
                                        console.error('Empty response received');
                                        window.location.href = originalUrl;
                                        return;
                                    }
                                    
                                    // Check if the response contains an error page or login page
                                    if (html.includes('<title>Error</title>') || 
                                        html.includes('<title>Login</title>') ||
                                        html.includes('login-form')) {
                                        console.log('Received error or login page, redirecting');
                                        window.location.href = originalUrl;
                                        return;
                                    }
                                    
                                    // Create a temporary element to parse the HTML
                                    const parser = new DOMParser();
                                    const doc = parser.parseFromString(html, 'text/html');
                                    
                                    // Verify we have a proper document
                                    if (!doc || !doc.body) {
                                        console.error('Invalid HTML document received');
                                        window.location.href = originalUrl;
                                        return;
                                    }
                                    
                                    // Extract the main content from the response
                                    // This assumes there's a specific container in your pages
                                    // You may need to adjust this selector based on your page structure
                                    const newContent = doc.querySelector('body > *:not(header):not(script)');
                                    
                                    // Verify we found content
                                    if (!newContent) {
                                        console.error('Could not find main content in the response');
                                        window.location.href = originalUrl;
                                        return;
                                    }
                                    
                                    // Check if the response contains actual data by looking for expected elements
                                    // Adjust these selectors based on your page structure
                                    const hasContent = doc.body.textContent.trim().length > 0;
                                    
                                    if (!hasContent) {
                                        console.error('Response appears to be empty or invalid');
                                        window.location.href = originalUrl;
                                        return;
                                    }
                                    
                                    // Update the page title
                                    const title = doc.querySelector('title');
                                    if (title) {
                                        document.title = title.textContent;
                                    }
                                    
                                    // Update the main content
                                    if (mainContent) {
                                        mainContent.innerHTML = '';
                                        
                                        // First collect all scripts to execute them later
                                        const scriptsToExecute = [];
                                        const externalScriptsToLoad = [];
                                        
                                        // Process scripts first
                                        Array.from(doc.querySelectorAll('script')).forEach(script => {
                                            if (!script.src && script.textContent && !script.textContent.includes('document.addEventListener(\'DOMContentLoaded\'')) {
                                                scriptsToExecute.push(script.textContent);
                                            } else if (script.src) {
                                                // Check if script already exists
                                                const scriptExists = Array.from(document.querySelectorAll('script')).some(
                                                    s => s.src === script.src
                                                );
                                                
                                                if (!scriptExists) {
                                                    externalScriptsToLoad.push(script);
                                                }
                                            }
                                        });
                                        
                                        // Extract and preserve any server-side data embedded in the page
                                        // This is crucial for maintaining state between AJAX loads
                                        const dataElements = [];
                                        
                                        // Find elements with data attributes or model attributes
                                        doc.querySelectorAll('[data-model], [data-items], [data-value], [data-id], [data-product-id], [data-category-id]').forEach(el => {
                                            dataElements.push(el.cloneNode(true));
                                        });
                                        
                                        // Find server-side variables in script tags (common pattern)
                                        const dataScripts = Array.from(doc.querySelectorAll('script')).filter(script => 
                                            !script.src && script.textContent && 
                                            (script.textContent.includes('var ') || 
                                             script.textContent.includes('let ') || 
                                             script.textContent.includes('const '))
                                        );
                                        
                                        // Clone all content nodes and append them
                                        Array.from(doc.body.children).forEach(child => {
                                            if (child.tagName !== 'HEADER' && !child.matches('script')) {
                                                const clonedNode = child.cloneNode(true);
                                                
                                                // Handle forms with CSRF tokens
                                                const forms = clonedNode.querySelectorAll('form');
                                                forms.forEach(form => {
                                                    // For forms that need to submit normally (not AJAX)
                                                    if (form.method === 'post' || form.getAttribute('data-ajax') === 'false') {
                                                        form.setAttribute('data-ajax', 'false');
                                                    }
                                                    
                                                    // Ensure CSRF tokens are preserved
                                                    const csrfInput = form.querySelector('input[name="_csrf"]');
                                                    if (csrfInput) {
                                                        // Make sure we have the latest CSRF token
                                                        const currentCsrfMeta = document.querySelector('meta[name="_csrf"]');
                                                        if (currentCsrfMeta) {
                                                            csrfInput.value = currentCsrfMeta.getAttribute('content');
                                                        }
                                                    }
                                                });
                                                
                                                mainContent.appendChild(clonedNode);
                                            }
                                        });
                                        
                                        // Re-inject any data elements that might have been missed
                                        dataElements.forEach(el => {
                                            // Find a matching element in the new DOM to replace or append to
                                            const selector = el.id ? `#${el.id}` : 
                                                           (el.className ? `.${el.className.split(' ').join('.')}` : null);
                                            
                                            if (selector) {
                                                const target = mainContent.querySelector(selector);
                                                if (target) {
                                                    // Copy data attributes
                                                    Array.from(el.attributes).forEach(attr => {
                                                        if (attr.name.startsWith('data-')) {
                                                            target.setAttribute(attr.name, attr.value);
                                                        }
                                                    });
                                                }
                                            }
                                        });
                                        
                                        // Execute inline scripts in correct order
                                        scriptsToExecute.forEach(scriptContent => {
                                            try {
                                                const scriptElement = document.createElement('script');
                                                scriptElement.textContent = scriptContent;
                                                document.body.appendChild(scriptElement);
                                            } catch (e) {
                                                console.error('Error executing script:', e);
                                            }
                                        });
                                        
                                        // Execute data scripts first to ensure data is available
                                        dataScripts.forEach(script => {
                                            try {
                                                const scriptElement = document.createElement('script');
                                                scriptElement.textContent = script.textContent;
                                                document.body.appendChild(scriptElement);
                                            } catch (e) {
                                                console.error('Error executing data script:', e);
                                            }
                                        });
                                        
                                        // Load external scripts
                                        let scriptsLoaded = 0;
                                        const totalExternalScripts = externalScriptsToLoad.length;
                                        
                                        function checkAllScriptsLoaded() {
                                            scriptsLoaded++;
                                            if (scriptsLoaded === totalExternalScripts) {
                                                // All scripts loaded, now initialize any components
                                                setTimeout(() => {
                                                    initializeComponents();
                                                    
                                                    // Double-check if content is still empty and reload if necessary
                                                    if (mainContent.textContent.trim().length === 0) {
                                                        console.warn('Content appears empty after loading, reloading page...');
                                                        window.location.href = originalUrl;
                                                    }
                                                }, 100); // Small delay to ensure DOM is updated
                                            }
                                        }
                                        
                                        // Load external scripts if any
                                        if (totalExternalScripts > 0) {
                                            externalScriptsToLoad.forEach(script => {
                                                const newScript = document.createElement('script');
                                                Array.from(script.attributes).forEach(attr => {
                                                    newScript.setAttribute(attr.name, attr.value);
                                                });
                                                
                                                newScript.onload = function() {
                                                    console.log('External script loaded:', script.src);
                                                    checkAllScriptsLoaded();
                                                };
                                                
                                                newScript.onerror = function() {
                                                    console.error('Error loading script:', script.src);
                                                    checkAllScriptsLoaded();
                                                };
                                                
                                                document.body.appendChild(newScript);
                                            });
                                        } else {
                                            // No external scripts, initialize components immediately
                                            setTimeout(() => {
                                                initializeComponents();
                                                
                                                // Double-check if content is still empty
                                                if (mainContent.textContent.trim().length === 0) {
                                                    console.warn('Content appears empty after loading, reloading page...');
                                                    window.location.href = originalUrl;
                                                }
                                            }, 100); // Small delay to ensure DOM is updated
                                        }
                                        
                                        // Update browser history if needed
                                        if (pushState) {
                                            // Use the original URL without cache busting for history
                                            history.pushState({url: originalUrl}, document.title, originalUrl);
                                            currentUrl = originalUrl;
                                        }
                                        
                                        // Scroll to top
                                        window.scrollTo(0, 0);
                                    }
                                })
                                .catch(error => {
                                    console.error('Error loading content:', error);
                                    // Fallback to normal navigation
                                    window.location.href = originalUrl;
                                });
                            }
                            
                            // Function to initialize components and attach event listeners
                            function initializeComponents() {
                                // Reinitialize Alpine.js components if Alpine is loaded
                                if (window.Alpine) {
                                    // For Alpine.js v2
                                    if (typeof window.Alpine.initializeComponent === 'function') {
                                        document.querySelectorAll('[x-data]').forEach(el => {
                                            window.Alpine.initializeComponent(el);
                                        });
                                    } 
                                    // For Alpine.js v3
                                    else if (typeof window.Alpine.initTree === 'function') {
                                        window.Alpine.initTree(document.body);
                                    }
                                }
                                
                                // Reattach event listeners for buttons
                                document.querySelectorAll('button[type="submit"]').forEach(button => {
                                    if (!button.getAttribute('data-ajax-initialized')) {
                                        button.setAttribute('data-ajax-initialized', 'true');
                                        
                                        // Check if button is in a form
                                        const form = button.closest('form');
                                        if (form && form.getAttribute('data-ajax') !== 'false') {
                                            // Make sure form submits work properly
                                            button.addEventListener('click', function(e) {
                                                if (form.getAttribute('data-ajax') !== 'false') {
                                                    // Let the form submit normally
                                                    return true;
                                                }
                                            });
                                        }
                                    }
                                });
                                
                                // Handle other buttons (not in forms)
                                document.querySelectorAll('button:not([type="submit"])').forEach(button => {
                                    if (!button.getAttribute('data-ajax-initialized') && !button.closest('[x-data]')) {
                                        button.setAttribute('data-ajax-initialized', 'true');
                                        
                                        // Check if button has a click handler via onclick attribute
                                        const onclickAttr = button.getAttribute('onclick');
                                        if (onclickAttr) {
                                            // We don't need to do anything, the onclick will be preserved
                                        } else {
                                            // For buttons without explicit handlers, ensure they're clickable
                                            button.addEventListener('click', function(e) {
                                                // Default button behavior
                                                return true;
                                            });
                                        }
                                    }
                                });
                                
                                // Re-initialize any custom components or plugins
                                // For example, if you use jQuery plugins:
                                if (window.jQuery) {
                                    // Reinitialize jQuery plugins here
                                    if (jQuery.fn.select2) {
                                        jQuery('.select2').select2();
                                    }
                                    
                                    // Reinitialize any other jQuery plugins
                                    // ...
                                }
                                
                                // Handle any special cases for specific pages
                                const currentPath = window.location.pathname;
                                
                                // Example: If on product detail page, initialize product image slider
                                if (currentPath.includes('/product/detail')) {
                                    // Initialize product sliders or other product page specific functionality
                                    if (typeof initProductPage === 'function') {
                                        initProductPage();
                                    }
                                }
                                
                                // Example: If on cart page, initialize quantity controls
                                if (currentPath.includes('/user/cart')) {
                                    // Attach event listeners to quantity buttons
                                    document.querySelectorAll('.quantity-btn').forEach(btn => {
                                        btn.addEventListener('click', function() {
                                            // Your quantity change logic
                                        });
                                    });
                                }
                                
                                // Trigger a custom event that page-specific scripts can listen for
                                document.dispatchEvent(new CustomEvent('ajax-content-loaded', {
                                    detail: { url: window.location.href }
                                }));
                            }
                            
                            // Intercept all navigation link clicks
                            document.body.addEventListener('click', function(e) {
                                // Find the closest anchor tag
                                let target = e.target;
                                while (target && target.tagName !== 'A') {
                                    target = target.parentNode;
                                    if (!target || target === document.body) break;
                                }
                                
                                // Process only if it's a link
                                if (target && target.tagName === 'A') {
                                    const href = target.getAttribute('href');
                                    
                                    // Skip if:
                                    // - No href
                                    // - External link
                                    // - JavaScript link
                                    // - Download link
                                    // - Mail link
                                    // - Has target="_blank"
                                    // - Is a login/logout link
                                    if (!href || 
                                        href.startsWith('http') && !href.startsWith(window.location.origin) ||
                                        href.startsWith('javascript:') || 
                                        href.startsWith('#') ||
                                        target.getAttribute('download') || 
                                        href.startsWith('mailto:') ||
                                        target.getAttribute('target') === '_blank' ||
                                        href.includes('login') ||
                                        href.includes('logout') ||
                                        target.closest('form') ||
                                        target.getAttribute('data-ajax') === 'false') {
                                        return; // Let the default behavior handle it
                                    }
                                    
                                    // Special handling for navigation menu items
                                    if (target.closest('[x-data]')) {
                                        // Check if this is a navigation menu item with a dropdown
                                        const navItem = target.closest('button');
                                        if (navItem && navItem.getAttribute('@mouseover') && navItem.getAttribute('@mouseover').includes('navigationMenu')) {
                                            // This is a dropdown trigger, don't intercept
                                            return;
                                        }
                                        
                                        // Check if this is a link inside a dropdown
                                        const dropdownLink = target.closest('a[href][onclick]');
                                        if (dropdownLink && dropdownLink.getAttribute('onclick') && 
                                            dropdownLink.getAttribute('onclick').includes('navigationMenuClose')) {
                                            // This is a dropdown item with a close action
                                            // Let the onclick handle it first, then we'll navigate
                                            e.preventDefault();
                                            
                                            // Execute the onclick (which closes the dropdown)
                                            const onclickAttr = dropdownLink.getAttribute('onclick');
                                            if (onclickAttr && onclickAttr.includes('navigationMenuClose')) {
                                                // Call the navigationMenuClose function
                                                const navMenu = target.closest('[x-data]').__x.$data;
                                                if (navMenu && typeof navMenu.navigationMenuClose === 'function') {
                                                    navMenu.navigationMenuClose();
                                                }
                                            }
                                            
                                            // Then load the content after a small delay
                                            setTimeout(() => {
                                                loadContent(href);
                                            }, 100);
                                            
                                            return;
                                        }
                                    }
                                    
                                    // Prevent default link behavior
                                    e.preventDefault();
                                    
                                    // Load the content via AJAX
                                    loadContent(href);
                                }
                            });
                            
                            // Handle browser back/forward navigation
                            window.addEventListener('popstate', function(e) {
                                if (e.state && e.state.url) {
                                    loadContent(e.state.url, false);
                                } else {
                                    loadContent(window.location.href, false);
                                }
                            });
                            
                            // Initialize history state
                            history.replaceState({url: window.location.href}, document.title, window.location.href);
                            
                            // Add CSS for loading indicator
                            const style = document.createElement('style');
                            style.textContent = `
                                #ajax-loading-indicator {
                                    position: relative;
                                    width: 100%;
                                    padding: 2rem;
                                    text-align: center;
                                }
                            `;
                            document.head.appendChild(style);
                        });
                    </script>
                </body>

                </html>
                <!-- Font Awesome -->
                <script src="https://kit.fontawesome.com/73713bf219.js" crossorigin="anonymous"></script>