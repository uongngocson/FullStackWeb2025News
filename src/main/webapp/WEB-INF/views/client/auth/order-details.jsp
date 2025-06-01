<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta http-equiv="X-UA-Compatible" content="IE=edge">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Chi tiết đơn hàng</title>
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
                        <link rel="preconnect" href="https://fonts.googleapis.com">
                        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
                            rel="stylesheet">
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sontest.css">
                        <link rel="icon"
                            href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg"
                            type="image/icon type">
                        <style>
                            #user-dropdown::before {
                                content: "";
                                position: absolute;
                                top: -8px;
                                right: 16px;
                                width: 0;
                                height: 0;
                                border-left: 8px solid transparent;
                                border-right: 8px solid transparent;
                                border-bottom: 8px solid black;
                                filter: drop-shadow(0 -1px 1px rgba(0, 0, 0, 0.05));
                            }
                        </style>
                    </head>


                    <body class="  min-h-screen">
                        <jsp:include page="../layout/navbar.jsp" />
                        <!-- Main Content -->
                        <section class="py-12 px-4 lg:py-16 text-white">
                            <div class="mx-auto max-w-7xl">
                                <!-- Header with gradient background -->
                                <div class="bg-gradient-to-r from-gray-900 to-black rounded-2xl p-8 mb-8 shadow-2xl border border-gray-800">
                                    <div class="flex items-center justify-between flex-wrap gap-4">
                                        <div>
                                            <h1 class="text-3xl lg:text-4xl font-bold text-white mb-2">
                                                Chi tiết đơn hàng
                                            </h1>
                                            <div class="flex items-center gap-3">
                                                <span class="text-lg text-gray-300">Mã đơn hàng:</span>
                                                <span class="text-xl font-semibold text-blue-400 bg-blue-500/10 px-4 py-2 rounded-lg border border-blue-500/20">
                                                    #<c:out value="${orderDetails[0].orderId}" />
                                                </span>
                                            </div>
                                        </div>
                                        
                                        <!-- Back button -->
                                        <a href="${pageContext.request.contextPath}/management/historyorder"
                                           class="inline-flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-white px-6 py-3 rounded-xl transition-all duration-300 border border-gray-700 hover:border-gray-600 hover:shadow-lg">
                                            <i class="uil uil-arrow-left"></i>
                                            <span class="font-medium">Quay lại lịch sử</span>
                                        </a>
                                    </div>
                                </div>

                                <!-- Debug info (hidden in production) -->
                                <div class="debug-info hidden">
                                    <p class="text-gray-400">Kích thước danh sách chi tiết đơn hàng:
                                        <c:out value="${orderDetails.size()}" />
                                    </p>
                                    <c:if test="${not empty orderDetails}">
                                        <p class="text-gray-400">ID đơn hàng đầu tiên:
                                            <c:out value="${orderDetails[0].orderId}" />
                                        </p>
                                        <p class="text-gray-400">Trạng thái đơn hàng:
                                            <c:out value="${orderDetails[0].orderStatus}" />
                                        </p>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.customer}">
                                        <p class="text-gray-400">Customer ID trong session:
                                            <c:out value="${sessionScope.customer.customerId}" />
                                        </p>
                                    </c:if>
                                    <c:if test="${empty sessionScope.customer}">
                                        <p class="text-gray-400 text-red-500">Không có thông tin khách hàng trong session!</p>
                                    </c:if>
                                    <p class="text-gray-400">Customer ID trong session (direct):
                                        <c:out value="${sessionScope.customerId}" />
                                    </p>
                                </div>

                                <!-- Error Message -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="bg-red-500/10 border border-red-500/30 rounded-xl p-6 mb-8">
                                        <div class="flex items-center gap-3 mb-3">
                                            <i class="uil uil-exclamation-triangle text-red-400 text-xl"></i>
                                            <h3 class="text-lg font-semibold text-red-400">Có lỗi xảy ra</h3>
                                        </div>
                                        <p class="text-red-300 mb-4">
                                            <c:out value="${errorMessage}" />
                                        </p>
                                        <a href="${pageContext.request.contextPath}/management/historyorder"
                                           class="inline-flex items-center gap-2 bg-red-600 hover:bg-red-500 text-white px-4 py-2 rounded-lg transition-colors">
                                            <i class="uil uil-arrow-left"></i>
                                            Quay lại lịch sử đơn hàng
                                        </a>
                                    </div>
                                </c:if>

                                <c:if test="${not empty orderDetails}">
                                    <!-- Order Information Card -->
                                    <div class="bg-gradient-to-br from-gray-900 to-gray-800 rounded-2xl p-8 mb-8 shadow-2xl border border-gray-700">
                                        <div class="flex items-center gap-3 mb-6">
                                            <div class="w-10 h-10 bg-blue-500 rounded-xl flex items-center justify-center">
                                                <i class="uil uil-file-info-alt text-white"></i>
                                            </div>
                                            <h2 class="text-2xl font-bold text-white">Thông tin đơn hàng</h2>
                                        </div>
                                        
                                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                                            <!-- Customer Info -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-user text-blue-400"></i>
                                                    <span class="font-semibold text-gray-300">Khách hàng</span>
                                                </div>
                                                <p class="text-white font-medium">
                                                    <c:out value="${orderDetails[0].firstName} ${orderDetails[0].lastName}" />
                                                </p>
                                            </div>

                                            <!-- Email -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-envelope text-green-400"></i>
                                                    <span class="font-semibold text-gray-300">Email</span>
                                                </div>
                                                <p class="text-white font-medium break-all">
                                                    <c:out value="${orderDetails[0].email}" />
                                                </p>
                                            </div>

                                            <!-- Order Date -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-calendar-alt text-purple-400"></i>
                                                    <span class="font-semibold text-gray-300">Ngày đặt hàng</span>
                                                </div>
                                                <p class="text-white font-medium">
                                                    <fmt:formatDate value="${orderDetails[0].orderDateAsDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                </p>
                                            </div>

                                            <!-- Shipping Address -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700 md:col-span-2">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-map-marker text-red-400"></i>
                                                    <span class="font-semibold text-gray-300">Địa chỉ giao hàng</span>
                                                </div>
                                                <p class="text-white font-medium">
                                                    <c:out value="${orderDetails[0].shippingAddress}" default="Không có thông tin địa chỉ" />
                                                </p>
                                            </div>

                                            <!-- Total Amount -->
                                            <div class="bg-gradient-to-r from-yellow-500/10 to-orange-500/10 rounded-xl p-5 border border-yellow-500/30">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-money-bill text-yellow-400"></i>
                                                    <span class="font-semibold text-gray-300">Tổng tiền</span>
                                                </div>
                                                <p class="text-2xl font-bold text-yellow-400">
                                                    <fmt:formatNumber value="${orderDetails[0].totalAmount}" type="number" pattern="#,##0.00" /> VNĐ
                                                </p>
                                            </div>
                                        </div>

                                        <!-- Status Cards -->
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                                            <!-- Order Status -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-package text-blue-400"></i>
                                                    <span class="font-semibold text-gray-300">Trạng thái đơn hàng</span>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${orderDetails[0].orderStatus == 'Pending'}">
                                                        <span class="inline-flex items-center gap-2 bg-yellow-500/20 text-yellow-300 px-4 py-2 rounded-lg border border-yellow-500/30 font-medium">
                                                            <div class="w-2 h-2 bg-yellow-400 rounded-full animate-pulse"></div>
                                                            <c:out value="${orderDetails[0].orderStatus}" />
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${orderDetails[0].orderStatus == 'Đang xử lý'}">
                                                        <span class="inline-flex items-center gap-2 bg-blue-500/20 text-blue-300 px-4 py-2 rounded-lg border border-blue-500/30 font-medium">
                                                            <div class="w-2 h-2 bg-blue-400 rounded-full animate-pulse"></div>
                                                            <c:out value="${orderDetails[0].orderStatus}" />
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${orderDetails[0].orderStatus == 'Đã giao'}">
                                                        <span class="inline-flex items-center gap-2 bg-green-500/20 text-green-300 px-4 py-2 rounded-lg border border-green-500/30 font-medium">
                                                            <div class="w-2 h-2 bg-green-400 rounded-full"></div>
                                                            <c:out value="${orderDetails[0].orderStatus}" />
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${orderDetails[0].orderStatus == 'Đã hủy'}">
                                                        <span class="inline-flex items-center gap-2 bg-red-500/20 text-red-300 px-4 py-2 rounded-lg border border-red-500/30 font-medium">
                                                            <div class="w-2 h-2 bg-red-400 rounded-full"></div>
                                                            <c:out value="${orderDetails[0].orderStatus}" />
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-2 bg-gray-500/20 text-gray-300 px-4 py-2 rounded-lg border border-gray-500/30 font-medium">
                                                            <div class="w-2 h-2 bg-gray-400 rounded-full"></div>
                                                            <c:out value="${orderDetails[0].orderStatus}" />
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Payment Status -->
                                            <div class="bg-black/30 rounded-xl p-5 border border-gray-700">
                                                <div class="flex items-center gap-3 mb-3">
                                                    <i class="uil uil-credit-card text-green-400"></i>
                                                    <span class="font-semibold text-gray-300">Trạng thái thanh toán</span>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${orderDetails[0].paymentStatus == 1}">
                                                        <span class="inline-flex items-center gap-2 bg-green-500/20 text-green-300 px-4 py-2 rounded-lg border border-green-500/30 font-medium">
                                                            <i class="uil uil-check-circle"></i>
                                                            Đã thanh toán
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="inline-flex items-center gap-2 bg-orange-500/20 text-orange-300 px-4 py-2 rounded-lg border border-orange-500/30 font-medium">
                                                            <i class="uil uil-clock"></i>
                                                            Chưa thanh toán
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Products Table -->
                                    <div class="bg-gradient-to-br from-gray-900 to-gray-800 rounded-2xl shadow-2xl border border-gray-700 overflow-hidden">
                                        <div class="p-8 border-b border-gray-700">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 bg-green-500 rounded-xl flex items-center justify-center">
                                                    <i class="uil uil-shopping-cart text-white"></i>
                                                </div>
                                                <h2 class="text-2xl font-bold text-white">Sản phẩm trong đơn hàng</h2>
                                            </div>
                                        </div>

                                        <!-- Desktop Table -->
                                        <div class="hidden lg:block overflow-x-auto">
                                            <table class="w-full">
                                                <thead class="bg-black/50">
                                                    <tr>
                                                        <th class="text-left py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Sản phẩm</th>
                                                        <th class="text-left py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Hình ảnh</th>
                                                        <th class="text-right py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Giá sản phẩm</th>
                                                        <th class="text-center py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Số lượng</th>
                                                        <th class="text-right py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Giá chi tiết</th>
                                                        <th class="text-right py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Tổng phụ</th>
                                                        <c:if test="${orderDetails[0].orderStatus == 'COMPLETED'}">
                                                            <th class="text-center py-4 px-6 font-semibold text-gray-300 border-b border-gray-700">Đánh giá</th>
                                                        </c:if>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="detail" items="${orderDetails}" varStatus="status">
                                                        <tr class="hover:bg-black/20 transition-colors ${status.last ? '' : 'border-b border-gray-800'}">
                                                            <td class="py-6 px-6">
                                                                <div class="font-medium text-white">
                                                                    <c:out value="${detail.productName}" default="N/A" />
                                                                </div>
                                                            </td>
                                                            <td class="py-6 px-6">
                                                                <c:choose>
                                                                    <c:when test="${not empty detail.imageUrl}">
                                                                        <div class="w-16 h-16 rounded-lg overflow-hidden bg-gray-800 border border-gray-700">
                                                                            <img src="${detail.imageUrl}" alt="Hình ảnh sản phẩm" 
                                                                                 class="w-full h-full object-cover hover:scale-110 transition-transform duration-300" />
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="w-16 h-16 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center">
                                                                            <i class="uil uil-image-slash text-gray-500"></i>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="py-6 px-6 text-right">
                                                                <span class="font-medium text-white">
                                                                    <fmt:formatNumber value="${detail.productPrice}" type="number" pattern="#,##0.00" /> VNĐ
                                                                </span>
                                                            </td>
                                                            <td class="py-6 px-6 text-center">
                                                                <span class="inline-flex items-center justify-center w-12 h-8 bg-blue-500/20 text-blue-300 rounded-lg border border-blue-500/30 font-medium">
                                                                    <c:out value="${detail.quantity}" default="N/A" />
                                                                </span>
                                                            </td>
                                                            <td class="py-6 px-6 text-right">
                                                                <span class="font-medium text-white">
                                                                    <fmt:formatNumber value="${detail.orderDetailPrice}" type="number" pattern="#,##0.00" /> VNĐ
                                                                </span>
                                                            </td>
                                                            <td class="py-6 px-6 text-right">
                                                                <span class="font-bold text-yellow-400 text-lg">
                                                                    <fmt:formatNumber value="${detail.subtotal}" type="number" pattern="#,##0.00" /> VNĐ
                                                                </span>
                                                            </td>
                                                            <c:if test="${orderDetails[0].orderStatus == 'COMPLETED'}">
                                                                <td class="py-6 px-6 text-center">
                                                                    <c:choose>
                                                                        <c:when test="${reviewedProducts.contains(detail.productId)}">
                                                                            <span class="inline-flex items-center gap-2 bg-green-500/20 text-green-300 px-4 py-2 rounded-lg border border-green-500/30 font-medium">
                                                                                <i class="uil uil-check-circle"></i>
                                                                                <a href="${pageContext.request.contextPath}/review/all" >
                                                                                    <i class="uil uil-star"></i>
                                                                                    <span>Đã đánh giá</span>
                                                                                </a>
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <button type="button" 
                                                                                    data-product-id="${detail.productId}"
                                                                                    data-product-name="${detail.productName}"
                                                                                    data-product-image="${detail.imageUrl}"
                                                                                    class="review-btn inline-flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg transition-all duration-300">
                                                                                <i class="uil uil-star"></i>
                                                                                <span>Đánh giá</span>
                                                                            </button>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </c:if>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>

                                        <!-- Mobile Cards -->
                                        <div class="lg:hidden p-6 space-y-6">
                                            <c:forEach var="detail" items="${orderDetails}">
                                                <div class="bg-black/30 rounded-xl p-6 border border-gray-700">
                                                    <div class="flex items-start gap-4 mb-4">
                                                        <c:choose>
                                                            <c:when test="${not empty detail.imageUrl}">
                                                                <div class="w-20 h-20 rounded-xl overflow-hidden bg-gray-800 border border-gray-700 flex-shrink-0">
                                                                    <img src="${detail.imageUrl}" alt="Hình ảnh sản phẩm" 
                                                                         class="w-full h-full object-cover" />
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="w-20 h-20 rounded-xl bg-gray-800 border border-gray-700 flex items-center justify-center flex-shrink-0">
                                                                    <i class="uil uil-image-slash text-gray-500 text-xl"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <div class="flex-1">
                                                            <h3 class="font-semibold text-white text-lg mb-2">
                                                                <c:out value="${detail.productName}" default="N/A" />
                                                            </h3>
                                                            <div class="flex items-center gap-2 mb-2">
                                                                <span class="text-gray-400">Số lượng:</span>
                                                                <span class="bg-blue-500/20 text-blue-300 px-3 py-1 rounded-lg border border-blue-500/30 font-medium">
                                                                    <c:out value="${detail.quantity}" default="N/A" />
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="grid grid-cols-2 gap-4 pt-4 border-t border-gray-700">
                                                        <div>
                                                            <span class="text-gray-400 text-sm">Giá sản phẩm</span>
                                                            <p class="font-medium text-white">
                                                                <fmt:formatNumber value="${detail.productPrice}" type="number" pattern="#,##0.00" /> VNĐ
                                                            </p>
                                                        </div>
                                                        <div>
                                                            <span class="text-gray-400 text-sm">Giá chi tiết</span>
                                                            <p class="font-medium text-white">
                                                                <fmt:formatNumber value="${detail.orderDetailPrice}" type="number" pattern="#,##0.00" /> VNĐ
                                                            </p>
                                                        </div>
                                                        <div class="col-span-2 pt-2 border-t border-gray-700">
                                                            <div class="flex justify-between items-center">
                                                                <span class="text-gray-400 font-medium">Tổng phụ</span>
                                                                <span class="font-bold text-yellow-400 text-xl">
                                                                    <fmt:formatNumber value="${detail.subtotal}" type="number" pattern="#,##0.00" /> VNĐ
                                                                </span>
                                                            </div>
                                                        </div>
                                                        <c:if test="${orderDetails[0].orderStatus == 'COMPLETED'}">
                                                            <div class="col-span-2 mt-4">
                                                                <c:choose>
                                                                    <c:when test="${reviewedProducts.contains(detail.productId)}">
                                                                        <span class="w-full inline-flex items-center justify-center gap-2 bg-green-500/20 text-green-300 px-4 py-3 rounded-lg border border-green-500/30 font-medium">
                                                                            <i class="uil uil-check-circle"></i>
                                                                            <span>Đã đánh giá sản phẩm</span>
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <button type="button" 
                                                                                data-product-id="${detail.productId}"
                                                                                data-product-name="${detail.productName}"
                                                                                data-product-image="${detail.imageUrl}"
                                                                                class="review-btn w-full inline-flex items-center justify-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-3 rounded-lg transition-all duration-300">
                                                                            <i class="uil uil-star"></i>
                                                                            <span>Đánh giá sản phẩm</span>
                                                                        </button>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Review Modal -->
                                    <div id="reviewModal" class="fixed inset-0 z-50 hidden overflow-y-auto">
                                        <div class="flex items-center justify-center min-h-screen p-4">
                                            <!-- Backdrop -->
                                            <div class="fixed inset-0 bg-black opacity-80 transition-opacity" id="modalBackdrop"></div>
                                            
                                            <!-- Modal content -->
                                            <div class="relative bg-gradient-to-br from-gray-900 to-gray-800 rounded-2xl max-w-lg w-full mx-auto shadow-2xl border border-gray-700 overflow-hidden z-10 transform transition-all">
                                                <!-- Modal header -->
                                                <div class="p-6 border-b border-gray-700">
                                                    <div class="flex items-center justify-between">
                                                        <div class="flex items-center gap-3">
                                                            <div class="w-10 h-10 bg-purple-600 rounded-xl flex items-center justify-center">
                                                                <i class="uil uil-star text-white"></i>
                                                            </div>
                                                            <h3 class="text-xl font-bold text-white">Đánh giá sản phẩm</h3>
                                                        </div>
                                                        <button type="button" onclick="closeReviewModal()" class="text-gray-400 hover:text-white">
                                                            <i class="uil uil-times text-2xl"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                
                                                <!-- Product info -->
                                                <div class="p-6 border-b border-gray-700 bg-black/30">
                                                    <div class="flex items-center gap-4">
                                                        <div id="reviewProductImage" class="w-20 h-20 rounded-xl overflow-hidden bg-gray-800 border border-gray-700">
                                                            <!-- Product image will be set by JS -->
                                                        </div>
                                                        <div>
                                                            <h4 id="reviewProductName" class="text-lg font-semibold text-white mb-1">
                                                                <!-- Product name will be set by JS -->
                                                            </h4>
                                                            <p class="text-gray-400">Chia sẻ đánh giá của bạn về sản phẩm này</p>
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- Review form -->
                                                <form id="reviewForm" action="${pageContext.request.contextPath}/review/submit" method="post" enctype="multipart/form-data" class="p-6">
                                                    <input type="hidden" id="productId" name="productId">
                                                    <!-- customerId sẽ được lấy từ thông tin đăng nhập trong controller -->
                                                    
                                                    <!-- Rating -->
                                                    <div class="mb-6">
                                                        <label class="block text-gray-300 mb-3">Đánh giá của bạn</label>
                                                        <div class="flex items-center gap-2">
                                                            <div class="rating-stars flex gap-2">
                                                                <button type="button" class="star-btn w-12 h-12 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center hover:bg-gray-700 transition-colors" data-rating="1">
                                                                    <i class="uil uil-star text-gray-400 text-2xl"></i>
                                                                </button>
                                                                <button type="button" class="star-btn w-12 h-12 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center hover:bg-gray-700 transition-colors" data-rating="2">
                                                                    <i class="uil uil-star text-gray-400 text-2xl"></i>
                                                                </button>
                                                                <button type="button" class="star-btn w-12 h-12 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center hover:bg-gray-700 transition-colors" data-rating="3">
                                                                    <i class="uil uil-star text-gray-400 text-2xl"></i>
                                                                </button>
                                                                <button type="button" class="star-btn w-12 h-12 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center hover:bg-gray-700 transition-colors" data-rating="4">
                                                                    <i class="uil uil-star text-gray-400 text-2xl"></i>
                                                                </button>
                                                                <button type="button" class="star-btn w-12 h-12 rounded-lg bg-gray-800 border border-gray-700 flex items-center justify-center hover:bg-gray-700 transition-colors" data-rating="5">
                                                                    <i class="uil uil-star text-gray-400 text-2xl"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" id="rating" name="rating" value="0">
                                                    </div>
                                                    
                                                    <!-- Comment -->
                                                    <div class="mb-6">
                                                        <label for="comment" class="block text-gray-300 mb-2">Nhận xét của bạn</label>
                                                        <div class="relative">
                                                            <textarea id="comment" name="comment" rows="4" 
                                                                    class="w-full bg-gray-800 border border-gray-700 rounded-xl p-4 text-white focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-none"
                                                                    placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..." 
                                                                    maxlength="250"
                                                                    onkeyup="countCharacters(this)"></textarea>
                                                            <div class="flex justify-end mt-2">
                                                                <span id="charCount" class="text-sm text-gray-400">0/250 ký tự</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Image upload -->
                                                    <div class="mb-6">
                                                        <label class="block text-gray-300 mb-2">Thêm hình ảnh (tùy chọn)</label>
                                                        <div class="relative">
                                                            <input type="file" id="reviewImage" name="reviewImage" accept="image/*" class="hidden" onchange="previewImage(event)">
                                                            <div id="imagePreviewContainer" class="hidden mb-3">
                                                                <div class="relative w-full h-40 bg-gray-800 rounded-xl overflow-hidden">
                                                                    <img id="imagePreview" class="w-full h-full object-contain" alt="Preview">
                                                                    <button type="button" onclick="removeImage()" class="absolute top-2 right-2 w-8 h-8 bg-red-500 rounded-full flex items-center justify-center text-white hover:bg-red-600 transition-colors">
                                                                        <i class="uil uil-times"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                            <button type="button" onclick="document.getElementById('reviewImage').click()" 
                                                                    class="w-full flex items-center justify-center gap-2 bg-gray-800 border border-gray-700 hover:bg-gray-700 text-gray-300 p-4 rounded-xl transition-colors">
                                                                <i class="uil uil-image-upload"></i>
                                                                <span>Tải lên hình ảnh</span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    
                                                    <!-- Submit button -->
                                                    <div class="flex justify-end gap-3 mt-8">
                                                        <button type="button" onclick="closeReviewModal()" 
                                                                class="px-6 py-3 bg-gray-800 hover:bg-gray-700 text-white rounded-xl transition-colors">
                                                            Hủy bỏ
                                                        </button>
                                                        <button type="submit" id="submitReview" disabled
                                                                class="px-6 py-3 bg-purple-600 text-white rounded-xl transition-colors opacity-50 cursor-not-allowed">
                                                            Gửi đánh giá
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Bottom Actions -->
                                    <div class="mt-8 flex justify-center">
                                        <a href="${pageContext.request.contextPath}/management/historyorder"
                                           class="inline-flex items-center gap-3 bg-gradient-to-r from-blue-600 to-blue-500 hover:from-blue-700 hover:to-blue-600 text-white px-8 py-4 rounded-xl transition-all duration-300 shadow-lg hover:shadow-xl hover:scale-105 font-medium">
                                            <i class="uil uil-arrow-left"></i>
                                            <span>Quay lại lịch sử đơn hàng</span>
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </section>
                        
                        <jsp:include page="../layout/footer.jsp" />
                        
                        <!-- Review functionality scripts -->
                        <script>
                            // Current selected rating
                            let currentRating = 0;
                            
                            // Character counter function
                            function countCharacters(textarea) {
                                const maxLength = 250;
                                const currentLength = textarea.value.length;
                                const charCountElement = document.getElementById('charCount');
                                
                                // Update character count
                                charCountElement.textContent = currentLength + '/' + maxLength + ' ký tự';
                                
                                // Change color when approaching limit
                                if (currentLength >= maxLength) {
                                    charCountElement.classList.remove('text-gray-400', 'text-yellow-400');
                                    charCountElement.classList.add('text-red-400');
                                } else if (currentLength >= maxLength * 0.8) {
                                    charCountElement.classList.remove('text-gray-400', 'text-red-400');
                                    charCountElement.classList.add('text-yellow-400');
                                } else {
                                    charCountElement.classList.remove('text-yellow-400', 'text-red-400');
                                    charCountElement.classList.add('text-gray-400');
                                }
                                
                                // Prevent typing more characters
                                if (currentLength > maxLength) {
                                    textarea.value = textarea.value.substring(0, maxLength);
                                }
                            }
                            
                            // Open review modal
                            function openReviewModal(productId, productName, imageUrl) {
                                // Set product information
                                document.getElementById('productId').value = productId;
                                document.getElementById('reviewProductName').textContent = productName;
                                
                                // Set product image
                                const productImageContainer = document.getElementById('reviewProductImage');
                                if (imageUrl && imageUrl !== '') {
                                    productImageContainer.innerHTML = '<img src="' + imageUrl + '" alt="Product Image" class="w-full h-full object-cover">';
                                } else {
                                    productImageContainer.innerHTML = '<div class="w-full h-full flex items-center justify-center"><i class="uil uil-image-slash text-gray-500 text-xl"></i></div>';
                                }
                                
                                // Show modal
                                document.getElementById('reviewModal').classList.remove('hidden');
                                document.body.classList.add('overflow-hidden');
                            }
                            
                            // Close review modal
                            function closeReviewModal() {
                                document.getElementById('reviewModal').classList.add('hidden');
                                document.body.classList.remove('overflow-hidden');
                                
                                // Reset form
                                resetReviewForm();
                            }
                            
                            // Reset review form
                            function resetReviewForm() {
                                document.getElementById('reviewForm').reset();
                                document.getElementById('rating').value = 0;
                                currentRating = 0;
                                
                                // Reset stars
                                const stars = document.querySelectorAll('.star-btn i');
                                stars.forEach(function(star) {
                                    star.classList.remove('text-yellow-400');
                                    star.classList.add('text-gray-400');
                                });
                                
                                // Reset submit button
                                const submitButton = document.getElementById('submitReview');
                                submitButton.disabled = true;
                                submitButton.classList.add('opacity-50', 'cursor-not-allowed');
                                
                                // Reset image preview
                                removeImage();
                            }
                            
                            // Preview uploaded image
                            function previewImage(event) {
                                const file = event.target.files[0];
                                if (file) {
                                    const reader = new FileReader();
                                    reader.onload = function(e) {
                                        document.getElementById('imagePreview').src = e.target.result;
                                        document.getElementById('imagePreviewContainer').classList.remove('hidden');
                                    }
                                    reader.readAsDataURL(file);
                                }
                            }
                            
                            // Remove uploaded image
                            function removeImage() {
                                document.getElementById('reviewImage').value = '';
                                document.getElementById('imagePreviewContainer').classList.add('hidden');
                            }
                            
                            // Initialize star rating functionality
                            document.addEventListener('DOMContentLoaded', function() {
                                // Setup review buttons
                                const reviewButtons = document.querySelectorAll('.review-btn');
                                reviewButtons.forEach(function(button) {
                                    button.addEventListener('click', function() {
                                        const productId = this.getAttribute('data-product-id');
                                        const productName = this.getAttribute('data-product-name');
                                        const imageUrl = this.getAttribute('data-product-image');
                                        openReviewModal(productId, productName, imageUrl);
                                    });
                                });
                                
                                const starButtons = document.querySelectorAll('.star-btn');
                                const ratingInput = document.getElementById('rating');
                                const submitButton = document.getElementById('submitReview');
                                
                                // Add click event to each star button
                                starButtons.forEach(function(button) {
                                    button.addEventListener('click', function() {
                                        const rating = parseInt(this.getAttribute('data-rating'));
                                        currentRating = rating;
                                        ratingInput.value = rating;
                                        
                                        // Update stars visual
                                        starButtons.forEach(function(btn) {
                                            const btnRating = parseInt(btn.getAttribute('data-rating'));
                                            const starIcon = btn.querySelector('i');
                                            
                                            if (btnRating <= rating) {
                                                starIcon.classList.remove('text-gray-400');
                                                starIcon.classList.add('text-yellow-400');
                                            } else {
                                                starIcon.classList.remove('text-yellow-400');
                                                starIcon.classList.add('text-gray-400');
                                            }
                                        });
                                        
                                        // Enable submit button if rating is selected
                                        if (rating > 0) {
                                            submitButton.disabled = false;
                                            submitButton.classList.remove('opacity-50', 'cursor-not-allowed');
                                        } else {
                                            submitButton.disabled = true;
                                            submitButton.classList.add('opacity-50', 'cursor-not-allowed');
                                        }
                                    });
                                });
                                
                                // Close modal when clicking on backdrop
                                document.getElementById('modalBackdrop').addEventListener('click', function() {
                                    closeReviewModal();
                                });
                                
                                // Prevent form submission if rating is not selected
                                document.getElementById('reviewForm').addEventListener('submit', function(event) {
                                    if (currentRating === 0) {
                                        event.preventDefault();
                                        alert('Vui lòng chọn số sao đánh giá.');
                                        return;
                                    }
                                });
                            });
                        </script>
                    </body>

                    </html>