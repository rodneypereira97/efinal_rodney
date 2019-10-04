-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.17-log - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para compras_ventas
DROP DATABASE IF EXISTS `compras_ventas`;
CREATE DATABASE IF NOT EXISTS `compras_ventas` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `compras_ventas`;

-- Volcando estructura para tabla compras_ventas.almacen
DROP TABLE IF EXISTS `almacen`;
CREATE TABLE IF NOT EXISTS `almacen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `predeterminado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.almacen: ~0 rows (aproximadamente)
DELETE FROM `almacen`;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.caja
DROP TABLE IF EXISTS `caja`;
CREATE TABLE IF NOT EXISTS `caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `operacion` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `efectivo` decimal(10,2) NOT NULL,
  `observacion` varchar(200) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `gastos_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `fk_caja_gastos_idx` (`gastos_id`),
  CONSTRAINT `caja_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_caja_gastos` FOREIGN KEY (`gastos_id`) REFERENCES `gastos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.caja: ~2 rows (aproximadamente)
DELETE FROM `caja`;
/*!40000 ALTER TABLE `caja` DISABLE KEYS */;
INSERT INTO `caja` (`id`, `fecha`, `monto`, `operacion`, `usuario_id`, `efectivo`, `observacion`, `estado`, `gastos_id`) VALUES
	(1, '2018-10-21 07:25:00', 100.00, 1, 5, 0.00, '', NULL, NULL),
	(2, '2019-09-29 13:34:04', 1000000.00, 1, 5, 0.00, '', NULL, NULL);
/*!40000 ALTER TABLE `caja` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.categorias
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.categorias: ~1 rows (aproximadamente)
DELETE FROM `categorias`;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `estado`) VALUES
	(25, 'Limpieza', 'Todo tipo de productos de limpieza', 1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.clientes
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `tipo_contribuyente_id` int(11) DEFAULT NULL,
  `tipo_documento_id` int(11) DEFAULT NULL,
  `num_documento` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_cliente_idx` (`tipo_contribuyente_id`),
  KEY `fk_tipo_documento_idx` (`tipo_documento_id`),
  CONSTRAINT `fk_tipo_contribuyente` FOREIGN KEY (`tipo_contribuyente_id`) REFERENCES `tipo_contribuyente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_documento` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipo_documento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.clientes: ~1 rows (aproximadamente)
DELETE FROM `clientes`;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`id`, `nombre`, `telefono`, `direccion`, `tipo_contribuyente_id`, `tipo_documento_id`, `num_documento`, `estado`) VALUES
	(95, 'Juan Perez', '988898989', 'Miramar E-13 Parte Baja', 3, 2, '89098911', 1);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.compras
DROP TABLE IF EXISTS `compras`;
CREATE TABLE IF NOT EXISTS `compras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `subtotal` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `comprobante` varchar(100) NOT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `tipo_pago_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `numero` varchar(50) NOT NULL,
  `serie` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_documento_prov_compras_idx` (`comprobante`),
  KEY `fk_proveedor_compras_idx` (`proveedor_id`),
  KEY `fk_usuarios_compras_idx` (`usuario_id`),
  KEY `fk_tipo_pago_compras_idx` (`tipo_pago_id`),
  KEY `fk_almacen_compras_idx` (`almacen_id`),
  CONSTRAINT `fk_almacen_compras` FOREIGN KEY (`almacen_id`) REFERENCES `almacen` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proveedor_compras` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_pago_compras` FOREIGN KEY (`tipo_pago_id`) REFERENCES `tipo_pago` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_compras` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.compras: ~1 rows (aproximadamente)
