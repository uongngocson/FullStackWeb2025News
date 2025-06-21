# FullStackWeb2025News - Tài liệu Dự án

## Tổng quan

Dự án FullStackWeb2025News là một ứng dụng web thương mại điện tử (e-commerce) được xây dựng bằng Spring Boot. Dự án này triển khai một nền tảng bán hàng trực tuyến hoàn chỉnh với nhiều tính năng như quản lý sản phẩm, giỏ hàng, đơn hàng, thanh toán và nhiều tính năng khác.

## Công nghệ sử dụng

### Backend
- **Java 21**: Ngôn ngữ lập trình chính
- **Spring Boot 3.2.3**: Framework chính để xây dựng ứng dụng
- **Spring Data JPA**: Tương tác với cơ sở dữ liệu
- **Spring Security**: Xác thực và phân quyền người dùng
- **Spring MVC**: Xây dựng các REST API và controller
- **SQL Server**: Hệ quản trị cơ sở dữ liệu

### Frontend
- **JSP (Jakarta Server Pages)**: Hiển thị giao diện người dùng
- **JSTL**: Thư viện thẻ cho JSP
- **Bootstrap**: Framework CSS cho giao diện

### Thanh toán
- **VNPay**: Cổng thanh toán trực tuyến Việt Nam
- **MoMo**: Cổng thanh toán ví điện tử

### Tích hợp
- **AWS S3**: Lưu trữ hình ảnh và tài liệu
- **Google OAuth2**: Đăng nhập bằng tài khoản Google
- **Facebook API**: Đăng nhập bằng tài khoản Facebook
- **Google Gemini (Vertex AI)**: Tích hợp AI cho các tính năng thông minh

## Cấu trúc dự án

### Cấu trúc thư mục
```
src/
├── main/
│   ├── java/
│   │   └── local/
│   │       └── example/
│   │           └── demo/
│   │               ├── config/          # Cấu hình ứng dụng
│   │               ├── controller/      # Xử lý request từ client
│   │               ├── exception/       # Xử lý ngoại lệ
│   │               ├── model/           # Định nghĩa các model
│   │               │   ├── dto/         # Data Transfer Objects
│   │               │   └── entity/      # Entity classes
│   │               ├── repository/      # Tương tác với cơ sở dữ liệu
│   │               ├── service/         # Logic nghiệp vụ
│   │               ├── util/            # Các tiện ích
│   │               └── validator/       # Kiểm tra tính hợp lệ của dữ liệu
│   ├── resources/                       # Tài nguyên tĩnh
│   └── webapp/                          # Giao diện người dùng (JSP)
└── test/                                # Unit tests
```

## Mô hình dữ liệu

Dự án sử dụng một số lượng lớn các entity để xây dựng một hệ thống e-commerce đầy đủ:

### Người dùng và Xác thực
- **Account**: Thông tin tài khoản người dùng
- **Customer**: Thông tin khách hàng
- **Employee**: Thông tin nhân viên
- **Role**: Vai trò người dùng (Admin, Employee, Customer)
- **Address**: Địa chỉ giao hàng

### Sản phẩm
- **Product**: Thông tin sản phẩm
- **ProductVariant**: Biến thể sản phẩm (kích thước, màu sắc)
- **ProductImage**: Hình ảnh sản phẩm
- **Brand**: Thương hiệu
- **Category**: Danh mục sản phẩm
- **Size**: Kích thước
- **Color**: Màu sắc
- **Supplier**: Nhà cung cấp
- **Inventory**: Quản lý tồn kho

### Mua hàng
- **Cart**: Giỏ hàng
- **CartDetail**: Chi tiết giỏ hàng
- **Order**: Đơn hàng
- **OrderDetail**: Chi tiết đơn hàng
- **Payment**: Thanh toán
- **Shipment**: Vận chuyển
- **Return**: Trả hàng
- **Review**: Đánh giá sản phẩm

### Khuyến mãi
- **Discount**: Mã giảm giá
- **ProductDiscount**: Giảm giá sản phẩm
- **AccountDiscountCode**: Mã giảm giá của tài khoản

