<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!-- Navigation -->
                <nav class="fixed w-full z-50 bg-white bg-opacity-90 border-b border-gray-100">
                    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                        <div class="text-2xl font-semibold tracking-widest">DDTS</div>

                        <div class="hidden md:flex space-x-8">
                            <a href="/"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.home" />
                            </a>
                            <a href="/product/category"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.categories" />
                            </a>
                            <a href="/product/item-male"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.men" />
                            </a>
                            <a href="/product/item-female"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.women" />
                            </a>
                            <a href="/about"
                                class="nav-link uppercase text-sm tracking-wider hover:after:w-full after:block after:w-0 after:h-px after:bg-black after:transition-all after:duration-300">
                                <spring:message code="navbar.about" />
                            </a>
                        </div>

                        <div class="flex items-center space-x-6">
                            <!-- Language Selector Dropdown -->
                            <div class="relative inline-block text-left">
                                <div>
                                    <button type="button"
                                        class="inline-flex items-center justify-center w-full px-4 py-2 text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none"
                                        id="language-menu-button" aria-expanded="false" aria-haspopup="true">
                                        <!-- Hiển thị ngôn ngữ hiện tại (Cập nhật) -->
                                        <span class="mr-2">
                                            <c:choose>
                                                <c:when test="${pageContext.response.locale == 'en'}">English</c:when>
                                                <c:when test="${pageContext.response.locale == 'ar'}">Arabic</c:when>
                                                <c:when test="${pageContext.response.locale == 'zh-Hans'}">Chinese
                                                    (Simplified)</c:when>
                                                <c:when test="${pageContext.response.locale == 'fr'}">French</c:when>
                                                <c:when test="${pageContext.response.locale == 'de'}">German</c:when>
                                                <c:when test="${pageContext.response.locale == 'ja'}">Japanese</c:when>
                                                <c:when test="${pageContext.response.locale == 'pt'}">Portuguese
                                                </c:when>
                                                <c:when test="${pageContext.response.locale == 'ru'}">Russian</c:when>
                                                <c:when test="${pageContext.response.locale == 'es'}">Spanish</c:when>
                                                <%-- Thêm 'vi' nếu bạn vẫn muốn hỗ trợ tiếng Việt --%>
                                                    <c:when test="${pageContext.response.locale == 'vi'}">Tiếng Việt
                                                    </c:when>
                                                    <c:otherwise>English</c:otherwise> <%-- Mặc định là English --%>
                                            </c:choose>
                                        </span>
                                        <svg class="-mr-1 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg"
                                            viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd"
                                                d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                                                clip-rule="evenodd" />
                                        </svg>
                                    </button>
                                </div>
                                <div class="hidden origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 focus:outline-none"
                                    <%-- Tăng chiều rộng nếu cần --%>
                                    role="menu" aria-orientation="vertical" aria-labelledby="language-menu-button"
                                    tabindex="-1" id="language-menu">
                                    <div class="py-1" role="none">
                                        <%-- Danh sách ngôn ngữ lựa chọn (Cập nhật) --%>
                                            <a href="javascript:void(0);" onclick="changeLanguage('en')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'en' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">English</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('ar')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'ar' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Arabic</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('zh-Hans')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'zh-Hans' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Chinese (Simplified)</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('fr')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'fr' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">French</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('de')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'de' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">German</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('ja')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'ja' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Japanese</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('pt')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'pt' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Portuguese</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('ru')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'ru' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Russian</a>
                                            <a href="javascript:void(0);" onclick="changeLanguage('es')"
                                                class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'es' ? 'bg-gray-100 font-medium' : ''}"
                                                role="menuitem">Spanish</a>
                                            <%-- Thêm 'vi' nếu bạn vẫn muốn hỗ trợ tiếng Việt --%>
                                                <a href="javascript:void(0);" onclick="changeLanguage('vi')"
                                                    class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100 ${pageContext.response.locale == 'vi' ? 'bg-gray-100 font-medium' : ''}"
                                                    role="menuitem">Tiếng Việt</a>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/user/cart" class="relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-lg"></i>
                                    <span
                                        class="absolute -top-1 -right-2 bg-blue-200 rounded-full flex items-center justify-center text-dark px-1 h-5 w-5 text-xs"
                                        id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="relative my-auto group">
                                    <button type="button" class="focus:outline-none">
                                        <i class="fas fa-user fa-lg"></i>
                                    </button>
                                    <div
                                        class="absolute right-0 mt-2 w-72 bg-white rounded-md shadow-lg z-50 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-300 transform group-hover:translate-y-0 translate-y-1">
                                        <div class="p-4">
                                            <div class="flex flex-col items-center">
                                                <img class="w-24 h-24 rounded-full object-cover mb-3"
                                                    src="${sessionScope.avatar}" />
                                                <div class="text-center font-medium mb-3">
                                                    <c:out value="${sessionScope.fullName}" />
                                                </div>
                                            </div>
                                            <hr class="my-2 border-gray-200">
                                            <a href="#" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.account" />
                                            </a>
                                            <a href="/order-history"
                                                class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                <spring:message code="navbar.orderHistory" />
                                            </a>
                                            <hr class="my-2 border-gray-200">
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit"
                                                    class="w-full text-left block px-4 py-2 text-gray-800 hover:bg-gray-100">
                                                    <spring:message code="navbar.logout" />
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="text-sm hover:text-blue-600">
                                    <spring:message code="navbar.login" />
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>

                <!-- Font Awesome -->
                <script src="https://kit.fontawesome.com/your-code.js" crossorigin="anonymous"></script>

                <!-- Thêm script để xử lý dropdown và chuyển đổi ngôn ngữ -->
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        const button = document.getElementById('language-menu-button');
                        const menu = document.getElementById('language-menu');

                        if (button && menu) { // Kiểm tra xem các phần tử có tồn tại không
                            // Toggle dropdown khi click button
                            button.addEventListener('click', function () {
                                menu.classList.toggle('hidden');
                                const isExpanded = menu.classList.contains('hidden') ? 'false' : 'true';
                                button.setAttribute('aria-expanded', isExpanded);
                            });

                            // Đóng dropdown khi click ra ngoài
                            document.addEventListener('click', function (event) {
                                if (!button.contains(event.target) && !menu.contains(event.target)) {
                                    menu.classList.add('hidden');
                                    button.setAttribute('aria-expanded', 'false');
                                }
                            });
                        }
                    });

                    // Hàm xử lý chuyển đổi ngôn ngữ (không thay đổi)
                    function changeLanguage(lang) {
                        const currentUrl = new URL(window.location.href);
                        currentUrl.searchParams.set('lang', lang); // Đặt hoặc cập nhật tham số 'lang'
                        window.location.href = currentUrl.toString(); // Điều hướng đến URL mới
                    }
                </script>