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
                            <form:form action="/client/auth/register" class="form-two--item2--list1-con" method="post" modelAttribute="registerDTO">
                                <div class="form-two-icon1">
                                    <div>Đăng ký</div>
                                    <div class="form-two-icon1-item3"><i class="fa-solid fa-qrcode"></i></div>
                                </div>
                                <!-- first name -->
                                <div class="form-two-icon2">
                                    <form:input placeholder="Họ" class="form-two-icon2" path="firstName"/>
                                    <form:errors path="firstName" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.firstName}">
                                        <div class="text-danger">${errors.firstName}</div>
                                    </c:if>
                                </div>
                                <!-- last name -->
                                <div class="form-two-icon2">
                                    <form:input placeholder="Tên" class="form-two-icon2" path="lastName"/>
                                    <form:errors path="lastName" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.lastName}">
                                        <div class="text-danger">${errors.lastName}</div>
                                    </c:if>
                                </div>
                                <!-- email -->
                                <div class="form-two-icon2">
                                    <form:input placeholder="Email" class="form-two-icon2" path="email"/>
                                    <form:errors path="email" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.email}">
                                        <div class="text-danger">${errors.email}</div>
                                    </c:if>
                                </div>
                                <!-- phone number -->
                                <div class="form-two-icon2">
                                    <form:input placeholder="Số điện thoại" class="form-two-icon2" path="phoneNumber"/>
                                    <form:errors path="phoneNumber" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.phoneNumber}">
                                        <div class="text-danger">${errors.phoneNumber}</div>
                                    </c:if>
                                </div>
                                <!-- login name -->
                                <div class="form-two-icon2">
                                    <form:input placeholder="Tên đăng nhập" class="form-two-icon2" path="loginName"/>
                                    <form:errors path="loginName" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.loginName}">
                                        <div class="text-danger">${errors.loginName}</div>
                                    </c:if>
                                </div>
                                <!-- password -->
                                <div class="form-two-icon3">
                                    <form:input placeholder="Mật khẩu" class="form-two-icon2" path="password" type="password"/>
                                    <form:errors path="password" cssClass="text-danger"/>
                                </div>
                                <!-- confirm password -->
                                <div class="form-two-icon4">
                                    <form:input placeholder="Nhập lại mật khẩu" class="form-two-icon2" path="confirmPassword" type="password"/>
                                    <form:errors path="confirmPassword" cssClass="text-danger"/>
                                    <c:if test="${not empty errors.confirmPassword}">
                                        <div class="text-danger">${errors.confirmPassword}</div>
                                    </c:if>
                                </div>
                                
                                <!-- btn register -->
                                <div class="form-two-icon4">
                                    <button type="submit" class="form-two-icon4-icon1">Đăng kí</button>
                                </div>
                                <!-- btn login -->
                                <div class="form-two-icon7">
                                    <div class="form-two-icon7-item1">Bạn đã có tài khoản?</div>
                                    <a class="form-two-icon7-item2" href="/client/auth/login">Đăng nhập</a>
                                </div>
                            </form:form>

                        </div>
                    </div>

                </div>
                <!-- end form two-->

            </div>

            <!-- start footer -->
            <jsp:include page="../layout/footer.jsp" />
            <!-- end footer -->

        </div>
    </body>

    </html>