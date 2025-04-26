<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>DDTS | Product Detail</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link rel="stylesheet" href="${ctx}/resources/assets/client/css/productDetail.css">
                    <script id="variantsData" type="application/json">
                    ${variantsJson}
                </script>

                </head>

                <body class="bg-white">
                    <!-- navbar -->
                    <jsp:include page="../layout/navbar.jsp" />
                    <!-- Product Container -->
                    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-[64px] ">
                        <div class="product-container flex flex-col md:flex-row gap-8">
                            <!-- Left Column - Product Gallery -->
                            <div class="w-full md:w-1/2">
                                <div class="product-gallery flex flex-col-reverse md:flex-row">
                                    <!-- Thumbnails -->
                                    <div class="thumbnail-container flex md:flex-col gap-2 mt-4 md:mt-0 md:mr-4">
                                        <div
                                            class="w-16 h-16 md:w-20 md:h-20 bg-gray-100 cursor-pointer border border-transparent hover:border-gray-300">
                                            <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                                alt="Product thumbnail 4" class="w-full h-full object-cover">
                                        </div>
                                    </div>

                                    <!-- Main Image -->
                                    <div class="flex-1 bg-gray-50 aspect-square">
                                        <img src="https://images.unsplash.com/photo-1591047139829-d91aecb6caea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=736&q=80"
                                            alt="MONOCHROME Oversized Blazer" class="w-full h-full object-cover">
                                    </div>
                                </div>
                            </div>

                            <!-- Right Column - Product Info -->
                            <div class="w-full md:w-1/2">
                                <!-- Product Title -->
                                <h1 class="text-2xl md:text-3xl font-medium mb-2">${product.productName}</h1>

                                <!-- Rating and Reviews -->
                                <div class="flex items-center mb-4">
                                    <div class="flex items-center mr-2">
                                        <span class="text-yellow-400 mr-1">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star-half-alt"></i>
                                        </span>
                                        <span class="text-sm font-medium">4.7</span>
                                    </div>
                                    <span class="mx-2 text-gray-300">|</span>
                                    <span class="text-sm text-gray-500">${product.quantitySold} sold</span>
                                </div>

                                <!-- Pricing -->
                                <div class="mb-6">
                                    <div class="flex items-center">
                                        <span class="text-2xl font-bold mr-3">${product.price}</span>
                                        <!-- <span class="text-lg text-gray-500 line-through mr-2">$129.99</span>
                                    <span class="discount-badge text-xs text-white px-2 py-1 rounded">31% OFF</span> -->
                                    </div>
                                    <p class="text-sm text-gray-500 mt-1">Inclusive of all taxes</p>
                                </div>

                                <!-- Color Selection -->
                                <div class="mb-6">
                                    <h3 class="text-sm font-medium mb-3">COLOR: <p id="selectedColor"
                                            style="display:none;"></p>
                                    </h3>
                                    <div class="flex gap-2">
                                        <c:forEach var="color" items="${colors}">
                                            <div class="color-option w-8 h-8 rounded-full cursor-pointer"
                                                style="background-color: ${color.colorHex}; border: 1px solid black;"
                                                data-color-id="${color.colorId}"
                                                onclick="selectColor(this, '${color.colorName}')"></div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Size Selection -->
                                <div class="mb-6">
                                    <h3 class="text-sm font-medium mb-3">SIZE:<p id="selectedSize"
                                            style="display:none;"></p>
                                    </h3>
                                    <div class="grid grid-cols-5 gap-2">
                                        <c:forEach var="size" items="${sizes}">
                                            <div class="size-option text-center py-2 border border-gray-200 cursor-pointer text-sm"
                                                data-size-id="${size.sizeId}"
                                                onclick="selectSize(this, '${size.sizeName}')">
                                                ${size.sizeName}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Quantity -->
                                <div class="mb-6">
                                    <h3 class="text-sm font-medium mb-3">QUANTITY:</h3>
                                    <div class="flex items-center border border-gray-200 w-24">
                                        <button type="button" onclick="adjustQuantity(-1)">-</button>
                                        <span id="quantityDisplay" class="flex-1 text-center">1</span>
                                        <button type="button" onclick="adjustQuantity(1)">+</button>
                                    </div>
                                </div>

                                <!-- Hidden Input to hold selected variantId -->

                                <!-- Action Buttons -->
                                <div class="flex flex-col sm:flex-row gap-3 mb-8">
                                    <!-- Nút ADD TO CART -->
                                    <c:set var="productId" value="${product.productId}" />
                                    <form action="/product-variant/add-to-cart/${productId}" method="post"
                                        class="flex-1">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <button
                                            class="w-full btn-primary bg-black text-white py-3 font-medium hover:bg-gray-800">
                                            <i class="fas fa-shopping-cart mr-2"></i> ADD TO CART
                                        </button>
                                    </form>

                                    <!-- Nút BUY NOW -->
                                    <form action="/user/order" method="get" id="buyNowForm" class="flex-1">
                                        <input type="hidden" name="variantId" id="selectedVariantId" />
                                        <input type="hidden" name="quantity" id="quantityInput" value="1" />
                                        <button type="submit"
                                            class="w-full btn-secondary bg-red-600 text-white py-3 font-medium hover:bg-red-700">
                                            <i class="fas fa-credit-card mr-2"></i> BUY NOW
                                        </button>
                                    </form>
                                </div>


                                <!-- Wishlist & Share -->
                                <div class="flex items-center gap-4 mb-8">
                                    <button class="flex items-center text-sm text-gray-700 hover:text-black">
                                        <i class="far fa-heart mr-2"></i> Add to Wishlist
                                    </button>
                                    <div class="flex items-center gap-3">
                                        <span class="text-sm text-gray-700">Share:</span>
                                        <a href="#" class="text-gray-500 hover:text-black"><i
                                                class="fab fa-facebook-f"></i></a>
                                        <a href="#" class="text-gray-500 hover:text-black"><i
                                                class="fab fa-twitter"></i></a>
                                        <a href="#" class="text-gray-500 hover:text-black"><i
                                                class="fab fa-pinterest-p"></i></a>
                                    </div>
                                </div>

                                <!-- Promo Banner -->
                                <div class="border border-gray-200 p-4 mb-8">
                                    <h3 class="text-sm font-medium mb-2">SPECIAL OFFER</h3>
                                    <p class="text-xs text-gray-700 mb-2">Get 10% additional discount when you spend
                                        over
                                        $200</p>
                                    <button class="text-xs text-red-600 font-medium underline">View All
                                        Vouchers</button>
                                </div>

                                <!-- Store Info -->

                            </div>
                        </div>

                        <!-- Product Details Section -->
                        <div class="mt-16">
                            <h2 class="text-xl font-medium mb-6">Product Details</h2>
                            <!-- Description -->
                            <div class="mb-12">
                                <h3 class="text-sm font-medium mb-4 uppercase tracking-wider">Description</h3>
                                <div class="prose max-w-none">
                                    <p class="text-sm mb-4">${product.description}
                                    <pre>${variantsJson}</pre>

                                    </p>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- footer -->
                    <jsp:include page="../layout/footer.jsp" />
                    <script>
                        let variants = [];
                        try {
                            const rawJson = document.getElementById("variantsData").textContent.trim();
                            variants = JSON.parse(rawJson);
                            console.log("Variants loaded:", variants);
                        } catch (e) {
                            console.error("Lỗi khi parse variantsJson:", e);
                        }


                        function selectColor(el, name) {
                            document.querySelectorAll('.color-option').forEach(e => e.classList.remove('selected'));
                            el.classList.add('selected');
                            const label = document.getElementById('selectedColor');
                            if (label) label.innerText = name;
                            updateSelectedVariant();
                        }

                        function selectSize(el, name) {
                            document.querySelectorAll('.size-option').forEach(e => e.classList.remove('selected'));
                            el.classList.add('selected');
                            const label = document.getElementById('selectedSize');
                            if (label) label.innerText = name;
                            updateSelectedVariant();
                        }

                        function adjustQuantity(change) {
                            const display = document.getElementById('quantityDisplay');
                            let val = parseInt(display.innerText);
                            val = Math.max(1, val + change);
                            display.innerText = val;
                            document.getElementById('quantityInput').value = val;
                        }

                        function updateSelectedVariant() {
                            if (!variants || variants.length === 0) {
                                console.warn("Không có variants để xử lý.");
                                return;
                            }

                            const selectedColorId = document.querySelector('.color-option.selected')?.dataset.colorId;
                            const selectedSizeId = document.querySelector('.size-option.selected')?.dataset.sizeId;

                            if (selectedColorId && selectedSizeId) {
                                const found = variants.find(v =>
                                    v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                );
                                if (found) {
                                    document.getElementById('selectedVariantId').value = found.productVariantId;
                                    console.log("Selected variant ID:", found.productVariantId);
                                } else {
                                    alert("Tổ hợp size & màu này không có sẵn!");
                                }
                            }

                            console.log("Hidden input value set to:", document.getElementById('selectedVariantId').value);
                        }

                        document.getElementById('buyNowForm').addEventListener('submit', function (e) {
                            updateSelectedVariant(); // GỌI BẮT BUỘC

                            const variantInput = document.getElementById('selectedVariantId');
                            console.log("Variant to submit:", variantInput.value);

                            if (!variantInput.value) {
                                e.preventDefault();
                                alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                            }
                        });

                    </script>
                </body>

                </html>