-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: librarieonline
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `autori`
--

DROP TABLE IF EXISTS `autori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autori` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nume_autor` varchar(50) NOT NULL,
  `prenume_autor` varchar(50) NOT NULL,
  `tara_origine` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autori`
--

LOCK TABLES `autori` WRITE;
/*!40000 ALTER TABLE `autori` DISABLE KEYS */;
INSERT INTO `autori` VALUES (1,'Susanna','Clarke','Marea Britanie'),(2,'Osamu','Dazai','Japonia'),(3,'George','Orwell','Marea Britanie');
/*!40000 ALTER TABLE `autori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carti`
--

DROP TABLE IF EXISTS `carti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carti` (
  `id_carte` int NOT NULL AUTO_INCREMENT,
  `titlu` varchar(100) NOT NULL,
  `gen` varchar(50) DEFAULT NULL,
  `pret` decimal(10,2) NOT NULL,
  `id_autor` int DEFAULT NULL,
  `id_editura` int DEFAULT NULL,
  PRIMARY KEY (`id_carte`),
  KEY `id_autor` (`id_autor`),
  KEY `id_editura` (`id_editura`),
  CONSTRAINT `carti_ibfk_1` FOREIGN KEY (`id_autor`) REFERENCES `autori` (`id_autor`),
  CONSTRAINT `carti_ibfk_2` FOREIGN KEY (`id_editura`) REFERENCES `edituri` (`id_editura`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carti`
--

LOCK TABLES `carti` WRITE;
/*!40000 ALTER TABLE `carti` DISABLE KEYS */;
INSERT INTO `carti` VALUES (1,'Piranesi','Fantasy',75.00,1,2),(2,'Melancolica Moarte a Baiatului-stridie','Poezie',50.00,2,1),(3,'My Brilliant Friend','Drama',65.00,3,3),(4,'Amurg','Literatura',55.00,2,1);
/*!40000 ALTER TABLE `carti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienti`
--

DROP TABLE IF EXISTS `clienti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienti` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `nume_client` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienti`
--

LOCK TABLES `clienti` WRITE;
/*!40000 ALTER TABLE `clienti` DISABLE KEYS */;
INSERT INTO `clienti` VALUES (1,'Popescu Ion','ion.popescu@gmail.com','0712345678'),(2,'Ionescu Maria','maria.ionescu@yahoo.com','0723456789'),(3,'Vasilescu Ana','ana.vasilescu@outlook.com','0734567890');
/*!40000 ALTER TABLE `clienti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comenzi`
--

DROP TABLE IF EXISTS `comenzi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comenzi` (
  `id_comanda` int NOT NULL AUTO_INCREMENT,
  `id_client` int DEFAULT NULL,
  `data_comanda` date NOT NULL,
  `status_comanda` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_comanda`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `comenzi_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clienti` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comenzi`
--

LOCK TABLES `comenzi` WRITE;
/*!40000 ALTER TABLE `comenzi` DISABLE KEYS */;
INSERT INTO `comenzi` VALUES (1,1,'2024-01-15','Finalizata'),(2,2,'2024-02-10','In curs'),(3,3,'2024-03-05','Anulata'),(4,2,'2024-05-01','In curs');
/*!40000 ALTER TABLE `comenzi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalii_comanda`
--

DROP TABLE IF EXISTS `detalii_comanda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalii_comanda` (
  `id_detaliu` int NOT NULL AUTO_INCREMENT,
  `id_comanda` int DEFAULT NULL,
  `id_carte` int DEFAULT NULL,
  `cantitate` int NOT NULL,
  PRIMARY KEY (`id_detaliu`),
  KEY `id_comanda` (`id_comanda`),
  KEY `id_carte` (`id_carte`),
  CONSTRAINT `detalii_comanda_ibfk_1` FOREIGN KEY (`id_comanda`) REFERENCES `comenzi` (`id_comanda`),
  CONSTRAINT `detalii_comanda_ibfk_2` FOREIGN KEY (`id_carte`) REFERENCES `carti` (`id_carte`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalii_comanda`
--

LOCK TABLES `detalii_comanda` WRITE;
/*!40000 ALTER TABLE `detalii_comanda` DISABLE KEYS */;
INSERT INTO `detalii_comanda` VALUES (1,1,1,2),(2,2,2,1),(3,3,3,3);
/*!40000 ALTER TABLE `detalii_comanda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edituri`
--

DROP TABLE IF EXISTS `edituri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edituri` (
  `id_editura` int NOT NULL AUTO_INCREMENT,
  `nume_editura` varchar(100) NOT NULL,
  `oras` varchar(50) DEFAULT NULL,
  `tara` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_editura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edituri`
--

LOCK TABLES `edituri` WRITE;
/*!40000 ALTER TABLE `edituri` DISABLE KEYS */;
INSERT INTO `edituri` VALUES (1,'Humanitas','Bucuresti','Romania'),(2,'Bloomsbury','Londra','Marea Britanie'),(3,'Penguin','New York','SUA');
/*!40000 ALTER TABLE `edituri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_carti_autori`
--

DROP TABLE IF EXISTS `view_carti_autori`;
/*!50001 DROP VIEW IF EXISTS `view_carti_autori`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_carti_autori` AS SELECT 
 1 AS `titlu`,
 1 AS `nume_autor`,
 1 AS `prenume_autor`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_carti_fantasy`
--

DROP TABLE IF EXISTS `view_carti_fantasy`;
/*!50001 DROP VIEW IF EXISTS `view_carti_fantasy`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_carti_fantasy` AS SELECT 
 1 AS `titlu`,
 1 AS `pret`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_comenzi_carti`
--

DROP TABLE IF EXISTS `view_comenzi_carti`;
/*!50001 DROP VIEW IF EXISTS `view_comenzi_carti`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_comenzi_carti` AS SELECT 
 1 AS `id_comanda`,
 1 AS `titlu`,
 1 AS `cantitate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_comenzi_popescu`
--

DROP TABLE IF EXISTS `view_comenzi_popescu`;
/*!50001 DROP VIEW IF EXISTS `view_comenzi_popescu`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_comenzi_popescu` AS SELECT 
 1 AS `id_comanda`,
 1 AS `data_comanda`,
 1 AS `status_comanda`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_edituri_carti`
--

DROP TABLE IF EXISTS `view_edituri_carti`;
/*!50001 DROP VIEW IF EXISTS `view_edituri_carti`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_edituri_carti` AS SELECT 
 1 AS `nume_editura`,
 1 AS `numar_carti`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'librarieonline'
--

--
-- Dumping routines for database 'librarieonline'
--
/*!50003 DROP FUNCTION IF EXISTS `calculeaza_discount_comanda` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculeaza_discount_comanda`(id_comanda_input INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    DECLARE discount DECIMAL(10,2);
    DECLARE prag DECIMAL(10,2) DEFAULT 100.00;

    SELECT SUM(c.pret * dc.cantitate) INTO total
    FROM detalii_comanda dc
    JOIN carti c ON dc.id_carte = c.id_carte
    WHERE dc.id_comanda = id_comanda_input;

    IF total > prag THEN
        SET discount = total * 0.10;
    ELSE
        SET discount = 0.00;
    END IF;

    RETURN discount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `comenzi_peste_n` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `comenzi_peste_n`(id_client INT, prag INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE nr_comenzi INT;

    SELECT COUNT(*) INTO nr_comenzi
    FROM comenzi
    WHERE client_id = id_client;

    RETURN nr_comenzi > prag;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizeazaPretCarte` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizeazaPretCarte`(
    IN p_id_carte INT,
    IN p_pret_nou DECIMAL(10,2)
)
BEGIN
    UPDATE Carti
    SET pret = p_pret_nou
    WHERE id_carte = p_id_carte;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AdaugaComandaNoua` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AdaugaComandaNoua`(
    IN p_id_client INT,
    IN p_data_comanda DATE,
    IN p_status_comanda VARCHAR(50)
)
BEGIN
    INSERT INTO Comenzi (id_client, data_comanda, status_comanda)
    VALUES (p_id_client, p_data_comanda, p_status_comanda);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AfiseazaComenziClient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AfiseazaComenziClient`(
    IN p_nume_client VARCHAR(100)
)
BEGIN
    SELECT Comenzi.id_comanda, data_comanda, status_comanda
    FROM Comenzi
    JOIN Clienti ON Comenzi.id_client = Clienti.id_client
    WHERE Clienti.nume_client = p_nume_client;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_carti_autori`
--

/*!50001 DROP VIEW IF EXISTS `view_carti_autori`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_carti_autori` AS select `carti`.`titlu` AS `titlu`,`autori`.`nume_autor` AS `nume_autor`,`autori`.`prenume_autor` AS `prenume_autor` from (`carti` join `autori` on((`carti`.`id_autor` = `autori`.`id_autor`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_carti_fantasy`
--

/*!50001 DROP VIEW IF EXISTS `view_carti_fantasy`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_carti_fantasy` AS select `carti`.`titlu` AS `titlu`,`carti`.`pret` AS `pret` from `carti` where (`carti`.`gen` = 'Fantasy') order by `carti`.`pret` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_comenzi_carti`
--

/*!50001 DROP VIEW IF EXISTS `view_comenzi_carti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_comenzi_carti` AS select `comenzi`.`id_comanda` AS `id_comanda`,`carti`.`titlu` AS `titlu`,`detalii_comanda`.`cantitate` AS `cantitate` from ((`detalii_comanda` join `carti` on((`detalii_comanda`.`id_carte` = `carti`.`id_carte`))) join `comenzi` on((`detalii_comanda`.`id_comanda` = `comenzi`.`id_comanda`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_comenzi_popescu`
--

/*!50001 DROP VIEW IF EXISTS `view_comenzi_popescu`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_comenzi_popescu` AS select `comenzi`.`id_comanda` AS `id_comanda`,`comenzi`.`data_comanda` AS `data_comanda`,`comenzi`.`status_comanda` AS `status_comanda` from (`comenzi` join `clienti` on((`comenzi`.`id_client` = `clienti`.`id_client`))) where (`clienti`.`nume_client` = 'Popescu Ion') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_edituri_carti`
--

/*!50001 DROP VIEW IF EXISTS `view_edituri_carti`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_edituri_carti` AS select `edituri`.`nume_editura` AS `nume_editura`,count(`carti`.`id_carte`) AS `numar_carti` from (`edituri` join `carti` on((`edituri`.`id_editura` = `carti`.`id_editura`))) group by `edituri`.`nume_editura` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-11 13:48:56
