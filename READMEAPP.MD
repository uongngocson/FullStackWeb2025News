# Lấy 20 đơn CONFIRMED đầu tiên
GET /api/shipper/orders/confirmed

# Lấy trang 2, mỗi trang 10 đơn
GET /api/shipper/orders/confirmed?page=1&size=10

# Sắp xếp theo tổng tiền giảm dần
GET /api/shipper/orders/confirmed?sortBy=totalAmount&sortDirection=DESC

# Lấy trang 3, sắp xếp theo ngày mới nhất
GET /api/shipper/orders/confirmed?page=2&size=15&sortBy=orderDate&sortDirection=DESC

🎯 API Endpoints Provided:
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/shipper/orders | Get all orders grouped by status (equivalent to all-orders.jsp) |
| GET | /api/shipper/orders/paginated | Get orders with pagination and filtering |
| GET | /api/shipper/orders/{orderId} | Get detailed order information (equivalent to detail-order.jsp) |
| GET | /api/shipper/orders/status/{status} | Get orders filtered by specific status |
| PUT | /api/shipper/orders/{orderId}/status | Update order status and payment status |
| GET | /api/shipper/orders/statistics | Get order statistics summary |

// 1. Lấy đơn hàng CONFIRMED
GET /api/shipper/orders/confirmed?page=0&size=20

// 2. Tạo shipment
POST /api/shipper/orders/ORD123/create-shipment?shipperId=1

// 3. Lấy shipments của shipper
GET /api/shipper/orders/shipments?shipperId=1

// 4. Cập nhật trạng thái
PUT /api/shipper/orders/shipments/1/status?shipperId=1
{
  "status": "COMPLETED",
  "paymentStatus": "PAID"
}

// 5. Nộp COD
POST /api/shipper/orders/cod/1/submit
{
  "paymentMethod": "CASH"
}