<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>DDTS | Sản phẩm yêu thích</title>
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <script src="https://cdn.tailwindcss.com"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link
                    href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link href="${ctx}/resources/assets/client/css/profile.css" rel="stylesheet">
                <style>
                    .favorite-product {
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                    }
                    
                    .favorite-product:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                    }
                    
                    .product-image {
                        height: 200px;
                        object-fit: contain;
                    }
                    
                    .empty-favorites {
                        text-align: center;
                        padding: 40px 20px;
                    }
                    
                    .remove-favorite {
                        position: absolute;
                        top: 10px;
                        right: 10px;
                        background-color: rgba(255, 255, 255, 0.8);
                        border-radius: 50%;
                        width: 30px;
                        height: 30px;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: all 0.2s ease;
                    }
                    
                    .remove-favorite:hover {
                        background-color: rgba(255, 0, 0, 0.1);
                    }
                </style>
            </head>

            <body class="bg-white">
                <!-- navbar -->
                <jsp:include page="../layout/navbar.jsp" />
                
                <div class="container mx-auto px-4 py-8">
                    <h1 class="text-3xl font-bold mb-6 text-center">Sản phẩm yêu thích</h1>
                    
                    <div id="favoritesContainer" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                        <!-- Favorites will be loaded here dynamically -->
                            </div>
                    
                    <div id="emptyFavorites" class="empty-favorites hidden">
                        <div class="text-center py-10">
                            <i class="far fa-heart text-6xl text-gray-300 mb-4"></i>
                            <h2 class="text-2xl font-semibold text-gray-700 mb-2">Chưa có sản phẩm yêu thích</h2>
                            <p class="text-gray-500 mb-6">Hãy thêm các sản phẩm bạn yêu thích để xem ở đây</p>
                            <a href="${ctx}/product" class="bg-black text-white px-6 py-3 rounded-md hover:bg-gray-800 transition-colors">
                                Khám phá sản phẩm
                            </a>
                            </div>
                            </div>
                            </div>

                <!-- footer -->
                <jsp:include page="../layout/footer.jsp" />

                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        loadFavorites();
                    });
                    
                    function loadFavorites() {
                        const favoritesContainer = document.getElementById('favoritesContainer');
                        const emptyFavoritesElement = document.getElementById('emptyFavorites');
                        
                        // Get favorites from localStorage
                        let favorites = [];
                        try {
                            const favoritesJson = localStorage.getItem('favorites');
                            if (favoritesJson) {
                                favorites = JSON.parse(favoritesJson);
                            }
                        } catch (error) {
                            console.error('Error loading favorites:', error);
                        }
                        
                        // Clear the container
                        favoritesContainer.innerHTML = '';
                        
                        // Show empty message if no favorites
                        if (!favorites || favorites.length === 0) {
                            emptyFavoritesElement.classList.remove('hidden');
                            return;
                        } else {
                            emptyFavoritesElement.classList.add('hidden');
                        }
                        
                        // Sort favorites by date added (newest first)
                        favorites.sort((a, b) => new Date(b.dateAdded) - new Date(a.dateAdded));
                        
                        // Generate HTML for each favorite product
                        favorites.forEach(product => {
                            // Get the main image (active or first one)
                            let mainImage = product.imageUrl;
                            if (product.images && product.images.length > 0) {
                                const activeImage = product.images.find(img => img.isActive);
                                if (activeImage) {
                                    mainImage = activeImage.imageUrl;
                                } else {
                                    mainImage = product.images[0].imageUrl;
                                }
                            }
                            
                            // Format price with comma separators
                            const formattedPrice = formatPrice(product.price);
                            
                            // Create product card
                            const productCard = document.createElement('div');
                            productCard.className = 'favorite-product bg-white rounded-lg overflow-hidden shadow-md relative';
                            productCard.setAttribute('data-product-id', product.productId);
                            
                            productCard.innerHTML = `
                                <div class="relative">
                                    <img src="` + mainImage + `" alt="` + product.productName + `" class="w-full product-image">
                                    <button class="remove-favorite" onclick="removeFavorite('` + product.productId + `')">
                                        <i class="fas fa-times text-red-500"></i>
                                    </button>
                                </div>
                                <div class="p-4">
                                    <h3 class="text-lg font-semibold mb-2 line-clamp-2 h-14">` + product.productName + `</h3>
                                    <div class="flex items-center mb-2">
                                        
                                        <span class="ml-2 text-gray-600 text-sm">` + product.quantitySold + `</span>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-xl font-bold">` + formattedPrice + `₫</span>
                                        <a href="/product/detail?id=` + product.productId + `" class="text-blue-600 hover:underline text-sm">Xem chi tiết</a>
                                    </div>
                                    <div class="mt-4">
                                        <button onclick="window.location.href='/product/detail?id=` + product.productId + `'" class="w-full bg-black text-white py-2 rounded-md hover:bg-gray-800 transition-colors">
                                            <i class="fas fa-shopping-cart mr-2"></i> Mua ngay
                                        </button>
                                    </div>
                                </div>
                            `;
                            
                            favoritesContainer.appendChild(productCard);
                        });
                    }
                    
                    function removeFavorite(productId) {
                        try {
                            // Get current favorites
                            let favorites = JSON.parse(localStorage.getItem('favorites')) || [];
                            
                            // Remove the product with matching ID
                            favorites = favorites.filter(item => item.productId !== productId);
                            
                            // Save back to localStorage
                            localStorage.setItem('favorites', JSON.stringify(favorites));
                            
                            // Show toast notification
                            showToast('Đã xóa sản phẩm khỏi danh sách yêu thích');
                            
                            // Reload the favorites display
                            loadFavorites();
                        } catch (error) {
                            console.error('Error removing favorite:', error);
                            showToast('Đã xảy ra lỗi khi xóa sản phẩm', true);
                        }
                    }
                    
                    function formatPrice(price) {
                        // Convert to number and format with commas
                        return parseFloat(price).toLocaleString('vi-VN');
                    }
                    
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
            </body>

            </html>