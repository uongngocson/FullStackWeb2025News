<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <!-- tạo từng file vì nhiều sản phẩm dễ quản lý , dễ push dữ liệu, rõ ràng -->
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Dashboard</title>
        <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
        <link rel="icon" href="../../../../../resources/assets/dashboard/img/kaiadmin/favicon.ico"
            type="image/x-icon" />

        <!-- Fonts and icons -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/webfont/webfont.min.js"></script>
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
                    urls: ["../../../../../resources/assets/dashboard/css/fonts.min.css"],
                },
                active: function () {
                    sessionStorage.fonts = true;
                },
            });
        </script>



        <!-- CSS Files -->
        <link rel="stylesheet" href="../../../../../resources/assets/dashboard/css/bootstrap.min.css" />
        <link rel="stylesheet" href="../../../../../resources/assets/dashboard/css/plugins.min.css" />
        <link rel="stylesheet" href="../../../../../resources/assets/dashboard/css/kaiadmin.min.css" />

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link rel="stylesheet" href="../../../../../resources/assets/dashboard/css/demo.css" />


        <style>
            body {
                background-color: #eae2f8;
            }

            .filter-container {
                background: #f1e8ff;
                padding: 20px;
                border-radius: 10px;
            }

            .search-btn {
                background-color: #a179dd;
                color: white;
                border: none;
            }

            .search-btn:hover {
                background-color: #8a5cb6;
            }

            .result {
                font-size: 20px;
                text-align: center;
                margin-top: 20px;
            }
        </style>






    </head>



    <body>
        <div class="wrapper">
            <!-- Thanh navbar bên trái -->

            <jsp:include page="../../layout/sidebarleft.jsp" />

            <!-- Body -->
            <div class="main-panel">

                <!-- Thanh header -->

                <jsp:include page="../../layout/header.jsp" />



                <div class="container">
                    <div>
                        <!-- header container -->
                        <div class="p-4 bg-dark text-white border-bottom border-light">
                            <div class="w-100 mb-1">
                                <div class="mb-4">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item">
                                                <a href="#" class="text-light"><i
                                                        class="bi bi-house-door-fill me-2"></i>Home</a>
                                            </li>
                                            <li class="breadcrumb-item">
                                                <a href="#" class="text-light">E-commerce</a>
                                            </li>
                                            <li class="breadcrumb-item active text-secondary" aria-current="page">
                                                Products</li>
                                        </ol>
                                    </nav>
                                    <h1 class="h4">Nhập loại sản phẩm</h1>
                                </div>
                                <div class="d-flex flex-column flex-sm-row justify-content-between align-items-center">
                                    <div class="d-flex">

                                        <div class="d-flex gap-2">
                                            <button class="btn btn-outline-light" type="button"><i
                                                    class="bi bi-gear"></i></button>
                                            <button class="btn btn-outline-light" type="button"><i
                                                    class="bi bi-trash"></i></button>
                                            <button class="btn btn-outline-light" type="button"><i
                                                    class="bi bi-exclamation-circle"></i></button>
                                            <button class="btn btn-outline-light" type="button"><i
                                                    class="bi bi-three-dots"></i></button>
                                        </div>
                                        <div class="container">
                                            <div class="input-group" id="datepicker">
                                                <input type="text" class="form-control" placeholder="dd/mm/yyyy">
                                                <span class="input-group-text"><i class="bi bi-calendar"></i></span>
                                            </div>
                                        </div>





                                    </div>


                                    <button id="createProductButton" class="btn btn-primary" type="button"
                                        data-bs-toggle="offcanvas" data-bs-target="#drawerCreateProduct"
                                        aria-controls="drawerCreateProduct">
                                        Add type SP
                                    </button>
                                </div>
                            </div>
                            <div class="w-100">
                                <!-- Thanh lọc sản phẩm -->
                                <div class=" filter-container p-0 shadow bg-dark text-white">
                                    <div class="row g-2 text-white">
                                        <div class="col-md-3">
                                            <label class="text-white form-label">Category</label>
                                            <select class=" form-select" id="category">
                                                <option value="">---</option>
                                                <option value="electronics">Electronics</option>
                                                <option value="clothing">Clothing</option>
                                                <option value="shoes">Shoes</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 text-white-strong">
                                            <label class="text-white form-label">Color</label>
                                            <select class="form-select" id="color">
                                                <option value="">---</option>
                                                <option value="red">Red</option>
                                                <option value="blue">Blue</option>
                                                <option value="black">Black</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3 text-white-strong">
                                            <label class="text-white form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Enter product name">
                                        </div>
                                        <div class="col-md-3 d-flex align-items-end">
                                            <button class="btn search-btn w-100"
                                                onclick="filterProducts()">Search</button>
                                        </div>
                                    </div>
                                    <div class="row g-2 mt-3">
                                        <div class="col-md-6">
                                            <label class="text-white form-label">Min Price</label>
                                            <input type="number" class="form-control" id="minPrice"
                                                placeholder="Min Price">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="text-white form-label">Max Price</label>
                                            <input type="number" class="form-control" id="maxPrice"
                                                placeholder="Max Price">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>



                        <script>
                            function filterProducts() {
                                let category = document.getElementById("category").value.toLowerCase();
                                let color = document.getElementById("color").value.toLowerCase();
                                let name = document.getElementById("name").value.toLowerCase();
                                let minPrice = document.getElementById("minPrice").value;
                                let maxPrice = document.getElementById("maxPrice").value;

                                let products = document.querySelectorAll(".product");
                                let count = 0;

                                products.forEach(product => {
                                    let productCategory = product.getAttribute("data-category").toLowerCase();
                                    let productColor = product.getAttribute("data-color").toLowerCase();
                                    let productName = product.getAttribute("data-name").toLowerCase();
                                    let productPrice = parseFloat(product.getAttribute("data-price"));

                                    let show = true;

                                    if (category && category !== productCategory) show = false;
                                    if (color && color !== productColor) show = false;
                                    if (name && !productName.includes(name)) show = false;
                                    if (minPrice && productPrice < parseFloat(minPrice)) show = false;
                                    if (maxPrice && productPrice > parseFloat(maxPrice)) show = false;

                                    if (show) {
                                        product.style.display = "block";
                                        count++;
                                    } else {
                                        product.style.display = "none";
                                    }
                                });

                                document.getElementById("resultText").innerHTML = `Found <b>${count}</b> results`;
                            }
                        </script>



                        <!-- load table data -->

                        <div class="mt-4">
                            <div class="table-responsive">
                                <table class="table table-dark table-hover align-middle w-100">
                                    <thead>
                                        <tr>
                                            <th scope="col"><input type="checkbox" class="form-check-input"></th>
                                            <th scope="col">ID</th>
                                            <th scope="col">Product Name</th>
                                            <th scope="col">Technology</th>
                                            <th scope="col">Description</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Discount</th>
                                            <th scope="col">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="product-tbody"></tbody>
                                    <!-- dữ liệu bảng load từ file pushData.js vì dùng DOM -->

                                </table>
                            </div>
                        </div>

                        <!-- add products  -->
                        <div class="offcanvas offcanvas-end" tabindex="-1" id="drawerCreateProduct"
                            aria-labelledby="drawerCreateProductLabel">
                            <div class="offcanvas-header">
                                <h5 id="drawerCreateProductLabel">Thêm loại sản phẩm mới</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <form action="#">
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price</label>
                                        <input type="number" class="form-control" id="price" placeholder="$2999"
                                            required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="category-create" class="form-label">Technology</label>
                                        <select class="form-select" id="category-create">
                                            <option selected>Select category</option>
                                            <option value="FL">Flowbite</option>
                                            <option value="RE">React</option>
                                            <option value="AN">Angular</option>
                                            <option value="VU">Vue</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" rows="4"
                                            placeholder="Enter event description here"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount-create" class="form-label">Discount</label>
                                        <select class="form-select" id="discount-create">
                                            <option selected>No</option>
                                            <option value="5">5%</option>
                                            <option value="10">10%</option>
                                            <option value="20">20%</option>
                                            <option value="30">30%</option>
                                            <option value="40">40%</option>
                                            <option value="50">50%</option>
                                        </select>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary w-25">Add product</button>
                                        <button type="button" class="btn btn-outline-secondary w-25"
                                            data-bs-dismiss="offcanvas">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>



                        <!-- update products -->
                        <!-- update sản phẩm ở đây , khi bấm vào update thì phải load hết dữ liệu có sẵn của cái cần update -->
                        <div class="offcanvas offcanvas-end" tabindex="-1" id="drawerUpdateProduct"
                            aria-labelledby="drawerCreateProductLabel">
                            <div class="offcanvas-header">
                                <h5 id="drawerCreateProductLabel">Cập nhập loại SP</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <form action="#">
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name"
                                            placeholder="Type product name" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price</label>
                                        <input type="number" class="form-control" id="price" placeholder="$2999"
                                            required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="category-create" class="form-label">Technology</label>
                                        <select class="form-select" id="category-create">
                                            <option selected>Select category</option>
                                            <option value="FL">Flowbite</option>
                                            <option value="RE">React</option>
                                            <option value="AN">Angular</option>
                                            <option value="VU">Vue</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" rows="4"
                                            placeholder="Enter event description here"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount-create" class="form-label">Discount</label>
                                        <select class="form-select" id="discount-create">
                                            <option selected>No</option>
                                            <option value="5">5%</option>
                                            <option value="10">10%</option>
                                            <option value="20">20%</option>
                                            <option value="30">30%</option>
                                            <option value="40">40%</option>
                                            <option value="50">50%</option>
                                        </select>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary w-25">Add product</button>
                                        <button type="button" class="btn btn-outline-secondary w-25"
                                            data-bs-dismiss="offcanvas">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>



                        <!-- delete product -->
                        <div class="offcanvas offcanvas-end" style="--bs-offcanvas-width: 400px;" tabindex="-1"
                            id="drawerDeleteProduct" aria-labelledby="drawerCreateProductLabel">
                            <div class="offcanvas-header">
                                <h5 id="drawer-label" class="text-uppercase text-secondary">Delete item</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body text-center">
                                <svg class="w-25 h-25 mt-3 mb-4 text-danger" fill="none" stroke="currentColor"
                                    viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                        d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <h3 class="mb-4 text-secondary">Are you sure you want to delete this product?</h3>
                                <div class="d-flex justify-content-center gap-2">
                                    <a href="#" class="btn btn-danger">Yes, I'm sure</a>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">No,
                                        cancel</button>
                                </div>
                            </div>

                        </div>

                        <!-- Detail product -->

                        <div class="offcanvas offcanvas-end" tabindex="-1" id="drawerDetailProduct"
                            aria-labelledby="drawerCreateProductLabel">
                            <div class="offcanvas-header">
                                <h5 id="drawerCreateProductLabel">Thông tin chi tiết sản phẩm</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <form action="#">
                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>

                                    <div class="mb-3 d-flex gap-2 ">
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>

                                        </div>
                                        <div class="w-100">
                                            <label for="name" class="form-label">Name</label>
                                            <input type="text" class="form-control" id="name"
                                                placeholder="Type product name" required>


                                        </div>


                                    </div>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name"
                                            placeholder="Type product name" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="price" class="form-label">Price</label>
                                        <input type="number" class="form-control" id="price" placeholder="$2999"
                                            required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="category-create" class="form-label">Technology</label>
                                        <select class="form-select" id="category-create">
                                            <option selected>Select category</option>
                                            <option value="FL">Flowbite</option>
                                            <option value="RE">React</option>
                                            <option value="AN">Angular</option>
                                            <option value="VU">Vue</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" rows="4"
                                            placeholder="Enter event description here"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label for="discount-create" class="form-label">Discount</label>
                                        <select class="form-select" id="discount-create">
                                            <option selected>No</option>
                                            <option value="5">5%</option>
                                            <option value="10">10%</option>
                                            <option value="20">20%</option>
                                            <option value="30">30%</option>
                                            <option value="40">40%</option>
                                            <option value="50">50%</option>
                                        </select>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary w-25">Add product</button>
                                        <button type="button" class="btn btn-outline-secondary w-25"
                                            data-bs-dismiss="offcanvas">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>











                        <!-- Bootstrap Icons (bi) requires Bootstrap Icons CDN or local installation -->
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

                        <!-- Edit Product Drawer -->







                        <!-- Delete Product Drawer -->





                        <!-- chia trang cho table -->
                        <div
                            class="position-sticky bottom-0 end-0 w-100 p-4 border-top border-secondary bg-dark text-light d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <a href="#"
                                    class="p-2 text-secondary rounded-circle d-flex align-items-center justify-content-center me-2"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-chevron-left fs-4"></i>
                                </a>
                                <a href="#"
                                    class="p-2 text-secondary rounded-circle d-flex align-items-center justify-content-center"
                                    style="width: 40px; height: 40px;">
                                    <i class="bi bi-chevron-right fs-4"></i>
                                </a>
                                <span class="ms-3">Showing <strong class="text-white">1-20</strong> of <strong
                                        class="text-white">2290</strong></span>
                            </div>
                            <div class="d-flex">
                                <a href="#" class="btn btn-primary d-flex align-items-center me-2">
                                    <i class="bi bi-chevron-left me-1"></i> Previous
                                </a>
                                <a href="#" class="btn btn-primary d-flex align-items-center">
                                    Next <i class="bi bi-chevron-right ms-1"></i>
                                </a>
                            </div>
                        </div>










                    </div>
                </div>
                <jsp:include page="../../layout/custom-template.jsp" />


            </div>

        </div>

        <!--   Core JS Files   -->
        <script src="../../../../../resources/assets/dashboard/js/core/jquery-3.7.1.min.js"></script>
        <script src="../../../../../resources/assets/dashboard/js/core/popper.min.js"></script>
        <script src="../../../../../resources/assets/dashboard/js/core/bootstrap.min.js"></script>

        <!-- jQuery Scrollbar -->
        <script
            src="../../../../../resources/assets/dashboard/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

        <!-- Chart JS -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/chart.js/chart.min.js"></script>

        <!-- jQuery Sparkline -->
        <script
            src="../../../../../resources/assets/dashboard/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

        <!-- Chart Circle -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/chart-circle/circles.min.js"></script>

        <!-- Datatables -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/datatables/datatables.min.js"></script>

        <!-- Bootstrap Notify -->
        <script
            src="../../../../../resources/assets/dashboard/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

        <!-- jQuery Vector Maps -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/jsvectormap/jsvectormap.min.js"></script>
        <script src="../../../../../resources/assets/dashboard/js/plugin/jsvectormap/world.js"></script>

        <!-- Sweet Alert -->
        <script src="../../../../../resources/assets/dashboard/js/plugin/sweetalert/sweetalert.min.js"></script>

        <!-- Kaiadmin JS -->
        <script src="../../../../../resources/assets/dashboard/js/kaiadmin.min.js"></script>

        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
        <script
            src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

        <!-- Kaiadmin DEMO methods, don't include it in your project! -->
        <script src="../../../../../resources/assets/dashboard/js/setting-demo.js"></script>
        <script src="../../../../../resources/assets/dashboard/js/demo.js"></script>
        <script src="../../../../../resources/assets/dashboard/js/pustData.js"></script>



        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const collapseItems = ["sub", "subnav1"]; // Danh sách các ID collapse

                collapseItems.forEach(id => {
                    let element = document.getElementById(id);
                    if (element) {
                        // Xóa class "show" mặc định
                        element.classList.remove("show");

                        // Nếu trong localStorage có lưu trạng thái mở => thêm class "show"
                        if (localStorage.getItem(id) === "open") {
                            element.classList.add("show");
                        }
                    }
                });
            });

            function toggleCollapse(id) {
                let element = document.getElementById(id);
                if (!element) return;

                let isCollapsed = element.classList.contains("show");

                if (isCollapsed) {
                    localStorage.removeItem(id); // Nếu đang mở, khi nhấn sẽ đóng
                    element.classList.remove("show");
                } else {
                    localStorage.setItem(id, "open"); // Nếu đang đóng, khi nhấn sẽ mở
                    element.classList.add("show");
                }
            }


            $(document).ready(function () {
                console.log("jQuery version:", $.fn.jquery);
                console.log("Datepicker available:", $.fn.datepicker);

                if ($.fn.datepicker) {
                    let $input = $('#datepicker input');

                    // Khởi tạo Datepicker chỉ trên input
                    $input.datepicker({
                        format: 'dd/mm/yyyy',
                        autoclose: true,
                        todayHighlight: true
                    });

                    // Khi bấm vào icon lịch thì mở Datepicker
                    $('#datepicker .input-group-text').click(function () {
                        $input.focus();
                    });
                } else {
                    console.error("Bootstrap Datepicker chưa được tải!");
                }
            });
        </script>




        <script>
            $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#177dff",
                fillColor: "rgba(23, 125, 255, 0.14)",
            });

            $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#f3545d",
                fillColor: "rgba(243, 84, 93, .14)",
            });

            $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#ffa534",
                fillColor: "rgba(255, 165, 52, .14)",
            });
        </script>
    </body>

    </html>