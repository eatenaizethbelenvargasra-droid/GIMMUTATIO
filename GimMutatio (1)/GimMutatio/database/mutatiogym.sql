-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-10-2026 a las 09:35:19
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mutatiogym`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `attendance`
--

CREATE TABLE `attendance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `checkin_at` datetime NOT NULL DEFAULT current_timestamp(),
  `recorded_by` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `attendance`
--

INSERT INTO `attendance` (`id`, `client_id`, `checkin_at`, `recorded_by`) VALUES
(1, 1, '2026-10-07 03:29:51', 2),
(2, 1, '2026-10-06 03:29:51', 2),
(3, 1, '2026-10-04 03:29:51', 2),
(4, 1, '2026-10-03 03:29:51', 2),
(5, 1, '2026-10-01 03:29:51', 2),
(6, 1, '2026-09-29 03:29:51', 2),
(7, 1, '2026-09-28 03:29:51', 2),
(8, 1, '2026-09-26 03:29:51', 2),
(9, 1, '2026-09-24 03:29:51', 2),
(10, 1, '2026-09-22 03:29:51', 2),
(11, 1, '2026-09-20 03:29:51', 2),
(12, 1, '2026-09-18 03:29:51', 2),
(13, 2, '2026-10-07 03:29:51', 2),
(14, 2, '2026-10-03 03:29:51', 2),
(15, 2, '2026-09-29 03:29:51', 2),
(16, 2, '2026-09-25 03:29:51', 2),
(17, 2, '2026-09-21 03:29:51', 2),
(18, 2, '2026-09-17 03:29:51', 2),
(19, 3, '2026-09-12 03:29:51', 2),
(20, 3, '2026-09-09 03:29:51', 2),
(21, 5, '2026-10-06 03:29:51', 2),
(22, 5, '2026-10-05 03:29:51', 2),
(23, 5, '2026-10-02 03:29:51', 2),
(24, 5, '2026-09-30 03:29:51', 2),
(25, 5, '2026-09-27 03:29:51', 2),
(26, 5, '2026-09-25 03:29:51', 2),
(27, 5, '2026-09-23 03:29:51', 2),
(28, 5, '2026-09-20 03:29:51', 2),
(29, 5, '2026-09-16 03:29:51', 2),
(30, 5, '2026-09-13 03:29:51', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audit_log`
--

CREATE TABLE `audit_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `entity` varchar(80) NOT NULL,
  `entity_id` int(10) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clients`
--

CREATE TABLE `clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(140) NOT NULL,
  `email` varchar(190) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clients`
--

INSERT INTO `clients` (`id`, `user_id`, `name`, `email`, `phone`, `document_number`, `birth_date`, `notes`, `active`, `created_at`) VALUES
(1, 3, 'Cliente Demo', 'cliente@mutatio.local', '70000001', 'DEMO-001', NULL, NULL, 1, '2026-10-08 07:29:51'),
(2, NULL, 'Valeria Rojas', 'valeria.rojas@mutatio.local', '70000002', 'DEMO-002', NULL, NULL, 1, '2026-10-08 07:29:51'),
(3, NULL, 'Diego Mamani', 'diego.mamani@mutatio.local', '70000003', 'DEMO-003', NULL, NULL, 1, '2026-10-08 07:29:51'),
(4, NULL, 'Camila Flores', 'camila.flores@mutatio.local', '70000004', 'DEMO-004', NULL, NULL, 1, '2026-10-08 07:29:51'),
(5, NULL, 'Pablo Choque', 'pablo.choque@mutatio.local', '70000005', 'DEMO-005', NULL, NULL, 1, '2026-10-08 07:29:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `memberships`
--

CREATE TABLE `memberships` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','expired','cancelled') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `memberships`
--

INSERT INTO `memberships` (`id`, `client_id`, `plan_id`, `start_date`, `end_date`, `status`, `created_at`) VALUES
(1, 1, 1, '2026-09-28', '2026-10-27', 'active', '2026-10-08 07:29:51'),
(2, 2, 2, '2026-09-14', '2026-12-12', 'active', '2026-10-08 07:29:51'),
(3, 3, 1, '2026-09-11', '2026-10-10', 'active', '2026-10-08 07:29:51'),
(4, 4, 1, '2026-07-30', '2026-08-28', 'expired', '2026-10-08 07:29:51'),
(5, 5, 3, '2026-06-10', '2026-12-07', 'active', '2026-10-08 07:29:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `membership_id` int(10) UNSIGNED DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `method` enum('efectivo','transferencia','tarjeta','qr','otro') NOT NULL DEFAULT 'efectivo',
  `reference` varchar(190) DEFAULT NULL,
  `status` enum('completed','void') NOT NULL DEFAULT 'completed',
  `recorded_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payments`
--

INSERT INTO `payments` (`id`, `client_id`, `membership_id`, `amount`, `payment_date`, `method`, `reference`, `status`, `recorded_by`, `created_at`) VALUES
(1, 1, NULL, 145.00, '2026-05-08 03:29:51', 'efectivo', 'DEMO-2026-05', 'completed', 1, '2026-10-08 07:29:51'),
(2, 1, NULL, 210.00, '2026-06-08 03:29:51', 'qr', 'DEMO-2026-06', 'completed', 1, '2026-10-08 07:29:51'),
(3, 1, NULL, 185.00, '2026-07-08 03:29:51', 'transferencia', 'DEMO-2026-07', 'completed', 1, '2026-10-08 07:29:51'),
(4, 1, NULL, 260.00, '2026-08-08 03:29:51', 'efectivo', 'DEMO-2026-08', 'completed', 1, '2026-10-08 07:29:51'),
(5, 1, NULL, 230.00, '2026-09-08 03:29:51', 'qr', 'DEMO-2026-09', 'completed', 1, '2026-10-08 07:29:51'),
(6, 1, NULL, 340.00, '2026-10-08 03:29:51', 'transferencia', 'DEMO-2026-10', 'completed', 1, '2026-10-08 07:29:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plans`
--

CREATE TABLE `plans` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `duration_days` smallint(5) UNSIGNED NOT NULL DEFAULT 30,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plans`
--

INSERT INTO `plans` (`id`, `name`, `description`, `price`, `duration_days`, `active`, `created_at`) VALUES
(1, 'Plan mensual', 'Acceso general por un mes', 180.00, 30, 1, '2026-10-08 07:29:51'),
(2, 'Plan trimestral', 'Acceso general por tres meses', 480.00, 90, 1, '2026-10-08 07:29:51'),
(3, 'Plan semestral', 'Acceso general por seis meses', 900.00, 180, 1, '2026-10-08 07:29:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(140) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','recepcionista','cliente') NOT NULL DEFAULT 'recepcionista',
  `profile_image` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role`, `profile_image`, `active`, `created_at`) VALUES
