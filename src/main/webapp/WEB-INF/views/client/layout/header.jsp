<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Alpha Mart</title>
                <!-- Fav-Icon link -->
                <link rel="shortcut icon" href="Images/favicon-16x16.webp" type="image/x-icon">
                <!-- Font-Awesome link -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
                    integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
                    crossorigin="anonymous" referrerpolicy="no-referrer" />
                <!-- Bootstrap link -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
                    integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd"
                    crossorigin="anonymous">
                <!-- Swiper link -->
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
                <!-- CSS link -->

                <link rel="stylesheet" href="../../../../resources/css/test.css">
                <link rel="stylesheet" href="../../../resources/css/grid.css">
                <link rel="stylesheet" href="../../../resources/css/style.css">
                <link rel="stylesheet" href="../../../resources/assets/css/base.css">
                <link rel="stylesheet" href="../../../resources/assets/css/style.css">
                <link rel="stylesheet" href="../../../resources/assets/css/grid.css">
                <link rel="stylesheet" href="../../../resources/assets/css/responsive.css">

            </head>

            <header class="header">

                <!-- Thanh điều hướng -->

                <div class="navbar">

                    <!-- Hình ảnh logo -->

                    <div class="outer-img-box">
                        <!-- Menu di động -->
                        <i class="bi bi-list" id="menu-for-mobile"></i>
                        <a href=""><img src="../../../../resources/assets/user/img/home/walmart-logo.webp"
                                alt="Logo DsDMart" class="nav-logo"></a>
                    </div>

                    <!-- Chọn khu vực -->

                    <div class="nav-select">
                        <img src="../../../../resources/assets/user/img/home/nav-select-item.webp" alt="hình ảnh"
                            class="sel-item-img">
                        <div class="nav-select-content">
                            <p id="select-p1">Bạn muốn nhận hàng như thế nào?</p>
                            <p id="select-p2"> Sacramento, 95829 • Sacramento Supas</p>
                        </div>
                        <i class="bi bi-caret-down"></i>
                    </div>

                    <!-- Ô tìm kiếm -->

                    <div class="nav-search">
                        <input type="text" placeholder="Tìm kiếm mọi thứ tại Walmart trực tuyến và trong cửa hàng"
                            class="nav-search-input">
                        <input type="text" placeholder="Tìm kiếm DsDMart" class="nav-search-input-2">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>

                    <!-- Danh sách yêu thích -->

                    <div class="nav-rec">
                        <i class="fa-regular fa-heart"></i>
                        <div class="nav-rec-cont">
                            <p class="rec-p1">Đặt lại hàng</p>
                            <p class="rec-p2">Sản phẩm của tôi</p>
                        </div>
                    </div>

                    <!-- Đăng nhập -->

                    <div class="nav-rec">
                        <i class="fa-regular fa-user"></i>
                        <c:if test="${empty pageContext.request.userPrincipal}">
                            <a class="nav-rec-cont" href="/logout">
                                <p class="rec-p1">LOGIN</p>
                            </a>
                        </c:if>
                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <a class="nav-rec-cont">
                                <form method="post" action="/logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="rec-p1">
                                        LOGOUT
                                    </button>
                                </form>
                            </a>
                        </c:if>
                    </div>

                    <!-- Giỏ hàng -->

                    <div class="nav-cart">
                        <div class="cart-item-count">
                            <i class="fa-solid fa-cart-shopping">
                                <span class="cart-count">0</span>
                            </i>
                        </div>
                        <p>$0.00</p>
                    </div>

                </div>

                <!-- Bảng điều khiển -->

                <div class="panel-content">

                    <!-- Chọn khu vực trên di động -->
                    <div class="nav-select-mobile">
                        <img src="../../../../resources/assets/user/img/home/nav-select-item.webp" alt="hình ảnh"
                            class="sel-item-img">
                        <div class="nav-select-content">
                            <p id="select-p1">Bạn muốn nhận hàng như thế nào?</p>
                        </div>
                        <div class="panel-line-mob"></div>
                        <p>89765</p>
                        <i class="bi bi-caret-down"></i>
                    </div>

                    <!-- Danh mục -->
                    <div class="panel-dep">
                        <div class="panel-dep-box1">
                            <img src="../../../../resources/assets/user/img/home/depart-img.webp" alt="Danh mục">
                            <p>Danh Mục </p>
                            <i class="bi bi-caret-down"></i>

                        </div>
                        <div class="panel-dep-box2">
                            <a href="/product/item">Thời Trang Nam</a>
                            <a href="#">Thời Trang Nữ</a>
                            <a href="#">Điện Thoại & Phụ Kiện</a>
                            <a href="#">Mẹ & Bé</a>
                            <a href="#">Thiết Bị Điện Tử</a>
                            <a href="#">Nhà Cửa & Đời Sống</a>
                            <a href="#">Máy Tính & Laptop</a>
                            <a href="#">Sắc Đẹp</a>
                            <a href="#">Máy Ảnh & Máy Quay Phim</a>
                            <a href="#">Sức Khỏe</a>
                            <a href="#">Đồng Hồ</a>
                            <a href="#">Giày Dép Nữ</a>
                            <a href="#">Giày Dép Nam</a>
                            <a href="#">Túi Ví Nữ</a>
                            <a href="#">Thiết Bị Điện Gia Dụng</a>
                            <a href="#">Phụ Kiện & Trang Sức Nữ</a>
                            <a href="#">Thể Thao & Du Lịch</a>
                            <a href="#">Bách Hóa Online</a>
                            <a href="#">Ô Tô & Xe Máy & Xe Đạp</a>
                            <a href="#">Nhà Sách Online</a>
                            <a href="#">Balo & Túi Ví Nam</a>

                        </div>
                    </div>

                    <!-- Dịch vụ -->
                    <div class="panel-ser">
                        <img src="../../../../resources/assets/user/img/home/service-img.webp" alt="Dịch vụ">
                        <p>Dịch vụ</p>
                        <i class="bi bi-caret-down"></i>
                    </div>

                    <!-- Ngăn cách -->
                    <div class="panel-line"></div>

                    <!-- Liên kết danh mục -->
                    <div class="panel-links">
                        <a href="#">Tiết kiệm mùa hè</a>
                        <a href="#">Thực phẩm & Nhu yếu phẩm</a>
                        <a href="#">Mua sắm mùa hè</a>
                        <a href="#">Trở lại trường học</a>
                        <a href="#">Nhà cửa</a>
                        <a href="#">Điện tử</a>
                        <a href="#">Thời trang</a>
                        <a href="#">Em bé</a>
                        <a href="#">Đồ chơi</a>
                        <a href="#">Đăng ký</a>
                        <a href="#">Thẻ ghi nợ ONE</a>
                        <a href="#">Walmart+</a>
                    </div>
                </div>
            </header>