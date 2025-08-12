-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: vete
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CarritoApp_categ_producto`
--

DROP TABLE IF EXISTS `CarritoApp_categ_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_categ_producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_categ_producto`
--

LOCK TABLES `CarritoApp_categ_producto` WRITE;
/*!40000 ALTER TABLE `CarritoApp_categ_producto` DISABLE KEYS */;
INSERT INTO `CarritoApp_categ_producto` VALUES (3,'Alimentos'),(2,'Productos Varios'),(1,'Remedios');
/*!40000 ALTER TABLE `CarritoApp_categ_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_compra`
--

DROP TABLE IF EXISTS `CarritoApp_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_compra` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `factura_compra` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_compra` date NOT NULL,
  `producto_id` bigint NOT NULL,
  `provedor_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CarritoApp_compra_producto_id_7f9a6275_fk_CarritoApp_producto_id` (`producto_id`),
  KEY `CarritoApp_compra_provedor_id_de2aa932_fk_CarritoApp_provedor_id` (`provedor_id`),
  CONSTRAINT `CarritoApp_compra_producto_id_7f9a6275_fk_CarritoApp_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `CarritoApp_producto` (`id`),
  CONSTRAINT `CarritoApp_compra_provedor_id_de2aa932_fk_CarritoApp_provedor_id` FOREIGN KEY (`provedor_id`) REFERENCES `CarritoApp_provedor` (`id`),
  CONSTRAINT `CarritoApp_compra_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_compra`
--

LOCK TABLES `CarritoApp_compra` WRITE;
/*!40000 ALTER TABLE `CarritoApp_compra` DISABLE KEYS */;
INSERT INTO `CarritoApp_compra` VALUES (1,100,0.50,'0001-888-8522','2025-04-11',1,1),(2,100,0.50,'0001-8888-7414','2025-04-11',2,2),(3,100,0.50,'0001-7414-8881','2025-04-11',3,2),(4,100,0.50,'0001-8521-7444','2025-04-11',4,1),(5,100,0.50,'0001-8541-8555','2025-04-11',5,1),(6,100,0.50,'0001-8524-8410','2025-04-11',6,1),(7,100,0.50,'1000-8528-7418','2025-04-11',7,3),(8,100,0.50,'1000-8521-8741','2025-04-11',8,3),(9,1000,0.50,'0007-9521-8541','2025-04-11',9,3);
/*!40000 ALTER TABLE `CarritoApp_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_cuentacorriente`
--

DROP TABLE IF EXISTS `CarritoApp_cuentacorriente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_cuentacorriente` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_cuota` date NOT NULL,
  `total_con_interes` decimal(10,2) NOT NULL,
  `cuota_total` int NOT NULL,
  `cuota_paga` int NOT NULL,
  `cuota_debe` int NOT NULL,
  `cuota_suma` int NOT NULL,
  `imp_mensual` decimal(10,2) NOT NULL,
  `imp_cuota_pagadas` decimal(10,2) NOT NULL,
  `entrega_cta` decimal(10,2) NOT NULL,
  `metodo_pago_id` bigint DEFAULT NULL,
  `tarjeta_nombre` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarjeta_numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `factura_id` int NOT NULL,
  `interes_aplicado` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CarritoApp_cuentacor_factura_id_6fc6af68_fk_CarritoAp` (`factura_id`),
  KEY `CarritoApp_cuentacorriente_metodo_pago_id_bb21fa33` (`metodo_pago_id`),
  CONSTRAINT `CarritoApp_cuentacor_factura_id_6fc6af68_fk_CarritoAp` FOREIGN KEY (`factura_id`) REFERENCES `CarritoApp_factura` (`id`),
  CONSTRAINT `CarritoApp_cuentacor_metodo_pago_id_bb21fa33_fk_CarritoAp` FOREIGN KEY (`metodo_pago_id`) REFERENCES `CarritoApp_metodopago` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_cuentacorriente`
--