DELETE FROM `compras`;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` (`id`, `fecha`, `subtotal`, `total`, `comprobante`, `proveedor_id`, `tipo_pago_id`, `usuario_id`, `almacen_id`, `estado`, `numero`, `serie`) VALUES
	(11, '2018-10-25', '108.00', '108.00', 'Factura', 1, 1, 5, NULL, 1, '45464545', '001');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.configuraciones
DROP TABLE IF EXISTS `configuraciones`;
CREATE TABLE IF NOT EXISTS `configuraciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clave_permiso` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.configuraciones: ~1 rows (aproximadamente)
DELETE FROM `configuraciones`;
/*!40000 ALTER TABLE `configuraciones` DISABLE KEYS */;
INSERT INTO `configuraciones` (`id`, `clave_permiso`) VALUES
	(1, 'alex');
/*!40000 ALTER TABLE `configuraciones` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.detalle_compra
DROP TABLE IF EXISTS `detalle_compra`;
CREATE TABLE IF NOT EXISTS `detalle_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `cantidad` varchar(45) DEFAULT NULL,
  `importe` varchar(45) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_detalle_compra_compra_idx` (`compra_id`),
  KEY `fk_detalle_compra_producto_idx` (`producto_id`),
  KEY `fk_detalle_compra_marca_idx` (`marca_id`),
  CONSTRAINT `fk_detalle_compra_compra` FOREIGN KEY (`compra_id`) REFERENCES `compras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compra_marca` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_compra_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.detalle_compra: ~1 rows (aproximadamente)
DELETE FROM `detalle_compra`;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` (`id`, `compra_id`, `producto_id`, `precio`, `cantidad`, `importe`, `marca_id`) VALUES
	(10, 11, 189, '9.00', '12', '108.00', NULL);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.detalle_venta
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `importe` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_venta_detalle_idx` (`venta_id`),
  KEY `fk_producto_detalle_idx` (`producto_id`),
  CONSTRAINT `fk_producto_detalle` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_detalle` FOREIGN KEY (`venta_id`) REFERENCES `ventas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4034 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.detalle_venta: ~4 rows (aproximadamente)
DELETE FROM `detalle_venta`;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` (`id`, `producto_id`, `venta_id`, `precio`, `cantidad`, `importe`) VALUES
	(4030, 189, 1088, '9.00', 2, '18.00'),
	(4031, 188, 1089, '2.50', 5, '12.50'),
	(4032, 189, 1090, '9.00', 1, '9.00'),
	(4033, 188, 1092, '2.50', 1, '2.50');
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.documento_prov
DROP TABLE IF EXISTS `documento_prov`;
CREATE TABLE IF NOT EXISTS `documento_prov` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL,
  `correlativo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.documento_prov: ~0 rows (aproximadamente)
DELETE FROM `documento_prov`;
/*!40000 ALTER TABLE `documento_prov` DISABLE KEYS */;
/*!40000 ALTER TABLE `documento_prov` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.empresa
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `propietario` varchar(45) DEFAULT NULL,
  `logotipo` varchar(45) DEFAULT NULL,
  `nit` varchar(45) DEFAULT NULL,
  `moneda_id` int(11) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `facebook` varchar(45) DEFAULT NULL,
  `web` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_moneda_empresa_idx` (`moneda_id`),
  CONSTRAINT `fk_tipo_moneda_empresa` FOREIGN KEY (`moneda_id`) REFERENCES `tipo_moneda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.empresa: ~0 rows (aproximadamente)
DELETE FROM `empresa`;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.gastos
DROP TABLE IF EXISTS `gastos`;
CREATE TABLE IF NOT EXISTS `gastos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `tipo_gasto_id` int(11) DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  `notas` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gastos_tipo_gasto_idx` (`tipo_gasto_id`),
  CONSTRAINT `fk_gastos_tipo_gasto` FOREIGN KEY (`tipo_gasto_id`) REFERENCES `tipo_gasto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.gastos: ~0 rows (aproximadamente)
DELETE FROM `gastos`;
/*!40000 ALTER TABLE `gastos` DISABLE KEYS */;
/*!40000 ALTER TABLE `gastos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.inventarios
DROP TABLE IF EXISTS `inventarios`;
CREATE TABLE IF NOT EXISTS `inventarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `month` int(11) NOT NULL,
  `year` year(4) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.inventarios: ~1 rows (aproximadamente)
DELETE FROM `inventarios`;
/*!40000 ALTER TABLE `inventarios` DISABLE KEYS */;
INSERT INTO `inventarios` (`id`, `month`, `year`, `usuario_id`, `created_at`) VALUES
	(20, 10, '2018', 5, '2018-10-25 02:00:00');
/*!40000 ALTER TABLE `inventarios` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.inventario_producto
DROP TABLE IF EXISTS `inventario_producto`;
CREATE TABLE IF NOT EXISTS `inventario_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `inventario_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.inventario_producto: ~3 rows (aproximadamente)
DELETE FROM `inventario_producto`;
/*!40000 ALTER TABLE `inventario_producto` DISABLE KEYS */;
INSERT INTO `inventario_producto` (`id`, `producto_id`, `inventario_id`, `cantidad`) VALUES
	(33, 188, 20, 21),
	(34, 189, 20, 0),
	(35, 190, 20, 3);
