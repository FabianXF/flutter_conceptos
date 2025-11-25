-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-11-2025 a las 21:09:36
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
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `codigo_curso` varchar(20) NOT NULL,
  `nombre_curso` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `creditos` int(11) DEFAULT 3,
  `semestre` int(11) DEFAULT NULL,
  `docente_id` int(11) DEFAULT NULL,
  `cupo_maximo` int(11) DEFAULT 30,
  `cupo_disponible` int(11) DEFAULT 30,
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `codigo_curso`, `nombre_curso`, `descripcion`, `creditos`, `semestre`, `docente_id`, `cupo_maximo`, `cupo_disponible`, `estado`, `fecha_creacion`) VALUES
(1, 'MOV-101', 'Desarrollo Móvil I', 'Introducción al desarrollo de aplicaciones móviles con Flutter', 4, 7, 1, 30, 25, 'ACTIVO', '2025-11-25 17:39:23'),
(2, 'WEB-201', 'Desarrollo Web Avanzado', 'Desarrollo de aplicaciones web con React y Node.js', 4, 7, 2, 25, 20, 'ACTIVO', '2025-11-25 17:39:23'),
(3, 'BD-301', 'Bases de Datos II', 'Diseño y administración de bases de datos relacionales', 3, 6, 1, 35, 30, 'ACTIVO', '2025-11-25 17:39:23'),
(4, '1234', 'Mobiles', 'Flutter 2.0', 3, 7, NULL, 30, 30, 'ACTIVO', '2025-11-25 19:53:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `id_detalle` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `codEstudiante` int(6) NOT NULL,
  `identificacion` varchar(255) DEFAULT NULL,
  `nombres` varchar(255) DEFAULT NULL,
  `apellidos` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `sexo` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`codEstudiante`, `identificacion`, `nombres`, `apellidos`, `telefono`, `correo`, `sexo`, `fecha_nacimiento`, `password`, `rol`) VALUES