LOCK TABLES `CarritoApp_cuentacorriente` WRITE;
/*!40000 ALTER TABLE `CarritoApp_cuentacorriente` DISABLE KEYS */;
/*!40000 ALTER TABLE `CarritoApp_cuentacorriente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_factura`
--

DROP TABLE IF EXISTS `CarritoApp_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_factura` (
  `uuid` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `nombre_cliente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido_cliente` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domicilio` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iva` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metodo_pago` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `detalle_productos` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagen_factura` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dni_cliente` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendedor` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descuento` decimal(5,2) NOT NULL,
  `total_descuento` decimal(10,2) NOT NULL,
  `estado_credito` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interes` decimal(5,2) NOT NULL,
  `total_con_interes` decimal(10,2) NOT NULL,
  `cuotas` int NOT NULL,
  `cuota_mensual` decimal(10,2) NOT NULL,
  `tarjeta_nombre` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarjeta_numero` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_factura`
--

LOCK TABLES `CarritoApp_factura` WRITE;
/*!40000 ALTER TABLE `CarritoApp_factura` DISABLE KEYS */;
INSERT INTO `CarritoApp_factura` VALUES ('b469ff214adb472393996f7f48c1e0dd',15,'00015','2025-04-15','Luisa','Morely',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Sarna\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20111111','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('ef158e3e659446a596bca6bb6476af09',16,'00016','2025-04-15','Gustavo','Lopez',NULL,NULL,'Efectivo',2.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 2, \"precio_unitario\": 1.0, \"subtotal\": 2.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,2.00,0,0.00,NULL,NULL),('86b743196a7a4c288f0fab9e9c729ff5',17,'00017','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('ad2c66c3bfb14981b96690970dc1cf9e',18,'00018','2025-04-15','Gustavo','Lopez',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('207a5d07bc5a47bbb52a115b84daa771',19,'00019','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('b180b7e68ceb4a5488a078a808680a4d',20,'00020','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('37b8b602b90746c083d9efad85a5f9f5',21,'00021','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('2fb0cc6b74bf49c9bf011b4347c51697',22,'00022','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('30117b843c794756a95a8733472c246f',23,'00023','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('130c1279f8f24a7ca522893de2a7de69',24,'00024','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('11d9fecd3f7a455d84499315345f653e',25,'00025','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('93e7949dda0d467085b3283319323a88',26,'00026','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('11d0f5e7a2eb41749b0736a064b236f9',27,'00027','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('3216403b1daa4ef3af51dd36c0229b79',28,'00028','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('c5411a10260c4572931c4fc35f225df7',29,'00029','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',0.00,'[]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,0.00,0,0.00,NULL,NULL),('0cc15c6471224c3bbc111978f2eb43a2',30,'00030','2025-04-15','Gustavo','Lopez',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('6f7084a6e13343ae99f7a1a86b3f8010',31,'00031','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('20d0fd19bba9453ab9ad3f5add8ebcc7',32,'00032','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('d4dd7b7becb64f0aa8d816a1e0eee8ee',33,'00033','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('d155a3992bde48e8b6e3404779922693',34,'00034','2025-04-15','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('ba5c48cb6a22420d88eca4acfc3f7106',35,'00035','2025-04-15','Gustavo','Lopez',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('49a34a20ac99418ca1f01a71238cf1f8',36,'00036','2025-04-15','Gustavo','Lopez',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('9ca660c7204f4df0bdb5550dfd8056d6',37,'','2025-04-16','Test','Factura',NULL,NULL,'Mercado Pago',100.00,'[{\"nombre_producto\": \"Test\", \"cantidad_vendida\": 1, \"precio_unitario\": 100.0, \"subtotal\": 100.0}]','','12345678','Shell',0.00,0.00,'Cuenta Corriente',0.00,100.00,0,0.00,NULL,NULL),('24706c44b0b64e8eb4c9a7e5a2964301',38,'00038','2025-04-16','Gustavo','Lopez',NULL,NULL,'Mercado Pago',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('873c151c9e464deba6188ab6aaf59701',39,'00039','2025-04-16','Gustavo','Lopez',NULL,NULL,'Efectivo',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('05a69570408e415696b347825216cb57',40,'00040','2025-04-16','Gustavo','Lopez',NULL,NULL,'No especificado',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL),('42eb0242e97e476e8aa636439604b893',41,'00041','2025-04-16','Gustavo','Lopez',NULL,NULL,'MERCADO PAGO',1.00,'[{\"nombre_producto\": \"Pulga\", \"cantidad_vendida\": 1, \"precio_unitario\": 1.0, \"subtotal\": 1.0}]','','20222222','Carrito Web',0.00,0.00,'Cuenta Corriente',0.00,1.00,0,0.00,NULL,NULL);
/*!40000 ALTER TABLE `CarritoApp_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_facturaproducto`
--

DROP TABLE IF EXISTS `CarritoApp_facturaproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_facturaproducto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `factura_id` int NOT NULL,
  `producto_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CarritoApp_facturapr_factura_id_f31adaa8_fk_CarritoAp` (`factura_id`),
  KEY `CarritoApp_facturapr_producto_id_9468bca9_fk_CarritoAp` (`producto_id`),
  CONSTRAINT `CarritoApp_facturapr_factura_id_f31adaa8_fk_CarritoAp` FOREIGN KEY (`factura_id`) REFERENCES `CarritoApp_factura` (`id`),
  CONSTRAINT `CarritoApp_facturapr_producto_id_9468bca9_fk_CarritoAp` FOREIGN KEY (`producto_id`) REFERENCES `CarritoApp_producto` (`id`),
  CONSTRAINT `CarritoApp_facturaproducto_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_facturaproducto`
--

LOCK TABLES `CarritoApp_facturaproducto` WRITE;
/*!40000 ALTER TABLE `CarritoApp_facturaproducto` DISABLE KEYS */;
/*!40000 ALTER TABLE `CarritoApp_facturaproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_metodopago`
--

DROP TABLE IF EXISTS `CarritoApp_metodopago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_metodopago` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tarjeta_nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `CarritoApp_metodopago_tarjeta_nombre_9ecf38e2_uniq` (`tarjeta_nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_metodopago`
--

LOCK TABLES `CarritoApp_metodopago` WRITE;
/*!40000 ALTER TABLE `CarritoApp_metodopago` DISABLE KEYS */;
INSERT INTO `CarritoApp_metodopago` VALUES (6,'Cheques'),(4,'Mercado Pago - MP'),(3,'Tarjeta Debito NBCH'),(1,'Tarjeta Tuya'),(2,'Tarjeta Visa'),(5,'Unicobro');
/*!40000 ALTER TABLE `CarritoApp_metodopago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_producto`
--

DROP TABLE IF EXISTS `CarritoApp_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_producto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_producto` int unsigned DEFAULT NULL,
  `nombre_producto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `imagen` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int unsigned NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoria_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_producto` (`numero_producto`),
  KEY `CarritoApp_producto_categoria_id_9f878cff_fk_CarritoAp` (`categoria_id`),
  CONSTRAINT `CarritoApp_producto_categoria_id_9f878cff_fk_CarritoAp` FOREIGN KEY (`categoria_id`) REFERENCES `CarritoApp_categ_producto` (`id`),
  CONSTRAINT `CarritoApp_producto_chk_1` CHECK ((`numero_producto` >= 0)),
  CONSTRAINT `CarritoApp_producto_chk_2` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_producto`
--

LOCK TABLES `CarritoApp_producto` WRITE;
/*!40000 ALTER TABLE `CarritoApp_producto` DISABLE KEYS */;
INSERT INTO `CarritoApp_producto` VALUES (1,10001,'Pulga','Para Pulgas','productos/Pulga4.jpg',78,1.00,'productos/Pulga1.jpg','','productos/Pulga3_P2yki9u.webp','',1),(2,10002,'Garrapata H1','Excelente... muy bueno','productos/Garrapata2_Kogam08.jfif',98,1.00,'productos/Garrapata4.jpg','','productos/Garrapata1_NfQkUir.jfif','',1),(3,10003,'Sarna','Excelente cuida al Animal','productos/sarna1_8G17Ble.jfif',90,1.00,'productos/sarna2_iQi9bZM.jfif','','productos/sarna3_vuATSCh.jfif','',1),(4,10004,'Perros','Dog-Chow','productos/Catchao2_w5xUvIr.jfif',100,1.00,'productos/Catchao4_yJksOax.jfif','','','',3),(5,10005,'Gatos','Cat-Chow','productos/Catchao1_Pb4PtN6.jfif',100,1.00,'productos/Catchao3_mf4gNPK.jfif','','','',3),(6,10006,'Perro','Pedigre','productos/Pedigre1_sXD59pp.jfif',100,1.00,'productos/Pedigre3_NtYKoKA.jfif','','','',1),(7,10007,'Collar','Collar Varios','productos/collar1_jBIuXvO.jfif',100,1.00,'productos/collar3_ugOLtnC.jfif','','productos/collar2_BGtGq53.jfif','',2),(8,10008,'Cucha','Cucha Casa','productos/cucha1_9ory4Ue.jfif',100,1.00,'productos/cucha4_u7yLoXK.jfif','','productos/cucha5_vomKICT.jpeg','',2),(9,10009,'Cucha Jaula','Excelente para viajes','productos/Cucha_Jaula3_9lm9FSZ.jfif',998,1.00,'productos/Cucha_Jaula1_JaFKZ3d.jfif','','productos/Cucha_Jaula2_LRt8yCt.jfif','',2),(10,10010,'Cucha Cama','muy Bueno para interiores','productos/Cucha_Cama2_jcnAAue.jfif',0,1.00,'productos/Cucha_Cama3_nr5syRo.jfif','','productos/Cucha_Cama_h1FHjJF.jfif','',2);
/*!40000 ALTER TABLE `CarritoApp_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_provedor`
--

DROP TABLE IF EXISTS `CarritoApp_provedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_provedor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` longtext COLLATE utf8mb4_unicode_ci,
  `telefono` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_provedor`
--

LOCK TABLES `CarritoApp_provedor` WRITE;
/*!40000 ALTER TABLE `CarritoApp_provedor` DISABLE KEYS */;
INSERT INTO `CarritoApp_provedor` VALUES (1,'Morresi','Barranquera - linier 789','3624-852841','Morresi@gmail.com'),(2,'Laboratorio SA','Bs As - Corrientes 7847','11-74128521','LaboratorioSA@gmail.com'),(3,'Juguete Animal','San Luis','11-85248569','Juguete@gmail.com');
/*!40000 ALTER TABLE `CarritoApp_provedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarritoApp_venta`
--

DROP TABLE IF EXISTS `CarritoApp_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarritoApp_venta` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `producto_id` bigint NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `CarritoApp_venta_producto_id_63d1e5ef_fk_CarritoApp_producto_id` (`producto_id`),
  KEY `CarritoApp_venta_usuario_id_dca1adaf_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `CarritoApp_venta_producto_id_63d1e5ef_fk_CarritoApp_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `CarritoApp_producto` (`id`),
  CONSTRAINT `CarritoApp_venta_usuario_id_dca1adaf_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarritoApp_venta`
--

LOCK TABLES `CarritoApp_venta` WRITE;
/*!40000 ALTER TABLE `CarritoApp_venta` DISABLE KEYS */;
/*!40000 ALTER TABLE `CarritoApp_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Opinión',7,'add_opinion'),(26,'Can change Opinión',7,'change_opinion'),(27,'Can delete Opinión',7,'delete_opinion'),(28,'Can view Opinión',7,'view_opinion'),(29,'Can add categ_producto',8,'add_categ_producto'),(30,'Can change categ_producto',8,'change_categ_producto'),(31,'Can delete categ_producto',8,'delete_categ_producto'),(32,'Can view categ_producto',8,'view_categ_producto'),(33,'Can add factura',9,'add_factura'),(34,'Can change factura',9,'change_factura'),(35,'Can delete factura',9,'delete_factura'),(36,'Can view factura',9,'view_factura'),(37,'Can add metodo pago',10,'add_metodopago'),(38,'Can change metodo pago',10,'change_metodopago'),(39,'Can delete metodo pago',10,'delete_metodopago'),(40,'Can view metodo pago',10,'view_metodopago'),(41,'Can add provedor',11,'add_provedor'),(42,'Can change provedor',11,'change_provedor'),(43,'Can delete provedor',11,'delete_provedor'),(44,'Can view provedor',11,'view_provedor'),(45,'Can add cuenta corriente',12,'add_cuentacorriente'),(46,'Can change cuenta corriente',12,'change_cuentacorriente'),(47,'Can delete cuenta corriente',12,'delete_cuentacorriente'),(48,'Can view cuenta corriente',12,'view_cuentacorriente'),(49,'Can add producto',13,'add_producto'),(50,'Can change producto',13,'change_producto'),(51,'Can delete producto',13,'delete_producto'),(52,'Can view producto',13,'view_producto'),(53,'Can add factura producto',14,'add_facturaproducto'),(54,'Can change factura producto',14,'change_facturaproducto'),(55,'Can delete factura producto',14,'delete_facturaproducto'),(56,'Can view factura producto',14,'view_facturaproducto'),(57,'Can add compra',15,'add_compra'),(58,'Can change compra',15,'change_compra'),(59,'Can delete compra',15,'delete_compra'),(60,'Can view compra',15,'view_compra'),(61,'Can add venta',16,'add_venta'),(62,'Can change venta',16,'change_venta'),(63,'Can delete venta',16,'delete_venta'),(64,'Can view venta',16,'view_venta'),(65,'Can add mascota',17,'add_mascota'),(66,'Can change mascota',17,'change_mascota'),(67,'Can delete mascota',17,'delete_mascota'),(68,'Can view mascota',17,'view_mascota'),(69,'Can add informe',18,'add_informe'),(70,'Can change informe',18,'change_informe'),(71,'Can delete informe',18,'delete_informe'),(72,'Can view informe',18,'view_informe'),(73,'Can add contacto',19,'add_contacto'),(74,'Can change contacto',19,'change_contacto'),(75,'Can delete contacto',19,'delete_contacto'),(76,'Can view contacto',19,'view_contacto');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `dni_usuario` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `domicilio_usuario` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tel1_usuario` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tel2_usuario` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cuil` varchar(13) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen_usuario` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iva` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$4omLFMrnEGcKDtHeCckzdp$UIZgDvJXZokN9+9UD3tijXy17eItwBeVeDaZoC/UgqU=','2025-04-15 13:28:31.466386',1,'Emy','Luisa','Morely','neagestion@gmail.com',1,1,'2025-04-11 14:39:12.000000','20111111','Alberdi 134','3644-741852','3644-852417','20201111118','usuarios/Emy_0TzfQMu.jpg','RI'),(2,'pbkdf2_sha256$870000$mZBkyQgoX6Z4LNvdbHLevf$CddRujgc0H+Y1/79Nb7ZN79VZJZ/qjyXcloppIULt0c=','2025-04-16 19:37:29.532333',0,'Gustavo','Gustavo','Lopez','gustavo@gmail.com',0,1,'2025-04-11 18:21:21.000000','20222222','moreno 785','3644-528524','3644-852965','20202222228','usuarios/images.jfif','M'),(3,'pbkdf2_sha256$870000$UHGx6LPyJRQewgv8PZRjBs$atP1oeplQPmT3e+DHJKuYAhvJ2XH2AK08lImw8OWyEE=','2025-04-15 13:09:17.802876',0,'German','German','Morales','german@gmail.com',0,1,'2025-04-11 18:23:27.000000','20333333','Rivadavia 789','3644-985871','3644-852541','20203333339','usuarios/Android_Studio.png','CF');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-04-15 12:22:08.309882','1','Emy',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(2,'2025-04-15 12:22:33.749092','3','German',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(3,'2025-04-15 12:22:48.776759','2','Gustavo',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(4,'2025-04-15 13:04:57.108976','14','Factura 00014 - Luisa Morely',3,'',9,1),(5,'2025-04-15 13:04:57.109080','13','Factura 00013 - Luisa Morely',3,'',9,1),(6,'2025-04-15 13:04:57.109114','12','Factura 00012 - Luisa Morely',3,'',9,1),(7,'2025-04-15 13:04:57.109143','11','Factura 00011 - Luisa Morely',3,'',9,1),(8,'2025-04-15 13:04:57.109171','10','Factura 00010 - Luisa Morely',3,'',9,1),(9,'2025-04-15 13:04:57.109197','9','Factura 00009 - Luisa Morely',3,'',9,1),(10,'2025-04-15 13:04:57.109222','8','Factura 00008 - Luisa Morely',3,'',9,1),(11,'2025-04-15 13:04:57.109247','7','Factura 00007 - Gustavo Lopez',3,'',9,1),(12,'2025-04-15 13:04:57.109271','6','Factura 00006 - Luisa Morely',3,'',9,1),(13,'2025-04-15 13:04:57.109295','5','Factura 00005 - Gustavo Lopez',3,'',9,1),(14,'2025-04-15 13:04:57.109319','4','Factura  - Luisa Morely',3,'',9,1),(15,'2025-04-15 13:04:57.109344','3','Factura 00003 - Luisa Morely',3,'',9,1),(16,'2025-04-15 13:04:57.109368','2','Factura 00002 - Luisa Morely',3,'',9,1),(17,'2025-04-15 13:04:57.109393','1','Factura 00001 - Luisa Morely',3,'',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(8,'CarritoApp','categ_producto'),(15,'CarritoApp','compra'),(12,'CarritoApp','cuentacorriente'),(9,'CarritoApp','factura'),(14,'CarritoApp','facturaproducto'),(10,'CarritoApp','metodopago'),(13,'CarritoApp','producto'),(11,'CarritoApp','provedor'),(16,'CarritoApp','venta'),(5,'contenttypes','contenttype'),(18,'mascota','informe'),(17,'mascota','mascota'),(7,'opiniones','opinion'),(19,'prueba1','contacto'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-11 14:28:14.035878'),(2,'auth','0001_initial','2025-04-11 14:28:14.811082'),(3,'CarritoApp','0001_initial','2025-04-11 14:28:15.761145'),(4,'CarritoApp','0002_remove_cuentacorriente_estado_credito','2025-04-11 14:28:15.831859'),(5,'CarritoApp','0003_remove_metodopago_nombre_metodopago_tarjeta_nombre_and_more','2025-04-11 14:28:16.272020'),(6,'CarritoApp','0004_alter_metodopago_tarjeta_nombre','2025-04-11 14:28:16.306293'),(7,'CarritoApp','0005_remove_metodopago_tarjeta_numero','2025-04-11 14:28:16.367789'),(8,'CarritoApp','0006_cuentacorriente_interes_aplicado','2025-04-11 14:28:16.474794'),(9,'admin','0001_initial','2025-04-11 14:28:16.707281'),(10,'admin','0002_logentry_remove_auto_add','2025-04-11 14:28:16.722938'),(11,'admin','0003_logentry_add_action_flag_choices','2025-04-11 14:28:16.736541'),(12,'contenttypes','0002_remove_content_type_name','2025-04-11 14:28:16.888107'),(13,'auth','0002_alter_permission_name_max_length','2025-04-11 14:28:16.987490'),(14,'auth','0003_alter_user_email_max_length','2025-04-11 14:28:17.024445'),(15,'auth','0004_alter_user_username_opts','2025-04-11 14:28:17.039691'),(16,'auth','0005_alter_user_last_login_null','2025-04-11 14:28:17.122713'),(17,'auth','0006_require_contenttypes_0002','2025-04-11 14:28:17.128713'),(18,'auth','0007_alter_validators_add_error_messages','2025-04-11 14:28:17.144258'),(19,'auth','0008_alter_user_username_max_length','2025-04-11 14:28:17.266730'),(20,'auth','0009_alter_user_last_name_max_length','2025-04-11 14:28:17.368531'),(21,'auth','0010_alter_group_name_max_length','2025-04-11 14:28:17.415854'),(22,'auth','0011_update_proxy_permissions','2025-04-11 14:28:17.442202'),(23,'auth','0012_alter_user_first_name_max_length','2025-04-11 14:28:17.541289'),(24,'mascota','0001_initial','2025-04-11 14:28:17.571512'),(25,'mascota','0002_rename_tipo_mascota_especie_mascota_descripcion_and_more','2025-04-11 14:28:17.678669'),(26,'mascota','0003_mascota_usuario_alter_mascota_descripcion','2025-04-11 14:28:17.772096'),(27,'mascota','0004_mascota_imagen1_mascota_imagen2_mascota_imagen3_and_more','2025-04-11 14:28:17.967167'),(28,'mascota','0005_mascota_imagen5','2025-04-11 14:28:18.034437'),(29,'mascota','0006_informe','2025-04-11 14:28:18.249801'),(30,'mascota','0007_remove_informe_foto_imagen_remove_informe_mascota','2025-04-11 14:28:18.403241'),(31,'mascota','0008_informe_foto_imagen_informe_mascota','2025-04-11 14:28:18.562886'),(32,'mascota','0009_alter_informe_mascota','2025-04-11 14:28:18.584889'),(33,'mascota','0010_mascota_dni_usuario','2025-04-11 14:28:18.657495'),(34,'opiniones','0001_initial','2025-04-11 14:28:18.941101'),(35,'patch_user','0001_add_user_fields','2025-04-11 14:28:19.522761'),(36,'prueba1','0001_initial','2025-04-11 14:28:19.560867'),(37,'sessions','0001_initial','2025-04-11 14:28:19.627652'),(38,'CarritoApp','0007_alter_factura_metodo_pago','2025-04-16 21:19:16.211153'),(40,'auth','0013_user_cuil_user_dni_usuario_user_domicilio_usuario_and_more','2025-04-16 22:25:53.893754');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3ufm10giahw487injo6yrwpfiem0om0s','.eJxVjDsOgzAQBe_iOrLiH-xSpucMaNk1gSTCkg0V4u4BiSJp38ybTXW0LmO3lpi7SVSjrLr9bj3xO84nkBfNz6Q5zUueen0q-qJFt0ni53G5f4GRyni8vZA36B3cOZpg2QiDcQiejAgOUFU1EFYuxF5M7ZgGIghBAL21gHhEmXKelqSabd-_vqE79Q:1u5A23:1zyAto9xVoEqgbWMiZ_utSs3LvqwcVcPRpH4_HTBTeM','2025-04-30 21:10:55.377865'),('9myus3pfmpctpq382sc5kpo0jlsgy60s','.eJxVjjEOwjAMRe-SuYpwm7YJIzsSN6hcO9BASVCaTKh3JwUGWDz4vf_tpxgwp2nIi42DY7EXtah-dyPSzfoN8BX9JUgKPkU3yk2RX7rIY2A7H77uX8GEy1TSilGBUY3ekYW2JmDS0BitEJjNWXddr9F0TWtHhr4hPCPqtmVtVF1rY0opYYwuBbF_CtjGIwbOlML7b6iED_cx2nLrlOcLlsAjWnLFB7nb0j45xo-KlO95Rv7AdV1fXshVEw:1u4T04:8K_rY6YgfHxYiy2DDxER4BJpDObHAUibD4AyIqR3Nj4','2025-04-28 23:14:00.002707'),('fxd49rwtexvr63ft7vu82hnlwayp2p0j','.eJxVjDsOwjAQBe_iGllrO-sPJX3OEO16DQ6gWMqnQtwdIqWA9s3Me6mBtrUO21LmYRR1Vkadfjem_CjTDuRO063p3KZ1Hlnvij7oovsm5Xk53L-DSkv91pAMA1EKHZBLlEzyyABeDEYbhE3HkT1SKO6KFiSbbAWhALoOOQb1_gC__Tb6:1u4pf4:s2yZ-6bZ3fYelhgMEHXPyTBWNDeAN1iHLfWB49aGjE8','2025-04-29 23:25:50.174762'),('oea0i041tsrvocidcfyqijj4oqrtnzlq','.eJxVjDsOwjAQBe_iGllrO-sPJX3OEO16DQ6gWMqnQtwdIqWA9s3Me6mBtrUO21LmYRR1Vkadfjem_CjTDuRO063p3KZ1Hlnvij7oovsm5Xk53L-DSkv91pAMA1EKHZBLlEzyyABeDEYbhE3HkT1SKO6KFiSbbAWhALoOOQb1_gC__Tb6:1u4fGg:KRKZr1TKJjEuU4O_L4AGDJtCTrAkoQdRr8T9z5Xrjho','2025-04-29 12:19:58.684071'),('uwx1daqvjxfzxx3tc5lr6i6asy6w53wd','.eJxVjrFywyAMht-F2ccJY2yTsXunPoBPQqSmTSCHYcr53YPTDM2iQd_3_9JdLFjLutTN5yWwOAkluv87Qvfr4wH4B-N3ki7FkgPJQ5EvusnPxP7y8XLfClbc1pYGqwgQ7TQAaotW2dEQwMjKzP3EpAaaaTQ4eX02PbBTrmcDHoweDM1TK3WYcyhJnO5CH-OWE1dX0vNv3YmYrpR9u_WFOWIL3LJ3oflKwpGOJTA2VXUCXb3WC_If3Pf9ASfTVK4:1u4Qx1:m-AF_AMrcyLj6Gf1wJVLdh1hnKeV7GzGlG2JyZh7zdE','2025-04-28 21:02:43.105734'),('vr8bs8od6nauaeh23u9ciqmixgn1dgee','.eJxVUMtuwyAQ_BfOlhX8SCDHXnpppd6rCq1ZnNASsHjkUMv_Xkic1uWAVrMzs7M7EwEpnkUKyguN5EgaUm2xAeSXsqWBn2BPrpbORq-HulDqtRvqV4fKPK3cfwZnCOes7hA6yruW7aSifSMpSkZbzjqgiHxk-_2BAd-3vRqQHloJIwDre2S8axrGeTaV4L2OjhxnQss3eYdJRnfLTSti3WXwKs96S-YEWTB5JXXm03pX1DZqhDsVZLokA3hvLktFRpAxeRAI0YXijlaXa-ya2yMb--cUIlxdhmBSxujiQl7cpL4zFF0Es45ElWuTJe_zqhaPzJuUj2Dimm-Xi1vAe3SRrI7gf3cIafjzXz6W5QdOwJFU:1u59r4:AvHX99xKcZULmrKx0XnswFwqFcusjG6rWuWEnQw_aY0','2025-04-30 20:59:34.603342'),('wrdi7imalcxopl8fvf9tmsdh1titqzay','.eJxVjDsOgzAQBe_iOrLiH-xSpucMaNk1gSTCkg0V4u4BiSJp38ybTXW0LmO3lpi7SVSjrLr9bj3xO84nkBfNz6Q5zUueen0q-qJFt0ni53G5f4GRyni8vZA36B3cOZpg2QiDcQiejAgOUFU1EFYuxF5M7ZgGIghBAL21gHhEmXKelqSabd-_vqE79Q:1u555s:VHOVYudB62hbIXXG6noY9aIp8dcC0AdPPj93aNXdhgU','2025-04-30 15:54:32.419712'),('z19kryp3v6ol9gbhfmycfg6j7l2x5uti','.eJxVjjEOwjAMRe-SuYpwm7YJIzsSN6hcO9BASVCaTKh3JwUGWDz4vf_tpxgwp2nIi42DY7EXtah-dyPSzfoN8BX9JUgKPkU3yk2RX7rIY2A7H77uX8GEy1TSilGBUY3ekYW2JmDS0BitEJjNWXddr9F0TWtHhr4hPCPqtmVtVF1rY0opYYwuBbF_CtjGIwbOlML7b6iED_cx2nLrlOcLlsAjWnLFB7nb0j45xo-KlO95Rv7AdV1fXshVEw:1u4S2n:dCSYRczmV9hDdbaDUkzpthhsvirZKN_wIMtsxb4YssA','2025-04-28 22:12:45.383414');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota_informe`
--

DROP TABLE IF EXISTS `mascota_informe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota_informe` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha` datetime(6) NOT NULL,
  `informe` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  `foto_imagen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mascota_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mascota_informe_usuario_id_0d3a9c01_fk_auth_user_id` (`usuario_id`),
  KEY `mascota_informe_mascota_id_5cd8d4f2_fk_mascota_mascota_id` (`mascota_id`),
  CONSTRAINT `mascota_informe_mascota_id_5cd8d4f2_fk_mascota_mascota_id` FOREIGN KEY (`mascota_id`) REFERENCES `mascota_mascota` (`id`),
  CONSTRAINT `mascota_informe_usuario_id_0d3a9c01_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota_informe`
--

LOCK TABLES `mascota_informe` WRITE;
/*!40000 ALTER TABLE `mascota_informe` DISABLE KEYS */;
/*!40000 ALTER TABLE `mascota_informe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota_mascota`
--

DROP TABLE IF EXISTS `mascota_mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota_mascota` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `edad` int NOT NULL,
  `especie` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT (_utf8mb3'Sin descripción'),
  `imagen` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usuario_id` int DEFAULT NULL,
  `imagen1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `imagen5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dni_usuario` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mascota_mascota_usuario_id_3cae744e_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `mascota_mascota_usuario_id_3cae744e_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota_mascota`
--

LOCK TABLES `mascota_mascota` WRITE;
/*!40000 ALTER TABLE `mascota_mascota` DISABLE KEYS */;
INSERT INTO `mascota_mascota` VALUES (1,'Tito',8,'Perro','Toy Mediano Blanco','mascotas/jachi_1QsLf49.jpg',2,'mascotas/jachi1_3UvST4F.jpg','mascotas/jachi3_yq0oPeT.jpg','','','','20222222'),(2,'Minino',7,'Gato','Es un Angora','mascotas/bolita_EDcPoCk.jpg',2,'mascotas/bolita1_7iax8wc.jpg','mascotas/bolita3_otNpiji.jpg','','','','20222222'),(3,'Moly',3,'Perro','Es Micro Toy','mascotas/Cachita3_cR7uggj.jpg',2,'mascotas/Cachita4_eckVruD.jpg','mascotas/Cachita_SmQwGST.jpg','','','','20222222'),(4,'Pichicho',9,'Perro','Es negro comun--- castrado ---','mascotas/negro_Zu3dnA6.jpg',2,'mascotas/negro1_qB5hWFd.jpg','','','','','20222222'),(5,'Michi',10,'Gato','Esta castrado... y es una gorda','mascotas/mini_0g02BcX.jpg',3,'mascotas/mini1_ydPoxOf.jpg','mascotas/mini3_XyfBgbY.jpg','','','','20333333');
/*!40000 ALTER TABLE `mascota_mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opiniones_opinion`
--

DROP TABLE IF EXISTS `opiniones_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opiniones_opinion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `texto` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `administrador_id` int DEFAULT NULL,
  `producto_id` bigint NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `opiniones_opinion_administrador_id_afc9688c_fk_auth_user_id` (`administrador_id`),
  KEY `opiniones_opinion_producto_id_cb16a849_fk_CarritoApp_producto_id` (`producto_id`),
  KEY `opiniones_opinion_usuario_id_6c8a7eea_fk_auth_user_id` (`usuario_id`),
  CONSTRAINT `opiniones_opinion_administrador_id_afc9688c_fk_auth_user_id` FOREIGN KEY (`administrador_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `opiniones_opinion_producto_id_cb16a849_fk_CarritoApp_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `CarritoApp_producto` (`id`),
  CONSTRAINT `opiniones_opinion_usuario_id_6c8a7eea_fk_auth_user_id` FOREIGN KEY (`usuario_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opiniones_opinion`
--

LOCK TABLES `opiniones_opinion` WRITE;
/*!40000 ALTER TABLE `opiniones_opinion` DISABLE KEYS */;
/*!40000 ALTER TABLE `opiniones_opinion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prueba1_contacto`
--

DROP TABLE IF EXISTS `prueba1_contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prueba1_contacto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consulta` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prueba1_contacto`
--

LOCK TABLES `prueba1_contacto` WRITE;
/*!40000 ALTER TABLE `prueba1_contacto` DISABLE KEYS */;
/*!40000 ALTER TABLE `prueba1_contacto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-15 11:52:25
