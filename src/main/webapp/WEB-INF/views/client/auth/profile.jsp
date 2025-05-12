<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTS | Your Profile</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
    <style>
        /* Optional: Additional styles for modals */
        .modal {
            z-index: 1000;
        }
        .modal input {
            outline: none;
            transition: border-color 0.2s;
        }
        .modal input:focus {
            border-color: #000;
        }
        .text-red-500 {
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body class="bg-white">
    <!-- Navbar -->
    <jsp:include page="../layout/navbar.jsp" />

    <div class="container mx-auto px-4 py-12 max-w-6xl">
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">
                ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">
                ${error}
            </div>
        </c:if>
        <c:if test="${not empty passwordSuccess}">
            <div class="bg-green-100 text-green-800 p-4 rounded mb-6">
                ${passwordSuccess}
            </div>
        </c:if>
        <c:if test="${not empty passwordError}">
            <div class="bg-red-100 text-red-800 p-4 rounded mb-6">
                ${passwordError}
            </div>
        </c:if>

        <!-- Profile Section -->
        <section class="pt-[64px] mb-16">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-medium">Your Profile</h2>
                <button id="editProfileBtn" class="btn-black bg-black text-white px-6 py-2 rounded-full text-sm">
                    Edit Info
                </button>
            </div>

            <div class="bg-white p-8 shadow-sm">
                <c:choose>
                    <c:when test="${not empty customer}">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <h3 class="text-lg font-medium mb-4">Personal Information</h3>
                                <div class="space-y-4">
                                    <div>
                                        <p class="text-gray-500 text-sm">Full Name</p>
                                        <p class="font-medium">
                                            <c:out value="${customer.firstName}" default="N/A"/> 
                                            <c:out value="${customer.lastName}" default="N/A"/>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Email</p>
                                        <p class="font-medium"><c:out value="${customer.email}" default="N/A"/></p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Phone</p>
                                        <p class="font-medium"><c:out value="${customer.phone}" default="N/A"/></p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Date of Birth</p>
                                        <p class="font-medium">
                                            <c:choose>
                                                <c:when test="${not empty customer.dateOfBirth}">
                                                    <fmt:formatDate value="${customer.dateOfBirthAsDate}" pattern="dd/MM/yyyy" />
                                                </c:when>
                                                <c:otherwise>N/A</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                    <div>
                                        <p class="text-gray-500 text-sm">Gender</p>
                                        <p class="font-medium">${customer.gender ? 'Male' : 'Female'}</p>
                                    </div>
                                    <c:if test="${not empty customer.imageUrl}">
                                        <div>
                                            <p class="text-gray-500 text-sm">Profile Image</p>
                                            <img src="${ctx}${customer.imageUrl}" alt="Profile Image" class="w-24 h-24 rounded-full object-cover" onerror="this.src='${ctx}/resources/assets/client/images/default-avatar.jpg'">
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <div>
                                <h3 class="text-lg font-medium mb-4">Shipping Addresses</h3>
                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${not empty customer.addresses}">
                                            <c:forEach var="address" items="${customer.addresses}">
                                                <div>
                                                    <p class="font-medium"><c:out value="${address.street}" default="N/A"/></p>
                                                    <p class="font-medium">
                                                        <c:out value="${address.ward}" default="N/A"/>, 
                                                        <c:out value="${address.district}" default="N/A"/>, 
                                                        <c:out value="${address.city}" default="N/A"/>, 
                                                        <c:out value="${address.country}" default="N/A"/>
                                                    </p>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-gray-500">No addresses available.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-red-500">Unable to load profile information. Please log in.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>

    <!-- Edit Profile Modal -->
    <div id="editProfileModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center modal">
        <div class="bg-white p-8 rounded-lg w-full max-w-md">
            <h3 class="text-lg font-medium mb-4">Edit Profile</h3>
            <form:form modelAttribute="customer" action="${ctx}/management/profile/update" method="POST" enctype="multipart/form-data">
                <form:hidden path="customerId" />
                <form:hidden path="account.accountId" />
                <form:hidden path="registrationDate" />
                <form:hidden path="status" />

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="firstName">First Name</label>
                    <form:input path="firstName" class="w-full px-4 py-2 border rounded-full" />
                    <form:errors path="firstName" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="lastName">Last Name</label>
                    <form:input path="lastName" class="w-full px-4 py-2 border rounded-full" />
                    <form:errors path="lastName" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="email">Email</label>
                    <form:input path="email" class="w-full px-4 py-2 border rounded-full" />
                    <form:errors path="email" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="phone">Phone</label>
                    <form:input path="phone" class="w-full px-4 py-2 border rounded-full" />
                    <form:errors path="phone" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="dateOfBirth">Date of Birth</label>
                    <form:input path="dateOfBirth" type="date" class="w-full px-4 py-2 border rounded-full" />
                    <form:errors path="dateOfBirth" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="gender">Gender</label>
                    <form:select path="gender" class="w-full px-4 py-2 border rounded-full">
                        <form:option value="true">Male</form:option>
                        <form:option value="false">Female</form:option>
                    </form:select>
                    <form:errors path="gender" cssClass="text-red-500 text-sm" />
                </div>

                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="image">Profile Image</label>
                    <input type="file" name="image" class="w-full px-4 py-2 border rounded-full" />
                </div>

                <div class="flex justify-between items-center mb-4">
                    <button type="button" id="changePasswordBtn" class="text-blue-500 hover:underline text-sm">
                        Change Password
                    </button>
                    <div class="flex space-x-4">
                        <button type="button" id="cancelEditBtn" class="px-6 py-2 border rounded-full">Cancel</button>
                        <button type="submit" class="btn-black bg-black text-white px-6 py-2 rounded-full">Save Changes</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

    <!-- Change Password Modal -->
    <div id="changePasswordModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center modal">
        <div class="bg-white p-8 rounded-lg w-full max-w-md">
            <h3 class="text-lg font-medium mb-4">Change Password</h3>
            <form action="${ctx}/management/profile/change-password" method="POST">
                <!-- CSRF Token -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="oldPassword">Old Password</label>
                    <input type="password" name="oldPassword" id="oldPassword" class="w-full px-4 py-2 border rounded-full" required />
                </div>
                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="newPassword">New Password</label>
                    <input type="password" name="newPassword" id="newPassword" class="w-full px-4 py-2 border rounded-full" required />
                </div>
                <div class="mb-4">
                    <label class="block text-sm text-gray-500 mb-2" for="confirmPassword">Confirm New Password</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" class="w-full px-4 py-2 border rounded-full" required />
                </div>
                <div class="flex justify-end space-x-4">
                    <button type="button" id="cancelPasswordBtn" class="px-6 py-2 border rounded-full">Cancel</button>
                    <button type="submit" class="btn-black bg-black text-white px-6 py-2 rounded-full">Save Password</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Toggle Edit Profile Modal
        const editProfileBtn = document.getElementById('editProfileBtn');
        const editProfileModal = document.getElementById('editProfileModal');
        const cancelEditBtn = document.getElementById('cancelEditBtn');

        editProfileBtn.addEventListener('click', () => {
            editProfileModal.classList.remove('hidden');
        });

        cancelEditBtn.addEventListener('click', () => {
            editProfileModal.classList.add('hidden');
        });

        // Toggle Change Password Modal
        const changePasswordBtn = document.getElementById('changePasswordBtn');
        const changePasswordModal = document.getElementById('changePasswordModal');
        const cancelPasswordBtn = document.getElementById('cancelPasswordBtn');

        changePasswordBtn.addEventListener('click', () => {
            changePasswordModal.classList.remove('hidden');
        });

        cancelPasswordBtn.addEventListener('click', () => {
            changePasswordModal.classList.add('hidden');
        });
    </script>
</body>
</html>