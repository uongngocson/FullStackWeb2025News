<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS |
                        <spring:message code="profile.title" />
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
                        <c:if test="${not empty passwordSuccess}">
                            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${passwordSuccess}</div>
                        </c:if>
                        <c:if test="${not empty passwordError}">
                            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${passwordError}</div>
                        </c:if>

                        <!-- Profile Section -->
                        <c:choose>
                            <c:when test="${not empty customer}">
                                <div class="bg-white rounded-lg border border-black overflow-hidden">
                                    <!-- Header -->
                                    <div class="px-6 py-4 border-b border-black">
                                        <h1 class="text-2xl font-bold text-black">
                                            <spring:message code="profile.pageTitle" />
                                        </h1>
                                    </div>

                                    <!-- Action Buttons -->
                                    <div class="px-6 py-4 border-b border-black flex justify-between">
                                        <a href="${ctx}/management/profile/update"
                                            class="bg-black hover:bg-gray-800 text-white px-4 py-2 rounded font-medium">
                                            <i class="fas fa-edit mr-2"></i>
                                            <spring:message code="profile.editInfo" />
                                        </a>
                                        <a href="${ctx}/management/profile/change-password"
                                            class="bg-white hover:bg-gray-100 text-black border border-black px-4 py-2 rounded font-medium">
                                            <i class="fas fa-key mr-2"></i>
                                            <spring:message code="profile.changePassword" />
                                        </a>
                                    </div>

                                    <!-- Validation Error Message -->
                                    <c:if test="${empty customer.dateOfBirth}">
                                        <div class="bg-red-100 text-red-800 p-4 mx-6 mt-4 rounded">
                                            <spring:message code="profile.errorBirthday" />
                                        </div>
                                    </c:if>

                                    <!-- Profile Content -->
                                    <div class="p-6">
                                        <div class="flex flex-col md:flex-row gap-8">
                                            <!-- Avatar Section -->
                                            <div class="w-full md:w-1/3 flex flex-col items-center">
                                                <div class="avatar-preview mb-4">
                                                    <c:choose>
                                                        <c:when test="${not empty customer.imageUrl}">
                                                            <img src="${ctx}${customer.imageUrl}"
                                                                alt="<spring:message code='profile.avatar' />">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${ctx}/resources/assets/client/images/default-avatar.jpg"
                                                                alt="<spring:message code='profile.defaultAvatar' />">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <!-- Personal Information Section -->
                                            <div class="w-full md:w-2/3">
                                                <h2
                                                    class="text-xl font-semibold mb-6 text-black border-b border-black pb-2">
                                                    <spring:message code="profile.personalInfo" />
                                                </h2>

                                                <div class="space-y-4">
                                                    <!-- Full Name -->
                                                    <div>
                                                        <p class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.fullName" />
                                                        </p>
                                                        <p class="w-full px-4 py-2 border border-black rounded">
                                                            <c:out
                                                                value="${not empty customer.firstName ? customer.firstName : 'N/A'}" />
                                                            <c:out
                                                                value="${not empty customer.lastName ? customer.lastName : 'N/A'}" />
                                                        </p>
                                                    </div>

                                                    <!-- Email -->
                                                    <div>
                                                        <p class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.email" />
                                                        </p>
                                                        <p class="w-full px-4 py-2 border border-black rounded">
                                                            <c:out
                                                                value="${not empty customer.email ? customer.email : 'N/A'}" />
                                                        </p>
                                                    </div>

                                                    <!-- Phone Number -->
                                                    <div>
                                                        <p class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.phone" />
                                                        </p>
                                                        <p class="w-full px-4 py-2 border border-black rounded">
                                                            <c:out
                                                                value="${not empty customer.phone ? customer.phone : 'N/A'}" />
                                                        </p>
                                                    </div>

                                                    <!-- Date of Birth -->
                                                    <div>
                                                        <p class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.dateOfBirth" />
                                                        </p>
                                                        <p class="w-full px-4 py-2 border border-black rounded">
                                                            <c:choose>
                                                                <c:when test="${not empty customer.dateOfBirth}">
                                                                    <fmt:parseDate value="${customer.dateOfBirth}"
                                                                        pattern="yyyy-MM-dd" var="parsedDate" />
                                                                    <fmt:formatDate value="${parsedDate}"
                                                                        pattern="dd/MM/yyyy" />
                                                                </c:when>
                                                                <c:otherwise>N/A</c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>

                                                    <!-- Gender -->
                                                    <div>
                                                        <p class="block text-sm font-medium text-black mb-1">
                                                            <spring:message code="profile.gender" />
                                                        </p>
                                                        <p class="w-full px-4 py-2 border border-black rounded">
                                                            <c:choose>
                                                                <c:when test="${customer.gender}">
                                                                    <spring:message code="profile.male" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <spring:message code="profile.female" />
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="bg-red-100 text-red-800 p-4 rounded mb-6">
                                    <spring:message code="profile.loadError" />
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Footer -->
                    <jsp:include page="../layout/footer.jsp" />
                </body>

                </html>