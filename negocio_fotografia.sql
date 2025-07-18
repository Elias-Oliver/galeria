-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-07-2025 a las 03:26:57
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
-- Base de datos: `negocio_fotografia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id_reserva` int(4) NOT NULL,
  `tipo_sesion` enum('cobertura de evento','tematica','estudio','exterior','otro') NOT NULL,
  `otros_datos` varchar(200) DEFAULT NULL,
  `lugar` varchar(100) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `duracion` enum('1 hora','2 horas','3 horas') NOT NULL,
  `cedula_cliente` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `agenda`
--

INSERT INTO `agenda` (`id_reserva`, `tipo_sesion`, `otros_datos`, `lugar`, `fecha`, `hora`, `duracion`, `cedula_cliente`) VALUES
(1, '', '', '', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(2, '', '', '', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(3, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(4, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(5, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(6, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(7, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269'),
(8, '', '', 'exterior', '2025-06-30', '21:30:00', '3 horas', '8-1011-2269');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `cedula` varchar(13) NOT NULL,
  `nombre_completo` varchar(60) NOT NULL,
  `telefono_celular` int(8) NOT NULL,
  `correo` varchar(80) NOT NULL,
  `direccion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`cedula`, `nombre_completo`, `telefono_celular`, `correo`, `direccion`) VALUES
('8-1011-2269', 'elias oliver', 804739474, 'eliasricardooliver@gmail.com\r\n', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fotos`
--

CREATE TABLE `fotos` (
  `id` int(11) NOT NULL,
  `galeria_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `is_selected` tinyint(1) DEFAULT 0,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `fotos`
--

INSERT INTO `fotos` (`id`, `galeria_id`, `filename`, `url`, `is_selected`, `uploaded_at`) VALUES
(4, 4, 'Copilot_20250703_153123.png', '../galeria/687989bec1d19_Copilot_20250703_153123.png', 0, '2025-07-17 23:39:42'),
(5, 4, '20250703_1528_image.png', '../galeria/687989c4b38af_20250703_1528_image.png', 1, '2025-07-17 23:39:48'),
(6, 4, '20250703_1522_image.png', '../galeria/687989caa329e_20250703_1522_image.png', 1, '2025-07-17 23:39:54'),
(7, 5, 'Copilot_20250703_153123.png', '../galeria/687990b219c56_Copilot_20250703_153123.png', 0, '2025-07-18 00:09:22'),
(8, 5, '20250703_1528_image.png', '../galeria/687990b911eca_20250703_1528_image.png', 0, '2025-07-18 00:09:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galerias`
--

CREATE TABLE `galerias` (
  `id` int(11) NOT NULL,
  `client_email` varchar(255) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `estado` enum('draft','review','selected','completed') DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `galerias`
--

INSERT INTO `galerias` (`id`, `client_email`, `admin_id`, `token`, `estado`, `created_at`) VALUES
(4, 'eliasricardooliver@gmail.com', 1, '3489446599abbce0', 'selected', '2025-07-17 23:39:23'),
(5, 'themoisesespinosa507@gmail.com', 1, '54b29b0ba2dce537', 'draft', '2025-07-18 00:09:07'),
(9, 'w4039599@gmail.com', 1, '9cb5246e2deb39b7', 'draft', '2025-07-18 00:55:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(4) NOT NULL,
  `monto_total` decimal(4,2) NOT NULL,
  `abono_inicial` decimal(4,2) NOT NULL,
  `estado` enum('por cobrar','pagado') NOT NULL,
  `id_reserva` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `monto_total`, `abono_inicial`, `estado`, `id_reserva`) VALUES
(1, 99.99, 99.99, 'por cobrar', 0),
(2, 99.99, 99.99, 'por cobrar', 2),
(3, 99.99, 90.00, 'por cobrar', 3),
(4, 99.99, 90.00, 'por cobrar', 4),
(5, 99.99, 90.00, 'por cobrar', 5),
(6, 99.99, 90.00, 'por cobrar', 6),
(7, 99.99, 90.00, 'por cobrar', 7),
(8, 99.99, 90.00, 'por cobrar', 8);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `FK_cedula_cliente` (`cedula_cliente`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cedula`);

--
-- Indices de la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galeria_id` (`galeria_id`);

--
-- Indices de la tabla `galerias`
--
ALTER TABLE `galerias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `FK_id_reserva` (`id_reserva`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id_reserva` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `fotos`
--
ALTER TABLE `fotos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `galerias`
--
ALTER TABLE `galerias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD CONSTRAINT `FK_cedula_cliente` FOREIGN KEY (`cedula_cliente`) REFERENCES `cliente` (`cedula`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `fotos`
--
ALTER TABLE `fotos`
  ADD CONSTRAINT `fotos_ibfk_1` FOREIGN KEY (`galeria_id`) REFERENCES `galerias` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `FK_id_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `agenda` (`id_reserva`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
