<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <div class="container-fluid">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Order Management</h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Customer</th>
                                        <th>Order Date</th>
                                        <th>Total Amount</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr>
                                            <td>${order.orderId}</td>
                                            <td>${order.customer.customerName}</td>
                                            <td>
                                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" type="currency" />
                                            </td>
                                            <td>${order.orderStatus}</td>
                                            <td>
                                                <a href="/admin/orders/edit/${order.orderId}"
                                                    class="btn btn-primary btn-sm">Edit</a>
                                                <a href="/admin/orders/delete/${order.orderId}"
                                                    class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Are you sure?')">Delete</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <a href="/admin/orders/create" class="btn btn-success">Add New Order</a>
                    </div>
                </div>
            </div>

            <jsp:include page="../layout/footer.jsp" />