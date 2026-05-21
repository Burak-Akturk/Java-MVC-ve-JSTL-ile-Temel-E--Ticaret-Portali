-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 21 May 2026, 17:13:46
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `is_active`) VALUES
(1, 'Akıllı Telefonlar', 'En son teknoloji Apple, Samsung ve Xiaomi modelleri.', 1),
(2, 'Bilgisayarlar', 'Dizüstü bilgisayarlar, oyuncu bilgisayarları ve aksesuarları.', 1),
(3, 'Kulaklıklar & Ses', 'Kablosuz kulaklıklar ve bluetooth hoparlörler.', 1),
(4, 'Aksesuarlar', 'Kılıflar, şarj cihazları ve akıllı saatler.', 1),
(5, 'Figür', NULL, 1),
(6, 'Tablet', NULL, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) DEFAULT 'Beklemede'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `total_amount`, `status`) VALUES
(1, 2, '2026-05-21 11:04:22', 73500.00, 'İptal Edildi'),
(2, 2, '2026-05-20 13:04:22', 15500.00, 'Onaylandı'),
(3, 3, '2026-05-18 13:04:22', 49450.00, 'Kargolandı'),
(4, 3, '2026-05-16 13:04:22', 12000.00, 'İptal Edildi'),
(5, 2, '2026-05-21 13:58:52', 48000.00, 'Onaylandı');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 1, 1, 65000.00, 65000.00),
(2, 1, 5, 1, 8500.00, 8500.00),
(3, 2, 7, 1, 15500.00, 15500.00),
(4, 3, 3, 1, 48000.00, 48000.00),
(5, 3, 8, 1, 1450.00, 1450.00),
(6, 4, 6, 1, 12000.00, 12000.00),
(7, 5, 3, 1, 48000.00, 48000.00);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `image_url` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `image_url`, `is_active`, `created_at`) VALUES
(1, 1, 'iPhone 15 Pro 128GB', 'Titanyum kasa, A17 Pro çip ve gelişmiş üçlü kamera sistemi.', 70000.00, 20, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500', 1, '2026-05-21 13:04:22'),
(2, 1, 'Samsung Galaxy S24 Ultra', 'AI özellikli yapay zeka kamerası, S-Pen ve 200MP ana kamera.', 58000.00, 20, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500', 1, '2026-05-21 13:04:22'),
(3, 2, 'MacBook Air M3 16GB', 'Taşınabilir, sessiz ve ultra güçlü M3 işlemcili 13.6 inç laptop.', 48000.00, 7, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500', 1, '2026-05-21 13:04:22'),
(4, 2, 'Asus ROG Strix G16', 'Intel i7 işlemci, RTX 4060 ekran kartı ile yüksek performans oyuncu bilgisayarı.', 42500.00, 5, 'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500', 1, '2026-05-21 13:04:22'),
(5, 3, 'AirPods Pro 2. Nesil', 'Aktif gürültü engelleme, adaptif şeffaf mod ve USB-C şarj kutusu.', 8500.00, 30, 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500', 1, '2026-05-21 13:04:22'),
(6, 3, 'Sony WH-1000XM5', 'Premium kafa üstü kablosuz kulaklık, eşsiz gürültü engelleme performansı.', 12000.00, 0, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500', 1, '2026-05-21 13:04:22'),
(7, 4, 'Apple Watch Series 9', 'Her zaman açık retina ekran, kanda oksijen ölçümü ve gelişmiş antrenman takibi.', 15500.00, 12, 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500', 1, '2026-05-21 13:04:22'),
(8, 4, 'MagSafe Kablosuz Şarj Cihazı', 'iPhone modelleri için 15W hızlı kablosuz şarj sağlayan miknatıslı stant.', 1450.00, 50, 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MHXH3?wid=500&hei=500&fmt=jpeg', 1, '2026-05-21 13:04:22'),
(10, 5, 'Cristiano Ronaldo Figürü', 'Gerçekçi Ronaldo figürü', 5000.00, 20, 'https://th.bing.com/th/id/OIP.95l4vDle2bs3dWhRONOOnwHaLH?w=204&h=306&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', 0, '2026-05-21 14:10:49');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` varchar(20) DEFAULT 'CUSTOMER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `phone`, `address`, `role`, `created_at`, `is_active`) VALUES
(1, 'Burak Admin', 'admin@eticaret.com', '123456', '05551112233', 'Kadıköy / İstanbul', 'ADMIN', '2026-05-21 13:04:22', 1),
(2, 'Ahmet Yılmaz', 'ahmet@gmail.com', '123456', '05321112233', 'Çankaya / Ankara', 'CUSTOMER', '2026-05-21 13:04:22', 1),
(3, 'Zeynep Kaya', 'zeynep@gmail.com', '123456', '05442223344', 'Konak / İzmir', 'CUSTOMER', '2026-05-21 13:04:22', 1),
(4, 'Burak Aktürk', 'burak@gmail.com', '123456', '', '', 'CUSTOMER', '2026-05-21 14:02:32', 1);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Tablo için indeksler `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Tablo için indeksler `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Tablo kısıtlamaları `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Tablo kısıtlamaları `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
