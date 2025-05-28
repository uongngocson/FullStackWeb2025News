<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <footer class="bg-gradient-to-br from-zinc-800 to-black text-white py-12 mt-8">
                    <div class="container mx-auto px-4">
                        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                            <div>
                                <img src="/client/img/logo.webp" alt="Logo" class="h-12 mb-4">
                                <p class="text-gray-400 mb-4 text-sm">
                                    <spring:message code="footer.description" />
                                </p>
                                <div class="flex space-x-4">
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-facebook-f"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-twitter"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                    <a href="#" class="text-gray-400 hover:text-white transition">
                                        <i class="fab fa-youtube"></i>
                                    </a>
                                </div>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">
                                    <spring:message code="footer.shop" />
                                </h4>
                                <ul class="space-y-2 text-sm text-gray-400">
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="navbar.home" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.women" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.men" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.accessories" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.newArrivals" />
                                        </a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">
                                    <spring:message code="footer.customerService" />
                                </h4>
                                <ul class="space-y-2 text-sm text-gray-400">
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.faq" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.shippingReturns" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.storePolicy" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.paymentMethods" />
                                        </a></li>
                                    <li><a href="#" class="hover:text-white transition">
                                            <spring:message code="footer.contact" />
                                        </a></li>
                                </ul>
                            </div>

                            <div>
                                <h4 class="text-lg font-semibold mb-4">
                                    <spring:message code="home.magazine" />
                                </h4>
                                <p class="text-gray-400 mb-4 text-sm">
                                    <spring:message code="home.minimalistFashionDesc" />
                                </p>
                                <form class="flex">
                                    <input type="email" placeholder="Your email address"
                                        class="px-4 py-2 bg-zinc-700 text-white placeholder-gray-400 rounded-l-md flex-grow text-sm focus:outline-none">
                                    <button type="submit"
                                        class="bg-purple-600 text-white px-4 py-2 rounded-r-md hover:bg-purple-700 transition text-sm">
                                        <spring:message code="cart.proceedToCheckout" />
                                    </button>
                                </form>
                            </div>
                        </div>

                        <hr class="border-zinc-700 my-8">

                        <div class="flex flex-col md:flex-row justify-between items-center text-sm text-gray-400">
                            <div>
                                <spring:message code="footer.copyright" />
                            </div>
                            <div class="mt-4 md:mt-0 flex space-x-4">
                                <a href="#" class="hover:text-white transition">
                                    <spring:message code="footer.privacyPolicy" />
                                </a>
                                <a href="#" class="hover:text-white transition">
                                    <spring:message code="footer.termsOfUse" />
                                </a>
                                <a href="#" class="hover:text-white transition">
                                    <spring:message code="footer.sustainability" />
                                </a>
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Include chatbot button -->
                <jsp:include page="chatbot-button.jsp" />