/*!40000 ALTER TABLE `inventario_producto` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.logs
DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `modulo` varchar(200) DEFAULT NULL,
  `accion` text,
  PRIMARY KEY (`id`),
  KEY `fk_logs_usuarios_idx` (`usuario_id`),
  CONSTRAINT `fk_logs_usuarios` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.logs: ~22 rows (aproximadamente)
DELETE FROM `logs`;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`id`, `fecha`, `usuario_id`, `modulo`, `accion`) VALUES
	(1, '2018-10-23 22:35:30', 5, 'Usuarios', 'Cierre de sesión'),
	(2, '2018-10-23 22:35:37', 5, 'Usuarios', 'Inicio de sesión'),
	(3, '2018-10-23 22:47:18', 5, 'Productos', 'Actualización del Producto con codigo de barra 7756641003971'),
	(4, '2018-10-23 22:47:40', 5, 'Productos', 'Eliminación del  Producto con codigo de barra 7750885014649'),
	(5, '2018-10-23 22:56:30', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1084'),
	(6, '2018-10-25 20:53:17', 5, 'Usuarios', 'Inicio de sesión'),
	(7, '2018-10-25 22:58:23', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1085'),
	(8, '2018-10-25 23:05:05', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1086'),
	(9, '2018-10-25 23:28:21', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1087'),
	(10, '2018-10-25 23:29:17', 5, 'Ventas', 'Actualizacion de la venta con identificador 1087'),
	(11, '2018-10-25 23:30:48', 5, 'Ventas', 'Actualizacion de la venta con identificador 1087'),
	(12, '2018-10-25 23:47:59', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1088'),
	(13, '2018-10-25 23:48:25', 5, 'Ventas', 'Eliminacion de la venta con identificador 1088'),
	(14, '2019-09-29 13:27:53', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1089'),
	(15, '2019-09-29 13:27:59', 5, 'Ventas', 'Eliminacion de la venta con identificador 1089'),
	(16, '2019-09-29 13:32:59', 5, 'Usuarios', 'Inicio de sesión'),
	(17, '2019-09-29 13:35:56', 5, 'Productos', 'Eliminación del  Producto con codigo de barra 7756641003971'),
	(18, '2019-09-29 14:17:43', 5, 'Usuarios', 'Cierre de sesión'),
	(19, '2019-09-29 14:17:50', 5, 'Usuarios', 'Inicio de sesión'),
	(20, '2019-09-30 19:39:03', 5, 'Usuarios', 'Inicio de sesión'),
	(21, '2019-09-30 20:00:42', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1090'),
	(22, '2019-09-30 20:33:04', 5, 'Ventas', 'Inserción de una nueva venta con identificador 1092');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.marca
DROP TABLE IF EXISTS `marca`;
CREATE TABLE IF NOT EXISTS `marca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.marca: ~1 rows (aproximadamente)
DELETE FROM `marca`;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` (`id`, `nombre`, `estado`) VALUES
	(1, 'Poet', 1);
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.menus
DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL,
  `parent` varchar(10) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.menus: ~39 rows (aproximadamente)
DELETE FROM `menus`;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `nombre`, `link`, `parent`, `orden`, `estado`) VALUES
	(1, 'Inicio', 'dashboard', '0', 1, 1),
	(2, 'Categorias', 'mantenimiento/categorias', '9', 0, 1),
	(3, 'Clientes', 'mantenimiento/clientes', '9', 0, 1),
	(4, 'Productos', 'mantenimiento/productos', '9', 0, 1),
	(5, 'Ventas', 'movimientos/ventas', '10', 0, 1),
	(6, 'Reporte de Ventas', 'reportes/ventas', '11', 0, 1),
	(7, 'Usuarios', 'administrador/usuarios', '12', 0, 1),
	(8, 'Permisos', 'administrador/permisos', '12', 0, 1),
	(9, 'Mantenimiento', '#', '0', 3, 1),
	(10, 'Movimientos', '#', '0', 5, 1),
	(11, 'Reportes', '#', '0', 6, 1),
	(12, 'Administrador', '#', '0', 7, 1),
	(13, 'Configuraciones', '#', '0', 0, 1),
	(14, 'Apertura de Caja', 'caja/apertura', '15', 0, 1),
	(15, 'Caja', '#', '0', 4, 1),
	(16, 'Cierre de Caja', 'caja/cierre', '15', 0, 1),
	(17, 'Reporte de Inventario', 'reportes/inventario', '11', 0, 1),
	(18, 'Ordenes', 'movimientos/ordenes', '10', 0, 1),
	(19, 'Mesas', 'mantenimiento/mesas', '9', 0, 1),
	(20, 'Clave de Permiso', 'administrador/clave-permiso', '12', 0, 1),
	(21, 'Productos Vendidos', 'reportes/productos', '11', 0, 1),
	(22, 'Subcategorias', 'mantenimiento/subcategorias', '9', 0, 1),
	(23, 'Panel de Control', 'reportes/grafico', '0', 0, 0),
	(24, 'Cuentas por Cobrar', '#', '0', 6, 1),
	(25, 'Ordenes Pendientes', 'movimientos/ordenes_pendientes', '24', 0, 1),
	(26, 'Marcas', 'mantenimiento/marcas', '9', 0, 1),
	(27, 'Presentacion', 'mantenimiento/presentacion', '9', 0, 1),
	(28, 'Almacen', 'mantenimiento/almacen', '9', 0, 1),
	(29, 'Contribuyente', 'mantenimiento/contribuyente', '9', 0, 1),
	(30, 'Documentos', 'mantenimiento/documento', '9', 0, 1),
	(31, 'Comprobantes', 'mantenimiento/comprobante', '9', 0, 1),
	(32, 'Proveedores', 'mantenimiento/proveedor', '9', 0, 1),
	(33, 'Moneda', 'mantenimiento/monedas', '9', 0, 1),
	(34, 'Empresa', 'administrador/empresa', '12', 0, 1),
	(35, 'Compras', 'movimientos/compras', '10', 0, 1),
	(36, 'Inventario', '#', '0', 8, 1),
	(37, 'Registrar Inventario Inicial', 'inventario/registro_mensual', '36', 0, 1),
	(38, 'seguimiento', 'inventario/seguimiento', '36', 0, 1),
	(39, 'Logs', 'administrador/logs', '12', 0, 1);
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.mesas
DROP TABLE IF EXISTS `mesas`;
CREATE TABLE IF NOT EXISTS `mesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(50) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.mesas: ~3 rows (aproximadamente)
DELETE FROM `mesas`;
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
INSERT INTO `mesas` (`id`, `numero`, `estado`) VALUES
	(1, '1', 1),
	(2, '2', 0),
	(3, '3', 1);
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.notificaciones
DROP TABLE IF EXISTS `notificaciones`;
CREATE TABLE IF NOT EXISTS `notificaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productos_notificaciones_idx` (`producto_id`),
  CONSTRAINT `fk_productos_notificaciones` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.notificaciones: ~2 rows (aproximadamente)
DELETE FROM `notificaciones`;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` (`id`, `producto_id`, `estado`) VALUES
	(1, 190, 1),
	(2, 189, 1);
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos: ~9 rows (aproximadamente)
DELETE FROM `pedidos`;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` (`id`, `fecha`, `usuario_id`, `estado`) VALUES
	(1, '2019-09-29', 5, 0),
	(2, '2019-09-29', 5, 1),
	(3, '2019-09-29', 5, 1),
	(4, '2019-09-29', 5, 1),
	(5, '2019-09-29', 5, 1),
	(6, '2019-09-29', 5, 1),
	(7, '2019-09-29', 5, 1),
	(8, '2019-09-29', 5, 1),
	(9, '2019-09-30', 5, 1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos_mesa
DROP TABLE IF EXISTS `pedidos_mesa`;
CREATE TABLE IF NOT EXISTS `pedidos_mesa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) DEFAULT NULL,
  `mesa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos_mesa: ~12 rows (aproximadamente)
DELETE FROM `pedidos_mesa`;
/*!40000 ALTER TABLE `pedidos_mesa` DISABLE KEYS */;
INSERT INTO `pedidos_mesa` (`id`, `pedido_id`, `mesa_id`) VALUES
	(1, 2, 1),
	(2, 3, 1),
	(3, 4, 2),
	(4, 5, 3),
	(5, 6, 1),
	(6, 7, 1),
	(7, 8, 1),
	(8, 2, 1),
	(9, 9, 2),
	(10, 9, 0),
	(11, 9, 0),
	(12, 9, 0);
