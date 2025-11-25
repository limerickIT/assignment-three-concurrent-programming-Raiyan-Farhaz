package com.example.assignment_three_zelora.model.service;

import com.example.assignment_three_zelora.model.entitys.Inventory;
import com.example.assignment_three_zelora.model.entitys.Product;
import com.example.assignment_three_zelora.model.entitys.Review;
import com.example.assignment_three_zelora.model.repos.ProductRepository;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    // CRUD
    public Product createProduct(Product product) { return productRepository.save(product); }
    public List<Product> getAllProducts() { return productRepository.findAll(); }
    public Product getProductById(Integer id) { return productRepository.findById(id).orElse(null); }
    public void deleteProduct(Integer id) { productRepository.deleteById(id); }

    public Product updateProduct(Integer id, Product updatedProduct) {
        if (!productRepository.existsById(id)) return null;
        updatedProduct.setProductId(id);
        return productRepository.save(updatedProduct);
    }

    // ---------------------------
    // FUNCTION 1 — Search
    // ---------------------------
    public List<Product> searchProducts(String name, String category,
                                        Double minPrice, Double maxPrice,
                                        String keyword, boolean recent) {

        List<Product> products = productRepository.findAll();

        return products.stream().filter(product -> {

            // Name
            if (name != null && !name.isEmpty()) {
                if (!product.getProductName().toLowerCase().contains(name.toLowerCase()))
                    return false;
            }

            // Category
            if (category != null && !category.isEmpty()) {
                String cat = (product.getCategoryId() != null &&
                        product.getCategoryId().getCategoryName() != null)
                        ? product.getCategoryId().getCategoryName().toLowerCase() : "";

                if (!cat.contains(category.toLowerCase()))
                    return false;
            }

            // min price
            if (minPrice != null && product.getPrice() != null &&
                    product.getPrice().doubleValue() < minPrice)
                return false;

            // max price
            if (maxPrice != null && product.getPrice() != null &&
                    product.getPrice().doubleValue() > maxPrice)
                return false;

            // recently added
            if (recent) {
                Date sevenDaysAgo =
                        new Date(System.currentTimeMillis() - TimeUnit.DAYS.toMillis(7));

                if (product.getReleaseDate() == null ||
                        product.getReleaseDate().before(sevenDaysAgo))
                    return false;
            }

            // keyword
            if (keyword != null && !keyword.isEmpty()) {
                String kw = keyword.toLowerCase();
                String desc = product.getDescription() != null ? product.getDescription().toLowerCase() : "";
                String mat = product.getMaterial() != null ? product.getMaterial().toLowerCase() : "";

                if (!desc.contains(kw) && !mat.contains(kw))
                    return false;
            }

            return true;

        }).collect(Collectors.toList());
    }

    // ---------------------------
    // FUNCTION 2 — Stock
    // ---------------------------
    public String getStockMessage(Product product) {

        if (product.getInventoryList() == null || product.getInventoryList().isEmpty()) {
            return "Out of Stock";
        }

        Inventory inv = product.getInventoryList().get(0);

        int available = inv.getQuantityInStock() - inv.getQuantityReserved();

        if (available <= 0) return "Out of Stock";

        if (available <= inv.getReorderPoint())
            return "Low stock — only " + available + " left!";

        return "In Stock (" + available + " available)";
    }

    // ---------------------------
    // FUNCTION 2 — Average Rating
    // ---------------------------
    public Double getAverageRating(Product product) {
        if (product.getReviewList() == null || product.getReviewList().isEmpty())
            return 0.0;

        double avg = product.getReviewList()
                .stream()
                .filter(r -> r.getRating() != null)
                .mapToInt(Review::getRating)
                .average()
                .orElse(0.0);

        return Math.round(avg * 10.0) / 10.0;
    }

    // ---------------------------
    // FUNCTION 2 — Reviews ≥ 3 stars
    // ---------------------------
    public List<Review> getValidReviews(Product product) {
        if (product.getReviewList() == null) return List.of();

        return product.getReviewList()
                .stream()
                .filter(r -> r.getRating() != null && r.getRating() >= 3)
                .collect(Collectors.toList());
    }
}
