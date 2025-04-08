<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <title>${customer.customerId != null ? 'Edit' : 'Create'} Customer</title>
                <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
                <link rel="icon" href="../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
                    type="image/x-icon" />

                <!-- Fonts and icons -->
                <script src="../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
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
                        <jsp:include page="../layout/header.jsp" />

                        <div class="container">
                            <div class="page-inner">

                                <!-- Page header-->
                                <div class="page-header">
                                    <h3 class="fw-bold mb-3">${customer.customerId != null ? 'Edit' : 'Create'} Customer
                                    </h3>
                                    <ul class="breadcrumbs mb-3">
                                        <li class="nav-home">
                                            <a href="#"><i class="icon-home"></i></a>
                                        </li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="/customer-mgr/list">Customers</a></li>
                                        <li class="separator"><i class="icon-arrow-right"></i></li>
                                        <li class="nav-item"><a href="#">${customer.customerId != null ? 'Edit' :
                                                'Create'}</a>
                                        </li>
                                    </ul>
                                </div>
                                <!-- End Page header-->

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <div class="card-title">${customer.customerId != null ? 'Update
                                                    Customer' : 'Create
                                                    New Customer'}</div>
                                            </div>
                                            <form:form action="/customer-mgr/save" method="post"
                                                modelAttribute="customer">
                                                <div class="card-body">
                                                    <c:if test="${not empty customer.customerId}">
                                                        <form:hidden path="customerId" />
                                                    </c:if>

                                                    <div class="row">
                                                        <!-- First Name -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="firstName">First Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="firstName" type="text"
                                                                    class="form-control" id="firstName"
                                                                    placeholder="Enter first name" required="true" />
                                                                <form:errors path="firstName" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Last Name -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="lastName">Last Name <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="lastName" type="text"
                                                                    class="form-control" id="lastName"
                                                                    placeholder="Enter last name" required="true" />
                                                                <form:errors path="lastName" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Email -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="email">Email <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="email" type="email"
                                                                    class="form-control" id="email"
                                                                    placeholder="Enter email address" required="true" />
                                                                <form:errors path="email" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Phone Number -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="phoneNumber">Phone Number <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="phoneNumber" type="tel"
                                                                    class="form-control" id="phoneNumber"
                                                                    placeholder="Enter phone number" required="true" />
                                                                <form:errors path="phoneNumber"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Date of Birth -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="dateOfBirth">Date of Birth <span
                                                                        class="text-danger">*</span></label>
                                                                <form:input path="dateOfBirth" type="date"
                                                                    class="form-control" id="dateOfBirth"
                                                                    required="true" />
                                                                <form:errors path="dateOfBirth"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Registration Date -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="registrationDate">Registration Date</label>
                                                                <form:input path="registrationDate" type="date"
                                                                    class="form-control" id="registrationDate" />
                                                                <form:errors path="registrationDate"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Gender -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label>Gender <span class="text-danger">*</span></label>
                                                                <div>
                                                                    <form:radiobutton path="gender" value="true"
                                                                        id="male" /> <label for="male">Male</label>
                                                                    <form:radiobutton path="gender" value="false"
                                                                        id="female" /> <label
                                                                        for="female">Female</label>
                                                                </div>
                                                                <form:errors path="gender" cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Profile Image -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="profileImage">Profile Image</label>
                                                                <form:input path="profileImage" type="file"
                                                                    class="form-control" id="profileImage" />
                                                                <form:errors path="profileImage"
                                                                    cssClass="text-danger" />
                                                            </div>
                                                        </div>

                                                        <!-- Status -->
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="status">Status</label>
                                                                <div>
                                                                    <form:checkbox path="status" id="status" /> Active
                                                                </div>
                                                                <form:errors path="status" cssClass="text-danger" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card-action">
                                                    <button type="submit" class="btn btn-success">${customer.customerId
                                                        != null ? 'Update' : 'Add'}</button>
                                                    <button type="reset" class="btn btn-primary">Reset</button>
                                                    <a href="/customer-mgr/list" class="btn btn-danger">Cancel</a>
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
            </body>

            </html>