-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2025 at 03:52 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zelora`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_image`, `category_name`) VALUES
(1, NULL, 'Tops'),
(2, NULL, 'Bottoms'),
(3, NULL, 'Footwear'),
(4, NULL, 'Accessories'),
(5, NULL, 'Outerwear'),
(6, NULL, 'Sportswear'),
(7, NULL, 'Underwear'),
(8, NULL, 'Eco Fashion'),
(9, NULL, 'Luxury Wear'),
(10, NULL, 'Casual Wear'),
(11, NULL, 'Formal Wear'),
(12, NULL, 'Kids Wear'),
(13, NULL, 'Winter Wear'),
(14, NULL, 'Summer Wear'),
(15, NULL, 'Women\'s Clothing'),
(16, NULL, 'Denim'),
(17, NULL, 'Swimwear'),
(18, NULL, 'Hats'),
(19, NULL, 'Home Apparel'),
(20, NULL, 'Bags');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `date_joined` date DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `payment_info` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `vip_status` varchar(255) DEFAULT NULL,
  `address` tinytext DEFAULT NULL,
  `communication_preferences` tinytext DEFAULT NULL,
  `size_preferences` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity_in_stock` int(11) DEFAULT NULL,
  `quantity_reserved` int(11) DEFAULT NULL,
  `reorder_point` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `item_price` decimal(38,2) DEFAULT NULL,
  `item_weight` decimal(38,2) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `order_item_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `subtotal` decimal(38,2) DEFAULT NULL,
  `customisation_options` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `customer_id` int(11) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `total_amount` decimal(38,2) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `category_id` int(11) DEFAULT NULL,
  `discounted_price` decimal(38,2) DEFAULT NULL,
  `price` decimal(38,2) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `release_date` date DEFAULT NULL,
  `supplier_id` int(11) NOT NULL,
  `sustainability_rating` int(11) DEFAULT NULL,
  `colour` varchar(255) DEFAULT NULL,
  `feature_image` varchar(255) NOT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `material` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `description` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`category_id`, `discounted_price`, `price`, `product_id`, `release_date`, `supplier_id`, `sustainability_rating`, `colour`, `feature_image`, `manufacturer`, `material`, `product_name`, `size`, `description`) VALUES
(8, NULL, 19.99, 1, '2024-01-15', 1, 5, 'White', '7.2.png', 'EcoThreads', 'Organic Cotton', 'White T-Shirt', 'M', 'Soft eco-friendly cotton t-shirt.'),
(15, NULL, 39.99, 2, '2024-02-02', 2, 4, 'White', '3_2.png', 'UrbanFabrics', 'Cotton', 'Bohemian  Style MAxi', 'L', 'Beautifully made cotton bohemian styled maxi'),
(3, 69.99, 79.99, 3, '2024-03-10', 3, 5, 'Beige', '3_1.png', 'GreenLeaf', 'Vegan Leather', 'Eco Sneakers', '42', 'Vegan leather sneakers with cork soles.'),
(10, NULL, 49.99, 4, '2024-04-18', 4, 4, 'Grey', '4_2.png', 'PrimeWear', 'Bamboo Fiber', 'Bamboo Hoodie', 'XL', 'Ultra-soft hoodie made from bamboo fibers.'),
(13, 119.99, 129.99, 5, '2024-05-30', 5, 5, 'Brown', '14_1.png', 'StyleForge', 'Wool', 'Wool Winter Coat', 'M', 'Thick premium wool coat for winter.'),
(2, NULL, 49.99, 6, '2024-06-12', 1, 4, 'Khaki', '4_3.png', 'EcoThreads', 'Cotton Blend', 'Slim Fit Chinos', '32', 'Stretchable chinos made for comfort.'),
(16, NULL, 69.99, 16, '2024-08-12', 16, 4, 'Blue', '1_1.png', 'DenimPro', 'Denim', 'Denim Jeans', '32', 'Classic blue denim jeans with slim fit.'),
(18, NULL, 19.99, 18, '2024-09-20', 18, 5, 'Light Brown', '6_2.png', 'TechHive', 'ABS Plastic', 'Light Brown Hat', NULL, 'Vintage Light Brown Hat'),
(20, 79.99, 89.99, 20, '2024-06-30', 20, 5, 'Brown', '15_1.png', 'BagLand', 'Leather', 'Backpack', NULL, 'Premium leather backpack for daily use.');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `customer_id` int(11) DEFAULT NULL,
  `flagged_as_spam` bit(1) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `review_id` int(11) NOT NULL,
  `review_text` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `address` tinytext DEFAULT NULL,
  `description` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `contact_email`, `contact_name`, `contact_phone`, `supplier_name`, `website`, `address`, `description`) VALUES
(1, 'contact@ecothreads.com', NULL, '123-4567', 'EcoThreads', NULL, NULL, NULL),
(2, 'info@urbanfab.com', NULL, '222-3333', 'UrbanFabrics', NULL, NULL, NULL),
(3, 'support@greenleaf.com', NULL, '444-5555', 'GreenLeaf', NULL, NULL, NULL),
(4, 'sales@primewear.com', NULL, '555-6666', 'PrimeWear', NULL, NULL, NULL),
(5, 'hello@styleforge.com', NULL, '777-8888', 'StyleForge', NULL, NULL, NULL),
(16, 'denim@supply.com', NULL, '999-1111', 'DenimPro', NULL, NULL, NULL),
(17, 'swim@master.com', NULL, '999-2222', 'SwimMaster', NULL, NULL, NULL),
(18, 'tech@hive.com', NULL, '999-3333', 'TechHive', NULL, NULL, NULL),
(19, 'home@soft.com', NULL, '999-4444', 'HomeSoft', NULL, NULL, NULL),
(20, 'bags@land.com', NULL, '999-5555', 'BagLand', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `added_date` date DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `wishlist_id` int(11) NOT NULL,
  `wishlist_name` varchar(255) DEFAULT NULL,
  `notes` tinytext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `FKq2yge7ebtfuvwufr6lwfwqy9l` (`product_id`),
  ADD KEY `FK1ticfk66udu8mbj1otebp2rgw` (`supplier_id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `FKm3mp87f5ygbbfuqfdhc09y9a` (`order_id`),
  ADD KEY `FKqu7dfdpbhltsgxfq2ahkdnyv5` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FKpxtb8awmi0dk6smoh2vp1litg` (`customer_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  ADD KEY `FK6i174ixi9087gcvvut45em7fd` (`supplier_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FK4sm0k8kw740iyuex3vwwv1etu` (`customer_id`),
  ADD KEY `FKpl51cejpw4gy5swfar8br9ngi` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wishlist_id`),
  ADD KEY `FKk6lal9w7ut5e4xvta479rq06y` (`customer_id`),
  ADD KEY `FK6p7qhvy1bfkri13u29x6pu8au` (`product_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `FK1ticfk66udu8mbj1otebp2rgw` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `FKq2yge7ebtfuvwufr6lwfwqy9l` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `FKm3mp87f5ygbbfuqfdhc09y9a` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `FKqu7dfdpbhltsgxfq2ahkdnyv5` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FKpxtb8awmi0dk6smoh2vp1litg` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FK6i174ixi9087gcvvut45em7fd` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `FK4sm0k8kw740iyuex3vwwv1etu` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `FKpl51cejpw4gy5swfar8br9ngi` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `FK6p7qhvy1bfkri13u29x6pu8au` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKk6lal9w7ut5e4xvta479rq06y` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