/*!40000 ALTER TABLE `pedidos_mesa` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.pedidos_productos
DROP TABLE IF EXISTS `pedidos_productos`;
CREATE TABLE IF NOT EXISTS `pedidos_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedido_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.pedidos_productos: ~7 rows (aproximadamente)
DELETE FROM `pedidos_productos`;
/*!40000 ALTER TABLE `pedidos_productos` DISABLE KEYS */;
INSERT INTO `pedidos_productos` (`id`, `pedido_id`, `producto_id`, `cantidad`, `estado`) VALUES
	(1, 3, 189, 7, NULL),
	(2, 7, 190, 4, NULL),
	(3, 8, 190, 4, NULL),
	(4, 2, 189, 3, 0),
	(11, 9, 190, 3, 0),
	(12, 9, 190, 1, 0),
	(13, 9, 189, 3, 0);
/*!40000 ALTER TABLE `pedidos_productos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.permisos
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE IF NOT EXISTS `permisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `read` int(11) DEFAULT NULL,
  `insert` int(11) DEFAULT NULL,
  `update` int(11) DEFAULT NULL,
  `delete` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menus_idx` (`menu_id`),
  KEY `fk_rol_idx` (`rol_id`),
  CONSTRAINT `fk_menus` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.permisos: ~53 rows (aproximadamente)
DELETE FROM `permisos`;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` (`id`, `menu_id`, `rol_id`, `read`, `insert`, `update`, `delete`) VALUES
	(1, 1, 2, 1, 1, 1, 1),
	(2, 2, 2, 1, 1, 1, 0),
	(3, 3, 2, 1, 1, 1, 1),
	(4, 4, 2, 1, 1, 1, 0),
	(5, 5, 2, 1, 1, 1, 1),
	(10, 1, 1, 1, 1, 1, 1),
	(11, 2, 1, 1, 1, 1, 1),
	(12, 4, 1, 1, 1, 1, 1),
	(13, 5, 1, 1, 1, 1, 1),
	(14, 6, 1, 1, 1, 1, 1),
	(15, 7, 1, 1, 1, 1, 1),
	(16, 3, 1, 1, 1, 1, 1),
	(17, 8, 1, 1, 1, 1, 1),
	(18, 9, 1, 1, 1, 1, 1),
	(19, 10, 1, 1, 1, 1, 1),
	(20, 11, 1, 1, 1, 1, 1),
	(21, 12, 1, 1, 1, 1, 1),
	(23, 9, 2, 1, 1, 1, 1),
	(24, 10, 2, 1, 1, 1, 1),
	(25, 15, 1, 1, 1, 1, 1),
	(26, 14, 1, 1, 1, 1, 1),
	(27, 16, 1, 1, 1, 1, 1),
	(28, 14, 2, 1, 1, 1, 1),
	(29, 16, 2, 1, 1, 1, 1),
	(30, 17, 1, 1, 1, 1, 1),
	(32, 19, 1, 0, 0, 0, 0),
	(33, 18, 2, 1, 1, 1, 0),
	(34, 17, 2, 1, 1, 1, 1),
	(35, 6, 2, 0, 0, 0, 0),
	(36, 11, 2, 1, 1, 1, 1),
	(37, 15, 2, 1, 1, 1, 1),
	(38, 19, 2, 1, 1, 1, 1),
	(39, 20, 1, 1, 1, 1, 1),
	(40, 21, 1, 1, 1, 1, 1),
	(41, 22, 1, 1, 1, 1, 1),
	(42, 23, 1, 1, 1, 1, 1),
	(43, 23, 2, 0, 1, 1, 1),
	(44, 24, 1, 1, 1, 1, 1),
	(46, 26, 1, 1, 1, 1, 1),
	(47, 27, 1, 1, 1, 1, 1),
	(48, 28, 1, 1, 1, 1, 1),
	(49, 29, 1, 1, 1, 1, 1),
	(50, 30, 1, 1, 1, 1, 1),
	(51, 31, 1, 1, 1, 1, 1),
	(52, 32, 1, 1, 1, 1, 1),
	(53, 33, 1, 1, 1, 1, 1),
	(54, 34, 1, 1, 1, 1, 1),
	(55, 35, 1, 1, 1, 1, 1),
	(56, 36, 1, 1, 1, 1, 1),
	(57, 37, 1, 1, 1, 1, 1),
	(58, 38, 1, 1, 1, 1, 1),
	(59, 39, 1, 1, 1, 1, 1),
	(60, 18, 1, 1, 1, 1, 1);
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.presentacion
DROP TABLE IF EXISTS `presentacion`;
CREATE TABLE IF NOT EXISTS `presentacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.presentacion: ~1 rows (aproximadamente)
DELETE FROM `presentacion`;
/*!40000 ALTER TABLE `presentacion` DISABLE KEYS */;
INSERT INTO `presentacion` (`id`, `nombre`, `estado`) VALUES
	(1, 'Unidad', 1);
