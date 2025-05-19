<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <title>Tạo phiếu nhập hàng mới</title>
                    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                    <link rel="icon" href="${ctx}/resources/assets/dashboard/img/kaiadmin/favicon.ico"
                        type="image/x-icon" />
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
                    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/bootstrap.min.css" />
                    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/plugins.min.css" />
                    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/kaiadmin.min.css" />
                    <link rel="stylesheet" href="${ctx}/resources/assets/dashboard/css/demo.css" />
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
                        .required-field::after {
                            content: " *";
                            color: red;
                        }

                        .detail-row {
                            margin-bottom: 15px;
                            padding: 15px;
                            border-radius: 5px;
                            background-color: #f8f9fa;
                            /* Light background for detail rows */
                        }

                        .detail-row:hover {
                            background-color: #e9ecef;
                            /* Slightly darker on hover */
                        }

                        .remove-detail {
                            cursor: pointer;
                        }

                        .total-amount {
                            font-size: 1.2em;
                            font-weight: bold;
                        }

                        /* Ensure template is hidden initially */
                        #detail-template {
                            display: none;
                        }
                    </style>

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
                                        <h3 class="fw-bold mb-3">Tạo phiếu nhập hàng mới</h3>
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
                                            <li class="separator">
                                                <i class="icon-arrow-right"></i>
                                            </li>
                                            <li class="nav-item">
                                                <a href="${ctx}/employee/receipt-mgr/create">Tạo mới</a>
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

                                        <!-- Form tạo phiếu nhập hàng -->
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="d-flex align-items-center">
                                                            <h4 class="card-title">Thông tin phiếu nhập hàng</h4>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <form:form action="${ctx}/employee/receipt-mgr/save"
                                                            method="POST" modelAttribute="purchaseReceipt"
                                                            id="receiptForm">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="receiptCode"
                                                                            class="required-field">Mã phiếu nhập</label>
                                                                        <form:input path="receiptCode" id="receiptCode"
                                                                            class="form-control" required="true"
                                                                            readonly="true" />
                                                                        <form:errors path="receiptCode"
                                                                            cssClass="text-danger" />
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="supplier" class="required-field">Nhà
                                                                            cung cấp</label>
                                                                        <form:select path="supplier.supplierId"
                                                                            id="supplier" class="form-control"
                                                                            required="true">
                                                                            <form:option value=""
                                                                                label="-- Chọn nhà cung cấp --" />
                                                                            <form:options items="${suppliers}"
                                                                                itemValue="supplierId"
                                                                                itemLabel="supplierName" />
                                                                        </form:select>
                                                                        <form:errors path="supplier"
                                                                            cssClass="text-danger" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <div class="form-group">
                                                                        <label for="note">Ghi chú</label>
                                                                        <form:textarea path="note" id="note"
                                                                            class="form-control" rows="3" />
                                                                        <form:errors path="note"
                                                                            cssClass="text-danger" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- Input ẩn cho totalAmount -->
                                                            <form:hidden path="totalAmount" id="totalAmountInput" />

                                                            <!-- Chi tiết phiếu nhập -->
                                                            <div class="card mt-4">
                                                                <div class="card-header bg-primary text-white">
                                                                    <div class="d-flex align-items-center">
                                                                        <h5 class="card-title mb-0 text-white">Chi tiết
                                                                            phiếu nhập</h5>
                                                                        <button type="button"
                                                                            class="btn btn-light btn-sm ms-auto"
                                                                            id="addDetail">
                                                                            <i class="fas fa-plus"></i> Thêm sản phẩm
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <div class="card-body" id="detailsContainer">
                                                                    <!-- Template for detail row (hidden by default) -->
                                                                    <div class="detail-row" id="detail-template"
                                                                        style="display: none;">
                                                                        <div class="row">
                                                                            <div class="col-md-4">
                                                                                <div class="form-group">
                                                                                    <label class="required-field">Sản
                                                                                        phẩm</label>
                                                                                    <select
                                                                                        class="form-control product-select"
                                                                                        required>
                                                                                        <option value="">-- Chọn sản
                                                                                            phẩm --</option>
                                                                                        <c:forEach items="${products}"
                                                                                            var="product">
                                                                                            <option
                                                                                                value="${product.productId}">
                                                                                                ${product.productName}
                                                                                            </option>
                                                                                        </c:forEach>
                                                                                    </select>
                                                                                    <div class="invalid-feedback">Vui
                                                                                        lòng chọn sản phẩm.</div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-3">
                                                                                <div class="form-group">
                                                                                    <label class="required-field">Biến
                                                                                        thể</label>
                                                                                    <select
                                                                                        class="form-control variant-select"
                                                                                        disabled required>
                                                                                        <option value="">-- Chọn sản
                                                                                            phẩm trước --</option>
                                                                                    </select>
                                                                                    <div class="invalid-feedback">Vui
                                                                                        lòng chọn biến thể.</div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-2">
                                                                                <div class="form-group">
                                                                                    <label class="required-field">Số
                                                                                        lượng</label>
                                                                                    <input type="number"
                                                                                        class="form-control quantity"
                                                                                        min="1" value="1" required />
                                                                                    <div class="invalid-feedback">Số
                                                                                        lượng phải lớn hơn 0.</div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-2">
                                                                                <div class="form-group">
                                                                                    <label class="required-field">Đơn
                                                                                        giá</label>
                                                                                    <input type="number"
                                                                                        class="form-control unit-price"
                                                                                        min="0" value="0" step="0.01"
                                                                                        required />
                                                                                    <div class="invalid-feedback">Đơn
                                                                                        giá phải lớn hơn hoặc bằng 0.
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div
                                                                                class="col-md-1 d-flex align-items-end">
                                                                                <div class="form-group">
                                                                                    <button type="button"
                                                                                        class="btn btn-danger btn-sm remove-detail">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="row">
                                                                            <div class="col-md-12 text-end">
                                                                                <span class="fw-bold">Thành tiền:
                                                                                </span>
                                                                                <span class="subtotal">0.00</span> VND
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Existing detail rows will be added here by JS -->
                                                                </div>
                                                                <div class="card-footer text-end">
                                                                    <span class="fw-bold">Tổng tiền phiếu nhập: </span>
                                                                    <span id="totalAmount" class="total-amount">0.00
                                                                        VND</span>
                                                                </div>
                                                            </div>


                                                            <div class="form-group text-center mt-4">
                                                                <button type="submit" class="btn btn-primary">Lưu Phiếu
                                                                    Nhập</button>
                                                                <a href="${ctx}/employee/receipt-mgr/list"
                                                                    class="btn btn-secondary">Hủy</a>
                                                            </div>
                                                        </form:form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                </div>
                            </div>

                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>

                    <!--   Core JS Files   -->
                    <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                    <!-- jQuery Scrollbar -->
                    <script
                        src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                    <script
                        src="${ctx}/resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

                    <!-- Datatables -->
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

                    <!-- Sweet Alert -->
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                    <!-- KaiAdmin JS -->
                    <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>

                    <!-- Custom Script -->
                    <script>
                        $(document).ready(function () {
                            // Loại bỏ thuộc tính required khỏi template ban đầu
                            $('#detail-template').find('.product-select').removeAttr('required');
                            $('#detail-template').find('.variant-select').removeAttr('required');
                            $('#detail-template').find('.quantity').removeAttr('required');
                            $('#detail-template').find('.unit-price').removeAttr('required');

                            // Thêm thuộc tính name cho template ban đầu
                            $('#detail-template').find('.product-select').attr('name', 'template-product');
                            $('#detail-template').find('.variant-select').attr('name', 'template-variant');
                            $('#detail-template').find('.quantity').attr('name', 'template-quantity');
                            $('#detail-template').find('.unit-price').attr('name', 'template-unitPrice');

                            // Counter for detail rows to set correct names
                            var detailRowIndex = 0;

                            // Add new detail row
                            $('#addDetail').click(function () {
                                var $templateRow = $('#detail-template');
                                var $newRow = $templateRow.clone();

                                // Remove display: none and update ID
                                $newRow.css('display', '').removeAttr('id');

                                // Thêm lại thuộc tính required cho các phần tử trong dòng mới
                                $newRow.find('.product-select').attr('required', 'required');
                                $newRow.find('.variant-select').attr('required', 'required');
                                $newRow.find('.quantity').attr('required', 'required');
                                $newRow.find('.unit-price').attr('required', 'required');

                                // Đảm bảo tất cả các phần tử form đều có thuộc tính name hợp lệ
                                $newRow.find('.product-select').attr('name', 'details[' + detailRowIndex + '].product.productId');
                                $newRow.find('.variant-select').attr('name', 'details[' + detailRowIndex + '].productVariant.productVariantId');
                                $newRow.find('.quantity').attr('name', 'details[' + detailRowIndex + '].quantity');
                                $newRow.find('.unit-price').attr('name', 'details[' + detailRowIndex + '].unitPrice');

                                // Add remove button functionality
                                $newRow.find('.remove-detail').click(function () {
                                    $(this).closest('.detail-row').remove();
                                    updateTotalAmount();
                                });

                                // Append the new row to the container
                                $('#detailsContainer').append($newRow);

                                // Increment index for the next row
                                detailRowIndex++;
                            });

                            // Handle product selection change (existing code, ensure it's present)
                            $(document).on('change', '.product-select', function () {
                                var selectedProductId = $(this).val();
                                var $variantSelect = $(this).closest('.detail-row').find('.variant-select');

                                // Clear previous options except the default one
                                $variantSelect.find('option:not([value=""])').remove();
                                // Disable variant select initially
                                $variantSelect.prop('disabled', true);


                                if (selectedProductId) {
                                    // Make AJAX call to fetch variants
                                    $.ajax({
                                        url: '${ctx}/employee/receipt-mgr/api/products/' + selectedProductId + '/variants',
                                        type: 'GET',
                                        success: function (variants) {
                                            // Clear previous dynamic options again in case of rapid changes
                                            console.log("Variants received:", variants); // Log the received data
                                            $variantSelect.find('option:not([value=""])').remove();

                                            // Populate variant dropdown
                                            if (variants && variants.length > 0) {
                                                // $variantSelect.append('<option value="">-- Chọn biến thể --</option>');
                                                $.each(variants, function (index, variant) {
                                                    // Luôn hiển thị SKU trước
                                                    var displayText = variant.SKU || variant.productVariantId;

                                                    // Thêm thông tin size và color nếu có (sử dụng các trường phẳng)
                                                    if (variant.sizeName && variant.colorName) {
                                                        displayText += ' - ' + variant.sizeName + ' - ' + variant.colorName;
                                                    } else if (variant.sizeName) {
                                                        displayText += ' - ' + variant.sizeName;
                                                    } else if (variant.colorName) {
                                                        displayText += ' - ' + variant.colorName;
                                                    }

                                                    $variantSelect.append('<option value="' + variant.productVariantId + '">' + displayText + '</option>');
                                                });
                                                $variantSelect.prop('disabled', false);
                                            } else {
                                                $variantSelect.append('<option value="">Không có biến thể</option>');
                                                $variantSelect.prop('disabled', true);
                                            }
                                        }
                                    });
                                } else {
                                    // If no product is selected, keep variant select disabled and show default option
                                    // $variantSelect.append('<option value="">-- Chọn sản phẩm trước --</option>');
                                }
                            });


                            // Handle quantity or unit price change to update subtotal and total
                            $(document).on('input', '.quantity, .unit-price', function () {
                                var $row = $(this).closest('.detail-row');
                                var quantity = parseFloat($row.find('.quantity').val()) || 0;
                                var unitPrice = parseFloat($row.find('.unit-price').val()) || 0;
                                var subtotal = quantity * unitPrice;
                                $row.find('.subtotal').text(subtotal.toFixed(2)); // Assuming you have a .subtotal element
                                updateTotalAmount();
                            });

                            // Function to update the total amount
                            function updateTotalAmount() {
                                var total = 0;
                                $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                                    var quantity = parseFloat($(this).find('.quantity').val()) || 0;
                                    var unitPrice = parseFloat($(this).find('.unit-price').val()) || 0;
                                    total += quantity * unitPrice;
                                });
                                $('#totalAmount').text(total.toFixed(2) + ' VND'); // Assuming you have an element with ID totalAmount
                                $('#totalAmountInput').val(total.toFixed(2)); // Set giá trị vào input ẩn
                            }

                            // Form submission handler
                            $("#receiptForm").submit(function (event) {
                                // Prevent default form submission để xử lý dữ liệu trước khi gửi
                                event.preventDefault();
                                // Cập nhật tổng tiền lần cuối trước khi gửi
                                updateTotalAmount();

                                // Basic client-side validation check
                                var isValid = true;
                                $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                                    if (!$(this).find('.product-select').val()) {
                                        isValid = false;
                                        $(this).find('.product-select').addClass('is-invalid');
                                    } else {
                                        $(this).find('.product-select').removeClass('is-invalid');
                                    }
                                    if (!$(this).find('.variant-select').val()) {
                                        isValid = false;
                                        $(this).find('.variant-select').addClass('is-invalid');
                                    } else {
                                        $(this).find('.variant-select').removeClass('is-invalid');
                                    }
                                    if (parseFloat($(this).find('.quantity').val()) <= 0) {
                                        isValid = false;
                                        $(this).find('.quantity').addClass('is-invalid');
                                    } else {
                                        $(this).find('.quantity').removeClass('is-invalid');
                                    }
                                    if (parseFloat($(this).find('.unit-price').val()) < 0) {
                                        isValid = false;
                                        $(this).find('.unit-price').addClass('is-invalid');
                                    } else {
                                        $(this).find('.unit-price').removeClass('is-invalid');
                                    }
                                });

                                if (!isValid) {
                                    alert("Vui lòng điền đầy đủ và chính xác thông tin chi tiết phiếu nhập.");
                                    return false;
                                }

                                // Tạo mảng chi tiết phiếu nhập
                                var details = [];
                                $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                                    var $row = $(this);
                                    var detail = {
                                        productVariantId: parseInt($row.find('.variant-select').val()),
                                        quantity: parseInt($row.find('.quantity').val()),
                                        unitPrice: parseFloat($row.find('.unit-price').val())
                                    };
                                    details.push(detail);
                                });

                                // Kiểm tra nếu không có chi tiết nào
                                if (details.length === 0) {
                                    alert("Phiếu nhập phải có ít nhất một chi tiết sản phẩm.");
                                    return false;
                                }

                                // Chuyển đổi mảng chi tiết thành chuỗi JSON
                                var detailsJson = JSON.stringify(details);

                                // Tạo input ẩn để gửi chuỗi JSON
                                $('<input>').attr({
                                    type: 'hidden',
                                    name: 'detailsJson',
                                    value: detailsJson
                                }).appendTo('#receiptForm');

                                // Submit form
                                this.submit();
                            });
                        });

                    </script>

                </body>

                </html>