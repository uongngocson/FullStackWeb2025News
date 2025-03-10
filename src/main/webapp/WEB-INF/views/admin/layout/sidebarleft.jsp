<%@page contentType="text/html" pageEncoding="UTF-8" %>


    <div class="sidebar sidebar-style-2" data-background-color="dark">
        <div class="sidebar-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
                <a href="/admin" class="logo">
                    <img src="../../../../resources/assets/user/img/logo/logo-full-blue.png" alt="navbar brand"
                        class="navbar-brand" height="20" />
                </a>
                <div class="nav-toggle">
                    <button class="btn btn-toggle toggle-sidebar">
                        <i class="gg-menu-right"></i>
                    </button>
                    <button class="btn btn-toggle sidenav-toggler">
                        <i class="gg-menu-left"></i>
                    </button>
                </div>
                <button class="topbar-toggler more">
                    <i class="gg-more-vertical-alt"></i>
                </button>
            </div>
            <!-- End Logo Header -->
        </div>
        <div class="sidebar-wrapper scrollbar scrollbar-inner">

            <div class="sidebar-content">
                <ul class="nav nav-secondary">
                    <li class="nav-item">
                        <a href="javascript:void(0);"
                            class="flex items-center justify-between px-4 py-2 text-gray-700 hover:bg-gray-200 transition"
                            onclick="toggleDropdown(event, 'dashboard')">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-home"></i>
                                <p>Dashboard</p>
                            </div>
                            <span class="caret transition-transform transform rotate-0 duration-200"></span>
                        </a>
                        <div id="dashboard" class="hidden block transition-all duration-300 ease-in-out">
                            <ul class="nav nav-collapse pl-6">
                                <li>
                                    <a href="../demo1/index.html" class="block py-2 text-gray-600 hover:text-gray-900">
                                        <span class="sub-item">Dashboard 1</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>




                    <!-- div split  -->
                    <li class="nav-section">
                        <span class="sidebar-mini-icon">
                            <i class="fa fa-ellipsis-h"></i>
                        </span>
                        <h4 class="text-section">Components</h4>
                    </li>
                    <!-- div các thành phần -->

                    <!-- Quản lý sản phẩm -->
                    <li class="nav-item">
                        <a href="javascript:void(0);" onclick="toggleCollapse('sub')">
                            <i class="fas fa-bars"></i>
                            <p>QUẢN LÝ SẢN PHẨM</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="sub">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="javascript:void(0);" onclick="toggleCollapse('subnav1')">
                                        <span class="sub-item">Tổng số sản phẩm</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav1">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="/admin/product/list/all/menstyle">
                                                    <span class="sub-item">Thời trang nam</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Thời Trang Nữ
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Điện Thoại & Phụ Kiện
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Mẹ & Bé
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Thiết Bị Điện Tử
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Nhà Cửa & Đời Sống
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Máy Tính & Laptop
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Sắc Đẹp
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Máy Ảnh & Máy Quay Phim
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Sức Khỏe
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Đồng Hồ
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Giày Dép Nữ
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Giày Dép Nam
                                                    </span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Nhà Sách Online
                                                    </span>
                                                </a>
                                            </li>


                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav2">
                                        <span class="sub-item">Số sản phẩm đang hiển thị</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav2">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav3">
                                        <span class="sub-item">Số sản phẩm đang hết hàng</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav3">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav4">
                                        <span class="sub-item">Số sản phẩm tồn kho</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav4">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav5">
                                        <span class="sub-item">Doanh thu sản phẩm bán ra</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav5">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>



                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav6">
                                        <span class="sub-item">Loại sản phẩm</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav6">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="/admin/product/import">
                                                    <span class="sub-item">Nhập liệu loại SP</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </li>



                    <li class="nav-item">
                        <a href="javascript:void(0);" onclick="toggleCollapsse('forms')">
                            <i class="fas fa-pen-square"></i>
                            <p>QUẢN LÝ KHÁCH HÀNG</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="forms">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/admin/product/list/clients">
                                        <span class="sub-item">Tổng số khách hàng đã đăng ký
                                        </span>
                                    </a>
                                    <a href="forms/forms.html">
                                        <span class="sub-item">Số khách hàng hoạt động gần đây
                                        </span>
                                    </a>
                                    <a href="forms/forms.html">
                                        <span class="sub-item">Số khách hàng mới trong tháng

                                        </span>
                                    </a>
                                    <a href="forms/forms.html">
                                        <span class="sub-item">Khách hàng VIP (mua hàng nhiều nhất)


                                        </span>
                                    </a>
                                    <a href="forms/forms.html">
                                        <span class="sub-item">Tổng số đơn hàng từ khách hàng

                                        </span>
                                    </a>


                                </li>

                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="javascript:void(0);" onclick="toggleCollapsse('tables')">
                            <i class="fas fa-table"></i>
                            <p>QUẢN LÝ ĐƠN HÀNG</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="tables">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="tables/tables.html">
                                        <span class="sub-item">Tổng số đơn hàng</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="tables/datatables.html">
                                        <span class="sub-item">Đơn hàng đang chờ xử lý</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="tables/datatables.html">
                                        <span class="sub-item">Đơn hàng đã giao thành công
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="tables/datatables.html">
                                        <span class="sub-item">Đơn hàng bị hủy

                                        </span>
                                    </a>
                                </li>
                                <li>


                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#maps">
                            <i class="fas fa-map-marker-alt"></i>
                            <p>QUẢN LÝ SHIPPER</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="maps">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="maps/googlemaps.html">
                                        <span class="sub-item">Tổng số shipper đang hoạt động
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="maps/jsvectormap.html">
                                        <span class="sub-item">Số đơn hàng đang giao
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#charts">
                            <i class="far fa-chart-bar"></i>
                            <p>QUẢN LÝ NHÂN VIÊN</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="charts">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="charts/charts.html">
                                        <span class="sub-item">Tổng số nhân viên
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="charts/sparkline.html">
                                        <span class="sub-item">Số nhân viên đang làm việc
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="charts/sparkline.html">
                                        <span class="sub-item">Nhân viên mới tuyển trong tháng

                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="charts/sparkline.html">
                                        <span class="sub-item">Số nhân viên nghỉ phép hôm nay


                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="charts/sparkline.html">
                                        <span class="sub-item">Nhân viên nghỉ việc trong tháng

                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!-- <li class="nav-item">
                    <a href="widgets.html">
                        <i class="fas fa-desktop"></i>
                        <p>QUẢN LÝ TÀI CHÍNH</p>
                        <span class="badge badge-success">4</span>
                    </a>
                </li> -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#chart">
                            <i class="far fa-chart-bar"></i>
                            <p>QUẢN LÝ TÀI CHÍNH</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="chart">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="charts/charts.html">
                                        <span class="sub-item">Tổng doanh thu trong tháng/năm

                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="charts/sparkline.html">
                                        <span class="sub-item">Tổng chi phí hoạt động

                                        </span>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#submenu">
                            <i class="fas fa-bars"></i>
                            <p>QUẢN LÝ TÀI KHOẢN </p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="submenu">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav1">
                                        <span class="sub-item">Đăng ký</span>
                                        <span class="caret"></span>
                                    </a>
                                    <!-- <div class="collapse" id="subnav1">
                                    <ul class="nav nav-collapse subnav">
                                        <li>
                                            <a href="#">
                                                <span class="sub-item">Level 2</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#">
                                                <span class="sub-item">Level 2</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div> -->
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav2">
                                        <span class="sub-item">Đăng nhập</span>
                                        <span class="caret"></span>
                                    </a>
                                    <!-- <div class="collapse" id="subnav2">
                                    <ul class="nav nav-collapse subnav">
                                        <li>
                                            <a href="#">
                                                <span class="sub-item">Level 2</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div> -->
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Forgot password</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Reset password</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Phân quyền</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Profile lock</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#subbh">
                            <i class="fas fa-bars"></i>
                            <p>QUẢN LÝ BẢO HÀNH</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="subbh">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav1">
                                        <span class="sub-item">Level 1</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav1">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav2">
                                        <span class="sub-item">Level 1</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav2">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Level 1</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#sub">
                            <i class="fas fa-bars"></i>
                            <p>Menu Levels</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="sub">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav1">
                                        <span class="sub-item">Level 1</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav1">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a data-bs-toggle="collapse" href="#subnav2">
                                        <span class="sub-item">Level 1</span>
                                        <span class="caret"></span>
                                    </a>
                                    <div class="collapse" id="subnav2">
                                        <ul class="nav nav-collapse subnav">
                                            <li>
                                                <a href="#">
                                                    <span class="sub-item">Level 2</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Level 1</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>


                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const collapseItems = ["sub", "subnav1"]; // Danh sách các ID collapse

                            collapseItems.forEach(id => {
                                let element = document.getElementById(id);
                                if (element) {
                                    // Xóa class "show" mặc định
                                    element.classList.remove("show");

                                    // Nếu trong localStorage có lưu trạng thái mở => thêm class "show"
                                    if (localStorage.getItem(id) === "open") {
                                        element.classList.add("show");
                                    }
                                }
                            });
                        });

                        function toggleCollapse(id) {
                            let element = document.getElementById(id);
                            if (!element) return;

                            let isCollapsed = element.classList.contains("show");

                            if (isCollapsed) {
                                localStorage.removeItem(id); // Nếu đang mở, khi nhấn sẽ đóng
                                element.classList.remove("show");
                            } else {
                                localStorage.setItem(id, "open"); // Nếu đang đóng, khi nhấn sẽ mở
                                element.classList.add("show");
                            }
                        }


                        document.addEventListener("DOMContentLoaded", function () {
                            const collapseItems = ["forms", "tables"]; // Danh sách ID cần lưu trạng thái

                            collapseItems.forEach(id => {
                                let element = document.getElementById(id);
                                if (element) {
                                    // Xóa class "show" mặc định
                                    element.classList.remove("show");

                                    // Nếu trạng thái trong localStorage là "open", mở collapse
                                    if (localStorage.getItem(id) === "open") {
                                        element.classList.add("show");
                                    }
                                }
                            });
                        });

                        function toggleCollapsse(id) {
                            let element = document.getElementById(id);
                            if (!element) return;

                            let isCollapsed = element.classList.contains("show");

                            if (isCollapsed) {
                                localStorage.removeItem(id); // Nếu đang mở, khi nhấn sẽ đóng
                                element.classList.remove("show");
                            } else {
                                localStorage.setItem(id, "open"); // Nếu đang đóng, khi nhấn sẽ mở
                                element.classList.add("show");
                            }
                        }




                        function toggleDropdown(event, id) {
                            event.preventDefault();
                            let dropdown = document.getElementById(id);
                            let caret = event.currentTarget.querySelector('.caret');

                            dropdown.classList.toggle('hidden');
                            dropdown.classList.toggle('!block');
                            caret.classList.toggle('rotate-180');
                        }
                    </script>
                </ul>
            </div>
        </div>
    </div>