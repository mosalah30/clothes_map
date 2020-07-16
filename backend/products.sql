-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 03, 2020 at 12:56 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id12916651_products`
--
CREATE DATABASE IF NOT EXISTS `id12916651_products` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `id12916651_products`;

-- --------------------------------------------------------

--
-- Table structure for table `hot_offers`
--

CREATE TABLE `hot_offers` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `priceBeforeDiscount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `hot_offers`
--

INSERT INTO `hot_offers` (`id`, `owner_id`, `description`, `price`, `priceBeforeDiscount`) VALUES
(1, 'test*%01', 'طقم رياضي أسود حريمي', 199.9, 250),
(2, 'test*%01', 'تيشيرت رجالي أحمر', 49.99, 60),
(3, 'test*%01', 'بنطلون برمودا اولادي', 70.5, 85),
(4, 'test*%01', 'بنطلون بني رجالي', 149.99, 200),
(5, 'test*%01', 'ساعة رجالي سوداء', 59.75, 70.5),
(6, 'test*%01', 'ساعة حريمي أنيقة', 39.99, 50),
(7, 'test*%01', 'كوفيه رجالي', 19.99, 25),
(8, 'test*%01', 'كوتشي أسود', 299.99, 349.99),
(9, 'test*%01', 'صندل أسود', 149.75, 210),
(10, 'test*%01', 'شنطة مدرسة زرقاء', 199.99, 250);

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `price` float NOT NULL,
  `priceBeforeDiscount` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `owner_id`, `description`, `price`, `priceBeforeDiscount`) VALUES
(1, 'test*%01', 'طقم أطفالي شتوي', 299.9, 350),
(2, 'test*%01', 'جاكيت شتوي بسوستة', 150.99, 200),
(3, 'test*%01', 'جاكيت شتوي بأزرار', 249.7, 300),
(4, 'test*%01', 'جاكيت أحمر شتوي', 99.99, 120),
(5, 'test*%01', 'حذاء شتوي من الصوف', 89.99, 99.99),
(6, 'test*%01', 'كوتشي أزرق', 200, 209.99),
(7, 'test*%01', 'بدلة حفلات شيك', 199.99, 249.75),
(8, 'test*%01', 'دستة كمامات بيضاء 12 قطعة', 49.99, 80),
(9, 'test*%01', 'شنطة سفر سوداء', 499.99, 600),
(10, 'test*%01', 'شنطة سفر فضية', 399.7, 449.99);

-- --------------------------------------------------------

--
-- Table structure for table `regular_products`
--

CREATE TABLE `regular_products` (
  `id` int(11) NOT NULL,
  `owner_id` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `category` enum('رجالي','حريمي','أطفالي') COLLATE utf8_unicode_ci NOT NULL,
  `section` enum('صيفي','شتوي','أحذية','شنط','إكسسوارات','أولاد','بنات') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `regular_products`
--

INSERT INTO `regular_products` (`id`, `owner_id`, `description`, `price`, `category`, `section`) VALUES
(1, 'test*%01', 'شنطة ظهر - خضراء', 200, 'رجالي', 'شنط'),
(2, 'test*%01', 'شنطة ظهر - زرقاء', 350, 'رجالي', 'شنط'),
(3, 'test*%01', 'شنطة يد بنية', 250, 'رجالي', 'شنط'),
(4, 'test*%01', 'تي شيرت صيفي سادة', 160, 'رجالي', 'صيفي'),
(5, 'test*%01', 'تي شيرت صيفي أسود-أبيض', 180, 'رجالي', 'صيفي'),
(6, 'test*%01', 'بنطلون برمودا صيفي', 210, 'رجالي', 'صيفي'),
(7, 'test*%01', 'جاكت صوف شتوي', 250, 'رجالي', 'شتوي'),
(8, 'test*%01', 'بنطلون شتوي بني', 50, 'رجالي', 'شتوي'),
(9, 'test*%01', 'بدلة شتوي أزرق كحلي', 500, 'رجالي', 'شتوي'),
(10, 'test*%01', 'كوتشي بني شتوي', 70, 'رجالي', 'أحذية'),
(11, 'test*%01', 'كوتشي سيفتي شتوي أسود', 140, 'رجالي', 'أحذية'),
(12, 'test*%01', 'صندل بني', 35, 'رجالي', 'أحذية'),
(13, 'test*%01', 'ساعة زيتي', 130, 'رجالي', 'إكسسوارات'),
(14, 'test*%01', 'خاتم فضي', 50, 'رجالي', 'إكسسوارات'),
(15, 'test*%01', 'نظارة شمسية', 25, 'رجالي', 'إكسسوارات'),
(16, 'test*%01', 'قميص أزرق', 46, 'أطفالي', 'أولاد'),
(17, 'test*%01', 'بنطلون جينز', 67, 'أطفالي', 'أولاد'),
(18, 'test*%01', 'زمزمية لتر', 20, 'أطفالي', 'أولاد'),
(19, 'test*%01', 'فستان قطعة واحدة', 166, 'أطفالي', 'بنات'),
(20, 'test*%01', 'شنطة مدرسة صغيرة', 56, 'أطفالي', 'بنات'),
(21, 'test*%01', 'شراب وردي', 15, 'أطفالي', 'بنات'),
(22, 'test*%01', 'ترنج صيفي كحلي', 235, 'حريمي', 'صيفي'),
(23, 'test*%01', 'ترنج رياضي أحمر', 290, 'حريمي', 'صيفي'),
(24, 'test*%01', 'بنطلون صيفي خفيف', 75, 'حريمي', 'صيفي'),
(25, 'test*%01', 'جاكيت رمادي شتوي', 238, 'حريمي', 'شتوي'),
(26, 'test*%01', 'بالطو نسائي', 140, 'حريمي', 'شتوي'),
(27, 'test*%01', 'روب أحمر شتوي', 234, 'حريمي', 'شتوي'),
(28, 'test*%01', 'حذاء بكعب أحمر', 65, 'حريمي', 'أحذية'),
(29, 'test*%01', 'كوتشي حريمي رمادي', 214, 'حريمي', 'أحذية'),
(30, 'test*%01', 'حذاء شتوي بأزرار ثلاثية', 213, 'حريمي', 'أحذية'),
(31, 'test*%01', 'شنطة يد فضية', 213, 'حريمي', 'شنط'),
(32, 'test*%01', 'شنطة حريمى فاشن سوداء', 57, 'حريمي', 'شنط'),
(33, 'test*%01', 'شنطة كروس حمراء', 132, 'حريمي', 'شنط'),
(34, 'test*%01', ' خاتم توينز - ذهب صينى', 499, 'حريمي', 'إكسسوارات'),
(35, 'test*%01', 'خاتم ذهب ابيض مع ياقوت', 875, 'حريمي', 'إكسسوارات'),
(36, 'test*%01', 'خاتم توينز مطلى ذهب ابيض', 211, 'حريمي', 'إكسسوارات');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hot_offers`
--
ALTER TABLE `hot_offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `regular_products`
--
ALTER TABLE `regular_products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hot_offers`
--
ALTER TABLE `hot_offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `regular_products`
--
ALTER TABLE `regular_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
