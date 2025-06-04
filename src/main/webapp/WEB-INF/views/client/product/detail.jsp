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
                    <link rel="icon" href="https://image.similarpng.com/file/similarpng/very-thumbnail/2021/01/Fashion-shop-logo-design-on-transparent-background-PNG.png" type="image/x-icon">

                    <script>
                        // Create a JavaScript product object from JSP data
                        const product = {
                            productId: "${product.productId}",
                            productName: "${product.productName}",
                            price: "${product.price}",
                            description: "${product.description}",
                            imageUrl: "${product.imageUrl}",
                            quantitySold: "${product.quantitySold}"
                        };

                    </script>
                    <script id="variantsData" type="application/json">
                    ${variantsJson}
                </script>

                </head>

                <body class="bg-white">
                    <!-- navbar -->
                    <jsp:include page="../layout/navbar.jsp" />

                    <!-- Product Container -->

                    <div class="bg-gray-100">
                        <div class="container mx-auto px-4 py-8">
                            <div class="bg-white py-8 antialiased dark:bg-gray-900 md:py-16 flex flex-wrap -mx-4">
                                <!-- Product Images -->
                                <div class="w-full md:w-1/2 px-4 mb-8">
                                    <div class="product-gallery">
                                        <div class="main-image-container relative overflow-hidden rounded-lg shadow-lg mb-4">
                                        <button id="view3dButton"
                                            class="absolute top-3 left-3 bg-black bg-opacity-70 hover:bg-opacity-90 text-white p-2 rounded-lg z-10 transition-all duration-300 flex items-center space-x-2 transform hover:scale-105 shadow-lg">
                                            <i class="fas fa-cube"></i>
                                            <span class="text-sm font-medium">XEM 3D</span>
                                        </button>
                                            <div id="productContainer" class="image-zoom-container" data-product-id="${product.productId}">
                                        <img src="${product.imageUrl}" alt="${product.productName}"
                                                    class="w-full h-auto object-cover transition-transform duration-500 ease-out"
                                            id="mainImage">
                                                <div class="zoom-lens"></div>
                                    </div>
                                            <div class="image-controls absolute bottom-4 right-4 flex space-x-2">
                                                <button class="bg-white bg-opacity-70 hover:bg-opacity-100 p-2 rounded-full shadow-md transition-all duration-300" id="zoomToggle">
                                                    <i class="fas fa-search-plus"></i>
                                                </button>
                                                <button class="bg-white bg-opacity-70 hover:bg-opacity-100 p-2 rounded-full shadow-md transition-all duration-300" id="fullscreenToggle">
                                                    <i class="fas fa-expand"></i>
                                                </button>
                                            </div>
                                        </div>
                                        
                                        <div class="thumbnails-container">
                                            <button class="gallery-nav-btn prev-btn absolute left-0 top-1/2 transform -translate-y-1/2 bg-white bg-opacity-70 hover:bg-opacity-100 p-2 rounded-full shadow-md z-10">
                                                <i class="fas fa-chevron-left"></i>
                                            </button>
                                            
                                            <div class="thumbnails-scroll relative">
                                                <div class="flex gap-3 py-4 overflow-x-auto thumbnails-track">
                                        <c:forEach var="image" items="${productImages}" varStatus="status">
                                                        <div class="thumbnail-wrapper min-w-[72px] sm:min-w-[80px]">
                                            <img src="${image.imageUrl}"
                                                alt="${product.productName} - Image ${status.index + 1}"
                                                                class="w-full aspect-square object-cover rounded-md cursor-pointer opacity-60 hover:opacity-100 transition duration-300 thumbnail-img"
                                                                data-index="${status.index}"
                                                                onclick="changeImage(this.src, this)">
                                                        </div>
                                        </c:forEach>

                                        <c:if test="${empty productImages}">
                                            <!-- Fallback images if no product images are available -->
                                                        <div class="thumbnail-wrapper min-w-[72px] sm:min-w-[80px]">
                                            <img src="${product.imageUrl}" alt="${product.productName}"
                                                                class="w-full aspect-square object-cover rounded-md cursor-pointer opacity-100 transition duration-300 thumbnail-img active"
                                                                data-index="0"
                                                                onclick="changeImage(this.src, this)">
                                                        </div>
                                        </c:if>
                                                </div>
                                            </div>

                                            <button class="gallery-nav-btn next-btn absolute right-0 top-1/2 transform -translate-y-1/2 bg-white bg-opacity-70 hover:bg-opacity-100 p-2 rounded-full shadow-md z-10">
                                                <i class="fas fa-chevron-right"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Product Details -->
                                <div class="w-full md:w-1/2 px-4">
                                    <h2 id="productName" class="text-3xl font-bold mb-2">${product.productName}</h2>
                                    <p class="text-gray-600 mb-4">SKU: WH1000XM4</p>
                                    <p class="text-gray-600 mb-4">TÌNH TRẠNG: <span id="stockStatus"
                                            class="text-green-600">Còn hàng</span> <span id="stockQuantity"
                                            class="text-blue-600 font-medium"></span></p>

                                    <div class="mb-4">
                                        <span id="productPrice" class="text-2xl font-bold mr-2">${product.price}</span>
                                        <span class="text-gray-500 line-through">$399.99</span>
                                    </div>
                                    <div class="flex items-center mb-4">
                                        <div class="flex items-center gap-0.5">
                                            <c:forEach begin="1" end="5" var="star">
                                                <c:choose>
                                                    <c:when test="${star <= averageRating}">
                                                        <svg class="h-4 w-4 text-yellow-300" aria-hidden="true"
                                                            xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                            fill="currentColor" viewBox="0 0 24 24">
                                                            <path
                                                                d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                                        </svg>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <svg class="h-4 w-4 text-gray-300" aria-hidden="true"
                                                            xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                            fill="currentColor" viewBox="0 0 24 24">
                                                            <path
                                                                d="M13.849 4.22c-.684-1.626-3.014-1.626-3.698 0L8.397 8.387l-4.552.361c-1.775.14-2.495 2.331-1.142 3.477l3.468 2.937-1.06 4.392c-.413 1.713 1.472 3.067 2.992 2.149L12 19.35l3.897 2.354c1.52.918 3.405-.436 2.992-2.15l-1.06-4.39 3.468-2.938c1.353-1.146.633-3.336-1.142-3.477l-4.552-.36-1.754-4.17Z" />
                                                        </svg>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </div>
                                        <span id="productRating" class="ml-2 text-gray-600">${averageRating}| ${product.quantitySold} sold</span>
                                    </div>

                                   

                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">MÀU SẮC: <span id="selectedColor2"
                                                style="display:none;"></span></h3>
                                        <div class="flex space-x-2">
                                            <c:forEach var="color" items="${colors}">
                                                <div class="color-option2 w-8 h-8 rounded-full cursor-pointer"
                                                    data-bg-color="${color.colorHex}" data-color-id="${color.colorId}"
                                                    onclick="selectColor2(this, '${color.colorName}')"></div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Size Selection -->
                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">SIZE: <span id="selectedSize2"
                                                style="display:none;"></span></h3>
                                        <div class="grid grid-cols-5 gap-2">
                                            <c:forEach var="size" items="${sizes}">
                                                <div class="size-option2 text-center py-2 border border-gray-200 cursor-pointer text-sm"
                                                    data-size-id="${size.sizeId}"
                                                    onclick="selectSize2(this, '${size.sizeName}')">
                                                    ${size.sizeName}
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>

                                    <!-- Quantity -->
                                    <div class="mb-6">
                                        <h3 class="text-lg font-semibold mb-2">SỐ LƯỢNG:</h3>
                                        <div
                                            class="quantity-selector flex items-center border border-gray-200 w-24 shadow-sm">
                                            <button type="button"
                                                class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                onclick="adjustQuantity2(-1)">-</button>
                                            <span id="quantityDisplay2"
                                                class="flex-1 text-center quantity-value py-1">1</span>
                                            <button type="button"
                                                class="px-2 py-1 text-gray-500 hover:bg-gray-100 transition-colors"
                                                onclick="adjustQuantity2(1)">+</button>
                                        </div>
                                    </div>

                                    <div class="flex space-x-4 mb-6">
                                        <!-- Nút ADD TO CART -->
                                        <form action="/product-variant/add-to-cart" method="post" id="addToCartForm2"
                                            class="flex-1">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="variantId" id="cartVariantId2" value="" />
                                            <input type="hidden" name="quantity" id="cartQuantityInput2" value="1" />
                                            <button type="submit"
                                                class="w-full bg-black text-white py-3 font-medium hover:bg-gray-800 rounded-md">
                                                <i class="fas fa-shopping-cart mr-2"></i> THÊM VÀO GIỎ HÀNG
                                            </button>
                                        </form>

                                        <!-- Nút BUY NOW -->
                                        <form action="${ctx}/order/orderfix" method="get" id="buyNowForm2" class="flex-1">
                                            <input type="hidden" name="variantId" id="selectedVariantId2" />
                                            <input type="hidden" name="quantity" id="quantityInput2" value="1" />
                                            <button type="submit" id="buyNowButton2" disabled
                                                class="w-full bg-red-600 text-white py-3 font-medium hover:bg-red-700 disabled:bg-gray-400 disabled:cursor-not-allowed rounded-md">
                                                <i class="fas fa-credit-card mr-2"></i> MUA NGAY
                                            </button>
                                        </form>
                                    </div>

                                    <div class="flex items-center gap-4 mb-8">
                                        <button id="addToFavoritesBtn" class="flex items-center text-sm text-gray-700 hover:text-black">
                                            <i class="far fa-heart mr-2"></i> THÊM VÀO YÊU THÍCH
                                        </button>
                                        <div class="flex items-center gap-3">
                                            <span class="text-sm text-gray-700">Chia sẻ:</span>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-facebook-f"></i></a>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-twitter"></i></a>
                                            <a href="#" class="text-gray-500 hover:text-black"><i
                                                    class="fab fa-pinterest-p"></i></a>
                                        </div>
                                    </div>
                                     <!-- Collapsible Description Section -->
                                     <div class="product-description-container mb-6 border border-gray-200 rounded-lg overflow-hidden">
                                        <button id="descriptionToggle" class="description-toggle w-full flex items-center justify-between bg-gray-50 px-4 py-3 hover:bg-gray-100 transition-all duration-300">
                                            <span class="font-semibold text-gray-800">MÔ TẢ SẢN PHẨM</span>
                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 transform transition-transform duration-300 description-arrow" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                                            </svg>
                                        </button>
                                        <div id="descriptionContent" class="description-content px-4 overflow-hidden max-h-0 transition-all duration-500 ease-in-out">
                                            <div class="py-4 description-inner">
                                                <p id="productDescription" class="text-gray-700 whitespace-pre-line">${product.description}</p>
                                                
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <jsp:include page="../layout/review.jsp" />


                        <script>
                            function changeImage(src, thumbnailElement) {
                                // Update main image
                                const mainImage = document.getElementById('mainImage');
                                mainImage.src = src;
                                
                                // Update active thumbnail
                                document.querySelectorAll('.thumbnail-img').forEach(img => {
                                    img.classList.remove('active', 'opacity-100');
                                    img.classList.add('opacity-60');
                                });
                                
                                if (thumbnailElement) {
                                    thumbnailElement.classList.add('active', 'opacity-100');
                                    thumbnailElement.classList.remove('opacity-60');
                                }
                                
                                // Reset zoom
                                if (window.isZoomActive) {
                                    toggleZoom();
                                }
                            }

                            // 3D View button click handler
                            document.addEventListener('DOMContentLoaded', function () {
                                // Initialize variables
                                window.isZoomActive = false;
                                window.isFullscreen = false;
                                
                                // 3D Button
                                document.getElementById('view3dButton').addEventListener('click', function () {
                                    const productId = document.querySelector('.image-zoom-container').getAttribute('data-product-id');
                                    window.location.href = "/product/image3d?id=" + productId;
                                });
                                
                                // Initialize gallery navigation
                                initGalleryNavigation();
                                
                                // Initialize zoom functionality
                                initZoomFeature();
                                
                                // Initialize fullscreen feature
                                initFullscreenFeature();
                                
                                // Set first thumbnail as active by default
                                const firstThumbnail = document.querySelector('.thumbnail-img');
                                if (firstThumbnail) {
                                    firstThumbnail.classList.add('active', 'opacity-100');
                                    firstThumbnail.classList.remove('opacity-60');
                                }
                                
                                // Initialize collapsible description
                                initCollapsibleDescription();
                            });
                            
                            function initCollapsibleDescription() {
                                const toggle = document.getElementById('descriptionToggle');
                                const content = document.getElementById('descriptionContent');
                                const arrow = document.querySelector('.description-arrow');
                                const inner = document.querySelector('.description-inner');
                                
                                if (!toggle || !content || !arrow || !inner) return;
                                
                                toggle.addEventListener('click', () => {
                                    // Toggle arrow rotation
                                    arrow.classList.toggle('active');
                                    
                                    // Toggle content visibility
                                    if (content.classList.contains('active')) {
                                        // Close the content
                                        content.style.maxHeight = '0px';
                                        content.classList.remove('active');
                                        inner.classList.remove('active');
                                        
                                        // Add slight delay before removing active class from inner content
                                        setTimeout(() => {
                                            inner.classList.remove('active');
                                        }, 100);
                                    } else {
                                        // Open the content
                                        content.classList.add('active');
                                        content.style.maxHeight = inner.offsetHeight + 'px';
                                        
                                        // Add slight delay before adding active class to inner content
                                        setTimeout(() => {
                                            inner.classList.add('active');
                                        }, 100);
                                    }
                                });
                            }
                            
                            function initGalleryNavigation() {
                                const track = document.querySelector('.thumbnails-track');
                                const prevBtn = document.querySelector('.prev-btn');
                                const nextBtn = document.querySelector('.next-btn');
                                
                                if (!track || !prevBtn || !nextBtn) return;
                                
                                // Show/hide navigation buttons based on scroll position
                                function updateNavButtons() {
                                    prevBtn.style.display = track.scrollLeft > 0 ? 'flex' : 'none';
                                    nextBtn.style.display = 
                                        track.scrollLeft < (track.scrollWidth - track.clientWidth - 10) ? 'flex' : 'none';
                                }
                                
                                // Initial button state
                                updateNavButtons();
                                
                                // Scroll event
                                track.addEventListener('scroll', updateNavButtons);
                                
                                // Button click handlers
                                prevBtn.addEventListener('click', () => {
                                    track.scrollBy({ left: -200, behavior: 'smooth' });
                                });
                                
                                nextBtn.addEventListener('click', () => {
                                    track.scrollBy({ left: 200, behavior: 'smooth' });
                                });
                                
                                // Keyboard navigation
                                document.addEventListener('keydown', (e) => {
                                    if (e.key === 'ArrowLeft') {
                                        navigateImages('prev');
                                    } else if (e.key === 'ArrowRight') {
                                        navigateImages('next');
                                    }
                                });
                            }
                            
                            function navigateImages(direction) {
                                const thumbnails = Array.from(document.querySelectorAll('.thumbnail-img'));
                                const activeIndex = thumbnails.findIndex(img => img.classList.contains('active'));
                                
                                if (activeIndex === -1) return;
                                
                                let newIndex;
                                if (direction === 'next') {
                                    newIndex = (activeIndex + 1) % thumbnails.length;
                                } else {
                                    newIndex = (activeIndex - 1 + thumbnails.length) % thumbnails.length;
                                }
                                
                                const nextThumb = thumbnails[newIndex];
                                changeImage(nextThumb.src, nextThumb);
                                
                                // Ensure the thumbnail is visible
                                nextThumb.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });
                            }
                            
                            function initZoomFeature() {
                                const mainImage = document.getElementById('mainImage');
                                const zoomContainer = document.querySelector('.image-zoom-container');
                                const zoomLens = document.querySelector('.zoom-lens');
                                const zoomToggle = document.getElementById('zoomToggle');
                                
                                if (!mainImage || !zoomContainer || !zoomLens || !zoomToggle) return;
                                
                                // Toggle zoom on button click
                                zoomToggle.addEventListener('click', toggleZoom);
                                
                                // Mouse events for zoom
                                zoomContainer.addEventListener('mousemove', handleZoomMouseMove);
                                zoomContainer.addEventListener('mouseleave', () => {
                                    if (window.isZoomActive) {
                                        zoomLens.style.display = 'none';
                                        const zoomResult = document.querySelector('.zoom-result');
                                        if (zoomResult) zoomResult.style.display = 'none';
                                    }
                                });
                                zoomContainer.addEventListener('mouseenter', () => {
                                    if (window.isZoomActive) {
                                        zoomLens.style.display = 'block';
                                        const zoomResult = document.querySelector('.zoom-result');
                                        if (zoomResult) zoomResult.style.display = 'block';
                                    }
                                });
                            }
                            
                            function toggleZoom() {
                                const zoomContainer = document.querySelector('.image-zoom-container');
                                const zoomLens = document.querySelector('.zoom-lens');
                                const zoomToggle = document.getElementById('zoomToggle');
                                const mainImage = document.getElementById('mainImage');
                                
                                window.isZoomActive = !window.isZoomActive;
                                
                                if (window.isZoomActive) {
                                    zoomContainer.classList.add('zoom-active');
                                    zoomLens.style.display = 'block';
                                    zoomToggle.innerHTML = '<i class="fas fa-search-minus"></i>';
                                    
                                    // Create zoom result window
                                    let zoomResult = document.querySelector('.zoom-result');
                                    if (!zoomResult) {
                                        zoomResult = document.createElement('div');
                                        zoomResult.className = 'zoom-result';
                                        zoomContainer.appendChild(zoomResult);
                                    }
                                    
                                    zoomResult.style.backgroundImage = `url(${mainImage.src})`;
                                    
                                    // Preload high-res image for better zoom quality
                                    const hiResImg = new Image();
                                    hiResImg.src = mainImage.src;
                                    hiResImg.onload = function() {
                                        const zoomResult = document.querySelector('.zoom-result');
                                        if (zoomResult) {
                                            zoomResult.style.backgroundImage = `url(${hiResImg.src})`;
                                        }
                                    };
                                } else {
                                    zoomContainer.classList.remove('zoom-active');
                                    zoomLens.style.display = 'none';
                                    zoomToggle.innerHTML = '<i class="fas fa-search-plus"></i>';
                                    
                                    // Remove zoom result window
                                    const zoomResult = document.querySelector('.zoom-result');
                                    if (zoomResult) {
                                        zoomResult.remove();
                                    }
                                }
                            }
                            
                            function handleZoomMouseMove(e) {
                                if (!window.isZoomActive) return;
                                
                                const zoomContainer = document.querySelector('.image-zoom-container');
                                const zoomLens = document.querySelector('.zoom-lens');
                                const zoomResult = document.querySelector('.zoom-result');
                                const mainImage = document.getElementById('mainImage');
                                
                                if (!zoomLens || !zoomResult || !mainImage) return;
                                
                                // Get relative cursor position
                                const rect = zoomContainer.getBoundingClientRect();
                                const x = e.clientX - rect.left;
                                const y = e.clientY - rect.top;
                                
                                // Calculate lens position
                                const lensWidth = zoomLens.offsetWidth;
                                const lensHeight = zoomLens.offsetHeight;
                                let lensX = x - lensWidth / 2;
                                let lensY = y - lensHeight / 2;
                                
                                // Constrain lens to image bounds
                                lensX = Math.max(0, Math.min(zoomContainer.offsetWidth - lensWidth, lensX));
                                lensY = Math.max(0, Math.min(zoomContainer.offsetHeight - lensHeight, lensY));
                                
                                // Position lens
                                zoomLens.style.left = `${lensX}px`;
                                zoomLens.style.top = `${lensY}px`;
                                
                                // Calculate background position for zoom result
                                const ratioX = zoomResult.offsetWidth / lensWidth;
                                const ratioY = zoomResult.offsetHeight / lensHeight;
                                const bgX = lensX * ratioX;
                                const bgY = lensY * ratioY;
                                
                                zoomResult.style.backgroundPosition = `-${bgX}px -${bgY}px`;
                                zoomResult.style.backgroundSize = `${mainImage.offsetWidth * ratioX}px ${mainImage.offsetHeight * ratioY}px`;
                            }
                            
                            function initFullscreenFeature() {
                                const fullscreenToggle = document.getElementById('fullscreenToggle');
                                if (!fullscreenToggle) return;
                                
                                fullscreenToggle.addEventListener('click', toggleFullscreen);
                            }
                            
                            function toggleFullscreen() {
                                const mainImage = document.getElementById('mainImage');
                                
                                if (!window.isFullscreen) {
                                    // Create fullscreen overlay
                                    const overlay = document.createElement('div');
                                    overlay.className = 'fullscreen-overlay';
                                    
                                    const closeBtn = document.createElement('button');
                                    closeBtn.className = 'fullscreen-close';
                                    closeBtn.innerHTML = '<i class="fas fa-times"></i>';
                                    closeBtn.addEventListener('click', toggleFullscreen);
                                    
                                    const fsImage = document.createElement('img');
                                    fsImage.src = mainImage.src;
                                    fsImage.className = 'fullscreen-image';
                                    
                                    overlay.appendChild(closeBtn);
                                    overlay.appendChild(fsImage);
                                    document.body.appendChild(overlay);
                                    document.body.style.overflow = 'hidden';
                                    
                                    // Function to handle fullscreen navigation
                                    function fullscreenNavigate(direction) {
                                        navigateImages(direction);
                                        fsImage.src = document.getElementById('mainImage').src;
                                    }
                                    
                                    // Add navigation buttons
                                    const prevBtn = document.createElement('button');
                                    prevBtn.className = 'fullscreen-nav prev';
                                    prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i>';
                                    prevBtn.addEventListener('click', (e) => {
                                        e.stopPropagation();
                                        fullscreenNavigate('prev');
                                    });
                                    
                                    const nextBtn = document.createElement('button');
                                    nextBtn.className = 'fullscreen-nav next';
                                    nextBtn.innerHTML = '<i class="fas fa-chevron-right"></i>';
                                    nextBtn.addEventListener('click', (e) => {
                                        e.stopPropagation();
                                        fullscreenNavigate('next');
                                    });
                                    
                                    overlay.appendChild(prevBtn);
                                    overlay.appendChild(nextBtn);
                                    
                                    // Keyboard navigation in fullscreen
                                    const keyHandler = (e) => {
                                        if (e.key === 'Escape') {
                                            toggleFullscreen();
                                        } else if (e.key === 'ArrowLeft') {
                                            fullscreenNavigate('prev');
                                        } else if (e.key === 'ArrowRight') {
                                            fullscreenNavigate('next');
                                        }
                                    };
                                    
                                    document.addEventListener('keydown', keyHandler);
                                    window.fullscreenKeyHandler = keyHandler; // Store for removal
                                    
                                    window.isFullscreen = true;
                                } else {
                                    // Remove fullscreen overlay
                                    const overlay = document.querySelector('.fullscreen-overlay');
                                    if (overlay) {
                                        overlay.remove();
                                    }
                                    document.body.style.overflow = '';
                                    
                                    // Remove keyboard event listener
                                    if (window.fullscreenKeyHandler) {
                                        document.removeEventListener('keydown', window.fullscreenKeyHandler);
                                    }
                                    
                                    window.isFullscreen = false;
                                }
                            }

                            // Apply background colors to color options
                            document.addEventListener('DOMContentLoaded', function () {
                                // Add hidden field with product ID for 3D view
                                const productIdField = document.createElement('div');
                                productIdField.setAttribute('data-product-id', '${product.productId}');
                                productIdField.style.display = 'none';
                                document.body.appendChild(productIdField);
                                
                                document.querySelectorAll('.color-option2').forEach(function (el) {
                                    const bgColor = el.getAttribute('data-bg-color');
                                    if (bgColor) {
                                        el.style.backgroundColor = bgColor;
                                        el.style.border = '1px solid black';
                                    }
                                });
                            });

                            function selectColor2(el, name) {
                                document.querySelectorAll('.color-option2').forEach(e => e.classList.remove('selected'));
                                el.classList.add('selected');
                                const label = document.getElementById('selectedColor2');
                                if (label) label.innerText = name;
                                updateSelectedVariant2();
                            }

                            function selectSize2(el, name) {
                                document.querySelectorAll('.size-option2').forEach(e => e.classList.remove('selected'));
                                el.classList.add('selected');
                                const label = document.getElementById('selectedSize2');
                                if (label) label.innerText = name;
                                updateSelectedVariant2();
                            }

                            function adjustQuantity2(change) {
                                const display = document.getElementById('quantityDisplay2');
                                let val = parseInt(display.innerText);

                                // Lấy số lượng tồn kho của variant đã chọn
                                const selectedVariant = getSelectedVariant();
                                const maxStock = selectedVariant ? selectedVariant.quantityStock : 0;

                                // Giới hạn số lượng không vượt quá tồn kho
                                val = Math.max(1, Math.min(maxStock, val + change));
                                display.innerText = val;

                                // Update quantity for both forms
                                document.getElementById('quantityInput2').value = val;
                                document.getElementById('cartQuantityInput2').value = val;

                            }

                            // Hàm lấy variant đã chọn hiện tại
                            function getSelectedVariant() {
                                const selectedColorId = document.querySelector('.color-option2.selected')?.dataset.colorId;
                                const selectedSizeId = document.querySelector('.size-option2.selected')?.dataset.sizeId;

                                if (!selectedColorId || !selectedSizeId || !variants || variants.length === 0) {
                                    return null;
                                }

                                return variants.find(v =>
                                    v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                );
                            }

                            let variants = [];
                            try {
                                const rawJson = document.getElementById("variantsData").textContent.trim();
                                variants = JSON.parse(rawJson);


                                // Kiểm tra tình trạng hàng hóa khi trang được tải
                                checkInitialStockStatus();
                            } catch (e) {
                                console.error("Lỗi khi parse variantsJson:", e);
                            }

                            // Kiểm tra tình trạng hàng hóa khi trang được tải
                            function checkInitialStockStatus() {
                                const stockStatus = document.getElementById('stockStatus');
                                const stockQuantity = document.getElementById('stockQuantity');

                                // Kiểm tra xem có ít nhất một variant còn hàng không
                                const hasStock = variants.some(variant => variant.quantityStock > 0);
                                const totalStock = variants.reduce((sum, variant) => sum + (variant.quantityStock || 0), 0);

                                if (variants.length === 0) {
                                    stockStatus.textContent = "Không có sẵn";
                                    stockStatus.className = "text-gray-600";
                                    stockQuantity.textContent = "";
                                } else if (hasStock) {
                                    stockStatus.textContent = "Có sẵn";
                                    stockStatus.className = "text-green-600";
                                    stockQuantity.textContent = "(Tổng " + totalStock + " sản phẩm)";
                                    stockQuantity.className = "text-blue-600 font-medium ml-2";
                                } else {
                                    stockStatus.textContent = "Hết hàng";
                                    stockStatus.className = "text-red-600";
                                    stockQuantity.textContent = "(0 sản phẩm)";
                                    stockQuantity.className = "text-gray-600 ml-2";
                                }
                            }

                            function updateSelectedVariant2() {
                                if (!variants || variants.length === 0) {
                                    console.warn("Không có variants để xử lý.");
                                    return;
                                }

                                const selectedColorId = document.querySelector('.color-option2.selected')?.dataset.colorId;
                                const selectedSizeId = document.querySelector('.size-option2.selected')?.dataset.sizeId;
                                const buyNowButton = document.getElementById('buyNowButton2');
                                const addToCartButton = document.getElementById('addToCartForm2').querySelector('button[type="submit"]');
                                const stockStatus = document.getElementById('stockStatus');
                                const stockQuantity = document.getElementById('stockQuantity');
                                const quantityDisplay = document.getElementById('quantityDisplay2');

                                // Disable BUY NOW button by default
                                buyNowButton.disabled = true;

                                if (selectedColorId && selectedSizeId) {
                                    const found = variants.find(v =>
                                        v.color.colorId == selectedColorId && v.size.sizeId == selectedSizeId
                                    );
                                    if (found) {
                                        document.getElementById('selectedVariantId2').value = found.productVariantId;
                                        document.getElementById('cartVariantId2').value = found.productVariantId;


                                        // Kiểm tra số lượng tồn kho
                                        if (found.quantityStock && found.quantityStock > 0) {
                                            stockStatus.textContent = "Còn hàng";
                                            stockStatus.className = "text-green-600";
                                            // Hiển thị số lượng tồn kho
                                            stockQuantity.textContent = "(" + found.quantityStock + " sản phẩm)";
                                            stockQuantity.className = "text-blue-600 font-medium ml-2";

                                            // Reset quantity display to 1 or max available
                                            const currentQty = parseInt(quantityDisplay.textContent);
                                            if (currentQty > found.quantityStock) {
                                                quantityDisplay.textContent = "1";
                                                document.getElementById('quantityInput2').value = 1;
                                                document.getElementById('cartQuantityInput2').value = 1;
                                            }

                                            // Enable BUY NOW button if variant is found and in stock
                                            buyNowButton.disabled = false;
                                            addToCartButton.disabled = false;
                                            addToCartButton.classList.remove('bg-gray-400', 'cursor-not-allowed');
                                            addToCartButton.classList.add('bg-black', 'hover:bg-gray-800');
                                        } else {
                                            stockStatus.textContent = "Hết hàng";
                                            stockStatus.className = "text-red-600";
                                            stockQuantity.textContent = "(0 sản phẩm)";
                                            stockQuantity.className = "text-gray-600 ml-2";

                                            // Reset quantity display
                                            quantityDisplay.textContent = "1";
                                            document.getElementById('quantityInput2').value = 1;
                                            document.getElementById('cartQuantityInput2').value = 1;

                                            // Disable both buttons if out of stock
                                            buyNowButton.disabled = true;
                                            addToCartButton.disabled = true;
                                            addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                            addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                        }
                                    } else {
                                        stockStatus.textContent = "Không có sẵn";
                                        stockStatus.className = "text-gray-600";
                                        stockQuantity.textContent = "";
                                        buyNowButton.disabled = true;
                                        addToCartButton.disabled = true;
                                        addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                        addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                        alert("Tổ hợp size & màu này không có sẵn!");
                                    }
                                } else {
                                    stockStatus.textContent = "Vui lòng chọn màu sắc và kích thước";
                                    stockStatus.className = "text-gray-600";
                                    stockQuantity.textContent = "";
                                    buyNowButton.disabled = true;
                                    addToCartButton.disabled = true;
                                    addToCartButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                                    addToCartButton.classList.remove('bg-black', 'hover:bg-gray-800');
                                }

                            }

                            // Add event listeners when the document is fully loaded
                            document.addEventListener('DOMContentLoaded', function () {
                                // Buy Now form submission for second section
                                document.getElementById('buyNowForm2').addEventListener('submit', function (e) {
                                    // Ensure values are up to date
                                    updateSelectedVariant2();

                                    const variantInput = document.getElementById('selectedVariantId2');
                                    const quantityInput = document.getElementById('quantityInput2');
                                    const quantityValue = parseInt(document.getElementById('quantityDisplay2').textContent);

                                    // Update quantity one more time to be sure
                                    quantityInput.value = quantityValue;



                                    if (!variantInput.value) {
                                        e.preventDefault();
                                        alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                        return false;
                                    }

                                    // Extra validation to ensure quantity is valid
                                    if (isNaN(parseInt(quantityInput.value)) || parseInt(quantityInput.value) < 1) {
                                        e.preventDefault();
                                        alert('Số lượng không hợp lệ');
                                        return false;
                                    }

                                    return true;
                                });

                                // Add to Cart form submission for second section
                                document.getElementById('addToCartForm2').addEventListener('submit', function (e) {
                                    updateSelectedVariant2(); // Update variant ID when form is submitted

                                    const variantInput = document.getElementById('cartVariantId2');

                                    if (!variantInput.value) {
                                        e.preventDefault();
                                        alert('Vui lòng chọn đầy đủ màu sắc và kích thước!');
                                    }
                                });
                                
                                // Add to Favorites functionality
                                document.getElementById('addToFavoritesBtn').addEventListener('click', function() {
                                    addToFavorites();
                                });
                            });
                            
                            // Add to Favorites function
                            function addToFavorites() {
                                try {
                                    // Get product data from DOM elements using direct ID references
                                    const productData = {
                                        productId: document.getElementById('productContainer').getAttribute('data-product-id'),
                                        productName: document.getElementById('productName').textContent.trim(),
                                        price: document.getElementById('productPrice').textContent.trim(),
                                        description: document.getElementById('productDescription') ? 
                                            document.getElementById('productDescription').textContent.trim() : '',
                                        imageUrl: document.getElementById('mainImage').src,
                                        quantitySold: document.getElementById('productRating').textContent.split('|')[1].trim(),
                                        dateAdded: new Date().toISOString()
                                    };
                                    
                                    // Get selected variant data if available
                                    const selectedVariant = getSelectedVariant();
                                    if (selectedVariant) {
                                        productData.selectedVariant = {
                                            variantId: selectedVariant.productVariantId,
                                            colorId: selectedVariant.color.colorId,
                                            colorName: selectedVariant.color.colorName,
                                            sizeId: selectedVariant.size.sizeId,
                                            sizeName: selectedVariant.size.sizeName
                                        };
                                    }
                                    
                                    // Get all product images
                                    const productImages = [];
                                    document.querySelectorAll('.thumbnail-img').forEach(img => {
                                        productImages.push({
                                            imageUrl: img.src,
                                            isActive: img.classList.contains('active')
                                        });
                                    });
                                    productData.images = productImages;
                                    
                                    // Get favorites from localStorage or initialize empty array
                                    let favorites = JSON.parse(localStorage.getItem('favorites')) || [];
                                    
                                    // Check if product already exists in favorites
                                    const existingIndex = favorites.findIndex(item => item.productId === productData.productId);
                                    
                                    if (existingIndex >= 0) {
                                        // Update existing product
                                        favorites[existingIndex] = productData;
                                        showToast('Sản phẩm đã được cập nhật trong danh sách yêu thích!');
                                    } else {
                                        // Add new product
                                        favorites.push(productData);
                                        showToast('Sản phẩm đã được thêm vào danh sách yêu thích!');
                                    }
                                    
                                    // Save to localStorage
                                    localStorage.setItem('favorites', JSON.stringify(favorites));
                                    
                                    // Update heart icon
                                    const heartIcon = document.querySelector('#addToFavoritesBtn i');
                                    heartIcon.classList.remove('far');
                                    heartIcon.classList.add('fas');
                                    heartIcon.classList.add('text-red-500');
                                    
                                } catch (error) {
                                    console.error('Error adding to favorites:', error);
                                    showToast('Đã xảy ra lỗi khi thêm vào yêu thích!', true);
                                }
                            }
                            
                            // Check if product is in favorites on page load
                            document.addEventListener('DOMContentLoaded', function() {
                                try {
                                    const favorites = JSON.parse(localStorage.getItem('favorites')) || [];
                                    const productId = document.getElementById('productContainer').getAttribute('data-product-id');
                                    const isInFavorites = favorites.some(item => item.productId === productId);
                                    
                                    if (isInFavorites) {
                                        const heartIcon = document.querySelector('#addToFavoritesBtn i');
                                        heartIcon.classList.remove('far');
                                        heartIcon.classList.add('fas');
                                        heartIcon.classList.add('text-red-500');
                                    }
                                } catch (error) {
                                    console.error('Error checking favorites status:', error);
                                }
                            });
                            
                            // Toast notification function
                            function showToast(message, isError = false) {
                                // Create toast element if it doesn't exist
                                let toast = document.getElementById('toast-notification');
                                if (!toast) {
                                    toast = document.createElement('div');
                                    toast.id = 'toast-notification';
                                    toast.className = 'fixed top-4 right-4 px-4 py-2 rounded-lg shadow-lg z-50 transform transition-all duration-300 translate-y-[-100%] opacity-0';
                                    document.body.appendChild(toast);
                                }
                                
                                // Set toast style based on type
                                if (isError) {
                                    toast.className = 'fixed top-4 right-4 px-4 py-2 rounded-lg shadow-lg z-50 transform transition-all duration-300 translate-y-[-100%] opacity-0 bg-red-500 text-white';
                                } else {
                                    toast.className = 'fixed top-4 right-4 px-4 py-2 rounded-lg shadow-lg z-50 transform transition-all duration-300 translate-y-[-100%] opacity-0 bg-green-500 text-white';
                                }
                                
                                // Set message
                                toast.textContent = message;
                                
                                // Show toast
                                setTimeout(() => {
                                    toast.classList.remove('translate-y-[-100%]', 'opacity-0');
                                    toast.classList.add('translate-y-0', 'opacity-100');
                                }, 100);
                                
                                // Hide toast after 3 seconds
                                setTimeout(() => {
                                    toast.classList.remove('translate-y-0', 'opacity-100');
                                    toast.classList.add('translate-y-[-100%]', 'opacity-0');
                                }, 3000);
                            }
                        </script>
                    </div>

                    <style>
                        /* Product Gallery Styles */
                        .product-gallery {
                            position: relative;
                        }
                        
                        .main-image-container {
                            position: relative;
                            overflow: hidden;
                            border-radius: 0.5rem;
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                            height: 500px; /* Fixed height for consistency */
                        }
                        
                        .image-zoom-container {
                            position: relative;
                            width: 100%;
                            height: 100%;
                            overflow: hidden;
                        }
                        
                        #mainImage {
                            width: 100%;
                            height: 100%;
                            object-fit: contain;
                            transition: transform 0.5s ease;
                        }
                        
                        .zoom-lens {
                            position: absolute;
                            border: 2px solid #fff;
                            width: 100px;
                            height: 100px;
                            background: rgba(255, 255, 255, 0.2);
                            cursor: move;
                            display: none;
                            pointer-events: none;
                            box-shadow: 0 0 5px rgba(0,0,0,0.5);
                        }
                        
                        .zoom-result {
                            position: absolute;
                            top: 0;
                            left: 100%;
                            width: 300px;
                            height: 300px;
                            border: 2px solid #ddd;
                            background-repeat: no-repeat;
                            background-color: white;
                            box-shadow: 0 0 10px rgba(0,0,0,0.2);
                            z-index: 100;
                            margin-left: 15px;
                            display: block;
                            pointer-events: none;
                        }
                        
                        .thumbnails-container {
                            position: relative;
                            margin-top: 15px;
                        }
                        
                        .thumbnails-scroll {
                            position: relative;
                            padding: 0 30px;
                        }
                        
                        .thumbnails-track {
                            scroll-behavior: smooth;
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                            justify-content: center;
                        }
                        
                        .thumbnails-track::-webkit-scrollbar {
                            display: none;
                        }
                        
                        .thumbnail-wrapper {
                            position: relative;
                            border: 2px solid transparent;
                            border-radius: 6px;
                            overflow: hidden;
                            transition: all 0.3s ease;
                        }
                        
                        .thumbnail-img.active {
                            opacity: 1 !important;
                        }
                        
                        .thumbnail-wrapper:hover {
                            transform: translateY(-2px);
                        }
                        
                        .thumbnail-img.active + .thumbnail-wrapper {
                            border-color: #000;
                            box-shadow: 0 0 0 2px rgba(0,0,0,0.1);
                        }
                        
                        .gallery-nav-btn {
                            display: none;
                            align-items: center;
                            justify-content: center;
                            width: 30px;
                            height: 30px;
                            cursor: pointer;
                            transition: all 0.3s ease;
                        }
                        
                        .gallery-nav-btn:hover {
                            background-color: white;
                            transform: scale(1.1);
                        }
                        
                        /* Fullscreen styles */
                        .fullscreen-overlay {
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0,0,0,0.9);
                            z-index: 9999;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                        }
                        
                        .fullscreen-image {
                            max-width: 90%;
                            max-height: 90%;
                            object-fit: contain;
                        }
                        
                        .fullscreen-close {
                            position: absolute;
                            top: 20px;
                            right: 20px;
                            color: white;
                            background: rgba(0,0,0,0.5);
                            border: none;
                            width: 40px;
                            height: 40px;
                            border-radius: 50%;
                            font-size: 20px;
                            cursor: pointer;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            transition: all 0.3s ease;
                            z-index: 10000;
                        }
                        
                        .fullscreen-close:hover {
                            background: rgba(255,255,255,0.2);
                            transform: scale(1.1);
                        }
                        
                        .fullscreen-nav {
                            position: absolute;
                            top: 50%;
                            transform: translateY(-50%);
                            background: rgba(255,255,255,0.2);
                            color: white;
                            width: 50px;
                            height: 50px;
                            border-radius: 50%;
                            border: none;
                            font-size: 24px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            z-index: 10000;
                        }
                        
                        .fullscreen-nav:hover {
                            background: rgba(255,255,255,0.4);
                        }
                        
                        .fullscreen-nav.prev {
                            left: 20px;
                        }
                        
                        .fullscreen-nav.next {
                            right: 20px;
                        }
                        
                        /* Image hover effect */
                        .main-image-container:hover #mainImage:not(.zoom-active) {
                            transform: scale(1.03);
                        }
                        
                        /* Collapsible Description Styles */
                        .product-description-container {
                            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                            transition: all 0.3s ease;
                        }
                        
                        .product-description-container:hover {
                            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
                        }
                        
                        .description-toggle {
                            cursor: pointer;
                            user-select: none;
                        }
                        
                        .description-toggle:hover .description-arrow {
                            color: #000;
                        }
                        
                        .description-arrow {
                            color: #666;
                        }
                        
                        .description-arrow.active {
                            transform: rotate(180deg);
                        }
                        
                        .description-content {
                            transition: max-height 0.5s ease, padding 0.3s ease;
                        }
                        
                        .description-content.active {
                            max-height: 1000px; /* Large enough to contain content */
                        }
                        
                        .description-inner {
                            opacity: 0;
                            transform: translateY(10px);
                            transition: opacity 0.4s ease 0.1s, transform 0.4s ease 0.1s;
                        }
                        
                        .description-inner.active {
                            opacity: 1;
                            transform: translateY(0);
                        }
                        
                        /* Responsive adjustments */
                        @media (max-width: 768px) {
                            .main-image-container {
                                height: 350px;
                            }
                            
                            .zoom-result {
                                display: none !important; /* Disable zoom result on mobile */
                            }
                        }

                        /* Styles for color selection in the second product section */
                        .color-option2.selected {
                            border: 2px solid #000 !important;
                            box-shadow: 0 0 0 1px #fff, 0 0 0 3px #000;
                            transform: scale(1.1);
                        }

                        /* Styles for size selection in the second product section */
                        .size-option2.selected {
                            background-color: #000;
                            color: #fff;
                            border-color: #000;
                        }

                        /* Original styles for the first product section */
                        .color-option.selected {
                            border: 2px solid #000 !important;
                            box-shadow: 0 0 0 1px #fff, 0 0 0 3px #000;
                            transform: scale(1.1);
                        }

                        .size-option.selected {
                            background-color: #000;
                            color: #fff;
                            border-color: #000;
                        }
                    </style>

                    <!-- footer -->
                    <jsp:include page="../layout/footer.jsp" />

                    <div class="container mx-auto px-4 py-8 bg-white hidden">
                        <h2 class="text-2xl font-bold mb-4">Danh sách hình ảnh sản phẩm</h2>
                        <div class="overflow-x-auto">
                            <table class="min-w-full bg-white border border-gray-300">
                                <thead>
                                    <tr>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            ID</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            Hình ảnh</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            URL</th>
                                        <th
                                            class="px-6 py-3 bg-gray-100 text-left text-xs font-medium text-gray-700 uppercase tracking-wider border-b">
                                            Ưu tiên</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="image" items="${productImages}">
                                        <tr class="border-b hover:bg-gray-50">
                                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                                ${image.productImageId}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <img src="${image.imageUrl}" alt="Product Image"
                                                    class="h-16 w-16 object-cover rounded">
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                ${image.imageUrl}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                <c:choose>
                                                    <c:when test="${image.priority}">
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">Có</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span
                                                            class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">Không</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty productImages}">
                                        <tr class="border-b">
                                            <td colspan="4"
                                                class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-center">
                                                Không có hình ảnh nào</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </body>

                </html>