<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Update Shipment</title>
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
                                    <h4 class="page-title">Update Shipment</h4>
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
                                            <a href="#">Order Management</a>
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
                                            <a href="#">Update Shipment</a>
                                        </li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <c:if test="${not empty successMessage}">
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                ${successMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty errorMessage}">
                                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                                ${errorMessage}
                                                <button type="button" class="close" data-dismiss="alert"
                                                    aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <div class="card-title">Update Shipment Status</div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6 mx-auto">
                                                    <form id="shipmentUpdateForm" action="${ctx}/shipper/shipment/update" method="post">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <input type="hidden" name="shipmentId"
                                                            value="${shipment.shipmentId}">

                                                        <div class="form-group">
                                                            <label for="shipmentId">Shipment ID</label>
                                                            <input type="text" class="form-control" id="shipmentId"
                                                                value="${shipment.shipmentId}" disabled>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="orderId">Order ID</label>
                                                            <input type="text" class="form-control" id="orderId"
                                                                value="${shipment.order.orderId}" disabled>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="customerName">Customer Name</label>
                                                            <input type="text" class="form-control" id="customerName"
                                                                value="${shipment.order.customer.firstName} ${shipment.order.customer.lastName}"
                                                                disabled>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="trackingNumber">Tracking Number</label>
                                                            <input type="text" class="form-control" id="trackingNumber"
                                                                value="${shipment.trackingNumber}" disabled>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="status">Status</label>
                                                            <select class="form-control" id="status" name="status"
                                                                required>
                                                                <option value="SHIPPING" ${shipment.status=='SHIPPING'
                                                                    ? 'selected' : '' }>SHIPPING</option>
                                                                <option value="COMPLETED" ${shipment.status=='COMPLETED'
                                                                    ? 'selected' : '' }>COMPLETED</option>
                                                                <option value="RETURNED" ${shipment.status=='RETURNED'
                                                                    ? 'selected' : '' }>RETURNED</option>
                                                            </select>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="paymentMethod">Payment Method</label>
                                                            <input type="text" class="form-control" id="paymentMethod"
                                                                value="${shipment.paymentMethod}" disabled>
                                                        </div>

                                                        <!-- Payment Status Section -->
                                                        <c:choose>
                                                            <c:when test="${shipment.paymentMethod == 'COD'}">
                                                                <!-- COD Payment Section -->
                                                                <div class="form-group">
                                                                    <label>COD Payment Status</label>
                                                                    <c:choose>
                                                                        <c:when test="${codPayment != null}">
                                                                            <div class="alert alert-info">
                                                                                <strong>COD Amount:</strong> 
                                                                                <fmt:formatNumber value="${codPayment.amount}" type="currency" currencySymbol="₫" />
                                                                                <br>
                                                                                <strong>Collection Date:</strong> ${codPayment.collectedDate}
                                                                                <br>
                                                                                <strong>Status:</strong> 
                                                                                <c:choose>
                                                                                    <c:when test="${codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                                                                        <span class="badge badge-warning">CHƯA NỘP</span>
                                                                                    </c:when>
                                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_CASH'}">
                                                                                        <span class="badge badge-success">ĐÃ NỘP (TIỀN MẶT)</span>
                                                                                    </c:when>
                                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_MOMO'}">
                                                                                        <span class="badge badge-success">ĐÃ NỘP (MOMO)</span>
                                                                                    </c:when>
                                                                                    <c:when test="${codPayment.submittedStatus == 'SUBMITTED_VNPAY'}">
                                                                                        <span class="badge badge-success">ĐÃ NỘP (VNPAY)</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span class="badge badge-secondary">${codPayment.submittedStatus}</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <c:if test="${codPayment.submittedDate != null}">
                                                                                    <br>
                                                                                    <strong>Submitted Date:</strong> ${codPayment.submittedDate}
                                                                                </c:if>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <div class="alert alert-warning">
                                                                                COD payment record will be created when shipment is completed.
                                                                            </div>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <!-- Regular Payment Status for non-COD shipments -->
                                                                <div class="form-group">
                                                                    <label for="paymentStatus">Payment Status</label>
                                                                    <select class="form-control" id="paymentStatus" name="paymentStatus" disabled>
                                                                        <option value="UNPAID" ${shipment.paymentStatus=='UNPAID' ? 'selected' : ''}>CHƯA NỘP</option>
                                                                        <option value="PAID" ${shipment.paymentStatus=='PAID' ? 'selected' : ''}>ĐÃ NỘP</option>
                                                                    </select>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <div class="form-group text-center mt-4">
                                                            <button type="submit" class="btn btn-primary">Update
                                                                Status</button>
                                                            <a href="${ctx}/shipper/shipment/list"
                                                                class="btn btn-danger ml-2">Cancel</a>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- COD Payment Submission Section - Moved outside main form -->
                                <c:if test="${shipment.paymentMethod == 'COD' && codPayment != null && codPayment.submittedStatus == 'NOT_SUBMITTED'}">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">Nộp COD</div>
                                            </div>
                                            <div class="card-body">
                                                <p>Chọn phương thức nộp COD:</p>
                                                
                                                <!-- Debug Information -->
                                                <div class="alert alert-info">
                                                    <strong>Debug Info:</strong><br>
                                                    COD Payment ID: ${codPayment.codPaymentId}<br>
                                                    CSRF Token: ${_csrf.token}<br>
                                                    Context Path: ${ctx}
                                                </div>
                                                
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <form id="codSubmitForm" action="${ctx}/shipper/cod/submit" method="post">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="codPaymentId" value="${codPayment.codPaymentId}">
                                                            <input type="hidden" name="paymentMethod" value="CASH">
                                                            <button type="submit" class="btn btn-success btn-block" 
                                                                    onclick="return confirmCodSubmission('tiền mặt');">
                                                                <i class="fa fa-money-bill"></i> Tiền Mặt
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <a href="${ctx}/shipper/cod/pay?codPaymentId=${codPayment.codPaymentId}&method=MOMO" 
                                                           class="btn btn-primary btn-block">
                                                            <i class="fa fa-mobile-alt"></i> MoMo
                                                        </a>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <a href="${ctx}/shipper/cod/pay?codPaymentId=${codPayment.codPaymentId}&method=VNPAY" 
                                                           class="btn btn-info btn-block">
                                                            <i class="fa fa-credit-card"></i> VNPay
                                                        </a>
                                                    </div>
                                                </div>
                                                
                                                <!-- Test Button for Debugging -->
                                                <div class="row mt-3">
                                                    <div class="col-md-12">
                                                        <button type="button" class="btn btn-warning btn-sm" onclick="testCodSubmission()">
                                                            <i class="fa fa-bug"></i> Test COD Submission (Debug)
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
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
                <script
                    src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>
                
                <script>
                    // Auto-submit form when status changes
                    document.getElementById('status').addEventListener('change', function() {
                        if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái vận đơn?')) {
                            // Submit the form automatically
                            document.getElementById('shipmentUpdateForm').submit();
                        } else {
                            // Reset to original value if user cancels
                            this.value = '${shipment.status}';
                        }
                    });
                    
                    // Function to confirm COD submission
                    function confirmCodSubmission(method) {
                        console.log('confirmCodSubmission called with method:', method);
                        return confirm('Xác nhận nộp COD bằng ' + method + '?');
                    }
                    
                    // Test function for debugging COD submission
                    function testCodSubmission() {
                        console.log('=== COD SUBMISSION TEST ===');
                        
                        var codForm = document.getElementById('codSubmitForm');
                        if (codForm) {
                            console.log('Form found:', codForm);
                            console.log('Form action:', codForm.action);
                            console.log('Form method:', codForm.method);
                            
                            var formData = new FormData(codForm);
                            console.log('Form data:');
                            for (var pair of formData.entries()) {
                                console.log(pair[0] + ': ' + pair[1]);
                            }
                            
                            // Test if form can be submitted
                            if (confirm('Do you want to test submit the COD form?')) {
                                console.log('Submitting form...');
                                codForm.submit();
                            }
                        } else {
                            console.log('COD form not found!');
                            alert('COD form not found!');
                        }
                        
                        console.log('=== END TEST ===');
                    }
                    
                    // Prevent form conflicts by stopping event propagation
                    document.addEventListener('DOMContentLoaded', function() {
                        console.log('DOM loaded, setting up COD form handlers');
                        
                        var codForm = document.getElementById('codSubmitForm');
                        if (codForm) {
                            console.log('COD form found, adding event listeners');
                            
                            codForm.addEventListener('submit', function(e) {
                                console.log('COD form submit event triggered');
                                e.stopPropagation();
                                
                                // Additional debugging
                                var formData = new FormData(this);
                                console.log('Form data:');
                                for (var pair of formData.entries()) {
                                    console.log(pair[0] + ': ' + pair[1]);
                                }
                            });
                            
                            // Add click handler to button for additional debugging
                            var submitButton = codForm.querySelector('button[type="submit"]');
                            if (submitButton) {
                                submitButton.addEventListener('click', function(e) {
                                    console.log('COD submit button clicked');
                                });
                            }
                        } else {
                            console.log('COD form not found');
                        }
                    });
                </script>
            </body>

            </html>