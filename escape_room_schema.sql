-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-03-2025 a las 12:55:39
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
-- Base de datos: `escape_room_schema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `game_session`
--

CREATE TABLE `game_session` (
  `id_game` int(11) NOT NULL,
  `id_room` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notifications`
--

CREATE TABLE `notifications` (
  `id_notifications` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notification_type` enum('Generic','Personal') DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_room` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `object`
--

CREATE TABLE `object` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  `theme` enum('Terror','Fiction','Fantasy') NOT NULL,
  `price` double NOT NULL,
  `clueValor` int(11) DEFAULT NULL,
  `img` varchar(100) DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `modification_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `object`
--

INSERT INTO `object` (`id`, `name`, `description`, `theme`, `price`, `clueValor`, `img`, `creation_date`, `modification_date`) VALUES
(1, 'Libro Antiguo', 'Un libro de historia con páginas amarillentas.', 'Terror', 25.5, 10, 'libro_antiguo.jpg', '2025-03-25 11:28:16', '2025-03-25 11:28:16'),
(2, 'Mapa del Tesoro', 'Un mapa antiguo que muestra la ubicación de un tesoro oculto.', 'Fiction', 50, 25, 'mapa_tesoro.png', '2025-03-25 11:28:16', '2025-03-25 11:28:16'),
(3, 'Poción Mágica', 'Una poción que otorga poderes temporales.', 'Fantasy', 100, 50, 'pocion_magica.jpg', '2025-03-25 11:28:16', '2025-03-25 11:28:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment`
--

CREATE TABLE `payment` (
  `id_payment` int(11) NOT NULL,
  `payment_mode` enum('Credit card','Bizum','PayPal') DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cost` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payment`
--

INSERT INTO `payment` (`id_payment`, `payment_mode`, `date`, `cost`, `id_user`) VALUES
(1, 'Credit card', '2025-03-25 11:38:13', 50, 1),
(2, 'Bizum', '2025-03-25 11:38:35', 24, 2),
(3, 'PayPal', '2025-03-25 11:39:02', 40, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `adress_street` varchar(100) DEFAULT NULL,
  `adress_number` int(11) DEFAULT NULL,
  `adress_floor` char(20) DEFAULT NULL,
  `adress_door` char(20) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `zip_code` char(20) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `phone` char(50) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `name`, `adress_street`, `adress_number`, `adress_floor`, `adress_door`, `city`, `zip_code`, `country`, `phone`, `mail`) VALUES
(1, 'Ana García', 'Calle Mayor', 123, '3', 'A', 'Madrid', '28001', 'España', '+34612345678', 'ana.garcia@email.com'),
(2, 'John Smith', 'Main Street', 456, '2', 'B', 'New York', '10001', 'USA', '+15551234567', 'john.smith@email.com'),
(3, 'Marie Dupont', 'Rue de la Paix', 789, '1', 'C', 'Paris', '75001', 'France', '+33123456789', 'marie.dupont@email.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `game_session`
--
ALTER TABLE `game_session`
  ADD PRIMARY KEY (`id_game`),
  ADD KEY `fk_game_user` (`id_user`);

--
-- Indices de la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id_notifications`),
  ADD KEY `fk_notifications_user` (`id_user`);

--
-- Indices de la tabla `object`
--
ALTER TABLE `object`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id_payment`),
  ADD KEY `fk_payment_user` (`id_user`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `mail` (`mail`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `game_session`
--
ALTER TABLE `game_session`
  MODIFY `id_game` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id_notifications` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `object`
--
ALTER TABLE `object`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `payment`
--
ALTER TABLE `payment`
  MODIFY `id_payment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `game_session`
--
ALTER TABLE `game_session`
  ADD CONSTRAINT `fk_game_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Filtros para la tabla `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
