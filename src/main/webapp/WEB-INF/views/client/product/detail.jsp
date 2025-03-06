<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Detail</title>
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
        <!-- <link rel="stylesheet" href="../../../resources/css/grid.css">
        <link rel="stylesheet" href="../../../resources/css/style.css"> -->

        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/base.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/style.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/responsive.css">
        <link rel="stylesheet" href="../../../../resources/assets/user/css-user/grid.css">



        <!-- end CSS link of HEADER and FOOTER -->

        <!-- start CSS link of CONTAINER -->
        <link rel="icon" href="./assets/img/logo/shopee-logo.png" type="image/x-icon">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">


        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css">
        <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>

        <!-- Thêm JavaScript -->
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

                <div class="grid wide">

                    <!-- Slider HTML -->
                    <!-- Swiper Container -->





                    <div class="container-formone-box1">
                        <div class="container-formone-box1-list1">
                            <div class="container-formone-box1-list1-item1">
                                <img class="container-formone-box1-list1-item1-img"
                                    src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd43-lu6dg0j3mev31f@resize_w900_nl.webp"></img>
                            </div>
                            <div class="container-formone-box1-list1-item2">

                                <!-- Swiper Container -->
                                <div class="swiper">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 1"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 2"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 3"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 4"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 5"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 6"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 7"></div>
                                        <div class="swiper-slide"><img
                                                src="https://down-vn.img.susercontent.com/file/sg-11134301-7rd6a-lu6dg09y17dd9e@resize_w164_nl.webp"
                                                alt="Hình 8"></div>
                                    </div>

                                    <!-- Nút điều hướng -->

                                    <div class="swiper-button-next"></div>
                                    <div class="swiper-button-prev"></div>

                                </div>

                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {
                                        var swiper = new Swiper('.swiper', {
                                            loop: true, /* Lặp vô tận */
                                            slidesPerView: 5, /* Hiển thị 5 ảnh mỗi lần */
                                            spaceBetween: 10, /* Khoảng cách giữa ảnh */
                                            autoplay: {
                                                delay: 2500, /* Tự động trượt sau 2.5 giây */
                                                disableOnInteraction: false, /* Không dừng khi người dùng tương tác */
                                            },
                                            navigation: {
                                                nextEl: '.swiper-button-next',
                                                prevEl: '.swiper-button-prev',
                                            },
                                        });
                                    });
                                </script>




                                <!-- Swiper Container -->

                            </div>
                            <div class="container-formone-box1-list1-item3">
                                <div class="container-formone-box1-list1-item3-share">
                                    <div class="">Chia sẻ:</div>
                                    <a href=""><i class="fa-brands fa-facebook"></i></a>
                                    <a href=""><i class="fa-brands fa-facebook-messenger"></i></a>
                                    <a href=""><i class="fa-brands fa-google-plus"></i></a>
                                    <a href=""><i class="fa-brands fa-twitter"></i></a>

                                </div>
                                <div class="container-formone-underscore">|</div>


                                <div class="container-formone-box1-list1-item3-like">
                                    <div class="">Đã thích</div>
                                    <div class="">(100)</div>
                                    <i class="item3-like fa-solid fa-heart"></i>
                                </div>



                            </div>

                        </div>
                        <div class="container-formone-box1-list2">
                            <div class="container-formone-box1-list2-title">Giá đỡ máy tính xách tay Giá đỡ máy tính
                                xách tay inch Phụ kiện máy tính bảng đa năng Giá đỡ máy tính xách tay có thể gập lại Đế
                                nâng</div>
                            <div class="container-formone-box1-list2-start">
                                <div class="container-formone-box1-list2-start-item1">
                                    <div class="">3.9</div>
                                    <div class="">⭐⭐⭐⭐⭐</div>
                                </div>
                                <div class="">|</div>

                                <div class="container-formone-box1-list2-start-item1">
                                    <div class="">672</div>
                                    <div class="">Đánh giá</div>
                                </div>
                                <div class="">|</div>
                                <div class="container-formone-box1-list2-start-item1">
                                    <div class="">112,9K</div>
                                    <div class="">Sole</div>
                                </div>



                            </div>
                            <div class="container-formone-box1-list2-cost">
                                <div class="container-formone-box1-list2-cost-sale1">
                                    <img
                                        src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/8eebfcdc539676df4457.svg">
                                    <div class="container-formone-box1-list2-cost-sale1-endsin">
                                        <img
                                            src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/26cb3f2fda38eb6ddcc1.svg">
                                        ENDS IN

                                        <div class="">
                                            33:36:32
                                        </div>

                                    </div>


                                </div>

                                <div class="container-formone-box1-list2-cost-sale2">
                                    <div class="">₫35.200</div>
                                    <div class="container-formone-box1-list2-cost-sale2-font">₫38.280</div>
                                    <div class="container-formone-box1-list2-cost-sale2-font"> -8% </div>
                                </div>


                            </div>
                            <div class="container-formone-box1-list2-discountshop">
                                <div class="">Mã Giảm Giá Của Shop</div>
                                <div class="container-formone-box1-list2-express-item1">
                                    <div class="container-formone-box1-list2-express-item1-discount">Giảm 1k</div>
                                    <div class="container-formone-box1-list2-express-item1-discount">Giảm 1k</div>
                                    <div class="container-formone-box1-list2-express-item1-discount">Giảm 1k</div>

                                </div>
                            </div>
                            <div class="container-formone-box1-list2-express">
                                <div class="container-formone-box1-list2-express-item1">Vận chuyển</div>
                                <div class="container-formone-box1-list2-express-item2"> <img
                                        src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/f1f65ec969d238ed62ff.svg">
                                    Nhận từ 1 Th03 - 3 Th03, phí giao ₫0
                                    Tặng Voucher ₫15.000 nếu đơn giao sau thời gian trên.</div>
                            </div>
                            <div class="container-formone-box1-list20-securiry">
                                <div class="">An tâm mua sắm cùng Shopee</div>
                                <div class="container-formone-box1-list20-securiry-item2"><img src="">Xử lý đơn hàng bởi
                                    DsDmart - Trả hàng miễn phí 15 ngày</div>
                            </div>
                            <div class="container-formone-box1-list20-securiry">
                                <div class="">Loại sản phẩm</div>
                                <div class="container-formone-box1-list20-securiry-item2">Xử lý đơn hàng bởi DsDmart -
                                    Trả hàng miễn phí 15 ngày</div>
                            </div>
                            <div class="container-formone-box1-list20-number">
                                <div class="container-formone-box1-list20-number-item1">Số lương</div>
                                <div class="container-formone-box1-list20-number-item2">
                                    <div class="container-formone-box1-list20-number-item2-con1">-</div>
                                    <div class="container-formone-box1-list20-number-item2-con2">6</div>
                                    <div class="container-formone-box1-list20-number-item2-con2">+</div>
                                </div>
                                <div class="">Còn(12345)</div>
                            </div>
                            <div class="container-formone-box1-list20-pushcart">
                                <div class="container-formone-box1-list20-pushcart-item1"><img
                                        src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/f600cbfffbe02cc144a1.svg">Thêm
                                    vào giỏ hàng</div>
                                <div class="container-formone-box1-list20-pushcart-item2">Mua ngay</div>
                            </div>

                        </div>
                        <div class="container-formone-box1-list3">
                            <div class="container-formone-box1-list3-item1">
                                <img class="container-formone-box1-list3-item1-img"
                                    src="https://down-vn.img.susercontent.com/file/9ce639955c3750991626b4b7c3e08b0a@resize_w160_nl.webp">
                                <div class="container-formone-box1-list3-item1-text">
                                    <div class="container-formone-box1-list3-item1-text1">LINH KIỆN 1984</div>
                                    <div class="container-formone-box1-list3-item1-text2">Online 19 giờ trước</div>
                                    <div class="container-formone-box1-list3-item1-text3">
                                        <div class="container-formone-box1-list3-item1-text3-list1"><img
                                                class="container-formone-box1-list3-item1-text3-list1-cus"
                                                src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/7bf03ed38ca37787fe78.svg">Chat
                                            ngay</div>
                                        <div class="container-formone-box1-list3-item1-text3-list2"><img
                                                class="container-formone-box1-list3-item1-text3-list2-cus"
                                                src="https://deo.shopeemobile.com/shopee/shopee-pcmall-live-sg/productdetailspage/748adc5e75595200c51b.svg">Xem
                                            shop</div>

                                    </div>

                                </div>

                            </div>
                            <div class="container-formone-box1-list3-item2">
                                <div class="container-formone-box1-list3-item2-text1">
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Đánh giá
                                        </div>
                                        <div class="item2-cus2"> 64k
                                        </div>

                                    </div>
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Sản phẩm</div>
                                        <div class="item2-cus2">2,4k</div>

                                    </div>

                                </div>
                                <div class="container-formone-box1-list3-item2-text1">
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Đánh giá
                                        </div>
                                        <div class="item2-cus2"> 64k
                                        </div>

                                    </div>
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Sản phẩm</div>
                                        <div class="item2-cus2">2,4k</div>

                                    </div>

                                </div>
                                <div class="container-formone-box1-list3-item2-text1">
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Đánh giá
                                        </div>
                                        <div class="item2-cus2"> 64k
                                        </div>

                                    </div>
                                    <div class="container-formone-box1-list3-item2-cus">
                                        <div class="item2-cus1">Sản phẩm</div>
                                        <div class="item2-cus2">2,4k</div>

                                    </div>

                                </div>

                            </div>
                        </div>

                        <div class="container-formone-box1-list4">
                            <div class="container-formone-box1-list4-item1">
                                <div class="container-formone-box1-list4-item1-text1">CHI TIẾT SẢN PHẨM
                                </div>
                                <div class="container-formone-box1-list4-item1-text2">

                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>
                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>
                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>
                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>
                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>
                                    <div class="container-formone-box1-list4-item1-text2-cus">
                                        <div class="text-cus-category-1">Danh Mục</div>
                                        <div class="text-cus-category-2">Danh Mục</div>

                                    </div>


                                </div>

                            </div>
                            <div class="container-formone-box1-list4-item2">
                                <div class="container-formone-box1-list4-item2-des">MÔ TẢ SẢN PHẨM
                                </div>
                                <div class="container-formone-box1-list4-item2-text">Giá đỡ Laptop , Giá kê MacBook ,
                                    Ultrabook chất liệu bằng nhôm điều chỉnh
                                    độ cao , chống mỏi cổ, dễ gấp gọn



                                    * Do ánh sáng khi chụp nên sản phẩm thực tế sẽ có đôi chút khác màu so với ảnh mình
                                    chụp , mong các bạn thông cảm ( sản phẩm thực tế màu sẽ sáng hơn nhiều

                                    * - CAM KẾT KHÔNG BỊ BẬP BÊNH, RUNG LẮC KHI SỬ DỤNG.

                                    - SẢN PHẨM ĐI KÈM TÚI ĐỰNG NHƯNG CHẤT LIỆU TÚI VÀ MÀU SẮC SẼ TÙY ĐỢT HÀNG NHÉ.

                                    THÔNG TIN SẢN PHẨM

                                    🔹 Chất liệu: Hợp kim nhôm được sơn tĩnh điện

                                    🔹 Kích thước: 230mmx180mmx55-(độ mở rộng 155mm)

                                    🔹 Cân nặng : 230g

                                    🔹 Sản phẩm bao gồm : 1 giá đỡ hợp kim, 1 túi rút bỏ cặp không làm trầy laptop

                                    🔹🔹🔹 TÍNH NĂNG CAO CẤP :



                                    🔹 Sản phẩm có chất liệu nhôm nguyên khối, được gia công tinh tế, chắc chắn đảm bảo
                                    laptop, macbook cố định chắc chắn, không bị rung lắc.



                                    🔹 Đáy chắc chắn với Đế Silicon chống trượt để đặt ổn định và không làm trầy bàn làm
                                    việc



                                    🔹 Viền Silicon chống trượt xung quanh rãnh để chống trầy xước
                                    Laptop/Macbook/Ipad/Surface/Wacom/Tablet của bạn



                                    🔹 Có 6 cấp độ điều chỉnh độ cao, phù hơp mọi tư thế sử dụng làm việc và giải trí



                                    🔹 Thoải mái chơi game không lo bị nóng máy. Mặt đáy thông thoáng tăng hiệu quả tản
                                    nhiệt !



                                    🔹 Tạo cho người dùng dáng ngồi thẳng, chống mỏi lưng, mỏi cổ, hạn chế các bệnh lý
                                    khi làm việc quá nhiều với máy tính.



                                    🔹 Hạn chế được các các bệnh liên quan đến lưng cột sống và đốt sống cổ,



                                    🔹 Túi đi kèm chống bẩn và chống nước, không làm trầy laptop



                                    🔹 Dễ dàng điều chỉnh và xếp gọn mang đi, tháo lắp nhanh chóng



                                    #giadolaptop#giakelaptop#giadomacbook#giadolaptopbangnhom

                                    #linhkien1984</div>

                            </div>

                        </div>
                        <div class="container-formone-box1-list5">
                            <div class="container-formone-box1-list5-item1">
                                ĐÁNH GIÁ SẢN PHẨM

                            </div>
                            <div class="container-formone-box1-list5-item2">
                                <div class="rating-container">
                                    <div class="rating-summary">
                                        <div class="score">
                                            <span class="score-value">4.7 OUT OF 5</span>
                                            <div class="stars">★★★★★</div>
                                        </div>
                                        <div class="filters">
                                            <button class="active">All</button>
                                            <button>5 Star (3,8k)</button>
                                            <button>4 Star (1,8k)</button>
                                            <button>3 Star (51)</button>
                                            <button>2 Star (34)</button>
                                            <button>1 Star (100)</button>
                                            <button>With Comments (249)</button>
                                            <button>With Media (147)</button>
                                            <button>Local Review (1,7k)</button>
                                        </div>
                                    </div>
                                    <div class="review">
                                        <div class="user-avatar"></div>
                                        <div class="review-content">
                                            <div class="user-info">
                                                <strong>ini2024</strong>
                                                <span class="stars">★★★★★ Similar Product Review
                                                </span>
                                            </div>
                                            <div class="review-meta">2024-12-15 19:09 | Variation: Đen</div>
                                            <div class="review-text">
                                                <p><strong>Chất lượng sản phẩm:</strong> <span class="highlight">sản
                                                        phẩm tuyệt vời</span></p>
                                                <p>sản phẩm có chất lượng cao và như mô tả. giá cả cũng tốt. rất khuyến
                                                    khích</p>
                                            </div>
                                            <div class="review-images">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                            </div>
                                            <div class="like-button">👍 5</div>
                                        </div>
                                    </div>
                                    <div class="review">
                                        <div class="user-avatar"></div>
                                        <div class="review-content">
                                            <div class="user-info">
                                                <strong>ini2024</strong>
                                                <span class="stars">★★★★★</span>
                                            </div>
                                            <div class="review-meta">2024-12-15 19:09 | Variation: Đen</div>
                                            <div class="review-text">
                                                <p><strong>Chất lượng sản phẩm:</strong> <span class="highlight">sản
                                                        phẩm tuyệt vời</span></p>
                                                <p>Vì mỗi lần dùng đều phải cúi người đau lưng nên đã quyết định múc em
                                                    này. Nhìn ảnh mình tưởng làm từ kim loại nhưng mà hoá ra là nhựa.
                                                    Được cái chắc chắn, dễ dùng.
                                                    Bây giờ dùng máy tính thoải mái hơn hẳn mà còn có túi đựng kèm theo,
                                                    gấp gọn gàng dễ đem theo người.
                                                    Buồn nỗi hôm trc chốt đơn 100k thì hum sau sale có 3 mấy thui 🥹
                                                    Vì mỗi lần dùng đều phải cúi người đau lưng nên đã quyết định múc em
                                                    này. Nhìn ảnh mình tưởng làm từ kim loại nhưng mà hoá ra là nhựa.
                                                    Được cái chắc chắn, dễ dùng.
                                                    Bây giờ dùng máy tính thoải mái hơn hẳn mà còn có túi đựng kèm theo,
                                                    gấp gọn gàng dễ đem theo người.
                                                    Buồn nỗi hôm trc chốt đơn 100k thì hum sau sale có 3 mấy thui 🥹</p>
                                            </div>
                                            <div class="review-images">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                            </div>
                                            <div class="like-button">👍 5</div>
                                        </div>
                                    </div>
                                    <div class="review">
                                        <div class="user-avatar"></div>
                                        <div class="review-content">
                                            <div class="user-info">
                                                <strong>ini2024</strong>
                                                <span class="stars">★★★★★</span>
                                            </div>
                                            <div class="review-meta">2024-12-15 19:09 | Variation: Đen</div>
                                            <div class="review-text">
                                                <p><strong>Chất lượng sản phẩm:</strong> <span class="highlight">sản
                                                        phẩm tuyệt vời</span></p>
                                                <p>Vì mỗi lần dùng đều phải cúi người đau lưng nên đã quyết định múc em
                                                    này. Nhìn ảnh mình tưởng làm từ kim loại nhưng mà hoá ra là nhựa.
                                                    Được cái chắc chắn, dễ dùng.
                                                    Bây giờ dùng máy tính thoải mái hơn hẳn mà còn có túi đựng kèm theo,
                                                    gấp gọn gàng dễ đem theo người.
                                                    Buồn nỗi hôm trc chốt đơn 100k thì hum sau sale có 3 mấy thui 🥹
                                                    Vì mỗi lần dùng đều phải cúi người đau lưng nên đã quyết định múc em
                                                    này. Nhìn ảnh mình tưởng làm từ kim loại nhưng mà hoá ra là nhựa.
                                                    Được cái chắc chắn, dễ dùng.
                                                    Bây giờ dùng máy tính thoải mái hơn hẳn mà còn có túi đựng kèm theo,
                                                    gấp gọn gàng dễ đem theo người.
                                                    Buồn nỗi hôm trc chốt đơn 100k thì hum sau sale có 3 mấy thui 🥹</p>
                                            </div>
                                            <div class="review-images">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                            </div>
                                            <div class="like-button">👍 5</div>
                                        </div>
                                    </div>
                                    <div class="review">
                                        <div class="user-avatar"></div>
                                        <div class="review-content">
                                            <div class="user-info">
                                                <strong>ini2024</strong>
                                                <span class="stars">★★★★★</span>
                                            </div>
                                            <div class="review-meta">2024-12-15 19:09 | Variation: Đen</div>
                                            <div class="review-text">
                                                <p><strong>Chất lượng sản phẩm:</strong> <span class="highlight">sản
                                                        phẩm tuyệt vời</span></p>
                                                <p>Vì mau sale có 3 mấy thui Vì mau sale có 3 mấy thuiVì mau sale có 3
                                                    mấy thuiVì mau sale có 3 mấy thui 🥹</p>
                                            </div>
                                            <div class="review-images">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                                <img src="https://down-vn.img.susercontent.com/file/vn-11134103-7ras8-m3t2phxy4iawdb@resize_w144_nl.webp"
                                                    alt="Review Image">
                                            </div>
                                            <div class="like-button">👍 5</div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- start footer -->
            <jsp:include page="../layout/footer.jsp" />
            <!-- end footer -->


        </div>

        <!-- start Js of CONTAINER-->
        <script src="../../../resources/assets/js/product.js"></script>
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
        <!-- end Js of HEADER and FOOTER -->
    </body>

    </html>