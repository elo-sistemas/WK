-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: teste_marcio
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `codigo` bigint(20) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`codigo`),
  KEY `idx_codigo` (`codigo`),
  KEY `idx_descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Água Mineral',2.50),(2,'Pão de sal',4.99),(3,'Pão de doce',5.99),(4,'Manteiga',6.99),(5,'Chá Mate',3.99),(6,'Sabão em Pó',13.50),(7,'Sal',1.99),(8,'Sabão em barra',7.99),(9,'Cerveja Skol',4.99),(10,'Coca-Cola',8.99),(11,'Detergente Minerva',1.99),(12,'Caixa de bombom Garoto',9.99),(13,'Leite',3.59),(14,'Doce de leite',5.99),(15,'Vinho tinto',60.00),(16,'Arroz',30.00),(17,'Feijão',9.80),(18,'Creme de leite',3.99),(19,'Bicarbonato de sódio',2.50),(20,'Café',7.50),(21,'Papel higiênico',10.90),(22,'Nescau',4.90),(23,'Milho de pipoca',4.99),(24,'Cesta básica',117.00),(25,'Vinagre',2.50);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-30 11:13:18