(1, 'Administrador Mutatio', 'admin@mutatio.local', '$2y$10$RbYxrrWmO/rBKFIW9panK.dWGqeR4.Y/mx.QIujV0XfkPJg0P0qg.', 'admin', NULL, 1, '2026-10-08 07:29:51'),
(2, 'Recepci?n Mutatio', 'recepcion@mutatio.local', '$2y$10$uEJsd2fWLf8HZrXo4tHa0eTtFmADOTNk3.qCSeG1ziPfmUFkiljiW', 'recepcionista', NULL, 1, '2026-10-08 07:29:51'),
(3, 'Cliente Demo Mutatio', 'cliente@mutatio.local', '$2y$10$Jex.Hp6rkH5/O7sj2TQqzuw8JfgO1eZcICzxskvmP8hwBn6/PFSii', 'cliente', NULL, 1, '2026-10-08 07:29:51');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_attendance_user` (`recorded_by`),
  ADD KEY `idx_attendance_date` (`checkin_at`),
  ADD KEY `idx_attendance_client_date` (`client_id`,`checkin_at`);

--
-- Indices de la tabla `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_audit_user` (`user_id`),
  ADD KEY `idx_audit_created` (`created_at`);

--
-- Indices de la tabla `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `document_number` (`document_number`),
  ADD KEY `idx_client_name` (`name`),
  ADD KEY `idx_client_active` (`active`);

--
-- Indices de la tabla `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_membership_plan` (`plan_id`),
  ADD KEY `idx_membership_client` (`client_id`),
  ADD KEY `idx_membership_dates` (`status`,`end_date`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_reset_user` (`user_id`),
  ADD KEY `idx_reset_token` (`token_hash`),
  ADD KEY `idx_reset_expiry` (`expires_at`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_payment_membership` (`membership_id`),
  ADD KEY `fk_payment_user` (`recorded_by`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `idx_payment_client` (`client_id`);

--
-- Indices de la tabla `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_plan_name` (`name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fk_attendance_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `fk_attendance_user` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `fk_client_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `memberships`
--
ALTER TABLE `memberships`
  ADD CONSTRAINT `fk_membership_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `fk_membership_plan` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- Filtros para la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `fk_reset_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  ADD CONSTRAINT `fk_payment_membership` FOREIGN KEY (`membership_id`) REFERENCES `memberships` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_payment_user` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
