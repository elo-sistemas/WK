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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `codigo` bigint(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `estado` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'sr. das Galáxias','BELO HORIZONTE','MG'),(2,'Jedis e Cia','BELO HORIZONTE','MG'),(3,'Pão e cia','BELO HORIZONTE','MG'),(4,'Galeria do Ourives','BELO HORIZONTE','MG'),(5,'20 ervas','RIO DE JANEIRO','RJ'),(6,'Javier Soros','RIO DE JANEIRO','RJ'),(7,'Clínica Alves','RIO DE JANEIRO','RJ'),(8,'Clínica Alves','RIO DE JANEIRO','RJ'),(9,'Roupas da Moda','SÃO PAULO','SP'),(10,'Moda & Moda','SÃO PAULO','SP'),(11,'Feminina Roupas','SÃO PAULO','SP'),(12,'Ferraz Advogados e CIA','CURITIBA','PR'),(13,'Doces doces','CURITIBA','PR'),(14,'Amargo Doce','CURITIBA','PR'),(15,'Vida Natural','CURITIBA','PR'),(16,'Corpo Bom','FORTALEZA','CE'),(17,'Água saudável','FORTALEZA','CE'),(18,'Câmara Municipal','FORTALEZA','CE'),(19,'Seja Feliz','FORTALEZA','CE'),(20,'Valeu Zumbi','FORTALEZA','CE'),(21,'Amigo Pat','FORTALEZA','CE'),(22,'A Cura Natural','FORTALEZA','CE');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
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
