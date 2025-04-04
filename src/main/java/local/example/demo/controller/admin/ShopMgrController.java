package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Shop;
import local.example.demo.service.ShopService;

@Controller
@RequestMapping("/shop-mgr/")
public class ShopMgrController {
    // Injecting the ShopService to handle shop-related operations
    @Autowired
    private final ShopService shopService;

    public ShopMgrController(ShopService shopService) {
        this.shopService = shopService;
    }

    @GetMapping("ui")
    public String getUI(Model model) {
        List<Shop> shops = shopService.findAllShops();
        model.addAttribute("shops", shops);
        return "admin/shop-mgr/all-shop2";
    }

    // Example method to get the list of shops
    @GetMapping("list")
    public String getShopList(Model model) {
        List<Shop> shops = shopService.findAllShops();
        model.addAttribute("shops", shops);
        return "admin/shop-mgr/all-shops";
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
            return "redirect:/shop-mgr/list";
        }
        model.addAttribute("shop", shop);
        return "admin/shop-mgr/form-shop";
    }

    // Example method to handle the creation of a new shop
    @PostMapping("save")
    public String saveShop(@ModelAttribute("shop") @Valid Shop shop, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "admin/shop-mgr/form-shop";
        }
        // Save the shop to the database
        shopService.saveShop(shop);
        return "redirect:/shop-mgr/list";
    }

    // delete the shop
    @RequestMapping("delete/{shopId}")
    public String deleteShop(@PathVariable("shopId") Integer shopId) {
        shopService.deleteShopById(shopId);
        return "redirect:/shop-mgr/list";
    }

}
