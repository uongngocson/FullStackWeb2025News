<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Chatbot Administration</title>
                    <!-- For Spring Security CSRF Support -->
                    <meta name="_csrf" content="${_csrf.token}" />
                    <meta name="_csrf_header" content="${_csrf.headerName}" />
                    <!-- Tailwind CSS CDN -->
                    <script src="https://cdn.tailwindcss.com"></script>
                    <!-- Font Awesome -->
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    <!-- jQuery -->
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <!-- Application Context Path for JavaScript -->
                    <script>
                        var contextPath = '${pageContext.request.contextPath}';
                    </script>
                </head>

                <body class="bg-gray-100 min-h-screen">
                    <div class="container mx-auto px-4 py-8">
                        <header class="mb-8">
                            <h1 class="text-3xl font-bold text-gray-800">Chatbot Administration</h1>
                            <p class="text-gray-600">Manage your chatbot knowledge base and data ingestion</p>
                        </header>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <!-- Document Ingestion Panel -->
                            <div class="bg-white rounded-lg shadow-md p-6">
                                <h2 class="text-xl font-semibold mb-4 flex items-center text-blue-800">
                                    <i class="fas fa-file-upload mr-2"></i> Document Ingestion
                                </h2>
                                <form id="document-form" class="space-y-4">
                                    <div>
                                        <label for="doc-title"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document Title</label>
                                        <input type="text" id="doc-title" name="title" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="doc-type"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document Type</label>
                                        <select id="doc-type" name="type" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                            <option value="fashion_knowledge">Fashion Knowledge</option>
                                            <option value="product_information">Product Information</option>
                                            <option value="faq">FAQ</option>
                                            <option value="policy">Store Policy</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label for="doc-content"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document
                                            Content</label>
                                        <textarea id="doc-content" name="text" rows="6" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"></textarea>
                                    </div>

                                    <div class="flex justify-end">
                                        <button type="button" id="ingest-document"
                                            class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                                            <i class="fas fa-plus mr-2"></i> Add to Knowledge Base
                                        </button>
                                    </div>
                                </form>
                                <div id="document-result" class="mt-4 hidden"></div>
                            </div>

                            <!-- Chunked Text Ingestion -->
                            <div class="bg-white rounded-lg shadow-md p-6">
                                <h2 class="text-xl font-semibold mb-4 flex items-center text-green-800">
                                    <i class="fas fa-puzzle-piece mr-2"></i> Chunked Document Ingestion
                                </h2>
                                <form id="chunked-form" class="space-y-4">
                                    <div>
                                        <label for="chunked-title"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document Title</label>
                                        <input type="text" id="chunked-title" name="title" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                    </div>

                                    <div>
                                        <label for="chunked-type"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document Type</label>
                                        <select id="chunked-type" name="type" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                            <option value="fashion_knowledge">Fashion Knowledge</option>
                                            <option value="product_information">Product Information</option>
                                            <option value="faq">FAQ</option>
                                            <option value="policy">Store Policy</option>
                                        </select>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="chunk-size"
                                                class="block text-sm font-medium text-gray-700 mb-1">Chunk Size</label>
                                            <input type="number" id="chunk-size" name="chunkSize" value="500" required
                                                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                        <div>
                                            <label for="chunk-overlap"
                                                class="block text-sm font-medium text-gray-700 mb-1">Chunk
                                                Overlap</label>
                                            <input type="number" id="chunk-overlap" name="overlap" value="50" required
                                                class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500">
                                        </div>
                                    </div>

                                    <div>
                                        <label for="chunked-content"
                                            class="block text-sm font-medium text-gray-700 mb-1">Document
                                            Content</label>
                                        <textarea id="chunked-content" name="text" rows="6" required
                                            class="w-full px-4 py-2 border border-gray-300 rounded-md focus:ring-blue-500 focus:border-blue-500"></textarea>
                                    </div>

                                    <div class="flex justify-end">
                                        <button type="button" id="ingest-chunked"
                                            class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2">
                                            <i class="fas fa-puzzle-piece mr-2"></i> Ingest Chunked Document
                                        </button>
                                    </div>
                                </form>
                                <div id="chunked-result" class="mt-4 hidden"></div>
                            </div>

                            <!-- Product Data Ingestion -->
                            <div class="bg-white rounded-lg shadow-md p-6">
                                <h2 class="text-xl font-semibold mb-4 flex items-center text-purple-800">
                                    <i class="fas fa-shopping-cart mr-2"></i> Product Data Ingestion
                                </h2>
                                <p class="text-gray-600 mb-4">Ingest product data from the database into the chatbot
                                    knowledge base.</p>

                                <div class="space-y-4">
                                    <div>
                                        <h3 class="text-lg font-medium text-gray-700">Bulk Product Import</h3>
                                        <p class="text-sm text-gray-500 mb-2">This will ingest all active products from
                                            the database.</p>
                                        <button type="button" id="ingest-all-products"
                                            class="px-4 py-2 bg-purple-600 text-white rounded-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                                            <i class="fas fa-database mr-2"></i> Import All Products
                                        </button>
                                    </div>

                                    <div class="border-t border-gray-200 pt-4">
                                        <h3 class="text-lg font-medium text-gray-700">Single Product Import</h3>
                                        <p class="text-sm text-gray-500 mb-2">Ingest a specific product by its ID.</p>
                                        <div class="flex space-x-4">
                                            <input type="number" id="product-id" name="productId"
                                                placeholder="Product ID" required
                                                class="flex-1 px-4 py-2 border border-gray-300 rounded-md focus:ring-purple-500 focus:border-purple-500">
                                            <button type="button" id="ingest-product"
                                                class="px-4 py-2 bg-purple-600 text-white rounded-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2">
                                                <i class="fas fa-plus mr-2"></i> Import Product
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div id="product-result" class="mt-4 hidden"></div>
                            </div>

                            <!-- Status Panel -->
                            <div class="bg-white rounded-lg shadow-md p-6">
                                <h2 class="text-xl font-semibold mb-4 flex items-center text-gray-800">
                                    <i class="fas fa-info-circle mr-2"></i> System Status
                                </h2>
                                <div class="space-y-4">
                                    <div class="p-4 bg-gray-50 rounded-lg border-l-4 border-green-500">
                                        <h3 class="font-medium text-gray-700 flex items-center">
                                            <i class="fas fa-check-circle text-green-500 mr-2"></i> RAG System Status
                                        </h3>
                                        <p class="text-gray-600 mt-1">
                                            The RAG system is <span class="text-green-600 font-semibold">Active</span>
                                            and processing user queries
                                        </p>
                                    </div>

                                    <div class="p-4 bg-gray-50 rounded-lg border-l-4 border-blue-500">
                                        <h3 class="font-medium text-gray-700 flex items-center">
                                            <i class="fas fa-database text-blue-500 mr-2"></i> Vector Database
                                        </h3>
                                        <p class="text-gray-600 mt-1">
                                            Using <span class="text-blue-600 font-semibold">FAISS Vector Database</span>
                                            (in-memory mode)
                                        </p>
                                        <div class="mt-2 text-sm text-gray-500">
                                            <div class="flex items-center">
                                                <i class="fas fa-file-alt mr-1"></i> Total documents: ${totalDocuments
                                                != null ? totalDocuments : 'Not available'}
                                            </div>
                                            <div class="flex items-center mt-1">
                                                <i class="fas fa-vector-square mr-1"></i> Vector dimensions: 768
                                            </div>
                                        </div>
                                    </div>

                                    <div class="p-4 bg-gray-50 rounded-lg border-l-4 border-purple-500">
                                        <h3 class="font-medium text-gray-700 flex items-center">
                                            <i class="fas fa-brain text-purple-500 mr-2"></i> AI Model
                                        </h3>
                                        <p class="text-gray-600 mt-1">
                                            Using <span class="text-purple-600 font-semibold">Gemini 2.0 Flash</span>
                                            for natural language processing
                                        </p>
                                        <p class="mt-1 text-sm text-gray-500">
                                            API Status: <span class="text-green-600 font-medium">Connected</span>
                                        </p>
                                    </div>

                                    <div class="p-4 bg-gray-50 rounded-lg border-l-4 border-gray-400">
                                        <h3 class="font-medium text-gray-700 flex items-center">
                                            <i class="fas fa-lightbulb text-yellow-500 mr-2"></i> About RAG System
                                        </h3>
                                        <p class="text-gray-600 mt-1 text-sm leading-relaxed">
                                            RAG (Retrieval-Augmented Generation) combines search capabilities with
                                            generative AI.
                                            The system first converts your query into a vector and searches for relevant
                                            documents.
                                            Then, it uses those documents to provide accurate, knowledge-grounded
                                            responses.
                                            This approach significantly reduces hallucinations and improves accuracy.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script>
                        $(document).ready(function () {
                            // CSRF token setup for AJAX
                            const csrfToken = $("meta[name='_csrf']").attr("content");
                            const csrfHeader = $("meta[name='_csrf_header']").attr("content");

                            $.ajaxSetup({
                                beforeSend: function (xhr) {
                                    if (csrfHeader && csrfToken) {
                                        xhr.setRequestHeader(csrfHeader, csrfToken);
                                    }
                                }
                            });

                            // Document ingestion
                            $("#ingest-document").click(function () {
                                const title = $("#doc-title").val();
                                const type = $("#doc-type").val();
                                const text = $("#doc-content").val();

                                if (!title || !type || !text) {
                                    showResult("#document-result", "Please fill in all fields", "error");
                                    return;
                                }

                                showResult("#document-result", "Processing...", "info");

                                $.ajax({
                                    url: contextPath + "/admin/chatbot/ingest/document",
                                    type: "POST",
                                    data: {
                                        title: title,
                                        type: type,
                                        text: text
                                    },
                                    success: function (response) {
                                        if (response.success) {
                                            showResult("#document-result", response.message, "success");
                                        } else {
                                            showResult("#document-result", response.message, "error");
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        showResult("#document-result", "Error: " + error, "error");
                                    }
                                });
                            });

                            // Chunked document ingestion
                            $("#ingest-chunked").click(function () {
                                const title = $("#chunked-title").val();
                                const type = $("#chunked-type").val();
                                const text = $("#chunked-content").val();
                                const chunkSize = $("#chunk-size").val();
                                const overlap = $("#chunk-overlap").val();

                                if (!title || !type || !text || !chunkSize || !overlap) {
                                    showResult("#chunked-result", "Please fill in all fields", "error");
                                    return;
                                }

                                showResult("#chunked-result", "Processing...", "info");

                                $.ajax({
                                    url: contextPath + "/admin/chatbot/ingest/chunked",
                                    type: "POST",
                                    data: {
                                        title: title,
                                        type: type,
                                        text: text,
                                        chunkSize: chunkSize,
                                        overlap: overlap
                                    },
                                    success: function (response) {
                                        if (response.success) {
                                            showResult("#chunked-result", response.message, "success");
                                        } else {
                                            showResult("#chunked-result", response.message, "error");
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        showResult("#chunked-result", "Error: " + error, "error");
                                    }
                                });
                            });

                            // Bulk product ingestion
                            $("#ingest-all-products").click(function () {
                                showResult("#product-result", "Starting product ingestion...", "info");

                                $.ajax({
                                    url: contextPath + "/admin/chatbot/ingest/products",
                                    type: "POST",
                                    success: function (response) {
                                        if (response.success) {
                                            showResult("#product-result", response.message, "success");
                                        } else {
                                            showResult("#product-result", response.message, "error");
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        showResult("#product-result", "Error: " + error, "error");
                                    }
                                });
                            });

                            // Single product ingestion
                            $("#ingest-product").click(function () {
                                const productId = $("#product-id").val();

                                if (!productId) {
                                    showResult("#product-result", "Please enter a product ID", "error");
                                    return;
                                }

                                showResult("#product-result", "Ingesting product " + productId + "...", "info");

                                $.ajax({
                                    url: contextPath + "/admin/chatbot/ingest/product/" + productId,
                                    type: "POST",
                                    success: function (response) {
                                        if (response.success) {
                                            showResult("#product-result", response.message, "success");
                                        } else {
                                            showResult("#product-result", response.message, "error");
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        showResult("#product-result", "Error: " + error, "error");
                                    }
                                });
                            });

                            // Helper function to show result messages
                            function showResult(elementId, message, type) {
                                const element = $(elementId);
                                element.removeClass("hidden bg-green-100 bg-red-100 bg-blue-100");

                                if (type === "success") {
                                    element.addClass("bg-green-100 text-green-800");
                                    element.html('<i class="fas fa-check-circle mr-2"></i>' + message);
                                } else if (type === "error") {
                                    element.addClass("bg-red-100 text-red-800");
                                    element.html('<i class="fas fa-exclamation-circle mr-2"></i>' + message);
                                } else if (type === "info") {
                                    element.addClass("bg-blue-100 text-blue-800");
                                    element.html('<i class="fas fa-info-circle mr-2"></i>' + message);
                                }

                                element.removeClass("hidden");
                                element.addClass("p-4 rounded-md");
                            }
                        });
                    </script>
                </body>

                </html>