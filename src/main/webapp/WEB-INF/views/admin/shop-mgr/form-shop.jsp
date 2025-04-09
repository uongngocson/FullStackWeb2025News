<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>Create Product</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />

                <!-- set path -->
                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <!-- Fonts and icons -->
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>

                <!-- ckeditor -->
                <!-- <script src="../../../../resources/ckeditor/ckeditor.js"></script> -->
                <script src="https://cdn.ckeditor.com/ckeditor5/36.0.1/classic/ckeditor.js"></script>

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
                            urls: ["../../../../resources/assets/dashboard/css/fonts.min.css"],
                        },
                        active: function () {
                            sessionStorage.fonts = true;
                        },
                    });
                </script>

                <!-- CSS Files -->
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/plugins.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/kaiadmin.min.css" />
                <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/demo.css" />
            </head>

            <body>
                <div class="wrapper">
                    <!-- Sidebar -->
                    <jsp:include page="../layout/sidebar.jsp" />
                    <!-- End Sidebar -->

                    <div class="main-panel">
                        <!-- start header -->
                        <jsp:include page="../layout/header.jsp" />
                        <!-- end header -->

                        <!-- Content -->
                        <div class="container">
                            <div class="page-inner">

                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${shop.shopId != null ? 'Update' : 'Create'} Shop</h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="/admin/dashboard/index"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/admin/shop-mgr/list">Shops</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${shop.shopId != null ? 'Update' :
                                                'Create'}</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <form:form action="/admin/shop-mgr/save" method="post" modelAttribute="shop"
                                                enctype="multipart/form-data">
                                                <div class="card-body">
                                                    <!-- id -->
                                                    <c:if test="${not empty shop.shopId}">
                                                        <form:hidden path="shopId" />
                                                    </c:if>

                                                    <div class="row mb-4">
                                                        <!-- shop name -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3 ">
                                                                <label class="fw-bold">Shop Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="shopName" type="text"
                                                                    class="form-control form-control-lg" id="shopName"
                                                                    placeholder="Enter shop name" />
                                                                <form:errors path="shopName" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- contact person -->
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Contact Person <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="contactPerson" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="contactPerson"
                                                                    placeholder="Enter contact person" />
                                                                <form:errors path="contactPerson"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Phone Number <span
                                                                        class="text-danger">*</label>
                                                                <form:input path="phoneNumber" type="tel"
                                                                    class="form-control form-control-lg"
                                                                    id="phoneNumber" placeholder="Enter phone number" />
                                                                <form:errors path="phoneNumber"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Email <span
                                                                        class="text-danger">*</label>
                                                                <form:input path="email" type="email"
                                                                    class="form-control form-control-lg" id="email"
                                                                    placeholder="Enter email" />
                                                                <form:errors path="email" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="mb-4">
                                                        <label class="fw-bold">Shop Address <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="shopAddress" type="text"
                                                            class="form-control form-control-lg" id="shopAddress"
                                                            placeholder="Enter shop address" />
                                                        <form:errors path="shopAddress" cssClass="text-danger" />
                                                    </div>

                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Operating Hours <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="operatingHours" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="operatingHours"
                                                                    placeholder="Enter operating hours (e.g., 9:00 AM - 5:00 PM)" />
                                                                <form:errors path="operatingHours"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Shop Category</label>
                                                                <form:input path="shopCategory" type="text"
                                                                    class="form-control form-control-lg"
                                                                    id="shopCategory"
                                                                    placeholder="Enter shop category" />
                                                                <form:errors path="shopCategory"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Shop Logo</label>
                                                                <div class="file-upload-wrapper">
                                                                    <input type="file" id="logoFile" name="logoFile"
                                                                        class="file-upload-input"
                                                                        data-preview="#logoPreview" accept="image/*">
                                                                    <form:hidden path="logoUrl" />
                                                                </div>
                                                                <div class="mt-2">
                                                                    <div id="logoPreview" class="img-preview">
                                                                        <c:if test="${not empty shop.logoUrl}">
                                                                            <img src="${ctx}/${shop.logoUrl}"
                                                                                alt="Shop Logo"
                                                                                class="img-fluid rounded"
                                                                                style="max-height: 150px;">
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Cover Image</label>
                                                                <div class="file-upload-wrapper">
                                                                    <input type="file" id="coverFile" name="coverFile"
                                                                        class="file-upload-input"
                                                                        data-preview="#coverPreview" accept="image/*">
                                                                    <form:hidden path="coverImageUrl" />
                                                                </div>
                                                                <div class="mt-2">
                                                                    <div id="coverPreview" class="img-preview">
                                                                        <c:if test="${not empty shop.coverImageUrl}">
                                                                            <img src="${ctx}/${shop.coverImageUrl}"
                                                                                alt="Shop Cover"
                                                                                class="img-fluid rounded"
                                                                                style="max-height: 150px;">
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row mb-4">
                                                        <div class="col-md-4">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Rating</label>
                                                                <form:input path="rating" type="number" step="0.1"
                                                                    min="0" max="5" class="form-control form-control-lg"
                                                                    id="rating" placeholder="Enter rating (0-5)" />
                                                                <form:errors path="rating" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="mb-3">
                                                                <label class="fw-bold">Total Followers</label>
                                                                <form:input path="totalFollowers" type="number" min="0"
                                                                    class="form-control form-control-lg"
                                                                    id="totalFollowers"
                                                                    placeholder="Enter follower count" />
                                                                <form:errors path="totalFollowers"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-check form-switch mt-4">
                                                                <form:checkbox path="isActive" class="form-check-input"
                                                                    id="isActiveSwitch" role="switch" />
                                                                <label class="form-check-label fw-bold"
                                                                    for="isActiveSwitch">
                                                                    Active Shop
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <label class="fw-bold">Description <span
                                                                    class="text-danger">*</span></label>
                                                            <form:textarea path="shopDescription"
                                                                class="form-control form-control-lg"
                                                                id="shopDescription" rows="5"
                                                                placeholder="Enter shop description" />
                                                            <!-- Khởi tạo CKEditor -->
                                                            <!-- <script>
                                                                CKEDITOR.replace('shopDescription');
                                                            </script> -->
                                                            <form:errors path="shopDescription"
                                                                cssClass="text-danger" />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${shop.shopId != null
                                                        ? 'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary"
                                                        id="btn-reset">Reset</button>
                                                    <a href="/admin/shop-mgr/list" class="btn btn-danger">Cancel</a>
                                                </div>
                                            </form:form>
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

                <!-- Core JS Files -->
                <script src="../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
                <script src="../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

                <!-- jQuery Scrollbar -->
                <script
                    src="../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

                <!-- Sweet Alert -->
                <script src="../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

                <!-- Kaiadmin JS -->
                <script src="../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

                <script>
                    // Ép EL vào biến JavaScript và đảm bảo bao quanh bằng dấu nháy nếu là chuỗi
                    var shopId = '<c:out value="${shop.shopId}" />';
                    if (shopId !== '') {
                        document.getElementById('btn-reset').style.display = 'none';
                    }
                </script>


                <script>
                    // Khởi tạo CKEditor cho textarea có id là shopDescription
                    ClassicEditor
                        .create(document.querySelector('#shopDescription'), {
                        })
                        .catch(error => {
                            console.error(error);
                        });

                    // Image preview functionality
                    $(document).ready(function () {
                        // Function to handle file input change and show preview
                        function handleFileInputChange(input) {
                            const previewElement = $($(input).data('preview'));

                            if (input.files && input.files[0]) {
                                const reader = new FileReader();

                                reader.onload = function (e) {
                                    // Clear previous preview
                                    previewElement.html('');

                                    // Create image element
                                    const img = $('<img>')
                                        .attr('src', e.target.result)
                                        .addClass('img-fluid rounded')
                                        .css('max-height', '150px');

                                    // Add to preview container
                                    previewElement.append(img);
                                }

                                reader.readAsDataURL(input.files[0]);
                            }
                        }

                        // Attach event listeners to file inputs
                        $('#logoFile').change(function () {
                            handleFileInputChange(this);
                        });

                        $('#coverFile').change(function () {
                            handleFileInputChange(this);
                        });

                    });
                </script>

            </body>

            </html>