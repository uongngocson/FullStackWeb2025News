<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <title>Update Receipt</title>
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
                    <style>
                        .required-field::after {
                            content: " *";
                            color: red;
                        }

                        .detail-row {
                            border: 1px solid #e9ecef;
                            padding: 15px;
                            margin-bottom: 15px;
                            border-radius: 5px;
                            background-color: #f8f9fa;
                        }

                        .detail-row:hover {
                            background-color: #e9ecef;
                        }

                        .remove-detail {
                            cursor: pointer;
                        }

                        .total-amount {
                            font-size: 1.2em;
                            font-weight: bold;
                        }

                        #detail-template {
                            display: none;
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
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div class="main-panel">
                            <jsp:include page="../layout/header.jsp" />
                            <div class="container">
                                <div class="page-inner">
                                    <div class="page-header">
                                        <h3 class="fw-bold mb-3">Update receipt</h3>
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
                                                <a href="${ctx}/employee/receipt-mgr/list">Receipt</a>
                                            </li>
                                            <li class="separator">
                                                <i class="icon-arrow-right"></i>
                                            </li>
                                            <li class="nav-item">Update</li>
                                        </ul>
                                    </div>
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
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="d-flex align-items-center">
                                                        <h4 class="card-title">Information receipt</h4>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <form:form action="${ctx}/employee/receipt-mgr/save" method="POST"
                                                        modelAttribute="purchaseReceipt" id="receiptForm">
                                                        <form:hidden path="id" />
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="receiptCode"
                                                                        class="required-field">Receipt Code</label>
                                                                    <form:input path="receiptCode" id="receiptCode"
                                                                        class="form-control" required="true"
                                                                        readonly="true" />
                                                                    <form:errors path="receiptCode"
                                                                        cssClass="text-danger" />
                                                                </div>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <div class="form-group">
                                                                    <label for="supplier"
                                                                        class="required-field">Supplier</label>
                                                                    <form:select path="supplier.supplierId"
                                                                        id="supplier" class="form-control"
                                                                        required="true" disabled="true">
                                                                        <form:option value=""
                                                                            label="-- Select supplier --" />
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
                                                                    <label for="note">Note</label>
                                                                    <form:textarea path="note" id="note"
                                                                        class="form-control" rows="3" />
                                                                    <form:errors path="note" cssClass="text-danger" />
                                                                </div>
                                                            </div>

                                                            <form:hidden path="createAt" />
                                                        </div>
                                                        <hr>
                                                        <div class="card-header">
                                                            <div class="d-flex align-items-center">
                                                                <h4 class="card-title">Receipt details</h4>
                                                                <button type="button" id="addDetail"
                                                                    class="btn btn-primary btn-round ms-auto">
                                                                    <i class="fas fa-plus"></i> Add product
                                                                </button>
                                                            </div>
                                                        </div>
                                                        <div class="card-body" id="detailsContainer">
                                                            <div class="detail-row" id="detail-template"
                                                                style="display: none;">
                                                                <input type="hidden" class="detail-id" value="0" />
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label
                                                                                class="required-field">Product</label>
                                                                            <select class="form-control product-select"
                                                                                required>
                                                                                <option value="">-- Select product --
                                                                                </option>
                                                                                <c:forEach items="${products}"
                                                                                    var="product">
                                                                                    <option
                                                                                        value="${product.productId}">
                                                                                        ${product.productName}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                            <div class="invalid-feedback">Please
                                                                                select a product.</div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label
                                                                                class="required-field">Variant</label>
                                                                            <select class="form-control variant-select"
                                                                                required disabled>
                                                                                <option value="">-- Select
                                                                                    Product First
                                                                                    --</option>
                                                                            </select>
                                                                            <div class="invalid-feedback">Please select
                                                                                a product variant.</div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <div class="form-group">
                                                                            <label
                                                                                class="required-field">Quantity</label>
                                                                            <input type="number"
                                                                                class="form-control quantity" min="1"
                                                                                value="1" required />
                                                                            <div class="invalid-feedback">Quantity must
                                                                                be greater than 0.</div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-2">
                                                                        <div class="form-group">
                                                                            <label class="required-field">Unit
                                                                                price</label>
                                                                            <input type="number"
                                                                                class="form-control unit-price" min="0"
                                                                                step="0.01" value="0" required />
                                                                            <div class="invalid-feedback">Unit
                                                                                price must be greater than or
                                                                                equal to 0.</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <div class="form-group">
                                                                            <label>Subtotal:</label>
                                                                            <span class="subtotal">0.00</span> VND
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-8 text-end">
                                                                        <button type="button"
                                                                            class="btn btn-danger btn-sm remove-detail">
                                                                            <i class="fas fa-trash"></i> Xóa
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-md-12 text-end">
                                                                <div class="form-group">
                                                                    <label>Total Receipt Amount: </label>
                                                                    <span id="totalAmount" class="total-amount">0.00
                                                                        VND</span>
                                                                    <input type="hidden" id="totalAmountInput"
                                                                        name="totalAmount" value="0.00" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-md-12 text-end">
                                                                <button type="submit"
                                                                    class="btn btn-primary">Update</button>
                                                                <a href="${ctx}/employee/receipt-mgr/list"
                                                                    class="btn btn-secondary">Cancel</a>
                                                            </div>
                                                        </div>
                                                        <input type="hidden" id="detailsJson" name="detailsJson"
                                                            value="" />
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
                    <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>
                    <script
                        src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/chart.js/chart.min.js"></script>
                    <script
                        src="${ctx}/resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/chart-circle/circles.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/jsvectormap/jsvectormap.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/jsvectormap/world.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/kaiadmin.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/setting-demo.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/demo.js"></script>
                    <script>
                        $(document).ready(function () {
                            $('#detail-template').find('.product-select').removeAttr('required');
                            $('#detail-template').find('.variant-select').removeAttr('required');
                            $('#detail-template').find('.quantity').removeAttr('required');
                            $('#detail-template').find('.unit-price').removeAttr('required');
                            $('#detail-template').find('.product-select').attr('name', 'template-product');
                            $('#detail-template').find('.variant-select').attr('name', 'template-variant');
                            $('#detail-template').find('.quantity').attr('name', 'template-quantity');
                            $('#detail-template').find('.unit-price').attr('name', 'template-unitPrice');
                            $('#detail-template').find('.detail-id').attr('name', 'template-detailId');

                            var detailRowIndex = ${ purchaseReceipt.purchaseReceiptDetails.size()
                        };

                        function addDetailRow(detail = null) {
                            var $templateRow = $('#detail-template');
                            var $newRow = $templateRow.clone();
                            $newRow.css('display', '').removeAttr('id');
                            $newRow.find('.product-select').attr('required', 'required');
                            $newRow.find('.variant-select').attr('required', 'required');
                            $newRow.find('.quantity').attr('required', 'required');
                            $newRow.find('.unit-price').attr('required', 'required');
                            $newRow.find('.detail-id').attr('name', 'details[' + detailRowIndex + '].id');
                            $newRow.find('.product-select').attr('name', 'details[' + detailRowIndex + '].product.productId');
                            $newRow.find('.variant-select').attr('name', 'details[' + detailRowIndex + '].productVariantId');
                            $newRow.find('.quantity').attr('name', 'details[' + detailRowIndex + '].quantity');
                            $newRow.find('.unit-price').attr('name', 'details[' + detailRowIndex + '].unitPrice');

                            if (detail) {
                                $newRow.find('.detail-id').val(detail.id || 0);
                                $newRow.find('.product-select').val(detail.product.productId);
                                $newRow.find('.variant-select').data('selected-variant-id', detail.productVariant.productVariantId);
                                $newRow.find('.quantity').val(detail.quantity);
                                $newRow.find('.unit-price').val(detail.unitPrice);
                                $newRow.find('.subtotal').text((detail.quantity * detail.unitPrice).toFixed(2));
                            }

                            $newRow.find('.remove-detail').click(function () {
                                $(this).closest('.detail-row').remove();
                                updateTotalAmount();
                            });

                            $('#detailsContainer').append($newRow);
                            detailRowIndex++;

                            if (detail) {
                                $newRow.find('.product-select').trigger('change');
                            }
                        }

                        <c:forEach items="${purchaseReceipt.purchaseReceiptDetails}" var="detail">
                            addDetailRow({
                                id: ${detail.id},
                            product: {productId: ${detail.product.productId} },
                            productVariant: {productVariantId: ${detail.productVariant.productVariantId} },
                            quantity: ${detail.quantity},
                            unitPrice: ${detail.unitPrice}
                });
                        </c:forEach>

                        // Counter for detail rows to set correct names
                        var detailRowIndex = 0;

                        // Xử lý khi thay đổi nhà cung cấp
                        $('#supplier').change(function () {
                            var supplierId = $(this).val();

                            // // Xóa tất cả các dòng chi tiết hiện có
                            // $('#detailsContainer .detail-row:not(#detail-template)').remove();

                            // Reset tổng tiền
                            $('#totalAmount').text('0.00 VND');
                            $('#totalAmountInput').val('0.00');

                            if (supplierId) {
                                // Tải danh sách sản phẩm theo nhà cung cấp
                                $.ajax({
                                    url: '${ctx}/employee/receipt-mgr/get-products-by-supplier',
                                    type: 'GET',
                                    data: { supplierId: supplierId },
                                    success: function (response) {
                                        // Cập nhật tất cả các select sản phẩm hiện có
                                        $('.product-select').html(response);

                                        // Reset các select biến thể
                                        $('.variant-select').html('<option value="">-- Chọn sản phẩm trước --</option>').prop('disabled', true);
                                    }
                                });
                            } else {
                                // Nếu không chọn nhà cung cấp, hiển thị thông báo trong select sản phẩm
                                $('.product-select').html('<option value="">-- Chọn nhà cung cấp trước --</option>');
                                $('.variant-select').html('<option value="">-- Chọn sản phẩm trước --</option>').prop('disabled', true);
                            }
                        });
                        $('#addDetail').click(function () {
                            addDetailRow();
                        });

                        $(document).on('change', '.product-select', function () {
                            var $row = $(this).closest('.detail-row');
                            var selectedProductId = $(this).val();
                            var $variantSelect = $row.find('.variant-select');
                            var selectedVariantId = $variantSelect.data('selected-variant-id');

                            $variantSelect.find('option:not([value=""])').remove();
                            $variantSelect.prop('disabled', true);
                            // $variantSelect.append('<option value="">-- Đang tải biến thể --</option>');

                            if (selectedProductId) {
                                $.ajax({
                                    url: "${ctx}/employee/receipt-mgr/api/products/" + selectedProductId + "/variants",
                                    type: "GET",
                                    success: function (variants) {
                                        $variantSelect.find('option:not([value=""])').remove();
                                        if (variants && variants.length > 0) {
                                            // $variantSelect.append('<option value="">-- Chọn biến thể --</option>');
                                            $.each(variants, function (index, variant) {
                                                var displayText = variant.SKU || variant.productVariantId;
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
                                            if (selectedVariantId) {
                                                $variantSelect.val(selectedVariantId);
                                                $variantSelect.removeData('selected-variant-id');
                                            }
                                        } else {
                                            $variantSelect.append('<option value="">Không có biến thể</option>');
                                            $variantSelect.prop('disabled', true);
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error("Error fetching product variants:", error);
                                        $variantSelect.find('option:not([value=""])').remove();
                                        $variantSelect.append('<option value="">-- Lỗi tải biến thể --</option>');
                                    }
                                });
                            } else {
                                $variantSelect.find('option:not([value=""])').remove();
                                // $variantSelect.append('<option value="">-- Chọn sản phẩm trước --</option>');
                            }
                        });

                        $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                            $(this).find('.product-select').trigger('change');
                        });

                        $(document).on('input', '.quantity, .unit-price', function () {
                            var $row = $(this).closest('.detail-row');
                            var quantity = parseFloat($row.find('.quantity').val()) || 0;
                            var unitPrice = parseFloat($row.find('.unit-price').val()) || 0;
                            var subtotal = quantity * unitPrice;
                            $row.find('.subtotal').text(subtotal.toFixed(2));
                            updateTotalAmount();
                        });

                        function updateTotalAmount() {
                            var total = 0;
                            $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                                var quantity = parseFloat($(this).find('.quantity').val()) || 0;
                                var unitPrice = parseFloat($(this).find('.unit-price').val()) || 0;
                                total += quantity * unitPrice;
                            });
                            $('#totalAmount').text(total.toFixed(2) + ' VND');
                            $('#totalAmountInput').val(total.toFixed(2));
                        }

                        updateTotalAmount();

                        $("#receiptForm").submit(function (event) {
                            event.preventDefault();
                            updateTotalAmount();

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

                            var details = [];
                            $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                                var $row = $(this);
                                var detail = {
                                    id: parseInt($row.find('.detail-id').val()) || 0,
                                    productVariantId: parseInt($row.find('.variant-select').val()),
                                    quantity: parseInt($row.find('.quantity').val()),
                                    unitPrice: parseFloat($row.find('.unit-price').val())
                                };
                                details.push(detail);
                            });

                            if (details.length === 0) {
                                alert("Phiếu nhập phải có ít nhất một chi tiết sản phẩm.");
                                return false;
                            }

                            $('#detailsJson').val(JSON.stringify(details));
                            this.submit();
                        });
                    });
                    </script>
                </body>

                </html>