<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Quản lý phiếu nhập hàng</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />
                <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />

                <link rel="stylesheet"
                    href="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js" />
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
                                    <h3 class="fw-bold mb-3">Phiếu nhập hàng</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="${ctx}/employee/product-mgr/list">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${ctx}/employee/receipt-mgr/list">Phiếu nhập hàng</a>
                                        </li>
                                    </ul>
                                </div>

                                <%-- Display Success and Error Messages --%>
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                                            ${successMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            ${errorMessage}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                    </c:if>

                                    <!-- start receipt datatable -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="d-flex align-items-center">
                                                        <h4 class="card-title">Danh sách phiếu nhập hàng</h4>
                                                        <a href="${ctx}/employee/receipt-mgr/create"
                                                            class="btn btn-primary btn-round ms-auto">
                                                            <i class="fas fa-plus"></i> Thêm phiếu nhập mới
                                                        </a>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table id="add-row" class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>No.</th>
                                                                    <th>ID</th>
                                                                    <th>Mã phiếu</th>
                                                                    <th>Nhà cung cấp</th>
                                                                    <th>Tổng tiền</th>
                                                                    <th>Nhân viên</th>
                                                                    <th>Ngày tạo</th>
                                                                    <th style="width: 10%">Thao tác</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${receipts}" var="receipt"
                                                                    varStatus="status">
                                                                    <tr>
                                                                        <td>${status.index+1}</td>
                                                                        <td><a href="${ctx}/employee/receipt-mgr/detail/${receipt.id}"
                                                                                class="text-primary">#${receipt.id}</a>
                                                                        </td>
                                                                        <td>${receipt.receiptCode}</td>
                                                                        <td>${receipt.supplier.supplierName}</td>
                                                                        <td>
                                                                            <fmt:formatNumber
                                                                                value="${receipt.totalAmount}"
                                                                                type="currency" currencySymbol="₫" />
                                                                        </td>
                                                                        <td>${receipt.employee.firstName}
                                                                            ${receipt.employee.lastName}</td>
                                                                        <td>
                                                                            <fmt:formatDate value="${receipt.createAt}"
                                                                                pattern="dd/MM/yyyy" />
                                                                        </td>
                                                                        <td>
                                                                            <div class="btn-group">
                                                                                <a href="${ctx}/employee/receipt-mgr/update/${receipt.id}"
                                                                                    class="btn btn-sm btn-primary">
                                                                                    <i class="fas fa-edit"></i>
                                                                                </a>
                                                                                <!-- Form for delete action -->
                                                                                <form id="deleteForm-${receipt.id}"
                                                                                    action="${ctx}/employee/receipt-mgr/delete/${receipt.id}"
                                                                                    method="POST"
                                                                                    style="display:inline;">
                                                                                    <!-- Add CSRF token if needed -->
                                                                                    <c:if test="${_csrf != null}">
                                                                                        <input type="hidden"
                                                                                            name="${_csrf.parameterName}"
                                                                                            value="${_csrf.token}" />
                                                                                    </c:if>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-danger"
                                                                                        onclick="confirmDeleteReceipt('${receipt.id}', '${receipt.receiptCode}')">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </button>
                                                                                </form>
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
                <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- Scrollbar Plugin -->
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- KaiAdmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <!-- DataTables JS -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                <!-- Sweet Alert -->
                <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <script>
                    $(document).ready(function () {
                        $('#add-row').DataTable({
                            "pageLength": 10,
                            lengthMenu: [5, 10, 25, 50, 100],
                            columnDefs: [
                                {
                                    targets: [7],
                                    orderable: false,
                                    searchable: false
                                }
                            ]
                        });
                    });

                    // Delete confirmation and form submission
                    function confirmDeleteReceipt(receiptId, receiptCode) {
                        swal({
                            title: "Bạn có chắc chắn?",
                            text: "Bạn sắp xóa phiếu nhập: " + receiptCode + ". Hành động này không thể hoàn tác!",
                            icon: "warning",
                            buttons: {
                                cancel: {
                                    visible: true,
                                    text: "Hủy",
                                    className: "btn btn-secondary",
                                },
                                confirm: {
                                    text: "Xóa",
                                    className: "btn btn-danger",
                                },
                            },
                            dangerMode: true,
                        }).then((willDelete) => {
                            if (willDelete) {
                                // Submit the form if confirmed
                                document.getElementById('deleteForm-' + receiptId).submit();
                            }
                        });
                    }
                </script>
            </body>

            </html>