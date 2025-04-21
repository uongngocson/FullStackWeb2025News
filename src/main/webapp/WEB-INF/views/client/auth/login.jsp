<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Home AlphaMart</title>


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
                                <div class="form-one--item1--list1">ĐĂNG NHẬP</div>
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
                                    <form action="/login" class="form-two--item2--list1-con" method="post">
                                        <div class="form-two-icon1">
                                            <div class="">Đăng nhập</div>
                                            <div class="form-two-icon1-item3"><i class="fa-solid fa-qrcode"></i></div>
                                        </div>
                                        <c:if test="${param.error != null}">
                                            <div class="my-2"
                                                style="color: rgb(128, 0, 0); text-align: center; margin: 10px 0;">
                                                Invalid username or password.
                                            </div>
                                        </c:if>
                                        <div class="form-two-icon2">
                                            <input placeholder="Tên đăng nhập" class="form-two-icon2" type="text"
                                                name="username" required />
                                        </div>
                                        <div class="form-two-icon3">
                                            <input placeholder="Mật khẩu" class="form-two-icon2" type="password"
                                                name="password" required />
                                        </div>
                                        <div>
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        </div>
                                        <div class=" form-two-icon4">
                                            <button type="submit" class="form-two-icon4-icon1">ĐĂNG NHẬP</button>
                                            <div class="form-two-icon4-icon2">
                                                <div class="">Quên mật khẩu</div>
                                            </div>
                                        </div>
                                        <div class="form-two-icon5">
                                            <div class="underscore"></div>
                                            <div>HOẶC</div>
                                            <div class="underscore"></div>
                                        </div>
                                        <div class="form-two-icon6">
                                            <div class="form-two-icon6-item1"><i
                                                    class="form-custom fa-brands fa-facebook"></i>
                                                Facebook
                                            </div>
                                            <div class="form-two-icon6-item2">
                                                <a href="/oauth2/authorization/google"> <i
                                                        class="form-custom2 fa-brands fa-google"></i> Login with
                                                    Google</a>
                                            </div>
                                        </div>
                                        <div class="form-two-icon7">
                                            <div class="form-two-icon7-item1">Bạn chưa có tài khoản? </div>
                                            <a class="form-two-icon7-item2" href="/register">Đăng ký</a>
                                        </div>
                                        <div class="form-two-icon8"></div>
                                        <div class="form-two-icon9"></div>
                                    </form>
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