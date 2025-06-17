<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Account Management</title>
                <sec:csrfMetaTags />
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <link rel="icon" href="<c:url value='/resources/assets/dashboard/img/kaiadmin/favicon.ico'/>"
                    type="image/x-icon" />

                <!-- Fonts and icons -->
                <script src="<c:url value='/resources/assets/dashboard/js/plugin/webfont/webfont.min.js'/>"></script>
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
                            urls: ["<c:url value='/resources/assets/dashboard/css/fonts.min.css'/>"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <!-- CSS Files -->
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/bootstrap.min.css'/>" />
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/plugins.min.css'/>" />
                <link rel="stylesheet" href="<c:url value='/resources/assets/dashboard/css/kaiadmin.min.css'/>" />
                <%-- CSS cho DataTables nếu cần tùy chỉnh thêm --%>
                    <link rel="stylesheet"
                        href="<c:url value='/resources/assets/dashboard/js/plugin/datatables/datatables.min.css'/>">

            </head>

            <body>
                <div class="wrapper">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div class="main-panel">
                        <jsp:include page="../layout/header.jsp" />
                        <div class="container">
                            <div class="page-inner">
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">Account Management</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="<c:url value='/admin/dashboard/index'/>">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="<c:url value='/admin/account-mgr/list'/>">Accounts</a>
                                        </li>
                                    </ul>
                                </div>
                                <div
                                    class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                                    <%-- Nút thêm mới --%>
                                        <div class="ms-md-auto py-2 py-md-0">
                                            <a href="<c:url value='/admin/account-mgr/create'/>"
                                                class="btn btn-primary btn-round">
                                                <i class="fas fa-plus me-1"></i> Add New Account
                                            </a>
                                        </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h4 class="card-title">Account List</h4>
                                            </div>
                                            <div class="card-body">
                                                <!-- Pagination info -->
                                                <div class="d-flex justify-content-between mb-3">
                                                    <div>
                                                        Showing ${accounts.size()} of ${totalItems} accounts
                                                    </div>
                                                    <div>
                                                        <form id="pageSizeForm" class="d-flex align-items-center" method="get" action="${ctx}/admin/account-mgr/list">
                                                            <label for="size" class="me-2">Items per page:</label>
                                                            <select id="size" name="size" class="form-select form-select-sm" onchange="this.form.submit()">
                                                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                                                <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                                                <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                                                                <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                                                            </select>
                                                            <input type="hidden" name="page" value="${currentPage}">
                                                        </form>
                                                    </div>
                                                </div>

                                                <div class="table-responsive">
                                                    <%-- Thêm class "table-striped table-bordered" nếu muốn --%>
                                                        <table id="accountsTable" class="display table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>NO</th>
                                                                    <th>Login Name</th>
                                                                    <th>Role</th>
                                                                    <th style="width: 10%;">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="account" items="${accounts}"
                                                                    varStatus="loop">
                                                                    <tr>
                                                                        <td>${loop.index + 1 + currentPage * pageSize}</td>
                                                                        <td>${account.loginName}</td>
                                                                        <td>${account.role.roleName}</td>
                                                                        <td>
                                                                            <div class="form-button-action">
                                                                                <%-- Sử dụng class này cho layout
                                                                                    nút đẹp hơn --%>
                                                                                    <a href="<c:url value='/admin/account-mgr/update/${account.accountId}'/>"
                                                                                        data-bs-toggle="tooltip"
                                                                                        title="Edit Account"
                                                                                        class="btn btn-link btn-primary btn-lg">
                                                                                        <i class="fa fa-edit"></i>
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        data-bs-toggle="tooltip"
                                                                                        title="Delete Account"
                                                                                        class="btn btn-link btn-danger"
                                                                                        onclick="deleteAccount('${account.accountId}')">
                                                                                        <i class="fa fa-times"></i>
                                                                                    </button>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                </div>
                                                
                                                <!-- Pagination controls -->
                                                <c:if test="${totalPages > 1}">
                                                    <nav aria-label="Account pagination">
                                                        <ul class="pagination justify-content-center mt-4">
                                                            <!-- Previous button -->
                                                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                                                <a class="page-link" href="${ctx}/admin/account-mgr/list?page=0&size=${pageSize}" aria-label="First">
                                                                    <span aria-hidden="true">&laquo;&laquo;</span>
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                                                                <a class="page-link" href="${ctx}/admin/account-mgr/list?page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                    <span aria-hidden="true">&laquo;</span>
                                                                </a>
                                                            </li>
                                                            
                                                            <!-- Page numbers -->
                                                            <c:forEach begin="${Math.max(0, currentPage - 2)}" end="${Math.min(totalPages - 1, currentPage + 2)}" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="${ctx}/admin/account-mgr/list?page=${i}&size=${pageSize}">${i + 1}</a>
                                                                </li>
                                                            </c:forEach>
                                                            
                                                            <!-- Next button -->
                                                            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="${ctx}/admin/account-mgr/list?page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
                                                                    <span aria-hidden="true">&raquo;</span>
                                                                </a>
                                                            </li>
                                                            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                                                                <a class="page-link" href="${ctx}/admin/account-mgr/list?page=${totalPages - 1}&size=${pageSize}" aria-label="Last">
                                                                    <span aria-hidden="true">&raquo;&raquo;</span>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </nav>
                                                </c:if>
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
                <script src="<c:url value='/resources/assets/dashboard/js/core/jquery-3.7.1.min.js'/>"></script>
                <script src="<c:url value='/resources/assets/dashboard/js/core/popper.min.js'/>"></script>
                <script src="<c:url value='/resources/assets/dashboard/js/core/bootstrap.min.js'/>"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js'/>"></script>

                <!-- Datatables -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/datatables/datatables.min.js'/>"></script>

                <!-- Sweet Alert -->
                <script
                    src="<c:url value='/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js'/>"></script>

                <!-- Kaiadmin JS -->
                <script src="<c:url value='/resources/assets/dashboard/js/kaiadmin.min.js'/>"></script>

                <script>
                    $(document).ready(function () {
                        // Kích hoạt DataTables
                        $('#accountsTable').DataTable();

                        // Kích hoạt Tooltips (nếu sử dụng data-bs-toggle="tooltip")
                        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                            return new bootstrap.Tooltip(tooltipTriggerEl);
                        });
                    });

                    // Lấy CSRF token từ thẻ meta (nếu có)
                    const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
                    const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

                    function deleteAccount(accountId) {
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
                                // Sử dụng URL tĩnh và thêm accountId vào cuối
                                const deleteUrl = '<c:url value="/admin/account-mgr/delete/"/>' + accountId;
                                
                                $.ajax({
                                    url: deleteUrl,
                                    type: 'POST',
                                    beforeSend: function (xhr) {
                                        if (csrfHeader && csrfToken) {
                                            xhr.setRequestHeader(csrfHeader, csrfToken);
                                        }
                                    },
                                    success: function (response) {
                                        swal("Deleted!", "The account has been deleted.", {
                                            icon: "success",
                                            buttons: {
                                                confirm: {
                                                    className: 'btn btn-success'
                                                }
                                            }
                                        }).then(function () {
                                            location.reload();
                                        });
                                    },
                                    error: function (xhr, status, error) {
                                        console.error("Error deleting account:", status, error, xhr.responseText);
                                        let errorMsg = "There was an issue deleting the account.";
                                        // Kiểm tra mã trạng thái HTTP
                                        if (xhr.status === 409) { // Conflict - Tài khoản đang sử dụng
                                            errorMsg = xhr.responseText; // Lấy thông báo lỗi từ server
                                        } else if (xhr.status === 404) { // Not Found
                                            errorMsg = xhr.responseText;
                                        } else if (xhr.status === 403) { // Forbidden - CSRF
                                            errorMsg = "Permission denied. Please refresh the page and try again.";
                                        } else if (xhr.responseText) {
                                            errorMsg = xhr.responseText; // Hiển thị lỗi chung từ server nếu có
                                        }
                                        swal("Error!", errorMsg, "error");
                                    }
                                });
                            }
                        });
                    }
                </script>
            </body>

            </html>