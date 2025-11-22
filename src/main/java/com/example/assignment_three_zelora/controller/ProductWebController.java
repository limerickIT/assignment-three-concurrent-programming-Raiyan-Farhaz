package com.example.assignment_three_zelora.controller;

import com.example.assignment_three_zelora.model.entitys.Product;
import com.example.assignment_three_zelora.model.entitys.Review;
import com.example.assignment_three_zelora.model.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductWebController {

    private final ProductService productService;

    public ProductWebController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/search")
    public String searchProducts(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) boolean recent,
            Model model) {

        List<Product> products = productService.searchProducts(
                name, category, minPrice, maxPrice, keyword, recent);

        model.addAttribute("products", products);
        model.addAttribute("searchParams",
                new SearchParams(name, category, minPrice, maxPrice, keyword, recent));

        return "product-search";
    }

    // -------------------------------
    // FUNCTION 2 — PRODUCT DETAILS
    // -------------------------------
    @GetMapping("/{id}")
    public String getProductDetails(@PathVariable Integer id, Model model) {

        Product product = productService.getProductById(id);
        if (product == null) return "product-not-found";

        String stockMessage = productService.getStockMessage(product);
        Double averageRating = productService.getAverageRating(product);
        List<Review> validReviews = productService.getValidReviews(product);

        model.addAttribute("product", product);
        model.addAttribute("stockMessage", stockMessage);
        model.addAttribute("averageRating", averageRating);
        model.addAttribute("reviews", validReviews);

        return "product-detail";
    }

    // Helper
    public static class SearchParams {
        public String name, category, keyword;
        public Double minPrice, maxPrice;
        public boolean recent;

        public SearchParams(String name, String category, Double minPrice,
                            Double maxPrice, String keyword, boolean recent) {
            this.name = name;
            this.category = category;
            this.minPrice = minPrice;
            this.maxPrice = maxPrice;
            this.keyword = keyword;
            this.recent = recent;
        }
    }
}

