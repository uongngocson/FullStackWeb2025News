<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Cập Nhật Hồ Sơ</title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                        
                        .form-card {
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
                            transform: translateY(-2px);
                            box-shadow: 0 15px 35px -5px rgba(99, 102, 241, 0.4);
                        }
                        
                        .form-input {
                            transition: all 0.3s ease;
                            border: 2px solid #e2e8f0;
                            background: rgba(255, 255, 255, 0.8);
                        }
                        
                        .form-input:focus {
                            border-color: #6366f1;
                            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
                            background: white;
                            transform: translateY(-1px);
                        }
                        
                        .form-input:hover {
                            border-color: #c7d2fe;
                            background: white;
                        }
                        
                        .form-group {
                            position: relative;
                            margin-bottom: 1.5rem;
                        }
                        
                        .form-label {
                            position: absolute;
                            left: 1rem;
                            top: -0.5rem;
                            background: white;
                            padding: 0 0.5rem;
                            font-size: 0.875rem;
                            font-weight: 500;
                            color: #6366f1;
                            z-index: 10;
                        }
                        
                        .form-icon {
                            position: absolute;
                            right: 1rem;
                            top: 50%;
                            transform: translateY(-50%);
                            color: #94a3b8;
                            transition: color 0.3s ease;
                        }
                        
                        .form-group:hover .form-icon {
                            color: #6366f1;
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
                        
                        .upload-zone {
                            border: 2px dashed #cbd5e1;
                            background: linear-gradient(145deg, #f8fafc 0%, #f1f5f9 100%);
                            transition: all 0.3s ease;
                        }
                        
                        .upload-zone:hover {
                            border-color: #6366f1;
                            background: linear-gradient(145deg, #eef2ff 0%, #e0e7ff 100%);
                        }
                        
                        .upload-zone.dragover {
                            border-color: #8b5cf6;
                            background: linear-gradient(145deg, #faf5ff 0%, #f3e8ff 100%);
                            transform: scale(1.02);
                        }
                        
                        .text-red-500 {
                            font-size: 0.875rem;
                            margin-top: 0.5rem;
                            padding: 0.5rem 1rem;
                            background: rgba(239, 68, 68, 0.1);
                            border-left: 3px solid #ef4444;
                            border-radius: 0 0.5rem 0.5rem 0;
                        }
                        
                        .btn-secondary {
                            background: white;
                            border: 2px solid #e2e8f0;
                            color: #64748b;
                            transition: all 0.3s ease;
                        }
                        
                        .btn-secondary:hover {
                            border-color: #6366f1;
                            background: #f8fafc;
                            color: #6366f1;
                            transform: translateY(-1px);
                            box-shadow: 0 4px 12px -2px rgba(99, 102, 241, 0.2);
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
                        <div class="absolute top-1/2 -left-20 w-40 h-40 bg-gradient-to-r from-green-400 to-blue-400 rounded-full opacity-10 floating-element" style="animation-delay: -1.5s;"></div>
                    </div>

                    <div class="relative z-10 container mx-auto px-4 py-12 max-w-4xl">
                        <!-- Flash Messages -->
                        <div class="space-y-4 mb-8">
                            <c:if test="${not empty success}">
                                <div class="alert-success p-6 rounded-2xl transform transition-all duration-500 hover:scale-[1.02]">
                                    <div class="flex items-center">
                                        <i class="fas fa-check-circle text-2xl mr-4"></i>
                                        <div>
                                            <h4 class="font-semibold text-lg">Cập nhật thành công!</h4>
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
                        </div>

                        <!-- Main Content -->
                        <section class="pt-16">
                            <!-- Header Section -->
                            <div class="text-center mb-12 section-header">
                                <h1 class="text-4xl lg:text-5xl font-bold bg-gradient-to-r from-slate-900 via-purple-900 to-slate-900 bg-clip-text text-transparent mb-4">
                                    Cập Nhật Hồ Sơ
                                </h1>
                                <p class="text-slate-600 text-lg">Chỉnh sửa thông tin cá nhân của bạn</p>
                            </div>

                            <!-- Profile Update Form -->
                            <div class="form-card rounded-3xl overflow-hidden">
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
                                                                 class="w-32 h-32 rounded-full object-cover border-4 border-white avatar-glow mx-auto">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${ctx}${customer.imageUrl}" alt="Ảnh đại diện" 
                                                                 class="w-32 h-32 rounded-full object-cover border-4 border-white avatar-glow mx-auto">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${ctx}/resources/assets/client/images/default-avatar.jpg"
                                                         alt="Ảnh đại diện mặc định" 
                                                         class="w-32 h-32 rounded-full object-cover border-4 border-white avatar-glow mx-auto">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="absolute -bottom-2 -right-2 w-10 h-10 bg-white rounded-full border-2 border-white flex items-center justify-center">
                                                <i class="fas fa-camera text-indigo-600 text-sm"></i>
                                            </div>
                                        </div>
                                        <h3 class="text-2xl font-bold text-white mt-4">Cập nhật ảnh đại diện</h3>
                                    </div>
                                </div>

                                <!-- Form Section -->
                                <div class="p-12">
                                    <form:form modelAttribute="customer" action="${ctx}/management/profile/update"
                                        method="POST" enctype="multipart/form-data" class="space-y-8">
                                        
                                        <!-- Hidden Fields -->
                                        <form:hidden path="customerId" />
                                        <form:hidden path="account.accountId" />
                                        <form:hidden path="registrationDate" />
                                        <form:hidden path="status" />

                                        <!-- Personal Information Section -->
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                            <!-- First Name -->
                                            <div class="form-group">
                                                <label class="form-label">Họ *</label>
                                                <div class="relative">
                                                    <form:input path="firstName" 
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12" 
                                                        required="true" placeholder="Nhập họ của bạn" />
                                                    <i class="form-icon fas fa-user"></i>
                                                </div>
                                                <form:errors path="firstName" cssClass="text-red-500" />
                                            </div>

                                            <!-- Last Name -->
                                            <div class="form-group">
                                                <label class="form-label">Tên *</label>
                                                <div class="relative">
                                                    <form:input path="lastName" 
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12" 
                                                        required="true" placeholder="Nhập tên của bạn" />
                                                    <i class="form-icon fas fa-user-tag"></i>
                                                </div>
                                                <form:errors path="lastName" cssClass="text-red-500" />
                                            </div>
                                        </div>

                                        <!-- Contact Information Section -->
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                            <!-- Email -->
                                            <div class="form-group">
                                                <label class="form-label">Email *</label>
                                                <div class="relative">
                                                    <form:input path="email" type="email"
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12" 
                                                        required="true" placeholder="example@email.com" />
                                                    <i class="form-icon fas fa-envelope"></i>
                                                </div>
                                                <form:errors path="email" cssClass="text-red-500" />
                                            </div>

                                            <!-- Phone -->
                                            <div class="form-group">
                                                <label class="form-label">Số Điện Thoại *</label>
                                                <div class="relative">
                                                    <form:input path="phone" 
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12"
                                                        required="true" pattern="\d{10}"
                                                        title="Số điện thoại phải có đúng 10 chữ số" 
                                                        placeholder="0123456789" />
                                                    <i class="form-icon fas fa-phone"></i>
                                                </div>
                                                <form:errors path="phone" cssClass="text-red-500" />
                                            </div>
                                        </div>

                                        <!-- Personal Details Section -->
                                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                            <!-- Date of Birth -->
                                            <div class="form-group">
                                                <label class="form-label">Ngày Sinh *</label>
                                                <div class="relative">
                                                    <c:if test="${not empty customer.dateOfBirth}">
                                                        <fmt:parseDate value="${customer.dateOfBirth}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd" var="formattedDate" />
                                                    </c:if>
                                                    <form:input path="dateOfBirth" type="date" value="${formattedDate}"
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12" 
                                                        required="true" />
                                                    <i class="form-icon fas fa-calendar-alt"></i>
                                                </div>
                                                <form:errors path="dateOfBirth" cssClass="text-red-500" />
                                            </div>

                                            <!-- Gender -->
                                            <div class="form-group">
                                                <label class="form-label">Giới Tính</label>
                                                <div class="relative">
                                                    <form:select path="gender" 
                                                        class="form-input w-full px-6 py-4 rounded-2xl text-lg font-medium pr-12 appearance-none">
                                                        <form:option value="true">Nam</form:option>
                                                        <form:option value="false">Nữ</form:option>
                                                    </form:select>
                                                    <i class="form-icon fas fa-venus-mars"></i>
                                                </div>
                                                <form:errors path="gender" cssClass="text-red-500" />
                                            </div>
                                        </div>

                                        <!-- Avatar Upload Section -->
                                        <div class="form-group">
                                            <label class="form-label">Ảnh Đại Diện</label>
                                            <div class="upload-zone p-8 rounded-2xl text-center">
                                                <div class="mb-4">
                                                    <i class="fas fa-cloud-upload-alt text-4xl text-slate-400 mb-4"></i>
                                                    <h4 class="text-lg font-semibold text-slate-700 mb-2">Tải lên ảnh đại diện mới</h4>
                                                    <p class="text-slate-500 text-sm mb-4">Kéo và thả file hoặc click để chọn</p>
                                                </div>
                                                <input type="file" name="image" 
                                                    class="w-full px-6 py-4 rounded-2xl border-2 border-dashed border-slate-300 bg-transparent file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100 transition-all duration-300"
                                                    accept="image/*" />
                                                <p class="text-xs text-slate-400 mt-2">PNG, JPG, GIF tối đa 5MB</p>
                                            </div>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="flex flex-col sm:flex-row justify-end gap-4 pt-8 border-t border-slate-200">
                                            <a href="${ctx}/management/profile"
                                                class="btn-secondary px-8 py-4 rounded-2xl font-semibold text-center flex items-center justify-center group">
                                                <i class="fas fa-times mr-3 group-hover:rotate-90 transition-transform duration-300"></i>
                                                Hủy Bỏ
                                            </a>
                                            <button type="submit"
                                                class="btn-gradient text-white px-8 py-4 rounded-2xl font-semibold flex items-center justify-center group">
                                                <i class="fas fa-save mr-3 group-hover:scale-110 transition-transform duration-300"></i>
                                                Lưu Thay Đổi
                                            </button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </section>
                    </div>

                    <script>
                        // Enhanced file upload interaction
                        document.addEventListener('DOMContentLoaded', function() {
                            const uploadZone = document.querySelector('.upload-zone');
                            const fileInput = document.querySelector('input[type="file"]');
                            
                            // Drag and drop functionality
                            uploadZone.addEventListener('dragover', function(e) {
                                e.preventDefault();
                                uploadZone.classList.add('dragover');
                            });
                            
                            uploadZone.addEventListener('dragleave', function(e) {
                                e.preventDefault();
                                uploadZone.classList.remove('dragover');
                            });
                            
                            uploadZone.addEventListener('drop', function(e) {
                                e.preventDefault();
                                uploadZone.classList.remove('dragover');
                                
                                const files = e.dataTransfer.files;
                                if (files.length > 0) {
                                    fileInput.files = files;
                                    // Add visual feedback here if needed
                                }
                            });
                            
                            // Form validation enhancement
                            const formInputs = document.querySelectorAll('.form-input');
                            formInputs.forEach(input => {
                                input.addEventListener('blur', function() {
                                    if (this.value.trim() !== '') {
                                        this.classList.add('has-value');
                                    } else {
                                        this.classList.remove('has-value');
                                    }
                                });
                                
                                // Check initial values
                                if (input.value.trim() !== '') {
                                    input.classList.add('has-value');
                                }
                            });
                        });
                    </script>
                </body>

                </html>