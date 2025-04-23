<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!-- Navigation -->
                <nav class="fixed w-full z-50 bg-white bg-opacity-90 border-b border-gray-100">
                    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
                        <div class="text-2xl font-semibold tracking-widest">DDTS</div>

                        <div class="hidden md:flex space-x-8">
                            <a href="/" class="nav-link uppercase text-sm tracking-wider">
                                <spring:message code="navbar.home" />
                            </a>
                            <a href="/product/category" class="nav-link uppercase text-sm tracking-wider">
                                <spring:message code="navbar.categories" />
                            </a>
                            <a href="/product/item-male" class="nav-link uppercase text-sm tracking-wider">
                                <spring:message code="navbar.men" />
                            </a>
                            <a href="/product/item-female" class="nav-link uppercase text-sm tracking-wider">
                                <spring:message code="navbar.women" />
                            </a>
                            <a href="/about" class="nav-link uppercase text-sm tracking-wider">
                                <spring:message code="navbar.about" />
                            </a>
                        </div>

                        <div class="flex items-center space-x-6">
                            <div class="flex space-x-2">
                                <a href="?lang=en"
                                    class="text-sm ${pageContext.response.locale == 'en' ? 'font-bold text-blue-600' : 'text-gray-600'}">EN</a>
                                <span class="text-gray-400">|</span>
                                <a href="?lang=vi"
                                    class="text-sm ${pageContext.response.locale == 'vi' ? 'font-bold text-blue-600' : 'text-gray-600'}">VI</a>
                            </div>
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <a href="/cart" class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>
                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                            <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                                src="${sessionScope.avatar}" />
                                            <div class="text-center my-3">
                                                <c:out value="${sessionScope.fullName}" />
                                            </div>
                                        </li>
                                        <li><a class="dropdown-item" href="#">
                                                <spring:message code="navbar.account" />
                                            </a></li>
                                        <li><a class="dropdown-item" href="/order-history">
                                                <spring:message code="navbar.orderHistory" />
                                            </a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="dropdown-item">
                                                    <spring:message code="navbar.logout" />
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <a href="/login" class="a-login position-relative me-4 my-auto">
                                    <spring:message code="navbar.login" />
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>