(1, '1012345678', 'Carlos', 'García', '3134567890', 'carlos.garcia@example.com', 'M', '1999-05-14', '12345', 'ESTUDIANTE'),
(2, '1023456789', 'Ana', 'Martínez', '3209876543', NULL, 'F', '2001-11-23', '12345', 'ESTUDIANTE'),
(3, '1034567890', 'Luis', 'Ramírez', '3123456789', 'luis.ramirez@example.com', 'M', NULL, '12345', 'ESTUDIANTE'),
(4, '1045678901', 'Laura', 'Gómez', '3221234567', 'laura.gomez@example.com', 'F', '1998-07-30', '12345', 'ESTUDIANTE'),
(5, '1056789012', 'Andrés', 'Torres', '3102345678', NULL, 'M', '2000-01-17', '12345', 'ESTUDIANTE'),
(6, '1067890123', 'Sofía', 'Rojas', '3198765432', 'sofia.rojas@example.com', 'F', NULL, '12345', 'ESTUDIANTE'),
(7, '1078901234', 'Daniel', 'Moreno', '3115678901', 'daniel.moreno@example.com', 'M', '1997-10-05', '12345', 'ESTUDIANTE'),
(8, '1089012345', 'María', 'Hernández', '3187654321', NULL, 'F', '1996-04-11', '12345', 'ESTUDIANTE'),
(9, '1102345678', 'Felipe', 'Sánchez', '3154321098', 'felipe.sanchez@example.com', 'M', '1995-12-03', '12345', 'ESTUDIANTE'),
(10, '1103456789', 'Valentina', 'Pérez', '3143210987', NULL, 'F', '2001-03-19', '12345', 'ESTUDIANTE'),
(11, '1104567890', 'Tomás', 'López', '3122109876', 'tomas.lopez@example.com', 'M', NULL, '12345', 'ESTUDIANTE'),
(12, '1105678901', 'Daniela', 'Jiménez', '3101098765', 'daniela.jimenez@example.com', 'F', '1998-08-15', '12345', 'ESTUDIANTE'),
(13, '1106789012', 'Esteban', 'Navarro', '3229988776', NULL, 'M', '2000-06-10', '12345', 'ESTUDIANTE'),
(14, '1107890123', 'Isabella', 'Mendoza', '3198877665', 'isabella.mendoza@example.com', 'F', NULL, '12345', 'ESTUDIANTE'),
(15, '1108901234', 'Juan', 'Ortega', '3187766554', 'juan.ortega@example.com', 'M', '1997-01-09', '12345', 'ESTUDIANTE'),
(16, '1109012345', 'Manuela', 'Cortés', '3176655443', NULL, 'F', '1999-11-27', '12345', 'ESTUDIANTE'),
(17, '1110123456', 'Sebastián', 'Ruiz', '3165544332', 'sebastian.ruiz@example.com', 'M', NULL, '12345', 'ESTUDIANTE'),
(18, '1111234567', 'Gabriela', 'Mejía', '3154433221', 'gabriela.mejia@example.com', 'F', '1996-02-14', '12345', 'ESTUDIANTE'),
(19, '1000000001', 'María', 'González', '3001234567', 'maria.gonzalez@universidad.edu', 'F', NULL, '12345', 'ESTUDIANTE'),
(20, '1000000002', 'Carlos', 'Rodríguez', '3009876543', 'carlos.rodriguez@universidad.edu', 'M', NULL, '12345', 'DOCENTE'),
(21, '1000000003', 'Admin', 'Sistema', '3001111111', 'admin@universidad.edu', 'M', NULL, '12345', 'ESTUDIANTE'),
(22, '3214569871', 'Pepito', 'Perez', '3202136359', 'pepito@admin.com', 'M', NULL, '12345', 'ADMIN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materiales`
--

CREATE TABLE `materiales` (
  `id_material` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `precio` decimal(38,2) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `imagen_url` varchar(500) DEFAULT NULL,
  `autor` varchar(200) DEFAULT NULL,
  `editorial` varchar(200) DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materiales`
--

INSERT INTO `materiales` (`id_material`, `nombre`, `descripcion`, `categoria`, `precio`, `stock`, `imagen_url`, `autor`, `editorial`, `disponible`, `fecha_creacion`) VALUES
(1, 'Flutter Complete Guide', 'Guía completa de Flutter para principiantes y avanzados', 'Libros', 45.99, 50, NULL, 'Maximilian Schwarzmüller', 'Udemy Press', 1, '2025-11-25 17:39:23'),
(2, 'Laptop HP Pavilion', 'Laptop ideal para desarrollo de software', 'Equipos', 899.99, 10, NULL, 'HP', 'HP Inc.', 1, '2025-11-25 17:39:23'),
(3, 'Mouse Inalámbrico Logitech', 'Mouse ergonómico para programadores', 'Accesorios', 25.99, 100, NULL, 'Logitech', 'Logitech', 1, '2025-11-25 17:39:23'),
(4, 'Teclado Mecánico RGB', 'Teclado mecánico para programación', 'Accesorios', 79.99, 30, NULL, 'Redragon', 'Redragon', 1, '2025-11-25 17:39:23'),
(5, 'Curso Online: React Avanzado', 'Curso completo de React con proyectos reales', 'Cursos', 39.99, 999, NULL, 'Fernando Herrera', 'DevTalles', 1, '2025-11-25 17:39:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `estudiante_id` int(11) NOT NULL,
  `fecha_pedido` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` varchar(20) DEFAULT 'PENDIENTE',
  `direccion_entrega` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id_tarea` int(11) NOT NULL,
  `curso_id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_entrega` datetime NOT NULL,
  `puntaje_maximo` decimal(38,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'ACTIVA',
  `creada_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tareas`
--

INSERT INTO `tareas` (`id_tarea`, `curso_id`, `titulo`, `descripcion`, `fecha_creacion`, `fecha_entrega`, `puntaje_maximo`, `estado`, `creada_por`) VALUES
(1, 1, 'Proyecto Final - App Flutter', 'Desarrollar una aplicación móvil completa usando Flutter', '2025-11-25 17:39:23', '2025-12-15 23:59:59', 100.00, 'ACTIVA', 1),
(2, 1, 'Tarea 1 - Widgets Básicos', 'Crear una interfaz usando widgets básicos de Flutter', '2025-11-25 17:39:23', '2025-11-30 23:59:59', 50.00, 'ACTIVA', 1),
(3, 2, 'API REST con Node.js', 'Implementar una API REST completa', '2025-11-25 17:39:23', '2025-12-10 23:59:59', 80.00, 'ACTIVA', 2);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_cursos_completa`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_cursos_completa` (
`id_curso` int(11)
,`codigo_curso` varchar(20)
,`nombre_curso` varchar(200)
,`descripcion` text
,`creditos` int(11)
,`semestre` int(11)
,`cupo_maximo` int(11)
,`cupo_disponible` int(11)
,`estado` varchar(20)
,`nombre_docente` varchar(511)
,`correo_docente` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_inscripciones_completa`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_inscripciones_completa` (
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_tareas_pendientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_tareas_pendientes` (
`id_tarea` int(11)
,`codigo_curso` varchar(20)
,`nombre_curso` varchar(200)
,`titulo` varchar(200)
,`descripcion` text
,`fecha_entrega` datetime
,`puntaje_maximo` decimal(38,2)
,`estado` varchar(20)
,`creada_por_nombre` varchar(511)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_cursos_completa`
--
DROP TABLE IF EXISTS `vista_cursos_completa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `vista_cursos_completa`  AS SELECT `c`.`id_curso` AS `id_curso`, `c`.`codigo_curso` AS `codigo_curso`, `c`.`nombre_curso` AS `nombre_curso`, `c`.`descripcion` AS `descripcion`, `c`.`creditos` AS `creditos`, `c`.`semestre` AS `semestre`, `c`.`cupo_maximo` AS `cupo_maximo`, `c`.`cupo_disponible` AS `cupo_disponible`, `c`.`estado` AS `estado`, concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `nombre_docente`, `e`.`correo` AS `correo_docente` FROM (`cursos` `c` left join `estudiantes` `e` on(`c`.`docente_id` = `e`.`codEstudiante`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_inscripciones_completa`
--
DROP TABLE IF EXISTS `vista_inscripciones_completa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `vista_inscripciones_completa`  AS SELECT `i`.`id_inscripcion` AS `id_inscripcion`, concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `nombre_estudiante`, `e`.`correo` AS `correo_estudiante`, `c`.`codigo_curso` AS `codigo_curso`, `c`.`nombre_curso` AS `nombre_curso`, `i`.`fecha_inscripcion` AS `fecha_inscripcion`, `i`.`estado` AS `estado`, `i`.`nota_final` AS `nota_final` FROM ((`inscripciones` `i` join `estudiantes` `e` on(`i`.`estudiante_id` = `e`.`codEstudiante`)) join `cursos` `c` on(`i`.`curso_id` = `c`.`id_curso`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_tareas_pendientes`
--
DROP TABLE IF EXISTS `vista_tareas_pendientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `vista_tareas_pendientes`  AS SELECT `t`.`id_tarea` AS `id_tarea`, `c`.`codigo_curso` AS `codigo_curso`, `c`.`nombre_curso` AS `nombre_curso`, `t`.`titulo` AS `titulo`, `t`.`descripcion` AS `descripcion`, `t`.`fecha_entrega` AS `fecha_entrega`, `t`.`puntaje_maximo` AS `puntaje_maximo`, `t`.`estado` AS `estado`, concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `creada_por_nombre` FROM ((`tareas` `t` join `cursos` `c` on(`t`.`curso_id` = `c`.`id_curso`)) left join `estudiantes` `e` on(`t`.`creada_por` = `e`.`codEstudiante`)) WHERE `t`.`estado` = 'ACTIVA' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`),
  ADD UNIQUE KEY `codigo_curso` (`codigo_curso`),
  ADD KEY `docente_id` (`docente_id`);

--
-- Indices de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `material_id` (`material_id`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`codEstudiante`),
  ADD UNIQUE KEY `identificacion` (`identificacion`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `identificacion_2` (`identificacion`),
  ADD UNIQUE KEY `correo_2` (`correo`),
  ADD UNIQUE KEY `identificacion_3` (`identificacion`);

--
-- Indices de la tabla `materiales`
--
ALTER TABLE `materiales`
  ADD PRIMARY KEY (`id_material`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `estudiante_id` (`estudiante_id`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id_tarea`),
  ADD KEY `curso_id` (`curso_id`),
  ADD KEY `creada_por` (`creada_por`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `codEstudiante` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `materiales`
--
ALTER TABLE `materiales`
  MODIFY `id_material` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id_tarea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `estudiantes` (`codEstudiante`) ON DELETE SET NULL;

--
-- Filtros para la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD CONSTRAINT `detalles_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE,
  ADD CONSTRAINT `detalles_pedido_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materiales` (`id_material`) ON DELETE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`codEstudiante`) ON DELETE CASCADE;

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE,
  ADD CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`creada_por`) REFERENCES `estudiantes` (`codEstudiante`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
