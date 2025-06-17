<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTS Fashion - Page Not Found</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#FF6B6B',
                        secondary: '#4ECDC4',
                        accent: '#45B7D1',
                        dark: '#2D3748',
                        light: '#F7FAFC'
                    },
                    animation: {
                        'float': 'float 6s ease-in-out infinite',
                        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
                        'bounce-slow': 'bounce 2s infinite',
                        'fade-in': 'fadeIn 1s ease-in-out',
                        'slide-up': 'slideUp 0.8s ease-out',
                        'shimmer': 'shimmer 2s linear infinite'
                    },
                    keyframes: {
                        float: {
                            '0%, 100%': { transform: 'translateY(0px)' },
                            '50%': { transform: 'translateY(-20px)' }
                        },
                        fadeIn: {
                            '0%': { opacity: '0' },
                            '100%': { opacity: '1' }
                        },
                        slideUp: {
                            '0%': { transform: 'translateY(50px)', opacity: '0' },
                            '100%': { transform: 'translateY(0)', opacity: '1' }
                        },
                        shimmer: {
                            '0%': { transform: 'translateX(-100%)' },
                            '100%': { transform: 'translateX(100%)' }
                        }
                    }
                }
            }
        }
    </script>
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .glass-effect {
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .text-gradient {
            background: linear-gradient(135deg, #FF6B6B, #4ECDC4);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .btn-gradient {
            background: linear-gradient(135deg, #FF6B6B, #45B7D1);
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            background: linear-gradient(135deg, #45B7D1, #FF6B6B);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }
        .shape {
            position: absolute;
            opacity: 0.1;
            animation: float 6s ease-in-out infinite;
        }
        .shape:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; }
        .shape:nth-child(2) { top: 20%; right: 10%; animation-delay: 1s; }
        .shape:nth-child(3) { bottom: 20%; left: 20%; animation-delay: 2s; }
        .shape:nth-child(4) { bottom: 10%; right: 20%; animation-delay: 3s; }
    </style>
</head>
<body class="min-h-screen gradient-bg relative overflow-hidden">
    <!-- Floating Background Shapes -->
    <div class="floating-shapes">
        <div class="shape w-32 h-32 bg-white rounded-full"></div>
        <div class="shape w-24 h-24 bg-primary rounded-lg transform rotate-45"></div>
        <div class="shape w-28 h-28 bg-secondary rounded-full"></div>
        <div class="shape w-20 h-20 bg-accent rounded-lg transform rotate-12"></div>
    </div>

    <!-- Main Container -->
    <div class="min-h-screen flex items-center justify-center px-4 relative z-10">
        <div class="max-w-4xl w-full">
            <!-- Error Card -->
            <div class="glass-effect rounded-3xl p-8 md:p-12 text-center animate-fade-in">
                <!-- Logo/Brand -->
                <div class="mb-8 animate-bounce-slow">
                    <div class="inline-flex items-center justify-center w-20 h-20 bg-white rounded-full shadow-lg mb-4">
                        <svg class="w-10 h-10 text-primary" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                        </svg>
                    </div>
                    <h1 class="text-3xl md:text-4xl font-bold text-white mb-2">DDTS</h1>
                    <p class="text-lg text-white/80">Fashion Shop</p>
                </div>

                <!-- Error Message -->
                <div class="mb-8 animate-slide-up">
                    <div class="text-8xl md:text-9xl font-black text-gradient mb-4 animate-pulse-slow">
                        404
                    </div>
                    <h2 class="text-3xl md:text-4xl font-bold text-white mb-4">
                        Trang không tồn tại
                    </h2>
                    <p class="text-lg text-white/80 mb-6 max-w-2xl mx-auto leading-relaxed">
                        Xin lỗi, trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển. 
                        Có thể URL bị lỗi hoặc trang không cho phép truy cập.
                    </p>
                </div>

                <!-- Error Types -->
                <div class="grid md:grid-cols-3 gap-4 mb-8 animate-slide-up">
                    <div class="glass-effect rounded-xl p-6 text-center hover:bg-white/20 transition-all duration-300">
                        <div class="w-12 h-12 bg-red-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"/>
                            </svg>
                        </div>
                        <h3 class="text-white font-semibold mb-2">URL Lỗi</h3>
                        <p class="text-white/70 text-sm">Địa chỉ trang web không đúng định dạng</p>
                    </div>
                    
                    <div class="glass-effect rounded-xl p-6 text-center hover:bg-white/20 transition-all duration-300">
                        <div class="w-12 h-12 bg-orange-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728L5.636 5.636m12.728 12.728L5.636 5.636"/>
                            </svg>
                        </div>
                        <h3 class="text-white font-semibold mb-2">Trang Bị Xóa</h3>
                        <p class="text-white/70 text-sm">Nội dung đã bị di chuyển hoặc xóa</p>
                    </div>
                    
                    <div class="glass-effect rounded-xl p-6 text-center hover:bg-white/20 transition-all duration-300">
                        <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-3">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                            </svg>
                        </div>
                        <h3 class="text-white font-semibold mb-2">Không Có Quyền</h3>
                        <p class="text-white/70 text-sm">Trang yêu cầu đăng nhập hoặc phân quyền</p>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center items-center animate-slide-up">
                    <button onclick="goHome()" class="btn-gradient text-white font-semibold py-4 px-8 rounded-full text-lg shadow-lg hover:shadow-xl transition-all duration-300 flex items-center gap-2">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                        Về Trang Chủ
                    </button>
                    
                    <button onclick="goBack()" class="glass-effect text-white font-semibold py-4 px-8 rounded-full text-lg hover:bg-white/20 transition-all duration-300 flex items-center gap-2">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                        </svg>
                        Quay Lại
                    </button>
                </div>

                <!-- Search Box -->
                <div class="mt-8 max-w-md mx-auto animate-slide-up">
                    <div class="relative">
                        <input type="text" id="searchInput" placeholder="Tìm kiếm sản phẩm..." 
                               class="w-full py-4 px-6 pr-12 rounded-full bg-white/20 backdrop-blur-sm border border-white/30 text-white placeholder-white/70 focus:outline-none focus:ring-2 focus:ring-white/50 transition-all duration-300">
                        <button onclick="performSearch()" class="absolute right-2 top-1/2 transform -translate-y-1/2 bg-white/20 hover:bg-white/30 rounded-full p-2 transition-all duration-300">
                            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Popular Categories -->
                <div class="mt-8 animate-slide-up">
                    <p class="text-white/80 mb-4">Danh mục phổ biến:</p>
                    <div class="flex flex-wrap justify-center gap-2">
                        <span class="glass-effect px-4 py-2 rounded-full text-white/90 text-sm hover:bg-white/20 cursor-pointer transition-all duration-300" onclick="searchCategory('Áo thun')">Áo thun</span>
                        <span class="glass-effect px-4 py-2 rounded-full text-white/90 text-sm hover:bg-white/20 cursor-pointer transition-all duration-300" onclick="searchCategory('Quần jean')">Quần jean</span>
                        <span class="glass-effect px-4 py-2 rounded-full text-white/90 text-sm hover:bg-white/20 cursor-pointer transition-all duration-300" onclick="searchCategory('Váy đầm')">Váy đầm</span>
                        <span class="glass-effect px-4 py-2 rounded-full text-white/90 text-sm hover:bg-white/20 cursor-pointer transition-all duration-300" onclick="searchCategory('Phụ kiện')">Phụ kiện</span>
                        <span class="glass-effect px-4 py-2 rounded-full text-white/90 text-sm hover:bg-white/20 cursor-pointer transition-all duration-300" onclick="searchCategory('Giày dép')">Giày dép</span>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="text-center mt-8 text-white/60 animate-fade-in">
                <p>© 2025 DDTS Fashion Shop. All rights reserved.</p>
                <div class="flex justify-center gap-4 mt-4">
                    <a href="#" class="text-white/60 hover:text-white transition-all duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                        </svg>
                    </a>
                    <a href="#" class="text-white/60 hover:text-white transition-all duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M22.46 6c-.77.35-1.6.58-2.46.69.88-.53 1.56-1.37 1.88-2.38-.83.5-1.75.85-2.72 1.05C18.37 4.5 17.26 4 16 4c-2.35 0-4.27 1.92-4.27 4.29 0 .34.04.67.11.98C8.28 9.09 5.11 7.38 3 4.79c-.37.63-.58 1.37-.58 2.15 0 1.49.75 2.81 1.91 3.56-.71 0-1.37-.2-1.95-.5v.03c0 2.08 1.48 3.82 3.44 4.21a4.22 4.22 0 0 1-1.93.07 4.28 4.28 0 0 0 4 2.98 8.521 8.521 0 0 1-5.33 1.84c-.34 0-.68-.02-1.02-.06C3.44 20.29 5.7 21 8.12 21 16 21 20.33 14.46 20.33 8.79c0-.19 0-.37-.01-.56.84-.6 1.56-1.36 2.14-2.23z"/>
                        </svg>
                    </a>
                    <a href="#" class="text-white/60 hover:text-white transition-all duration-300">
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.174-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.097.118.112.223.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.402.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.357-.629-2.751-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146C9.57 23.812 10.763 24.009 12.017 24.009c6.624 0 11.99-5.367 11.99-11.988C24.007 5.367 18.641.001 12.017.001z"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Function to go back - JSP compatible
        function goBack() {
            if (window.history.length > 1) {
                window.history.back();
            } else {
                window.location.href = '/';
            }
        }

        // Function to go home - JSP compatible
        function goHome() {
            window.location.href = '/';
        }

        // Search function - JSP compatible, no template literals
        function performSearch() {
            var searchInput = document.getElementById('searchInput');
            var query = searchInput.value.trim();
            if (query) {
                // Use traditional string concatenation instead of template literals
                window.location.href = '/search?q=' + encodeURIComponent(query);
            }
        }

        // Category search function - JSP compatible
        function searchCategory(categoryName) {
            // Use traditional string concatenation
            window.location.href = '/category/' + encodeURIComponent(categoryName);
        }

        // Enter key for search - JSP compatible
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });

        // Add interactive effects - JSP compatible
        document.addEventListener('DOMContentLoaded', function() {
            // Animate elements on load
            var elements = document.querySelectorAll('.animate-slide-up');
            for (var i = 0; i < elements.length; i++) {
                elements[i].style.animationDelay = (i * 0.1) + 's';
            }

            // Add cursor glow effect - JSP compatible
            document.addEventListener('mousemove', function(e) {
                var cursor = document.querySelector('.cursor-glow');
                if (!cursor) {
                    var glowCursor = document.createElement('div');
                    glowCursor.className = 'cursor-glow fixed pointer-events-none z-50 w-8 h-8 bg-white/20 rounded-full blur-sm';
                    document.body.appendChild(glowCursor);
                }
                var glow = document.querySelector('.cursor-glow');
                if (glow) {
                    glow.style.left = (e.clientX - 16) + 'px';
                    glow.style.top = (e.clientY - 16) + 'px';
                }
            });
        });

        // Additional utility functions for JSP compatibility
        function redirectToPage(url) {
            window.location.href = url;
        }

        function showAlert(message) {
            alert(message);
        }

        // Contact function
        function contactSupport() {
            showAlert('Vui lòng liên hệ: support@ddtsfashion.com hoặc hotline: 1900-1234');
        }
    </script>
</body>
</html>