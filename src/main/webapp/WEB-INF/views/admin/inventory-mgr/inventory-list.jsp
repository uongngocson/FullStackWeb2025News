<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <c:set var="ctx" value="${pageContext.request.contextPath}" />

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Inventory Management</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
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
                                    <h3 class="fw-bold mb-3">Inventory Management</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="${ctx}/admin/dashboard/index">
                                                <i class="icon-home"></i>
                                            </a>
                                        </li>
                                        <li class="separator">
                                            <i class="icon-arrow-right"></i>
                                        </li>
                                        <li class="nav-item">
                                            <a href="${ctx}/admin/inventory-mgr/list">Inventory Management</a>
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

                                    <!-- start inventory datatable -->
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="d-flex align-items-center">
                                                        <h4 class="card-title">Inventory List</h4>
                                                        <%-- Removed Update Inventory button --%>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="table-responsive">
                                                        <table id="add-row" class="table table-hover">
                                                            <thead>
                                                                <tr>
                                                                    <th>No.</th>
                                                                    <%-- Removed ID column --%>
                                                                        <th>Image</th>
                                                                        <th>Product</th>
                                                                        <th>Variant</th>
                                                                        <th>Quantity</th>
                                                                        <th>Last Update</th>
                                                                        <%-- Removed Action column --%>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach items="${inventories}" var="inventory"
                                                                    varStatus="status">
                                                                    <tr>
                                                                        <td>${status.index+1}</td>
                                                                        <%-- Removed ID data --%>
                                                                            <td>
                                                                                <img src="${ctx}/${inventory.productVariant.imageUrl}"
                                                                                    alt="Product Image"
                                                                                    style="width: 50px; height: auto;">
                                                                            </td>
                                                                            <td>${inventory.productVariant.product.productName}
                                                                            </td>
                                                                            <td>${inventory.productVariant.color.colorName}
                                                                                -
                                                                                ${inventory.productVariant.size.sizeName}
                                                                            </td>
                                                                            <td>
                                                                                <span
                                                                                    class="badge ${inventory.quantityStock > 10 ? 'bg-success' : (inventory.quantityStock > 0 ? 'bg-warning' : 'bg-danger')}">
                                                                                    ${inventory.quantityStock}
                                                                                </span>
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${inventory.lastUpdate}"
                                                                                    pattern="dd/MM/yyyy HH:mm:ss" />
                                                                            </td>
                                                                            <%-- Removed Action data --%>
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
                                // Removed the columnDefs for the action column
                                // {
                                //     targets: [6], // Original index of Action column
                                //     orderable: false,
                                //     searchable: false
                                // }
                            ]
                        });
                    });
                </script>
            </body>

            </html>