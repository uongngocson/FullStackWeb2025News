package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Shop;
import local.example.demo.service.FileService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ShopService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("admin/shop-mgr/")
public class ShopMgrController {
    // Injecting the ShopService to handle shop-related operations
    private final ShopService shopService;
    private final ProductService productService;
    private final FileService fileService;

    // Example method to get the list of shops
    @GetMapping("list")
    public String getShopList(Model model) {
        List<Shop> shops = shopService.findAllShops();
        model.addAttribute("shops", shops);
        return "admin/shop-mgr/all-shops";
    }

    // Example method to get the details of a specific shop
    @GetMapping("detail/{shopId}")
    public String getShopDetail(@PathVariable("shopId") Integer shopId, Model model) {
        Shop shop = shopService.findShopById(shopId);
        List<Product> products = productService.findProductsByShopId(shopId);
        if (shop == null) {
            return "redirect:/admin/shop-mgr/list";
        }
        model.addAttribute("products", products);
        model.addAttribute("shop", shop);
        return "admin/shop-mgr/detail-shop";
    }

    // Example method to create a new shop
    @GetMapping("create")
    public String createShop(Model model) {
        model.addAttribute("shop", new Shop());
        return "admin/shop-mgr/form-shop";
    }

    // update the shop
    @GetMapping("update/{shopId}")
    public String updateShop(Model model, @PathVariable("shopId") Integer shopId) {
        Shop shop = shopService.findShopById(shopId);
        if (shop == null) {
            return "redirect:/admin/shop-mgr/list";
        }
        model.addAttribute("shop", shop);
        return "admin/shop-mgr/form-shop";
    }

    // Example method to handle the creation of a new shop
    @PostMapping("save")
    public String saveShop(@ModelAttribute("shop") @Valid Shop shop, BindingResult bindingResult,
            @RequestParam("logoFile") MultipartFile logoFile,
            @RequestParam("coverFile") MultipartFile coverFile) {
        if (bindingResult.hasErrors()) {
            return "admin/shop-mgr/form-shop";
        }

        if (fileService.isValidFile(logoFile) && fileService.isValidFile(coverFile)) {
            String logoPath = fileService.handleSaveUploadFile(logoFile, "shop");
            String coverPath = fileService.handleSaveUploadFile(coverFile, "shop");
            shop.setLogoUrl("resources/images-upload/shop/" + logoPath);
            shop.setCoverImageUrl("resources/images-upload/shop/" + coverPath);
        }

        // Save the shop to the database
        shopService.saveShop(shop);
        return "redirect:/admin/shop-mgr/list";
    }

    // delete the shop
    @RequestMapping("delete/{shopId}")
    public String deleteShop(@PathVariable("shopId") Integer shopId) {
        shopService.deleteShopById(shopId);
        return "redirect:/admin/shop-mgr/list";
    }

}
