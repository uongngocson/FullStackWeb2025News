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
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Create Product</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="#"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/product-mgr/">Products</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">Create Product</a></li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">Product Information</div>
                                            </div>
                                            <form:form modelAttribute="product" action="create" method="POST">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <!-- Product Name -->
                                                            <div class="form-group">
                                                                <label for="productName">Product Name</label>
                                                                <form:input type="text" class="form-control"
                                                                    id="productName" path="productName"
                                                                    placeholder="Enter product name" required="true" />
                                                                <form:errors path="productName"
                                                                    cssClass="text-danger" />
                                                            </div>

                                                            <!-- Shop Selection -->
                                                            <div class="form-group">
                                                                <label for="shopId">Shop</label>
                                                                <form:select class="form-select" id="shopId"
                                                                    path="shop.shopId">
                                                                    <form:options items="${shops}" itemValue="shopId"
                                                                        itemLabel="shopName" />
                                                                </form:select>
                                                                <form:errors path="shop.shopId"
                                                                    cssClass="text-danger" />
                                                            </div>

                                                            <!-- Category Selection -->
                                                            <div class="form-group">
                                                                <label for="categoryId">Category</label>
                                                                <form:select class="form-select" id="categoryId"
                                                                    path="category.categoryId">
                                                                    <form:options items="${categories}"
                                                                        itemValue="categoryId"
                                                                        itemLabel="categoryName" />
                                                                </form:select>
                                                                <form:errors path="category.categoryId"
                                                                    cssClass="text-danger" />
                                                            </div>

                                                            <!-- Brand Selection -->
                                                            <div class="form-group">
                                                                <label for="brandId">Brand</label>
                                                                <form:select class="form-select" id="brandId"
                                                                    path="brand.brandId">
                                                                    <form:options items="${brands}" itemValue="brandId"
                                                                        itemLabel="brandName" />
                                                                </form:select>
                                                                <form:errors path="brand.brandId"
                                                                    cssClass="text-danger" />
                                                            </div>


                                                            <!-- Price -->
                                                            <div class="form-group">
                                                                <label for="price">Price</label>
                                                                <form:input type="number" step="0.01"
                                                                    class="form-control" id="price" path="price"
                                                                    placeholder="Enter price" required="true" />
                                                                <form:errors path="price" cssClass="text-danger" />
                                                            </div>

                                                            <!-- Quantity in Stock -->
                                                            <div class="form-group">
                                                                <label for="quantityInStock">Quantity in Stock</label>
                                                                <form:input type="number" class="form-control"
                                                                    id="quantityInStock" path="quantityInStock"
                                                                    placeholder="Enter quantity" required="true" />
                                                                <form:errors path="quantityInStock"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <div class="col-md-6">
                                                            <!-- Short Description -->
                                                            <div class="form-group">
                                                                <label for="shortDescription">Short Description</label>
                                                                <form:textarea class="form-control"
                                                                    id="shortDescription" path="shortDescription"
                                                                    rows="3" placeholder="Enter short description" />
                                                                <form:errors path="shortDescription"
                                                                    cssClass="text-danger" />
                                                            </div>

                                                            <!-- Full Description -->
                                                            <div class="form-group">
                                                                <label for="description">Description</label>
                                                                <form:textarea class="form-control" id="description"
                                                                    path="description" rows="5"
                                                                    placeholder="Enter full description" />
                                                                <form:errors path="description"
                                                                    cssClass="text-danger" />
                                                            </div>

                                                            <!-- Image URL -->
                                                            <div class="form-group">
                                                                <label for="imageUrl">Image URL</label>
                                                                <form:input type="text" class="form-control"
                                                                    id="imageUrl" path="imageUrl"
                                                                    placeholder="Enter image URL" />
                                                                <form:errors path="imageUrl" cssClass="text-danger" />
                                                            </div>

                                                            <!-- Warranty -->
                                                            <div class="form-group">
                                                                <label for="warranty">Warranty</label>
                                                                <form:input type="text" class="form-control"
                                                                    id="warranty" path="warranty"
                                                                    placeholder="Enter warranty info" />
                                                                <form:errors path="warranty" cssClass="text-danger" />
                                                            </div>

                                                            <!-- Return Policy -->
                                                            <div class="form-group">
                                                                <label for="returnPolicy">Return Policy</label>
                                                                <form:input type="text" class="form-control"
                                                                    id="returnPolicy" path="returnPolicy"
                                                                    placeholder="Enter return policy" />
                                                                <form:errors path="returnPolicy"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Buttons -->
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">Submit</button>
                                                    <button type="reset" class="btn btn-danger">Cancel</button>
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