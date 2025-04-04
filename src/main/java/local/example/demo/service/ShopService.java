package local.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import local.example.demo.model.entity.Shop;
import local.example.demo.repository.ShopRepository;

@Service
public class ShopService {
    @Autowired
    private final ShopRepository shopRepository;

    public ShopService(ShopRepository shopRepository) {
        this.shopRepository = shopRepository;
    }

    // findby all shop
    @Transactional(readOnly = true)
    public List<Shop> findAllShops() {
        return shopRepository.findAll();
    }

    // find shop by id
    @Transactional(readOnly = true)
    public Shop findShopById(Integer shopId) {
        return shopRepository.findById(shopId).orElse(null);
    }

    // save shop
    @Transactional
    public void saveShop(Shop shop) {
        shopRepository.save(shop);
    }

    // delete shop by id
    @Transactional
    public void deleteShopById(Integer shopId) {
        shopRepository.deleteById(shopId);
    }
}
