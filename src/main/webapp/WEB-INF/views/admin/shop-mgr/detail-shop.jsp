<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <title>Shop Details</title>
            <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
            <!-- set path -->
            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <link rel="icon" href="../../../../resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />
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
            <!-- CSS -->
            <style>
                .shop-logo-container {
                    padding: 15px;
                    background-color: #f8f9fa;
                    border-radius: 5px;
                }

                .shop-image-container {
                    border-radius: 5px;
                    overflow: hidden;
                    background-color: #f8f9fa;
                    padding: 10px;
                }

                .shop-info {
                    padding: 10px;
                }

                .shop-info p {
                    margin-bottom: 8px;
                }

                .shop-description-container .btn:focus {
                    box-shadow: none;
                }

                .shop-description-container .btn i.fa-chevron-down {
                    transition: transform 0.3s;
                }

                .shop-description-container .btn[aria-expanded="true"] i.fa-chevron-down {
                    transform: rotate(180deg);
                }

                /* CSS */
                .shop-description-container .btn[aria-expanded="true"]::before {
                    content: "Hide Description";
                }

                .shop-description-container .btn[aria-expanded="true"] .btn-text {
                    display: none;
                }
            </style>
        </head>

        <body>
            <div class="wrapper">
                <!-- start sidebar -->
                <jsp:include page="../layout/sidebar.jsp" />
                <!-- end sidebar -->
                <div class="main-panel">
                    <!-- start navbar -->
                    <jsp:include page="../layout/header.jsp" />
                    <!-- end navbar -->
                    <div class="container">
                        <div class="page-inner">

                            <!-- Page Header -->
                            <div class="page-header">
                                <h3 class="fw-bold mb-3">Shop Details</h3>
                                <ul class="breadcrumbs mb-3">
                                    <li class="nav-home">
                                        <a href="/admin/dashboard/index">
                                            <i class="icon-home"></i>
                                        </a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="/admin/shop-mgr/list">Shops</a>
                                    </li>
                                    <li class="separator">
                                        <i class="icon-arrow-right"></i>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#">Shop Details</a>
                                    </li>
                                </ul>
                            </div>

                            <!-- Page Content -->

                            <!-- Shop Details Card -->
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <!-- start card header -->
                                        <div class="card-header">
                                            <div class="d-flex align-items-center">
                                                <h4 class="card-title">#${shop.shopId} - ${shop.shopName}</h4>
                                                <div class="ms-auto">
                                                    <a href="/admin/shop-mgr/update/${shop.shopId}"
                                                        class="btn btn-primary btn-sm">
                                                        <i class="fas fa-edit"></i> Update Shop
                                                    </a>
                                                    <button class="btn btn-danger btn-sm"
                                                        onclick="deleteShop('${shop.shopId}')">
                                                        <i class="fas fa-trash"></i> Delete Shop
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- end card header -->

                                        <!-- start card body -->
                                        <div class="card-body">
                                            <div class="row mb-4">
                                                <div class="col-md-3 text-center">
                                                    <!-- start shop logo -->
                                                    <div class="shop-logo-container mb-3">

                                                        <c:choose>
                                                            <c:when test="${not empty shop.logoUrl}">
                                                                <c:set var="logoUrl" value="${ctx}/${shop.logoUrl}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="logoUrl"
                                                                    value="${ctx}/resources/images/logo-is-empty.jpg" />
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <img src="${logoUrl}" alt="logo"
                                                            class="img-fluid rounded shadow-sm"
                                                            style="max-height: 150px; max-width: 100%;">
                                                    </div>
                                                    <!-- end shop logo -->

                                                    <!-- start status -->
                                                    <div class="shop-status text-center">
                                                        <span
                                                            class="badge badge-${shop.isActive ? 'success' : 'danger'} p-2 fs-6 w-100">
                                                            ${shop.isActive ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </div>
                                                    <!-- end status -->
                                                </div>

                                                <!-- start information shop -->
                                                <div class="col-md-5">
                                                    <div class="shop-info">
                                                        <h4 class="fw-bold">${shop.shopName}</h4>
                                                        <p class="text-muted mb-2">
                                                            <i
                                                                class="fas fa-map-marker-alt me-2"></i>${shop.shopAddress}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-user me-2"></i>${shop.contactPerson}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-phone me-2"></i>${shop.phoneNumber}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-envelope me-2"></i>${shop.email}
                                                        </p>
                                                        <p class="text-muted mb-2">
                                                            <i class="fas fa-calendar me-2"></i>Created:
                                                            ${shop.createdAt}
                                                        </p>
                                                        <div class="shop-rating mt-3">
                                                            <span class="text-warning me-2">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <i
                                                                        class="fas fa-star${i <= shop.rating ? '' : '-o'}"></i>
                                                                </c:forEach>
                                                            </span>
                                                            <span class="fw-bold">${shop.rating}/5</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- end information shop -->

                                                <!-- start cover image -->
                                                <div class="col-md-4">
                                                    <div
                                                        class="shop-image-container h-100 d-flex align-items-center justify-content-center">
                                                        <c:choose>
                                                            <c:when test="${not empty shop.coverImageUrl}">
                                                                <c:set var="imgUrl"
                                                                    value="${ctx}/${shop.coverImageUrl}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set var="imgUrl"
                                                                    value="${ctx}/resources/images/images-is-empty.jpg" />
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <img src="${imgUrl}" alt="image shop"
                                                            class="img-fluid rounded shadow"
                                                            style="max-height: 200px; max-width: 100%; object-fit: cover;">
                                                    </div>
                                                </div>
                                                <!-- end cover image -->
                                            </div>


                                            <!-- start show description -->
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="shop-description-container">
                                                        <button class="btn btn-light btn-sm w-100 mb-3" type="button"
                                                            data-bs-toggle="collapse" data-bs-target="#shopDescription"
                                                            aria-expanded="false" aria-controls="shopDescription">
                                                            <i class="fas fa-info-circle me-2"></i>
                                                            <span class="btn-text">Shop Description</span>
                                                            <i class="fas fa-chevron-down ms-2 toggle-icon"></i>
                                                        </button>
                                                        <div class="collapse" id="shopDescription">
                                                            <div class="card card-body bg-light">
                                                                <p class="mb-0">
                                                                    ${shop.shopDescription != null ?
                                                                    shop.shopDescription : 'No description available for
                                                                    this shop.'}
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- end show description -->

                                            <!-- start statistics -->
                                            <div class="row mt-4">
                                                <div class="row">
                                                    <!-- statistics visitor -->
                                                    <div class="col-sm-6 col-md-3">
                                                        <div class="card card-stats card-round">
                                                            <div class="card-body">
                                                                <div class="row align-items-center">
                                                                    <div class="col-icon">
                                                                        <div
                                                                            class="icon-big text-center icon-primary bubble-shadow-small">
                                                                            <i class="fas fa-users"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col col-stats ms-3 ms-sm-0">
                                                                        <div class="numbers">
                                                                            <p class="card-category">Visitors</p>
                                                                            <h4 class="card-title">${shop.totalFollowers
                                                                                != null ? shop.totalFollowers : '0'}
                                                                            </h4>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- statistics product -->
                                                    <div class="col-sm-6 col-md-3">
                                                        <div class="card card-stats card-round">
                                                            <div class="card-body">
                                                                <div class="row align-items-center">
                                                                    <div class="col-icon">
                                                                        <div
                                                                            class="icon-big text-center icon-info bubble-shadow-small">
                                                                            <i class="fas fa-luggage-cart"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col col-stats ms-3 ms-sm-0">
                                                                        <div class="numbers">
                                                                            <p class="card-category">Products</p>
                                                                            <h4 class="card-title">
                                                                                ${shopStats.totalProducts != null ?
                                                                                shopStats.totalProducts :
                                                                                products.size()}</h4>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- statistics sale -->
                                                    <div class="col-sm-6 col-md-3">
                                                        <div class="card card-stats card-round">
                                                            <div class="card-body">
                                                                <div class="row align-items-center">
                                                                    <div class="col-icon">
                                                                        <div
                                                                            class="icon-big text-center icon-success bubble-shadow-small">
                                                                            <i class="fas fa-database"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col col-stats ms-3 ms-sm-0">
                                                                        <div class="numbers">
                                                                            <p class="card-category">Sales</p>
                                                                            <h4 class="card-title">$ 1,345</h4>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- statistics order -->
                                                    <div class="col-sm-6 col-md-3">
                                                        <div class="card card-stats card-round">
                                                            <div class="card-body">
                                                                <div class="row align-items-center">
                                                                    <div class="col-icon">
                                                                        <div
                                                                            class="icon-big text-center icon-secondary bubble-shadow-small">
                                                                            <i class="far fa-check-circle"></i>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col col-stats ms-3 ms-sm-0">
                                                                        <div class="numbers">
                                                                            <p class="card-category">Order</p>
                                                                            <h4 class="card-title">
                                                                                ${shopStats.totalOrders != null ?
                                                                                shopStats.totalOrders : '0'}</h4>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- end statistics -->
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Shop Products Card -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="d-flex align-items-center">
                                                    <h4 class="card-title">Products from this Shop</h4>
                                                    <a href="/product-mgr/create?shopId=${shop.shopId}"
                                                        class="btn btn-primary btn-round ms-auto">
                                                        <i class="fas fa-plus"></i> Add New Product
                                                    </a>
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table id="products-table" class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th>No.</th>
                                                                <th>ID</th>
                                                                <th>Image</th>
                                                                <th>Name</th>
                                                                <th>Category</th>
                                                                <th>Price</th>
                                                                <th>Stock</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="product" items="${products}"
                                                                varStatus="status">
                                                                <tr>
                                                                    <td>${status.index+1}</td>
                                                                    <td><a href="/product-mgr/${product.productId}"
                                                                            class="text-primary">#${product.productId}</a>
                                                                    </td>
                                                                    <td>
                                                                        <img src="${product.imageUrl}"
                                                                            alt="${product.productName}" class="rounded"
                                                                            width="50">
                                                                    </td>
                                                                    <td>${product.productName}</td>
                                                                    <td>${product.category.categoryName}</td>
                                                                    <td>$${product.price}</td>
                                                                    <td>${product.quantityInStock}</td>

                                                                    <td>
                                                                        <div class="btn-group">
                                                                            <a href="/product-mgr/${product.productId}"
                                                                                class="btn btn-sm btn-info">
                                                                                <i class="fas fa-eye"></i>
                                                                            </a>
                                                                            <a href="/product-mgr/update/${product.productId}"
                                                                                class="btn btn-sm btn-primary">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <button type="button"
                                                                                class="btn btn-sm btn-danger"
                                                                                onclick="deleteProduct('${product.productId}')">
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

                <!-- Scrollbar Plugin -->
                <script
                    src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- KaiAdmin JS -->
                <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <!-- DataTables JS -->
                <script src="../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <script>

                    // function delete shop
                    function deleteShop(shopId) {
                        swal({
                            title: "Are you sure you want to delete this shop?",
                            text: "This action cannot be undone and will also delete all products associated with this shop.",
                            icon: "warning",
                            buttons: ["Cancel", "Delete"],
                            dangerMode: true,
                        }).then((confirmed) => {
                            if (confirmed) {
                                $.post(`/admin/shop-mgr/delete/${shopId}`)
                                    .done(() => {
                                        swal("Deleted!", "The shop has been successfully deleted.", "success")
                                            .then(() => window.location.href = "/admin/shop-mgr/list");
                                    })
                                    .fail(() => {
                                        swal("Error!", "Something went wrong. Please try again.", "error");
                                    });
                            }
                        });
                    }

                    // function delete product
                    function deleteProduct(productId) {
                        swal({
                            title: "Are you sure you want to delete this product?",
                            text: "This action cannot be undone.",
                            icon: "warning",
                            buttons: ["Cancel", "Delete"],
                            dangerMode: true,
                        }).then((confirmed) => {
                            if (confirmed) {
                                $.post(`/product-mgr/delete/${productId}`)
                                    .done(() => {
                                        swal("Deleted!", "The product has been successfully deleted.", "success")
                                            .then(() => location.reload());
                                    })
                                    .fail(() => {
                                        swal("Error!", "Something went wrong. Please try again.", "error");
                                    });
                            }
                        });
                    }


                    $(document).ready(function () {
                        // Initialize DataTable
                        $('#products-table').DataTable({
                            pageLength: 10,
                            lengthMenu: [5, 10, 25, 50, 100],
                            columnDefs: [
                                {
                                    targets: [2, 7],
                                    orderable: false,
                                    searchable: false
                                }
                            ]
                        });
                        // Update button text when description is toggled
                        $(document).ready(function () {
                            $('.shop-description-container .btn').on('click', function () {
                                const $this = $(this);
                                const $icon = $this.find('.toggle-icon');
                                const isExpanded = $this.attr('aria-expanded') === 'true';

                                $icon.toggleClass('fa-chevron-down fa-chevron-up', !isExpanded);
                            });
                        });

                    });
                </script>
        </body>

        </html>