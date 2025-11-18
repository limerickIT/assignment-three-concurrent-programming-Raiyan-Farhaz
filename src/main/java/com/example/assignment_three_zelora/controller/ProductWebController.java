package com.example.assignment_three_zelora.controller;

import com.example.assignment_three_zelora.model.entitys.Product;
import com.example.assignment_three_zelora.model.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductWebController {

    private final ProductService productService;

    // Use constructor injection for the service
    public ProductWebController(ProductService productService) {
        this.productService = productService;
    }

    /**
     * Handles requests to /products/search.
     * It performs the multi-criteria search (To Do 1) and passes results to the Thymeleaf template.
     */
    @GetMapping("/search")
    public String searchProducts(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) boolean recent,
            Model model) {

        // 1. Perform the search using your existing service layer
        List<Product> products = productService.searchProducts(name, category, minPrice, maxPrice, keyword, recent);

        // 2. Add the results and search parameters to the model for Thymeleaf
        model.addAttribute("products", products);

        // Also add the search criteria so the form can retain user input after submission
        model.addAttribute("searchParams", new SearchParams(name, category, minPrice, maxPrice, keyword, recent));

        // 3. Return the name of the Thymeleaf template (located in src/main/resources/templates/)
        return "product-search";
    }

    // Helper class to hold search parameters for retaining form values in Thymeleaf
    public static class SearchParams {
        public String name;
        public String category;
        public Double minPrice;
        public Double maxPrice;
        public String keyword;
        public boolean recent;

        public SearchParams(String name, String category, Double minPrice, Double maxPrice, String keyword, boolean recent) {
            this.name = name;
            this.category = category;
            this.minPrice = minPrice;
            this.maxPrice = maxPrice;
            this.keyword = keyword;
            this.recent = recent;
        }
    }
}