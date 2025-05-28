<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3D Image Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-50">
    <div class="min-h-screen">
        <!-- Header -->
        <header class="bg-gradient-to-r from-purple-600 to-blue-500 text-white shadow-lg">
            <div class="container mx-auto px-4 py-6">
                <h1 class="text-3xl font-bold">3D Image Management việt nam </h1>
                <p class="mt-2 text-blue-100">Create and manage 3D product images</p>
            </div>
        </header>
        
        <!-- Main Content -->
        <main class="container mx-auto px-4 py-8">
            <!-- Filter Section -->
            <div class="mb-8 bg-white rounded-xl shadow-md p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Filter Products</h2>
                <form action="${pageContext.request.contextPath}/admin/dashboard/createimage3d" method="get">
                    <div class="flex flex-wrap gap-4">
                        <div class="flex-grow">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Product ID</label>
                            <input type="text" name="productId" value="${selectedProductId}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" 
                                placeholder="Enter Product ID">
                        </div>
                        <div class="flex-grow">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Product Name</label>
                            <input type="text" name="productName" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" 
                                placeholder="Not implemented yet">
                        </div>
                        <div class="flex items-end">
                            <button type="submit" class="px-5 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition">
                                Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            
            <!-- Product Variants Grid -->
            <div class="bg-white rounded-xl shadow-md p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-semibold text-gray-800">Product Variants</h2>
                    <a href="${pageContext.request.contextPath}/admin/dashboard/createimage3d" class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition">
                        Show All Variants
                    </a>
                </div>
                
                <div class="overflow-hidden rounded-lg border border-gray-200">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Variant ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Product ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Product Name</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">SKU</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Regular Image</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">3D Image</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${productVariants}" var="variant">
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${variant.productVariantId}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${variant.product.productId}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${variant.product.productName}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${variant.SKU}</td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="h-20 w-20 rounded-md overflow-hidden bg-gray-100 border">
                                            <c:choose>
                                                <c:when test="${not empty variant.imageUrl}">
                                                    <img src="${variant.imageUrl}" alt="Product" class="h-full w-full object-cover">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="h-full w-full flex items-center justify-center text-gray-400">
                                                        <i class="fas fa-image text-xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="h-20 w-20 rounded-md overflow-hidden bg-gray-100 border">
                                            <c:choose>
                                                <c:when test="${not empty variant.image_url3d}">
                                                    <div class="h-full w-full flex items-center justify-center bg-green-100">
                                                        <span class="text-green-600 font-medium">có 3D</span>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="h-full w-full flex items-center justify-center bg-red-50">
                                                        <span class="text-red-500 font-medium">3D No</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <div class="flex space-x-2">
                                            <a href="${pageContext.request.contextPath}/admin/dashboard/products/edit?id=${variant.productVariantId}" class="p-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button class="upload-btn p-2 bg-green-500 text-white rounded hover:bg-green-600 transition" 
                                                    title="Upload 3D Image" 
                                                    data-variant-id="${variant.productVariantId}"
                                                    data-product-name="${variant.product.productName}"
                                                    data-sku="${variant.SKU}">
                                                <i class="fas fa-cube"></i>
                                            </button>
                                            <button class="delete-3d-btn p-2 bg-red-500 text-white rounded hover:bg-red-600 transition" 
                                                    title="Delete 3D Image"
                                                    data-variant-id="${variant.productVariantId}"
                                                    ${empty variant.image_url3d ? 'disabled' : ''}>
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <!-- If no variants are found -->
                            <c:if test="${empty productVariants}">
                                <tr>
                                    <td colspan="7" class="px-6 py-10 text-center text-gray-500">
                                        <div class="flex flex-col items-center">
                                            <i class="fas fa-box-open text-4xl mb-3 text-gray-300"></i>
                                            <p>No product variants found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                
                <!-- Simple pagination indication - replace with dynamic pagination later -->
                <c:if test="${not empty productVariants}">
                    <div class="flex items-center justify-between py-4">
                        <div class="flex-1 flex justify-between items-center">
                            <div>
                                <p class="text-sm text-gray-700">
                                    Showing <span class="font-medium">${productVariants.size()}</span> results
                                </p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            
            <!-- Upload 3D Image Modal (hidden by default) -->
            <div id="uploadModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                <div class="bg-white rounded-xl shadow-xl max-w-md w-full mx-4">
                    <div class="p-6">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-semibold text-gray-900">Upload 3D Image</h3>
                            <button id="closeModal" class="text-gray-500 hover:text-gray-700">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                        <form id="uploadForm" enctype="multipart/form-data">
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Product Variant ID</label>
                                <input type="text" id="variantId" name="variantId" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500" readonly>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-1">Product Name</label>
                                <input type="text" id="productName" class="w-full px-4 py-2 border border-gray-300 rounded-lg" readonly>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-1">SKU</label>
                                <input type="text" id="sku" class="w-full px-4 py-2 border border-gray-300 rounded-lg" readonly>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-1">3D Image</label>
                                <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-gray-300 border-dashed rounded-lg">
                                    <div class="space-y-1 text-center">
                                        <i class="fas fa-cube text-gray-400 text-3xl"></i>
                                        <div class="flex text-sm text-gray-600">
                                            <label for="file-upload" class="relative cursor-pointer bg-white rounded-md font-medium text-blue-600 hover:text-blue-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-offset-2 focus-within:ring-blue-500">
                                                <span>Upload a file</span>
                                                <input id="file-upload" name="file" type="file" class="sr-only" accept=".glb,.gltf,.obj,.fbx">
                                            </label>
                                            <p class="pl-1">or drag and drop</p>
                                        </div>
                                        <p class="text-xs text-gray-500" id="file-name">GLB, GLTF, OBJ or FBX up to 10MB</p>
                                    </div>
                                </div>
                            </div>
                            <div class="flex justify-end mt-6">
                                <button type="button" id="cancelUpload" class="mr-2 px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-400 focus:ring-offset-2 transition">
                                    Cancel
                                </button>
                                <button type="submit" id="uploadButton" class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition flex items-center">
                                    <span>Upload</span>
                                    <span id="uploadSpinner" class="hidden ml-2">
                                        <i class="fas fa-spinner fa-spin"></i>
                                    </span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Success/Error Toast Message -->
            <div id="toast" class="hidden fixed bottom-4 right-4 px-4 py-2 rounded-lg text-white font-medium shadow-lg transform transition-all duration-300 ease-in-out z-50">
                <span id="toastMessage"></span>
            </div>
        </main>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('uploadModal');
            const toast = document.getElementById('toast');
            const toastMessage = document.getElementById('toastMessage');
            const uploadForm = document.getElementById('uploadForm');
            const fileUpload = document.getElementById('file-upload');
            const fileName = document.getElementById('file-name');
            
            // Show file name when selected
            fileUpload.addEventListener('change', function() {
                if (this.files.length > 0) {
                    fileName.textContent = this.files[0].name;
                } else {
                    fileName.textContent = "GLB, GLTF, OBJ or FBX up to 10MB";
                }
            });
            
            // Open modal when upload button is clicked
            document.querySelectorAll('.upload-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const variantId = this.getAttribute('data-variant-id');
                    const productName = this.getAttribute('data-product-name');
                    const sku = this.getAttribute('data-sku');
                    
                    document.getElementById('variantId').value = variantId;
                    document.getElementById('productName').value = productName;
                    document.getElementById('sku').value = sku;
                    fileName.textContent = "GLB, GLTF, OBJ or FBX up to 10MB";
                    
                    modal.classList.remove('hidden');
                });
            });
            
            // Close modal
            document.getElementById('closeModal').addEventListener('click', function() {
                modal.classList.add('hidden');
            });
            
            document.getElementById('cancelUpload').addEventListener('click', function() {
                modal.classList.add('hidden');
            });
            
            // Close modal when clicking outside
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    modal.classList.add('hidden');
                }
            });
            
            // Handle form submission
            uploadForm.addEventListener('submit', function(e) {
                e.preventDefault();
                
                const formData = new FormData();
                const fileInput = document.getElementById('file-upload');
                const variantId = document.getElementById('variantId').value;
                const uploadButton = document.getElementById('uploadButton');
                const uploadSpinner = document.getElementById('uploadSpinner');
                
                if (fileInput.files.length === 0) {
                    showToast('Please select a file to upload', 'error');
                    return;
                }
                
                // Disable button and show spinner
                uploadButton.disabled = true;
                uploadSpinner.classList.remove('hidden');
                
                formData.append('file', fileInput.files[0]);
                formData.append('variantId', variantId);
                
                fetch('${pageContext.request.contextPath}/admin/dashboard/upload3dimage', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    // Re-enable button and hide spinner
                    uploadButton.disabled = false;
                    uploadSpinner.classList.add('hidden');
                    
                    if (data === 'success') {
                        showToast('3D image uploaded successfully to AWS S3!', 'success');
                        modal.classList.add('hidden');
                        // Reload the page to see the changes
                        setTimeout(() => {
                            window.location.reload();
                        }, 1500);
                    } else {
                        showToast('Error: ' + data, 'error');
                    }
                })
                .catch(error => {
                    // Re-enable button and hide spinner
                    uploadButton.disabled = false;
                    uploadSpinner.classList.add('hidden');
                    
                    showToast('An error occurred: ' + error, 'error');
                });
            });
            
            // Handle delete 3D image
            document.querySelectorAll('.delete-3d-btn').forEach(button => {
                if (!button.hasAttribute('disabled')) {
                    button.addEventListener('click', function() {
                        const variantId = this.getAttribute('data-variant-id');
                        
                        if (confirm('Are you sure you want to delete this 3D image?')) {
                            // This is a placeholder for actual implementation
                            fetch('${pageContext.request.contextPath}/admin/dashboard/delete3dimage', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'variantId=' + variantId
                            })
                            .then(response => response.text())
                            .then(data => {
                                if (data === 'success') {
                                    showToast('3D image deleted successfully!', 'success');
                                    // Reload the page to see the changes
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                } else {
                                    showToast('Error: ' + data, 'error');
                                }
                            })
                            .catch(error => {
                                showToast('An error occurred: ' + error, 'error');
                            });
                        }
                    });
                }
            });
            
            // Show toast message
            function showToast(message, type) {
                toastMessage.textContent = message;
                toast.classList.remove('hidden', 'bg-green-500', 'bg-red-500');
                
                if (type === 'success') {
                    toast.classList.add('bg-green-500');
                } else {
                    toast.classList.add('bg-red-500');
                }
                
                toast.classList.add('opacity-100');
                
                setTimeout(() => {
                    toast.classList.add('hidden');
                }, 3000);
            }
        });
    </script>
</body>
</html>
