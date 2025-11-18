package com.example.assignment_three_zelora.model.service;

import com.example.assignment_three_zelora.model.entitys.Product;
import com.example.assignment_three_zelora.model.repos.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // Existing CRUD Operations:

    // Create
    public Product createProduct(Product product) {
        return productRepository.save(product);
    }

    // Get all
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // Get one
    public Product getProductById(Integer id) {
        return productRepository.findById(id).orElse(null);
    }

    // Update
    public Product updateProduct(Integer id, Product updatedProduct) {
        if (!productRepository.existsById(id)) {
            return null;
        }
        updatedProduct.setProductId(id);
        return productRepository.save(updatedProduct);
    }

    // Delete by id
    public void deleteProduct(Integer id) {
        productRepository.deleteById(id);
    }

    // To Do 1: Multi-Criteria Search Implementation

    /**
     * Implements the multi-criteria product search (To Do 1).
     * Filters products based on name, category, price range, keyword, and recent date.
     */
    public List<Product> searchProducts(String name, String category, Double minPrice, Double maxPrice, String keyword, boolean recent) {
        // Fetch all products to perform in-memory filtering (since we are not using custom JPA queries yet)
        List<Product> products = productRepository.findAll();

        return products.stream()
                .filter(product -> {
                    // 1. Filter by Product Name (partial match, case-insensitive)
                    if (name != null && !name.trim().isEmpty()) {
                        // Using getProductName() to match your entity's getter
                        if (!product.getProductName().toLowerCase().contains(name.trim().toLowerCase())) {
                            return false;
                        }
                    }

                    // 2. Filter by Category
                    if (category != null && !category.trim().isEmpty()) {
                        // FIX: Accessing the Category entity's getName() method via getCategoryId()
                        String productCategory = product.getCategoryId() != null && product.getCategoryId().getCategoryName() != null
                                ? product.getCategoryId().getCategoryName().toLowerCase()
                                : "";

                        if (!productCategory.contains(category.trim().toLowerCase())) {
                            return false;
                        }
                    }

                    // 3. Filter by Price Range
                    if (minPrice != null && product.getPrice() != null && product.getPrice().doubleValue() < minPrice) {
                        return false;
                    }
                    if (maxPrice != null && product.getPrice() != null && product.getPrice().doubleValue() > maxPrice) {
                        return false;
                    }

                    // 4. Filter by Recently Added (Last 7 Days)
                    if (recent) {
                        // Calculate the date 7 days ago
                        Date sevenDaysAgo = new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(7));
                        if (product.getReleaseDate() == null || product.getReleaseDate().before(sevenDaysAgo)) {
                            return false;
                        }
                    }

                    // 5. Filter by Keyword (Checks Description and Material fields)
                    if (keyword != null && !keyword.trim().isEmpty()) {
                        String searchString = keyword.trim().toLowerCase();
                        String description = product.getDescription() != null ? product.getDescription().toLowerCase() : "";

                        // FIX: This now correctly calls getMaterial() which exists in your Product class
                        String material = product.getMaterial() != null ? product.getMaterial().toLowerCase() : "";

                        // The keyword must be found in either the description OR the material
                        if (!description.contains(searchString) && !material.contains(searchString)) {
                            return false;
                        }
                    }

                    return true; // Product passed all criteria
                })
                .collect(Collectors.toList()); // Return the filtered list
    }
}