-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 05, 2021 at 09:07 AM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kypay_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `kypay_biller`
--

CREATE TABLE `kypay_biller` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `service_bid` varchar(128) DEFAULT NULL,
  `payout_method` varchar(64) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `addr_line1` varchar(255) DEFAULT NULL,
  `addr_line2` varchar(255) DEFAULT NULL,
  `post_code` varchar(20) DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `state` varchar(150) DEFAULT NULL,
  `country` varchar(5) DEFAULT NULL,
  `icon_url` varchar(255) DEFAULT NULL,
  `status` enum('A','S') DEFAULT 'A',
  `by_type` enum('PN','AN','O') DEFAULT 'AN',
  `number_validator` varchar(128) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_biller`
--

INSERT INTO `kypay_biller` (`id`, `service_bid`, `payout_method`, `name`, `addr_line1`, `addr_line2`, `post_code`, `city`, `state`, `country`, `icon_url`, `status`, `by_type`, `number_validator`, `last_updated`) VALUES
('astro_77363avdvd3a63', 'beneficiary_ebf65ac46c65cc7d6aac5f69d05e4ca9', 'my_allianceislamicbank_bank', 'Astro', NULL, NULL, NULL, NULL, NULL, 'MY', '/images/billers/MY/astro.png', 'A', 'AN', NULL, '2021-07-01 11:29:54'),
('sesb-88277376aga2', 'beneficiary_42f0049c56b62a6324da9d7ed14735af', 'my_affinbank_bank', 'SESB', NULL, NULL, NULL, NULL, NULL, 'MY', '/images/billers/MY/sesb.png', 'A', 'AN', NULL, '2021-07-01 11:24:22'),
('tm_77ggsgdvVAf390', 'beneficiary_3e90373749167aa868b02e4012c8345f', 'my_affinbank_bank', 'Telekom', NULL, NULL, NULL, NULL, NULL, 'MY', '/images/billers/MY/tm.png', 'A', 'PN', '^[0-9+]{0,1}+[0-9]{5,16}$', '2021-07-01 11:32:03');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_device_token`
--

CREATE TABLE `kypay_device_token` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `token` varchar(128) NOT NULL DEFAULT 'xxx',
  `device_type` enum('I','A','O') DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_device_token`
--

INSERT INTO `kypay_device_token` (`id`, `token`, `device_type`, `last_updated`) VALUES
('Che_Rm92ndZL', '82727272727aa', 'I', '2021-06-30 09:00:14');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_message`
--

CREATE TABLE `kypay_message` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `uid` varchar(32) NOT NULL DEFAULT 'x',
  `item_id` varchar(32) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `type` enum('SM','RM','O') DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_message`
--

INSERT INTO `kypay_message` (`id`, `uid`, `item_id`, `title`, `sub_title`, `type`, `last_updated`) VALUES
('Mesg_1V7Nt2SnvrLAAVABCMjUyw22', 'Yan_ffbnByHzZQQ2', 'wQbTY9R4FIYEDWPKC7NaBA22', 'Money Received!', 'May Yang sent you money MYR 10', 'SM', '2021-07-04 13:53:44'),
('Mesg_6PScntnlbW6S4lA8OlHzZQ22', 'Yan_ffbnByHzZQQ2', 'OkxO2fmeW1Dj7P9w6Cbw8Q22', 'Money Received!', 'Ket Yung Chee sent you money MYR10', 'SM', '2021-07-03 17:41:35'),
('Mesg_A1DCcWYl1atibv0WAlZw8A22', 'Yan_ffbnByHzZQQ2', '0uW6JBBlenGttrfTvR4A1A22', 'Money Received!', 'Ket Yung Chee sent you money MYR 10', 'SM', '2021-07-05 16:14:01'),
('Mesg_GmBlb0foB4G1jijB4BkpsA22', 'Che_Rm92ndZL', 'AFRH0C6xoHFS6QEjOUzmXQ22', 'Money Received!', 'Ket Yung Chee sent you money MYR 10', 'SM', '2021-07-05 10:03:50'),
('Mesg_H92ngm8ok2FD9gZQZskkZA22', 'Yan_ffbnByHzZQQ2', 'ac6n9Fvw4P8porr3gzD6sQ22', 'Money Received!', 'Ket Yung Chee sent you money MYR 20', 'SM', '2021-07-03 17:44:18'),
('Mesg_JuKpZ8kGvQue3pAvob2e2A22', 'Che_Rm92ndZL', 'XyK11NhUwIi8xaEavbNPHA22', 'Money Received!', '  sent you money MYR2', 'SM', '2021-07-03 16:32:05'),
('Mesg_OiaEM6RrscwXW5N1ON3mcg22', 'Che_Rm92ndZL', 'KJSUqeHfzAzbqV7TXlHegg22', 'Money Received!', '  sent you money MYR1', 'SM', '2021-07-03 16:30:07'),
('Mesg_qIeoocdduT7W37nHUBuhFg22', 'Che_Rm92ndZL', 'vAbKetrpsKiAH6DNXOoryw22', 'Money Received!', 'Ket Yung Chee sent you money MYR 200', 'SM', '2021-07-05 16:15:33'),
('Mesg_Tl4q3cAaKSM5WlbYww09fw22', 'Che_Rm92ndZL', 'xdHX6n2gzR7aCe60gxZofA22', 'Money Received!', 'May Yang sent you money MYR 2.03', 'SM', '2021-07-03 17:47:19'),
('Mesg_UguF3DWXCjfVOkVEjR6xxA22', 'Che_Rm92ndZL', '4PNPSbopnKHCTCfmp9eSgQ22', 'Money Received!', '  sent you money MYR1', 'SM', '2021-07-03 16:24:24'),
('Mesg_Vi7dcXbyvskBSfx0JYW5XQ22', 'Che_Rm92ndZL', 'QEeBes9jL2zwaaX3D6MkRQ22', 'Money Received!', 'May Yang sent you money MYR 1', 'SM', '2021-07-03 17:45:03'),
('Mesg_wAY0iZHDazN69GOqyM2Y0A22', 'Che_Rm92ndZL', 'Hmd2CpTMN6HwqIlLfa81TQ22', 'Money Received!', '  sent you money MYR1', 'SM', '2021-07-03 16:28:45'),
('Mesg_Y9fKHjwhnD2RHLCC4T6VnQ22', 'Yan_ffbnByHzZQQ2', 'ZpYEUWyJDYYXCix2n5i8qA22', 'Money Received!', 'Ket Yung Chee sent you money MYR 10', 'SM', '2021-07-04 15:00:24'),
('Mesg_Z0f9F7iLuenSjAq2Io2HYA22', 'Che_Rm92ndZL', 'iySNyGIsNW2TTSx1qBIPHA22', 'Money Received!', 'May Yang sent you money MYR1.09', 'SM', '2021-07-03 16:37:13'),
('Mesg_zwXSrQqCekkC2iXoUi9fMQ22', 'Yan_ffbnByHzZQQ2', 'JPf6ZJ8I6WmpXQpXzNOM9g22', 'Money Received!', 'Ket Yung Chee sent you money MYR 2', 'SM', '2021-07-05 16:43:35');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_order`
--

CREATE TABLE `kypay_order` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `uid` varchar(32) NOT NULL DEFAULT 'x',
  `total` float(10,2) DEFAULT NULL,
  `currency` varchar(5) DEFAULT NULL,
  `status` enum('D','N','PD') NOT NULL DEFAULT 'N',
  `payment_method` varchar(64) DEFAULT NULL,
  `date_ordered` datetime DEFAULT NULL,
  `date_delivered` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_order`
--

INSERT INTO `kypay_order` (`id`, `uid`, `total`, `currency`, `status`, `payment_method`, `date_ordered`, `date_delivered`, `last_updated`) VALUES
('ORDERPC4XN5LLHKDMYWSEASW2', 'Che_Rm92ndZL', 260.00, 'MYR', 'N', 'kypay_wallet_transfer', '2021-07-05 17:06:01', NULL, '2021-07-05 17:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller`
--

CREATE TABLE `kypay_seller` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `uid` varchar(32) NOT NULL DEFAULT 'x',
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller`
--

INSERT INTO `kypay_seller` (`id`, `uid`, `name`, `description`, `last_updated`) VALUES
('S-8HAFvGAJ3KLaJK', 'Teo_bKVBIrH0XFI2', 'Teo\'s Figurine Shop', 'Selling Interesting Figurines which are great for your collection', '2021-07-04 07:43:21'),
('S-CHEEKY8998KYCC', 'Che_Rm92ndZL', 'Chee\'s Home Appliance Shop', 'Selling great value for money home appliances on KyShop', '2021-07-04 09:26:54'),
('S-UJAG627HAJA902', 'Yan_ffbnByHzZQQ2', 'May Little Book Shop', 'A kid-friendly bookshop selling great books for kids', '2021-07-04 08:33:52');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller_category`
--

