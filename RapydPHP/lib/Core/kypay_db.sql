-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 29, 2021 at 01:19 AM
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
('Van_nAkT6Eog', 'Abigail', 'Vanc Chee', 'P', NULL, 'FQ6VlcNn220n0H3kCelLXAK0Pju+tcj1kKFFZqQEh4w+YTMARnVS5VLFCN+ijPuuHJB+SBUbQIpNfJnE', 'FQ6VlcNn220n0H3kCelLXAK0Pju+tcj1dinDitI1u10qXb9E80O4hhiRUYnx3abfUcUtGQ==', 'MY', 8, 'SO', NULL, NULL),
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
  `to_uid_type` enum('P','E','U') NOT NULL DEFAULT 'U',
  `tx_type` enum('WT','SM','RM','PB') DEFAULT NULL,
  `wallet_ref_id` varchar(16) DEFAULT NULL,
  `to_wallet_ref_id` varchar(16) DEFAULT NULL,
  `amount` float(10,2) DEFAULT NULL,
  `currency` varchar(5) NOT NULL DEFAULT 'MYR',
  `method` varchar(64) DEFAULT NULL,
  `service_id` varchar(128) DEFAULT NULL,
  `stat` enum('S','E','N') NOT NULL DEFAULT 'N',
  `stat_message` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user_payment_tx`
--

INSERT INTO `kypay_user_payment_tx` (`id`, `uid`, `to_uid`, `to_uid_type`, `tx_type`, `wallet_ref_id`, `to_wallet_ref_id`, `amount`, `currency`, `method`, `service_id`, `stat`, `stat_message`, `last_updated`) VALUES
('01Vi30sv1LCtyM8qjVlXwQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'send_money', '2cde9824-d7e8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:09:36'),
('0irXm7VkNRu9DjvIcVSJtQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'send_money', '0aaaa1bd-d877-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:12:17'),
('0jdxJyVarlVbaBhpuRaVjQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_affinbank_bank', NULL, 'S', NULL, '2021-06-25 10:37:33'),
('146Zp26NkMjk7ZxsYSDY6A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '8d1af0ee-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:09:33'),
('22ttODMYnUCxfwJvBc2iSg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 09:44:25'),
('2Rpo7ReBEROkvL4bky9l2Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'send_money', '79ddd1e2-d7e9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:18:56'),
('2SVXy81GsdBE1MPO2J20wQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-27 15:23:28'),
('30Pn5922j0ppgXLbKdrb8A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 09:55:02'),
('33Av8sAc80FWQXAjDfbv8w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, 'S', NULL, '2021-06-27 15:27:12'),
('3PHrKmEsJSmTQHaVdbZaCw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '4e1b80b8-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:06:45'),
('3voYHQwOdTIVahCfWEYLBQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_affinbank_bank', 'payment_b42580a3c2482df184f914daacd52d7b', 'S', NULL, '2021-06-27 15:52:28'),
('45P03fOOW2Fuz4Cw7OprSg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '6b389dca-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:25:40'),
('4GQwixhzCGlcR9DLSEePew22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 10:22:35'),
('4mmJcBaUGmpHR2ZIiSv02A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '5f3d51be-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:25:20'),
('4UPZIiexzzVm5vj22CGV2A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -50.00, 'MYR', 'send_money', '9a5f364f-d7e4-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:44:02'),
('6tCtVkJr42yZRDNwB7rgRQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'd8f225ce-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:27:56'),
('7AZpNZLQZsQPS0julSg7Dg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '1368dd64-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:30:22'),
('7bOHLvZxtNmucteL0vLjMg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '0470aba5-d802-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:14:36'),
('7d7O7KLZG0aYE8qC2AeT4w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'dee558b7-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:13:32'),
('7dHatp7qqDchW8qlfFTvUw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_public_bank', NULL, 'S', NULL, '2021-06-25 10:56:44'),
('7hFTdGVOEI89NpVU3RsApQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '17b034bf-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:46:45'),
('8pC2zNjzhD0q3PNqNMmq7Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '6a0b275a-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:07:33'),
('90Af1obat7x77stV4xYuGA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '23ac60d9-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:31:28'),
('9a29ANkiVQembGqJOJamVA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_amonline_bank', NULL, 'S', NULL, '2021-06-27 09:58:41'),
('Aj233TPvMX0bIcn87lFfUQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'ef63c28f-d876-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:11:31'),
('aLgmPHB0UWbZBxAkAdWvOw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 0.00, 'MYR', 'send_money', NULL, 'S', NULL, '2021-06-28 10:50:01'),
('aN3xTYC1b2zAjIY5sCsylg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '3252d648-d809-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:05:59'),
('AzfrJkPemq18xxg71jh0wQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, 'S', NULL, '2021-06-27 15:41:09'),
('B9JjqdriinSebxv88OXA9w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_ocbc_bank', NULL, 'S', NULL, '2021-06-27 15:28:22'),
('BdX1bNYnSsJnga9dWlrtxw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '5c56ec2a-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:08:12'),
('Bf3lVFC8TnQw5Qgcc2SpHw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_ocbc_bank', NULL, 'S', NULL, '2021-06-25 09:48:10'),
('bGpExs59xLB7B9sCOV8h5A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'ce1968d7-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:44:41'),
('bokyZ4GaOKERrUlFAuPtoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '3e4438bd-d7ee-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:53:03'),
('Bq57Zw0qjWNQbMy5OS8aKA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'fd6fe424-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:30:25'),
('cc2zFUwF6whwBqxjVt0x8Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_standardchartered_bank', 'payment_c5bb131c30e0e09edd29a1389df73f65', 'S', NULL, '2021-06-27 17:03:27'),
('cCj1Mxd8N7LCqedomGJkkg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_islam_bank', 'payment_c9209fabcba62b69bbf0754694efc97e', 'S', NULL, '2021-06-28 19:40:19'),
('daOPFJep9nEpaUHm0uQY9g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'S', NULL, '2021-06-25 17:13:10'),
('DcETebLid6C7NLnbhnC5Jg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_islam_bank', NULL, 'S', NULL, '2021-06-25 09:51:33'),
('dGTzq9NixtZBB78uNyE9Nw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'c376afe3-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:55:43'),
('dh2eunjXlwZFaEnmRx4fYQ22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 34.13, 'MYR', NULL, NULL, 'N', NULL, '2021-06-16 08:57:05'),
('dRt7TKl2zxZWnpDM6W3q1g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, 0.00, 'MYR', 'send_money', 'b15561be-d7e3-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:37:31'),
('dWBhgyQx6pblrEOR987rog22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'a65b46fe-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:10:16'),
('dWubi2tJvIebHsbw62jZwg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'bbd40ce6-d869-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:37:01'),
('E3RXneI8BcfMHUcoNsNKLg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_alliancebank_bank', 'payment_e18a375bcc707f4bdb16dc55a13eb920', 'S', NULL, '2021-06-28 15:26:40'),
('E8gfvMILco1bxjQsS2Ci7Q22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 49.17, 'MYR', NULL, NULL, 'N', NULL, '2021-06-16 08:57:00'),
('Ea1bT0br46dQDbc6bXc11Q22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_rakyat_bank', NULL, 'S', NULL, '2021-06-25 17:52:01'),
('EalpSnNE84UudSBKAslZYw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_ocbc_bank', NULL, 'S', NULL, '2021-06-25 10:24:34'),
('ebs8H7A8kcJyeoqky9MfbQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b7ee2942-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:28:27'),
('EfiztJ0MeX4WCFtlyGM1xA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_rhb_bank', 'payment_bebcfb8b9dd8f5b639469cabafba12bf', 'S', NULL, '2021-06-27 15:48:51'),
('eqO4IeL6W6TfAbFYcAsH2w22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_hsbc_bank', NULL, 'S', NULL, '2021-06-25 17:46:41'),
('F83TEWSEEko8mZHC92Bmdg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '8442804c-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:11:00'),
('FE3JIOny8gSMVCkEfvPHoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '66a686a4-d7ed-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:47:01'),
('fp2APpn6bQKxeIEiqj7Z5w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '32bfd566-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:14:11'),
('G0VxPaCG22PwV4nsRkhzHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 13.00, 'MYR', 'my_maybank_bank', 'payment_341702ea0aa3d3b5a60c400bf563c8e0', 'S', NULL, '2021-06-28 11:52:53'),
('G930QarRQMd4bvIrcVmjbQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_kuwaitfinancehouse_bank', 'payment_fc756371b2e0af7b87fa866c61bb4fea', 'S', NULL, '2021-06-28 11:54:37'),
('gbd7BIdW7wJq1j80Q9JiHQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '64522c8a-d86d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:03:12'),
('GpQK7NdZU1np6C1ycJOAGA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '5ff5242b-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:48:46'),
('gqH7Z1sqj2Wk2joNQH0qKQ22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 33.85, 'MYR', NULL, NULL, 'N', NULL, '2021-06-16 08:55:24'),
('gsKUefqDPvBNOprOLMVHqw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -12.00, 'MYR', 'send_money', '583ffa16-d7e2-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:27:52'),
('gTuaP9ZQB5vLNd5jcmHCOQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-27 15:22:53'),
('h080o6fOTAye7SIHmNCMbw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 11.00, 'MYR', 'my_islam_bank', NULL, 'S', NULL, '2021-06-25 17:43:07'),
('HvGUkCCWmQAFWpwZuaQ9UQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, 'S', NULL, '2021-06-25 10:52:10'),
('hYVPFxVwtN9kydZbJPj3AQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-25 12:49:50'),
('hZDGifQsQac2rIV3M55hmg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '41adbb3f-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:40:46'),
('IOzyf5HU8HZ2JWfJ8XlZhw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'abadb8c0-d86d-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:05:12'),
('iSwy32xZpbMMU0cW3SUQrw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'ae61f191-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:12:12'),
('IvMo3IpoUBuXEZvdgCrmEA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '0f1f3aff-d808-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:57:50'),
('IyJzeVKdmQb9TPXwp4Vdpw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 33.00, 'MYR', 'my_standardchartered_bank', 'payment_56e00f7f744af05480b43c796b532cae', 'S', NULL, '2021-06-28 19:44:10'),
('j93tBtfuqOCTGsfwGdeNoQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'ac6d48dc-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:35:17'),
('j94qiPsbn2m2v7PMp3imQg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 10:10:46'),
('J96rKbz0t3F0dngqeW7XOQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_rhb_bank', NULL, 'S', NULL, '2021-06-28 11:41:09'),
('JZc7wjz2Q9ntnp2BSY8fVw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '880f5034-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:33:38'),
('K54RRaA2QuSpJmkbJlBfcA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b9128cd6-d80b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:24:04'),
('KJ1xqq3rPVODikUbLCtv2Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '718f12eb-d7ed-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:47:19'),
('kXPQ8L2sHPIp1o75b4rBtQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '08754b4b-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:13:00'),
('lUoB4940bZWYyCybPLGbQQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b852a4ed-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:10:46'),
('m16e28BQ7Et26ifQ2W3gTg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b9b44269-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:03:39'),
('MHy0vk9oQbTBZIbAxu6KlA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'S', NULL, '2021-06-25 17:11:50'),
('MMGdRDAvLgXDd7oQBSi8og22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '262f1e10-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:12:48'),
('MPlvbacGZ7Wv4bXPa4r8Dg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'e8abdcb8-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:56:48'),
('MRHt8wx2DJohgNmV1p8Q9w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'send_money', '38124f23-d7e5-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:48:26'),
('mSh4grwG2pGKjxia2vy7sA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '892b93cc-d86f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:18:33'),
('mxcrZV0CGUljB20UzRVt6w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '0c950e86-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:30:49'),
('mXYAu0jihJ8nN23yTbC2Tw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_affinbank_bank', NULL, 'S', NULL, '2021-06-28 11:50:51'),
('nBjndgeDBaoXb1a32FYA6A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_rhb_bank', NULL, 'S', NULL, '2021-06-25 10:21:28'),
('NpABJtjc2B3I8bKxmAlwUg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', NULL, '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, 'S', NULL, '2021-06-25 09:18:42'),
('NVijCr8cvqUtiIBMKGdM4Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'fb210f27-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:28:54'),
('nwTXbtag8BsgHv8uTt8S8g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '36659eef-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:13:15'),
('OwIRqSXPijIgZIFjdNcjgA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '96f327d7-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:43:09'),
('p2BbwMhejtnMH0QeSZbV8A22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'ab25a487-d80b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:23:42'),
('pbZg2Mf2ruUB3xhNNhg6Bg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '7c2711d4-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:33:18'),
('Q2nPai8yE75j8BxEPemmnA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b6497a39-d870-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:26:58'),
('QMtk0RQZbQO5UzdYpkzKQQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '321bded1-d7ee-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:52:42'),
('qQvoNq7syrNy5QmPb9opdw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'bf79fbd8-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:28:40'),
('QSzGRztcRFa2l6To9qvM4A22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'S', NULL, '2021-06-25 16:57:00'),
('qx5CUULnBtYbbWk39lEJJA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '3fe1f434-d7f1-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:14:33'),
('QYublyj4n2BDHJsouwY28Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'c4fba82d-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:04:02'),
('reMZGaQjUnEDhDgfvhmCHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'f6c7243d-d807-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:57:09'),
('RKaGsEKzVDCcLVb0IsBw1w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '70de70c9-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:14:53'),
('S1Sdmi5pU4t6pC6eAtz5TQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, 'S', NULL, '2021-06-25 10:36:09'),
('SC6yHried2CrwdIZGj5UzA22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 15.30, 'MYR', NULL, NULL, 'N', NULL, '2021-06-16 08:55:18'),
('Sl7nfxTCMLHlKFy4guVxCQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'e3445b1c-d7ea-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:29:03'),
('svpzL8H0GQ2iColDZUK8NA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '9e042699-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:34:53'),
('tuFCTfRuN5hJqgV2IhUqaA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_maybank_bank', 'payment_7364c2ff9adc41796da297cb8521c355', 'S', NULL, '2021-06-28 11:54:02'),
('TuyoKQpteJHUzt6KE0W1gA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 11:48:49'),
('TvQXVbJWxtUZyVtUuKBi1Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -5.00, 'MYR', 'send_money', '224df46c-d7e5-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 15:47:51'),
('TW0qUezuhOHkueR7y2YvZQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-28 11:46:22'),
('TWz7R42HuRb8AWMKpOfPEQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '4e43740d-d7f0-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 17:07:48'),
('u3YWbbQRE33rx1QbIlcSZw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '03ebf05e-d7ef-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:58:35'),
('UDz7hsWG3Lx4zjCMTcbQNA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 30.00, 'MYR', 'my_alliancebank_bank', 'payment_2472dd925f5e36af14a2e0ac153103c9', 'S', NULL, '2021-06-28 17:07:31'),
('UssUsBM4GX2IedGT8BGEQg22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', NULL, '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-25 09:40:22'),
('v29amR4akbzBcE2yOdMxSg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'd01da133-d86c-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:59:03'),
('vbJfFGT2CS5vg5rNBBMeGQ22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_alliancebank_bank', NULL, 'S', NULL, '2021-06-25 11:02:38'),
('vjEVyJ43B70p4SyTKFjThg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '4a80022f-d86a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:41:00'),
('VKuSyPEK4k4cJmbW40YbDA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '7aba6d40-d86c-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:56:40'),
('VlEHhfrRB0U0cx0NHeaDgw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 10.00, 'MYR', 'us_visa_card', NULL, 'S', NULL, '2021-06-25 17:09:04'),
('VN8dtdhQOmE5gD3KJbOL1w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -2.00, 'MYR', 'send_money', '099f6233-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:01:27'),
('vpTXZdUbBAxAn2i1ubajuQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '3a747603-d7e8-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:09:59'),
('vxnjuBP9ghbW6ysdjoDoPw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_islam_bank', NULL, 'S', NULL, '2021-06-25 11:07:33'),
('VY2XCKdSvSXPUDDIjxnh9g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-25 12:48:59'),
('vYS2eJ8VG5Y2SRmEsvpozg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '7a9c2b18-d815-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:33:54'),
('WbMSHWHyQoed62AQNRCOHw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'c30fbd68-d874-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:55:58'),
('wftCqV3OsjCLt7BIfKsJcA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '464021a6-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:48:03'),
('wH7NgBJe20bbV5upv9dVIQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '6a4671a5-d86b-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 07:49:04'),
('wm4BRF9Xl37zNO419d6Wlw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-27 09:42:42'),
('womCPZVpQHhQqUvTRDvMeg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_simpanannasional_bank', 'payment_8d799a95045647edfa2b1eb7b0e92c30', 'S', NULL, '2021-06-28 19:42:41'),
('WQYwfzFIhfW9yAC2Pay71w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '911682b9-d801-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 19:11:24'),
('wYXCXANap82KvtbaztJldQ22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -130.00, 'MYR', 'send_money', NULL, 'S', NULL, '2021-06-28 15:42:31'),
('xj2QWO5OKccx5KML1ikS4w22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '81961371-d80a-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 20:15:23'),
('xoYP7SQYsb2utCgxfbFazA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'b8dc098c-d877-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 09:17:09'),
('XtQPo994ANmCHynqybE3vg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_public_bank', NULL, 'S', NULL, '2021-06-27 11:37:44'),
('XXd2TIbvTLbbfkzDTld6lA22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '2eb86204-d86f-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-29 08:16:01'),
('XZNdPEf7fjlBoYnQw84bbw22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_maybank_bank', NULL, 'S', NULL, '2021-06-25 17:27:32'),
('ygJlWLz2VUUeGZVLtXl2Dw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'send_money', '2b15be0a-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:02:23'),
('yhY4dM2eAaOvNKpzBclg4Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '967273da-d814-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 21:27:31'),
('YzSVudYB6nn1IdbTffbI1g22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 12.00, 'MYR', 'my_hsbc_bank', 'payment_98797b0a6ebb3b865d548502b217c37b', 'S', NULL, '2021-06-27 15:45:49'),
('z5nntvB9mUovvXXC7KIU2g22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 0.00, 'MYR', 'my_hongleong_bank', NULL, 'S', NULL, '2021-06-25 17:23:55'),
('Za6ViGga2jbcfCUmdGmOcA22', 'Cha_BCmFOsbhcm02', 'Cha_BCmFOsbhcm02', 'U', 'WT', '5FAwvqtWVRs2', NULL, 21.00, 'MYR', 'my_alliancebank_bank', NULL, 'S', NULL, '2021-06-25 17:29:34'),
('ZA8eA0BuEExWidykcxixeg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', 'f8870bcb-d7e9-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:22:27'),
('ZNq12oacdrjcSWRnAqOCdg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 10.00, 'MYR', 'my_cimb_bank', NULL, 'S', NULL, '2021-06-27 15:43:26'),
('Zvm7hh6ZGm7Nui24poja1Q22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -3.00, 'MYR', 'send_money', 'b85bf429-d7e7-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:06:20'),
('Zwr7RmMT70INuz8373zICw22', 'Che_Rm92ndZL', NULL, 'U', NULL, NULL, NULL, 26.88, 'MYR', NULL, NULL, 'N', NULL, '2021-06-16 08:56:53'),
('zwZTWVF9ge2SRLdqrjBkGw22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'WT', 'gjud1v6Yi2Y2', NULL, 11.00, 'MYR', 'my_muamalat_bank', NULL, 'S', NULL, '2021-06-27 09:22:18'),
('ZYn20DQFQFUQuWmuUfcZsg22', 'Che_Rm92ndZL', 'Che_Rm92ndZL', 'U', 'SM', 'gjud1v6Yi2Y2', NULL, -1.00, 'MYR', 'send_money', '0539f726-d7eb-11eb-b38b-02240218ee6d', 'S', NULL, '2021-06-28 16:29:58');

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
  `service_addr_id` varchar(255) DEFAULT NULL,
  `service_contact_id` varchar(255) DEFAULT NULL,
  `service_cust_id` varchar(255) DEFAULT NULL,
  `service_po_ben_id` varchar(255) DEFAULT NULL,
  `service_po_sender_id` varchar(255) DEFAULT NULL,
  `service_wallet_id` varchar(255) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kypay_user_wallet`
