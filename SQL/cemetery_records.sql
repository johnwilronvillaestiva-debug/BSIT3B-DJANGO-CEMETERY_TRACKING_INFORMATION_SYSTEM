-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2026 at 05:08 PM
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
-- Database: `cemetery_records`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` int(11) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `burial_plots`
--

CREATE TABLE `burial_plots` (
  `plot_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `plot_code` varchar(30) NOT NULL,
  `row_number` varchar(20) DEFAULT NULL,
  `plot_status` varchar(20) NOT NULL DEFAULT 'Available',
  `location_description` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `cemetery_sections`
--

CREATE TABLE `cemetery_sections` (
  `section_id` int(11) NOT NULL,
  `section_name` varchar(100) NOT NULL,
  `section_code` varchar(20) NOT NULL,
  `description` text DEFAULT NULL,
  `location_notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deceased_contacts`
--

CREATE TABLE `deceased_contacts` (
  `deceased_contact_id` int(11) NOT NULL,
  `deceased_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `relationship` varchar(50) NOT NULL,
  `is_primary_contact` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deceased_records`
--

CREATE TABLE `deceased_records` (
  `deceased_id` int(11) NOT NULL,
  `plot_id` int(11) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_death` date NOT NULL,
  `burial_date` date DEFAULT NULL,
  `record_notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `family_contacts`
--

CREATE TABLE `family_contacts` (
  `contact_id` int(11) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(30) NOT NULL,
  `account_status` varchar(20) NOT NULL DEFAULT 'Active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_audit_user` (`user_id`),
  ADD KEY `idx_audit_target` (`table_name`,`record_id`);

--
-- Indexes for table `burial_plots`
--
ALTER TABLE `burial_plots`
  ADD PRIMARY KEY (`plot_id`),
  ADD UNIQUE KEY `uq_plots_section_code` (`section_id`,`plot_code`);

--
-- Indexes for table `cemetery_sections`
--
ALTER TABLE `cemetery_sections`
  ADD PRIMARY KEY (`section_id`),
  ADD UNIQUE KEY `uq_sections_code` (`section_code`);

--
-- Indexes for table `deceased_contacts`
--
ALTER TABLE `deceased_contacts`
  ADD PRIMARY KEY (`deceased_contact_id`),
  ADD UNIQUE KEY `uq_deceased_contact` (`deceased_id`,`contact_id`),
  ADD KEY `idx_dc_contact` (`contact_id`);

--
-- Indexes for table `deceased_records`
--
ALTER TABLE `deceased_records`
  ADD PRIMARY KEY (`deceased_id`),
  ADD KEY `idx_deceased_name` (`last_name`,`first_name`),
  ADD KEY `idx_deceased_death_date` (`date_of_death`),
  ADD KEY `idx_deceased_plot` (`plot_id`);

--
-- Indexes for table `family_contacts`
--
ALTER TABLE `family_contacts`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `idx_contacts_name` (`full_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `uq_users_username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `burial_plots`
--
ALTER TABLE `burial_plots`
  MODIFY `plot_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cemetery_sections`
--
ALTER TABLE `cemetery_sections`
  MODIFY `section_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deceased_contacts`
--
ALTER TABLE `deceased_contacts`
  MODIFY `deceased_contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deceased_records`
--
ALTER TABLE `deceased_records`
  MODIFY `deceased_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `family_contacts`
--
ALTER TABLE `family_contacts`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `burial_plots`
--
ALTER TABLE `burial_plots`
  ADD CONSTRAINT `fk_plots_section` FOREIGN KEY (`section_id`) REFERENCES `cemetery_sections` (`section_id`) ON UPDATE CASCADE;

--
-- Constraints for table `deceased_contacts`
--
ALTER TABLE `deceased_contacts`
  ADD CONSTRAINT `fk_dc_contact` FOREIGN KEY (`contact_id`) REFERENCES `family_contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dc_deceased` FOREIGN KEY (`deceased_id`) REFERENCES `deceased_records` (`deceased_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `deceased_records`
--
ALTER TABLE `deceased_records`
  ADD CONSTRAINT `fk_deceased_plot` FOREIGN KEY (`plot_id`) REFERENCES `burial_plots` (`plot_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
