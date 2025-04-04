<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Create Product</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />

                <!-- Fonts and icons -->
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <script>
                    WebFont.load({
                        google: { families: ["Public Sans:300,400,500,600,700"] },
                        custom: {
                            families: [
                                "Font Awesome 5 Solid",
                                "Font Awesome 5 Regular",
                                "Font Awesome 5 Brands",
                                "simple-line-icons",
                            ],
                            urls: ["../../../../resources/assets/dashboard/css/fonts.min.css"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <!-- CSS Files -->
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
            </head>

            <body>
                <div class="wrapper">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End Sidebar -->

                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />

                        <div class="container">
                            <div class="page-inner">

                                <!-- Page header-->
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${shop.shopId != null ? 'Edit' : 'Create'} Shop</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="#"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/product-mgr/list">Shops</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${shop.shopId != null ? 'Edit' : 'Create'}</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- End Page header-->

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">${shop.shopId != null ? 'Update Shop' : 'Create
                                                    New Shop'}</div>
                                            </div>
                                            <form:form action="/shop-mgr/save" method="post" modelAttribute="shop">
                                                <div class="card-body">
                                                    <c:if test="${not empty shop.shopId}">
                                                        <form:hidden path="shopId" />
                                                    </c:if>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="shopName">Shop Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="shopName" type="text"
                                                                    class="form-control" id="shopName"
                                                                    placeholder="Enter shop name" required="true" />
                                                                <form:errors path="shopName" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="contactPerson">Contact Person <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="contactPerson" type="text"
                                                                    class="form-control" id="contactPerson"
                                                                    placeholder="Enter contact person"
                                                                    required="true" />
                                                                <form:errors path="contactPerson"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="shopAddress">Shop Address <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="shopAddress" type="text" class="form-control"
                                                            id="shopAddress" placeholder="Enter shop address"
                                                            required="true" />
                                                        <form:errors path="shopAddress" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="shopDescription">Description <span
                                                                class="text-danger">*</span></label>
                                                        <form:textarea path="shopDescription" class="form-control"
                                                            id="shopDescription" rows="5"
                                                            placeholder="Enter shop description" required="true" />
                                                        <form:errors path="shopDescription" cssClass="text-danger" />
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="operatingHours">Operating Hours <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="operatingHours" type="text"
                                                            class="form-control" id="operatingHours"
                                                            placeholder="Enter operating hours (e.g., 9:00 AM - 5:00 PM)"
                                                            required="true" />
                                                        <form:errors path="operatingHours" cssClass="text-danger" />
                                                    </div>
                                                </div>
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${shop.shopId != null
                                                        ? 'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary">Reset</button>
                                                    <a href="/shop-mgr/list" class="btn btn-danger">Cancel</a>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Footer -->
                        <jsp:include page="../layout/footer.jsp" />
                        <!-- End Footer -->
                    </div>
                </div>

                <!-- Core JS Files -->
                <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Sweet Alert -->
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>
            </body>

            </html>