<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | <c:choose>
                        <c:when test="${gender == 'men'}">Men's Categories</c:when>
                        <c:otherwise>Women's Categories</c:otherwise>
                    </c:choose>
                </title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${ctx}/resources/assets/client/css/category.css">
                <style>
                    .dropdown-menu a.font-bold {
                        background-color: #f3f4f6;
                    }

                    .category-image {
                        transition: transform 0.3s ease;
                    }

                    .group:hover .category-image {
                        transform: scale(1.05);
                    }
                </style>
            </head>

            <body class="bg-white text-gray-900">
                <!-- Sticky Navigation -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Hero Banner -->
                <section class="pt-24 pb-16">
                    <div class="max-w-7xl mx-auto px-6">
                        <div
                            class="relative w-full h-[600px] md:h-[700px] flex items-center justify-center overflow-hidden">
                            <img src="${gender == 'men' ? 'https://image.uniqlo.com/UQ/ST3/jp/imagesother/000_PLP/ShortPants/25SS/men/KV-m-Image-pc.jpg' : 'https://im.uniqlo.com/global-cms/spa/res766fcd71bbbeb0632d311be5b4bbf706fr.jpg'}"
                                alt="Fashion Categories"
                                class="absolute inset-0 w-full h-full object-contain md:object-cover opacity-90"
                                loading="lazy">
                            <div class="relative text-center px-6">
                                <h1 class="font-serif text-5xl md:text-7xl font-light mb-4 text-white drop-shadow-lg">
                                    <c:choose>
                                        <c:when test="${gender == 'men'}">Men's Fashion</c:when>
                                        <c:otherwise>Women's Fashion</c:otherwise>
                                    </c:choose>
                                </h1>
                                <p class="max-w-2xl mx-auto text-lg md:text-xl text-white drop-shadow-md">Explore our
                                    curated collection of categories</p>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Category Grid -->
                <section class="py-12">
                    <div class="max-w-7xl mx-auto px-6">
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <c:choose>
                                    <c:when test="${gender == 'men'}">Men's Categories</c:when>
                                    <c:otherwise>Women's Categories</c:otherwise>
                                </c:choose>
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                        </div>
                        <c:choose>
                            <c:when test="${not empty categories}">
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                                    <c:forEach var="category" items="${categories}">
                                        <div
                                            class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                            <a
                                                href="${ctx}/gender-product/products?gender=${gender}&categoryId=${category.categoryId}">
                                                <div class="relative overflow-hidden h-96">
                                                    <c:set var="categoryImage">
                                                        <c:choose>
                                                            <c:when test="${category.categoryId == 1}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_04_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 2}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_41_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 3}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_52_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 4}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_53_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 5}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_37_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 6}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_37_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 7}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_24_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 8}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_18_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 9}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_54_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 10}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_22_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 11}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_14_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 12}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_40_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 13}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_36_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 14}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_10_kv.jpg?250116
                                                            </c:when>
                                                            <c:when test="${category.categoryId == 15}">
                                                                https://www.uniqlo.com/jp/ja/contents/feature/masterpiece/common/img/product/item_23_kv.jpg?250116
                                                            </c:when>
                                                            <c:otherwise>https://via.placeholder.com/300</c:otherwise>
                                                        </c:choose>
                                                    </c:set>
                                                    <img src="${categoryImage}" alt="${category.categoryName}"
                                                        class="w-full h-full object-cover category-image"
                                                        loading="lazy">
                                                </div>
                                                <div class="mt-4 text-center">
                                                    <h3 class="text-lg font-light">${category.categoryName}</h3>
                                                </div>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-10 text-gray-500">
                                    <p>
                                        <spring:message code="category.noProductsFound" />
                                    </p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Dynamically adjust banner padding to account for navigation bar and dropdown height
                        const navBar = document.querySelector('nav');
                        const bannerSection = document.querySelector('.banner-section');
                        if (navBar && bannerSection) {
                            const navHeight = navBar.offsetHeight;
                            const dropdownHeight = 44; // Approximate height of translate-y-11
                            bannerSection.style.paddingTop = `${navHeight + dropdownHeight}px`;
                        }
                    });
                </script>
            </body>