CREATE TABLE `kypay_seller_category` (
  `id` varchar(12) NOT NULL DEFAULT 'x',
  `name` varchar(64) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller_category`
--

INSERT INTO `kypay_seller_category` (`id`, `name`, `last_updated`) VALUES
('BK-YH62738L', 'Books', '2021-07-03 20:42:55'),
('COL-2663BBL', 'Collectibles', '2021-07-03 20:42:55'),
('GG-4BTHY672', 'Gadgets', '2021-07-03 20:42:55'),
('HA-BH62736N', 'Home Appliances', '2021-07-03 20:42:55');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller_item`
--

CREATE TABLE `kypay_seller_item` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `seller_id` varchar(32) NOT NULL DEFAULT 'x',
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `category` varchar(12) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `currency` varchar(5) DEFAULT NULL,
  `qoh` smallint(3) DEFAULT NULL,
  `shipping_fee` float(10,2) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller_item`
--

INSERT INTO `kypay_seller_item` (`id`, `seller_id`, `name`, `description`, `category`, `price`, `currency`, `qoh`, `shipping_fee`, `last_updated`) VALUES
('B00000000001', 'S-UJAG627HAJA902', 'Colouring Childrens Activity Fun 8 Books Collection', 'Colouring Kids Sticker Activity Books Collection Set at amazing value for money. Comes with over 250 stickers and lots of exciting press-out pieces', 'BK-YH62738L', 45.00, 'MYR', 910, 0.00, '2021-07-04 08:49:54'),
('B0000000002x', 'S-UJAG627HAJA902', 'Exciting Stories: 10 Kids Picture Books Bundle - Picture Book', 'This Classic Bedtime Set Includes all the Books You Love from Authors such as LeyLand Perree, Katherine Sully, Robert Pearce, and Christine Swift. This 10 Books Set is perfect for your children and includes Pigs Egg, Titch The Tiddler, Stop Monkeying Around, Little Bear Wont Sleep, Frog On The Log, Animal Fashion Parade, Mr Wrinkles, The Penguin King, The Goat That Gloats, Hen\'s Feathers.', 'BK-YH62738L', 50.00, 'MYR', 712, 0.00, '2021-07-04 08:54:47'),
('BF8888888888gH', 'S-UJAG627HAJA902', 'Ultimate Football Heroes Collection 10 Books Set', 'Ultimate Football Heroes Collection 10 Books Set By Matt Oldfield and Tom Oldfield telling your about the 10 great players in soccer, including Kane, Neymar, Ronaldo, Hazard, Lukaku, Messi, Bale, Aguero, and Coutinho ', 'BK-YH62738L', 130.00, 'MYR', 320, 0.00, '2021-07-04 09:04:13'),
('BS00000000fxY', 'S-UJAG627HAJA902', 'Usborne Beginner\'s Series Science 10 Books Set HARDCOVER', 'Usborne - Beginner\'s Science Collection - 10 Books Set as follows :\r\n\r\n- Earthquakes and Tsunamis \r\n- Sun Moon and Stars \r\n- Living in Space \r\n- Storms and Hurricanes \r\n- Astronomy \r\n- The Solar System \r\n- Your Body\r\n- Planet Earth\r\n- Weather', 'BK-YH62738L', 125.00, 'MYR', 800, 0.00, '2021-07-04 08:59:33'),
('H1234567899A', 'S-CHEEKY8998KYCC', 'Hamilton Beach 33956.SAU 4.5L Programmable Slow Cooker ', 'This model come with 3 choices for easy and automatic cooking such as probe, program and manual. There also built in with thermometer probe for meat as well as consist of full grip handles and power interrupt protection.', 'HA-BH62736N', 850.00, 'MYR', 500, 0.00, '2021-07-04 09:31:34'),
('H23356778BHA', 'S-CHEEKY8998KYCC', 'Hamilton Beach 51241.SAU 600ml Go Sport Personal Blender', 'This blender come with 2 single serve double mug and with removable blades. It also come with 2 speeds & pulse as well as is BPA free in food zones.', 'HA-BH62736N', 410.00, 'MYR', 300, 0.00, '2021-07-04 09:35:44'),
('i00000002aaaXdf', 'S-8HAFvGAJ3KLaJK', 'Comansi - Figure Fireman Sam with helmet\r\n', 'Delivery time: usually ships in 1-3 working days\r\n\r\nBrand: Comansi', 'COL-2663BBL', 18.90, 'MYR', 500, 0.00, '2021-07-04 08:29:33'),
('i000089haj38JKs', 'S-8HAFvGAJ3KLaJK', 'Comansi - Dora the Explorer - figurine Dora Illusion\r\n', 'Delivery time: usually ships in 1-3 working days\r\n\r\nBrand: Comansi', 'COL-2663BBL', 15.60, 'MYR', 915, 0.00, '2021-07-04 08:24:21'),
('i00009abYakopI2', 'S-8HAFvGAJ3KLaJK', 'Comansi - Masha and the Bear - figurine Masha', 'Delivery time: usually ships in 1-3 working days\nBrand: Comansi', 'COL-2663BBL', 12.50, 'MYR', 290, 0.00, '2021-07-04 07:51:06');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller_item_image`
--

CREATE TABLE `kypay_seller_item_image` (
  `id` smallint(2) NOT NULL DEFAULT '1',
  `item_id` varchar(32) NOT NULL DEFAULT 'x',
  `type` enum('T','O') DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller_item_image`
--

INSERT INTO `kypay_seller_item_image` (`id`, `item_id`, `type`, `url`, `last_updated`) VALUES
(1, 'B00000000001', 'O', '/sellers/S-UJAG627HAJA902/B00000000001/images/1.png', '2021-07-04 09:23:22'),
(1, 'B0000000002x', 'O', '/sellers/S-UJAG627HAJA902/B0000000002x/images/1.png', '2021-07-04 09:09:38'),
(1, 'BF8888888888gH', 'O', '/sellers/S-UJAG627HAJA902/BF8888888888gH/images/1.png', '2021-07-04 09:08:19'),
(1, 'BS00000000fxY', 'O', '/sellers/S-UJAG627HAJA902/BS00000000fxY/images/1.png', '2021-07-04 09:24:35'),
(1, 'H1234567899A', 'O', '/sellers/S-CHEEKY8998KYCC/H1234567899A/images/1.png', '2021-07-04 09:44:45'),
(1, 'H23356778BHA', 'O', '/sellers/S-CHEEKY8998KYCC/H23356778BHA/images/1.png', '2021-07-04 09:43:43'),
(1, 'i00000002aaaXdf', 'O', '/sellers/S-8HAFvGAJ3KLaJK/i00000002aaaXdf/images/1.png', '2021-07-04 08:31:27'),
(1, 'i000089haj38JKs', 'O', '/sellers/S-8HAFvGAJ3KLaJK/i000089haj38JKs/images/1.png', '2021-07-04 08:26:47'),
(1, 'i00009abYakopI2', 'O', '/sellers/S-8HAFvGAJ3KLaJK/i00009abYakopI2/images/1.png', '2021-07-04 07:58:06');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller_order`
--

CREATE TABLE `kypay_seller_order` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `order_id` varchar(32) NOT NULL DEFAULT 'x',
  `seller_id` varchar(32) NOT NULL DEFAULT 'x',
  `total` float(10,2) DEFAULT NULL,
  `currency` varchar(5) DEFAULT NULL,
  `status` enum('D','N','PD') NOT NULL DEFAULT 'N',
  `service_payment_id` varchar(128) DEFAULT NULL,
  `date_ordered` datetime DEFAULT NULL,
  `date_delivered` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller_order`
--

INSERT INTO `kypay_seller_order` (`id`, `order_id`, `seller_id`, `total`, `currency`, `status`, `service_payment_id`, `date_ordered`, `date_delivered`, `last_updated`) VALUES
('SOFUZELYVAQPBKDAMSP2G2', 'ORDERPC4XN5LLHKDMYWSEASW2', 'S-UJAG627HAJA902', 260.00, 'MYR', 'N', 'xxxxxxxx-xxx__111', '2021-07-05 17:06:01', NULL, '2021-07-05 17:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_seller_order_item`
--

CREATE TABLE `kypay_seller_order_item` (
  `seller_order_id` varchar(32) NOT NULL DEFAULT 'x',
  `item_id` varchar(32) NOT NULL DEFAULT '',
  `item_name` varchar(64) DEFAULT NULL,
  `price` float(10,2) DEFAULT NULL,
  `quantity` smallint(3) DEFAULT NULL,
  `total` float(10,2) DEFAULT NULL,
  `status` enum('D','N','PD') NOT NULL DEFAULT 'N',
  `date_delivered` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_seller_order_item`
--

INSERT INTO `kypay_seller_order_item` (`seller_order_id`, `item_id`, `item_name`, `price`, `quantity`, `total`, `status`, `date_delivered`, `last_updated`) VALUES
('SOFUZELYVAQPBKDAMSP2G2', 'BF8888888888gH', 'Ultimate Football Heroes Collection 10 Books Set', 130.00, 2, 260.00, 'N', NULL, '2021-07-05 17:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_user`
--

CREATE TABLE `kypay_user` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `first_name` varchar(100) NOT NULL DEFAULT 'x',
  `last_name` varchar(100) NOT NULL DEFAULT 'x',
  `account_type` enum('B','P','O') NOT NULL DEFAULT 'P',
  `dob` datetime DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `country_code` varchar(5) NOT NULL DEFAULT 'MY',
  `seed` smallint(3) DEFAULT NULL,
  `stat` enum('SI','SO') NOT NULL DEFAULT 'SO',
  `last_stat_time` datetime DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user`
--

INSERT INTO `kypay_user` (`id`, `first_name`, `last_name`, `account_type`, `dob`, `email`, `phone_number`, `country_code`, `seed`, `stat`, `last_stat_time`, `last_updated`) VALUES
('Cha_2HIp1eI5L5g2', 'Claire', 'Chan', 'P', '1986-11-30 00:00:00', 'mMajH/DBnRl1aH1aawM0BvL56FF55Bwfr2AHAUTbqYFFyjfgIRA7g4bBjbV0UzVTRGX8NEWe2cHohmif', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfKyqXIUyiLvWldXVYJXXJRM6b3O01Dj9WSmuKaw==', 'MY', 7, 'SO', NULL, '2021-06-23 07:34:26'),
('Cha_BCmFOsbhcm02', 'Claire', 'Chan', 'P', '1986-11-30 00:00:00', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfIBUSru2NMd7CyOrc4aJeeIbBjbV0UztcShPRMkGTns6piA==', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfHIjMcDgGJP0OGDZHe5e5HM6b3O0wDjxUTmqFYA==', 'MY', 7, 'SO', NULL, '2021-06-23 08:45:00'),
('Cha_PciWGbbhn7o2', 'Claire', 'Chan', 'P', '1986-11-30 00:00:00', '+VoWhDGyvoMbcngGjhD8UG+8M0lV4f8lvsUkgs7gzK2h3zLgubc8ZDz2lOTkkR4IinZj8VtiCohbkQI=', '+VoWhDGyvoMbcngGjhD8UG+8M0lV4f8lrnly2tzRYs/AYgGe1+84onSsxbynzBcPgXkarw==', 'MY', 6, 'SO', NULL, '2021-06-23 08:33:02'),
('Che_Rm92ndZL', 'Ket Yung', 'Chee', 'P', NULL, 'HBBFC1BgFbmgtRE5SliSBaGBK/Iq9ZNVlC2Vd69N43m0ZMshBzLf/Z46Q+yFvSrynm/xFPPcwvPFJnwF', 'HBBFC1BgFbmgtRE5SliSBaGBK/Iq9ZNVWLwimcLPjXsG+drGYxQ/2N5pB6TD63uB3jKmRA==', 'MY', 16, 'SI', '2021-06-12 11:48:37', '2021-06-12 11:48:37'),
('Kin_pe23WUO3ZwE2', 'Jason', 'King', 'P', '2001-11-03 10:19:00', 'mMajH/DBnRl1aH1aawM0BvL56FF55Bwf+YcRGDAxe6EQX+xnk9fzW6/Gh7dtdmoIHTrQfUuQ3Q==', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfMWch/QG5E/X7VdyRJoow+s6c2uk2Aj5WTWuEag==', 'US', 7, 'SO', NULL, '2021-07-03 10:19:48'),
('Sha_oPkPWHhybAc2', 'Luke', 'Shaw', 'P', '1983-07-03 10:23:00', 'ZqppCyMx5zNNygU9IPU4LRX41wkb3QBueXC6lZLRp+PiQuDEbqAF/jTGURQoVCXZRT5ismA=', 'ZqppCyMx5zNNygU9IPU4LRX41wkb3QBuTV6NSDaEq0p26CygcK7xplOEDWV6AXKAGyM25Q==', 'US', 15, 'SO', NULL, '2021-07-03 10:23:38'),
('Tan_Kql018jlkyo2', 'Aska', 'Tang', 'P', '1992-07-03 10:30:00', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfESpmbmzWY/mjFeiyDLqSFaTeh71ydnUIHTrQfUuQ3Q==', 'mMajH/DBnRl1aH1aawM0BvL56FF55BwfEG6advwllAysKifE5/xB/86b3O03DjxUTWKNYQ==', 'MY', 7, 'SO', NULL, '2021-07-03 10:30:45'),
('Tee_40QSIitGYbk2', 'Johnson', 'Tee', 'P', '2004-07-03 10:13:00', 'T6wI4+/Agwahs0o/6L7HadCphg+lyrFswnwTRF1IyPKS2ohsseAUnW19SH4a9r8vpgeelNN9', 'T6wI4+/Agwahs0o/6L7HadCphg+lyrFspU+qSYTKaaS20YYen98O7ww/GCJiveZ591OJ', 'SG', 19, 'SO', NULL, '2021-07-03 10:13:28'),
('Teo_bKVBIrH0XFI2', 'Chris', 'Teo', 'P', '1999-07-03 10:46:00', 'HBBFC1BgFbmgtRE5SliSBaGBK/Iq9ZNVzI/cHp/CIjYDx/6ta5atdbYrUvqwqyDTg2a8H//Z', 'HBBFC1BgFbmgtRE5SliSBaGBK/Iq9ZNVbP1rtSmoqZBHPrQeFntvx95pB6TC63yD2zujTw==', 'MY', 16, 'SO', NULL, '2021-07-03 10:46:11'),
('Van_nAkT6Eog', 'Abigail', 'Vanc Chee', 'P', NULL, 'FQ6VlcNn220n0H3kCelLXAK0Pju+tcj1kKFFZqQEh4w+YTMARnVS5VLFCN+ijPuuHJB+SBUbQIpNfJnE', 'FQ6VlcNn220n0H3kCelLXAK0Pju+tcj1dinDitI1u10qXb9E80O4hhiRUYnx3abfUcUtGQ==', 'MY', 8, 'SO', NULL, NULL),
('Wan_82u6cg9obZc2', 'Justin', 'Wang', 'P', '1998-07-03 08:52:00', 'ZqppCyMx5zNNygU9IPU4LRX41wkb3QBu9XWzCHt6/+EOKKCh8VdjRTLASiAmVzPRR3dBumB0A2GrXPz6', 'ZqppCyMx5zNNygU9IPU4LRX41wkb3QBuHcZM7i7Sb17eFs8Dq1WWI1ODDG1+CHWIGyI5', 'SG', 15, 'SO', NULL, '2021-07-03 08:52:44'),
('Yan_ffbnByHzZQQ2', 'May', 'Yang', 'P', '1992-07-03 09:08:00', 'cbcOnYrKhI45OZqOrgE1k2LZSfn7t9OO4dFcO4ajB3mZi6e/Inw5VfR5GSWJQTC7U0GS4oc=', 'cbcOnYrKhI45OZqOrgE1k2LZSfn7t9OOWpBgwCXrmQpcmrkJMJZtCpIiUFTDFGPrB1fDvg==', 'MY', 17, 'SO', NULL, '2021-07-03 09:08:17'),
('Yon_pgP5FOzMeJM2', 'Jason', 'Yong', 'P', '1975-10-20 00:00:00', 'S5ENREqf2ZPlPqg7SETKTXw+ia7XDeWFUVBIe6gbw0Zd2Lr12XiOLjoIn8AwmwxPN8CB/xw2VEVraBk=', 'S5ENREqf2ZPlPqg7SETKTXw+ia7XDeWFmFbhBT/2SDziqGYeNdQ/vWlGwpBsmg1EMbjeoA==', 'MY', 26, 'SO', NULL, '2021-06-12 11:51:00');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_user_address`
--

CREATE TABLE `kypay_user_address` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `addr_type` enum('R','W','O') NOT NULL DEFAULT 'R',
  `line1` varchar(255) DEFAULT NULL,
  `line2` varchar(255) DEFAULT NULL,
  `post_code` varchar(20) DEFAULT NULL,
  `city` varchar(150) DEFAULT NULL,
  `state` varchar(150) DEFAULT NULL,
  `country` varchar(5) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user_address`
--

INSERT INTO `kypay_user_address` (`id`, `addr_type`, `line1`, `line2`, `post_code`, `city`, `state`, `country`, `last_updated`) VALUES
('Che_Rm92ndZL', 'R', 'Lot 5, H68', 'Tmn Sinar Plax', '88844', 'Kota Kinabalu', 'Sabah', 'MY', '2021-06-11 17:31:51'),
('Che_Rm92ndZL', 'W', 'Wisma Kenatex', 'Jln Tuaran', '88844', 'Kota Kinabalu', 'Sabah', 'MY', '2021-06-12 09:25:20');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_user_img`
--

CREATE TABLE `kypay_user_img` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `pid` smallint(2) NOT NULL DEFAULT '1',
  `ptype` enum('P','I') NOT NULL DEFAULT 'P',
  `url` text,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kypay_user_payment_tx`
--

CREATE TABLE `kypay_user_payment_tx` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `uid` varchar(32) NOT NULL DEFAULT 'x',
  `to_uid` varchar(255) DEFAULT NULL,
  `to_uid_type` enum('B','P','E','U') NOT NULL DEFAULT 'U',
  `tx_type` enum('WT','SM','RM','PB','OP') DEFAULT NULL,
  `wallet_ref_id` varchar(16) DEFAULT NULL,
  `to_wallet_ref_id` varchar(16) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `currency` varchar(5) NOT NULL DEFAULT 'MYR',
  `method` varchar(64) DEFAULT NULL,
  `note` varchar(64) DEFAULT NULL,
  `service_id` varchar(128) DEFAULT NULL,
  `stat` enum('S','E','N') NOT NULL DEFAULT 'N',
  `stat_message` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user_payment_tx`
--

INSERT INTO `kypay_user_payment_tx` (`id`, `uid`, `to_uid`, `to_uid_type`, `tx_type`, `wallet_ref_id`, `to_wallet_ref_id`, `amount`, `currency`, `method`, `note`, `service_id`, `stat`, `stat_message`, `last_updated`) VALUES
('01Vi30sv1LCtyM8qjVlXwQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'kypay_send_money', NULL, '2cde9824-d7e8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:09:36'),
('02bbrh0TAlP7SgRNkb2qWg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.25, 'MYR', 'kypay_send_money', NULL, '89e3f689-d950-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 11:09:13'),
('0irXm7VkNRu9DjvIcVSJtQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'kypay_send_money', NULL, '0aaaa1bd-d877-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:12:17'),
('0jdxJyVarlVbaBhpuRaVjQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_affinbank_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:37:33'),
('0uW6JBBlenGttrfTvR4A1A22', 'Che_Rm92ndZL', 'Yan_ffbnByHzZQQ2', 'U', 'SM', 'gjud1v6Yi2Y2', 'ZLHg8jll7no2', -10.00, 'MYR', 'kypay_send_money', 'Trrrrrr', 'f38a8c7f-dd68-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-05 16:14:01'),
('146Zp26NkMjk7ZxsYSDY6A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '8d1af0ee-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:09:33'),
('20hpOb55zzyyIyxs1gLGbw22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -3.00, 'MYR', 'kypay_send_money', 'Payment for Abigail’s food order tomorrow', '11d33ed8-da14-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:28:51'),
('22rSmylJ74Y7CWEccDjFxA22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -10.00, 'MYR', 'kypay_send_money', NULL, '0947e486-da0f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 09:52:58'),
('22ttODMYnUCxfwJvBc2iSg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:44:25'),
('2Rpo7ReBEROkvL4bky9l2Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'kypay_send_money', NULL, '79ddd1e2-d7e9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:18:56'),
('2SVXy81GsdBE1MPO2J20wQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:23:28'),
('2xPPoz2Dlb9dVrBWmHtaWg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.15, 'MYR', 'kypay_send_money', NULL, 'f478778c-d89a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 13:29:21'),
('30Pn5922j0ppgXLbKdrb8A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:55:02'),
('33Av8sAc80FWQXAjDfbv8w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:27:12'),
('3PHrKmEsJSmTQHaVdbZaCw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '4e1b80b8-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:06:45'),
('3voYHQwOdTIVahCfWEYLBQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_affinbank_bank', NULL, 'payment_b42580a3c2482df184f914daacd52d7b', 'S', NULL, '2021-06-27 15:52:28'),
('45P03fOOW2Fuz4Cw7OprSg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '6b389dca-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:25:40'),
('4glf4eo56wfRhgINte2RJg22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 20.00, 'SGD', 'sg_fast_bank', NULL, 'payment_18f527cdf7f4618c78f14de95255b244', 'S', NULL, '2021-07-03 09:40:17'),
('4GQwixhzCGlcR9DLSEePew22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:22:35'),
('4IAtzByeZOwFUhlDRnVBUQ22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -2.30, 'MYR', 'kypay_send_money', NULL, '1f0b6782-d980-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:49:48'),
('4JHPDfaeR3srymp8v31FNA22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Test zzzzz', 'b9d9420e-db9e-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 09:33:54'),
('4kHGvIU4d16HLvxqyR2rNw22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, 'payment_43de00fbd7190ddfc4fa6f5f92524430', 'S', NULL, '2021-07-03 10:51:01'),
('4mmJcBaUGmpHR2ZIiSv02A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '5f3d51be-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:25:20'),
('4PNPSbopnKHCTCfmp9eSgQ22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Teeeeee', '124e8a55-dbd8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:24:24'),
('4UPZIiexzzVm5vj22CGV2A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -50.00, 'MYR', 'kypay_send_money', NULL, '9a5f364f-d7e4-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:44:02'),
('5Cu6ILg5Bl8fuEsJTYCYrA22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -5.00, 'MYR', 'kypay_send_money', NULL, '0164139a-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:56:09'),
('6MstXaJyXmUwB6IIJpjhgA22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 20.00, 'SGD', 'sg_paynow_bank', NULL, 'payment_526148faa666abad6d2c547916d4d252', 'S', NULL, '2021-07-03 09:44:46'),
('6tCtVkJr42yZRDNwB7rgRQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'd8f225ce-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:27:56'),
('7AZpNZLQZsQPS0julSg7Dg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '1368dd64-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:30:22'),
('7bOHLvZxtNmucteL0vLjMg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '0470aba5-d802-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:14:36'),
('7d7O7KLZG0aYE8qC2AeT4w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'dee558b7-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:13:32'),
('7dHatp7qqDchW8qlfFTvUw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_public_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:56:44'),
('7hFTdGVOEI89NpVU3RsApQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '17b034bf-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:46:45'),
('85vLEU1B6CeNdn5ZuFSagQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'a61275cf-d956-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 11:52:56'),
('86H6UTe8y611k1BqbLuAmw22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 12.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_a4db2ceee87759dc159c7d7399fc3c4d', 'S', NULL, '2021-07-03 13:57:14'),
('87Gp2mCICMMIFWePfW6C4w22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Eeeeee ha', '29a35292-dbd7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:17:54'),
('8pC2zNjzhD0q3PNqNMmq7Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '6a0b275a-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:07:33'),
('90Af1obat7x77stV4xYuGA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '23ac60d9-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:31:28'),
('9a29ANkiVQembGqJOJamVA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_amonline_bank', NULL, NULL, 'S', NULL, '2021-06-27 09:58:41'),
('9M1Tz2Zbfv0GXWRdnq6b4g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'f7b3cae8-d94e-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 10:57:59'),
('ac6n9Fvw4P8porr3gzD6sQ22', 'Che_Rm92ndZL', 'Yan_ffbnByHzZQQ2', 'U', 'SM', 'gjud1v6Yi2Y2', 'ZLHg8jll7no2', -20.00, 'MYR', 'kypay_send_money', 'Pay u my dear', '3a652617-dbe3-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 17:44:18'),
('acbvBR8P7uD9yVALq5ZOQQ22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Test 1', 'e8eb2900-dbd7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:23:15'),
('AFRH0C6xoHFS6QEjOUzmXQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_muamalat_bank', NULL, 'payment_3e66954579cca7ca22bbef4ed24599c0', 'S', NULL, '2021-07-05 10:03:50'),
('Aj233TPvMX0bIcn87lFfUQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ef63c28f-d876-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:11:31'),
('aLgmPHB0UWbZBxAkAdWvOw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 0.00, 'MYR', 'kypay_send_money', NULL, NULL, 'S', NULL, '2021-06-28 10:50:01'),
('aN3xTYC1b2zAjIY5sCsylg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '3252d648-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:05:59'),
('AwbxLkF52lXefZBsNOboyg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.50, 'MYR', 'kypay_send_money', NULL, '3b1cd167-d94f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 10:59:49'),
('AzfrJkPemq18xxg71jh0wQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:41:09'),
('B9JjqdriinSebxv88OXA9w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:28:22'),
('BdX1bNYnSsJnga9dWlrtxw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '5c56ec2a-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:08:12'),
('Bf3lVFC8TnQw5Qgcc2SpHw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_ocbc_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:48:10'),
('bGpExs59xLB7B9sCOV8h5A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ce1968d7-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:44:41'),
('bKV61Z2NoylUf3kZFbvpOQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'kypay_send_money', NULL, '8d33ddf6-d94f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 11:02:07'),
('bok4h2jxDb6YdrtVXVAL2w22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -20.00, 'MYR', 'kypay_send_money', 'Tx RM 20 for Abigail’s uniform order', 'e4d16195-da13-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:27:35'),
('bokyZ4GaOKERrUlFAuPtoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '3e4438bd-d7ee-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:53:03'),
('Bq57Zw0qjWNQbMy5OS8aKA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'fd6fe424-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:30:25'),
('cc2zFUwF6whwBqxjVt0x8Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_standardchartered_bank', NULL, 'payment_c5bb131c30e0e09edd29a1389df73f65', 'S', NULL, '2021-06-27 17:03:27'),
('cCj1Mxd8N7LCqedomGJkkg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_islam_bank', NULL, 'payment_c9209fabcba62b69bbf0754694efc97e', 'S', NULL, '2021-06-28 19:40:19'),
('CfZrSrFyP7WyuG9RSI6enA22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.20, 'MYR', 'kypay_send_money', NULL, 'f2e34c44-d97a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:12:47'),
('CI3T8RKkFBIskcShOYk2pw22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'payment_8dac2f8d6c47694c8cd735d03f5cb4b3', 'S', NULL, '2021-07-03 13:48:39'),
('Ci4GLd1GBPlb9a6gGbDXNw22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -3.00, 'MYR', 'kypay_send_money', 'Test rrrrrr', '73f592cb-dbd4-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 15:58:30'),
('CXUR9W2GW7lADM1SFGHbVg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -10.00, 'MYR', 'kypay_send_money', 'Test 10', '54a2ab89-db12-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-02 16:48:55'),
('daOPFJep9nEpaUHm0uQY9g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, NULL, 'S', NULL, '2021-06-25 17:13:10'),
('DcETebLid6C7NLnbhnC5Jg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_islam_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:51:33'),
('dgruSceuBpxzH6BCKZbuYg22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -2.00, 'MYR', 'kypay_send_money', NULL, '753ad16f-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:59:22'),
('dGTzq9NixtZBB78uNyE9Nw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'c376afe3-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:55:43'),
('dh2eunjXlwZFaEnmRx4fYQ22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 34.13, 'MYR', NULL, NULL, NULL, 'N', NULL, '2021-06-16 08:57:05'),
('dRt7TKl2zxZWnpDM6W3q1g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, 0.00, 'MYR', 'kypay_send_money', NULL, 'b15561be-d7e3-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:37:31'),
('dWBhgyQx6pblrEOR987rog22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'a65b46fe-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:10:16'),
('dWubi2tJvIebHsbw62jZwg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'bbd40ce6-d869-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:37:01'),
('dxhh8k0ztHe9CRWhuBzVAg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 30.00, 'MYR', 'my_maybank_bank', NULL, 'payment_0e0d278a9dc213f7571fae672fdab444', 'S', NULL, '2021-06-30 20:23:00'),
('e0DEqTHmP2ZNfpLoYnoPqg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -20.00, 'MYR', 'kypay_send_money', 'Test transfer information rm20 just for fun only', 'e044f0c1-da11-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:13:09'),
('E3RXneI8BcfMHUcoNsNKLg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_e18a375bcc707f4bdb16dc55a13eb920', 'S', NULL, '2021-06-28 15:26:40'),
('E8gfvMILco1bxjQsS2Ci7Q22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 49.17, 'MYR', NULL, NULL, NULL, 'N', NULL, '2021-06-16 08:57:00'),
('Ea1bT0br46dQDbc6bXc11Q22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_rakyat_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:52:01'),
('EalpSnNE84UudSBKAslZYw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_ocbc_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:24:34'),
('ebs8H7A8kcJyeoqky9MfbQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b7ee2942-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:28:27'),
('Ef2IeYxbxdCOhoFzvkiW5g22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -3.00, 'MYR', 'kypay_send_money', 'Test sending 3 only', '0d311201-db1d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-02 18:05:41'),
('EfiztJ0MeX4WCFtlyGM1xA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_rhb_bank', NULL, 'payment_bebcfb8b9dd8f5b639469cabafba12bf', 'S', NULL, '2021-06-27 15:48:51'),
('eqO4IeL6W6TfAbFYcAsH2w22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_hsbc_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:46:41'),
('F83TEWSEEko8mZHC92Bmdg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '8442804c-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:11:00'),
('FE3JIOny8gSMVCkEfvPHoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '66a686a4-d7ed-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:47:01'),
('fp2APpn6bQKxeIEiqj7Z5w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '32bfd566-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:14:11'),
('Fr6Ozp43Eqx7dGmSI5L0Lw22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', '', 'cbebc452-da13-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:26:54'),
('G0VxPaCG22PwV4nsRkhzHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 13.00, 'MYR', 'my_maybank_bank', NULL, 'payment_341702ea0aa3d3b5a60c400bf563c8e0', 'S', NULL, '2021-06-28 11:52:53'),
('G930QarRQMd4bvIrcVmjbQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_kuwaitfinancehouse_bank', NULL, 'payment_fc756371b2e0af7b87fa866c61bb4fea', 'S', NULL, '2021-06-28 11:54:37'),
('gbd7BIdW7wJq1j80Q9JiHQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '64522c8a-d86d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:03:12'),
('gfy0XxtIHerSXEd69EUyMg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'a01685cb-d94d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 10:48:21'),
('gk27UbRN2LulyMPWYjD2YQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'my_islam_bank', NULL, 'payment_5d52c0fa092bff41e1c15dfedf2b012e', 'S', NULL, '2021-07-02 18:04:46'),
('Goog1VOeYkDbH7tZkTeiKg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.60, 'MYR', 'kypay_send_money', NULL, 'c9addc88-d99d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 20:22:09'),
('GpQK7NdZU1np6C1ycJOAGA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '5ff5242b-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:48:46'),
('gqH7Z1sqj2Wk2joNQH0qKQ22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 33.85, 'MYR', NULL, NULL, NULL, 'N', NULL, '2021-06-16 08:55:24'),
('gsKUefqDPvBNOprOLMVHqw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -12.00, 'MYR', 'kypay_send_money', NULL, '583ffa16-d7e2-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:27:52'),
('gTuaP9ZQB5vLNd5jcmHCOQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:22:53'),
('gzFpaiCbyU30lPZRq0dQZw22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', NULL, 'd0756bdf-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 17:01:55'),
('h080o6fOTAye7SIHmNCMbw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_islam_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:43:07'),
('Hmd2CpTMN6HwqIlLfa81TQ22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Tttttt', 'ada230b2-dbd8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:28:45'),
('HvGUkCCWmQAFWpwZuaQ9UQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:52:10'),
('hyaA913kL9GSZ4G7jI5Hsg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.50, 'MYR', 'kypay_send_money', NULL, '3d33718d-d959-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 12:11:28'),
('hYVPFxVwtN9kydZbJPj3AQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-25 12:49:50'),
('hZDGifQsQac2rIV3M55hmg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '41adbb3f-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:40:46'),
('I6I3Hg0x4HZ65szvm9i9Ow22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Payment for Abigail’s uniform ', '462fc05e-da10-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:01:41'),
('IE7CmQcvwtKG8bqf5hln6g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'kypay_send_money', NULL, '5cd08c46-d94c-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 10:39:19'),
('IOzyf5HU8HZ2JWfJ8XlZhw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'abadb8c0-d86d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:05:12'),
('iPhqjISgLxsJpZGYEKvjRw22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -20.00, 'MYR', 'kypay_send_money', NULL, '35d59ddc-d99d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 20:18:01'),
('iSIGaqBKbZ8wCHuyJrJROQ22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.20, 'MYR', 'kypay_send_money', 'Test 2.20', '751dd173-db1d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-02 18:08:34'),
('iSwy32xZpbMMU0cW3SUQrw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ae61f191-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:12:12'),
('IvMo3IpoUBuXEZvdgCrmEA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '0f1f3aff-d808-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:57:50'),
('Iw1GE8mVwWTsTEUeUIwGTw22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -10.00, 'MYR', 'kypay_send_money', NULL, '53c90410-d99b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 20:04:32'),
('IyJzeVKdmQb9TPXwp4Vdpw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 33.00, 'MYR', 'my_standardchartered_bank', NULL, 'payment_56e00f7f744af05480b43c796b532cae', 'S', NULL, '2021-06-28 19:44:10'),
('iySNyGIsNW2TTSx1qBIPHA22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.09, 'MYR', 'kypay_send_money', 'Trrrrr', 'dcb7ec5c-dbd9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:37:13'),
('j93tBtfuqOCTGsfwGdeNoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ac6d48dc-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:35:17'),
('j94qiPsbn2m2v7PMp3imQg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:10:46'),
('J96rKbz0t3F0dngqeW7XOQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_rhb_bank', NULL, NULL, 'S', NULL, '2021-06-28 11:41:09'),
('JPf6ZJ8I6WmpXQpXzNOM9g22', 'Che_Rm92ndZL', 'Yan_ffbnByHzZQQ2', 'U', 'SM', 'gjud1v6Yi2Y2', 'ZLHg8jll7no2', -2.00, 'MYR', 'kypay_send_money', 'Teeeeeeee', '14b62d36-dd6d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-05 16:43:35'),
('jQdKontYpUAohMtU2hSO4w22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -3.50, 'MYR', 'kypay_send_money', NULL, '5b1834de-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:58:38'),
('JrCzvkVOTpz20bAVrUceGA22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_25fd8a754c36e9b923ec84cfd0dc5157', 'S', NULL, '2021-07-03 10:47:46'),
('jrXR8C2KrKNTvVlnfC5Z2A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.10, 'MYR', 'kypay_send_money', NULL, '991025b5-d950-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 11:09:37'),
('jtkeE9nF9imw21x66WDdTw22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -3.60, 'MYR', 'kypay_send_money', NULL, '822cf445-d980-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:52:34'),
('jwTk0xz0QyB6qiV3ADFVGw22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 20.00, 'MYR', 'us_visa_card', NULL, 'payment_d0cb03842067519aeb61dc1dd8185b0f', 'S', NULL, '2021-07-03 14:00:38'),
('jY0CApCWrepZP8O2BJ01lA22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.00, 'MYR', 'kypay_send_money', NULL, 'f1d94c07-d97e-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:41:22'),
('JZc7wjz2Q9ntnp2BSY8fVw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '880f5034-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:33:38'),
('k2XSVF3IT3lue0e0h622YQ22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.00, 'MYR', 'kypay_send_money', NULL, '5c37db42-d97b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:15:44'),
('K54RRaA2QuSpJmkbJlBfcA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b9128cd6-d80b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:24:04'),
('KJ1xqq3rPVODikUbLCtv2Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '718f12eb-d7ed-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:47:19'),
('KJSUqeHfzAzbqV7TXlHegg22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Rrrrrr', 'de94f623-dbd8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:30:07'),
('kXPQ8L2sHPIp1o75b4rBtQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '08754b4b-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:13:00'),
('lUoB4940bZWYyCybPLGbQQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b852a4ed-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:10:46'),
('lYLZ5P12ry23EVONtZHiSg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -3.20, 'MYR', 'kypay_send_money', NULL, 'aa2db8ae-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 17:00:50'),
('m16e28BQ7Et26ifQ2W3gTg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b9b44269-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:03:39'),
('M2HeZPVDdx24T6jhmDDKKw22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.00, 'MYR', 'kypay_send_money', NULL, '0a3e21a1-d980-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:49:13'),
('MHy0vk9oQbTBZIbAxu6KlA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, NULL, 'S', NULL, '2021-06-25 17:11:50'),
('MMGdRDAvLgXDd7oQBSi8og22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '262f1e10-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:12:48'),
('MPlvbacGZ7Wv4bXPa4r8Dg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'e8abdcb8-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:56:48'),
('MPSLdX2Q0S99aueLX3tIOA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 20.00, 'MYR', 'my_maybank_bank', NULL, 'payment_84c04ed4cf350fa5ab3474799a33b7a8', 'S', NULL, '2021-06-30 21:40:08'),
('MRHt8wx2DJohgNmV1p8Q9w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'kypay_send_money', NULL, '38124f23-d7e5-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:48:26'),
('mSh4grwG2pGKjxia2vy7sA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '892b93cc-d86f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:18:33'),
('mxcrZV0CGUljB20UzRVt6w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '0c950e86-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:30:49'),
('mXYAu0jihJ8nN23yTbC2Tw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_affinbank_bank', NULL, NULL, 'S', NULL, '2021-06-28 11:50:51'),
('N4RYYyOh7G13dAbABQZ1uQ22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.50, 'MYR', 'kypay_send_money', NULL, '33c9bca5-d980-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:50:22'),
('nBjndgeDBaoXb1a32FYA6A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_rhb_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:21:28'),
('nKEJW359tpJ0yL29CEZflQ22', 'Yan_ffbnByHzZQQ2', 'Yan_ffbnByHzZQQ2', 'U', 'WT', 'ZLHg8jll7no2', NULL, 10.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_ac34c849aa1d88bd94a641b932f431c1', 'S', NULL, '2021-07-03 09:32:16'),
('nMvA7vl1hUrDgs6nfL8shw22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 20.00, 'SGD', 'sg_fast_bank', NULL, 'payment_f8e0304bdaf0a81da77e8034c8acad5d', 'S', NULL, '2021-07-03 09:38:24'),
('nnCrCM61d8VVfrz717GsYA22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 20.00, 'SGD', 'sg_fast_bank', NULL, 'payment_f430d8bc072257eb5fd1731c0ccbbd87', 'S', NULL, '2021-07-03 09:44:20'),
('NpABJtjc2B3I8bKxmAlwUg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', NULL, '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:18:42'),
('NVijCr8cvqUtiIBMKGdM4Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'fb210f27-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:28:54'),
('nwTXbtag8BsgHv8uTt8S8g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '36659eef-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:13:15'),
('o62CT23xNIliKtjOTWikJQ22', 'Yan_ffbnByHzZQQ2', 'Yan_ffbnByHzZQQ2', 'U', 'WT', 'ZLHg8jll7no2', NULL, 10.00, 'MYR', 'my_rakyat_bank', NULL, 'payment_88468b6466be3411ebbb00e6c14f721d', 'S', NULL, '2021-07-03 09:35:18'),
('OAfDDbC5fYbFGu7eP3Re2g22', 'Yan_ffbnByHzZQQ2', 'Yan_ffbnByHzZQQ2', 'U', 'WT', 'ZLHg8jll7no2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'payment_acb14a9eb14a67fb7533c52c11ada37a', 'S', NULL, '2021-07-03 15:24:30'),
('obEHQB1jnoEtkbae7eSvkQ22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -3.00, 'MYR', 'kypay_send_money', 'Testing yyy', '4b5e5544-dbd0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 15:28:44'),
('OkxO2fmeW1Dj7P9w6Cbw8Q22', 'Che_Rm92ndZL', 'Yan_ffbnByHzZQQ2', 'U', 'SM', 'gjud1v6Yi2Y2', 'ZLHg8jll7no2', -10.00, 'MYR', 'kypay_send_money', 'Return ', 'd9af3ad6-dbe2-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 17:41:35'),
('OMEbIxPQSvmTnNlFcgsJhg22', 'Teo_bKVBIrH0XFI2', 'Che_Rm92ndZL', 'U', 'SM', 'BzDVyp8M60A2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Test fr chris teo', '6481a3d1-dba9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 10:50:16'),
('OwIRqSXPijIgZIFjdNcjgA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '96f327d7-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:43:09'),
('ozBeFWctivwXd3FehSAdJg22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'payment_48b7332fa8882b71d4f13672d6a9a319', 'S', NULL, '2021-07-03 13:45:53'),
('p2BbwMhejtnMH0QeSZbV8A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ab25a487-d80b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:23:42'),
('p2ELaRW8RCXPnmwY7zUNtA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'afcd5047-d94e-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 10:55:56'),
('p5ce7R3MeeQm9lyX3PQ4ig22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -3.60, 'MYR', 'kypay_send_money', NULL, 'e7a50de7-d981-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 17:02:34'),
('pbZg2Mf2ruUB3xhNNhg6Bg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '7c2711d4-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:33:18'),
('PYZum0j734w5KSJ6sUvqcg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Test la how are you ??????', 'b08c0137-da11-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:11:50'),
('Q2nPai8yE75j8BxEPemmnA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b6497a39-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:26:58'),
('QEeBes9jL2zwaaX3D6MkRQ22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -1.00, 'MYR', 'kypay_send_money', 'Return ', '56b97453-dbe3-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 17:45:03'),
('QMtk0RQZbQO5UzdYpkzKQQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '321bded1-d7ee-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:52:42'),
('qQvoNq7syrNy5QmPb9opdw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'bf79fbd8-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:28:40'),
('QSzGRztcRFa2l6To9qvM4A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, NULL, 'S', NULL, '2021-06-25 16:57:00'),
('qx5CUULnBtYbbWk39lEJJA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '3fe1f434-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:14:33'),
('QYublyj4n2BDHJsouwY28Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'c4fba82d-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:04:02'),
('reMZGaQjUnEDhDgfvhmCHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'f6c7243d-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:57:09'),
('RKaGsEKzVDCcLVb0IsBw1w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '70de70c9-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:14:53'),
('RQkyqD008Lu4etHHiTbuXg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -12.00, 'MYR', 'kypay_send_money', NULL, 'e9fbacb5-d980-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:55:28'),
('RwjUoxbMq30vb69FDbIbRw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'ad929276-d94f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 11:03:02'),
('RZkcG6PS59uBT2sulrQpyQ22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', NULL, '6c0a2130-da0f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 09:55:35'),
('S1Sdmi5pU4t6pC6eAtz5TQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, NULL, 'S', NULL, '2021-06-25 10:36:09'),
('SC6yHried2CrwdIZGj5UzA22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 15.30, 'MYR', NULL, NULL, NULL, 'N', NULL, '2021-06-16 08:55:18'),
('Sl7nfxTCMLHlKFy4guVxCQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'e3445b1c-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:29:03'),
('svpzL8H0GQ2iColDZUK8NA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '9e042699-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:34:53'),
('T89DuLKb7K9fKPZv2XF4bA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_cimb_bank', NULL, 'payment_11910c01847b459725e0ed00dc4c4844', 'S', NULL, '2021-06-29 17:28:19'),
('tuFCTfRuN5hJqgV2IhUqaA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_maybank_bank', NULL, 'payment_7364c2ff9adc41796da297cb8521c355', 'S', NULL, '2021-06-28 11:54:02'),
('TuyoKQpteJHUzt6KE0W1gA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 11:48:49'),
('TVe4yjCdcQPNDj79yCBhHg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'e530535a-d8ac-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 15:37:49'),
('TvQXVbJWxtUZyVtUuKBi1Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -5.00, 'MYR', 'kypay_send_money', NULL, '224df46c-d7e5-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:47:51'),
('TW0qUezuhOHkueR7y2YvZQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-28 11:46:22'),
('TWz7R42HuRb8AWMKpOfPEQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '4e43740d-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:07:48'),
('u3YWbbQRE33rx1QbIlcSZw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '03ebf05e-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:58:35'),
('UDz7hsWG3Lx4zjCMTcbQNA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 30.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_2472dd925f5e36af14a2e0ac153103c9', 'S', NULL, '2021-06-28 17:07:31'),
('UKTPpVEVF0Cy7Nd2dGVcgw22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.00, 'MYR', 'kypay_send_money', NULL, '856b1d6e-d97f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:45:30'),
('UssUsBM4GX2IedGT8BGEQg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', NULL, '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-25 09:40:22'),
('v29amR4akbzBcE2yOdMxSg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'd01da133-d86c-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:59:03'),
('vAbKetrpsKiAH6DNXOoryw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 200.00, 'MYR', 'my_simpanannasional_bank', NULL, 'payment_3b1e6a683869c0a9905def4db1afe69c', 'S', NULL, '2021-07-05 16:15:33'),
('vbiBNWXpInyDgiGvsd3Y4w22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -10.00, 'MYR', 'kypay_send_money', NULL, '1352e369-da0e-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 09:45:56'),
('vbJfFGT2CS5vg5rNBBMeGQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, NULL, 'S', NULL, '2021-06-25 11:02:38'),
('vjEVyJ43B70p4SyTKFjThg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '4a80022f-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:41:00'),
('VKuSyPEK4k4cJmbW40YbDA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '7aba6d40-d86c-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:56:40'),
('VlEHhfrRB0U0cx0NHeaDgw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, NULL, 'S', NULL, '2021-06-25 17:09:04'),
('VN8dtdhQOmE5gD3KJbOL1w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'kypay_send_money', NULL, '099f6233-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:01:27'),
('vpTXZdUbBAxAn2i1ubajuQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '3a747603-d7e8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:09:59'),
('VurtMEQacsjj9f629Lv7vg22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Testtttt', 'e0461932-dbd6-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:15:51'),
('VvR2gFbIAeSZuioaVcaFfg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 12.00, 'MYR', 'my_islam_bank', NULL, 'payment_ea04657807179a766eadc2d0c68a301e', 'S', NULL, '2021-07-02 16:51:40'),
('vxnjuBP9ghbW6ysdjoDoPw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_islam_bank', NULL, NULL, 'S', NULL, '2021-06-25 11:07:33'),
('VY2XCKdSvSXPUDDIjxnh9g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-25 12:48:59'),
('vYS2eJ8VG5Y2SRmEsvpozg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '7a9c2b18-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:33:54'),
('W1pxA4wxvmsPpOOA2SK2Yg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Test haha', 'd4aadb58-da0f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 09:58:30'),
('WbMSHWHyQoed62AQNRCOHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'c30fbd68-d874-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:55:58'),
('wftCqV3OsjCLt7BIfKsJcA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '464021a6-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:48:03'),
('wH7NgBJe20bbV5upv9dVIQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '6a4671a5-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:49:04'),
('wm4BRF9Xl37zNO419d6Wlw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-27 09:42:42'),
('womCPZVpQHhQqUvTRDvMeg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_simpanannasional_bank', NULL, 'payment_8d799a95045647edfa2b1eb7b0e92c30', 'S', NULL, '2021-06-28 19:42:41'),
('wPHIeUtVOhFC2iubfNTVDA22', 'Teo_bKVBIrH0XFI2', 'Che_Rm92ndZL', 'U', 'SM', 'BzDVyp8M60A2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Test sending', '273a14e7-dbc4-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 14:01:49'),
('wQbTY9R4FIYEDWPKC7NaBA22', 'Yan_ffbnByHzZQQ2', 'Yan_ffbnByHzZQQ2', 'U', 'WT', 'ZLHg8jll7no2', NULL, 10.00, 'MYR', 'my_islam_bank', NULL, 'payment_206d1a12d4fab4d668d8727498e84e65', 'S', NULL, '2021-07-04 13:53:44'),
('WQYwfzFIhfW9yAC2Pay71w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '911682b9-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:11:24'),
('WuGS1FDaqbKpBScndNOXsg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 25.00, 'MYR', 'my_kuwaitfinancehouse_bank', NULL, 'payment_4e71d63eba01848403195327fe48814d', 'S', NULL, '2021-07-02 18:07:39'),
('wYXCXANap82KvtbaztJldQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -130.00, 'MYR', 'kypay_send_money', NULL, NULL, 'S', NULL, '2021-06-28 15:42:31'),
('xdHX6n2gzR7aCe60gxZofA22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -2.03, 'MYR', 'kypay_send_money', 'Test la', 'a75ee769-dbe3-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 17:47:19'),
('xj2QWO5OKccx5KML1ikS4w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '81961371-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:15:23'),
('xoYP7SQYsb2utCgxfbFazA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'b8dc098c-d877-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:17:09'),
('XpzMsEnAcisUWIyBQR2Tbg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'my_alliancebank_bank', NULL, 'payment_39bc37ab02c5e9f381ee6639b2c21cf1', 'S', NULL, '2021-07-02 16:48:07'),
('XtQPo994ANmCHynqybE3vg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_public_bank', NULL, NULL, 'S', NULL, '2021-06-27 11:37:44'),
('XXd2TIbvTLbbfkzDTld6lA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '2eb86204-d86f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:16:01'),
('XyK11NhUwIi8xaEavbNPHA22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Rrrrrr', '2502bd69-dbd9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:32:05'),
('XZNdPEf7fjlBoYnQw84bbw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:27:32'),
('Y34Ej3ZCCYuXGhYuODef0w22', 'Yan_ffbnByHzZQQ2', 'Che_Rm92ndZL', 'U', 'SM', 'ZLHg8jll7no2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Gffgggg', '09e74d2b-dbd7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-03 16:17:01'),
('ygJlWLz2VUUeGZVLtXl2Dw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'kypay_send_money', NULL, '2b15be0a-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:02:23'),
('yhY4dM2eAaOvNKpzBclg4Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '967273da-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:27:31'),
('yOk2EdGbaCoKoqRiwTagOA22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -2.00, 'MYR', 'kypay_send_money', 'Test note haha tx u rm2', '751dd0ac-da11-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-01 10:10:09'),
('YXlswOtw0bIB47bdU9MKrg22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 10.00, 'SGD', 'sg_enets_bank', NULL, 'payment_16ccd8146928009d446560ae0fd78b2e', 'S', NULL, '2021-07-03 14:10:20'),
('YzSVudYB6nn1IdbTffbI1g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_hsbc_bank', NULL, 'payment_98797b0a6ebb3b865d548502b217c37b', 'S', NULL, '2021-06-27 15:45:49'),
('z5nntvB9mUovvXXC7KIU2g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_hongleong_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:23:55'),
('Za6ViGga2jbcfCUmdGmOcA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 21.00, 'MYR', 'my_alliancebank_bank', NULL, NULL, 'S', NULL, '2021-06-25 17:29:34'),
('ZA8eA0BuEExWidykcxixeg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, 'f8870bcb-d7e9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:22:27'),
('zGf2h5L4GOzAQKbw64BvbQ22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'payment_29378a70a853cb18afa7a55c03422f02', 'S', NULL, '2021-07-03 13:55:09'),
('zLtCncy9VXBlaGB0eHWgAQ22', 'Che_Rm92ndZL', 'Cha_BCmFOsbhcm02', 'U', 'SM', 'gjud1v6Yi2Y2', '5FAwvqtWVRs2', -1.00, 'MYR', 'kypay_send_money', NULL, 'd916117c-d97f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 16:47:50'),
('ZNq12oacdrjcSWRnAqOCdg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_cimb_bank', NULL, NULL, 'S', NULL, '2021-06-27 15:43:26'),
('ZpYEUWyJDYYXCix2n5i8qA22', 'Che_Rm92ndZL', 'Yan_ffbnByHzZQQ2', 'U', 'SM', 'gjud1v6Yi2Y2', 'ZLHg8jll7no2', -10.00, 'MYR', 'kypay_send_money', 'Test ', '8092a22c-dc95-11eb-b38b-02240218ee6d', 'S', NULL, '2021-07-04 15:00:24'),
('Zq2ygVhkzxAbShhJiqjC5w22', 'Teo_bKVBIrH0XFI2', 'Teo_bKVBIrH0XFI2', 'U', 'WT', 'BzDVyp8M60A2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'payment_7b81c5a62ab8c834f8cb55e72e93f0c3', 'S', NULL, '2021-07-03 13:59:11'),
('Zsrg232xneLhvh01qYn5Rg22', 'Cha_BCmFOsbhcm02', 'Che_Rm92ndZL', 'U', 'SM', '5FAwvqtWVRs2', 'gjud1v6Yi2Y2', -3.00, 'MYR', 'kypay_send_money', NULL, '491fa0bc-d99d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-30 20:18:35'),
('Zvm7hh6ZGm7Nui24poja1Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'kypay_send_money', NULL, 'b85bf429-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:06:20'),
('ZwKTDvI5RJznmiLSh9u7PQ22', 'Wan_82u6cg9obZc2', 'Wan_82u6cg9obZc2', 'U', 'WT', 'coEjXC6NmV42', NULL, 10.00, 'SGD', 'us_visa_card', NULL, 'payment_c0c227ac36710a6a0b66e340aacc8ff1', 'S', NULL, '2021-07-03 14:07:08'),
('Zwr7RmMT70INuz8373zICw22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 26.88, 'MYR', NULL, NULL, NULL, 'N', NULL, '2021-06-16 08:56:53'),
('zwZTWVF9ge2SRLdqrjBkGw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 11.00, 'MYR', 'my_muamalat_bank', NULL, NULL, 'S', NULL, '2021-06-27 09:22:18'),
('ZYn20DQFQFUQuWmuUfcZsg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'kypay_send_money', NULL, '0539f726-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:29:58');

-- --------------------------------------------------------

--
-- Table structure for table `kypay_user_wallet`
--

CREATE TABLE `kypay_user_wallet` (
  `id` varchar(32) NOT NULL DEFAULT 'x',
  `ref_id` varchar(16) NOT NULL DEFAULT 'x',
  `balance` float(10,2) DEFAULT NULL,
  `currency` varchar(5) NOT NULL DEFAULT 'MYR',
  `type` enum('B','P') NOT NULL DEFAULT 'P',
  `service_addr_id` varchar(128) DEFAULT NULL,
  `service_contact_id` varchar(128) DEFAULT NULL,
  `service_cust_id` varchar(128) DEFAULT NULL,
  `service_po_ben_id` varchar(128) DEFAULT NULL,
  `service_po_sender_id` varchar(128) DEFAULT NULL,
  `service_wallet_id` varchar(128) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user_wallet`
--

INSERT INTO `kypay_user_wallet` (`id`, `ref_id`, `balance`, `currency`, `type`, `service_addr_id`, `service_contact_id`, `service_cust_id`, `service_po_ben_id`, `service_po_sender_id`, `service_wallet_id`, `last_updated`) VALUES
('Cha_BCmFOsbhcm02', '5FAwvqtWVRs2', 168.20, 'MYR', 'P', 'address_19b2cf30bb21632df521fdaf5aab5ed1', 'cont_1c251ee25b4d0464c9a555818784a2f9', 'cus_9e0963b6e0db22f4e5d21e80db70952b', NULL, 'sender_52da87fa037b0741eebf8ddc55976f85', 'ewallet_69bb819addd90f6750dfd645a3af0c40', '2021-06-30 20:23:00'),
('Che_Rm92ndZL', 'gjud1v6Yi2Y2', 383.92, 'MYR', 'P', 'address_7c43774d4b62495b62af4d0d9285f2fb', 'cont_3db76f3e88eea5e18e7d2fb10e8dad8f', 'cus_984be6751fedb6702e8b57c55d06982d', NULL, NULL, 'ewallet_ea94db770b966314504eafdb8ecbe603', '2021-07-05 16:43:35'),
('Kin_pe23WUO3ZwE2', '0NZ2vaDtoPA2', 0.00, 'USD', 'P', 'address_425584f96542d5032664592a95b0a289', 'cont_74fbf83102ad34c1188aab6a804c9d91', 'cus_f2aa4f94fcd9ad708ae83e11dcdeae08', NULL, NULL, 'ewallet_bfa042323fcd6e85ed84747b968c1257', '2021-07-03 10:25:07'),
('Tan_Kql018jlkyo2', 'UW7SK3YVMXE2', 200.80, 'MYR', 'P', 'address_7c43774d4b62495b62af4d0d9285f2fb', 'cont_3db76f3e88eea5e18e7d2fb10e8dad8f', 'cus_99ce848db401cf2b1cf2d4fa49fe541b', NULL, NULL, 'ewallet_ea94db770b966314504eafdb8ecbe603', '2021-07-03 10:42:09'),
('Teo_bKVBIrH0XFI2', 'BzDVyp8M60A2', 99.00, 'MYR', 'P', 'address_2f8964b84cf0a049c66d41b8868db141', 'cont_00506872a545fa318675aa1ec7844450', 'cus_f905469d72b7fdf8d5a5392ea445ef5e', NULL, NULL, 'ewallet_59534311fd8ad71096cebd25ff1bb867', '2021-07-03 14:01:49'),
('Wan_82u6cg9obZc2', 'coEjXC6NmV42', 100.00, 'SGD', 'P', 'address_d11a384ddc15b6c3044c95c6c6f4ec69', 'cont_7bb2f279a10680f4362bde0295f49195', 'cus_8eb8251bf97374cdcf239764cb07ac7b', NULL, NULL, 'ewallet_c6d8ae333585425da53a01d24c86af81', '2021-07-03 14:10:20'),
('Yan_ffbnByHzZQQ2', 'ZLHg8jll7no2', 68.88, 'MYR', 'P', 'address_fa88daedeb2a1809a6a37b3485c3f579', 'cont_8c1295ef67aa28629c3ea1a302388d85', 'cus_2868e186b61d360c53eb19d3bf0119df', NULL, NULL, 'ewallet_1058fdfd2c61bb7c8b904d1d6ee95a36', '2021-07-03 09:35:18'),
('Yon_pgP5FOzMeJM2', 'pgUrZV69ElU2', 0.00, 'MYR', 'P', NULL, NULL, NULL, NULL, NULL, NULL, '2021-06-20 09:50:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kypay_biller`
--
ALTER TABLE `kypay_biller`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kypay_device_token`
--
ALTER TABLE `kypay_device_token`
  ADD PRIMARY KEY (`id`,`token`);

--
-- Indexes for table `kypay_message`
--
ALTER TABLE `kypay_message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kypay_order`
--
ALTER TABLE `kypay_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `kypay_seller`
--
ALTER TABLE `kypay_seller`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `kypay_seller_category`
--
ALTER TABLE `kypay_seller_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kypay_seller_item`
--
ALTER TABLE `kypay_seller_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `kypay_seller_item_image`
--
ALTER TABLE `kypay_seller_item_image`
  ADD PRIMARY KEY (`id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `kypay_seller_order`
--
ALTER TABLE `kypay_seller_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `seller_id` (`seller_id`);

--
-- Indexes for table `kypay_seller_order_item`
--
ALTER TABLE `kypay_seller_order_item`
  ADD PRIMARY KEY (`seller_order_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `kypay_user`
--
ALTER TABLE `kypay_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_idx` (`phone_number`),
  ADD KEY `email_idx` (`email`);

--
-- Indexes for table `kypay_user_address`
--
ALTER TABLE `kypay_user_address`
  ADD PRIMARY KEY (`id`,`addr_type`);

--
-- Indexes for table `kypay_user_img`
--
ALTER TABLE `kypay_user_img`
  ADD PRIMARY KEY (`id`,`pid`);

--
-- Indexes for table `kypay_user_payment_tx`
--
ALTER TABLE `kypay_user_payment_tx`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `kypay_user_wallet`
--
ALTER TABLE `kypay_user_wallet`
  ADD PRIMARY KEY (`id`,`ref_id`),
  ADD UNIQUE KEY `wallet_uidx` (`id`,`type`,`currency`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kypay_order`
--
ALTER TABLE `kypay_order`
  ADD CONSTRAINT `kypay_order_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `kypay_user` (`id`);

--
-- Constraints for table `kypay_seller`
--
ALTER TABLE `kypay_seller`
  ADD CONSTRAINT `kypay_seller_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `kypay_user` (`id`);

--
-- Constraints for table `kypay_seller_item`
--
ALTER TABLE `kypay_seller_item`
  ADD CONSTRAINT `kypay_seller_item_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `kypay_seller` (`id`),
  ADD CONSTRAINT `kypay_seller_item_ibfk_2` FOREIGN KEY (`category`) REFERENCES `kypay_seller_category` (`id`);

--
-- Constraints for table `kypay_seller_item_image`
--
ALTER TABLE `kypay_seller_item_image`
  ADD CONSTRAINT `kypay_seller_item_image_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `kypay_seller_item` (`id`);

--
-- Constraints for table `kypay_seller_order`
--
ALTER TABLE `kypay_seller_order`
  ADD CONSTRAINT `kypay_seller_order_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `kypay_order` (`id`),
  ADD CONSTRAINT `kypay_seller_order_ibfk_2` FOREIGN KEY (`seller_id`) REFERENCES `kypay_seller` (`id`);

--
-- Constraints for table `kypay_seller_order_item`
--
ALTER TABLE `kypay_seller_order_item`
  ADD CONSTRAINT `kypay_seller_order_item_ibfk_1` FOREIGN KEY (`seller_order_id`) REFERENCES `kypay_seller_order` (`id`),
  ADD CONSTRAINT `kypay_seller_order_item_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `kypay_seller_item` (`id`);

--
-- Constraints for table `kypay_user_address`
--
ALTER TABLE `kypay_user_address`
  ADD CONSTRAINT `kypay_user_address_ibfk_1` FOREIGN KEY (`id`) REFERENCES `kypay_user` (`id`);

--
-- Constraints for table `kypay_user_img`
--
ALTER TABLE `kypay_user_img`
  ADD CONSTRAINT `kypay_user_img_ibfk_1` FOREIGN KEY (`id`) REFERENCES `kypay_user` (`id`);

--
-- Constraints for table `kypay_user_payment_tx`
--
ALTER TABLE `kypay_user_payment_tx`
  ADD CONSTRAINT `kypay_user_payment_tx_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `kypay_user` (`id`);

--
-- Constraints for table `kypay_user_wallet`
--
ALTER TABLE `kypay_user_wallet`
  ADD CONSTRAINT `kypay_user_wallet_ibfk_1` FOREIGN KEY (`id`) REFERENCES `kypay_user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