--

INSERT INTO `kypay_user_wallet` (`id`, `ref_id`, `balance`, `currency`, `type`, `service_addr_id`, `service_contact_id`, `service_cust_id`, `service_po_ben_id`, `service_po_sender_id`, `service_wallet_id`, `last_updated`) VALUES
('Cha_BCmFOsbhcm02', '5FAwvqtWVRs2', 75.00, 'MYR', 'P', 'address_19b2cf30bb21632df521fdaf5aab5ed1', 'cont_1c251ee25b4d0464c9a555818784a2f9', 'cus_9e0963b6e0db22f4e5d21e80db70952b', NULL, NULL, 'ewallet_69bb819addd90f6750dfd645a3af0c40', '2021-06-25 17:52:01'),
('Che_Rm92ndZL', 'gjud1v6Yi2Y2', 25.00, 'MYR', 'P', 'address_7c43774d4b62495b62af4d0d9285f2fb', 'cont_3db76f3e88eea5e18e7d2fb10e8dad8f', 'cus_984be6751fedb6702e8b57c55d06982d', NULL, NULL, 'ewallet_ea94db770b966314504eafdb8ecbe603', '2021-06-29 09:17:09'),
('Yon_pgP5FOzMeJM2', 'pgUrZV69ElU2', 0.00, 'MYR', 'P', NULL, NULL, NULL, NULL, NULL, NULL, '2021-06-20 09:50:48');

--
-- Indexes for dumped tables
--

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
