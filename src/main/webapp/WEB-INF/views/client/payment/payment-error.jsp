<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Error | Luxury Boutique</title>
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
<body class="min-h-screen bg-gradient-to-br from-gray-50 via-blue-50 to-purple-50">
    <jsp:include page="../layout/navbar.jsp" />

    <!-- Error Message -->
    <div class="container mx-auto px-4 py-20">
        <div class="max-w-3xl mx-auto glass-card p-8 rounded-2xl">
            <div class="text-center mb-8">
                <div class="w-24 h-24 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                </div>
                <h1 class="serif text-4xl font-bold text-gray-900 mb-2">Payment Error</h1>
                <p class="text-gray-600 text-lg">We encountered an issue with your payment request.</p>
            </div>
            
            <div class="bg-red-50 border-l-4 border-red-500 p-4 mb-6">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm text-red-700">
                            <c:choose>
                                <c:when test="${not empty errorMessage}">
                                    ${errorMessage}
                                </c:when>
                                <c:otherwise>
                                    There was a problem processing your payment. The security verification failed.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            
            <div class="border-t border-gray-200 py-6 mb-6">
                <h3 class="text-sm font-semibold text-gray-500 mb-4">WHAT MIGHT HAVE HAPPENED?</h3>
                <ul class="list-disc pl-5 space-y-2 text-gray-600">
                    <li>The payment request might have been tampered with</li>
                    <li>The connection may have been interrupted during the payment process</li>
                    <li>The payment gateway encountered a technical error</li>
                    <li>Your browser session might have expired</li>
                </ul>
            </div>
            
            <div class="text-center space-y-4">
                <p class="text-gray-600">For security reasons, we've canceled this payment attempt. Please try again or contact our customer support for assistance.</p>
                
                <div class="flex flex-col md:flex-row gap-4 justify-center">
                    <a href="/" class="px-8 py-3 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition duration-300 ease-in-out">
                        Return to Home
                    </a>
                    <a href="/client/user/cart" class="px-8 py-3 border border-gray-300 rounded-xl hover:bg-gray-50 transition duration-300 ease-in-out">
                        Try Again
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../layout/footer.jsp" />
</body>
</html> 