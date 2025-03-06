<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
                <a href="../index.html" class="logo">
                    <img src="../../../../resources/assets/dashboard/img/kaiadmin/logo_light.svg" alt="navbar brand"
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

                    <!-- start nav charts -->
                    <li class="nav-item">
                        <a href="#">
                            <i class="far fa-chart-bar"></i>
                            <p>Charts</p>
                        </a>
                    </li>
                    <!-- end nav charts -->

                    <!-- start nav users -->
                    <li class="nav-item">
                        <a href="/admin/user">
                            <i class="fas fa-users"></i>
                            <p>Users</p>
                        </a>
                    </li>
                    <!-- end nav users-->

                    <!-- start nav products-->
                    <li class="nav-item">
                        <a href="/admin/product">
                            <i class="fas fa-box"></i>
                            <p>Products</p>
                        </a>
                    </li>
                    <!-- end nav products-->

                </ul>
            </div>
        </div>
    </div>