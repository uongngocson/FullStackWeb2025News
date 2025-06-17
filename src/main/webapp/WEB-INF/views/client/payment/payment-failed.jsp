<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Failed | Luxury Boutique</title>
    <link rel="icon" href="https://image.similarpng.com/file/similarpng/very-thumbnail/2021/01/Fashion-shop-logo-design-on-transparent-background-PNG.png" type="image/x-icon">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&family=Cormorant+Garamond:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Inter', sans-serif;
        }
        
        .serif {
            font-family: 'Cormorant Garamond', serif;
        }
        
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-gray-50 via-red-50 to-pink-50">
    <jsp:include page="../layout/navbar.jsp" />

    <!-- Failed Message -->
    <div class="container mx-auto px-4 py-20">
        <div class="max-w-3xl mx-auto glass-card p-8 rounded-2xl">
            <div class="text-center mb-8">
                <div class="w-24 h-24 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </div>
                <h1 class="serif text-4xl font-bold text-gray-900 mb-2">Payment Failed</h1>
                <p class="text-gray-600 text-lg">Your transaction could not be completed.</p>
            </div>
            
            <div class="border-t border-b border-gray-200 py-6 mb-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h3 class="text-sm font-semibold text-gray-500 mb-2">TRANSACTION DETAILS</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Order Reference:</span>
                                <span class="font-medium">${orderId}</span>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <h3 class="text-sm font-semibold text-gray-500 mb-2">ERROR DETAILS</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Status:</span>
                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                    Failed
                                </span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Message:</span>
                                <span class="font-medium">${message}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center space-y-4">
                <p class="text-gray-600">We were unable to process your payment. Please try again or use a different payment method.</p>
                
                <div class="flex flex-col md:flex-row gap-4 justify-center">
                    <a href="/" class="px-8 py-3 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition duration-300 ease-in-out">
                        Return to Home
                    </a>
                    <a href="/checkout" class="px-8 py-3 border border-gray-300 rounded-xl hover:bg-gray-50 transition duration-300 ease-in-out">
                        Try Again
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html> 
</html> 