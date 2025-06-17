ALTER PROCEDURE dbo.usp_CreateOrderFull        
    -- Input Parameters        
    @customer_id INT,        
    @payment_id INT,       
    @TotalAmount DECIMAL(15, 2), -- Đã chuyển thành tham số đầu vào      
    @OrderItems dbo.OrderDetailType READONLY, -- Sử dụng TVP đã tạo        
          
    -- Address parameters      
    @AddressId INT = NULL,      
    @recipient_name NVARCHAR(100) = NULL,      
    @recipient_phone NCHAR(15) = NULL,      
    @Street NVARCHAR(100) = NULL,      
    @ProvinceId INT = NULL,      
    @DistrictId INT = NULL,      
    @WardId INT = NULL,      
    @Country NVARCHAR(50) = NULL,      
    @ProductVariantIds NVARCHAR(MAX) = NULL, -- Comma-separated list of product_variant_ids      
        
    -- Output Parameters        
    @new_order_id CHAR(10) OUTPUT,       -- Trả về mã đơn hàng mới nếu thành công        
    @ErrorCode INT OUTPUT,               -- Mã lỗi (0: Thành công, <0: Lỗi)        
    @ErrorMessage NVARCHAR(500) OUTPUT   -- Thông báo lỗi chi tiết        
AS        
BEGIN        
    -- Tối ưu hiệu năng, không trả về số dòng bị ảnh hưởng        
    SET NOCOUNT ON;        
        
    -- Khởi tạo Output Parameters        
    SET @new_order_id = NULL;        
    SET @ErrorCode = 0;        
    SET @ErrorMessage = N'Đơn hàng đã được tạo thành công.';        
        
    -- Khai báo biến cục bộ        
    DECLARE @GeneratedOrderID CHAR(10);        
    DECLARE @CurrentProductVariantID INT;        
    DECLARE @CurrentQuantity INT;        
    DECLARE @CurrentPrice DECIMAL(10, 2);        
    DECLARE @AvailableStock INT;        
    DECLARE @shipping_address_id INT; -- Biến để lưu address_id lấy từ bảng Addresses        
    DECLARE @cart_id INT; -- Biến để lưu cart_id của customer      
          
    -- Variables for Address update success tracking      
    DECLARE @AddressUpdateSuccess BIT = 1;      
    DECLARE @AddressUpdateMessage NVARCHAR(4000);      
      
    -- Bắt đầu Transaction để đảm bảo tính toàn vẹn        
    BEGIN TRY        
        BEGIN TRANSACTION;        
        
        -- === VALIDATION ===        
        
        -- 1. Kiểm tra Customer tồn tại        
        IF NOT EXISTS (SELECT 1 FROM dbo.Customers WHERE customer_id = @customer_id AND [status] = 1)        
        BEGIN        
            SET @ErrorCode = -1;        
            SET @ErrorMessage = N'Lỗi: Khách hàng không tồn tại hoặc không hoạt động.';        
            RAISERROR(@ErrorMessage, 16, 1); -- Ném lỗi để nhảy vào CATCH        
        END        
              
        -- 2. Xử lý địa chỉ giao hàng      
        -- Nếu có tham số địa chỉ đầy đủ, cập nhật hoặc thêm mới địa chỉ      
        IF @AddressId IS NOT NULL AND @recipient_name IS NOT NULL AND @recipient_phone IS NOT NULL       
           AND @Street IS NOT NULL AND @ProvinceId IS NOT NULL AND @DistrictId IS NOT NULL       
           AND @WardId IS NOT NULL AND @Country IS NOT NULL      
        BEGIN      
            -- Cập nhật hoặc thêm mới địa chỉ      
            MERGE [dbo].[Address] WITH (HOLDLOCK) AS target      
            USING (SELECT @AddressId AS address_id) AS source      
            ON (target.address_id = source.address_id)      
            WHEN MATCHED THEN      
                UPDATE SET       
                    customer_id = @customer_id,      
                    street = @Street,      
                    ward_id = @WardId,      
                    district_id = @DistrictId,      
                    province_id = @ProvinceId,      
                    country = @Country,      
                    recipient_name = @recipient_name,      
                    recipient_phone = @recipient_phone      
            WHEN NOT MATCHED THEN      
                INSERT (address_id, customer_id, street, ward_id, district_id, province_id, country, recipient_name, recipient_phone)      
                VALUES (@AddressId, @customer_id, @Street, @WardId, @DistrictId, @ProvinceId, @Country, @recipient_name, @recipient_phone);      
                  
            -- Sử dụng address_id từ tham số      
            SET @shipping_address_id = @AddressId;      
        END      
        ELSE      
        BEGIN      
            -- Nếu không có tham số địa chỉ đầy đủ, lấy địa chỉ từ bảng Addresses như trước      
            SELECT TOP 1 @shipping_address_id = address_id        
            FROM dbo.Addresses        
            WHERE customer_id = @customer_id        
            ORDER BY address_id;      
                  
            -- Kiểm tra nếu không tìm thấy địa chỉ        
            IF @shipping_address_id IS NULL        
            BEGIN        
                SET @ErrorCode = -2;        
                SET @ErrorMessage = N'Lỗi: Không tìm thấy địa chỉ giao hàng hợp lệ cho khách hàng này.';        
                RAISERROR(@ErrorMessage, 16, 1);        
            END      
        END      
        
        -- 3. Kiểm tra Payment Method tồn tại        
        IF NOT EXISTS (SELECT 1 FROM dbo.Payments WHERE payment_id = @payment_id)        
        BEGIN        
            SET @ErrorCode = -3;        
            SET @ErrorMessage = N'Lỗi: Phương thức thanh toán không tồn tại.';        
            RAISERROR(@ErrorMessage, 16, 1);        
        END        
        
        -- 4. Kiểm tra danh sách sản phẩm đầu vào có rỗng không        
        IF NOT EXISTS (SELECT 1 FROM @OrderItems)        
        BEGIN        
            SET @ErrorCode = -4;        
            SET @ErrorMessage = N'Lỗi: Đơn hàng phải có ít nhất một sản phẩm.';        
            RAISERROR(@ErrorMessage, 16, 1);        
        END        
        
        -- 5. Kiểm tra từng sản phẩm trong danh sách đầu vào        
        -- Tạo bảng tạm để lưu giá và kiểm tra tồn kho một lần cho hiệu quả        
        DECLARE @ValidatedItems TABLE (        
            product_variant_id INT PRIMARY KEY,        
            quantity INT NOT NULL,        
            price DECIMAL(10, 2) NOT NULL,        
            product_id INT NOT NULL,        
            current_stock INT NOT NULL        
        );        
        
        INSERT INTO @ValidatedItems (product_variant_id, quantity, price, product_id, current_stock)        
        SELECT        
            oi.product_variant_id,        
            oi.quantity,        
            p.price, -- Lấy giá từ bảng Products        
            p.product_id,        
            pv.quantity_stock        
        FROM @OrderItems oi        
        INNER JOIN dbo.product_variants pv ON oi.product_variant_id = pv.product_variant_id        
        INNER JOIN dbo.Products p ON pv.product_id = p.product_id        
        
        -- Kiểm tra xem có sản phẩm nào không hợp lệ (không tìm thấy hoặc số lượng <= 0)        
        IF (SELECT COUNT(*) FROM @OrderItems) != (SELECT COUNT(*) FROM @ValidatedItems)        
           OR EXISTS (SELECT 1 FROM @OrderItems WHERE quantity <= 0)        
        BEGIN        
             SET @ErrorCode = -5;        
             SET @ErrorMessage = N'Lỗi: Một hoặc nhiều sản phẩm không hợp lệ, không tồn tại, hoặc số lượng đặt hàng <= 0.';        
             RAISERROR(@ErrorMessage, 16, 1);        
        END        
        
        -- 6. (Optional but Recommended) Kiểm tra tồn kho        
        IF EXISTS (SELECT 1 FROM @ValidatedItems WHERE quantity > current_stock)        
        BEGIN        
            DECLARE @OutOfStockItem INT = (SELECT TOP 1 product_variant_id FROM @ValidatedItems WHERE quantity > current_stock);        
            SET @ErrorCode = -6;        
            SET @ErrorMessage = CONCAT(N'Lỗi: Sản phẩm variant ID ', @OutOfStockItem, N' không đủ số lượng tồn kho.');        
            RAISERROR(@ErrorMessage, 16, 1);        
        END        
        
        -- === PROCESSING ===        
        
        -- 1. Tạo Order ID duy nhất (Ví dụ: 'OR' + 8 số từ Sequence)        
        SET @GeneratedOrderID = CONCAT('OR', FORMAT(NEXT VALUE FOR dbo.OrderSequence, '00000000')); -- Sinh mã 10 ký tự        
        
        -- 2. Không cần tính tổng tiền đơn hàng nữa vì đã nhận từ tham số @TotalAmount      
        
        -- 3. Insert vào bảng Orders        
        INSERT INTO dbo.Orders (        
            order_id,        
            customer_id,        
            order_date,         -- Mặc định là thời gian hiện tại khi insert        
            total_amount,        
            order_status,       -- Trạng thái ban đầu, ví dụ: 'Pending' hoặc 'Processing'        
            shipping_address_id,        
            payment_id,        
            payment_status      -- Trạng thái thanh toán ban đầu, ví dụ: 0 (Chưa thanh toán)        
        )        
        VALUES (        
            @GeneratedOrderID,        
            @customer_id,        
            GETDATE(),          -- Lấy ngày giờ hiện tại        
            @TotalAmount,       -- Sử dụng tham số đầu vào       
            N'PENDING',         -- Hoặc 'Processing' tùy quy trình của bạn        
            @shipping_address_id,        
            @payment_id,        
            0                   -- Mặc định là chưa thanh toán        
        );        
        
        -- 4. Insert vào bảng order_details        
        INSERT INTO dbo.order_details (        
            order_id,        
            product_variant_id,        
            quantity,        
            price               -- Lưu giá tại thời điểm đặt hàng        
        )        
        SELECT        
            @GeneratedOrderID,        
            vi.product_variant_id,        
            vi.quantity,        
            vi.price            -- Lấy giá đã xác thực từ bảng tạm        
        FROM @ValidatedItems vi;        
        
        -- 5. Cập nhật số lượng tồn kho        
        UPDATE pv        
        SET pv.quantity_stock = pv.quantity_stock - vi.quantity        
        FROM dbo.product_variants pv        
        INNER JOIN @ValidatedItems vi ON pv.product_variant_id = vi.product_variant_id;        
        
        -- Cập nhật số lượng đã bán trong bảng Products (tùy chọn)        
        UPDATE p        
        SET p.quantity_sold = ISNULL(p.quantity_sold, 0) + vi.quantity        
        FROM dbo.Products p        
        INNER JOIN @ValidatedItems vi ON p.product_id = vi.product_id;        
              
        -- 6. Xử lý mã giảm giá nếu có @ProductVariantIds      
        IF @ProductVariantIds IS NOT NULL AND LEN(@ProductVariantIds) > 0      
        BEGIN      
            -- Sử dụng STRING_SPLIT nếu SQL Server 2016+ hoặc fallback cho phiên bản trước đó      
            IF OBJECT_ID('sys.string_split') IS NOT NULL      
            BEGIN      
                UPDATE adc      
                SET status = 'used',      
                    used_at = GETDATE()      
                FROM [dbo].[Account_Discount_Codes] adc      
                INNER JOIN STRING_SPLIT(@ProductVariantIds, ',') s       
                    ON adc.product_variant_id = TRY_CAST(LTRIM(RTRIM(s.value)) AS INT)      
                WHERE adc.customer_id = @customer_id      
                AND adc.status = 'available'      
                AND TRY_CAST(LTRIM(RTRIM(s.value)) AS INT) IS NOT NULL;      
            END      
            ELSE -- Cho SQL Server phiên bản trước 2016      
            BEGIN      
                -- Tạo bảng tạm với clustered index để tăng hiệu suất      
                CREATE TABLE #TempProductVariantIds       
                (      
                    product_variant_id INT NOT NULL PRIMARY KEY CLUSTERED      
                );      
                      
                -- Phương pháp phân tích XML nhanh      
                INSERT INTO #TempProductVariantIds (product_variant_id)      
                SELECT CAST(LTRIM(RTRIM(x.value)) AS INT)      
                FROM (      
                    SELECT [value] = N.c.value('.[1]', 'nvarchar(50)')      
                    FROM (SELECT CAST('<i>' + REPLACE(@ProductVariantIds, ',', '</i><i>') + '</i>' AS XML) AS X) AS T      
                    CROSS APPLY X.nodes('/i') AS N(c)      
                ) AS x      
                WHERE ISNUMERIC(LTRIM(RTRIM(x.value))) = 1;      
                
                -- Cập nhật với join tối ưu      
                UPDATE adc      
                SET status = 'used',      
                    used_at = GETDATE()      
                FROM [dbo].[Account_Discount_Codes] adc WITH (ROWLOCK)      
                INNER JOIN #TempProductVariantIds t       
                    ON adc.product_variant_id = t.product_variant_id      
                WHERE adc.customer_id = @customer_id      
                AND adc.status = 'available';      
                      
             -- Dọn dẹp      
                DROP TABLE #TempProductVariantIds;      
            END      
        END      
      
        -- 7. XÓA các mục trong cart_details sau khi đặt hàng thành công      
        -- Đầu tiên lấy cart_id của customer      
        SELECT @cart_id = cart_id      
        FROM dbo.Carts      
        WHERE customer_id = @customer_id;      
      
        -- Nếu tìm thấy cart_id, xóa các mục trong cart_details      
        IF @cart_id IS NOT NULL      
        BEGIN      
            -- Xóa các sản phẩm trong giỏ hàng mà đã được đặt      
            DELETE cd      
            FROM dbo.cart_details cd      
            INNER JOIN @ValidatedItems vi ON cd.product_variant_id = vi.product_variant_id      
            WHERE cd.cart_id = @cart_id;      
        END      
        
        -- Gán giá trị cho biến output @new_order_id
        SET @new_order_id = @GeneratedOrderID;
        
        -- Nếu mọi thứ thành công, commit transaction        
        COMMIT TRANSACTION;        
        
        -- Gán giá trị cho output parameters (đã gán @new_order_id trước khi commit)
        -- ErrorCode và ErrorMessage đã được set mặc định là thành công        
        
    END TRY        
    BEGIN CATCH        
        -- Nếu có lỗi xảy ra, rollback transaction        
        IF @@TRANCOUNT > 0        
            ROLLBACK TRANSACTION;        
        
        -- Gán thông tin lỗi cho output parameters        
        -- Nếu lỗi được ném bởi RAISERROR, ErrorCode và ErrorMessage đã được set        
        -- Nếu là lỗi SQL khác, cần lấy thông tin lỗi ở đây        
        IF @ErrorCode = 0 -- Chỉ ghi đè nếu chưa được set bởi RAISERROR        
        BEGIN        
            SET @ErrorCode = ERROR_NUMBER(); -- Hoặc mã lỗi tùy chỉnh khác        
            SET @ErrorMessage = N'Lỗi hệ thống: ' + ERROR_MESSAGE();        
        END        
        SET @new_order_id = NULL;        
        
        -- (Optional) Ghi log lỗi vào một bảng riêng        
        -- INSERT INTO dbo.ErrorLog (ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine, LogTime)        
        -- VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_PROCEDURE(), ERROR_LINE(), GETDATE());        
        
    END CATCH        
        
    -- Luôn trả về mã lỗi và thông báo (gồm cả order_id nếu thành công)
    SELECT @ErrorCode AS ErrorCode, @ErrorMessage AS ErrorMessage, @new_order_id AS NewOrderID;        
        
END; 