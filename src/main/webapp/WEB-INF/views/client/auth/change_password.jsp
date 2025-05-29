<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS |
                    <spring:message code="profile.changePasswordTitle" />
                </title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
                <style>
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
                    <c:if test="${not empty passwordSuccess}">
                        <div class="bg-green-100 text-green-800 p-4 rounded mb-6">${passwordSuccess}</div>
                    </c:if>
                    <c:if test="${not empty passwordError}">
                        <div class="bg-red-100 text-red-800 p-4 rounded mb-6">${passwordError}</div>
                    </c:if>

                    <div class="bg-white rounded-lg border border-black overflow-hidden">
                        <!-- Header -->
                        <div class="px-6 py-4 border-b border-black">
                            <h1 class="text-2xl font-bold text-black">
                                <spring:message code="profile.changePasswordPageTitle" />
                            </h1>
                        </div>

                        <!-- Profile Content -->
                        <div class="p-6">
                            <form action="${ctx}/management/profile/change-password" method="POST">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="space-y-4">
                                    <!-- Old Password -->
                                    <div>
                                        <label for="oldPassword" class="block text-sm font-medium text-black mb-1">
                                            <spring:message code="profile.oldPassword" />
                                        </label>
                                        <input type="password" name="oldPassword" id="oldPassword"
                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                            required />
                                    </div>

                                    <!-- New Password -->
                                    <div>
                                        <label for="newPassword" class="block text-sm font-medium text-black mb-1">
                                            <spring:message code="profile.newPassword" />
                                        </label>
                                        <input type="password" name="newPassword" id="newPassword"
                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                            required />
                                    </div>

                                    <!-- Confirm Password -->
                                    <div>
                                        <label for="confirmPassword" class="block text-sm font-medium text-black mb-1">
                                            <spring:message code="profile.confirmPassword" />
                                        </label>
                                        <input type="password" name="confirmPassword" id="confirmPassword"
                                            class="w-full px-4 py-2 border border-black rounded focus:outline-none focus:ring-1 focus:ring-black"
                                            required />
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
                                        <spring:message code="profile.savePassword" />
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Footer -->
                <jsp:include page="../layout/footer.jsp" />
            </body>

            </html>