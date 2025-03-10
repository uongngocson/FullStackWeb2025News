package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductManagementController {

        @GetMapping("/admin/product/list")
        public String getProductManagementPage(Model model) {
                List<Product> products = new ArrayList<>();
                products.add(
                                new Product(1, "Laptop Dell XPS", "Electronics", "Intel i7", "High-performance laptop",
                                                1200.99, 10));
                products.add(new Product(2, "iPhone 15", "Mobile", "A16 Bionic", "Latest Apple iPhone", 999.99, 5));
                products.add(new Product(3, "Samsung Galaxy S23", "Mobile", "Snapdragon 8 Gen 2",
                                "Flagship Samsung phone",
                                899.99, 8));
                products.add(new Product(4, "Sony WH-1000XM5", "Accessories", "Noise Cancelling",
                                "Premium noise-canceling headphones", 349.99, 15));
                products.add(
                                new Product(5, "MacBook Air M2", "Electronics", "Apple M2", "Lightweight Apple laptop",
                                                1099.99, 12));

                for (Product product : products) {
                        System.out.println(product);
                }

                return "admin/manageProduct/manageproduct";
        }

        @GetMapping("/admin/product/list/all")
        public String getDashboardPageAllProduct(Model model) {
                return "admin/manageProduct/allproduct";
        }

        @GetMapping("/admin/product/list/all/menstyle")
        public String getDashboardPageMen(Model model) {
                return "admin/manageProduct/fashionMen/modelone";
        }

        // nhập loại sản phẩm

        @GetMapping("/admin/product/import")
        public String importProductType(Model model) {
                return "admin/manageProduct/nhaploaisp/importproduct";
        }

}