/*!40000 ALTER TABLE `presentacion` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.productos
DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_barras` varchar(45) DEFAULT NULL,
  `codigo_slug` varchar(45) DEFAULT NULL,
  `nombre` varchar(200) DEFAULT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` varchar(45) DEFAULT NULL,
  `precio_compra` varchar(45) DEFAULT NULL,
  `stock` int(11) DEFAULT '0',
  `stock_minimo` int(11) NOT NULL,
  `categoria_id` int(11) DEFAULT NULL,
  `subcategoria_id` int(11) NOT NULL,
  `imagen` varchar(45) DEFAULT NULL,
  `presentacion_id` int(11) DEFAULT NULL,
  `marca_id` int(11) DEFAULT NULL,
  `pasillo` varchar(45) DEFAULT NULL,
  `estanteria` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `almacen_id` int(11) DEFAULT NULL,
  `condicion` tinyint(1) DEFAULT NULL,
  `asociado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo_barras`),
  KEY `fk_categoria_producto_idx` (`categoria_id`),
  KEY `fk_subcategoria_producto_idx` (`subcategoria_id`),
  KEY `fk_presentacion_producto_idx` (`presentacion_id`),
  KEY `fk_marca_producto_idx` (`marca_id`),
  KEY `fk_almacen_producto_idx` (`almacen_id`),
  CONSTRAINT `fk_categoria_producto` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_marca_producto` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_presentacion_producto` FOREIGN KEY (`presentacion_id`) REFERENCES `presentacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_subcategoria_producto` FOREIGN KEY (`subcategoria_id`) REFERENCES `subcategorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.productos: ~4 rows (aproximadamente)
DELETE FROM `productos`;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`id`, `codigo_barras`, `codigo_slug`, `nombre`, `descripcion`, `precio`, `precio_compra`, `stock`, `stock_minimo`, `categoria_id`, `subcategoria_id`, `imagen`, `presentacion_id`, `marca_id`, `pasillo`, `estanteria`, `estado`, `almacen_id`, `condicion`, `asociado`) VALUES
	(188, '7756641003971', NULL, 'Desinfectante Poet Primavera de 648ml', 'Desinfectante Poet Primavera de 648ml', '3.00', '2.50', 20, 10, 25, 5, 'sally_carrera1.jpg', 1, 1, '3', '4', 0, NULL, 1, 1),
	(189, '7751271011693', NULL, 'Detergente Ariel de 1kg', 'Detergente Ariel de 1kg', '10.00', '9.00', 21, 5, 25, 5, 'Penguins.jpg', 1, 1, '3', '2', 1, NULL, NULL, NULL),
	(190, '7759307005197', NULL, 'Lejia Clorox de 1litro', 'Lejia Clorox de 1litro', '5.00', '4.00', 3, 5, 25, 5, 'Penguins1.jpg', 1, 1, '1', '3', 1, NULL, NULL, NULL),
	(191, '7750885014649', NULL, 'Avena 3 ositos', 'Avena 3 ositos', '1.50', '1.20', 48, 6, 25, 5, 'Lighthouse1.jpg', 1, 1, '1', '2', 0, NULL, NULL, NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.productos_asociados
DROP TABLE IF EXISTS `productos_asociados`;
CREATE TABLE IF NOT EXISTS `productos_asociados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `producto_asociado` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.productos_asociados: ~1 rows (aproximadamente)
DELETE FROM `productos_asociados`;
/*!40000 ALTER TABLE `productos_asociados` DISABLE KEYS */;
INSERT INTO `productos_asociados` (`id`, `producto_id`, `producto_asociado`, `cantidad`) VALUES
	(2, 190, 189, 2);