### Nhập hàng
- **PurchaseReceipt**: Phiếu nhập hàng
- **PurchaseReceiptDetail**: Chi tiết phiếu nhập hàng

### Vận chuyển
- **GHNProvince**: Tỉnh/Thành phố (GHN)
- **GHNDistrict**: Quận/Huyện (GHN)
- **GHNWard**: Phường/Xã (GHN)

## Các tính năng chính

### Dành cho khách hàng
1. **Đăng ký và đăng nhập**:
   - Đăng ký tài khoản mới
   - Đăng nhập bằng email/mật khẩu
   - Đăng nhập bằng Google, Facebook
   - Quên mật khẩu

2. **Mua sắm**:
   - Xem danh sách sản phẩm
   - Tìm kiếm sản phẩm
   - Lọc theo danh mục, thương hiệu, giá, v.v.
   - Xem chi tiết sản phẩm
   - Thêm vào giỏ hàng

3. **Giỏ hàng và thanh toán**:
   - Quản lý giỏ hàng
   - Áp dụng mã giảm giá
   - Chọn phương thức thanh toán (VNPay, MoMo, COD)
   - Chọn địa chỉ giao hàng

4. **Quản lý đơn hàng**:
   - Xem lịch sử đơn hàng
   - Theo dõi trạng thái đơn hàng
   - Hủy đơn hàng
   - Trả hàng/hoàn tiền

5. **Đánh giá sản phẩm**:
   - Đánh giá và viết nhận xét
   - Xem đánh giá của người khác

### Dành cho nhân viên
1. **Quản lý sản phẩm**:
   - Thêm/sửa/xóa sản phẩm
   - Quản lý tồn kho
   - Nhập hàng từ nhà cung cấp

2. **Quản lý đơn hàng**:
   - Xem tất cả đơn hàng
   - Cập nhật trạng thái đơn hàng
   - Xử lý đơn trả hàng/hoàn tiền

3. **Quản lý khách hàng**:
   - Xem danh sách khách hàng
   - Hỗ trợ khách hàng

### Dành cho admin
1. **Quản lý hệ thống**:
   - Quản lý tài khoản nhân viên
   - Phân quyền người dùng
   - Xem báo cáo, thống kê

2. **Quản lý khuyến mãi**:
   - Tạo mã giảm giá
   - Thiết lập chương trình khuyến mãi

## Công nghệ nổi bật

### Spring Boot
- **Dependency Injection**: Quản lý các dependency
- **Auto-configuration**: Tự động cấu hình các thành phần
- **Spring Data JPA**: Tương tác với cơ sở dữ liệu
- **Spring Security**: Xác thực và phân quyền
- **Spring MVC**: Xây dựng các REST API

### Cơ sở dữ liệu
- **JPA/Hibernate**: ORM (Object-Relational Mapping)
- **SQL Server**: Lưu trữ dữ liệu
- **Spring Session JDBC**: Quản lý session

### Bảo mật
- **Spring Security**: Xác thực và phân quyền
- **OAuth2**: Đăng nhập bằng Google, Facebook
- **JWT**: JSON Web Token (nếu có API)

### Thanh toán
- **VNPay**: Cổng thanh toán trực tuyến
- **MoMo**: Cổng thanh toán ví điện tử

### Tích hợp
- **AWS S3**: Lưu trữ hình ảnh và tài liệu
- **Google Gemini (Vertex AI)**: Tích hợp AI
- **GHN (Giao Hàng Nhanh)**: Tích hợp vận chuyển

## Kết luận

Dự án FullStackWeb2025News là một ứng dụng web thương mại điện tử đầy đủ tính năng được xây dựng bằng Spring Boot. Dự án này cung cấp một nền tảng bán hàng trực tuyến hoàn chỉnh với các tính năng quản lý sản phẩm, giỏ hàng, đơn hàng, thanh toán và nhiều tính năng khác. Dự án sử dụng nhiều công nghệ hiện đại và tích hợp nhiều dịch vụ bên ngoài để cung cấp trải nghiệm tốt nhất cho người dùng.
