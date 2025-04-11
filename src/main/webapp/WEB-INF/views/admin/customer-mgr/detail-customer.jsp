<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Customer Details</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
                <!-- Add Font Awesome for better icons -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

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
                            urls: ["${ctx}/resources/assets/dashboard/css/fonts.min.css"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <style>
                    .info-card {
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        border: none;
                        margin-bottom: 25px;
                    }

                    .info-card .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 20px 25px;
                    }

                    .info-card .card-body {
                        padding: 25px;
                    }

                    .info-label {
                        color: #718096;
                        font-size: 13px;
                        font-weight: 500;
                        margin-bottom: 8px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .info-value {
                        font-weight: 600;
                        font-size: 16px;
                        margin-bottom: 20px;
                    }

                    .profile-image {
                        width: 150px;
                        height: 150px;
                        border-radius: 50%;
                        object-fit: cover;
                        border: 5px solid #fff;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                        margin-bottom: 20px;
                    }

                    .profile-header {
                        text-align: center;
                        padding: 30px 0;
                        background-color: #f8fafc;
                        border-radius: 10px;
                        margin-bottom: 30px;
                    }

                    .profile-name {
                        font-size: 24px;
                        font-weight: 700;
                        margin-bottom: 5px;
                    }

                    .profile-email {
                        color: #718096;
                        margin-bottom: 15px;
                    }

                    .status-badge {
                        padding: 8px 15px;
                        border-radius: 30px;
                        font-weight: 600;
                        font-size: 12px;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        display: inline-block;
                    }

                    .action-buttons .btn {
                        padding: 8px 16px;
                        font-weight: 500;
                        margin-left: 10px;
                    }

                    .table-order-items th {
                        font-weight: 600;
                        color: #4a5568;
                        border-top: none;
                        background-color: #f9fafb;
                    }

                    .table-order-items td {
                        vertical-align: middle;
                    }

                    .order-item {
                        display: flex;
                        align-items: center;
                    }

                    .order-id {
                        font-weight: 600;
                        color: #4299e1;
                    }

                    .order-date {
                        font-size: 12px;
                        color: #718096;
                    }

                    .info-icon {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        background-color: #ebf4ff;
                        color: #4299e1;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        margin-right: 15px;
                    }

                    .info-icon i {
                        font-size: 18px;
                    }

                    .info-row {
                        display: flex;
                        align-items: center;
                        margin-bottom: 20px;
                    }

                    .info-content {
                        flex: 1;
                    }
                </style>
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
                                    <h3 class="fw-bold mb-3">Customer Details</h3>
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
                                            <a href="/admin/customer-mgr/list">Customers</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Customer Details</a>
                                        </li>
                                    </ul>
                                </div>

                                <!-- Profile Header -->
                                <div class="profile-header">
                                    <img src="${not empty customer.imageUrl ? customer.imageUrl : ctx.concat('/resources/assets/dashboard/img/profile.jpg')}"
                                        class="profile-image" alt="${customer.firstName}">
                                    <div class="profile-name">${customer.firstName} ${customer.lastName}</div>
                                    <div class="profile-email">${customer.email}</div>
                                    <span class="status-badge ${customer.status ? 'bg-success' : 'bg-danger'}">
                                        ${customer.status ? 'Active' : 'Inactive'}
                                    </span>
                                    <div class="mt-4 action-buttons">
                                        <a href="/admin/customer-mgr/update/${customer.customerId}"
                                            class="btn btn-primary btn-round">
                                            <i class="fa fa-edit mr-1"></i> Edit
                                        </a>
                                        <button class="btn btn-danger btn-round"
                                            onclick="confirmDelete('${customer.customerId}')">
                                            <i class="fa fa-trash mr-1"></i> Delete
                                        </button>
                                    </div>
                                </div>

                                <!-- Customer Information -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-user mr-2 text-primary"></i>
                                                    Personal Information
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-id-card"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Customer ID</div>
                                                        <div class="info-value">#${customer.customerId}</div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Full Name</div>
                                                        <div class="info-value">${customer.firstName}
                                                            ${customer.lastName}</div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-venus-mars"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Gender</div>
                                                        <div class="info-value">${customer.gender ? 'Male' : 'Female'}
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-birthday-cake"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Date of Birth</div>
                                                        <div class="info-value">
                                                            <fmt:formatDate value="${customer.getDateOfBirthAsDate()}"
                                                                pattern="dd/MM/yyyy" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-address-card mr-2 text-primary"></i>
                                                    Contact Information
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-envelope"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Email Address</div>
                                                        <div class="info-value">${customer.email}</div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-phone"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Phone Number</div>
                                                        <div class="info-value">${customer.phone}</div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-calendar-alt"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Registration Date</div>
                                                        <div class="info-value">
                                                            <fmt:formatDate
                                                                value="${customer.getRegistrationDateAsDate()}"
                                                                pattern="dd/MM/yyyy" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="info-row">
                                                    <div class="info-icon">
                                                        <i class="fas fa-toggle-on"></i>
                                                    </div>
                                                    <div class="info-content">
                                                        <div class="info-label">Account Status</div>
                                                        <div class="info-value">
                                                            <span
                                                                class="status-badge ${customer.status ? 'bg-success' : 'bg-danger'}">
                                                                ${customer.status ? 'Active' : 'Inactive'}
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Customer Orders -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card info-card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-shopping-cart mr-2 text-primary"></i>
                                                    Order History
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty orders}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-order-items">
                                                                <thead>
                                                                    <tr>
                                                                        <th width="5%">#</th>
                                                                        <th width="15%">Order ID</th>
                                                                        <th width="20%">Order Date</th>
                                                                        <th width="15%">Total Amount</th>
                                                                        <th width="15%">Payment Status</th>
                                                                        <th width="15%">Order Status</th>
                                                                        <th width="15%" class="text-center">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="order" items="${orders}"
                                                                        varStatus="status">
                                                                        <tr>
                                                                            <td>${status.index + 1}</td>
                                                                            <td>
                                                                                <div class="order-id">#${order.orderId}
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div class="order-date">
                                                                                    <fmt:parseDate
                                                                                        value="${order.orderDate}"
                                                                                        pattern="yyyy-MM-dd'T'HH:mm"
                                                                                        var="parsedDate" type="both" />
                                                                                    <fmt:formatDate
                                                                                        value="${parsedDate}"
                                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                                </div>
                                                                            </td>
                                                                            <td>$${order.totalAmount}</td>
                                                                            <td>
                                                                                <span
                                                                                    class="status-badge ${order.paymentStatus == 'Paid' ? 'bg-success' : 
                                                                        order.paymentStatus == 'Pending' ? 'bg-warning' : 
                                                                        order.paymentStatus == 'Failed' ? 'bg-danger' : 'bg-secondary'}">
                                                                                    ${order.paymentStatus}
                                                                                </span>
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="status-badge ${order.orderStatus == 'Completed' ? 'bg-success' : 
                                                                        order.orderStatus == 'Processing' ? 'bg-primary' : 
                                                                        order.orderStatus == 'Shipped' ? 'bg-info' : 
                                                                        order.orderStatus == 'Cancelled' ? 'bg-danger' : 'bg-warning'}">
                                                                                    ${order.orderStatus}
                                                                                </span>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <a href="/admin/order-mgr/detail/${order.orderId}"
                                                                                    class="btn btn-primary btn-sm">
                                                                                    <i class="fas fa-eye"></i> View
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-5">
                                                            <i class="fas fa-shopping-cart fa-3x text-muted mb-3"></i>
                                                            <h4>No Orders Found</h4>
                                                            <p class="text-muted">This customer hasn't placed any orders
                                                                yet.</p>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
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
                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    function confirmDelete(customerId) {
                        swal({
                            title: "Are you sure?",
                            text: "Once deleted, you will not be able to recover this customer!",
                            icon: "warning",
                            buttons: true,
                            dangerMode: true,
                        }).then((willDelete) => {
                            if (willDelete) {
                                window.location.href = "/admin/customer-mgr/delete/" + customerId;
                            }
                        });
                    }
                </script>
            </body>

            </html>