<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Item</title>
        <!-- start CSS link of HEADER and FOOTER -->
        <!-- Fav-Icon link -->
        <link rel="shortcut icon" href="Images/favicon-16x16.webp" type="image/x-icon">
        <!-- Font-Awesome link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
            integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
            crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Bootstrap link -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
            integrity="sha384-4LISF5TTJX/fLmGSxO53rV4miRxdg84mZsxmO8Rx5jGtp/LbrixFETvWa5a6sESd" crossorigin="anonymous">
        <!-- Swiper link -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
        <!-- CSS link -->
        <link rel="stylesheet" href="../../../resources/css/test.css">

        <!-- start CSS link of CONTAINER -->
        <link rel="icon" href="./assets/img/logo/shopee-logo.png" type="image/x-icon">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">

        <!-- CSS LINK OF ITEM -->
        <link rel="stylesheet" href="../../../../resources/css/test.css">
        <!-- <link rel="stylesheet" href="../../../resources/css/grid.css">
        <link rel="stylesheet" href="../../../resources/css/style.css"> -->

        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/base.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/style.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/responsive.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/grid.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- end CSS link of CONTAINER -->

    </head>

    <body>

        <div class="app">
            <!-- start header -->
            <jsp:include page="../layout/header.jsp" />
            <!-- end header -->

            <!-- start container -->

            <div class="container">
                <ul class="header__sort-bar">
                    <li class="header__sort-item">
                        <a href="#" class="header__sort-link">Liên quan</a>
                    </li>
                    <li class="header__sort-item header__sort-item--active">
                        <a href="#" class="header__sort-link">Mới nhất</a>
                    </li>
                    <li class="header__sort-item">
                        <a href="#" class="header__sort-link">Bán chạy</a>
                    </li>
                    <li class="header__sort-item">
                        <a href="#" class="header__sort-link">Giá</a>
                    </li>
                </ul>
                <div class="grid wide">
                    <div class="row sm-gutter">
                        <div class="col l-2 m-0 c-0">
                            <!-- category -->
                            <nav class="category">
                                <h3 class="category-heading">
                                    <i class="category-heading-icon fas fa-list-ul"></i>
                                    Bộ lọc tìm kiếm
                                </h3>
                                <div class="category-group">
                                    <div class="category-group-title">Theo Danh Mục</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Thiết bị mạng
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Chuột và bàn phím
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            USB
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Link kiện máy tính
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Wifi
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Nơi Bán</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Hà Nội
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Hồ Chí Minh
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Đà Nẵng
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Đơn Vị Vận Chuyển</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Hoả tốc
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Nhanh
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Tiết kiệm
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Thương Hiệu</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Kingston
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Sandisk
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Seagate
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Khoảng Giá</div>
                                    <div class="category-group-filter">
                                        <input type="number" placeholder="đ TỪ" class="category-group-filter-input">
                                        <i class="fas fa-arrow-right"></i>
                                        <input type="number" placeholder="đ ĐẾN" class="category-group-filter-input">
                                    </div>
                                    <button class="btn btn--primary category-group-filter-btn">Áp dụng</button>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Loại Shop</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            DSDMART
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            DSDMART Mail
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Shop yêu thích
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Tình Trạng</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Mới
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Đã sử dụng
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Lựa Chọn Thanh Toán</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Thanh toán khi nhận hàng
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Chuyển khoản
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Trả góp 0%
                                        </li>
                                    </ul>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Đánh Giá</div>
                                    <div class="rating-star">
                                        <input type="checkbox" class="category-group-item-check">
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                    </div>
                                    <div class="rating-star">
                                        <input type="checkbox" class="category-group-item-check">
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                    </div>
                                    <div class="rating-star">
                                        <input type="checkbox" class="category-group-item-check">
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                    </div>
                                    <div class="rating-star">
                                        <input type="checkbox" class="category-group-item-check">
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                    </div>
                                    <div class="rating-star">
                                        <input type="checkbox" class="category-group-item-check">
                                        <i class="star-checked far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                        <i class="star-uncheck far fa-star"></i>
                                    </div>
                                </div>
                                <div class="category-group">
                                    <div class="category-group-title">Dịch Vụ & Khuyến Mãi</div>
                                    <ul class="category-group-list">
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Freeship Xtra
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Hoàn xu Xtra
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Đang giảm giá
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Miễn phí vận chuyển
                                        </li>
                                        <li class="category-group-item">
                                            <input type="checkbox" class="category-group-item-check">
                                            Gì cũng rẻ
                                        </li>
                                    </ul>
                                </div>
                                <button class="btn btn--primary category-group-filter-btn category-group--margin">LÀM
                                    MỚI</button>
                            </nav>
                        </div>
                        <div class="col l-10 m-12 c-12">
                            <!-- home filter -->
                            <div class="home-filter hide-on-mobile-tablet">
                                <div class="home-filter-control">
                                    <p class="home-filter-title">Sắp xếp theo</p>
                                    <button class="btn btn--primary home-filter-btn">Phổ biến</button>
                                    <button class="btn home-filter-btn">Mới nhất</button>
                                    <button class="btn home-filter-btn">Bán chạy</button>
                                    <div class="btn home-filter-sort">
                                        <p class="home-filter-sort-btn">Giá</p>
                                        <i class="fas fa-sort-amount-down-alt"></i>
                                        <ul class="home-filter-sort-list">
                                            <li>
                                                <a href="#" class="home-filter-sort-item-link">
                                                    Giảm dần
                                                    <i class="fas fa-sort-amount-down-alt"></i>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="home-filter-sort-item-link">
                                                    Tăng dần
                                                    <i class="fas fa-sort-amount-up-alt"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="home-filter-page">
                                    <div class="home-filter-page-number">
                                        <p class="home-filter-page-now">1</p>
                                        /14
                                    </div>
                                    <div class="home-filter-page-control">
                                        <a href="#" class="home-filter-page-btn home-filter-page-btn--disable">
                                            <i class="fas fa-angle-left"></i>
                                        </a>
                                        <a href="#" class="home-filter-page-btn">
                                            <i class="fas fa-angle-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!-- home product -->
                            <div class="home-product">
                                <nav class="mobile-category">
                                    <ul class="mobile-category-list">
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Thiết bị mạng</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Chuột và bàn phím</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">USB</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Link kiện máy tính</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Wifi</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Ổ cứng</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">CD/DVD</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Tai nghe</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Lót chuột</a>
                                        </li>
                                        <li class="mobile-category-item">
                                            <a href="#" class="mobile-category-item-link">Micro</a>
                                        </li>
                                    </ul>
                                </nav>
                                <div id="list-product" class="row sm-gutter"></div>
                                <!-- <div id="list-product" class="row sm-gutter">
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/1.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/2.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">300.000đ</p>
                                                <p class="home-product-item__price-new">250.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,2k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/3.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">150.000đ</p>
                                                <p class="home-product-item__price-new">180.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,7k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">30%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/4.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">350.000đ</p>
                                                <p class="home-product-item__price-new">400.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 2,7k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                            <div class="home-product-item__sale-off-value">20%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/5.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">270.000đ</p>
                                                <p class="home-product-item__price-new">300.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,2k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">20%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/6.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">160.000đ</p>
                                                <p class="home-product-item__price-new">220.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 2,3k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">25%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/7.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">195.000đ</p>
                                                <p class="home-product-item__price-new">250.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">15%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/8.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">360.000đ</p>
                                                <p class="home-product-item__price-new">420.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,9k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">20%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/9.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">130.000đ</p>
                                                <p class="home-product-item__price-new">170.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">50%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/10.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/11.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/12.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/13.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/14.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/15.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/16.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Ổ đĩa flash USB2.0 2TB Hp kim loại chống thấm nước</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">180.000đ</p>
                                                <p class="home-product-item__price-new">200.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,8k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">40%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/17.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Jack BNC lò xo cho dây tín hiệu đồng trục camera</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">170.000đ</p>
                                                <p class="home-product-item__price-new">210.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">30%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/18.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Pin TCbest AA và AAA cho chuột không dây và điều khiển giao ngẫu nhiên</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">50.000đ</p>
                                                <p class="home-product-item__price-new">70.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 5,6k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">10%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/19.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Màn Hình Máy Tính 24 inch/19inch AOC,Màn Hình 75HZ Full HD 1920*1080</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">2.100.000đ</p>
                                                <p class="home-product-item__price-new">3.000.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">36%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/20.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Webcam Máy Tính-Latop-Có Mic Full HD-Camera</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">350.000đ</p>
                                                <p class="home-product-item__price-new">400.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 2,7k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">20%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/21.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Loa máy tính để bàn,loa vi tính MC D - 221 SUPER BASS</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">270.000đ</p>
                                                <p class="home-product-item__price-new">300.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,2k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">25%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/22.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Loa SIÊU TRẦM (SUB BASS): 8W, cường độ âm thanh >80dB</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">160.000đ</p>
                                                <p class="home-product-item__price-new">185.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 2,3k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">23%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/23.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Bàn Phím Gaming Có Led 7 Màu-Bàn Phím G21 Kèm Chuột-Lót Chuột</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">195.000đ</p>
                                                <p class="home-product-item__price-new">230.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">15%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/24.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">Bàn phím Gaming, Keyboard T-WOLF TF20 Led 7 màu USB</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">360.000đ</p>
                                                <p class="home-product-item__price-new">420.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 1,9k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">20%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                                <div class="col l-2-4 m-3 c-6 home-product-item">
                                    <a class="home-product-item-link" href="#">
                                        <div class="home-product-item__img" style="background-image: url(./assets/img/home/25.PNG);"></div>
                                        <div class="home-product-item__info">
                                            <h4 class="home-product-item__name">CHUỘT KHÔNG DÂY T- WOLF Q13 CHUỘT GAMING</h4>
                                            <div class="home-product-item__price">
                                                <p class="home-product-item__price-old">135.000đ</p>
                                                <p class="home-product-item__price-new">170.000đ</p>
                                                <i class="home-product-item__ship fas fa-shipping-fast"></i>
                                            </div>
                                            <div class="home-product-item__footer">
                                                <div class="home-product-item__save">
                                                    <input type="checkbox" name="save-check" id="heart-save">
                                                    <label for="heart-save" class="far fa-heart"></label>
                                                </div>
                                                <div class="home-product-item__rating-star">
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                    <i class="star-checked far fa-star"></i>
                                                </div>
                                                <div class="home-product-item__saled">Đã bán 3,1k</div>
                                            </div>
                                            <div class="home-product-item__origin">Hà Nội</div>
                                            <div class="home-product-item__favourite">
                                                Yêu thích
                                            </div>
                                            <div class="home-product-item__sale-off">
                                                <div class="home-product-item__sale-off-value">50%</div>
                                                <div class="home-product-item__sale-off-label">GIẢM</div>
                                            </div>
                                        </div>
                                        <div class="home-product-item-footer">Tìm sản phẩm tương tự</div>
                                    </a>
                                </div>
                            </div> -->
                            </div>
                            <!-- pagination -->
                            <ul class="pagination home-product-pagination">
                                <li class="pagination-item">
                                    <a href="#" class="pagination-item-link pagination-item-link--disable">
                                        <i class="fas fa-chevron-left"></i>
                                    </a>
                                </li>
                                <li class="pagination-item pagination-item--active">
                                    <a href="#" class="pagination-item-link">1</a>
                                </li>
                                <li class="pagination-item">
                                    <a href="#" class="pagination-item-link">2</a>
                                </li>
                                <li class="pagination-item">
                                    <a href="#" class="pagination-item-link">3</a>
                                </li>
                                <li class="pagination-item">
                                    <a class="pagination-item-link pagination-item-link--disable">. . .</a>
                                </li>
                                <li class="pagination-item">
                                    <a href="#" class="pagination-item-link">8</a>
                                </li>
                                <li class="pagination-item">
                                    <a href="#" class="pagination-item-link">
                                        <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end container -->

            <!-- start footer -->
            <jsp:include page="../layout/footer.jsp" />
            <!-- end footer -->
        </div>

        <!-- start Js of CONTAINER-->
        <!-- end Js of CONTAINER-->

        <!-- start Js of HEADER and FOOTER -->
        <!-- swipper Js  -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

        <!-- Gsap cdn -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"
            integrity="sha512-7eHRwcbYkK4d9g/6tD/mhkf++eoTHwpNM9woBxtPUBWm67zeAfFC+HrdoE2GanKeocly/VxeLvIqwvCdk7qScg=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

        <!-- Script link -->
        <script src="../../../../resources/assets/user/js/script.js"></script>
        <script src="../../../../resources/assets/user/js/product.js"></script>

        <!-- end Js of HEADER and FOOTER -->
    </body>

    </html>