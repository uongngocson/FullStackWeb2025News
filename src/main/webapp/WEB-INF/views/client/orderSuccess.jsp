<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed | DDTS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;500&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #FFFFFF;
            color: #000000;
        }
        
        .heading-font {
            font-family: 'Playfair Display', serif;
        }
        
        .checkmark {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #000000;
            color: #FFFFFF;
            font-size: 40px;
        }
        
        .order-item {
            transition: transform 0.3s ease;
        }
        
        .order-item:hover {
            transform: translateY(-5px);
        }
        
        .return-btn {
            transition: all 0.3s ease;
        }
        
        .return-btn:hover {
            background-color: #333333 !important;
            transform: scale(1.02);
        }
        
        .divider {
            border-top: 1px solid #e5e5e5;
        }
        
        .social-icon {
            transition: all 0.3s ease;
        }
        
        .social-icon:hover {
            transform: translateY(-2px);
            opacity: 0.8;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col">
    

    <!-- Main Content -->
    <main class="flex-grow py-16 px-4">
        <div class="container mx-auto max-w-4xl">
            <div class="text-center mb-12">
                <div class="checkmark mx-auto mb-6">
                    <i class="fas fa-check"></i>
                </div>
                <h1 class="heading-font text-4xl md:text-5xl font-bold mb-4">Order Confirmed</h1>
            </div>
            
          
            <div class="text-center">
                <button class="return-btn bg-black text-white py-3 px-8 rounded-none font-medium text-sm tracking-wider">
                    <a href="/">RETURN TO HOME</a>
                </button>
            </div>
        </div>
    </main>


</body>
</html>