/*!40000 ALTER TABLE `productos_asociados` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.proveedor
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE IF NOT EXISTS `proveedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `nit` varchar(45) DEFAULT NULL,
  `contribuyente_id` int(11) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `contacto` varchar(45) DEFAULT NULL,
  `tel_contacto` varchar(45) DEFAULT NULL,
  `banco` varchar(45) DEFAULT NULL,
  `no_cuenta` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contribuyente_proveedor_idx` (`contribuyente_id`),
  CONSTRAINT `fk_contribuyente_proveedor` FOREIGN KEY (`contribuyente_id`) REFERENCES `tipo_contribuyente` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.proveedor: ~1 rows (aproximadamente)
DELETE FROM `proveedor`;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` (`id`, `nombre`, `nit`, `contribuyente_id`, `direccion`, `telefono`, `email`, `contacto`, `tel_contacto`, `banco`, `no_cuenta`, `estado`) VALUES
	(1, 'JJ Moran S.A', '10477471123', 3, 'Calle Arica 430', '988898989', 'jjmoran@ventas.pe', 'Jose Campos', '989112121', 'Azteca S.A', '0001222214', 1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.roles: ~3 rows (aproximadamente)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
	(1, 'admin', 'todas las funciones'),
	(2, 'cajero', 'algunas funciones'),
	(3, 'Vendedor', 'Acceso algunas funciones');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.subcategorias
DROP TABLE IF EXISTS `subcategorias`;
CREATE TABLE IF NOT EXISTS `subcategorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.subcategorias: ~1 rows (aproximadamente)
DELETE FROM `subcategorias`;
/*!40000 ALTER TABLE `subcategorias` DISABLE KEYS */;
INSERT INTO `subcategorias` (`id`, `nombre`, `estado`) VALUES
	(5, 'Desinfectante', 1);
