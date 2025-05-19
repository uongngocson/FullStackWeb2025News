package local.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Inventory;
import local.example.demo.repository.InventoryRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InventoryService {

    private final InventoryRepository inventoryRepository;

    public List<Inventory> getAllInventories() {
        return inventoryRepository.findAll();
    }

    public Inventory getInventoryById(Integer id) {
        return inventoryRepository.findById(id).orElse(null);
    }
}
