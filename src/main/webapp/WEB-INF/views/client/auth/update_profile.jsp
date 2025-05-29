<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>DDTS |
                            <spring:message code="profile.updateTitle" />
                        </title>
                        <c:set var="ctx" value="${pageContext.request.contextPath}" />
                        <script src="https://cdn.tailwindcss.com"></script>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                            rel="stylesheet">
                        <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
                        <style>
                            .avatar-upload {
                                position: relative;
                                display: inline-block;
                            }

                            .avatar-upload input[type="file"] {
                                position: absolute;
                                left: 0;
                                top: 0;
                                opacity: 0;
                                width: 100%;
                                height: 100%;
                                cursor: pointer;
                            }

                            .avatar-preview {
                                width: 120px;
                                height: 120px;
                                border-radius: 50%;
                                border: 2px solid #000;
                                background-color: #f3f4f6;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                overflow: hidden;
                            }

                            .avatar-preview img {
                                width: 100%;
                                height: 100%;
                                object-fit: cover;
                            }

                            .text-red-500 {
                                font-size: 0.875rem;
                                margin-top: 0.25rem;
                            }
                        </style>
                    </head>

                    <body class="bg-white min-h-screen">
                        <!-- Navbar -->
                        <jsp:include page="../layout/navbar.jsp" />

                        <div class="container mx-auto px-4 py-8 max-w-2xl">
                            <!-- Flash Messages -->
                            <c:if test="${not empty success}">
                                <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${success}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${error}</div>
                            </c:if>

                            <div class="bg-white rounded-lg border border-black overflow-hidden">
                                <!-- Header -->
                                <div class="px-6 py-4 border-b border-black">
                                    <h1 class="text-2xl font-bold text-black">
                                        <spring:message code="profile.updatePageTitle" />
                                    </h1>
                                </div>

                                <!-- Profile Content -->
                                <div class="p-6">
                                    <div class="flex flex-col md:flex-row gap-8">
                                        <!-- Avatar Section -->
                                        <div class="w-full md:w-1/3 flex flex-col items-center">
                                            <div class="avatar-upload mb-4">
                                                <div class="avatar-preview">
                                                    <c:choose>
                                                        <c:when test="${not empty customer.imageUrl}">
                                                            <img id="avatar-preview" src="${ctx}${customer.imageUrl}"
                                                                alt="<spring:message code='profile.avatar' />">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img id="avatar-preview"
                                                                src="${ctx}/resources/assets/client/images/default-avatar.jpg"
                                                                alt="<spring:message code='profile.defaultAvatar' />">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <button onclick="document.getElementById('avatar-input').click()"
                                                class="bg-white hover:bg-gray-100 text-black border border-black px-4 py-2 rounded font-medium">
                                                <spring:message code="profile.changeAvatar" />
                                            </button>
                                        </div>

                                        <!-- Personal Information Section -->
                                        <div class="w-full md:w-2/3">
                                            <h2
                                                class="text-xl font-semibold mb-6 text-black border-b border-black pb-2">
                                                <spring:message code="profile.personalInfo" />
                                            </h2>

                                            <form:form modelAttribute="customer"
                                                action="${ctx}/management/profile/update" method="POST"
                                                enctype="multipart/form-data">
                                                <form:hidden path="customerId" />
                                                <form:hidden path="account.accountId" />
                                                <form:hidden path="registrationDate" />
                                                <form:hidden path="status" />

                                                <div class="space-y-4">
                                                    <!-- First Name -->
                                                    <div>
                                                        <label for="firstName"
                                                            class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.firstName" />
                                                        </label>
                                                        <form:input path="firstName"
                                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                                            required="true" />
                                                        <form:errors path="firstName" cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Last Name -->
                                                    <div>
                                                        <label for="lastName"
                                                            class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.lastName" />
                                                        </label>
                                                        <form:input path="lastName"
                                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                                            required="true" />
                                                        <form:errors path="lastName" cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Email -->
                                                    <div>
                                                        <label for="email"
                                                            class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.email" />
                                                        </label>
                                                        <form:input path="email" type="email"
                                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                                            required="true" />
                                                        <form:errors path="email" cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Phone Number -->
                                                    <div>
                                                        <label for="phone"
                                                            class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.phone" />
                                                        </label>
                                                        <form:input path="phone"
                                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                                            required="true" pattern="\d{10}"
                                                            title="Số điện thoại phải có đúng 10 chữ số" />
                                                        <form:errors path="phone" cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Date of Birth -->
                                                    <div>
                                                        <label for="dateOfBirth"
                                                            class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.dateOfBirth" />
                                                        </label>
                                                        <c:if test="${not empty customer.dateOfBirth}">
                                                            <fmt:parseDate value="${customer.dateOfBirth}"
                                                                pattern="yyyy-MM-dd" var="parsedDate" />
                                                            <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd"
                                                                var="formattedDate" />
                                                        </c:if>

                                                        <!-- Lấy ngày hiện tại để giới hạn -->
                                                        <jsp:useBean id="now" class="java.util.Date" />
                                                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd"
                                                            var="currentDate" />

                                                        <form:input path="dateOfBirth" type="date"
                                                            value="${formattedDate}"
                                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                                            required="true" max="${currentDate}" />
                                                        <form:errors path="dateOfBirth"
                                                            cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Gender -->
                                                    <div>
                                                        <label class="block text-sm font-medium text-black mb-2">
                                                            <spring:message code="profile.gender" />
                                                        </label>
                                                        <div class="flex items-center space-x-4">
                                                            <label class="inline-flex items-center">
                                                                <form:radiobutton path="gender" value="true"
                                                                    class="h-4 w-4 text-black focus:ring-black border-black" />
                                                                <span class="ml-2 text-black">
                                                                    <spring:message code="profile.male" />
                                                                </span>
                                                            </label>
                                                            <label class="inline-flex items-center">
                                                                <form:radiobutton path="gender" value="false"
                                                                    class="h-4 w-4 text-black focus:ring-black border-black" />
                                                                <span class="ml-2 text-black">
                                                                    <spring:message code="profile.female" />
                                                                </span>
                                                            </label>
                                                        </div>
                                                        <form:errors path="gender" cssClass="text-red-500 text-sm" />
                                                    </div>

                                                    <!-- Avatar Upload -->
                                                    <div class="hidden">
                                                        <label class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.avatar" />
                                                        </label>
                                                        <input type="file" name="image" id="avatar-input"
                                                            accept="image/*"
                                                            class="w-full px-4 py-2 border border-black rounded" />
                                                    </div>
                                                </div>

                                                <!-- Save Button -->
                                                <div class="mt-8 flex justify-end space-x-4">
                                                    <a href="${ctx}/management/profile"
                                                        class="px-6 py-2 border border-black rounded font-medium">
                                                        <spring:message code="profile.cancel" />
                                                    </a>
                                                    <button type="submit"
                                                        class="bg-black hover:bg-gray-800 text-white px-6 py-2 rounded font-medium">
                                                        <spring:message code="profile.saveChanges" />
                                                    </button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <jsp:include page="../layout/footer.jsp" />

                        <script>
                            // Handle avatar upload preview
                            document.getElementById('avatar-input').addEventListener('change', function (e) {
                                const file = e.target.files[0];
                                if (file) {
                                    const reader = new FileReader();
                                    reader.onload = function (event) {
                                        document.getElementById('avatar-preview').src = event.target.result;
                                    };
                                    reader.readAsDataURL(file);
                                }
                            });
                        </script>
                    </body>

                    </html>