-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-03-2024 a las 21:46:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `simple_pos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `products`
--

CREATE TABLE `products` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `productType` varchar(10) NOT NULL DEFAULT 'UNIDAD',
  `price` float NOT NULL,
  `stock` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `products`
--

INSERT INTO `products` (`id`, `name`, `productType`, `price`, `stock`) VALUES
(1, 'Limón', 'UNIDAD', 30, 20),
(2, 'Limpiaparabrisas', 'UNIDAD', 120, 15),
(3, 'Detergente en polvo', 'UNIDAD', 200, 10),
(4, 'Suavizante de telas', 'UNIDAD', 150, 8),
(5, 'Bolsas de basura', 'UNIDAD', 80, 25),
(6, 'Papel aluminio', 'UNIDAD', 50, 30),
(7, 'Film plástico', 'UNIDAD', 60, 20),
(8, 'Toallas de papel', 'UNIDAD', 100, 15),
(9, 'Café molido', 'UNIDAD', 180, 10),
(10, 'Té negro', 'UNIDAD', 120, 8),
(11, 'Arroz integral', 'UNIDAD', 130, 20),
(12, 'Avena en hojuelas', 'UNIDAD', 100, 15),
(13, 'Lentejas rojas', 'UNIDAD', 160, 10),
(14, 'Garbanzos cocidos', 'UNIDAD', 180, 8),
(15, 'Aceite de coco', 'UNIDAD', 250, 5),
(16, 'Vinagre balsámico', 'UNIDAD', 200, 3),
(17, 'Salsa de soya', 'UNIDAD', 100, 20),
(18, 'Especias mixtas', 'UNIDAD', 150, 15),
(19, 'Hierbas aromáticas', 'UNIDAD', 120, 10),
(20, 'Frutos secos mixtos', 'UNIDAD', 200, 8),
(21, 'Manzana', 'UNIDAD', 50, 30),
(22, 'Plátano', 'UNIDAD', 25, 50),
(23, 'Naranja', 'UNIDAD', 40, 20),
(24, 'Uva', 'UNIDAD', 100, 15),
(25, 'Lechuga', 'UNIDAD', 30, 25),
(26, 'Tomate', 'UNIDAD', 40, 20),
(27, 'Cebolla', 'UNIDAD', 25, 30),
(28, 'Ajo', 'UNIDAD', 50, 10),
(29, 'Papa', 'UNIDAD', 40, 40),
(30, 'Yuca', 'UNIDAD', 30, 35),
(31, 'Carne de cerdo', 'UNIDAD', 350, 8),
(32, 'Pollo entero', 'UNIDAD', 400, 5),
(33, 'Salmón', 'UNIDAD', 600, 3),
(34, 'Atún enlatado', 'UNIDAD', 120, 20),
(35, 'Arveja', 'UNIDAD', 80, 15),
(36, 'Maíz', 'UNIDAD', 50, 25),
(37, 'Aceite vegetal', 'UNIDAD', 150, 10),
(38, 'Mantequilla', 'UNIDAD', 200, 8),
(39, 'Harina de trigo', 'UNIDAD', 80, 30),
(40, 'Azúcar morena', 'UNIDAD', 80, 20),
(41, 'Chocolate en polvo', 'UNIDAD', 150, 15),
(42, 'Galletas dulces', 'UNIDAD', 100, 25),
(43, 'Galletas saladas', 'UNIDAD', 80, 30),
(44, 'Cereales', 'UNIDAD', 120, 20),
(45, 'Papel higiénico', 'UNIDAD', 50, 40),
(46, 'Jabón de baño', 'UNIDAD', 80, 25),
(47, 'Champú', 'UNIDAD', 100, 20),
(48, 'Pasta dental', 'UNIDAD', 70, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`) VALUES
(1, 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'admin');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