/*!40000 ALTER TABLE `subcategorias` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_comprobante
DROP TABLE IF EXISTS `tipo_comprobante`;
CREATE TABLE IF NOT EXISTS `tipo_comprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `iva` int(11) DEFAULT NULL,
  `serie` varchar(45) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT NULL,
  `no_inicial` int(11) NOT NULL,
  `no_final` int(11) NOT NULL,
  `resolucion` varchar(50) NOT NULL,
  `fecha_resolucion` date NOT NULL,
  `predeterminado` tinyint(1) NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `igv` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_comprobante: ~3 rows (aproximadamente)
DELETE FROM `tipo_comprobante`;
/*!40000 ALTER TABLE `tipo_comprobante` DISABLE KEYS */;
INSERT INTO `tipo_comprobante` (`id`, `nombre`, `iva`, `serie`, `fecha_registro`, `no_inicial`, `no_final`, `resolucion`, `fecha_resolucion`, `predeterminado`, `estado`, `cantidad`, `igv`) VALUES
	(3, 'Factura', 18, '001', '0000-00-00 00:00:00', 1, 99999999, 'resolucion 01', '0000-00-00', 0, 1, 4, 18),
	(4, 'Boleta', 0, '002', '0000-00-00 00:00:00', 1, 99999999, 'resolucion 01', '0000-00-00', 1, 1, 5, NULL),
	(5, 'Ticket', 0, '001', '2018-10-18 00:00:00', 1, 99999999, 'resolucion 01', '2018-10-18', 0, 1, 5, NULL);
/*!40000 ALTER TABLE `tipo_comprobante` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_contribuyente
DROP TABLE IF EXISTS `tipo_contribuyente`;
CREATE TABLE IF NOT EXISTS `tipo_contribuyente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_contribuyente: ~1 rows (aproximadamente)
DELETE FROM `tipo_contribuyente`;
/*!40000 ALTER TABLE `tipo_contribuyente` DISABLE KEYS */;
INSERT INTO `tipo_contribuyente` (`id`, `nombre`, `descripcion`, `estado`) VALUES
	(3, 'Persona Natural', '', 1);
