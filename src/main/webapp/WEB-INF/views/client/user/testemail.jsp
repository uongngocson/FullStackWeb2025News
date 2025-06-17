<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>MONOCHROME | Simple Email Test</title>
                    <c:set var="ctx" value="${pageContext.request.contextPath}" />
                    <script src="https://cdn.tailwindcss.com"></script>
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500&display=swap"
                        rel="stylesheet">

                    <link rel="icon" href="https://image.similarpng.com/file/similarpng/very-thumbnail/2021/01/Fashion-shop-logo-design-on-transparent-background-PNG.png" type="image/x-icon">

                    <!-- Google Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
                        rel="stylesheet">
                        
                    <!-- EmailJS CDN -->
                    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js"></script>

                    <!-- CSRF Token -->
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />

                    <style>
                        .heading-font {
                            font-family: 'Playfair Display', serif;
                        }

                        .body-font {
                            font-family: 'Inter', sans-serif;
                        }

                        body {
                            font-weight: 500;
                        }

                        h1, h2, h3, .heading-font {
                            font-weight: 600;
                        }

                        .email-test-container {
                            max-width: 800px;
                            margin: 0 auto;
                            padding: 40px 20px;
                        }
                        
                        .test-button {
                            background-color: #000;
                            color: white;
                            padding: 12px 24px;
                            border: none;
                            border-radius: 4px;
                            cursor: pointer;
                            font-weight: 600;
                            transition: all 0.2s;
                        }
                        
                        .test-button:hover {
                            background-color: #333;
                        }
                        
                        .result-container {
                            margin-top: 20px;
                            padding: 15px;
                            border-radius: 4px;
                            display: none;
                        }
                        
                        .success {
                            background-color: #d1e7dd;
                            color: #0f5132;
                            border: 1px solid #badbcc;
                        }
                        
                        .error {
                            background-color: #f8d7da;
                            color: #842029;
                            border: 1px solid #f5c2c7;
                        }
                    </style>

                </head>

                <body class="bg-white body-font text-gray-800 min-h-screen flex flex-col">
                    <div class="email-test-container">
                        <h1 class="text-3xl heading-font mb-6">Simple Email Test</h1>
                        
                        <div class="mb-6">
                            <p class="mb-2">This page tests sending a simple email using EmailJS.</p>
                            <p class="mb-4">Enter the recipient email address and click the button to send a test email.</p>
                            
                            <div class="mb-4">
                                <label for="recipient-email" class="block mb-2">Recipient Email:</label>
                                <input type="email" id="recipient-email" class="border border-gray-300 rounded p-2 w-full max-w-md" 
                                       placeholder="Enter recipient email address">
                            </div>

                            <div class="mb-4">
                                <label for="subject" class="block mb-2">Subject:</label>
                                <input type="text" id="subject" class="border border-gray-300 rounded p-2 w-full max-w-md" 
                                       placeholder="Email subject" value="Test Email from MONOCHROME">
                            </div>

                            <div class="mb-4">
                                <label for="message" class="block mb-2">Message:</label>
                                <textarea id="message" class="border border-gray-300 rounded p-2 w-full max-w-md h-32" 
                                       placeholder="Enter your message">This is a test email from MONOCHROME. Thank you for testing our email functionality.</textarea>
                            </div>
                            
                            <button id="send-test-email" class="test-button">
                                Send Email
                            </button>
                        </div>
                        
                        <div id="result-container" class="result-container">
                            <p id="result-message"></p>
                        </div>
                        
                        <div class="mt-8">
                            <h2 class="text-xl heading-font mb-4">Email Configuration</h2>
                            <ul class="list-disc pl-5">
                                <li>Service ID: uongngocson</li>
                                <li>Template ID: template_qlqdea9</li>
                                <li>Public Key: fnk7nljKs4K4Nt2ee</li>
                            </ul>
                        </div>
                    </div>

                    <script type="text/javascript">
                        // Initialize EmailJS
                        (function() {
                            emailjs.init("fnk7nljKs4K4Nt2ee");
                        })();
                        
                        // Send email function
                        document.getElementById('send-test-email').addEventListener('click', function() {
                            const recipientEmail = document.getElementById('recipient-email').value;
                            const subject = document.getElementById('subject').value;
                            const message = document.getElementById('message').value;
                            
                            if (!recipientEmail) {
                                showResult("Please enter a recipient email address", false);
                                return;
                            }
                            
                            // Show loading state
                            const button = this;
                            button.disabled = true;
                            button.textContent = "Sending...";
                            
                            // Create simple email parameters
                            const emailParams = {
                                to_email: recipientEmail,
                                to_name: recipientEmail.split('@')[0],
                                subject: subject,
                                message: message,
                                from_name: "MONOCHROME",
                                from_email: "noreply@monochrome.com"
                            };
                            
                            // Send the email using the service ID and template ID
                            emailjs.send("uongngocson", "template_qlqdea9", emailParams)
                                .then(function(response) {
                                    console.log("Email sent successfully", response);
                                    showResult("Email sent successfully! Check the recipient's inbox.", true);
                                })
                                .catch(function(error) {
                                    console.error("Failed to send email", error);
                                    showResult("Failed to send email: " + (error.text || JSON.stringify(error)), false);
                                })
                                .finally(function() {
                                    button.disabled = false;
                                    button.textContent = "Send Email";
                                });
                        });
                        
                        // Show result message
                        function showResult(message, isSuccess) {
                            const resultContainer = document.getElementById('result-container');
                            const resultMessage = document.getElementById('result-message');
                            
                            resultContainer.style.display = 'block';
                            resultContainer.className = 'result-container ' + (isSuccess ? 'success' : 'error');
                            resultMessage.textContent = message;
                            
                            // Scroll to the result
                            resultContainer.scrollIntoView({ behavior: 'smooth' });
                        }
                    </script>
                </body>

                </html>