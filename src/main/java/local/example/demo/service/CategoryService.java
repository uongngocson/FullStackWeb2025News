package local.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import local.example.demo.model.entity.Category;
import local.example.demo.repository.CategoryRepository;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> findAllCategories() {
        return categoryRepository.findAll();
    }

    public Optional<Category> findById(Integer categoryId) {
        return categoryRepository.findById(categoryId);
    }

}
