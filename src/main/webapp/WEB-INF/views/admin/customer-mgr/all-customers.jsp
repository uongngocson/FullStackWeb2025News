<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Customer Management</title>
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
                    .customer-avatar {
                        width: 40px;
                        height: 40px;
                        border-radius: 50%;
                        object-fit: cover;
                    }

                    .status-badge {
                        padding: 5px 10px;
                        border-radius: 30px;
                        font-size: 12px;
                        font-weight: 600;
                    }

                    .table-responsive {
                        overflow-x: auto;
                    }

                    .action-buttons .btn {
                        /* This class was defined but not used, keeping for potential future use or removal if definitely not needed */
                        padding: 5px 10px;
                        margin: 0 2px;
                    }

                    .card {
                        border-radius: 10px;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                        border: none;
                    }

                    .card-header {
                        background-color: #fff;
                        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
                        padding: 20px 25px;
                    }

                    .card-title {
                        font-weight: 600;
                        color: #2d3748;
                    }

                    .card-body {
                        padding: 25px;
                    }

                    .table th {
                        font-weight: 600;
                        color: #4a5568;
                        border-top: none;
                        background-color: #f9fafb;
                    }

                    .table td {
                        vertical-align: middle;
                    }

                    .customer-info {
                        display: flex;
                        align-items: center;
                    }

                    .customer-details {
                        margin-left: 15px;
                    }

                    .customer-name {
                        font-weight: 600;
                        margin-bottom: 3px;
                    }

                    .customer-email {
                        font-size: 12px;
                        color: #718096;
                    }

                    /* Pagination styling */
                    .pagination {
                        margin-bottom: 0;
                    }

                    .page-item.active .page-link {
                        background-color: #4299e1;
                        border-color: #4299e1;
                    }

                    .page-link {
                        color: #4299e1;
                    }

                    .page-link:hover {
                        color: #2b6cb0;
                    }

                    /* Filter card styling */
                    .filter-card {
                        margin-bottom: 20px;
                    }

                    .filter-card .card-body {
                        padding: 15px;
                    }

                    .filter-form {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 10px;
                        align-items: flex-end;
                    }

                    .filter-form .form-group {
                        flex: 1;
                        min-width: 200px;
                        margin-bottom: 0;
                    }

                    .filter-form .btn-group {
                        white-space: nowrap;
                    }

                    /* Sorting icons */
                    .sort-icon {
                        margin-left: 5px;
                    }

                    /* Responsive adjustments */
                    @media (max-width: 768px) {
                        .filter-form {
                            flex-direction: column;
                        }

                        .filter-form .form-group {
                            width: 100%;
                            margin-bottom: 10px;
                        }
                    }

                    /* Loading indicator */
                    .loading-overlay {
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(255, 255, 255, 0.7);
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        z-index: 9999;
                        visibility: hidden;
                        opacity: 0;
                        transition: visibility 0s, opacity 0.3s;
                    }

                    .loading-overlay.active {
                        visibility: visible;
                        opacity: 1;
                    }

                    .spinner {
                        width: 50px;
                        height: 50px;
                        border: 5px solid #f3f3f3;
                        border-top: 5px solid #3498db;
                        border-radius: 50%;
                        animation: spin 1s linear infinite;
                    }

                    @keyframes spin {
                        0% { transform: rotate(0deg); }
                        100% { transform: rotate(360deg); }
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
                                    <h3 class="fw-bold mb-3">Customer Management</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="<c:url value='/admin/dashboard/index' />">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="<c:url value='/admin/customer-mgr/list' />">Customers</a>
                                        </li>
                                    </ul>
                                </div>

                                <%-- Hủy chức năng thêm khách hàng của trang ADMIN --%>
                                    <!-- <div
                        class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                        <div class="ms-md-auto py-2 py-md-0">
                            <a href="<c:url value='/admin/customer-mgr/create' />" class="btn btn-primary btn-round">
                                <i class="fas fa-plus"></i> Add New Customer
                            </a>
                        </div>
                    </div> -->

                                    <%-- Display Success and Error Messages --%>
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                ${successMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                ${errorMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">×</span>
                                                </button>
                                            </div>
                                        </c:if>

                                        <!-- Filter Card -->
                                        <div class="card filter-card">
                                            <div class="card-header">
                                                <div class="card-title">
                                                    <i class="fas fa-filter mr-2 text-primary"></i>
                                                    Filter Customers
                                                </div>
                                            </div>
                                            <div class="card-body">
                                                <form id="filterForm" class="filter-form" method="get" action="${ctx}/admin/customer-mgr/list">
                                                    <div class="form-group">
                                                        <label for="keyword">Search</label>
                                                        <input type="text" class="form-control" id="keyword" name="keyword" 
                                                            placeholder="Name, Email..." value="${keyword}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="status">Status</label>
                                                        <select class="form-control" id="status" name="status">
                                                            <option value="">All</option>
                                                            <option value="true" ${status == true ? 'selected' : ''}>Active</option>
                                                            <option value="false" ${status == false ? 'selected' : ''}>Inactive</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="sortField">Sort By</label>
                                                        <select class="form-control" id="sortField" name="sortField">
                                                            <option value="registrationDate" ${sortField == 'registrationDate' ? 'selected' : ''}>Registration Date</option>
                                                            <option value="firstName" ${sortField == 'firstName' ? 'selected' : ''}>First Name</option>
                                                            <option value="lastName" ${sortField == 'lastName' ? 'selected' : ''}>Last Name</option>
                                                            <option value="email" ${sortField == 'email' ? 'selected' : ''}>Email</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="sortDirection">Direction</label>
                                                        <select class="form-control" id="sortDirection" name="sortDirection">
                                                            <option value="ASC" ${sortDirection == 'ASC' ? 'selected' : ''}>Ascending</option>
                                                            <option value="DESC" ${sortDirection == 'DESC' ? 'selected' : ''}>Descending</option>
                                                        </select>
                                                    </div>
                                                    <div class="btn-group">
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-search mr-1"></i> Apply
                                                        </button>
                                                        <button type="button" id="resetFilter" class="btn btn-secondary">
                                                            <i class="fas fa-redo mr-1"></i> Reset
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="card">
                                                    <div class="card-header d-flex justify-content-between align-items-center">
                                                        <div class="card-title">
                                                            <i class="fas fa-users mr-2 text-primary"></i>
                                                            Customer List
                                                        </div>
                                                        <div class="card-tools">
                                                            <span class="badge badge-info">
                                                                Total: ${totalItems} customers
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="table-responsive">
                                                            <table id="customerTable" class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th width="5%">No.</th>
                                                                        <th width="25%">Customer</th>
                                                                        <th width="15%">Phone</th>
                                                                        <th width="15%">Date of Birth</th>
                                                                        <th width="15%">Register Date</th>
                                                                        <th width="10%">Status</th>
                                                                        <th width="15%" class="text-center">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="customer" items="${customers}"
                                                                        varStatus="status">
                                                                        <tr>
                                                                            <td>${status.index + 1 + currentPage * pageSize}</td>
                                                                            <td>
                                                                                <div class="customer-info">
                                                                                    <img src="${not empty customer.imageUrl 
                                                                            ? (customer.imageUrl.startsWith('http') ? customer.imageUrl : ctx.concat(customer.imageUrl)) 
                                                                            : (ctx.concat(customer.gender ? '/resources/images-upload/customer/avatar-default-male.jpg' : '/resources/images-upload/customer/avatar-default-female.jpg'))}"
                                                                                        alt="Customer Avatar" class="w-12 h-12 rounded-full object-cover border-2 border-white shadow-md" style="width: 50px; height: 50px;">
                                                                                    <div class="customer-details">
                                                                                        <div class="customer-name">
                                                                                            ${customer.firstName}
                                                                                            ${customer.lastName}
                                                                                        </div>
                                                                                        <div class="customer-email">
                                                                                            ${customer.email}
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                            <td>${customer.phone}</td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${customer.getDateOfBirthAsDate()}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${customer.getRegistrationDateAsDate()}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="status-badge ${customer.status ? 'bg-success text-white' : 'bg-danger text-white'}">
                                                                                    ${customer.status ? 'Active' :
                                                                                    'Inactive'}
                                                                                </span>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <div class="btn-group">
                                                                                    <a href="<c:url value='/admin/customer-mgr/detail/${customer.customerId}' />"
                                                                                        class="btn btn-sm btn-info"
                                                                                        title="View Details">
                                                                                        <i class="fas fa-eye"></i>
                                                                                    </a>
                                                                                    <a href="<c:url value='/admin/customer-mgr/update/${customer.customerId}' />"
                                                                                        class="btn btn-sm btn-primary"
                                                                                        title="Edit Customer">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-danger"
                                                                                        onclick="confirmDelete('${customer.customerId}', '${customer.firstName} ${customer.lastName}')"
                                                                                        title="Delete Customer">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                    <c:if test="${empty customers}">
                                                                        <tr>
                                                                            <td colspan="7" class="text-center">No customers found</td>
                                                                        </tr>
                                                                    </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <!-- Pagination -->
                                                        <c:if test="${totalPages > 0}">
                                                            <div class="d-flex justify-content-between align-items-center mt-4 flex-wrap">
                                                                <div class="d-flex align-items-center mb-2">
                                                                    <span class="mr-2">Show</span>
                                                                    <select id="pageSizeSelect" class="form-control form-control-sm" style="width: auto;">
                                                                        <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                                                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                                                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                                                        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                                                                        <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                                                                    </select>
                                                                    <span class="ml-2">entries</span>
                                                                </div>
                                                                
                                                                <nav>
                                                                    <ul class="pagination">
                                                                        <!-- First Page -->
                                                                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                                                            <c:if test="${currentPage > 0}">
                                                                                <a class="page-link" href="${ctx}/admin/customer-mgr/list?page=0&size=${pageSize}&sortField=${sortField}&sortDirection=${sortDirection}&keyword=${keyword}&status=${status}">
                                                                                    <i class="fas fa-angle-double-left"></i>
                                                                                </a>
                                                                            </c:if>
                                                                            <c:if test="${currentPage == 0}">
                                                                                <span class="page-link">
                                                                                    <i class="fas fa-angle-double-left"></i>
                                                                                </span>
                                                                            </c:if>
                                                                        </li>
                                                                        
                                                                        <!-- Previous Page -->
                                                                        <c:set var="prevPage" value="${currentPage - 1}" />
                                                                        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                                                            <c:if test="${currentPage > 0}">
                                                                                <a class="page-link" href="${ctx}/admin/customer-mgr/list?page=${prevPage}&size=${pageSize}&sortField=${sortField}&sortDirection=${sortDirection}&keyword=${keyword}&status=${status}">
                                                                                    <i class="fas fa-angle-left"></i>
                                                                                </a>
                                                                            </c:if>
                                                                            <c:if test="${currentPage == 0}">
                                                                                <span class="page-link">
                                                                                    <i class="fas fa-angle-left"></i>
                                                                                </span>
                                                                            </c:if>
                                                                        </li>
                                                                        
                                                                        <!-- Page Numbers -->
                                                                        <c:forEach items="${pageNumbers}" var="pageNumber">
                                                                            <c:choose>
                                                                                <c:when test="${pageNumber == -1}">
                                                                                    <li class="page-item disabled">
                                                                                        <span class="page-link">...</span>
                                                                                    </li>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <li class="page-item ${currentPage == pageNumber ? 'active' : ''}">
                                                                                        <a class="page-link" href="${ctx}/admin/customer-mgr/list?page=${pageNumber}&size=${pageSize}&sortField=${sortField}&sortDirection=${sortDirection}&keyword=${keyword}&status=${status}">
                                                                                            ${pageNumber + 1}
                                                                                        </a>
                                                                                    </li>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:forEach>
                                                                        
                                                                        <!-- Next Page -->
                                                                        <c:set var="nextPage" value="${currentPage + 1}" />
                                                                        <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                                                            <c:if test="${currentPage < totalPages - 1}">
                                                                                <a class="page-link" href="${ctx}/admin/customer-mgr/list?page=${nextPage}&size=${pageSize}&sortField=${sortField}&sortDirection=${sortDirection}&keyword=${keyword}&status=${status}">
                                                                                    <i class="fas fa-angle-right"></i>
                                                                                </a>
                                                                            </c:if>
                                                                            <c:if test="${currentPage == totalPages - 1}">
                                                                                <span class="page-link">
                                                                                    <i class="fas fa-angle-right"></i>
                                                                                </span>
                                                                            </c:if>
                                                                        </li>
                                                                        
                                                                        <!-- Last Page -->
                                                                        <c:set var="lastPage" value="${totalPages - 1}" />
                                                                        <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                                                            <c:if test="${currentPage < totalPages - 1}">
                                                                                <a class="page-link" href="${ctx}/admin/customer-mgr/list?page=${lastPage}&size=${pageSize}&sortField=${sortField}&sortDirection=${sortDirection}&keyword=${keyword}&status=${status}">
                                                                                    <i class="fas fa-angle-double-right"></i>
                                                                                </a>
                                                                            </c:if>
                                                                            <c:if test="${currentPage == totalPages - 1}">
                                                                                <span class="page-link">
                                                                                    <i class="fas fa-angle-double-right"></i>
                                                                                </span>
                                                                            </c:if>
                                                                        </li>
                                                                    </ul>
                                                                </nav>
                                                            </div>
                                                        </c:if>
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

                <!-- Loading Overlay -->
                <div id="loadingOverlay" class="loading-overlay">
                    <div class="spinner"></div>
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
                    $(document).ready(function () {
                        // Reset filter button
                        $('#resetFilter').click(function() {
                            window.location.href = '${ctx}/admin/customer-mgr/list';
                        });

                        // Handle page size change
                        $('#pageSizeSelect').change(function() {
                            const size = $(this).val();
                            const url = new URL(window.location.href);
                            const params = new URLSearchParams(url.search);
                            
                            params.set('size', size);
                            params.set('page', 0); // Reset to first page
                            
                            showLoading();
                            window.location.href = '${ctx}/admin/customer-mgr/list?' + params.toString();
                        });

                        // Form submission with loading indicator
                        $('#filterForm').submit(function() {
                            showLoading();
                        });
                    });

                    function showLoading() {
                        document.getElementById('loadingOverlay').classList.add('active');
                    }

                    function confirmDelete(customerId, customerName) {
                        swal({
                            title: "Are you sure?",
                            text: "Do you really want to delete customer '" + customerName + "'? This action cannot be undone.",
                            icon: "warning",
                            buttons: {
                                cancel: {
                                    text: "Cancel",
                                    value: null,
                                    visible: true,
                                    className: "btn btn-secondary",
                                    closeModal: true,
                                },
                                confirm: {
                                    text: "Delete",
                                    value: true,
                                    visible: true,
                                    className: "btn btn-danger",
                                    closeModal: true
                                }
                            },
                            dangerMode: true,
                        }).then((willDelete) => {
                            if (willDelete) {
                                showLoading();
                                // Construct the URL using the context path variable 'ctx'
                                window.location.href = "${ctx}/admin/customer-mgr/delete/" + customerId;
                            }
                        });
                    }
                </script>
            </body>

            </html>