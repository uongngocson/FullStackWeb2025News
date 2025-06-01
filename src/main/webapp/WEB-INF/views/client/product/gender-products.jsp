<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | <c:choose>
                            <c:when test="${category != null}">${category.categoryName}</c:when>
                            <c:otherwise>All Products</c:otherwise>
                        </c:choose> - <c:choose>
                            <c:when test="${gender == 'men'}">Men</c:when>
                            <c:otherwise>Women</c:otherwise>
                        </c:choose>
                    </title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="${ctx}/resources/assets/client/css/category.css">
                    <style>
                        .dropdown-menu a.font-bold {
                            background-color: #f3f4f6;
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
                                    alt="<c:choose><c:when test=" ${category !=null}">${category.categoryName}</c:when>
                                <c:otherwise>All Products</c:otherwise>
                                </c:choose> Collection"
                                class="absolute inset-0 w-full h-full object-contain md:object-cover opacity-90"
                                loading="lazy">
                                <div class="relative text-center px-6">
                                    <h1
                                        class="font-serif text-5xl md:text-7xl font-light mb-4 text-white drop-shadow-lg">
                                        <c:choose>
                                            <c:when test="${category != null}">${category.categoryName}</c:when>
                                            <c:otherwise>All Products</c:otherwise>
                                        </c:choose> for <c:choose>
                                            <c:when test="${gender == 'men'}">Men</c:when>
                                            <c:otherwise>Women</c:otherwise>
                                        </c:choose>
                                    </h1>
                                    <p class="max-w-2xl mx-auto text-lg md:text-xl text-white drop-shadow-md">Discover
                                        our curated <c:choose>
                                            <c:when test="${category != null}">${category.categoryName}</c:when>
                                            <c:otherwise>product</c:otherwise>
                                        </c:choose> collection</p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Filter and Sort Bar -->
                    <section class="py-6 border-b border-gray-100">
                        <div class="max-w-7xl mx-auto px-6">
                            <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                                <div class="text-sm">
                                    <c:set var="startItem" value="${(currentPage - 1) * pageSize + 1}" />
                                    <c:set var="endItem" value="${currentPage * pageSize}" />
                                    <c:if test="${endItem > totalElements}">
                                        <c:set var="endItem" value="${totalElements}" />
                                    </c:if>
                                    <c:if test="${totalElements == 0}">
                                        <c:set var="startItem" value="0" />
                                    </c:if>
                                    <spring:message code="category.showingProducts"
                                        arguments="${startItem},${endItem},${totalElements}" />
                                </div>

                                <div class="flex flex-wrap gap-3">
                                    <!-- Base URL for Sort -->
                                    <c:url var="baseFilterUrl"
                                        value="/gender-product/${category != null ? 'products' : gender.concat('-products')}">
                                        <c:if test="${category != null}">
                                            <c:param name="categoryId" value="${category.categoryId}" />
                                        </c:if>
                                        <c:param name="gender" value="${gender}" />
                                        <c:param name="sortBy" value="${selectedSortBy}" />
                                        <c:param name="page" value="1" />
                                    </c:url>

                                    <!-- Sort Dropdown (Price Only) -->
                                    <div class="dropdown relative">
                                        <button
                                            class="flex items-center gap-2 px-4 py-2 border border-gray-200 text-sm hover:bg-gray-50">
                                            <spring:message code="category.dropdown.sortBy" /> <i
                                                class="fa-solid fa-chevron-down text-xs"></i>
                                        </button>
                                        <div
                                            class="dropdown-menu absolute hidden right-0 mt-1 w-48 bg-white border border-gray-200 shadow-lg z-10">
                                            <c:url var="sortPriceAscUrl"
                                                value="/gender-product/${category != null ? 'products' : gender.concat('-products')}">
                                                <c:if test="${category != null}">
                                                    <c:param name="categoryId" value="${category.categoryId}" />
                                                </c:if>
                                                <c:param name="gender" value="${gender}" />
                                                <c:param name="sortBy" value="priceAsc" />
                                                <c:param name="page" value="1" />
                                            </c:url>
                                            <a href="${sortPriceAscUrl}"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'priceAsc' ? 'font-bold' : ''}">
                                                <spring:message code="category.sort.priceAsc" />
                                            </a>
                                            <c:url var="sortPriceDescUrl"
                                                value="/gender-product/${category != null ? 'products' : gender.concat('-products')}">
                                                <c:if test="${category != null}">
                                                    <c:param name="categoryId" value="${category.categoryId}" />
                                                </c:if>
                                                <c:param name="gender" value="${gender}" />
                                                <c:param name="sortBy" value="priceDesc" />
                                                <c:param name="page" value="1" />
                                            </c:url>
                                            <a href="${sortPriceDescUrl}"
                                                class="block px-4 py-2 text-sm hover:bg-gray-50 ${selectedSortBy == 'priceDesc' ? 'font-bold' : ''}">
                                                <spring:message code="category.sort.priceDesc" />
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Product Grid -->
                    <section class="py-12">
                        <div class="max-w-7xl mx-auto px-6">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
                                        <c:forEach items="${products}" var="p">
                                            <div class="product-card group relative">
                                                <div class="relative overflow-hidden mb-4 h-96">
                                                    <img src="${p.primaryImageUrl != null ? p.primaryImageUrl : 'https://via.placeholder.com/300'}"
                                                        alt="${p.productName}"
                                                        class="w-full h-full object-cover transition duration-500 group-hover:opacity-75">
                                                    <div
                                                        class="absolute inset-0 bg-black bg-opacity-0 transition duration-500 group-hover:bg-opacity-60">
                                                    </div>
                                                    <div
                                                        class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                                        <c:url var="detailUrl" value="/product/detail">
                                                            <c:param name="id" value="${p.productId}" />
                                                        </c:url>
                                                        <a href="${detailUrl}"
                                                            class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                            <spring:message code="category.quickView" />
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="text-center">
                                                    <h3 class="font-serif text-xl mb-1">${p.productName}</h3>
                                                    <p class="text-gray-500">
                                                        <fmt:formatNumber value="${p.price}" type="currency"
                                                            currencySymbol="₫" />
                                                    </p>
                                                </div>
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

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="mt-16 flex justify-center">
                                    <nav aria-label="Phân trang">
                                        <ul class="flex items-center gap-1">
                                            <c:url var="basePageUrl"
                                                value="/gender-product/${category != null ? 'products' : gender.concat('-products')}">
                                                <c:if test="${category != null}">
                                                    <c:param name="categoryId" value="${category.categoryId}" />
                                                </c:if>
                                                <c:param name="gender" value="${gender}" />
                                                <c:param name="sortBy" value="${selectedSortBy}" />
                                            </c:url>

                                            <!-- Previous Button -->
                                            <li>
                                                <c:url var="prevUrl" value="${basePageUrl}">
                                                    <c:param name="page" value="${currentPage - 1}" />
                                                </c:url>
                                                <a href="${currentPage > 1 ? prevUrl : '#'}"
                                                    class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${currentPage <= 1 ? 'text-gray-400 pointer-events-none' : 'hover:bg-gray-100'}"
                                                    aria-label="Previous" ${currentPage <=1
                                                    ? 'tabindex="-1" aria-disabled="true"' : '' }>
                                                    <i class="fa-solid fa-chevron-left text-xs"></i>
                                                </a>
                                            </li>

                                            <!-- Page Numbers (Dynamic Range) -->
                                            <c:set var="maxPagesToShow" value="5" />
                                            <c:set var="startPage"
                                                value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                                            <c:set var="endPage"
                                                value="${startPage + maxPagesToShow - 1 > totalPages ? totalPages : startPage + maxPagesToShow - 1}" />
                                            <c:if test="${endPage - startPage + 1 < maxPagesToShow}">
                                                <c:set var="startPage"
                                                    value="${endPage - maxPagesToShow + 1 > 1 ? endPage - maxPagesToShow + 1 : 1}" />
                                            </c:if>

                                            <!-- First Page -->
                                            <c:if test="${startPage > 1}">
                                                <c:url var="firstPageUrl" value="${basePageUrl}">
                                                    <c:param name="page" value="1" />
                                                </c:url>
                                                <li>
                                                    <a href="${firstPageUrl}"
                                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-100">
                                                        1
                                                    </a>
                                                </li>
                                                <c:if test="${startPage > 2}">
                                                    <li><span class="px-2">...</span></li>
                                                </c:if>
                                            </c:if>

                                            <!-- Page Range -->
                                            <c:forEach begin="${startPage}" end="${endPage}" var="pageNumber">
                                                <li>
                                                    <c:url var="pageUrl" value="${basePageUrl}">
                                                        <c:param name="page" value="${pageNumber}" />
                                                    </c:url>
                                                    <a href="${pageUrl}"
                                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${pageNumber eq currentPage ? 'bg-black text-white font-semibold pointer-events-none' : 'hover:bg-gray-100'}">
                                                        ${pageNumber}
                                                    </a>
                                                </li>
                                            </c:forEach>

                                            <!-- Last Page -->
                                            <c:if test="${endPage < totalPages}">
                                                <c:if test="${endPage < totalPages - 1}">
                                                    <li><span class="px-2">...</span></li>
                                                </c:if>
                                                <c:url var="lastPageUrl" value="${basePageUrl}">
                                                    <c:param name="page" value="${totalPages}" />
                                                </c:url>
                                                <li>
                                                    <a href="${lastPageUrl}"
                                                        class="pagination-item w-10 h-10 flex items-center justify-center rounded-full hover:bg-gray-100">
                                                        ${totalPages}
                                                    </a>
                                                </li>
                                            </c:if>

                                            <!-- Next Button -->
                                            <li>
                                                <c:url var="nextUrl" value="${basePageUrl}">
                                                    <c:param name="page" value="${currentPage + 1}" />
                                                </c:url>
                                                <a href="${currentPage < totalPages ? nextUrl : '#'}"
                                                    class="pagination-item w-10 h-10 flex items-center justify-center rounded-full ${currentPage >= totalPages ? 'text-gray-400 pointer-events-none' : 'hover:bg-gray-100'}"
                                                    aria-label="Next" ${currentPage>= totalPages ? 'tabindex="-1"
                                                    aria-disabled="true"' : ''}>
                                                    <i class="fa-solid fa-chevron-right text-xs"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
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

                            // Dropdown toggle functionality
                            document.querySelectorAll('.dropdown button').forEach(button => {
                                button.addEventListener('click', function (e) {
                                    e.stopPropagation();
                                    const menu = this.nextElementSibling;
                                    menu.classList.toggle('hidden');
                                });
                            });
                            document.addEventListener('click', function () {
                                document.querySelectorAll('.dropdown-menu').forEach(menu => {
                                    menu.classList.add('hidden');
                                });
                            });
                        });
                    </script>
                </body>

                </html>