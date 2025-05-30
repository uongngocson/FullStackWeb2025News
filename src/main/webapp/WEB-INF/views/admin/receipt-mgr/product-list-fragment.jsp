<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <option value="">-- Chọn sản phẩm --</option>
                <c:forEach items="${products}" var="product">
                    <option value="${product.productId}">${product.productName}</option>
                </c:forEach>