-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2025 a las 05:01:53
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
-- Base de datos: `reservas_hoteles`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `apellido`) VALUES
(9, 'Mohamed', 'Reda\r\n'),
(10, 'Mohamed', 'Chansedine'),
(11, 'Carlos', 'Gomez');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `hoteles`
--

CREATE TABLE `hoteles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `hoteles`
--

INSERT INTO `hoteles` (`id`, `nombre`, `ubicacion`, `descripcion`) VALUES
(1, 'HOTEL SUNSON PUNTA BLANCA', NULL, NULL),
(2, 'HOTEL LD SUITE', NULL, NULL),
(3, 'HOTEL HESPERIA', NULL, NULL),
(4, 'HOTEL AGUA DORADA', NULL, NULL),
(5, 'HOTEL COSTA CARIBE', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `cantidad_personas` int(11) DEFAULT NULL,
  `traslado` tinyint(1) DEFAULT NULL,
  `precio_traslado` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reservas`
--

INSERT INTO `reservas` (`id`, `id_cliente`, `id_hotel`, `fecha_inicio`, `fecha_fin`, `cantidad_personas`, `traslado`, `precio_traslado`, `total`) VALUES
(41, 9, 1, '2025-01-13', '2025-01-15', 3, 0, 0.00, 380.00),
(42, 9, 2, '2025-01-13', '2025-01-15', 3, 0, 0.00, 320.00),
(43, 9, 3, '2025-01-13', '2025-01-15', 3, 0, 0.00, 348.00),
(44, 9, 4, '2025-01-13', '2025-01-15', 3, 0, 0.00, 300.00),
(45, 9, 5, '2025-01-13', '2025-01-15', 3, 0, 0.00, 268.00),
(46, 10, 1, '2025-03-13', '2025-03-16', 2, 0, 0.00, 285.00),
(47, 10, 2, '2025-03-13', '2025-03-16', 2, 0, 0.00, 240.00),
(48, 10, 3, '2025-03-13', '2025-03-16', 2, 0, 0.00, 261.00),
(49, 10, 4, '2025-03-13', '2025-03-16', 2, 0, 0.00, 225.00),
(50, 10, 5, '2025-03-13', '2025-03-16', 2, 0, 0.00, 201.00),
(51, 11, 1, '2025-07-16', '2025-07-19', 4, 0, 0.00, 612.00),
(52, 11, 2, '2025-07-16', '2025-07-19', 4, 0, 0.00, 522.00),
(53, 11, 3, '2025-07-16', '2025-07-19', 4, 0, 0.00, 564.00),
(54, 11, 4, '2025-07-16', '2025-07-19', 4, 0, 0.00, 492.00),
(55, 11, 5, '2025-07-16', '2025-07-19', 4, 0, 0.00, 444.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifas`
--

CREATE TABLE `tarifas` (
  `id` int(11) NOT NULL,
  `id_hotel` int(11) DEFAULT NULL,
  `tipo_habitacion` enum('sencilla','doble','triple','niño') DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarifas`
--

INSERT INTO `tarifas` (`id`, `id_hotel`, `tipo_habitacion`, `precio`, `fecha_inicio`, `fecha_fin`) VALUES
(64, 1, 'doble', 90.00, '2025-01-01', '2025-01-31'),
(65, 1, 'triple', 95.00, '2025-01-01', '2025-01-31'),
(66, 1, 'sencilla', 100.00, '2025-01-01', '2025-01-31'),
(67, 1, 'doble', 95.00, '2025-01-04', '2025-04-16'),
(68, 1, 'triple', 100.00, '2025-01-04', '2025-04-16'),
(69, 1, 'sencilla', 110.00, '2025-01-04', '2025-04-16'),
(70, 1, 'doble', 98.00, '2025-04-17', '2025-06-30'),
(71, 1, 'triple', 105.00, '2025-04-17', '2025-06-30'),
(72, 1, 'sencilla', 115.00, '2025-04-17', '2025-06-30'),
(73, 1, 'doble', 102.00, '2025-07-01', '2025-08-10'),
(74, 1, 'triple', 115.00, '2025-07-01', '2025-08-10'),
(75, 1, 'sencilla', 125.00, '2025-07-01', '2025-08-10'),
(76, 1, 'doble', 110.00, '2025-08-11', '2025-09-26'),
(77, 1, 'triple', 125.00, '2025-08-11', '2025-09-26'),
(78, 1, 'sencilla', 140.00, '2025-08-11', '2025-09-26'),
(79, 1, 'doble', 98.00, '2025-09-27', '2025-11-30'),
(80, 1, 'triple', 105.00, '2025-09-27', '2025-11-30'),
(81, 1, 'sencilla', 115.00, '2025-09-27', '2025-11-30'),
(82, 1, 'doble', 110.00, '2025-12-01', '2025-12-31'),
(83, 1, 'triple', 125.00, '2025-12-01', '2025-12-31'),
(84, 1, 'sencilla', 150.00, '2025-12-01', '2025-12-31'),
(85, 2, 'doble', 75.00, '2025-01-01', '2025-03-31'),
(86, 2, 'triple', 80.00, '2025-01-01', '2025-03-31'),
(87, 2, 'sencilla', 85.00, '2025-01-01', '2025-03-31'),
(88, 2, 'doble', 80.00, '2025-01-04', '2025-04-16'),
(89, 2, 'triple', 85.00, '2025-01-04', '2025-04-16'),
(90, 2, 'sencilla', 95.00, '2025-01-04', '2025-04-16'),
(91, 2, 'doble', 83.00, '2025-04-17', '2025-06-30'),
(92, 2, 'triple', 90.00, '2025-04-17', '2025-06-30'),
(93, 2, 'sencilla', 108.00, '2025-04-17', '2025-06-30'),
(94, 2, 'doble', 87.00, '2025-07-01', '2025-08-10'),
(95, 2, 'triple', 100.00, '2025-07-01', '2025-08-10'),
(96, 2, 'sencilla', 119.00, '2025-07-01', '2025-08-10'),
(97, 2, 'doble', 95.00, '2025-08-11', '2025-09-26'),
(98, 2, 'triple', 110.00, '2025-08-11', '2025-09-26'),
(99, 2, 'sencilla', 135.00, '2025-08-11', '2025-09-26'),
(100, 2, 'doble', 83.00, '2025-09-27', '2025-11-30'),
(101, 2, 'triple', 90.00, '2025-09-27', '2025-11-30'),
(102, 2, 'sencilla', 100.00, '2025-09-27', '2025-11-30'),
(103, 2, 'doble', 95.00, '2025-12-01', '2025-12-31'),
(104, 2, 'triple', 110.00, '2025-12-01', '2025-12-31'),
(105, 2, 'sencilla', 135.00, '2025-12-01', '2025-12-31'),
(106, 3, 'doble', 82.00, '2025-01-01', '2025-03-31'),
(107, 3, 'triple', 87.00, '2025-01-01', '2025-03-31'),
(108, 3, 'sencilla', 92.00, '2025-01-01', '2025-03-31'),
(109, 3, 'doble', 87.00, '2025-01-04', '2025-04-16'),
(110, 3, 'triple', 92.00, '2025-01-04', '2025-04-16'),
(111, 3, 'sencilla', 102.00, '2025-01-04', '2025-04-16'),
(112, 3, 'doble', 90.00, '2025-04-17', '2025-06-30'),
(113, 3, 'triple', 97.00, '2025-04-17', '2025-06-30'),
(114, 3, 'sencilla', 107.00, '2025-04-17', '2025-06-30'),
(115, 3, 'doble', 94.00, '2025-07-01', '2025-08-10'),
(116, 3, 'triple', 107.00, '2025-07-01', '2025-08-10'),
(117, 3, 'sencilla', 117.00, '2025-07-01', '2025-08-10'),
(118, 3, 'doble', 102.00, '2025-08-11', '2025-09-26'),
(119, 3, 'triple', 117.00, '2025-08-11', '2025-09-26'),
(120, 3, 'sencilla', 142.00, '2025-08-11', '2025-09-26'),
(121, 3, 'doble', 90.00, '2025-09-27', '2025-11-30'),
(122, 3, 'triple', 97.00, '2025-09-27', '2025-11-30'),
(123, 3, 'sencilla', 107.00, '2025-09-27', '2025-11-30'),
(124, 3, 'doble', 102.00, '2025-12-01', '2025-12-31'),
(125, 3, 'triple', 117.00, '2025-12-01', '2025-12-31'),
(126, 3, 'sencilla', 142.00, '2025-12-01', '2025-12-31'),
(127, 4, 'doble', 70.00, '2025-01-01', '2025-03-31'),
(128, 4, 'triple', 75.00, '2025-01-01', '2025-03-31'),
(129, 4, 'sencilla', 80.00, '2025-01-01', '2025-03-31'),
(130, 4, 'doble', 75.00, '2025-01-04', '2025-04-16'),
(131, 4, 'triple', 80.00, '2025-01-04', '2025-04-16'),
(132, 4, 'sencilla', 90.00, '2025-01-04', '2025-04-16'),
(133, 4, 'doble', 78.00, '2025-04-17', '2025-06-30'),
(134, 4, 'triple', 85.00, '2025-04-17', '2025-06-30'),
(135, 4, 'sencilla', 95.00, '2025-04-17', '2025-06-30'),
(136, 4, 'doble', 82.00, '2025-07-01', '2025-08-10'),
(137, 4, 'triple', 95.00, '2025-07-01', '2025-08-10'),
(138, 4, 'sencilla', 105.00, '2025-07-01', '2025-08-10'),
(139, 4, 'doble', 90.00, '2025-08-11', '2025-09-26'),
(140, 4, 'triple', 105.00, '2025-08-11', '2025-09-26'),
(141, 4, 'sencilla', 130.00, '2025-08-11', '2025-09-26'),
(142, 4, 'doble', 78.00, '2025-09-27', '2025-11-30'),
(143, 4, 'triple', 85.00, '2025-09-27', '2025-11-30'),
(144, 4, 'sencilla', 95.00, '2025-09-27', '2025-11-30'),
(145, 4, 'doble', 90.00, '2025-12-01', '2025-12-31'),
(146, 4, 'triple', 105.00, '2025-12-01', '2025-12-31'),
(147, 4, 'sencilla', 130.00, '2025-12-01', '2025-12-31'),
(148, 5, 'doble', 62.00, '2025-01-01', '2025-03-31'),
(149, 5, 'triple', 67.00, '2025-01-01', '2025-03-31'),
(150, 5, 'sencilla', 72.00, '2025-01-01', '2025-03-31'),
(151, 5, 'doble', 67.00, '2025-01-04', '2025-04-16'),
(152, 5, 'triple', 72.00, '2025-01-04', '2025-04-16'),
(153, 5, 'sencilla', 82.00, '2025-01-04', '2025-04-16'),
(154, 5, 'doble', 70.00, '2025-04-17', '2025-06-30'),
(155, 5, 'triple', 77.00, '2025-04-17', '2025-06-30'),
(156, 5, 'sencilla', 87.00, '2025-04-17', '2025-06-30'),
(157, 5, 'doble', 74.00, '2025-07-01', '2025-08-10'),
(158, 5, 'triple', 87.00, '2025-07-01', '2025-08-10'),
(159, 5, 'sencilla', 97.00, '2025-07-01', '2025-08-10'),
(160, 5, 'doble', 82.00, '2025-08-11', '2025-09-26'),
(161, 5, 'triple', 97.00, '2025-08-11', '2025-09-26'),
(162, 5, 'sencilla', 122.00, '2025-08-11', '2025-09-26'),
(163, 5, 'doble', 70.00, '2025-09-27', '2025-11-30'),
(164, 5, 'triple', 77.00, '2025-09-27', '2025-11-30'),
(165, 5, 'sencilla', 87.00, '2025-09-27', '2025-11-30'),
(166, 5, 'doble', 82.00, '2025-12-01', '2025-12-31'),
(167, 5, 'triple', 97.00, '2025-12-01', '2025-12-31'),
(168, 5, 'sencilla', 122.00, '2025-12-01', '2025-12-31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_hotel` (`id_hotel`);

--
-- Indices de la tabla `tarifas`
--
ALTER TABLE `tarifas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_hotel` (`id_hotel`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `hoteles`
--
ALTER TABLE `hoteles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `tarifas`
--
ALTER TABLE `tarifas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id`);

--
-- Filtros para la tabla `tarifas`
--
ALTER TABLE `tarifas`
  ADD CONSTRAINT `tarifas_ibfk_1` FOREIGN KEY (`id_hotel`) REFERENCES `hoteles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
