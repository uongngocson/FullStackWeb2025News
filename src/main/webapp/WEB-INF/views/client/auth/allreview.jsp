<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá của tôi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sontest.css">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/assets/client/images/icon-adidas-logo.svg" type="image/icon type">
    <style>
        body {
           
        }
        
        .rating {
            display: flex;
            align-items: center;
        }
        
        .star {
            color: #94a3b8;
        }
        
        .star.filled {
            color: #fbbf24;
        }
        
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 50;
            padding: 1rem;
            overflow-y: auto;
        }
        
        .modal-content {
            background: linear-gradient(to bottom right, #1e293b, #0f172a);
            border-radius: 1rem;
            border: 1px solid #334155;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 32rem;
            max-height: calc(100vh - 2rem);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            margin: auto;
            position: relative;
        }
        
        .modal-content form {
            overflow-y: auto;
            max-height: calc(100vh - 12rem);
            scrollbar-width: thin;
            scrollbar-color: #475569 #1e293b;
        }
        
        .modal-content form::-webkit-scrollbar {
            width: 6px;
        }
        
        .modal-content form::-webkit-scrollbar-track {
            background: #1e293b;
        }
        
        .modal-content form::-webkit-scrollbar-thumb {
            background-color: #475569;
            border-radius: 3px;
        }
        
        @media (max-height: 700px) {
            .modal-content {
                max-height: 90vh;
            }
        }
        
        @media (max-width: 640px) {
            .modal-content {
                max-width: 100%;
            }
        }
        
        .hidden {
            display: none;
        }
        
        .review-card {
            transition: all 0.3s ease;
        }
        
        .review-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
        }
        
        .edit-modal-rating-btn {
            width: 2.5rem;
            height: 2.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 0.5rem;
            background-color: #1e293b;
            border: 1px solid #334155;
            color: #94a3b8;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .edit-modal-rating-btn:hover {
            background-color: #334155;
        }
        
        .edit-modal-rating-btn.selected {
            background-color: #fbbf24;
            border-color: #f59e0b;
            color: #0f172a;
        }
    </style>
</head>

