<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DDTS | Search Results</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500;700&display=swap"
        rel="stylesheet">
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <link rel="icon" href="https://image.similarpng.com/file/similarpng/very-thumbnail/2021/01/Fashion-shop-logo-design-on-transparent-background-PNG.png" type="image/x-icon">
</head>

<body>
    <!-- Header -->
    <jsp:include page="../layout/navbar.jsp" />

    <!-- Search Results Content -->
    <main>
        <section class="py-20 max-w-7xl mx-auto px-6">
            <!-- Search Results Container - This will be updated via AJAX -->
            <div class="search-results-container">
                <c:choose>
                    <c:when test="${empty searchProducts}">
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <spring:message code="search.title" text="Search Results" />
                                <c:if test="${not empty searchKeyword}">
                                    for: "${searchKeyword}"
                                </c:if>
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                            <p class="mt-4">
                                <spring:message code="search.noResults" text="No results found" />
                            </p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                <spring:message code="search.title" text="Search Results" />
                                <c:if test="${not empty searchKeyword}">
                                    for: "${searchKeyword}"
                                </c:if>
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                            <p class="mt-4">
                                <spring:message code="search.found" text="Found" /> 
                                ${searchTotalRecords} 
                                <spring:message code="search.results" text="results" />
                            </p>
                        </div>

                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
                            <c:forEach items="${searchProducts}" var="product">
                                <div class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/e3956afad4ca48a3a33f6ee339a93a31_9366/manchester-united-ubp-tee.jpg'}"
                                            alt="${product.product_name}"
                                            class="product-primary-image w-full h-full object-cover transition-opacity duration-300 ease-in-out group-hover:opacity-0">
                                        <img src="${product.image_url != null ? product.image_url : 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/170eb3f87f1e44c5ac8599ddb9b19969_9366/manchester-united-ubp-tee.jpg'}"
                                            alt="${product.product_name} Hover"
                                            class="product-hover-image absolute inset-0 w-full h-full object-cover opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
                                        
                                        <!-- Quick View Button -->
                                        <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                            <a href="${ctx}/product/detail?id=${product.product_id}"
                                                class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                <spring:message code="product.quickView" text="Quick View" />
                                            </a>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">${product.product_name}</h3>
                                        <p class="text-sm text-gray-600">$${product.price}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${searchTotalRecords > searchPageSize}">
                            <div class="flex justify-center mt-10">
                                <div class="flex items-center space-x-1">
                                    <c:forEach begin="1" end="${Math.ceil(searchTotalRecords / searchPageSize)}" var="i">
                                        <a href="javascript:void(0)" 
                                           onclick="searchPage('${i}', '${searchPageSize}', '${searchKeyword}')"
                                           class="${i == searchCurrentPage ? 'bg-black text-white' : 'bg-white text-black'} px-4 py-2 border hover:bg-gray-200 transition">
                                            ${i}
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="../layout/footer.jsp" />
    
    <script>
        // Global function for pagination
        function searchPage(page, size, keyword) {
            const contextPath = '${pageContext.request.contextPath}';
            const url = new URL(window.location.href);
            url.searchParams.set('keyword', keyword);
            url.searchParams.set('page', page);
            url.searchParams.set('size', size);
            window.history.pushState({}, '', url);
            
            fetch(contextPath + '/api/products/search?keyword=' + encodeURIComponent(keyword) + '&page=' + page + '&size=' + size)
                .then(response => response.json())
                .then(data => {
                    // Get container
                    const searchSection = document.querySelector('.search-results-container');
                    if (!searchSection) return;
                    
                    // Build HTML
                    let searchResultsHTML = `
                        <div class="text-center mb-16">
                            <h2 class="text-3xl font-light mb-4">
                                Search Results for: "${keyword}"
                            </h2>
                            <div class="w-20 h-px bg-black mx-auto"></div>
                            <p class="mt-4">
                                Found ${data.totalRecords} results
                            </p>
                        </div>
                    `;
                    
                    // Add products grid
                    searchResultsHTML += '<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">';
                    
                    if (!data.products || data.products.length === 0) {
                        // No results found
                        searchResultsHTML += `
                            <div class="col-span-4 text-center py-10">
                                <p>No results found</p>
                            </div>
                        `;
                    } else {
                        // Display products
                        data.products.forEach(product => {
                            const imageUrl = product.image_url || 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/e3956afad4ca48a3a33f6ee339a93a31_9366/manchester-united-ubp-tee.jpg';
                            const hoverImageUrl = product.image_url || 'https://assets.adidas.com/images/w_766,h_766,f_auto,q_auto,fl_lossy,c_fill,g_auto/170eb3f87f1e44c5ac8599ddb9b19969_9366/manchester-united-ubp-tee.jpg';
                            
                            searchResultsHTML += `
                                <div class="group border-2 border-transparent hover:border-black transition-colors duration-300 p-2">
                                    <div class="relative overflow-hidden h-96">
                                        <img src="\${imageUrl}"
                                            alt="\${product.product_name}"
                                            class="product-primary-image w-full h-full object-cover transition-opacity duration-300 ease-in-out group-hover:opacity-0">
                                        <img src="\${hoverImageUrl}"
                                            alt="\${product.product_name} Hover"
                                            class="product-hover-image absolute inset-0 w-full h-full object-cover opacity-0 group-hover:opacity-100 transition-opacity duration-300 ease-in-out">
                                        
                                        <!-- Quick View Button -->
                                        <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                                            <a href="\${contextPath}/product/detail?id=\${product.product_id}"
                                                class="bg-white px-6 py-2 text-sm tracking-wider border border-black hover:bg-black hover:text-white transition duration-300">
                                                Quick View
                                            </a>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <h3 class="text-lg font-light">\${product.product_name}</h3>
                                        <p class="text-sm text-gray-600">$\${product.price}</p>
                                    </div>
                                </div>
                            `;
                        });
                    }
                    
                    searchResultsHTML += '</div>';
                    
                    // Add pagination
                    if (data.totalRecords > data.pageSize) {
                        const totalPages = Math.ceil(data.totalRecords / data.pageSize);
                        const currentPage = data.currentPage;
                        
                        searchResultsHTML += `
                            <div class="flex justify-center mt-10">
                                <div class="flex items-center space-x-1">
                        `;
                        
                        for (let i = 1; i <= totalPages; i++) {
                            const isCurrentPage = i == currentPage;
                            searchResultsHTML += `
                                <a href="javascript:void(0)" 
                                   onclick="searchPage('${i}', '${data.pageSize}', '${keyword}')"
                                   class="${isCurrentPage ? 'bg-black text-white' : 'bg-white text-black'} px-4 py-2 border hover:bg-gray-200 transition">
                                    ${i}
                                </a>
                            `;
                        }
                        
                        searchResultsHTML += `
                                </div>
                            </div>
                        `;
                    }
                    
                    // Update content
                    searchSection.innerHTML = searchResultsHTML;
                })
                .catch(error => {
                    console.error('Error fetching paginated results:', error);
                });
        }
    </script>
</body>
</html> 