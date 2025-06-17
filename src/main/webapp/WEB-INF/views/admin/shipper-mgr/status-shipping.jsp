<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tiền COD - Shipper Management</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->

    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
            --card-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --border-radius: 0.5rem;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .main-content {
            padding: 2rem 0;
        }

        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: var(--border-radius);
            color: white;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .stats-card .icon {
            font-size: 2.5rem;
            opacity: 0.8;
        }

        .card {
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            transition: box-shadow 0.3s ease;
        }

        .card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .table-responsive {
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .table thead th {
            background-color: var(--primary-color);
            color: white;
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: background-color 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }

        .status-badge {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 0.4rem 0.8rem;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-submitted {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }
        
        .status-pending-approval {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            animation: pulse-warning 2s infinite;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        @keyframes pulse-warning {
            0% { box-shadow: 0 0 0 0 rgba(231, 76, 60, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(231, 76, 60, 0); }
            100% { box-shadow: 0 0 0 0 rgba(231, 76, 60, 0); }
        }

        .btn-custom {
            border-radius: 50px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #2980b9 100%);
            border: none;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9 0%, var(--secondary-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #229954 100%);
            border: none;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #229954 0%, var(--success-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e67e22 100%);
            border: none;
            color: white;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e67e22 0%, var(--warning-color) 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
            color: white;
        }

        .amount-text {
            font-weight: 700;
            font-size: 1.1rem;
        }

        .shipper-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--card-shadow);
            border-left: 4px solid var(--secondary-color);
            transition: all 0.3s ease;
        }

        .shipper-card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transform: translateX(5px);
        }

        .shipper-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--secondary-color);
        }

        .form-control, .form-select {
            border-radius: var(--border-radius);
            border: 2px solid #e9ecef;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .alert {
            border: none;
            border-radius: var(--border-radius);
            border-left: 4px solid;
        }

        .alert-success {
            border-left-color: var(--success-color);
            background-color: #d4edda;
        }

        .alert-danger {
            border-left-color: var(--danger-color);
            background-color: #f8d7da;
        }

        .pagination .page-link {
            border: none;
            color: var(--primary-color);
            border-radius: 50%;
            margin: 0 2px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .pagination .page-link:hover {
            background-color: var(--secondary-color);
            color: white;
            transform: translateY(-2px);
        }

        .pagination .page-item.active .page-link {
            background-color: var(--primary-color);
            color: white;
        }

        .search-box {
            position: relative;
        }

        .search-box .form-control {
            padding-left: 3rem;
        }

        .search-box .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .loading-spinner {
            display: none;
        }

        .loading .loading-spinner {
            display: inline-block;
        }

        .bulk-actions {
            background: white;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            box-shadow: var(--card-shadow);
        }

        .checkbox-custom {
            transform: scale(1.2);
            accent-color: var(--secondary-color);
        }

        @media (max-width: 768px) {
            .table-responsive {
                font-size: 0.875rem;
            }
            
            .btn-custom {
                font-size: 0.8rem;
                padding: 0.4rem 1rem;
            }
            
            .stats-card .icon {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/admin/dashboard/index">
                <i class="fas fa-shipping-fast me-2"></i>
                Quản Lý Shipper Shop DDTS
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/admin/shipper-mgr/list">
                    <i class="fas fa-users me-1"></i>
                    Quản Lý Shipper
                </a>
                <a class="nav-link" href="/admin/cod-management/dashboard">
                    <i class="fas fa-money-bill-wave me-1"></i>
                    Quản Lý COD
                </a>
            </div>
        </div>
    </nav>

    <div class="container main-content">
        <!-- Alert Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Page Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h1 class="h2 mb-0">
                            <i class="fas fa-money-check-alt text-primary me-2"></i>
                            Quản Lý Tiền COD
                        </h1>
                        <p class="text-muted mb-0">Theo dõi và quản lý tiền thu hộ của các shipper</p>
                    </div>
                    <div>
                        <button class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#statisticsModal">
                            <i class="fas fa-chart-bar me-2"></i>
                            Thống Kê
                        </button>
                        <c:if test="${totalSubmittedPendingApproval > 0}">
                            <a href="/admin/cod-management/pending-approval" class="btn btn-warning btn-custom ms-2">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                Duyệt Tiền Mặt
                                <span class="badge bg-danger ms-1">
                                    <fmt:formatNumber value="${totalSubmittedPendingApproval}" type="number" maxFractionDigits="0" />₫
                                </span>
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Overall Statistics -->
        <c:if test="${not empty shippers}">
            <div class="row mb-4">
                <c:set var="totalShippers" value="${shippers.size()}" />
                <c:set var="totalCollected" value="0" />
                <c:set var="totalPending" value="0" />
                <c:set var="totalSubmitted" value="0" />
                <c:set var="totalSubmittedPendingApproval" value="0" />
                
                <c:forEach var="entry" items="${shipperStats}">
                    <c:set var="totalCollected" value="${totalCollected + entry.value['totalCollected']}" />
                    <c:set var="totalPending" value="${totalPending + entry.value['totalPending']}" />
                    <c:set var="totalSubmitted" value="${totalSubmitted + entry.value['totalSubmitted']}" />
                    <c:set var="totalSubmittedPendingApproval" value="${totalSubmittedPendingApproval + entry.value['totalSubmittedPendingApproval']}" />
                </c:forEach>
                
                <!-- First Row of Stats -->
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stats-card h-100">
                        <div class="card-body text-center">
                            <div class="icon mb-3">
                                <i class="fas fa-users"></i>
                            </div>
                            <h5 class="card-title">Tổng Shipper</h5>
                            <h3 class="mb-0">${totalShippers}</h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stats-card h-100" style="background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);">
                        <div class="card-body text-center">
                            <div class="icon mb-3">
                                <i class="fas fa-money-bill-wave"></i>
                            </div>
                            <h5 class="card-title">Tổng Thu Được</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${totalCollected}" type="number" maxFractionDigits="0" />₫
                            </h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stats-card h-100" style="background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);">
                        <div class="card-body text-center">
                            <div class="icon mb-3">
                                <i class="fas fa-clock"></i>
                            </div>
                            <h5 class="card-title">Chưa Nộp</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${totalPending}" type="number" maxFractionDigits="0" />₫
                            </h3>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6 mb-3">
                    <div class="card stats-card h-100" style="background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);">
                        <div class="card-body text-center">
                            <div class="icon mb-3">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h5 class="card-title">Đã Duyệt</h5>
                            <h3 class="mb-0">
                                <fmt:formatNumber value="${totalSubmitted}" type="number" maxFractionDigits="0" />₫
                            </h3>
                        </div>
                    </div>
                </div>
                
                <!-- New Second Row for Pending Approval -->
                <c:if test="${totalSubmittedPendingApproval > 0}">
                    <div class="col-12 mb-3">
                        <div class="card stats-card h-100" style="background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);">
                            <div class="card-body text-center">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <div class="icon">
                                            <i class="fas fa-exclamation-triangle"></i>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <h5 class="card-title mb-1">⚠️ Tiền Mặt Chờ Duyệt</h5>
                                        <h3 class="mb-0">
                                            <fmt:formatNumber value="${totalSubmittedPendingApproval}" type="number" maxFractionDigits="0" />₫
                                        </h3>
                                        <small class="opacity-75">Yêu cầu admin duyệt để hoàn tất</small>
                                    </div>
                                    <!-- <div class="col-md-2 hidden">
                                        <a href="/admin/cod-management/pending-approval" class="btn btn-light btn-sm">
                                            <i class="fas fa-eye me-1"></i>
                                            Xem Chi Tiết
                                        </a>
                                    </div> -->
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- Shipper Detail View -->
        <c:if test="${not empty shipper}">
            <div class="row">
                <!-- Shipper Info -->
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">
                                <i class="fas fa-user me-2"></i>
                                Thông Tin Shipper
                            </h5>
                        </div>
                        <div class="card-body text-center">
                            <c:choose>
                                <c:when test="${not empty shipper.imageUrl}">
                                    <img src="${shipper.imageUrl}" alt="Avatar" class="shipper-avatar mb-3">
                                </c:when>
                                <c:otherwise>
                                    <div class="shipper-avatar mb-3 d-flex align-items-center justify-content-center bg-secondary text-white mx-auto">
                                        <i class="fas fa-user fa-2x"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <h5>${shipper.firstName} ${shipper.lastName}</h5>
                            <p class="text-muted mb-2">
                                <i class="fas fa-envelope me-1"></i>
                                ${shipper.email}
                            </p>
                            <p class="text-muted mb-3">
                                <i class="fas fa-phone me-1"></i>
                                ${shipper.phone}
                            </p>
                            
                            <!-- Statistics -->
                            <div class="row text-center">
                                <div class="col-3">
                                    <h6 class="text-success">
                                        <fmt:formatNumber value="${totalCollected}" type="number" maxFractionDigits="0" />₫
                                    </h6>
                                    <small class="text-muted">Tổng Thu</small>
                                </div>
                                <div class="col-3">
                                    <h6 class="text-warning">
                                        <fmt:formatNumber value="${totalPending}" type="number" maxFractionDigits="0" />₫
                                    </h6>
                                    <small class="text-muted">Chưa Nộp</small>
                                </div>
                                <div class="col-3">
                                    <h6 class="text-danger">
                                        <fmt:formatNumber value="${totalSubmittedPendingApproval}" type="number" maxFractionDigits="0" />₫
                                    </h6>
                                    <small class="text-muted">Chờ Duyệt</small>
                                </div>
                                <div class="col-3">
                                    <h6 class="text-primary">
                                        <fmt:formatNumber value="${totalSubmitted}" type="number" maxFractionDigits="0" />₫
                                    </h6>
                                    <small class="text-muted">Đã Duyệt</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- COD Payments List -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header bg-light">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <h5 class="mb-0">
                                        <i class="fas fa-list me-2"></i>
                                        Danh Sách COD
                                    </h5>
                                </div>
                                <div class="col-md-6">
                                    <form method="get" class="d-flex">
                                        <input type="hidden" name="shipperId" value="${shipper.employeeId}">
                                        <select name="status" class="form-select me-2" onchange="this.form.submit()">
                                            <option value="">Tất cả trạng thái</option>
                                            <option value="NOT_SUBMITTED" ${currentStatus == 'NOT_SUBMITTED' ? 'selected' : ''}>Chưa nộp</option>
                                            <option value="SUBMITTED_CASH" ${currentStatus == 'SUBMITTED_CASH' ? 'selected' : ''}>Đã nộp tiền mặt</option>
                                            <option value="SUBMITTED_MOMO" ${currentStatus == 'SUBMITTED_MOMO' ? 'selected' : ''}>Đã nộp MoMo</option>
                                            <option value="SUBMITTED_VNPAY" ${currentStatus == 'SUBMITTED_VNPAY' ? 'selected' : ''}>Đã nộp VNPay</option>
                                            <option value="ADMIN_APPROVED" ${currentStatus == 'ADMIN_APPROVED' ? 'selected' : ''}>Admin duyệt</option>
                                        </select>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <c:choose>
                                <c:when test="${not empty codPayments}">
                                    <!-- Bulk Actions -->
                                    <div class="bulk-actions">
                                        <form id="bulkActionForm" method="post" action="/admin/cod-management/bulk-approve">
                                            <div class="row align-items-center">
                                                <div class="col-md-6">
                                                    <div class="form-check">
                                                        <input type="checkbox" class="form-check-input checkbox-custom" id="selectAll">
                                                        <label class="form-check-label fw-bold" for="selectAll">
                                                            Chọn tất cả
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6 text-end">
                                                    <button type="submit" class="btn btn-success btn-custom" id="bulkApproveBtn" disabled>
                                                        <i class="fas fa-check me-2"></i>
                                                        Duyệt các mục đã chọn
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0">
                                            <thead>
                                                <tr>
                                                    <th style="width: 50px;">
                                                        <input type="checkbox" class="form-check-input checkbox-custom" id="selectAllTable">
                                                    </th>
                                                    <th>ID Giao Hàng</th>
                                                    <th>Số Tiền</th>
                                                    <th>Ngày Thu</th>
                                                    <th>Ngày Nộp</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Thao Tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="payment" items="${codPayments}">
                                                    <tr>
                                                        <td>
                                                            <input type="checkbox" class="form-check-input checkbox-custom payment-checkbox" 
                                                                   name="selectedPayments" value="${payment.codPaymentId}"
                                                                   ${(payment.submittedStatus != 'NOT_SUBMITTED' && payment.submittedStatus != 'SUBMITTED_CASH') ? 'disabled' : ''}>
                                                        </td>
                                                        <td>
                                                            <strong>#${payment.shipment.shipmentId}</strong>
                                                            <br>
                                                            <small class="text-muted">Tracking: ${payment.shipment.trackingNumber}</small>
                                                        </td>
                                                        <td>
                                                            <span class="amount-text text-success">
                                                                <fmt:formatNumber value="${payment.amount}" type="number" maxFractionDigits="0" />₫
                                                            </span>
                                                        </td>
                                                        <td>
                                                            ${payment.collectedDate}
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty payment.submittedDate}">
                                                                    ${payment.submittedDate}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">---</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${payment.submittedStatus == 'NOT_SUBMITTED'}">
                                                                    <span class="status-badge status-pending">
                                                                        <i class="fas fa-clock me-1"></i>
                                                                        Chưa nộp
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${payment.submittedStatus == 'SUBMITTED_CASH'}">
                                                                    <span class="status-badge status-pending-approval">
                                                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                                                        Tiền mặt
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${payment.submittedStatus == 'ADMIN_APPROVED'}">
                                                                    <span class="status-badge status-approved">
                                                                        <i class="fas fa-check-circle me-1"></i>
                                                                        Admin duyệt
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge status-submitted">
                                                                        <i class="fas fa-check me-1"></i>
                                                                        ${payment.submittedStatus.replace('SUBMITTED_', '')}
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${payment.submittedStatus == 'NOT_SUBMITTED'}">
                                                                    <form method="post" action="/admin/cod-management/approve/${payment.codPaymentId}" class="d-inline">
                                                                        <button type="submit" class="btn btn-sm btn-success btn-custom"
                                                                                onclick="return confirm('Xác nhận duyệt thanh toán này?')">
                                                                            <i class="fas fa-check me-1"></i>
                                                                            Duyệt
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:when test="${payment.submittedStatus == 'SUBMITTED_CASH'}">
                                                                    <form method="post" action="/admin/cod-management/approve/${payment.codPaymentId}" class="d-inline">
                                                                        <button type="submit" class="btn btn-sm btn-warning btn-custom"
                                                                                onclick="return confirm('Xác nhận duyệt tiền mặt này? Hành động này không thể hoàn tác.')">
                                                                            <i class="fas fa-hand-holding-usd me-1"></i>
                                                                            Duyệt Tiền Mặt
                                                                        </button>
                                                                    </form>
                                                                </c:when>
                                                                <c:when test="${payment.submittedStatus == 'ADMIN_APPROVED'}">
                                                                    <span class="text-success">
                                                                        <i class="fas fa-check-circle me-1"></i>
                                                                        Đã duyệt
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-info">
                                                                        <i class="fas fa-info-circle me-1"></i>
                                                                        Tự động xử lý
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
                                    <div class="text-center py-5">
                                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Chưa có dữ liệu COD</h5>
                                        <p class="text-muted">Shipper này chưa có giao dịch COD nào.</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Shipper List Overview -->
        <c:if test="${empty shipper and not empty shippers}">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header bg-light">
                            <div class="row align-items-center">
                                <div class="col-md-6">
                                    <h5 class="mb-0">
                                        <i class="fas fa-users me-2"></i>
                                        Danh Sách Shipper
                                    </h5>
                                </div>
                                <div class="col-md-6">
                                    <div class="search-box">
                                        <i class="fas fa-search search-icon"></i>
                                        <input type="text" class="form-control" id="shipperSearch" 
                                               placeholder="Tìm kiếm shipper...">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row" id="shipperList">
                                <c:forEach var="shipper" items="${shippers}">
                                    <div class="col-md-6 col-lg-4 mb-3 shipper-item" 
                                         data-name="${shipper.firstName} ${shipper.lastName}"
                                         data-email="${shipper.email}">
                                        <div class="shipper-card">
                                            <div class="d-flex align-items-center mb-3">
                                                <c:choose>
                                                    <c:when test="${not empty shipper.imageUrl}">
                                                        <img src="${shipper.imageUrl}" alt="Avatar" class="shipper-avatar me-3">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="shipper-avatar me-3 d-flex align-items-center justify-content-center bg-secondary text-white">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="flex-grow-1">
                                                    <h6 class="mb-1">${shipper.firstName} ${shipper.lastName}</h6>
                                                    <small class="text-muted">${shipper.email}</small>
                                                </div>
                                                <c:if test="${shipper.status}">
                                                    <span class="badge bg-success">Active</span>
                                                </c:if>
                                                <c:if test="${not shipper.status}">
                                                    <span class="badge bg-danger">Inactive</span>
                                                </c:if>
                                            </div>
                                            
                                            <div class="row text-center mb-3">
                                                <div class="col-3">
                                                    <small class="text-muted">Tổng Thu</small>
                                                    <div class="fw-bold text-success">
                                                        <fmt:formatNumber value="${shipperStats[shipper]['totalCollected']}" type="number" maxFractionDigits="0" />₫
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <small class="text-muted">Chưa Nộp</small>
                                                    <div class="fw-bold text-warning">
                                                        <fmt:formatNumber value="${shipperStats[shipper]['totalPending']}" type="number" maxFractionDigits="0" />₫
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <small class="text-muted">Chờ Duyệt</small>
                                                    <div class="fw-bold text-danger">
                                                        <fmt:formatNumber value="${shipperStats[shipper]['totalSubmittedPendingApproval']}" type="number" maxFractionDigits="0" />₫
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <small class="text-muted">Đã Duyệt</small>
                                                    <div class="fw-bold text-primary">
                                                        <fmt:formatNumber value="${shipperStats[shipper]['totalSubmitted']}" type="number" maxFractionDigits="0" />₫
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="text-center">
                                                <a href="/admin/cod-management/shipper/${shipper.employeeId}" 
                                                   class="btn btn-primary btn-custom btn-sm">
                                                    <i class="fas fa-eye me-1"></i>
                                                    Xem Chi Tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <c:if test="${shippers.size() == 0}">
                                <div class="text-center py-5">
                                    <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có shipper nào</h5>
                                    <p class="text-muted">Hiện tại chưa có shipper nào trong hệ thống.</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Statistics Modal -->
    <div class="modal fade" id="statisticsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-chart-bar me-2"></i>
                        Thống Kê Chi Tiết
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form method="get" action="/admin/cod-management/statistics">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Từ ngày</label>
                                <input type="date" name="fromDate" class="form-control" 
                                       value="${fromDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Đến ngày</label>
                                <input type="date" name="toDate" class="form-control" 
                                       value="${toDate}" required>
                            </div>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary btn-custom">
                                <i class="fas fa-search me-2"></i>
                                Xem Thống Kê
                            </button>
                        </div>
                    </form>
                    
                    <c:if test="${not empty shipperTotals}">
                        <hr>
                        <h6>Kết quả thống kê từ ${fromDate} đến ${toDate}</h6>
                        <div class="table-responsive">
                            <table class="table table-sm">
                                <thead>
                                    <tr>
                                        <th>Shipper</th>
                                        <th>Tổng Thu (₫)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${shipperTotals}">
                                        <tr>
                                            <td>${entry.key.firstName} ${entry.key.lastName}</td>
                                            <td class="text-end">
                                                <span class="fw-bold text-success">
                                                    <fmt:formatNumber value="${entry.value}" type="number" maxFractionDigits="0" />₫
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Select All functionality
        document.addEventListener('DOMContentLoaded', function() {
            const selectAllCheckboxes = document.querySelectorAll('#selectAll, #selectAllTable');
            const paymentCheckboxes = document.querySelectorAll('.payment-checkbox');
            const bulkApproveBtn = document.getElementById('bulkApproveBtn');
            const bulkActionForm = document.getElementById('bulkActionForm');

            // Handle select all
            selectAllCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    const isChecked = this.checked;
                    paymentCheckboxes.forEach(cb => {
                        if (!cb.disabled) {
                            cb.checked = isChecked;
                        }
                    });
                    updateBulkActionButton();
                    
                    // Sync both select all checkboxes
                    selectAllCheckboxes.forEach(cb => {
                        if (cb !== this) {
                            cb.checked = isChecked;
                        }
                    });
                });
            });

            // Handle individual checkbox changes
            paymentCheckboxes.forEach(checkbox => {
                checkbox.addEventListener('change', function() {
                    updateBulkActionButton();
                    updateSelectAllState();
                });
            });

            function updateBulkActionButton() {
                const checkedBoxes = document.querySelectorAll('.payment-checkbox:checked');
                bulkApproveBtn.disabled = checkedBoxes.length === 0;
                
                // Update form with selected IDs
                const existingInputs = bulkActionForm.querySelectorAll('input[name="codPaymentIds"]');
                existingInputs.forEach(input => input.remove());
                
                checkedBoxes.forEach(checkbox => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'codPaymentIds';
                    input.value = checkbox.value;
                    bulkActionForm.appendChild(input);
                });
            }

            function updateSelectAllState() {
                const enabledCheckboxes = document.querySelectorAll('.payment-checkbox:not(:disabled)');
                const checkedBoxes = document.querySelectorAll('.payment-checkbox:checked');
                const allChecked = enabledCheckboxes.length > 0 && checkedBoxes.length === enabledCheckboxes.length;
                
                selectAllCheckboxes.forEach(checkbox => {
                    checkbox.checked = allChecked;
                    checkbox.indeterminate = checkedBoxes.length > 0 && checkedBoxes.length < enabledCheckboxes.length;
                });
            }

            // Search functionality
            const searchInput = document.getElementById('shipperSearch');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    const shipperItems = document.querySelectorAll('.shipper-item');
                    
                    shipperItems.forEach(item => {
                        const name = item.dataset.name.toLowerCase();
                        const email = item.dataset.email.toLowerCase();
                        const matches = name.includes(searchTerm) || email.includes(searchTerm);
                        item.style.display = matches ? 'block' : 'none';
                    });
                });
            }

            // Form validation
            const forms = document.querySelectorAll('form[method="post"]');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const button = form.querySelector('button[type="submit"]');
                    if (button && !button.disabled) {
                        button.disabled = true;
                        button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
                        
                        // Re-enable after 5 seconds to prevent permanent disable if something goes wrong
                        setTimeout(() => {
                            button.disabled = false;
                            button.innerHTML = button.dataset.originalText || button.innerHTML.replace(/Đang xử lý\.\.\./, 'Duyệt');
                        }, 5000);
                    }
                });
            });

            // Auto dismiss alerts after 5 seconds
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</body>
</html>
