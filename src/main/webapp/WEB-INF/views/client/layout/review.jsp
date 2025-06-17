<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<section class="bg-white py-8 antialiased dark:bg-gray-900 md:py-16">
    <div class="mx-auto max-w-screen-xl px-6 2xl:px-4">
        <div class="flex items-center gap-2">
            <h2 class="text-2xl font-semibold text-gray-900 dark:text-white">Đánh giá sản phẩm</h2>

            <div class="mt-2 flex items-center gap-2 sm:mt-0">
                <div class="flex items-center gap-0.5">
                    <c:forEach begin="1" end="5" var="star">
                        <c:choose>
                            <c:when test="${star <= averageRating}">
                                <svg class="h-4 w-4 text-yellow-300" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                    fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                </svg>
                            </c:when>
                            <c:otherwise>
                                <svg class="h-4 w-4 text-gray-300" aria-hidden="true"
                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                    fill="currentColor" viewBox="0 0 24 24">
                                    <path
                                        d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                </svg>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <p class="text-sm font-medium leading-none text-gray-500 dark:text-gray-400">(${averageRating})</p>
                <p class="text-sm font-medium leading-none text-gray-900 underline hover:no-underline dark:text-white">
                    ${reviewCount} Đánh giá
                </p>
            </div>
        </div>

        <div class="my-6 gap-8 sm:flex sm:items-start md:my-8">
            <div class="shrink-0 space-y-4">
                <p class="text-2xl font-semibold leading-none text-gray-900 dark:text-white">${averageRating} / 5</p>
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/review/all'"
                    class="mb-2 me-2 rounded-lg bg-primary-700 px-5 py-2.5 text-sm font-medium text-white hover:bg-primary-800 focus:outline-none focus:ring-4 focus:ring-primary-300 dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">
                    Xem tất cả đánh giá của bạn
                </button>
            </div>

            <div class="mt-6 min-w-0 flex-1 space-y-3 sm:mt-0">
                <!-- Đánh giá 5 sao -->
                <div class="flex items-center gap-2">
                    <p class="w-2 shrink-0 text-start text-sm font-medium leading-none text-gray-900 dark:text-white">5</p>
                    <svg class="h-4 w-4 shrink-0 text-yellow-300" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        fill="currentColor" viewBox="0 0 24 24">
                        <path
                            d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                    </svg>
                    <div class="h-1.5 w-80 rounded-full bg-gray-200 dark:bg-gray-700">
                        <c:set var="percent5" value="${reviewCount > 0 ? (ratingCounts[5] * 100 / reviewCount) : 0}" />
                        <div class="h-1.5 rounded-full bg-yellow-300" style="width: ${percent5}%"></div>
                    </div>
                    <a href="#" class="w-8 shrink-0 text-right text-sm font-medium leading-none text-primary-700 hover:underline dark:text-primary-500 sm:w-auto sm:text-left">
                        ${ratingCounts[5]} <span class="hidden sm:inline">đánh giá</span>
                    </a>
                </div>

                <!-- Đánh giá 4 sao -->
                <div class="flex items-center gap-2">
                    <p class="w-2 shrink-0 text-start text-sm font-medium leading-none text-gray-900 dark:text-white">4</p>
                    <svg class="h-4 w-4 shrink-0 text-yellow-300" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        fill="currentColor" viewBox="0 0 24 24">
                        <path
                            d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                    </svg>
                    <div class="h-1.5 w-80 rounded-full bg-gray-200 dark:bg-gray-700">
                        <c:set var="percent4" value="${reviewCount > 0 ? (ratingCounts[4] * 100 / reviewCount) : 0}" />
                        <div class="h-1.5 rounded-full bg-yellow-300" style="width: ${percent4}%"></div>
                    </div>
                    <a href="#" class="w-8 shrink-0 text-right text-sm font-medium leading-none text-primary-700 hover:underline dark:text-primary-500 sm:w-auto sm:text-left">
                        ${ratingCounts[4]} <span class="hidden sm:inline">đánh giá</span>
                    </a>
                </div>

                <!-- Đánh giá 3 sao -->
                <div class="flex items-center gap-2">
                    <p class="w-2 shrink-0 text-start text-sm font-medium leading-none text-gray-900 dark:text-white">3</p>
                    <svg class="h-4 w-4 shrink-0 text-yellow-300" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        fill="currentColor" viewBox="0 0 24 24">
                        <path
                            d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                    </svg>
                    <div class="h-1.5 w-80 rounded-full bg-gray-200 dark:bg-gray-700">
                        <c:set var="percent3" value="${reviewCount > 0 ? (ratingCounts[3] * 100 / reviewCount) : 0}" />
                        <div class="h-1.5 rounded-full bg-yellow-300" style="width: ${percent3}%"></div>
                    </div>
                    <a href="#" class="w-8 shrink-0 text-right text-sm font-medium leading-none text-primary-700 hover:underline dark:text-primary-500 sm:w-auto sm:text-left">
                        ${ratingCounts[3]} <span class="hidden sm:inline">đánh giá</span>
                    </a>
                </div>

                <!-- Đánh giá 2 sao -->
                <div class="flex items-center gap-2">
                    <p class="w-2 shrink-0 text-start text-sm font-medium leading-none text-gray-900 dark:text-white">2</p>
                    <svg class="h-4 w-4 shrink-0 text-yellow-300" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        fill="currentColor" viewBox="0 0 24 24">
                        <path
                            d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                    </svg>
                    <div class="h-1.5 w-80 rounded-full bg-gray-200 dark:bg-gray-700">
                        <c:set var="percent2" value="${reviewCount > 0 ? (ratingCounts[2] * 100 / reviewCount) : 0}" />
                        <div class="h-1.5 rounded-full bg-yellow-300" style="width: ${percent2}%"></div>
                    </div>
                    <a href="#" class="w-8 shrink-0 text-right text-sm font-medium leading-none text-primary-700 hover:underline dark:text-primary-500 sm:w-auto sm:text-left">
                        ${ratingCounts[2]} <span class="hidden sm:inline">đánh giá</span>
                    </a>
                </div>

                <!-- Đánh giá 1 sao -->
                <div class="flex items-center gap-2">
                    <p class="w-2 shrink-0 text-start text-sm font-medium leading-none text-gray-900 dark:text-white">1</p>
                    <svg class="h-4 w-4 shrink-0 text-yellow-300" aria-hidden="true"
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        fill="currentColor" viewBox="0 0 24 24">
                        <path
                            d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                    </svg>
                    <div class="h-1.5 w-80 rounded-full bg-gray-200 dark:bg-gray-700">
                        <c:set var="percent1" value="${reviewCount > 0 ? (ratingCounts[1] * 100 / reviewCount) : 0}" />
                        <div class="h-1.5 rounded-full bg-yellow-300" style="width: ${percent1}%"></div>
                    </div>
                    <a href="#" class="w-8 shrink-0 text-right text-sm font-medium leading-none text-primary-700 hover:underline dark:text-primary-500 sm:w-auto sm:text-left">
                        ${ratingCounts[1]} <span class="hidden sm:inline">đánh giá</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="mt-6 divide-y divide-gray-200 dark:divide-gray-700">
            <c:choose>
                <c:when test="${empty reviews}">
                    <div class="text-center py-10">
                        <div class="w-20 h-20 bg-gray-800 rounded-full mx-auto mb-4 flex items-center justify-center">
                            <i class="uil uil-star text-gray-600 text-4xl"></i>
                        </div>
                        <h2 class="text-xl font-semibold text-gray-300 mb-2">Chưa có đánh giá nào</h2>
                        <p class="text-gray-400 mb-6">Sản phẩm này chưa có đánh giá nào. Hãy mua sản phẩm và đánh giá để chia sẻ trải nghiệm của bạn.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Danh sách đánh giá -->
                    <c:forEach items="${reviews}" var="review">
                        <div class="gap-3 py-6 sm:flex sm:items-start">
                            <div class="shrink-0 space-y-2 sm:w-48 md:w-72">
                                <div class="flex items-center gap-0.5">
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:choose>
                                            <c:when test="${star <= review.rating}">
                                                <svg class="h-4 w-4 text-yellow-300" aria-hidden="true"
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    fill="currentColor" viewBox="0 0 24 24">
                                                    <path
                                                        d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                                </svg>
                                            </c:when>
                                            <c:otherwise>
                                                <svg class="h-4 w-4 text-gray-300" aria-hidden="true"
                                                    xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                    fill="currentColor" viewBox="0 0 24 24">
                                                    <path
                                                        d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                                </svg>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>

                                <div class="space-y-0.5">
                                    <p class="text-base font-semibold text-gray-900 dark:text-white">
                                        <c:out value="${review.customer.firstName} ${review.customer.lastName}" />
                                    </p>
                                    <p class="text-sm font-normal text-gray-500 dark:text-gray-400">
                                        <fmt:parseDate value="${review.reviewDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </p>
                                </div>

                                <div class="inline-flex items-center gap-1">
                                    <svg class="h-5 w-5 text-primary-700 dark:text-primary-500"
                                        aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24"
                                        height="24" fill="currentColor" viewBox="0 0 24 24">
                                        <path fill-rule="evenodd"
                                            d="M12 2c-.791 0-1.55.314-2.11.874l-.893.893a.985.985 0 0 1-.696.288H7.04A2.984 2.984 0 0 0 4.055 7.04v1.262a.986.986 0 0 1-.288.696l-.893.893a2.984 2.984 0 0 0 0 4.22l.893.893a.985.985 0 0 1 .288.696v1.262a2.984 2.984 0 0 0 2.984 2.984h1.262c.261 0 .512.104.696.288l.893.893a2.984 2.984 0 0 0 4.22 0l.893-.893a.985.985 0 0 1 .696-.288h1.262a2.984 2.984 0 0 0 2.984-2.984V15.7c0-.261.104-.512.288-.696l.893-.893a2.984 2.984 0 0 0 0-4.22l-.893-.893a.985.985 0 0 1-.288-.696V7.04a2.984 2.984 0 0 0-2.984-2.984h-1.262a.985.985 0 0 1-.696-.288l-.893-.893A2.984 2.984 0 0 0 12 2Zm3.683 7.73a1 1 0 1 0-1.414-1.413l-4.253 4.253-1.277-1.277a1 1 0 0 0-1.415 1.414l1.985 1.984a1 1 0 0 0 1.414 0l4.96-4.96Z"
                                            clip-rule="evenodd" />
                                    </svg>
                                    <p class="text-sm font-medium text-gray-900 dark:text-white">Khách hàng đã mua</p>
                                </div>
                            </div>

                            <div class="mt-4 min-w-0 flex-1 space-y-4 sm:mt-0">
                                <p class="text-base font-normal text-gray-500 dark:text-gray-400">
                                    <c:out value="${review.comment}" default="Không có nhận xét" />
                                </p>

                                <c:if test="${not empty review.imageUrl}">
                                    <div class="flex gap-2">
                                        <img class="h-32 w-auto rounded-lg object-cover"
                                            src="${review.imageUrl}"
                                            alt="Hình ảnh đánh giá" />
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${reviewCount > 5}">
            <div class="mt-6 text-center">
                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/review/all'"
                    class="mb-2 me-2 rounded-lg border border-gray-200 bg-white px-5 py-2.5 text-sm font-medium text-gray-900 hover:bg-gray-100 hover:text-primary-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-gray-100 dark:border-gray-600 dark:bg-gray-800 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white dark:focus:ring-gray-700">
                    Xem thêm đánh giá
                </button>
            </div>
        </c:if>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Xử lý khi trang đã load xong
        console.log("Review section loaded");
    });
</script>