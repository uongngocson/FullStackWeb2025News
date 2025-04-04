<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <div class="container-fluid">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">
                            <c:choose>
                                <c:when test="${not empty order.orderId}">Edit Order</c:when>
                                <c:otherwise>Create New Order</c:otherwise>
                            </c:choose>
                        </h6>
                    </div>
                    <div class="card-body">
                        <form action="/admin/orders/save" method="post">
                            <input type="hidden" name="orderId" value="${order.orderId}">

                            <div class="form-group">
                                <label>Customer</label>
                                <select name="customer.customerId" class="form-control" required>
                                    <option value="">Select Customer</option>
                                    <c:forEach items="${customers}" var="customer">
                                        <option value="${customer.customerId}" <c:if
                                            test="${order.customer.customerId == customer.customerId}">selected</c:if>>
                                            ${customer.customerName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Order Date</label>
                                <input type="datetime-local" name="orderDate" class="form-control"
                                    value="<fmt:formatDate value='${order.orderDate}' pattern='yyyy-MM-dd''T'HH:mm' />"
                                    required>
                            </div>

                            <div class="form-group">
                                <label>Expected Delivery Date</label>
                                <input type="date" name="expectedDeliveryDate" class="form-control"
                                    value="<fmt:formatDate value='${order.expectedDeliveryDate}' pattern='yyyy-MM-dd' />">
                            </div>

                            <div class="form-group">
                                <label>Total Amount</label>
                                <input type="number" step="0.01" name="totalAmount" class="form-control"
                                    value="${order.totalAmount}" required>
                            </div>

                            <div class="form-group">
                                <label>Order Status</label>
                                <select name="orderStatus" class="form-control" required>
                                    <option value="Pending" <c:if test="${order.orderStatus == 'Pending'}">selected
                                        </c:if>>Pending</option>
                                    <option value="Processing" <c:if test="${order.orderStatus == 'Processing'}">
                                        selected</c:if>>Processing</option>
                                    <option value="Shipped" <c:if test="${order.orderStatus == 'Shipped'}">selected
                                        </c:if>>Shipped</option>
                                    <option value="Delivered" <c:if test="${order.orderStatus == 'Delivered'}">selected
                                        </c:if>>Delivered</option>
                                    <option value="Cancelled" <c:if test="${order.orderStatus == 'Cancelled'}">selected
                                        </c:if>>Cancelled</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Save</button>
                            <a href="/admin/orders" class="btn btn-secondary">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>

            <jsp:include page="../layout/footer.jsp" />