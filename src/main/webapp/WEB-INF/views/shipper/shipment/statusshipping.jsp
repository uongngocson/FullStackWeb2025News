<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>COD Payment Status Management</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <!-- set path -->
    <c:set var="ctx" value="${pageContext.request.contextPath}" />

    <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico" type="image/x-icon" />
    <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />

    <style>
        .status-badge {
            display: inline-block;
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
            font-weight: 500;
            border-radius: 0.375rem;
            text-transform: uppercase;
        }
        
        .status-not-submitted {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-submitted-cash {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .status-submitted-momo {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-submitted-vnpay {
            background-color: #cce5ff;
            color: #004085;
            border: 1px solid #b3d9ff;
        }
        
        .payment-card {
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .payment-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }
        
        .cod-summary-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .summary-item {
            text-align: center;
            padding: 1rem;
        }
        
        .summary-value {
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }
        
        .summary-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }
        
        .payment-methods-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .payment-method-card {
            text-align: center;
            padding: 1.5rem;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            background: white;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }
        
        .payment-method-card:hover {
            border-color: #007bff;
            background-color: #f8f9fa;
            transform: translateY(-3px);
            color: inherit;
            text-decoration: none;
        }
        
        .payment-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            border-left: 4px solid;
        }
        
        .stat-pending { border-left-color: #ffc107; }
        .stat-submitted { border-left-color: #28a745; }
        .stat-total { border-left-color: #17a2b8; }
        
        .filter-section {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        .btn-payment {
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
            border-radius: 0.25rem;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-cash {
            background-color: #28a745;
            color: white;
        }
        
        .btn-cash:hover {
            background-color: #218838;
            color: white;
            text-decoration: none;
        }
        
        .btn-momo {
            background-color: #e91e63;
            color: white;
        }
        
        .btn-momo:hover {
            background-color: #c2185b;
            color: white;
            text-decoration: none;
        }
        
        .btn-vnpay {
            background-color: #2196f3;
            color: white;
        }
        
        .btn-vnpay:hover {
            background-color: #1976d2;
            color: white;
            text-decoration: none;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
    </style>

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
                        <h4 class="page-title">COD Payment Status Management</h4>
                        <ul class="breadcrumbs">
                            <li class="nav-home">
                                <a href="#">
                                    <i class="icon-home"></i>
                                </a>
                            </li>
                            <li class="separator">
                                <i class="icon-arrow-right"></i>
                            </li>
                            <li class="nav-item">
                                <a href="${ctx}/shipper/shipment/list">Shipments</a>
                            </li>
                            <li class="separator">
                                <i class="icon-arrow-right"></i>
                            </li>
                            <li class="nav-item">
                                <a href="#">COD Status</a>
                            </li>
                        </ul>
                    </div>

                    <!-- Message Alerts -->
                    <div class="row">
                        <div class="col-md-12">
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fa fa-check-circle mr-2"></i>${successMessage}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fa fa-exclamation-triangle mr-2"></i>${errorMessage}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- COD Summary Dashboard -->
                    <div class="cod-summary-card">
                        <div class="row">
                            <div class="col-md-3 summary-item">
                                <div class="summary-value">
                                    <c:set var="totalPending" value="0" />
                                    <c:forEach var="codPayment" items="${codPayments}">
                                        <c:if test="${codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                            <c:set var="totalPending" value="${totalPending + codPayment.amount}" />
                                        </c:if>
                                    </c:forEach>
                                    <fmt:formatNumber value="${totalPending}" type="currency" currencySymbol="₫" />
                                </div>
                                <div class="summary-label">Chưa Nộp</div>
                            </div>
                            <div class="col-md-3 summary-item">
                                <div class="summary-value">
                                    <c:set var="totalSubmitted" value="0" />
                                    <c:forEach var="codPayment" items="${codPayments}">
                                        <c:if test="${codPayment.submittedStatus != 'NOT_SUBMITTED'}">
                                            <c:set var="totalSubmitted" value="${totalSubmitted + codPayment.amount}" />
                                        </c:if>
                                    </c:forEach>
                                    <fmt:formatNumber value="${totalSubmitted}" type="currency" currencySymbol="₫" />
                                </div>
                                <div class="summary-label">Đã Nộp</div>
                            </div>
                            <div class="col-md-3 summary-item">
                                <div class="summary-value">
                                    <c:set var="pendingCount" value="0" />
                                    <c:forEach var="codPayment" items="${codPayments}">
                                        <c:if test="${codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${pendingCount}
                                </div>
                                <div class="summary-label">Giao Dịch Chưa Nộp</div>
                            </div>
                            <div class="col-md-3 summary-item">
                                <div class="summary-value">${fn:length(codPayments)}</div>
                                <div class="summary-label">Tổng Giao Dịch</div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Payment Methods -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">
                                        <i class="fas fa-hand-holding-usd mr-2"></i>
                                        Phương Thức Nộp Tiền Nhanh
                                    </h4>
                                </div>
                                <div class="card-body">
                                    <div class="payment-methods-grid">
                                        <div class="payment-method-card">
                                            <div class="payment-icon text-success">
                                                <i class="fas fa-money-bill-wave"></i>
                                            </div>
                                            <h6>Tiền Mặt</h6>
                                            <p class="text-muted small">Nộp trực tiếp tại văn phòng</p>
                                            <c:if test="${pendingCount > 0}">
                                                <form action="${ctx}/shipper/cod/submitAll" method="post" style="display: inline;">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="paymentMethod" value="CASH" />
                                                    <button type="submit" class="btn btn-success btn-sm"
                                                            onclick="return confirm('Xác nhận nộp tất cả COD bằng tiền mặt?');">
                                                        Nộp Tất Cả
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                        
                                        <div class="payment-method-card">
                                            <div class="payment-icon text-danger">
                                                <i class="fab fa-cc-apple-pay"></i>
                                            </div>
                                            <h6>MoMo</h6>
                                            <p class="text-muted small">Thanh toán qua ví MoMo</p>
                                            <c:if test="${pendingCount > 0}">
                                                <a href="${ctx}/shipper/cod/payAll?method=MOMO" class="btn btn-danger btn-sm">
                                                    Thanh Toán
                                                </a>
                                            </c:if>
                                        </div>
                                        
                                        <div class="payment-method-card">
                                            <div class="payment-icon text-primary">
                                                <i class="fas fa-credit-card"></i>
                                            </div>
                                            <h6>VNPay</h6>
                                            <p class="text-muted small">Thanh toán qua VNPay</p>
                                            <c:if test="${pendingCount > 0}">
                                                <a href="${ctx}/shipper/cod/payAll?method=VNPAY" class="btn btn-primary btn-sm">
                                                    Thanh Toán
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Filter Section -->
                    <div class="filter-section">
                        <form method="get" action="${ctx}/shipper/shipment/statusshipping">
                            <div class="row align-items-end">
                                <div class="col-md-3">
                                    <label for="statusFilter" class="form-label">Trạng Thái</label>
                                    <select class="form-control" id="statusFilter" name="status">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="NOT_SUBMITTED" ${param.status == 'NOT_SUBMITTED' ? 'selected' : ''}>Chưa Nộp</option>
                                        <option value="SUBMITTED_CASH" ${param.status == 'SUBMITTED_CASH' ? 'selected' : ''}>Đã Nộp (Tiền Mặt)</option>
                                        <option value="SUBMITTED_MOMO" ${param.status == 'SUBMITTED_MOMO' ? 'selected' : ''}>Đã Nộp (MoMo)</option>
                                        <option value="SUBMITTED_VNPAY" ${param.status == 'SUBMITTED_VNPAY' ? 'selected' : ''}>Đã Nộp (VNPay)</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label for="dateFrom" class="form-label">Từ Ngày</label>
                                    <input type="date" class="form-control" id="dateFrom" name="dateFrom" value="${param.dateFrom}">
                                </div>
                                <div class="col-md-3">
                                    <label for="dateTo" class="form-label">Đến Ngày</label>
                                    <input type="date" class="form-control" id="dateTo" name="dateTo" value="${param.dateTo}">
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search mr-1"></i>Lọc
                                    </button>
                                    <a href="${ctx}/shipper/shipment/statusshipping" class="btn btn-secondary ml-2">
                                        <i class="fa fa-refresh mr-1"></i>Reset
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- COD Payments Table -->
                    <div class="table-container">
                        <div class="card">
                            <div class="card-header">
                                <div class="d-flex align-items-center">
                                    <h4 class="card-title">
                                        <i class="fas fa-list mr-2"></i>
                                        Danh Sách COD Payments
                                    </h4>
                                    <div class="ml-auto">
                                        <span class="badge badge-info">
                                            Tổng: ${fn:length(codPayments)} giao dịch
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty codPayments}">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th>COD ID</th>
                                                        <th>Shipment ID</th>
                                                        <th>Đơn Hàng</th>
                                                        <th>Khách Hàng</th>
                                                        <th>Số Tiền</th>
                                                        <th>Ngày Thu</th>
                                                        <th>Ngày Nộp</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Thao Tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="codPayment" items="${codPayments}">
                                                        <tr class="payment-card">
                                                            <td>
                                                                <strong class="text-primary">#${codPayment.codPaymentId}</strong>
                                                            </td>
                                                            <td>
                                                                <a href="${ctx}/shipper/shipment/edit?shipmentId=${codPayment.shipment.shipmentId}" 
                                                                   class="text-decoration-none">
                                                                    #${codPayment.shipment.shipmentId}
                                                                </a>
                                                            </td>
                                                            <td>
                                                                <span class="font-weight-bold">${codPayment.shipment.order.orderId}</span>
                                                            </td>
                                                            <td>
                                                                ${codPayment.shipment.order.customer.firstName} 
                                                                ${codPayment.shipment.order.customer.lastName}
                                                            </td>
                                                            <td>
                                                                <span class="font-weight-bold text-warning">
                                                                    <fmt:formatNumber value="${codPayment.amount}" type="currency" currencySymbol="₫" />
                                                                </span>
                                                            </td>
                                                            <td>
                                                                ${codPayment.collectedDate}
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty codPayment.submittedDate}">
                                                                        ${codPayment.submittedDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">--</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                                                        <span class="status-badge status-not-submitted">
                                                                            <i class="fa fa-clock mr-1"></i>Chưa Nộp
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_CASH'}">
                                                                        <span class="status-badge status-submitted-cash">
                                                                            <i class="fa fa-money-bill mr-1"></i>Tiền Mặt
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_MOMO'}">
                                                                        <span class="status-badge status-submitted-momo">
                                                                            <i class="fab fa-cc-apple-pay mr-1"></i>MoMo
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_VNPAY'}">
                                                                        <span class="status-badge status-submitted-vnpay">
                                                                            <i class="fa fa-credit-card mr-1"></i>VNPay
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge badge-secondary">${codPayment.submittedStatus}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                                                        <div class="action-buttons">
                                                                            <!-- Cash Payment Form -->
                                                                            <form action="${ctx}/shipper/cod/submit" method="post" style="display: inline;">
                                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                                <input type="hidden" name="codPaymentId" value="${codPayment.codPaymentId}" />
                                                                                <input type="hidden" name="paymentMethod" value="CASH" />
                                                                                <button type="submit" class="btn-payment btn-cash" 
                                                                                        onclick="return confirm('Xác nhận nộp COD bằng tiền mặt?');"
                                                                                        title="Nộp bằng tiền mặt">
                                                                                    <i class="fa fa-money-bill"></i>
                                                                                </button>
                                                                            </form>
                                                                            
                                                                            <!-- MoMo Payment Link -->
                                                                            <a href="${ctx}/shipper/cod/pay?codPaymentId=${codPayment.codPaymentId}&method=MOMO" 
                                                                               class="btn-payment btn-momo"
                                                                               title="Thanh toán qua MoMo">
                                                                                <i class="fab fa-cc-apple-pay"></i>
                                                                            </a>
                                                                            
                                                                            <!-- VNPay Payment Link -->
                                                                            <a href="${ctx}/shipper/cod/pay?codPaymentId=${codPayment.codPaymentId}&method=VNPAY" 
                                                                               class="btn-payment btn-vnpay"
                                                                               title="Thanh toán qua VNPay">
                                                                                <i class="fa fa-credit-card"></i>
                                                                            </a>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-success">
                                                                            <i class="fa fa-check-circle mr-1"></i>Đã Hoàn Thành
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="empty-state">
                                            <i class="fas fa-receipt"></i>
                                            <h5>Không có giao dịch COD nào</h5>
                                            <p class="text-muted">
                                                Chưa có giao dịch COD nào được tạo. 
                                                <a href="${ctx}/shipper/shipment/list" class="text-primary">Quay lại danh sách vận đơn</a>
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <c:if test="${not empty codPayments}">
                        <div class="quick-stats">
                            <div class="stat-card stat-pending">
                                <h3 class="text-warning">${pendingCount}</h3>
                                <p class="mb-0">Giao Dịch Chưa Nộp</p>
                            </div>
                            <div class="stat-card stat-submitted">
                                <h3 class="text-success">${fn:length(codPayments) - pendingCount}</h3>
                                <p class="mb-0">Giao Dịch Đã Nộp</p>
                            </div>
                            <div class="stat-card stat-total">
                                <h3 class="text-info">
                                    <fmt:formatNumber value="${totalPending + totalSubmitted}" type="currency" currencySymbol="₫" />
                                </h3>
                                <p class="mb-0">Tổng Giá Trị COD</p>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>

    <!-- Core JS Files -->
    <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
    <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
    <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

    <script>
        // Simple confirmation dialogs
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-hide alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                setTimeout(function() {
                    alert.style.transition = 'opacity 0.5s';
                    alert.style.opacity = '0';
                    setTimeout(function() {
                        alert.remove();
                    }, 500);
                }, 5000);
            });
        });
    </script>
</body>

</html>
