<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | Hồ Sơ Của Bạn</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
                <style>
                    * {
                        font-family: 'Inter', sans-serif;
                    }
                    
                    .gradient-bg {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    }
                    
                    .glass-effect {
                        backdrop-filter: blur(20px);
                        background: rgba(255, 255, 255, 0.1);
                        border: 1px solid rgba(255, 255, 255, 0.2);
                    }
                    
                    .profile-card {
                        background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
                        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                    }
                    
                    .avatar-glow {
                        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1), 0 0 0 8px rgba(99, 102, 241, 0.05);
                    }
                    
                    .btn-gradient {
                        background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
                        transition: all 0.3s ease;
                    }
                    
                    .btn-gradient:hover {
                        background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
                        transform: translateY(-1px);
                        box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.4);
                    }
                    
                    .info-item {
                        transition: all 0.3s ease;
                        border-left: 3px solid transparent;
                        padding-left: 1rem;
                    }
                    
                    .info-item:hover {
                        border-left-color: #6366f1;
                        background: linear-gradient(90deg, rgba(99, 102, 241, 0.03) 0%, transparent 100%);
                        transform: translateX(4px);
                    }
                    
                    .alert-success {
                        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                        border: none;
                        color: white;
                        box-shadow: 0 4px 14px 0 rgba(16, 185, 129, 0.3);
                    }
                    
                    .alert-error {
                        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                        border: none;
                        color: white;
                        box-shadow: 0 4px 14px 0 rgba(239, 68, 68, 0.3);
                    }
                    
                    .floating-element {
                        animation: float 6s ease-in-out infinite;
                    }
                    
                    @keyframes float {
                        0%, 100% {
                            transform: translateY(0px);
                        }
                        50% {
                            transform: translateY(-10px);
                        }
                    }
                    
                    .section-header {
                        position: relative;
                        overflow: hidden;
                    }
                    
                    .section-header::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: -100%;
                        width: 100%;
                        height: 100%;
                        background: linear-gradient(90deg, transparent, rgba(99, 102, 241, 0.1), transparent);
                        transition: left 0.5s;
                    }
                    
                    .section-header:hover::before {
                        left: 100%;
                    }
                </style>
            </head>

            <body class="bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 min-h-screen">
                <!-- Navbar -->
                <jsp:include page="../layout/navbar.jsp" />

                <!-- Background Elements -->
                <div class="fixed inset-0 overflow-hidden pointer-events-none">
                    <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-purple-400 to-blue-400 rounded-full opacity-10 floating-element"></div>
                    <div class="absolute -bottom-40 -left-40 w-96 h-96 bg-gradient-to-tr from-pink-400 to-purple-400 rounded-full opacity-10 floating-element" style="animation-delay: -3s;"></div>
                </div>

                <div class="relative z-10 container mx-auto px-4 py-12 max-w-7xl">
                    <!-- Flash Messages -->
                    <div class="space-y-4 mb-8">
                        <c:if test="${not empty success}">
                            <div class="alert-success p-6 rounded-2xl transform transition-all duration-500 hover:scale-[1.02]">
                                <div class="flex items-center">
                                    <i class="fas fa-check-circle text-2xl mr-4"></i>
                                    <div>
                                        <h4 class="font-semibold text-lg">Thành công!</h4>
                                        <p class="opacity-90">${success}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert-error p-6 rounded-2xl transform transition-all duration-500 hover:scale-[1.02]">
                                <div class="flex items-center">
                                    <i class="fas fa-exclamation-circle text-2xl mr-4"></i>
                                    <div>
                                        <h4 class="font-semibold text-lg">Có lỗi xảy ra!</h4>
                                        <p class="opacity-90">${error}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty passwordSuccess}">
                            <div class="alert-success p-6 rounded-2xl transform transition-all duration-500 hover:scale-[1.02]">
                                <div class="flex items-center">
                                    <i class="fas fa-lock text-2xl mr-4"></i>
                                    <div>
                                        <h4 class="font-semibold text-lg">Mật khẩu đã được cập nhật!</h4>
                                        <p class="opacity-90">${passwordSuccess}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty passwordError}">
                            <div class="alert-error p-6 rounded-2xl transform transition-all duration-500 hover:scale-[1.02]">
                                <div class="flex items-center">
                                    <i class="fas fa-exclamation-triangle text-2xl mr-4"></i>
                                    <div>
                                        <h4 class="font-semibold text-lg">Lỗi mật khẩu!</h4>
                                        <p class="opacity-90">${passwordError}</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Profile Section -->
                    <c:choose>
                        <c:when test="${not empty customer}">
                            <section class="pt-16">
                                <!-- Header Section -->
                                <div class="flex flex-col lg:flex-row justify-between items-start lg:items-center mb-12 section-header">
                                    <div class="mb-6 lg:mb-0">
                                        <h1 class="text-4xl lg:text-5xl font-bold bg-gradient-to-r from-slate-900 via-purple-900 to-slate-900 bg-clip-text text-transparent mb-2">
                                            Hồ Sơ Của Bạn
                                        </h1>
                                        <p class="text-slate-600 text-lg">Quản lý thông tin cá nhân của bạn</p>
                                    </div>
                                    <div class="flex flex-col sm:flex-row gap-4">
                                        <a href="${ctx}/management/profile/update"
                                            class="btn-gradient text-white px-8 py-4 rounded-2xl font-semibold text-sm flex items-center justify-center group">
                                            <i class="fas fa-edit mr-3 group-hover:rotate-12 transition-transform duration-300"></i>
                                            Chỉnh Sửa Thông Tin
                                        </a>
                                        <a href="${ctx}/management/profile/change-password"
                                            class="bg-white text-slate-700 px-8 py-4 rounded-2xl font-semibold text-sm border-2 border-slate-200 hover:border-indigo-300 hover:bg-indigo-50 transition-all duration-300 flex items-center justify-center group">
                                            <i class="fas fa-key mr-3 group-hover:rotate-12 transition-transform duration-300"></i>
                                            Thay Đổi Mật Khẩu
                                        </a>
                                    </div>
                                </div>

                                <!-- Date of Birth Validation Error -->
                                <c:if test="${empty customer.dateOfBirth}">
                                    <div class="alert-error p-6 rounded-2xl mb-8 transform transition-all duration-500 hover:scale-[1.02]">
                                        <div class="flex items-center">
                                            <i class="fas fa-calendar-times text-2xl mr-4"></i>
                                            <div>
                                                <h4 class="font-semibold text-lg">Thông tin chưa đầy đủ</h4>
                                                <p class="opacity-90">Ngày sinh không được để trống. Vui lòng cập nhật thông tin hồ sơ.</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Main Profile Card -->
                                <div class="profile-card rounded-3xl overflow-hidden">
                                    <!-- Avatar Section -->
                                    <div class="bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 p-12 text-center relative">
                                        <div class="absolute inset-0 bg-black opacity-10"></div>
                                        <div class="relative z-10">
                                            <div class="inline-block relative">
                                                <c:choose>
                                                    <c:when test="${not empty customer.imageUrl}">
                                                        <c:choose>
                                                            <c:when test="${customer.imageUrl.startsWith('http')}">
                                                                <img src="${customer.imageUrl}" alt="Ảnh đại diện" 
                                                                     class="w-40 h-40 rounded-full object-cover border-6 border-white avatar-glow mx-auto">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${customer.imageUrl}" alt="Ảnh đại diện" 
                                                                     class="w-40 h-40 rounded-full object-cover border-6 border-white avatar-glow mx-auto">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${ctx}/resources/assets/client/images/default-avatar.jpg"
                                                             alt="Ảnh đại diện mặc định" 
                                                             class="w-40 h-40 rounded-full object-cover border-6 border-white avatar-glow mx-auto">
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="absolute -bottom-2 -right-2 w-12 h-12 bg-green-500 rounded-full border-4 border-white flex items-center justify-center">
                                                    <i class="fas fa-check text-white text-sm"></i>
                                                </div>
                                            </div>
                                            <h2 class="text-3xl font-bold text-white mt-6 mb-2">
                                                <c:out value="${not empty customer.firstName ? customer.firstName : 'N/A'}" />
                                                <c:out value="${not empty customer.lastName ? customer.lastName : 'N/A'}" />
                                            </h2>
                                            <p class="text-white opacity-90 text-lg">Thành viên DDTS</p>
                                        </div>
                                    </div>

                                    <!-- Information Grid -->
                                    <div class="p-12">
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
                                            <!-- Personal Information Column -->
                                            <div>
                                                <div class="flex items-center mb-8">
                                                    <div class="w-12 h-12 bg-gradient-to-r from-blue-500 to-purple-500 rounded-xl flex items-center justify-center mr-4">
                                                        <i class="fas fa-user text-white text-lg"></i>
                                                    </div>
                                                    <h3 class="text-2xl font-bold text-slate-800">Thông Tin Cá Nhân</h3>
                                                </div>
                                                
                                                <div class="space-y-6">
                                                    <div class="info-item p-6 rounded-2xl bg-white border border-slate-100 hover:shadow-lg">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center mr-4">
                                                                <i class="fas fa-user text-blue-600"></i>
                                                            </div>
                                                            <div class="flex-1">
                                                                <p class="text-slate-500 text-sm font-medium mb-1">Họ và Tên</p>
                                                                <p class="text-slate-800 font-semibold text-lg">
                                                                    <c:out value="${not empty customer.firstName ? customer.firstName : 'N/A'}" />
                                                                    <c:out value="${not empty customer.lastName ? customer.lastName : 'N/A'}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="info-item p-6 rounded-2xl bg-white border border-slate-100 hover:shadow-lg">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-green-100 rounded-xl flex items-center justify-center mr-4">
                                                                <i class="fas fa-envelope text-green-600"></i>
                                                            </div>
                                                            <div class="flex-1">
                                                                <p class="text-slate-500 text-sm font-medium mb-1">Email</p>
                                                                <p class="text-slate-800 font-semibold text-lg">
                                                                    <c:out value="${not empty customer.email ? customer.email : 'N/A'}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="info-item p-6 rounded-2xl bg-white border border-slate-100 hover:shadow-lg">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-purple-100 rounded-xl flex items-center justify-center mr-4">
                                                                <i class="fas fa-phone text-purple-600"></i>
                                                            </div>
                                                            <div class="flex-1">
                                                                <p class="text-slate-500 text-sm font-medium mb-1">Số Điện Thoại</p>
                                                                <p class="text-slate-800 font-semibold text-lg">
                                                                    <c:out value="${not empty customer.phone ? customer.phone : 'N/A'}" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Additional Information Column -->
                                            <div>
                                                <div class="flex items-center mb-8">
                                                    <div class="w-12 h-12 bg-gradient-to-r from-pink-500 to-orange-500 rounded-xl flex items-center justify-center mr-4">
                                                        <i class="fas fa-info-circle text-white text-lg"></i>
                                                    </div>
                                                    <h3 class="text-2xl font-bold text-slate-800">Thông Tin Bổ Sung</h3>
                                                </div>
                                                
                                                <div class="space-y-6">
                                                    <div class="info-item p-6 rounded-2xl bg-white border border-slate-100 hover:shadow-lg">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-orange-100 rounded-xl flex items-center justify-center mr-4">
                                                                <i class="fas fa-birthday-cake text-orange-600"></i>
                                                            </div>
                                                            <div class="flex-1">
                                                                <p class="text-slate-500 text-sm font-medium mb-1">Ngày Sinh</p>
                                                                <p class="text-slate-800 font-semibold text-lg">
                                                                    <c:choose>
                                                                        <c:when test="${not empty customer.dateOfBirth}">
                                                                            <fmt:parseDate value="${customer.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                                                        </c:when>
                                                                        <c:otherwise>N/A</c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="info-item p-6 rounded-2xl bg-white border border-slate-100 hover:shadow-lg">
                                                        <div class="flex items-center">
                                                            <div class="w-10 h-10 bg-pink-100 rounded-xl flex items-center justify-center mr-4">
                                                                <i class="fas fa-venus-mars text-pink-600"></i>
                                                            </div>
                                                            <div class="flex-1">
                                                                <p class="text-slate-500 text-sm font-medium mb-1">Giới Tính</p>
                                                                <p class="text-slate-800 font-semibold text-lg">
                                                                    <c:choose>
                                                                        <c:when test="${customer.gender}">Nam</c:when>
                                                                        <c:otherwise>Nữ</c:otherwise>
                                                                    </c:choose>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Stats Card -->
                                                    <div class="p-6 rounded-2xl bg-gradient-to-r from-indigo-500 to-purple-500 text-white">
                                                        <div class="flex items-center justify-between">
                                                            <div>
                                                                <p class="text-white opacity-90 text-sm font-medium mb-1">Trạng thái tài khoản</p>
                                                                <p class="text-white font-bold text-xl">Đã xác thực</p>
                                                            </div>
                                                            <div class="w-12 h-12 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
                                                                <i class="fas fa-shield-alt text-white text-lg"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </c:when>
                        <c:otherwise>
                            <div class="alert-error p-8 rounded-3xl text-center transform transition-all duration-500 hover:scale-[1.02]">
                                <div class="flex flex-col items-center">
                                    <i class="fas fa-user-times text-4xl mb-4"></i>
                                    <h3 class="font-bold text-xl mb-2">Không thể tải hồ sơ</h3>
                                    <p class="opacity-90">Không thể tải thông tin hồ sơ. Vui lòng đăng nhập.</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <jsp:include page="../layout/footer.jsp" />
            </body>
            

            </html>