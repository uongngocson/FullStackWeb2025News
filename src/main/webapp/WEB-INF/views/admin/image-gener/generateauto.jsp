<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Giám Sát API</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        'sans': ['system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif'],
                        'mono': ['ui-monospace', 'SFMono-Regular', 'Monaco', 'Consolas', 'monospace']
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.6s ease-out',
                        'slide-up': 'slideUp 0.5s ease-out',
                        'pulse-dot': 'pulseDot 2s infinite',
                        'spin-slow': 'spin 3s linear infinite',
                    },
                    keyframes: {
                        fadeIn: {
                            '0%': { opacity: '0', transform: 'translateY(20px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        slideUp: {
                            '0%': { opacity: '0', transform: 'translateY(30px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        pulseDot: {
                            '0%, 100%': { opacity: '1', transform: 'scale(1)' },
                            '50%': { opacity: '0.7', transform: 'scale(1.05)' }
                        }
                    },
                    boxShadow: {
                        'elegant': '0 10px 40px rgba(0, 0, 0, 0.1)',
                        'card': '0 4px 20px rgba(0, 0, 0, 0.08)',
                        'card-hover': '0 8px 30px rgba(0, 0, 0, 0.12)',
                    }
                }
            }
        }
    </script>
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        
        .card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }
        
        .status-dot {
            position: relative;
            display: inline-block;
        }
        
        .status-dot::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 50%;
            animation: pulseDot 2s infinite;
        }
        
        .status-dot.online::after {
            background: rgba(34, 197, 94, 0.3);
        }
        
        .status-dot.processing::after {
            background: rgba(59, 130, 246, 0.3);
        }
        
        .status-dot.offline::after {
            background: rgba(107, 114, 128, 0.3);
        }
        
        .gradient-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
        }
        
        .progress-bar {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            height: 4px;
            border-radius: 2px;
            transition: width 0.3s ease;
        }
        
        .timeline-item {
            position: relative;
            padding-left: 2rem;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 0.5rem;
            top: 0.7rem;
            width: 2px;
            height: calc(100% + 1rem);
            background: #e5e7eb;
        }
        
        .timeline-item:last-child::before {
            display: none;
        }
        
        .timeline-dot {
            position: absolute;
            left: 0;
            top: 0.7rem;
            width: 1rem;
            height: 1rem;
            border-radius: 50%;
            border: 2px solid white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="min-h-screen font-sans">
    <div class="min-h-screen py-6 px-4">
        <div class="max-w-7xl mx-auto">
            <!-- Header -->
            <div class="text-center mb-8 animate-fade-in">
                <h1 class="text-4xl font-bold gradient-text mb-3">
                    Hệ Thống Giám Sát API
                </h1>
                <p class="text-lg text-gray-600 font-medium">
                    Theo dõi quá trình xử lý hình ảnh 3D theo thời gian thực
                </p>
            </div>

            <!-- Control Panel -->
            <div class="card rounded-2xl p-6 mb-8 shadow-card animate-slide-up">
                <h2 class="text-xl font-semibold text-gray-800 mb-4 flex items-center gap-2">
                    <i class="fas fa-cogs text-blue-500"></i>
                    Bảng Điều Khiển
                </h2>
                
                <!-- Variants needing 3D images section -->
                <div class="mb-6">
                    <h3 class="text-lg font-semibold text-gray-700 mb-3">Sản phẩm cần tạo hình ảnh 3D</h3>
                    <div class="bg-gray-50 rounded-lg p-4 border border-gray-200 mb-4">
                        <c:choose>
                            <c:when test="${empty variantsNeed3DImage}">
                                <div class="text-center text-gray-500 py-4">
                                    <i class="fas fa-check-circle text-3xl mb-2 opacity-50"></i>
                                    <div>Tất cả sản phẩm đã có hình ảnh 3D</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="overflow-x-auto">
                                    <table class="min-w-full divide-y divide-gray-200">
                                        <thead>
                                            <tr>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">SKU</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Hình ảnh</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">URL Hình ảnh</th>
                                                <th class="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody class="bg-white divide-y divide-gray-200" id="variantsList">
                                            <c:forEach items="${variantsNeed3DImage}" var="variant" varStatus="status">
                                                <tr class="hover:bg-gray-50">
                                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-900">${variant.productVariantId}</td>
                                                    <td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500">${variant.SKU}</td>
                                                    <td class="px-4 py-2 whitespace-nowrap">
                                                        <div class="h-16 w-16 rounded-md overflow-hidden bg-gray-100 border">
                                                            <c:if test="${not empty variant.imageUrl}">
                                                                <img src="${variant.imageUrl}" alt="Product" class="h-full w-full object-cover">
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td class="px-4 py-2 text-sm text-gray-500 max-w-xs truncate">
                                                        <span class="variant-image-url">${variant.imageUrl}</span>
                                                    </td>
                                                    <td class="px-4 py-2 whitespace-nowrap">
                                                        <button class="process-variant-btn px-3 py-1 bg-blue-500 text-white text-sm rounded hover:bg-blue-600 transition" 
                                                                data-variant-id="${variant.productVariantId}" 
                                                                data-image-url="${variant.imageUrl}"
                                                                data-has-3d-image="${not empty variant.image_url3d}">
                                                            Xử lý
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="mt-3 text-sm text-gray-600">
                                    Tìm thấy <span class="font-semibold">${variantsNeed3DImage.size()}</span> sản phẩm cần tạo hình ảnh 3D
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="flex flex-col lg:flex-row gap-4 items-end">
                    <div class="flex-1">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            URL Hình Ảnh Đầu Vào (variant.imageUrl)
                        </label>
                        <input type="text" id="imageUrlInput" 
                               placeholder="Nhập đường dẫn hình ảnh cần xử lý..."
                               class="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all duration-300 text-gray-700 font-sans">
                    </div>
                    <div class="flex gap-3">
                        <button onclick="startProcessing()" id="startBtn"
                                class="btn-primary px-6 py-3 text-white font-semibold rounded-xl flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
                            <i class="fas fa-play"></i>
                            Bắt Đầu
                        </button>
                        <button onclick="stopProcessing()" id="stopBtn" disabled
                                class="btn-danger px-6 py-3 text-white font-semibold rounded-xl flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed">
                            <i class="fas fa-stop"></i>
                            Dừng Lại
                        </button>
                    </div>
                </div>
            </div>

            <!-- Status Overview -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <!-- Current Status -->
                <div class="card rounded-xl p-6 shadow-card animate-slide-up">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase tracking-wide">Trạng Thái</h3>
                        <div id="statusIndicator" class="status-dot offline w-3 h-3 bg-gray-400 rounded-full"></div>
                    </div>
                    <div id="statusText" class="text-2xl font-bold text-gray-800 mb-1">Sẵn Sàng</div>
                    <div id="statusDescription" class="text-sm text-gray-500">Chờ bắt đầu xử lý</div>
                </div>

                <!-- Request Count -->
                <div class="card rounded-xl p-6 shadow-card animate-slide-up">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase tracking-wide">Số Yêu Cầu</h3>
                        <i class="fas fa-paper-plane text-blue-500 text-lg"></i>
                    </div>
                    <div id="requestCounter" class="text-2xl font-bold text-blue-600 mb-1">0</div>
                    <div class="text-sm text-gray-500">Tổng số lần gửi API</div>
                </div>

                <!-- Success Rate -->
                <div class="card rounded-xl p-6 shadow-card animate-slide-up">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase tracking-wide">Tỷ Lệ Thành Công</h3>
                        <i class="fas fa-chart-line text-green-500 text-lg"></i>
                    </div>
                    <div id="successRate" class="text-2xl font-bold text-green-600 mb-1">--%</div>
                    <div class="text-sm text-gray-500">
                        <span id="successCount">0</span>/<span id="totalCount">0</span> hoàn thành
                    </div>
                </div>

                <!-- Processing Time -->
                <div class="card rounded-xl p-6 shadow-card animate-slide-up">
                    <div class="flex items-center justify-between mb-3">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase tracking-wide">Thời Gian Xử Lý</h3>
                        <i class="fas fa-clock text-purple-500 text-lg"></i>
                    </div>
                    <div id="avgProcessingTime" class="text-2xl font-bold text-purple-600 mb-1">--s</div>
                    <div class="text-sm text-gray-500">Trung bình mỗi request</div>
                </div>
            </div>

            <!-- Main Content Grid -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <!-- Timeline -->
                <div class="card rounded-2xl p-6 shadow-card">
                    <h3 class="text-xl font-semibold text-gray-800 mb-4 flex items-center gap-2">
                        <i class="fas fa-history text-blue-500"></i>
                        Nhật Ký Xử Lý
                    </h3>
                    <div id="timeline" class="space-y-4 max-h-96 overflow-y-auto">
                        <div class="timeline-item">
                            <div class="timeline-dot bg-gray-400"></div>
                            <div class="flex items-center gap-3">
                                <span class="text-sm text-gray-500 font-mono">--:--:--</span>
                                <span class="text-gray-600">Hệ thống sẵn sàng hoạt động</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Data Preview -->
                <div class="card rounded-2xl p-6 shadow-card">
                    <h3 class="text-xl font-semibold text-gray-800 mb-4 flex items-center gap-2">
                        <i class="fas fa-eye text-green-500"></i>
                        Dữ Liệu Xử Lý
                    </h3>
                    
                    <!-- Input Section -->
                    <div class="mb-6">
                        <div class="flex items-center gap-2 mb-3">
                            <i class="fas fa-upload text-blue-500"></i>
                            <h4 class="font-semibold text-gray-700">Đầu Vào (variant.imageUrl)</h4>
                        </div>
                        <div id="inputPreview" class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                            <div class="text-center text-gray-500 py-4">
                                <i class="fas fa-image text-3xl mb-2 opacity-50"></i>
                                <div>Chưa có dữ liệu đầu vào</div>
                            </div>
                        </div>
                    </div>

                    <!-- Output Section -->
                    <div>
                        <div class="flex items-center gap-2 mb-3">
                            <i class="fas fa-download text-green-500"></i>
                            <h4 class="font-semibold text-gray-700">Đầu Ra (variant.image_url3d)</h4>
                        </div>
                        <div id="outputPreview" class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                            <div class="text-center text-gray-500 py-4">
                                <i class="fas fa-cube text-3xl mb-2 opacity-50"></i>
                                <div>Chưa có kết quả xử lý</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Progress Bar -->
            <div id="progressContainer" class="mt-8 card rounded-xl p-4 shadow-card hidden">
                <div class="flex items-center justify-between mb-2">
                    <span class="text-sm font-semibold text-gray-700">Tiến Độ Xử Lý</span>
                    <span id="progressText" class="text-sm text-gray-500">0%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                    <div id="progressBar" class="progress-bar rounded-full h-2" style="width: 0%"></div>
                </div>
            </div>

            <!-- History Log Dashboard -->
            <div class="mt-8 card rounded-2xl p-6 shadow-card animate-slide-up">
                <h2 class="text-xl font-semibold text-gray-800 mb-6 flex items-center gap-2">
                    <i class="fas fa-database text-indigo-500"></i>
                    Bảng Tổng Hợp Dữ Liệu Xử Lý
                </h2>

                <!-- Filter Controls -->
                <div class="flex flex-wrap gap-3 mb-6">
                    <button id="filterAllBtn" class="px-4 py-2 rounded-lg bg-gray-100 text-gray-700 font-medium hover:bg-gray-200 transition-all flex items-center gap-2 active">
                        <i class="fas fa-list-ul"></i>
                        Tất Cả
                        <span id="filterAllCount" class="bg-gray-700 text-white text-xs px-2 py-0.5 rounded-full ml-1">0</span>
                    </button>
                    <button id="filterSuccessBtn" class="px-4 py-2 rounded-lg bg-gray-100 text-gray-700 font-medium hover:bg-green-100 hover:text-green-700 transition-all flex items-center gap-2">
                        <i class="fas fa-check-circle text-green-500"></i>
                        Thành Công
                        <span id="filterSuccessCount" class="bg-green-500 text-white text-xs px-2 py-0.5 rounded-full ml-1">0</span>
                    </button>
                    <button id="filterErrorBtn" class="px-4 py-2 rounded-lg bg-gray-100 text-gray-700 font-medium hover:bg-red-100 hover:text-red-700 transition-all flex items-center gap-2">
                        <i class="fas fa-times-circle text-red-500"></i>
                        Lỗi
                        <span id="filterErrorCount" class="bg-red-500 text-white text-xs px-2 py-0.5 rounded-full ml-1">0</span>
                    </button>
                    <div class="ml-auto">
                        <button id="clearHistoryBtn" class="px-4 py-2 rounded-lg bg-gray-700 text-white font-medium hover:bg-gray-800 transition-all flex items-center gap-2">
                            <i class="fas fa-trash-alt"></i>
                            Xóa Lịch Sử
                        </button>
                    </div>
                </div>

                <!-- Data Table -->
                <div class="rounded-xl border border-gray-200 overflow-hidden">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-gray-50 border-b border-gray-200">
                                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">#</th>
                                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Thời Gian</th>
                                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Trạng Thái</th>
                                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600 hidden md:table-cell">URL Hình Ảnh</th>
                                <th class="px-4 py-3 text-left text-sm font-semibold text-gray-600">Thời Gian Xử Lý</th>
                                <th class="px-4 py-3 text-center text-sm font-semibold text-gray-600">Thao Tác</th>
                            </tr>
                        </thead>
                        <tbody id="historyTableBody">
                            <tr class="border-b border-gray-100 text-center">
                                <td colspan="6" class="px-4 py-8 text-gray-500">
                                    <i class="fas fa-history text-3xl mb-3 opacity-30"></i>
                                    <div>Chưa có dữ liệu xử lý</div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Empty State -->
                <div id="emptyHistoryState" class="hidden text-center py-10">
                    <i class="fas fa-clipboard-list text-4xl text-gray-300 mb-3"></i>
                    <h3 class="text-gray-500 font-medium mb-1">Không Có Dữ Liệu</h3>
                    <p class="text-gray-400 text-sm">Chưa có dữ liệu nào phù hợp với bộ lọc đã chọn</p>
                </div>

                <!-- Stats Footer -->
                <div class="mt-4 flex flex-wrap justify-between text-sm text-gray-500">
                    <div>
                        Hiển thị <span id="visibleRecordCount">0</span> / <span id="totalRecordCount">0</span> bản ghi
                    </div>
                    <div>
                        Cập nhật lần cuối: <span id="lastUpdatedTime">--:--:--</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let isProcessing = false;
        let requestCount = 0;
        let successCount = 0;
        let processingTimes = [];
        let processingInterval;
        let variantsToProcess = [];
        let currentVariantIndex = 0;
        
        const statusIndicator = document.getElementById('statusIndicator');
        const statusText = document.getElementById('statusText');
        const statusDescription = document.getElementById('statusDescription');
        const requestCounter = document.getElementById('requestCounter');
        const successRate = document.getElementById('successRate');
        const successCountEl = document.getElementById('successCount');
        const totalCountEl = document.getElementById('totalCount');
        const avgProcessingTimeEl = document.getElementById('avgProcessingTime');
        const timeline = document.getElementById('timeline');
        const inputPreview = document.getElementById('inputPreview');
        const outputPreview = document.getElementById('outputPreview');
        const startBtn = document.getElementById('startBtn');
        const stopBtn = document.getElementById('stopBtn');
        const imageUrlInput = document.getElementById('imageUrlInput');
        const progressContainer = document.getElementById('progressContainer');
        const progressBar = document.getElementById('progressBar');
        const progressText = document.getElementById('progressText');
        
        // Initialize variants data from the table
        function initializeVariantsData() {
            variantsToProcess = [];
            const variantRows = document.querySelectorAll('#variantsList tr');
            
            variantRows.forEach(row => {
                const processBtn = row.querySelector('.process-variant-btn');
                if (!processBtn) return;
                
                const variantId = processBtn.getAttribute('data-variant-id');
                const imageUrl = row.querySelector('.variant-image-url').textContent;
                const has3DImage = processBtn.getAttribute('data-has-3d-image') === 'true';
                
                if (imageUrl && imageUrl.trim() !== '' && !has3DImage) {
                    variantsToProcess.push({
                        variantId: variantId,
                        imageUrl: imageUrl
                    });
                }
            });
            
            console.log('Found ' + variantsToProcess.length + ' variants to process');
            
            // If we have variants, set the first one as the current URL
            if (variantsToProcess.length > 0) {
                imageUrlInput.value = variantsToProcess[0].imageUrl;
                addTimelineEvent('Đã tải ' + variantsToProcess.length + ' sản phẩm cần xử lý', 'info', 'fas fa-database');
            }
        }
        
        // Add event listeners to process variant buttons
        document.querySelectorAll('.process-variant-btn').forEach(button => {
            button.addEventListener('click', function() {
                const imageUrl = this.getAttribute('data-image-url');
                imageUrlInput.value = imageUrl;
                
                // Scroll to the control panel
                document.querySelector('.card').scrollIntoView({ behavior: 'smooth' });
                
                // Highlight the input field
                imageUrlInput.focus();
                imageUrlInput.classList.add('ring-2', 'ring-blue-300');
                setTimeout(() => {
                    imageUrlInput.classList.remove('ring-2', 'ring-blue-300');
                }, 1500);
            });
        });

        function updateStatus(status, description, statusClass) {
            statusText.textContent = status;
            statusDescription.textContent = description;
            statusIndicator.className = `status-dot ${statusClass} w-3 h-3 rounded-full`;
            
            const bgColors = {
                'online': 'bg-green-500',
                'processing': 'bg-blue-500',
                'offline': 'bg-gray-400',
                'error': 'bg-red-500'
            };
            
            statusIndicator.classList.add(bgColors[statusClass] || 'bg-gray-400');
        }

        function addTimelineEvent(message, type = 'info', icon = 'fas fa-info-circle') {
            const colors = {
                info: { bg: 'bg-blue-500', text: 'text-blue-700', bgLight: 'bg-blue-50' },
                success: { bg: 'bg-green-500', text: 'text-green-700', bgLight: 'bg-green-50' },
                error: { bg: 'bg-red-500', text: 'text-red-700', bgLight: 'bg-red-50' },
                warning: { bg: 'bg-yellow-500', text: 'text-yellow-700', bgLight: 'bg-yellow-50' }
            };
            
            const color = colors[type];
            const time = new Date().toLocaleTimeString('vi-VN');
            
            const event = document.createElement('div');
            event.className = 'timeline-item animate-fade-in';
            event.innerHTML = 
                '<div class="timeline-dot ' + color.bg + '"></div>' +
                '<div class="flex items-start gap-3">' +
                    '<span class="text-sm text-gray-500 font-mono flex-shrink-0">' + time + '</span>' +
                    '<div class="flex-1">' +
                        '<div class="flex items-center gap-2 mb-1">' +
                            '<i class="' + icon + ' ' + color.text + ' text-sm"></i>' +
                            '<span class="text-gray-800 font-medium">' + message + '</span>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            
            timeline.insertBefore(event, timeline.firstChild);
            
            // Giữ chỉ 15 sự kiện gần nhất
            while (timeline.children.length > 15) {
                timeline.removeChild(timeline.lastChild);
            }
        }

        function updateStats() {
            requestCounter.textContent = requestCount;
            successCountEl.textContent = successCount;
            totalCountEl.textContent = requestCount;
            
            if (requestCount > 0) {
                const rate = Math.round((successCount / requestCount) * 100);
                successRate.textContent = rate + '%';
            } else {
                successRate.textContent = '--%';
            }
            
            if (processingTimes.length > 0) {
                const avg = processingTimes.reduce((a, b) => a + b, 0) / processingTimes.length;
                avgProcessingTimeEl.textContent = avg.toFixed(1) + 's';
            }
        }

        function updateProgress(percent) {
            progressBar.style.width = percent + '%';
            progressText.textContent = percent + '%';
        }

        function simulateApiCall() {
            const imageUrl = imageUrlInput.value.trim();
            if (!imageUrl) {
                addTimelineEvent('Lỗi: Chưa nhập URL hình ảnh', 'error', 'fas fa-exclamation-triangle');
                return;
            }

            requestCount++;
            const requestId = requestCount;
            const startTime = Date.now();
            
            // Lấy variantId của biến thể hiện tại nếu đang xử lý danh sách biến thể
            let currentVariantId = null;
            if (variantsToProcess.length > 0 && currentVariantIndex < variantsToProcess.length) {
                currentVariantId = variantsToProcess[currentVariantIndex].variantId;
            }
            
            updateStats();
            progressContainer.classList.remove('hidden');
            
            addTimelineEvent('Đang gửi yêu cầu #' + requestId + (currentVariantId ? ` cho biến thể #${currentVariantId}` : ''), 'info', 'fas fa-paper-plane');
            
            // Cập nhật preview đầu vào
            inputPreview.innerHTML = 
                '<div class="space-y-3">' +
                    '<div class="flex items-center gap-2 text-blue-600">' +
                        '<i class="fas fa-link"></i>' +
                        '<span class="font-semibold">URL Hình Ảnh:</span>' +
                    '</div>' +
                    '<div class="bg-white p-3 rounded-lg border border-blue-200 break-all font-mono text-sm">' +
                        imageUrl +
                    '</div>' +
                    (currentVariantId ? 
                    '<div class="text-xs text-blue-600 font-semibold">' +
                        '<i class="fas fa-tag"></i> Biến thể ID: ' + currentVariantId +
                    '</div>' : '') +
                    '<div class="text-xs text-gray-500">' +
                        '<i class="fas fa-clock"></i> Thời gian gửi: <span>' + new Date().toLocaleString('vi-VN') + '</span>' +
                    '</div>' +
                '</div>';

            // Hiển thị tiến trình
            let progress = 0;
            const progressInterval = setInterval(() => {
                progress += Math.random() * 15 + 5;
                if (progress > 95) progress = 95;
                updateProgress(Math.round(progress));
            }, 200);
            
            // Chuyển đổi URL hình ảnh thành base64
            fetch(imageUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Không thể tải hình ảnh từ URL');
                    }
                    return response.blob();
                })
                .then(blob => {
                    return new Promise((resolve, reject) => {
                        const reader = new FileReader();
                        reader.onloadend = () => resolve(reader.result);
                        reader.onerror = reject;
                        reader.readAsDataURL(blob);
                    });
                })
                .then(dataUrl => {
                    // Loại bỏ phần header của data URL để lấy chuỗi base64 thuần túy
                    const base64String = dataUrl.split(',')[1];
                    
                    // Gọi API Hunyuan3D-2
                    return fetch('http://localhost:8081/generate', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            image: base64String,
                            octree_resolution: 256,
                            num_inference_steps: 5,
                            guidance_scale: 5.0,
                            texture: true,
                            type: 'glb'
                        })
                    });
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('API trả về lỗi: ' + response.status);
                    }
                    return response.blob();
                })
                .then(blob => {
                    clearInterval(progressInterval);
                    updateProgress(100);
                    
                    const endTime = Date.now();
                    const duration = (endTime - startTime) / 1000;
                    processingTimes.push(duration);
                    
                    // Chuyển blob thành URL đối tượng để hiển thị hoặc tải xuống
                    const objectURL = URL.createObjectURL(blob);
                    
                    // Tạo một FormData để tải lên mô hình 3D
                    const formData = new FormData();
                    formData.append('file', blob, 'model_3d.glb');
                    
                    // Tải lên mô hình 3D lên server
                    return fetch('/admin/upload3DModel', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Không thể tải mô hình lên server');
                        }
                        return response.json();
                    })
                    .then(data => {
                        successCount++;
                        
                        // URL của mô hình 3D trên server
                        const serverModelUrl = data.modelUrl;
                        
                        // Nếu có variantId, cập nhật URL mô hình 3D cho biến thể
                        let updatePromise = Promise.resolve();
                        if (currentVariantId) {
                            updatePromise = updateVariant3DImage(currentVariantId, serverModelUrl);
                        }
                        
                        return updatePromise.then(() => {
                            setTimeout(() => {
                                progressContainer.classList.add('hidden');
                                
                                addTimelineEvent('Yêu cầu #' + requestId + ' hoàn thành thành công', 'success', 'fas fa-check-circle');
                                
                                outputPreview.innerHTML = 
                                    '<div class="space-y-3">' +
                                        '<div class="flex items-center gap-2 text-green-600">' +
                                            '<i class="fas fa-cube"></i>' +
                                            '<span class="font-semibold">Mô hình 3D:</span>' +
                                        '</div>' +
                                        '<div class="bg-white p-3 rounded-lg border border-green-200 break-all font-mono text-sm">' +
                                            serverModelUrl +
                                        '</div>' +
                                        (currentVariantId ? 
                                        '<div class="text-xs text-green-600 font-semibold">' +
                                            '<i class="fas fa-check"></i> Đã cập nhật cho biến thể #' + currentVariantId +
                                        '</div>' : '') +
                                        '<div class="flex items-center justify-between text-xs">' +
                                            '<span class="text-green-600">' +
                                                '<i class="fas fa-check-circle"></i> Xử lý thành công' +
                                            '</span>' +
                                            '<span class="text-gray-500">' +
                                                '<i class="fas fa-stopwatch"></i> ' + duration.toFixed(1) + 's' +
                                            '</span>' +
                                        '</div>' +
                                        '<div class="text-xs text-gray-500">' +
                                            '<i class="fas fa-clock"></i> Hoàn thành: <span>' + new Date().toLocaleString('vi-VN') + '</span>' +
                                        '</div>' +
                                        '<div class="mt-2">' +
                                            '<a href="' + objectURL + '" download="model_3d.glb" class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg inline-flex items-center gap-2 transition-all">' +
                                                '<i class="fas fa-download"></i> Tải xuống mô hình 3D' +
                                            '</a>' +
                                        '</div>' +
                                    '</div>';
                                
                                // Thêm vào bảng dữ liệu
                                addHistoryRecord(requestId, imageUrl, true, duration, serverModelUrl);
                                
                                updateStats();
                            }, 500);
                            
                            return {
                                success: true,
                                objectURL: objectURL,
                                serverModelUrl: serverModelUrl
                            };
                        });
                    });
                })
                .catch(error => {
                    clearInterval(progressInterval);
                    updateProgress(100);
                    
                    const endTime = Date.now();
                    const duration = (endTime - startTime) / 1000;
                    processingTimes.push(duration);
                    
                    setTimeout(() => {
                        progressContainer.classList.add('hidden');
                        
                        const errorMsg = 'Lỗi: ' + error.message;
                        
                        addTimelineEvent('Yêu cầu #' + requestId + ' thất bại: ' + errorMsg, 'error', 'fas fa-times-circle');
                        
                        outputPreview.innerHTML = 
                            '<div class="space-y-3">' +
                                '<div class="flex items-center gap-2 text-red-600">' +
                                    '<i class="fas fa-exclamation-triangle"></i>' +
                                    '<span class="font-semibold">Lỗi Xử Lý:</span>' +
                                '</div>' +
                                '<div class="bg-red-50 border border-red-200 p-3 rounded-lg">' +
                                    '<div class="text-red-700 font-medium">' + errorMsg + '</div>' +
                                    '<div class="text-red-600 text-sm mt-1">Mã lỗi: ERR_' + (Math.floor(Math.random() * 9000) + 1000) + '</div>' +
                                '</div>' +
                                (currentVariantId ? 
                                '<div class="text-xs text-red-600 font-semibold">' +
                                    '<i class="fas fa-times"></i> Không thể cập nhật biến thể #' + currentVariantId +
                                '</div>' : '') +
                                '<div class="flex items-center justify-between text-xs">' +
                                    '<span class="text-red-600">' +
                                        '<i class="fas fa-times-circle"></i> Xử lý thất bại' +
                                    '</span>' +
                                    '<span class="text-gray-500">' +
                                        '<i class="fas fa-stopwatch"></i> ' + duration.toFixed(1) + 's' +
                                    '</span>' +
                                '</div>' +
                                '<div class="text-xs text-gray-500">' +
                                    '<i class="fas fa-clock"></i> Thất bại lúc: <span>' + new Date().toLocaleString('vi-VN') + '</span>' +
                                '</div>' +
                            '</div>';
                        
                        // Thêm vào bảng dữ liệu
                        addHistoryRecord(requestId, imageUrl, false, duration, null, errorMsg);
                        
                        updateStats();
                    }, 500);
                    
                    return {
                        success: false,
                        error: error.message
                    };
                });
        }

        function startProcessing() {
            const imageUrl = imageUrlInput.value.trim();
            if (!imageUrl) {
                alert('Vui lòng nhập URL hình ảnh trước khi bắt đầu!');
                imageUrlInput.focus();
                return;
            }

            isProcessing = true;
            startBtn.disabled = true;
            stopBtn.disabled = false;
            imageUrlInput.disabled = true;
            
            updateStatus('Đang Xử Lý', 'Đang gửi yêu cầu đến API...', 'processing');
            addTimelineEvent('Bắt đầu quá trình xử lý tự động', 'info', 'fas fa-play-circle');
            
            // Kiểm tra nếu có danh sách biến thể cần xử lý
            if (variantsToProcess.length > 0) {
                addTimelineEvent(`Bắt đầu xử lý ${variantsToProcess.length} biến thể sản phẩm`, 'info', 'fas fa-tasks');
                currentVariantIndex = 0;
                
                // Gửi yêu cầu đầu tiên ngay lập tức
                imageUrlInput.value = variantsToProcess[currentVariantIndex].imageUrl;
                simulateApiCall();
                
                // Tiếp tục gửi các yêu cầu còn lại
                processingInterval = setInterval(() => {
                    if (!isProcessing) {
                        clearInterval(processingInterval);
                        return;
                    }
                    
                    currentVariantIndex++;
                    if (currentVariantIndex >= variantsToProcess.length) {
                        // Đã xử lý tất cả biến thể
                        clearInterval(processingInterval);
                        addTimelineEvent('Đã xử lý tất cả biến thể sản phẩm', 'success', 'fas fa-check-double');
                        stopProcessing();
                        return;
                    }
                    
                    // Cập nhật URL hình ảnh và gửi yêu cầu tiếp theo
                    imageUrlInput.value = variantsToProcess[currentVariantIndex].imageUrl;
                    simulateApiCall();
                }, 5000); // Đợi 5 giây giữa các yêu cầu để tránh quá tải API
            } else {
                // Nếu không có danh sách biến thể, chỉ xử lý URL hiện tại
                simulateApiCall();
            }
        }

        function stopProcessing() {
            isProcessing = false;
            startBtn.disabled = false;
            stopBtn.disabled = true;
            imageUrlInput.disabled = false;
            
            if (processingInterval) {
                clearInterval(processingInterval);
            }
            
            progressContainer.classList.add('hidden');
            updateStatus('Đã Dừng', 'Quá trình xử lý đã được dừng', 'offline');
            addTimelineEvent('Đã dừng quá trình xử lý', 'warning', 'fas fa-pause-circle');
        }

        // Khởi tạo
        updateStats();
        updateStatus('Sẵn Sàng', 'Chờ bắt đầu xử lý', 'offline');
        
        // Initialize variants data
        initializeVariantsData();
        
        // Clear timeline mặc định
        setTimeout(() => {
            timeline.innerHTML = '';
            addTimelineEvent('Hệ thống đã sẵn sàng hoạt động', 'info', 'fas fa-check-circle');
        }, 500);
        
        // ----- History Log Dashboard Functions -----
        
        const historyData = [];
        const historyTableBody = document.getElementById('historyTableBody');
        const emptyHistoryState = document.getElementById('emptyHistoryState');
        const filterAllBtn = document.getElementById('filterAllBtn');
        const filterSuccessBtn = document.getElementById('filterSuccessBtn');
        const filterErrorBtn = document.getElementById('filterErrorBtn');
        const clearHistoryBtn = document.getElementById('clearHistoryBtn');
        const filterAllCount = document.getElementById('filterAllCount');
        const filterSuccessCount = document.getElementById('filterSuccessCount');
        const filterErrorCount = document.getElementById('filterErrorCount');
        const visibleRecordCount = document.getElementById('visibleRecordCount');
        const totalRecordCount = document.getElementById('totalRecordCount');
        const lastUpdatedTime = document.getElementById('lastUpdatedTime');
        
        let currentFilter = 'all';
        
        function addHistoryRecord(id, imageUrl, isSuccess, duration, resultUrl, errorMessage) {
            const timestamp = new Date();
            const record = {
                id,
                timestamp,
                imageUrl,
                isSuccess,
                duration,
                resultUrl,
                errorMessage,
                visible: true
            };
            
            historyData.unshift(record);
            updateHistoryTable();
            updateHistoryStats();
            lastUpdatedTime.textContent = timestamp.toLocaleTimeString('vi-VN');
        }
        
        function updateHistoryTable() {
            if (historyData.length === 0) {
                historyTableBody.innerHTML = 
                    '<tr class="border-b border-gray-100 text-center">' +
                        '<td colspan="6" class="px-4 py-8 text-gray-500">' +
                            '<i class="fas fa-history text-3xl mb-3 opacity-30"></i>' +
                            '<div>Chưa có dữ liệu xử lý</div>' +
                        '</td>' +
                    '</tr>';
                emptyHistoryState.classList.add('hidden');
                return;
            }
            
            // Áp dụng filter
            const filteredData = historyData.filter(record => {
                if (currentFilter === 'all') return true;
                if (currentFilter === 'success') return record.isSuccess;
                if (currentFilter === 'error') return !record.isSuccess;
                return true;
            });
            
            if (filteredData.length === 0) {
                historyTableBody.innerHTML = '';
                emptyHistoryState.classList.remove('hidden');
            } else {
                emptyHistoryState.classList.add('hidden');
                
                historyTableBody.innerHTML = filteredData.map(record => {
                    const statusBadge = record.isSuccess
                        ? '<span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"><i class="fas fa-check-circle"></i> Thành công</span>'
                        : '<span class="inline-flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800"><i class="fas fa-times-circle"></i> Lỗi</span>';
                    
                    const truncatedUrl = record.imageUrl.length > 40
                        ? record.imageUrl.substring(0, 37) + '...'
                        : record.imageUrl;
                    
                    let actionButtons = '';
                    if (record.isSuccess) {
                        actionButtons = 
                            '<button class="text-blue-600 hover:text-blue-800 transition-colors" title="Xem kết quả">' +
                                '<i class="fas fa-eye"></i>' +
                            '</button>' +
                            '<button class="text-green-600 hover:text-green-800 transition-colors ml-3" title="Tải xuống">' +
                                '<i class="fas fa-download"></i>' +
                            '</button>';
                    } else {
                        actionButtons = 
                            '<button class="text-blue-600 hover:text-blue-800 transition-colors" title="Xem chi tiết lỗi">' +
                                '<i class="fas fa-info-circle"></i>' +
                            '</button>' +
                            '<button class="text-yellow-600 hover:text-yellow-800 transition-colors ml-3" title="Thử lại">' +
                                '<i class="fas fa-redo-alt"></i>' +
                            '</button>';
                    }
                    
                    return '<tr class="border-b border-gray-100 hover:bg-gray-50 transition-colors">' +
                        '<td class="px-4 py-3 text-gray-800 font-medium">#' + record.id + '</td>' +
                        '<td class="px-4 py-3 text-gray-600 font-mono text-sm">' + record.timestamp.toLocaleTimeString('vi-VN') + '</td>' +
                        '<td class="px-4 py-3">' + statusBadge + '</td>' +
                        '<td class="px-4 py-3 text-gray-600 text-sm hidden md:table-cell">' +
                            '<span title="' + record.imageUrl + '" class="cursor-help hover:text-blue-600 transition-colors">' + truncatedUrl + '</span>' +
                        '</td>' +
                        '<td class="px-4 py-3 text-gray-600 font-mono">' + record.duration.toFixed(1) + 's</td>' +
                        '<td class="px-4 py-3 text-center">' + actionButtons + '</td>' +
                    '</tr>';
                }).join('');
            }
            
            // Cập nhật số lượng bản ghi hiển thị
            visibleRecordCount.textContent = filteredData.length;
        }
        
        function updateHistoryStats() {
            // Cập nhật tổng số
            totalRecordCount.textContent = historyData.length;
            filterAllCount.textContent = historyData.length;
            
            // Cập nhật số thành công
            const successRecords = historyData.filter(record => record.isSuccess);
            filterSuccessCount.textContent = successRecords.length;
            
            // Cập nhật số lỗi
            const errorRecords = historyData.filter(record => !record.isSuccess);
            filterErrorCount.textContent = errorRecords.length;
        }
        
        function applyFilter(filter) {
            currentFilter = filter;
            
            // Cập nhật trạng thái active của các nút
            filterAllBtn.classList.remove('active', 'bg-gray-200');
            filterSuccessBtn.classList.remove('active', 'bg-green-200', 'text-green-800');
            filterErrorBtn.classList.remove('active', 'bg-red-200', 'text-red-800');
            
            if (filter === 'all') {
                filterAllBtn.classList.add('active', 'bg-gray-200');
            } else if (filter === 'success') {
                filterSuccessBtn.classList.add('active', 'bg-green-200', 'text-green-800');
            } else if (filter === 'error') {
                filterErrorBtn.classList.add('active', 'bg-red-200', 'text-red-800');
            }
            
            updateHistoryTable();
        }
        
        function clearHistory() {
            if (historyData.length === 0) return;
            
            if (confirm('Bạn có chắc chắn muốn xóa tất cả lịch sử xử lý?')) {
                historyData.length = 0;
                updateHistoryTable();
                updateHistoryStats();
                addTimelineEvent('Đã xóa tất cả lịch sử xử lý', 'warning', 'fas fa-trash-alt');
            }
        }
        
        // Event Listeners
        filterAllBtn.addEventListener('click', function() { applyFilter('all'); });
        filterSuccessBtn.addEventListener('click', function() { applyFilter('success'); });
        filterErrorBtn.addEventListener('click', function() { applyFilter('error'); });
        clearHistoryBtn.addEventListener('click', clearHistory);

        // Hàm cập nhật URL mô hình 3D cho biến thể sản phẩm
        function updateVariant3DImage(variantId, model3dUrl) {
            return fetch('/admin/variant/update3DImage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    variantId: variantId,
                    image_url3d: model3dUrl
                })
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Không thể cập nhật URL mô hình 3D');
                }
                return response.json();
            })
            .then(data => {
                addTimelineEvent(`Đã cập nhật URL mô hình 3D cho biến thể #${variantId}`, 'success', 'fas fa-database');
                return data;
            })
            .catch(error => {
                addTimelineEvent(`Lỗi cập nhật URL mô hình 3D: ${error.message}`, 'error', 'fas fa-exclamation-circle');
                throw error;
            });
        }
    </script>
</body>
</html>