<body class="min-h-screen">
    <jsp:include page="../layout/navbar.jsp" />
    
    <!-- Main Content -->
    <section class="py-12 px-4 lg:py-16">
        <div class="mx-auto max-w-7xl">
            <!-- Header with gradient background -->
            <div class="bg-gradient-to-r from-gray-900 to-black rounded-2xl p-8 mb-8 shadow-2xl border border-gray-800">
                <div class="flex items-center justify-between flex-wrap gap-4">
                    <div>
                        <h1 class="text-3xl lg:text-4xl font-bold text-white mb-2">
                            Đánh giá của tôi
                        </h1>
                        <p class="text-gray-300">
                            Quản lý tất cả đánh giá sản phẩm của bạn
                        </p>
                    </div>
                    
                    <!-- Back button -->
                    <a href="${pageContext.request.contextPath}/management/historyorder"
                       class="inline-flex items-center gap-2 bg-gray-800 hover:bg-gray-700 text-white px-6 py-3 rounded-xl transition-all duration-300 border border-gray-700 hover:border-gray-600 hover:shadow-lg">
                        <i class="uil uil-arrow-left"></i>
                        <span class="font-medium">Quay lại lịch sử đơn hàng</span>
                    </a>
                </div>
            </div>
            
            <!-- Success/Error Messages -->
            <c:if test="${not empty successMessage}">
                <div class="bg-green-500/10 border border-green-500/30 rounded-xl p-4 mb-8 flex items-center">
                    <i class="uil uil-check-circle text-green-400 text-xl mr-3"></i>
                    <p class="text-green-300"><c:out value="${successMessage}" /></p>
                </div>
            </c:if>
            
            <c:if test="${not empty errorMessage}">
                <div class="bg-red-500/10 border border-red-500/30 rounded-xl p-4 mb-8 flex items-center">
                    <i class="uil uil-exclamation-triangle text-red-400 text-xl mr-3"></i>
                    <p class="text-red-300"><c:out value="${errorMessage}" /></p>
                </div>
            </c:if>
            
            <!-- Reviews Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="col-span-full bg-gray-900/50 rounded-2xl p-8 text-center border border-gray-800">
                            <div class="w-20 h-20 bg-gray-800 rounded-full mx-auto mb-4 flex items-center justify-center">
                                <i class="uil uil-star text-gray-600 text-4xl"></i>
                            </div>
                            <h2 class="text-xl font-semibold text-gray-300 mb-2">Chưa có đánh giá nào</h2>
                            <p class="text-gray-400 mb-6">Bạn chưa đánh giá sản phẩm nào. Hãy mua sắm và đánh giá sản phẩm để chia sẻ trải nghiệm của bạn.</p>
                            <a href="${pageContext.request.contextPath}/" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-xl transition-all duration-300">
                                <i class="uil uil-shopping-bag"></i>
                                <span>Mua sắm ngay</span>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="review" items="${reviews}">
                            <div class="review-card bg-gradient-to-br from-gray-900 to-gray-800 rounded-2xl overflow-hidden border border-gray-700 shadow-xl">
                                <div class="p-6 border-b border-gray-700">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center">
                                            <div class="rating mr-3">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <i class="uil uil-star text-lg ${star <= review.rating ? 'star filled' : 'star'}"></i>
                                                </c:forEach>
                                            </div>
                                            <span class="text-sm text-gray-400">
                                                <c:out value="${review.reviewDate.toLocalDate()}" />
                                            </span>
                                        </div>
                                        <div class="flex items-center">
                                            <button type="button" onclick="openEditModal('${review.reviewId}', '${review.rating}', '${fn:escapeXml(review.comment)}', '${review.imageUrl}')" 
                                                    class="w-8 h-8 flex items-center justify-center rounded-lg bg-blue-500/20 text-blue-300 hover:bg-blue-500/30 mr-2">
                                                <i class="uil uil-edit"></i>
                                            </button>
                                            <button type="button" onclick="openDeleteModal('${review.reviewId}')" 
                                                    class="w-8 h-8 flex items-center justify-center rounded-lg bg-red-500/20 text-red-300 hover:bg-red-500/30">
                                                <i class="uil uil-trash-alt"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                    <div class="flex items-center gap-3 mb-4">
                                        <div class="w-12 h-12 rounded-lg overflow-hidden bg-gray-800 border border-gray-700 flex-shrink-0">
                                            <c:choose>
                                                <c:when test="${not empty review.product && not empty review.product.productId && not empty productMap[review.product.productId].imageUrl}">
                                                    <img src="${productMap[review.product.productId].imageUrl}" alt="${productMap[review.product.productId].productName}" 
                                                         class="w-full h-full object-cover" />
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-full h-full flex items-center justify-center">
                                                        <i class="uil uil-image-slash text-gray-500"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <h3 class="font-medium text-white">
                                                <c:out value="${not empty review.product && not empty review.product.productId && not empty productMap[review.product.productId] ? productMap[review.product.productId].productName : 'Sản phẩm'}" />
                                            </h3>
                                            <c:if test="${not empty review.product && not empty review.product.productId}">
                                                <a href="${pageContext.request.contextPath}/product/detail?id=${review.product.productId}" class="text-sm text-blue-400 hover:text-blue-300">
                                                    Xem sản phẩm
                                                </a>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-4">
                                        <p class="text-gray-300 whitespace-pre-line">
                                            <c:out value="${review.comment}" default="Không có nhận xét" />
                                        </p>
                                    </div>
                                    
                                    <c:if test="${not empty review.imageUrl}">
                                        <div class="rounded-lg overflow-hidden bg-gray-800 border border-gray-700">
                                            <img src="${review.imageUrl}" alt="Hình ảnh đánh giá" class="w-full h-auto object-contain max-h-48" />
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
    
    <!-- Edit Review Modal -->
    <div id="editReviewModal" class="modal-backdrop hidden">
        <div class="modal-content">
            <div class="p-6 border-b border-gray-700">
                <div class="flex items-center justify-between">
                    <h3 class="text-xl font-bold text-white">Chỉnh sửa đánh giá</h3>
                    <button type="button" onclick="closeEditModal()" class="text-gray-400 hover:text-white">
                        <i class="uil uil-times text-2xl"></i>
                    </button>
                </div>
            </div>
            
            <form id="editReviewForm" action="${pageContext.request.contextPath}/review/update" method="post" enctype="multipart/form-data" class="p-6">
                <input type="hidden" id="editReviewId" name="reviewId" value="">
                
                <!-- Rating -->
                <div class="mb-6">
                    <label class="block text-gray-300 mb-3">Đánh giá của bạn</label>
                    <div class="flex gap-2">
                        <button type="button" class="edit-modal-rating-btn" data-rating="1" onclick="selectRating(1)">
                            <i class="uil uil-star"></i>
                        </button>
                        <button type="button" class="edit-modal-rating-btn" data-rating="2" onclick="selectRating(2)">
                            <i class="uil uil-star"></i>
                        </button>
                        <button type="button" class="edit-modal-rating-btn" data-rating="3" onclick="selectRating(3)">
                            <i class="uil uil-star"></i>
                        </button>
                        <button type="button" class="edit-modal-rating-btn" data-rating="4" onclick="selectRating(4)">
                            <i class="uil uil-star"></i>
                        </button>
                        <button type="button" class="edit-modal-rating-btn" data-rating="5" onclick="selectRating(5)">
                            <i class="uil uil-star"></i>
                        </button>
                    </div>
                    <input type="hidden" id="editRating" name="rating" value="1">
                </div>
                
                <!-- Comment -->
                <div class="mb-6">
                    <label for="editComment" class="block text-gray-300 mb-2">Nhận xét của bạn</label>
                    <div class="relative">
                        <textarea id="editComment" name="comment" rows="4" 
                                class="w-full bg-gray-800 border border-gray-700 rounded-xl p-4 text-white focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent resize-none"
                                placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."
                                maxlength="250"
                                onkeyup="countEditCharacters(this)"></textarea>
                        <div class="flex justify-end mt-2">
                            <span id="editCharCount" class="text-sm text-gray-400">0/250 ký tự</span>
                        </div>
                    </div>
                </div>
                
                <!-- Current Image Preview -->
                <div id="currentImageContainer" class="mb-4 hidden">
                    <label class="block text-gray-300 mb-2">Hình ảnh hiện tại</label>
                    <div class="relative">
                        <img id="currentImage" src="" alt="Hình ảnh hiện tại" class="w-full h-auto max-h-40 object-contain rounded-lg border border-gray-700" />
                    </div>
                </div>
                
                <!-- Image upload -->
                <div class="mb-6">
                    <label class="block text-gray-300 mb-2">Thay đổi hình ảnh (tùy chọn)</label>
                    <div class="relative">
                        <input type="file" id="editReviewImage" name="reviewImage" accept="image/*" class="hidden" onchange="previewEditImage(event)">
                        <div id="editImagePreviewContainer" class="hidden mb-3">
                            <div class="relative w-full h-40 bg-gray-800 rounded-xl overflow-hidden">
                                <img id="editImagePreview" class="w-full h-full object-contain" alt="Preview">
                                <button type="button" onclick="removeEditImage()" class="absolute top-2 right-2 w-8 h-8 bg-red-500 rounded-full flex items-center justify-center text-white hover:bg-red-600 transition-colors">
                                    <i class="uil uil-times"></i>
                                </button>
                            </div>
                        </div>
                        <button type="button" onclick="document.getElementById('editReviewImage').click()" 
                                class="w-full flex items-center justify-center gap-2 bg-gray-800 border border-gray-700 hover:bg-gray-700 text-gray-300 p-4 rounded-xl transition-colors">
                            <i class="uil uil-image-upload"></i>
                            <span>Tải lên hình ảnh mới</span>
                        </button>
                    </div>
                </div>
                
                <!-- Submit button -->
                <div class="flex justify-end gap-3 mt-8">
                    <button type="button" onclick="closeEditModal()" 
                            class="px-6 py-3 bg-gray-800 hover:bg-gray-700 text-white rounded-xl transition-colors">
                        Hủy bỏ
                    </button>
                    <button type="submit" 
                            class="px-6 py-3 bg-purple-600 hover:bg-purple-700 text-white rounded-xl transition-colors">
                        Cập nhật đánh giá
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div id="deleteConfirmModal" class="modal-backdrop hidden">
        <div class="modal-content max-w-md">
            <div class="p-6 border-b border-gray-700">
                <div class="flex items-center justify-between">
                    <h3 class="text-xl font-bold text-white">Xác nhận xóa</h3>
                    <button type="button" onclick="closeDeleteModal()" class="text-gray-400 hover:text-white">
                        <i class="uil uil-times text-2xl"></i>
                    </button>
                </div>
            </div>
            
            <div class="p-6">
                <div class="mb-6">
                    <div class="w-16 h-16 mx-auto bg-red-500/20 rounded-full flex items-center justify-center mb-4">
                        <i class="uil uil-exclamation-triangle text-red-400 text-3xl"></i>
                    </div>
                    <p class="text-center text-gray-300 mb-2">Bạn có chắc chắn muốn xóa đánh giá này?</p>
                    <p class="text-center text-gray-400 text-sm">Hành động này không thể hoàn tác.</p>
                </div>
                
                <form id="deleteReviewForm" action="${pageContext.request.contextPath}/review/delete" method="post">
                    <input type="hidden" id="deleteReviewId" name="reviewId" value="">
                    
                    <div class="flex justify-center gap-4">
                        <button type="button" onclick="closeDeleteModal()" 
                                class="px-6 py-3 bg-gray-800 hover:bg-gray-700 text-white rounded-xl transition-colors">
                            Hủy bỏ
                        </button>
                        <button type="submit" 
                                class="px-6 py-3 bg-red-600 hover:bg-red-700 text-white rounded-xl transition-colors">
                            Xóa đánh giá
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
    
    <script>
        // Edit Modal Functions
        function openEditModal(reviewId, rating, comment, imageUrl) {
            document.getElementById('editReviewId').value = reviewId;
            document.getElementById('editComment').value = comment;
            document.getElementById('editRating').value = parseInt(rating);
            
            // Update rating buttons
            updateRatingButtons(parseInt(rating));
            
            // Show current image if exists
            var currentImageContainer = document.getElementById('currentImageContainer');
            var currentImage = document.getElementById('currentImage');
            
            if (imageUrl && imageUrl !== '') {
                currentImageContainer.classList.remove('hidden');
                currentImage.src = imageUrl;
            } else {
                currentImageContainer.classList.add('hidden');
            }
            
            // Show modal
            document.getElementById('editReviewModal').classList.remove('hidden');
            document.body.classList.add('overflow-hidden');
        }
        
        function closeEditModal() {
            document.getElementById('editReviewModal').classList.add('hidden');
            document.body.classList.remove('overflow-hidden');
            
            // Reset form
            document.getElementById('editReviewForm').reset();
            document.getElementById('editImagePreviewContainer').classList.add('hidden');
        }
        
        function selectRating(rating) {
            document.getElementById('editRating').value = rating;
            updateRatingButtons(rating);
        }
        
        function updateRatingButtons(rating) {
            var ratingButtons = document.querySelectorAll('.edit-modal-rating-btn');
            ratingButtons.forEach(function(button) {
                var buttonRating = parseInt(button.getAttribute('data-rating'));
                if (buttonRating <= rating) {
                    button.classList.add('selected');
                } else {
                    button.classList.remove('selected');
                }
            });
        }
        
        function previewEditImage(event) {
            var file = event.target.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('editImagePreview').src = e.target.result;
                    document.getElementById('editImagePreviewContainer').classList.remove('hidden');
                }
                reader.readAsDataURL(file);
            }
        }
        
        function removeEditImage() {
            document.getElementById('editReviewImage').value = '';
            document.getElementById('editImagePreviewContainer').classList.add('hidden');
        }
        
        // Delete Modal Functions
        function openDeleteModal(reviewId) {
            document.getElementById('deleteReviewId').value = reviewId;
            document.getElementById('deleteConfirmModal').classList.remove('hidden');
            document.body.classList.add('overflow-hidden');
        }
        
        function closeDeleteModal() {
            document.getElementById('deleteConfirmModal').classList.add('hidden');
            document.body.classList.remove('overflow-hidden');
        }
        
        // Character counter function for edit form
        function countEditCharacters(textarea) {
            const maxLength = 250;
            const currentLength = textarea.value.length;
            const charCountElement = document.getElementById('editCharCount');
            
            // Update character count
            charCountElement.textContent = currentLength + '/' + maxLength + ' ký tự';
            
            // Change color when approaching limit
            if (currentLength >= maxLength) {
                charCountElement.classList.remove('text-gray-400', 'text-yellow-400');
                charCountElement.classList.add('text-red-400');
            } else if (currentLength >= maxLength * 0.8) {
                charCountElement.classList.remove('text-gray-400', 'text-red-400');
                charCountElement.classList.add('text-yellow-400');
            } else {
                charCountElement.classList.remove('text-yellow-400', 'text-red-400');
                charCountElement.classList.add('text-gray-400');
            }
            
            // Prevent typing more characters
            if (currentLength > maxLength) {
                textarea.value = textarea.value.substring(0, maxLength);
            }
        }
        
        // Initialize character count when editing a review
        document.addEventListener('DOMContentLoaded', function() {
            // Set initial character count when edit modal is opened
            const editButtons = document.querySelectorAll('.edit-review-btn');
            if (editButtons) {
                editButtons.forEach(function(button) {
                    button.addEventListener('click', function() {
                        // Set timeout to ensure the textarea is populated before counting
                        setTimeout(function() {
                            const editTextarea = document.getElementById('editComment');
                            if (editTextarea) {
                                countEditCharacters(editTextarea);
                            }
                        }, 100);
                    });
                });
            }
        });
    </script>
</body>

</html> 