-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2020 a las 03:28:32
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `delilahresto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `depe_id` int(11) NOT NULL,
  `pedi_id` int(11) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `depe_cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(1, 1, 1, 2);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(2, 1, 2, 1);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(5, 3, 1, 4);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(6, 3, 2, 2);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(7, 4, 1, 4);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(8, 4, 2, 2);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(9, 5, 1, 4);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(10, 5, 2, 2);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(11, 6, 1, 2);
INSERT INTO `detalle_pedido` (`depe_id`, `pedi_id`, `prod_id`, `depe_cantidad`) VALUES(12, 6, 2, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_pedido`
--

CREATE TABLE `estado_pedido` (
  `espe_id` int(11) NOT NULL,
  `espe_nombre` char(50) DEFAULT NULL,
  `espe_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_pedido`
--

INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(1, 'Nuevo', 1);
INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(2, 'Confirmado', 1);
INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(3, 'En preparación', 1);
INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(4, 'Enviado', 1);
INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(5, 'Cancelado', 1);
INSERT INTO `estado_pedido` (`espe_id`, `espe_nombre`, `espe_estado`) VALUES(6, 'Entregado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estado_pedido`
--

CREATE TABLE `historial_estado_pedido` (
  `hiep_id` int(11) NOT NULL,
  `pedi_id` int(11) DEFAULT NULL,
  `espe_id` int(11) DEFAULT NULL,
  `hiep_fecha` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `historial_estado_pedido`
--

INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(1, 1, 1, '2020-10-12 21:19:14');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(2, 1, 3, '2020-10-12 17:06:50');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(4, 3, 1, '2020-11-03 02:18:54');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(5, 4, 1, '2020-11-03 02:22:15');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(6, 5, 1, '2020-11-03 02:24:20');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(7, 5, 3, '2020-11-03 02:56:10');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(8, 6, 1, '2020-11-07 23:08:02');
INSERT INTO `historial_estado_pedido` (`hiep_id`, `pedi_id`, `espe_id`, `hiep_fecha`) VALUES(9, 5, 3, '2020-11-07 23:09:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `pedi_id` int(11) NOT NULL,
  `pedi_fecha` datetime DEFAULT current_timestamp(),
  `tipa_id` int(11) DEFAULT NULL,
  `usua_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `prod_id` int(11) NOT NULL,
  `prod_nombre` varchar(50) DEFAULT NULL,
  `prod_descripcion` varchar(100) DEFAULT NULL,
  `prod_imagen` varchar(50) DEFAULT NULL,
  `prod_precio` int(11) DEFAULT NULL,
  `prod_estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`prod_id`, `prod_nombre`, `prod_descripcion`, `prod_imagen`, `prod_precio`, `prod_estado`) VALUES(1, 'Bagel de salmón', 'Bagel de salmón', 'imagen', 4000, 1);
INSERT INTO `producto` (`prod_id`, `prod_nombre`, `prod_descripcion`, `prod_imagen`, `prod_precio`, `prod_estado`) VALUES(2, 'Hamburguesa clásica', 'Hamburguesa al carbón', '', 7000, 1);
INSERT INTO `producto` (`prod_id`, `prod_nombre`, `prod_descripcion`, `prod_imagen`, `prod_precio`, `prod_estado`) VALUES(3, 'Ensalada veggie', 'Ensalada veggie', '', 6500, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `rol_id` int(11) NOT NULL,
  `rol_nombre` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES(1, 'cliente');
INSERT INTO `rol` (`rol_id`, `rol_nombre`) VALUES(2, 'administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `tipa_id` int(11) NOT NULL,
  `tipa_nombre` varchar(50) DEFAULT NULL,
  `tipa_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_pago`
--

INSERT INTO `tipo_pago` (`tipa_id`, `tipa_nombre`, `tipa_estado`) VALUES(1, 'efectivo', 1);
INSERT INTO `tipo_pago` (`tipa_id`, `tipa_nombre`, `tipa_estado`) VALUES(2, 'tarjeta débito', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `usua_id` int(11) NOT NULL,
  `usua_nombre` varchar(50) NOT NULL,
  `usua_apellido` varchar(50) NOT NULL,
  `usua_username` varchar(50) NOT NULL,
  `usua_password` varchar(50) NOT NULL,
  `usua_direccion` varchar(100) NOT NULL,
  `usua_telefono` int(11) NOT NULL,
  `usua_correo` varchar(50) DEFAULT NULL,
  `rol_id` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`usua_id`, `usua_nombre`, `usua_apellido`, `usua_username`, `usua_password`, `usua_direccion`, `usua_telefono`, `usua_correo`, `rol_id`) VALUES(1, 'Dayana', 'Ruiz', 'dayana.ruiz', 'dayana.endo', 'Cra 4e #43 Bogotá', 22334455, 'dayana.en@correo.co', 1);
INSERT INTO `usuario` (`usua_id`, `usua_nombre`, `usua_apellido`, `usua_username`, `usua_password`, `usua_direccion`, `usua_telefono`, `usua_correo`, `rol_id`) VALUES(2, 'Nicol', 'Endo', 'nicol.endo', 'nicol.endo', 'Cra 4e #43', 32321, 'nicol.endo@correo.co', 2);
INSERT INTO `usuario` (`usua_id`, `usua_nombre`, `usua_apellido`, `usua_username`, `usua_password`, `usua_direccion`, `usua_telefono`, `usua_correo`, `rol_id`) VALUES(3, 'Heidy', 'Endo', 'heidy.endo', 'heidy.endo', 'Cra 4e #43', 32321, 'heidy.endo@correo.co', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`depe_id`);

--
-- Indices de la tabla `estado_pedido`
--
ALTER TABLE `estado_pedido`
  ADD PRIMARY KEY (`espe_id`);

--
-- Indices de la tabla `historial_estado_pedido`
--
ALTER TABLE `historial_estado_pedido`
  ADD PRIMARY KEY (`hiep_id`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`pedi_id`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`prod_id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rol_id`);

--
-- Indices de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`tipa_id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usua_id`) USING BTREE,
  ADD UNIQUE KEY `usua_username` (`usua_username`),
  ADD KEY `usua_nombre` (`usua_nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `depe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `estado_pedido`
--
ALTER TABLE `estado_pedido`
  MODIFY `espe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `historial_estado_pedido`
--
ALTER TABLE `historial_estado_pedido`
  MODIFY `hiep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `pedi_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `prod_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rol_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `tipa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usua_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
