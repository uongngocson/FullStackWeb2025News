<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Shop Management</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                type="image/x-icon" />
            <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
            <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
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
        </head>

        <body>
            <div class="wrapper">
                <!-- Sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />
                <div class="main-panel">
                    <jsp:include page="../layout/header.jsp" />
                    <div class="container">
                        <div class="page-inner">
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Shops</h3>
                                <ul class="breadcrumbs mb-3">
                                    <li class="nav-home">
                                        <a href="#">
                                            <i class="icon-home"></i>
                                        </a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#">Shops</a>
                                    </li>
                                </ul>
                            </div>
                            <div
                                class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                                <div class="ms-md-auto py-2 py-md-0">
                                    <a href="/shop-mgr/create" class="btn btn-primary btn-round">
                                        <i class="fas fa-plus"></i> Add New Shop
                                    </a>
                                </div>
                            </div>

                            <!-- Shop List Table -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table id="shopsTable" class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Shop ID</th>
                                                            <th>Shop Name</th>
                                                            <th>Contact Person</th>
                                                            <th>Address</th>
                                                            <th>Operating Hours</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="shop" items="${shops}">
                                                            <tr>
                                                                <td>${shop.shopId}</td>
                                                                <td>${shop.shopName}</td>
                                                                <td>${shop.contactPerson}</td>
                                                                <td>${shop.shopAddress}</td>
                                                                <td>${shop.operatingHours}</td>
                                                                <td>
                                                                    <div class="btn-group">
                                                                        <a href="/shop-mgr/${shop.shopId}"
                                                                            class="btn btn-sm btn-info">
                                                                            <i class="fas fa-eye"></i>
                                                                        </a>
                                                                        <a href="/shop-mgr/update/${shop.shopId}"
                                                                            class="btn btn-sm btn-primary">
                                                                            <i class="fas fa-edit"></i>
                                                                        </a>
                                                                        <button type="button"
                                                                            class="btn btn-sm btn-danger"
                                                                            onclick="deleteShop('${shop.shopId}')">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>

            <!-- Core JS Files -->
            <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
            <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
            <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

            <!-- Sweet Alert -->
            <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

            <script>
                // Delete confirmation and API call
                function deleteShop(shopId) {
                    swal({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        type: 'warning',
                        buttons: {
                            cancel: {
                                visible: true,
                                text: 'Cancel',
                                className: 'btn btn-danger'
                            },
                            confirm: {
                                text: 'Yes, delete it!',
                                className: 'btn btn-success'
                            }
                        }
                    }).then((willDelete) => {
                        if (willDelete) {
                            // Make an AJAX request to delete the product
                            $.ajax({
                                url: '/shop-mgr/delete/' + shopId, // Make sure the path is correct
                                type: 'POST',
                                success: function (response) {
                                    swal("Deleted!", "The shop has been deleted.", {
                                        icon: "success",
                                        buttons: {
                                            confirm: {
                                                className: 'btn btn-success'
                                            }
                                        }
                                    }).then(function () {
                                        location.reload(); // Reload the page after deletion
                                    });
                                },
                                error: function (error) {
                                    swal("Error!", "There was an issue deleting the shop.", "error");
                                }
                            });
                        }
                    });
                }
            </script>
        </body>

        </html>