/*!40000 ALTER TABLE `tipo_contribuyente` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_documento
DROP TABLE IF EXISTS `tipo_documento`;
CREATE TABLE IF NOT EXISTS `tipo_documento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.tipo_documento: ~3 rows (aproximadamente)
DELETE FROM `tipo_documento`;
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` (`id`, `nombre`, `estado`) VALUES
	(2, 'DNI', 1),
	(3, 'RUC', 1),
	(4, 'Pasaporte', 1);
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_gasto
DROP TABLE IF EXISTS `tipo_gasto`;
CREATE TABLE IF NOT EXISTS `tipo_gasto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_gasto: ~0 rows (aproximadamente)
DELETE FROM `tipo_gasto`;
/*!40000 ALTER TABLE `tipo_gasto` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_gasto` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_moneda
DROP TABLE IF EXISTS `tipo_moneda`;
CREATE TABLE IF NOT EXISTS `tipo_moneda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `simbolo` varchar(10) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_moneda: ~1 rows (aproximadamente)
DELETE FROM `tipo_moneda`;
/*!40000 ALTER TABLE `tipo_moneda` DISABLE KEYS */;
INSERT INTO `tipo_moneda` (`id`, `nombre`, `simbolo`, `estado`) VALUES
	(1, 'guarani', 'GS', 1);
/*!40000 ALTER TABLE `tipo_moneda` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.tipo_pago
DROP TABLE IF EXISTS `tipo_pago`;
CREATE TABLE IF NOT EXISTS `tipo_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `predeterminado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla compras_ventas.tipo_pago: ~2 rows (aproximadamente)
DELETE FROM `tipo_pago`;
/*!40000 ALTER TABLE `tipo_pago` DISABLE KEYS */;
INSERT INTO `tipo_pago` (`id`, `nombre`, `predeterminado`) VALUES
	(1, 'Efectivo', 1),
	(2, 'Credito', 0);
/*!40000 ALTER TABLE `tipo_pago` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagen` varchar(45) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `fk_rol_usuarios_idx` (`rol_id`),
  CONSTRAINT `fk_rol_usuarios` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.usuarios: ~3 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `imagen`, `nombres`, `apellidos`, `telefono`, `email`, `username`, `password`, `rol_id`, `estado`) VALUES
	(1, NULL, 'Gary', 'Cano', '42956492', 'gcanom88@gmail.com', 'gcano', 'b2ffdbeb87e8e6331d350b482b328d309bc5a321', 1, 1),
	(5, NULL, 'yony brondy', 'mamani fuentes', '45645342', 'yony@gmail.com', 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 1, 1),
	(6, NULL, 'julio', 'mendoza', '46464545', 'julio@admin.com', 'julio17', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', 2, 1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla compras_ventas.ventas
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `subtotal` varchar(45) DEFAULT NULL,
  `descuento` varchar(45) DEFAULT NULL,
  `total` varchar(45) DEFAULT NULL,
  `tipo_comprobante_id` int(11) DEFAULT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `num_documento` varchar(45) DEFAULT NULL,
  `monto_recibido` varchar(45) DEFAULT NULL,
  `cambio` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `iva` varchar(50) NOT NULL,
  `serie` varchar(50) NOT NULL,
  `igv` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario_venta_idx` (`usuario_id`),
  KEY `fk_cliente_venta_idx` (`cliente_id`),
  KEY `fk_tipo_comprobante_venta_idx` (`tipo_comprobante_id`),
  CONSTRAINT `fk_cliente_venta` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_comprobante_venta` FOREIGN KEY (`tipo_comprobante_id`) REFERENCES `tipo_comprobante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_venta` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1093 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla compras_ventas.ventas: ~4 rows (aproximadamente)
DELETE FROM `ventas`;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` (`id`, `fecha`, `subtotal`, `descuento`, `total`, `tipo_comprobante_id`, `cliente_id`, `usuario_id`, `num_documento`, `monto_recibido`, `cambio`, `estado`, `iva`, `serie`, `igv`) VALUES
	(1088, '2018-10-25', '18.00', '0.00', '18.00', 4, 95, 5, '00000005', NULL, NULL, 0, '0.00', '', ''),
	(1089, '2019-09-29', '12.50', '3', '11.75', 3, 95, 5, '00000003', NULL, NULL, 0, '2.25', '', ''),
	(1090, '2019-09-30', '9.00', '2', '7.00', 5, 95, 5, '00000005', NULL, NULL, 1, '0.00', '', ''),
	(1092, '2019-09-10', '2.50', '0.00', '2.95', 3, 95, 5, '00000004', NULL, NULL, 1, '0.45', '', '');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
