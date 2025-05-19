<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- Sidebar -->
    <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="dark">
                <a href="/employee/dashboard/index" class="logo">
                    <img src="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico" alt="navbar brand"
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

                    <!-- Product Management -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#products">
                            <i class="fas fa-th"></i>
                            <p>Product Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="products">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/product-mgr/list">
                                        <span class="sub-item">Product List</span>
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </li>

                    <!-- Order Management -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#orders">
                            <i class="fas fa-shopping-cart"></i>
                            <p>Order Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="orders">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/order-mgr/list">
                                        <span class="sub-item">Order List</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Shipping Status</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="sub-item">Shipper List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                    <!-- Receipt Management -->
                    <li class="nav-item">
                        <a data-bs-toggle="collapse" href="#receipts">
                            <i class="fas fa-th"></i>
                            <p>Receipt Management</p>
                            <span class="caret"></span>
                        </a>
                        <div class="collapse" id="receipts">
                            <ul class="nav nav-collapse">
                                <li>
                                    <a href="/employee/inventory-mgr/list">
                                        <span class="sub-item">Inventory</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="/employee/receipt-mgr/list">
                                        <span class="sub-item">Receipt List</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>

                </ul>
            </div>
        </div>
    </div>
    <!-- End Sidebar -->