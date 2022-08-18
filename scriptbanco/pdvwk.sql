-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: wkpdv
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tab_clientes`
--

DROP TABLE IF EXISTS `tab_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_clientes` (
  `cli_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cli_nome` varchar(80) DEFAULT NULL,
  `cli_cidade` varchar(80) DEFAULT NULL,
  `cli_uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cli_codigo`),
  KEY `idx_cli_nome` (`cli_nome`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_clientes`
--

LOCK TABLES `tab_clientes` WRITE;
/*!40000 ALTER TABLE `tab_clientes` DISABLE KEYS */;
INSERT INTO `tab_clientes` VALUES (1,'ANTONIO JARDIM','BELÉM','PA'),(2,'CAMILA SALGADO','BELÉM','PA'),(3,'MARCELINO NETO','MELGAÇO','PA'),(4,'THAMIRES BRAGA','MACAPÁ','AP'),(5,'THALIA BRAGA','MACAPÁ','AP'),(6,'THIENE BRAGA','MACAPÁ','AP'),(7,'PAULO GABRIEL','BELÉM','PA'),(8,'LUCAS DANIEL','BELEM','PA'),(9,'ALBERTO PRIMO','BELEM','PA'),(10,'FRANCISCA PRIMO','BELEM','PA'),(11,'ARTHUR PRIMO','BELEM','PA'),(12,'ARMANDO PRIMO','BELEM','PA'),(13,'ADRIANA PRIMO','BELEM','PA'),(14,'LUCAS DANIEL','BELEM','PA'),(15,'WHELLER PIMENTEL','BELEM','PA'),(16,'LUCIANO BAMBRILA','BELEM','PA'),(17,'LUCAS DANIEL','BELEM','PA'),(18,'JOÃO FALCÃO','BELEM','PA'),(19,'MARCELA TATIANE','MACAPÁ','AP'),(20,'FRANK CAPISTRANO','BELEM','PA');
/*!40000 ALTER TABLE `tab_clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_pedidos`
--

DROP TABLE IF EXISTS `tab_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_pedidos` (
  `ped_codigo` int(11) DEFAULT NULL,
  `ped_dtemissao` date DEFAULT curdate(),
  `ped_cliente` int(11) DEFAULT NULL,
  `ped_total` decimal(12,2) DEFAULT 0.00,
  KEY `tab_pedidos_ped_dtemissao_IDX` (`ped_dtemissao`) USING BTREE,
  KEY `tab_pedidos_ped_cliente_IDX` (`ped_cliente`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_pedidos`
--

LOCK TABLES `tab_pedidos` WRITE;
/*!40000 ALTER TABLE `tab_pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tab_pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_pedidos_itens`
--

DROP TABLE IF EXISTS `tab_pedidos_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_pedidos_itens` (
  `pdi_codigo` int(11) DEFAULT NULL,
  `pdi_pedido` int(11) DEFAULT NULL,
  `pdi_produto` int(11) DEFAULT NULL,
  `pdi_quantidade` decimal(12,2) DEFAULT NULL,
  `pdi_unitario` decimal(12,2) DEFAULT NULL,
  `pdi_total` decimal(12,2) DEFAULT NULL,
  KEY `tab_pedidos_itens_pdi_pedido_IDX` (`pdi_pedido`) USING BTREE,
  KEY `tab_pedidos_itens_pdi_produto_IDX` (`pdi_produto`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_pedidos_itens`
--

LOCK TABLES `tab_pedidos_itens` WRITE;
/*!40000 ALTER TABLE `tab_pedidos_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tab_pedidos_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tab_produtos`
--

DROP TABLE IF EXISTS `tab_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_produtos` (
  `pro_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `pro_descricao` varchar(80) DEFAULT NULL,
  `pro_precovenda` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`pro_codigo`),
  KEY `idx_pro_descricao` (`pro_descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_produtos`
--

LOCK TABLES `tab_produtos` WRITE;
/*!40000 ALTER TABLE `tab_produtos` DISABLE KEYS */;
INSERT INTO `tab_produtos` VALUES (1,'FEIJÃO CARIOQUINHA AMADOR',7.650),(2,'ARROZ BABILONIA',5.550),(3,'CHOCOLATE GATORO',13.900),(4,'ADESIVO TIGRE PFV',11.150),(5,'ARO DE ALUMÍNIO COM 8 ROL',32.550),(6,'LIXA MASSA 120',11.550),(7,'TE 3X4 TIGRE',1.250),(8,'TUBO 3X4 TIGRE',17.510),(9,'ARROZ CARIOQUINHA',4.550),(10,'ACUCAR SAO JORGE',3.910),(11,'SAL MOJAVE',3.130),(12,'ACHOCOLADADO TODDY 200G',7.200),(13,'LEITE ELEGE 200G',7.550),(14,'LEITE ITEMBÉ 200G',8.120),(15,'QUEIJO PERDIGÃO',10.500),(16,'TOALHA DE MESA G',25.500),(17,'JOGO DE PANELAS TRAMONTINA',65.500),(18,'JOGO DE CHÁ MIRELLA',36.990),(19,'PORTA GUARDANAPOS INOX',8.550),(20,'PARAFUSO DE RODA',10.700);
/*!40000 ALTER TABLE `tab_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wkpdv'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-18 14:55:38
