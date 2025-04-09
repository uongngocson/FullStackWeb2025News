<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Employee Details</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <link rel="icon" href="${ctx}/resources/assets/user/img/home/walmart-logo.webp" type="image/x-icon" />

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
                    .profile-header {
                        background-color: #4e73df;
                        color: white;
                        padding: 30px;
                        border-radius: 10px;
                        margin-bottom: 30px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                    }

                    .profile-img {
                        width: 150px;
                        height: 150px;
                        border-radius: 50%;
                        border: 5px solid white;
                        object-fit: cover;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                    }

                    .profile-name {
                        font-size: 28px;
                        font-weight: 700;
                        margin-top: 15px;
                        margin-bottom: 5px;
                    }

                    .profile-position {
                        font-size: 18px;
                        opacity: 0.9;
                        margin-bottom: 15px;
                    }

                    .profile-department {
                        display: inline-block;
                        background-color: rgba(255, 255, 255, 0.2);
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 14px;
                        margin-bottom: 10px;
                    }

                    .profile-status {
                        display: inline-block;
                        background-color: #1cc88a;
                        color: white;
                        padding: 5px 15px;
                        border-radius: 20px;
                        font-size: 14px;
                        margin-left: 10px;
                    }

                    .profile-status.inactive {
                        background-color: #e74a3b;
                    }

                    .info-card {
                        background-color: white;
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        padding: 25px;
                        margin-bottom: 30px;
                        border-top: 4px solid #4e73df;
                    }

                    .info-title {
                        font-size: 18px;
                        font-weight: 600;
                        color: #2d3748;
                        margin-bottom: 20px;
                        padding-bottom: 15px;
                        border-bottom: 1px solid #e2e8f0;
                    }

                    .info-item {
                        margin-bottom: 20px;
                    }

                    .info-label {
                        font-weight: 600;
                        color: #4e73df;
                        margin-bottom: 5px;
                        font-size: 14px;
                    }

                    .info-value {
                        color: #2d3748;
                        font-size: 16px;
                    }

                    .info-icon {
                        color: #4e73df;
                        margin-right: 10px;
                        width: 20px;
                        text-align: center;
                    }

                    .action-buttons {
                        margin-top: 20px;
                    }

                    .btn-primary {
                        background-color: #4e73df;
                        border-color: #4e73df;
                    }

                    .btn-danger {
                        background-color: #e74a3b;
                        border-color: #e74a3b;
                    }

                    .btn-round {
                        border-radius: 30px;
                        padding: 8px 16px;
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
                                    <h3 class="fw-bold mb-3">Employee Details</h3>
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
                                            <a href="/admin/employee-mgr/list">Employees</a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="#">Details</a>
                                        </li>
                                    </ul>
                                </div>

                                <!-- Profile Header -->
                                <div class="profile-header">
                                    <div class="row align-items-center">
                                        <div class="col-md-3 text-center">
                                            <img src="${not empty employee.profileImage ? employee.profileImage : ctx.concat('/resources/assets/dashboard/img/profile.jpg')}"
                                                alt="${employee.firstName}" class="profile-img">
                                        </div>
                                        <div class="col-md-9">
                                            <div class="profile-name">${employee.firstName} ${employee.lastName}</div>
                                            <div class="profile-position">${employee.employeeType ? 'Manager' : 'Staff'}
                                            </div>
                                            <div>
                                                <span class="profile-department">${not empty employee.shop ?
                                                    employee.shop.shopName : 'No Shop Assigned'}</span>
                                                <span
                                                    class="profile-status ${employee.status ? '' : 'inactive'}">${employee.status
                                                    ? 'Active' : 'Inactive'}</span>
                                            </div>
                                            <div class="action-buttons">
                                                <a href="/admin/employee-mgr/update/${employee.employeeId}"
                                                    class="btn btn-primary btn-round">
                                                    <i class="fas fa-edit mr-2"></i> Edit
                                                </a>
                                                <button class="btn btn-danger btn-round"
                                                    onclick="deleteEmployee('${employee.employeeId}')">
                                                    <i class="fas fa-trash mr-2"></i> Delete
                                                </button>
                                                <a href="/admin/employee-mgr/list" class="btn btn-secondary btn-round">
                                                    <i class="fas fa-arrow-left mr-2"></i> Back to List
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- Personal Information -->
                                    <div class="col-md-6">
                                        <div class="info-card">
                                            <div class="info-title">
                                                <i class="fas fa-user-circle mr-2"></i> Personal Information
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-id-card info-icon"></i> Employee ID
                                                </div>
                                                <div class="info-value">#${employee.employeeId}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-user info-icon"></i> Full Name
                                                </div>
                                                <div class="info-value">${employee.firstName} ${employee.lastName}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-venus-mars info-icon"></i> Gender
                                                </div>
                                                <div class="info-value">${employee.gender ? 'Male' : 'Female'}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-birthday-cake info-icon"></i> Date of Birth
                                                </div>
                                                <div class="info-value">
                                                    <fmt:parseDate value="${employee.dateOfBirth}" pattern="yyyy-MM-dd"
                                                        var="parsedDate" type="date" />
                                                    <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy" />
                                                </div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-map-marker-alt info-icon"></i> Address
                                                </div>
                                                <div class="info-value">${not empty employee.address ? employee.address
                                                    : 'Not provided'}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Contact Information -->
                                    <div class="col-md-6">
                                        <div class="info-card">
                                            <div class="info-title">
                                                <i class="fas fa-address-card mr-2"></i> Contact Information
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-envelope info-icon"></i> Email
                                                </div>
                                                <div class="info-value">${employee.email}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-phone info-icon"></i> Phone
                                                </div>
                                                <div class="info-value">${employee.phoneNumber}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-store info-icon"></i> Shop
                                                </div>
                                                <div class="info-value">${not empty employee.shop ?
                                                    employee.shop.shopName : 'Not assigned'}</div>
                                            </div>
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-user-tie info-icon"></i> Manager
                                                </div>
                                                <div class="info-value">${not empty employee.manager ?
                                                    employee.manager.firstName.concat('
                                                    ').concat(employee.manager.lastName) : 'No manager'}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Employment Information -->
                                    <div class="col-md-12">
                                        <div class="info-card">
                                            <div class="info-title">
                                                <i class="fas fa-briefcase mr-2"></i> Employment Information
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <div class="info-label">
                                                            <i class="fas fa-id-badge info-icon"></i> Employee Type
                                                        </div>
                                                        <div class="info-value">${employee.employeeType ? 'Manager' :
                                                            'Staff'}</div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <div class="info-label">
                                                            <i class="fas fa-calendar-alt info-icon"></i> Hire Date
                                                        </div>
                                                        <div class="info-value">
                                                            <fmt:parseDate value="${employee.hireDate}"
                                                                pattern="yyyy-MM-dd" var="hireDate" type="date" />
                                                            <fmt:formatDate value="${hireDate}"
                                                                pattern="MMMM dd, yyyy" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <div class="info-label">
                                                            <i class="fas fa-dollar-sign info-icon"></i> Salary
                                                        </div>
                                                        <div class="info-value">
                                                            <fmt:formatNumber value="${employee.salary}" type="currency"
                                                                currencySymbol="$" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <div class="info-label">
                                                            <i class="fas fa-toggle-on info-icon"></i> Status
                                                        </div>
                                                        <div class="info-value">
                                                            <span
                                                                class="badge badge-${employee.status ? 'success' : 'danger'}">
                                                                ${employee.status ? 'Active' : 'Inactive'}
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="info-item">
                                                        <div class="info-label">
                                                            <i class="fas fa-user-shield info-icon"></i> Account
                                                        </div>
                                                        <div class="info-value">
                                                            ${not empty employee.account ? employee.account.username :
                                                            'No account linked'}
                                                        </div>
                                                    </div>
                                                </div>
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
                    function deleteEmployee(employeeId) {
                        swal({
                            title: 'Are you sure?',
                            text: "You won't be able to revert this!",
                            icon: 'warning',
                            buttons: {
                                cancel: {
                                    visible: true,
                                    text: 'Cancel',
                                    className: 'btn btn-secondary'
                                },
                                confirm: {
                                    text: 'Yes, delete it!',
                                    className: 'btn btn-danger'
                                }
                            }
                        }).then((willDelete) => {
                            if (willDelete) {
                                $.ajax({
                                    url: '/admin/employee-mgr/delete/' + employeeId,
                                    type: 'POST',
                                    success: function (result) {
                                        swal({
                                            title: 'Deleted!',
                                            text: 'Employee has been deleted.',
                                            icon: 'success'
                                        }).then(() => {
                                            window.location.href = '/admin/employee-mgr/list';
                                        });
                                    },
                                    error: function (error) {
                                        swal('Error!', 'Something went wrong.', 'error');
                                    }
                                });
                            }
                        });
                    }
                </script>
            </body>

            </html>