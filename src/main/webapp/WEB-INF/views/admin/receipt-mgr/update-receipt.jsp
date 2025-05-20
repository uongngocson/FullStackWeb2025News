<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <title>Cập nhật phiếu nhập hàng</title>
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
                                        <h3 class="fw-bold mb-3">Cập nhật phiếu nhập hàng</h3>
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
                                                <a href="${ctx}/admin/receipt-mgr/list">Phiếu nhập hàng</a>
                                            </li>
                                            <li class="separator">
                                                <i class="icon-arrow-right"></i>
                                            </li>
                                            <li class="nav-item">Cập nhật</li>
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

                                        <!-- Form cập nhật phiếu nhập hàng -->
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="d-flex align-items-center">
                                                            <h4 class="card-title">Thông tin phiếu nhập hàng</h4>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <form:form action="${ctx}/admin/receipt-mgr/update"
                                                            method="POST" modelAttribute="purchaseReceipt"
                                                            id="receiptForm">
                                                            <%-- Hidden input for Receipt ID --%>
                                                                <form:hidden path="id" />
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label for="receiptCode"
                                                                                class="required-field">Mã phiếu
                                                                                nhập</label>
                                                                            <form:input path="receiptCode"
                                                                                id="receiptCode" class="form-control"
                                                                                required="true" readonly="true" />
                                                                            <form:errors path="receiptCode"
                                                                                cssClass="text-danger" />
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label for="supplier"
                                                                                class="required-field">Nhà cung
                                                                                cấp</label>
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
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label for="createAt">Ngày tạo</label>
                                                                            <%-- Display create date, make it readonly
                                                                                --%>
                                                                                <input type="text" class="form-control"
                                                                                    value="<fmt:formatDate value="
                                                                                    ${purchaseReceipt.createAt}"
                                                                                    pattern="dd/MM/yyyy HH:mm" />"
                                                                                readonly />
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <hr>

                                                                <div class="card-header">
                                                                    <div class="d-flex align-items-center">
                                                                        <h4 class="card-title">Chi tiết phiếu nhập
                                                                        </h4>
                                                                        <button type="button" id="addDetail"
                                                                            class="btn btn-primary btn-round ms-auto">
                                                                            <i class="fas fa-plus"></i> Thêm sản phẩm
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <div class="card-body" id="detailsContainer">
                                                                    <!-- Template for detail row (hidden by default) -->
                                                                    <div class="detail-row" id="detail-template"
                                                                        style="display: none;">
                                                                        <%-- Hidden input for detail ID (if updating
                                                                            existing detail) --%>
                                                                            <input type="hidden" class="detail-id"
                                                                                value="0" />
                                                                            <div class="row">
                                                                                <div class="col-md-4">
                                                                                    <div class="form-group">
                                                                                        <label
                                                                                            class="required-field">Sản
                                                                                            phẩm</label>
                                                                                        <select
                                                                                            class="form-control product-select"
                                                                                            required>
                                                                                            <option value="">-- Chọn sản
                                                                                                phẩm --</option>
                                                                                            <c:forEach
                                                                                                items="${products}"
                                                                                                var="product">
                                                                                                <option
                                                                                                    value="${product.productId}">
                                                                                                    ${product.productName}
                                                                                                </option>
                                                                                            </c:forEach>
                                                                                        </select>
                                                                                        <div class="invalid-feedback">
                                                                                            Vui
                                                                                            lòng chọn sản phẩm.</div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-4">
                                                                                    <div class="form-group">
                                                                                        <label
                                                                                            class="required-field">Biến
                                                                                            thể</label>
                                                                                        <select
                                                                                            class="form-control variant-select"
                                                                                            required disabled>
                                                                                            <option value="">-- Chọn sản
                                                                                                phẩm trước --</option>
                                                                                        </select>
                                                                                        <div class="invalid-feedback">
                                                                                            Vui
                                                                                            lòng chọn biến thể.</div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-2">
                                                                                    <div class="form-group">
                                                                                        <label class="required-field">Số
                                                                                            lượng</label>
                                                                                        <input type="number"
                                                                                            class="form-control quantity"
                                                                                            min="1" value="1"
                                                                                            required />
                                                                                        <div class="invalid-feedback">Số
                                                                                            lượng phải lớn hơn 0.</div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-2">
                                                                                    <div class="form-group">
                                                                                        <label
                                                                                            class="required-field">Đơn
                                                                                            giá</label>
                                                                                        <input type="number"
                                                                                            class="form-control unit-price"
                                                                                            min="0" step="0.01"
                                                                                            value="0" required />
                                                                                        <div class="invalid-feedback">
                                                                                            Đơn
                                                                                            giá không được âm.</div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="row">
                                                                                <div class="col-md-4">
                                                                                    <div class="form-group">
                                                                                        <label>Thành tiền:</label>
                                                                                        <span
                                                                                            class="subtotal">0.00</span>
                                                                                        VND
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

                                                                    <!-- Existing details will be loaded here by JavaScript -->
                                                                </div>

                                                                <hr>

                                                                <div class="row">
                                                                    <div class="col-md-12 text-end">
                                                                        <div class="form-group">
                                                                            <label>Tổng tiền phiếu nhập:</label>
                                                                            <span id="totalAmount"
                                                                                class="total-amount">0.00 VND</span>
                                                                            <%-- Hidden input to send total amount to
                                                                                controller --%>
                                                                                <input type="hidden"
                                                                                    id="totalAmountInput"
                                                                                    name="totalAmount" value="0.00" />
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="row">
                                                                    <div class="col-md-12 text-end">
                                                                        <button type="submit"
                                                                            class="btn btn-primary">Cập nhật phiếu
                                                                            nhập</button>
                                                                        <a href="${ctx}/admin/receipt-mgr/list"
                                                                            class="btn btn-secondary">Hủy</a>
                                                                    </div>
                                                                </div>

                                                                <%-- Hidden input to send details as JSON --%>
                                                                    <input type="hidden" id="detailsJson"
                                                                        name="detailsJson" value="" />
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

                    <!-- Core JS Files -->
                    <script src="${ctx}/resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/popper.min.js"></script>
                    <script src="${ctx}/resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                    <!-- Scrollbar Plugin -->
                    <script
                        src="${ctx}/resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

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

                            // Thêm thuộc tính name cho template ban đầu (chỉ để phân biệt với các dòng thực tế)
                            $('#detail-template').find('.product-select').attr('name', 'template-product');
                            $('#detail-template').find('.variant-select').attr('name', 'template-variant');
                            $('#detail-template').find('.quantity').attr('name', 'template-quantity');
                            $('#detail-template').find('.unit-price').attr('name', 'template-unitPrice');
                            $('#detail-template').find('.detail-id').attr('name', 'template-detailId');


                            // Counter for detail rows to set correct names (used for new rows)
                            var detailRowIndex = ${ purchaseReceipt.purchaseReceiptDetails.size()
                        }; // Start index after existing details

                        // Function to add a new detail row
                        function addDetailRow(detail = null) {
                            var $templateRow = $('#detail-template');
                            var $newRow = $templateRow.clone();

                            // Remove display: none and update ID
                            $newRow.css('display', '').removeAttr('id');

                            // Thêm lại thuộc tính required cho các phần tử trong dòng mới
                            $newRow.find('.product-select').attr('required', 'required');
                            $newRow.find('.variant-select').attr('required', 'required');
                            $newRow.find('.quantity').attr('required', 'required');
                            $newRow.find('.unit-price').attr('required', 'required');

                            // Set names for form submission (using index)
                            $newRow.find('.detail-id').attr('name', 'details[' + detailRowIndex + '].id');
                            $newRow.find('.product-select').attr('name', 'details[' + detailRowIndex + '].product.productId'); // Need product ID for variant fetching
                            $newRow.find('.variant-select').attr('name', 'details[' + detailRowIndex + '].productVariantId'); // Send variant ID
                            $newRow.find('.quantity').attr('name', 'details[' + detailRowIndex + '].quantity');
                            $newRow.find('.unit-price').attr('name', 'details[' + detailRowIndex + '].unitPrice');

                            // Populate with existing data if available (for update)
                            if (detail) {
                                $newRow.find('.detail-id').val(detail.id || 0); // Use 0 for new details added on update page
                                $newRow.find('.product-select').val(detail.product.productId);
                                // Trigger product change to load variants
                                $newRow.find('.product-select').trigger('change');
                                // After variants are loaded, set the variant
                                // This needs to be done asynchronously after the AJAX call completes
                                $newRow.find('.variant-select').data('selected-variant-id', detail.productVariant.productVariantId); // Store variant ID temporarily
                                $newRow.find('.quantity').val(detail.quantity);
                                $newRow.find('.unit-price').val(detail.unitPrice);
                                $newRow.find('.subtotal').text((detail.quantity * detail.unitPrice).toFixed(2));
                            }


                            // Add remove button functionality
                            $newRow.find('.remove-detail').click(function () {
                                $(this).closest('.detail-row').remove();
                                updateTotalAmount();
                                // Re-index rows after removal if needed for server-side binding,
                                // but sending as JSON array is easier.
                            });

                            // Append the new row to the container
                            $('#detailsContainer').append($newRow);

                            // Increment index for the next row
                            detailRowIndex++;
                        }

                        // Load existing details when the page loads
                        <c:forEach items="${purchaseReceipt.purchaseReceiptDetails}" var="detail">
                            addDetailRow({
                                id: ${detail.id},
                            product: {productId: ${detail.product.productId} },
                            productVariant: {productVariantId: ${detail.productVariant.productVariantId} },
                            quantity: ${detail.quantity},
                            unitPrice: ${detail.unitPrice}
                                });
                        </c:forEach>


                        // Add new detail row button click
                        $('#addDetail').click(function () {
                            addDetailRow();
                        });

                        // Handle product selection change (existing code, ensure it's present)
                        $(document).on('change', '.product-select', function () {
                            var selectedProductId = $(this).val();
                            var $variantSelect = $(this).closest('.detail-row').find('.variant-select');
                            var selectedVariantId = $variantSelect.data('selected-variant-id'); // Get stored variant ID

                            // Clear previous options except the default one
                            $variantSelect.find('option:not([value=""])').remove();
                            // Disable variant select initially
                            $variantSelect.prop('disabled', true);
                            $variantSelect.append('<option value="">-- Đang tải biến thể --</option>');


                            if (selectedProductId) {
                                // Make AJAX call to fetch variants
                                $.ajax({
                                    url: "${ctx}/admin/receipt-mgr/api/products/" + selectedProductId + "/variants",
                                    type: "GET",
                                    success: function (variants) {
                                        $variantSelect.find('option:not([value=""])').remove(); // Clear loading message
                                        if (variants.length > 0) {
                                            $variantSelect.append('<option value="">-- Chọn biến thể --</option>');
                                            $.each(variants, function (index, variant) {
                                                $variantSelect.append($('<option>', {
                                                    value: variant.productVariantId,
                                                    text: variant.variantName // Assuming ProductVariantDto has variantName
                                                }));
                                            });
                                            $variantSelect.prop('disabled', false);

                                            // If loading existing detail, set the variant after options are populated
                                            if (selectedVariantId) {
                                                $variantSelect.val(selectedVariantId);
                                                $variantSelect.removeData('selected-variant-id'); // Remove stored ID
                                            }

                                        } else {
                                            $variantSelect.append('<option value="">-- Không có biến thể --</option>');
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error("Error fetching product variants:", error);
                                        $variantSelect.find('option:not([value=""])').remove(); // Clear loading message
                                        $variantSelect.append('<option value="">-- Lỗi tải biến thể --</option>');
                                    }
                                });
                            } else {
                                $variantSelect.find('option:not([value=""])').remove(); // Clear loading message
                                $variantSelect.append('<option value="">-- Chọn sản phẩm trước --</option>');
                            }
                        });

                        // Trigger change for existing details to load variants
                        $('#detailsContainer .detail-row:not(#detail-template)').each(function () {
                            $(this).find('.product-select').trigger('change');
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

                        // Initial total amount calculation on page load
                        updateTotalAmount();


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
                                    id: parseInt($row.find('.detail-id').val()) || 0, // Include detail ID, 0 for new ones
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

                            // Set chuỗi JSON vào input ẩn
                            $('#detailsJson').val(detailsJson);

                            // Submit form
                            this.submit();
                        });
                        });

                    </script>

                </body>

                </html>