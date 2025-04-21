<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Home AlphaMart</title>
                <link rel="stylesheet" href="../../../resources/css/test.css">
                <link rel="stylesheet" href="../../../resources/css/grid.css">
                <link rel="stylesheet" href="../../../resources/css/style.css">

                <link rel="stylesheet" href="../../../resources/assets/css/base.css">
                <link rel="stylesheet" href="../../../resources/assets/css/style.css">
                <link rel="stylesheet" href="../../../resources/assets/css/grid.css">
                <link rel="stylesheet" href="../../../resources/assets/css/responsive.css">

                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
            </head>

            <body>
                <div class="container-login">
                    <div class="container-login-form">

                        <!-- start form one -->
                        <div class="form-one">
                            <div class="form-one--item1">
                                <img src="../../../../resources/assets/user/img/logo/logo-full-blue.png"
                                    class="header__logo-img">
                                <div class="form-one--item1--list1">ĐĂNG KÝ</div>
                            </div>
                            <div class="form-one--item2">
                                Bạn cần giúp đỡ?

                            </div>

                        </div>
                        <!-- end form one -->

                        <!-- start form two -->
                        <div class="form-two">
                            <div class="form-two--item2">
                                <div class="form-two--item2--list1">
                                    <form action="${pageContext.request.contextPath}/register-auth" method="post"
                                        class="form-two--item2--list1-con">
                                        <div class="form-two-icon1">
                                            <div>Xác nhận đăng ký</div>
                                        </div>
                                        <div class="form-two-icon2">
                                            <input placeholder="Nhập mã xác nhận" class="form-two-icon2"
                                                name="verificationCode" />
                                        </div>
                                        <!-- Add CSRF token -->
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <c:if test="${not empty verificationError}">
                                            <div class="text-danger" style="color: red; margin: 10px 0;">
                                                ${verificationError}
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty message}">
                                            <div class="text-success" style="color: green; margin: 10px 0;">
                                                ${message}
                                            </div>
                                        </c:if>
                                        <div class="form-two-icon4">
                                            <button type="submit" class="form-two-icon4-icon1">Xác nhận</button>
                                            <a href="${pageContext.request.contextPath}/resend-verification"
                                                class="form-two-icon4-icon1">
                                                Gửi lại mã xác nhận
                                            </a>
                                        </div>
                                    </form>


                                </div>


                            </div>

                        </div>

                    </div>

                    <!-- start footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- end footer -->

                </div>
            </body>

            </html>