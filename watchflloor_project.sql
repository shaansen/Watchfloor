-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: watchfloor
-- ------------------------------------------------------
-- Server version	5.7.16-log

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
-- Table structure for table `db_access_logs`
--

DROP TABLE IF EXISTS `db_access_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_access_logs` (
  `email` varchar(25) NOT NULL,
  `action` varchar(25) DEFAULT NULL,
  `user_type` char(1) NOT NULL,
  KEY `fk4_db_user` (`email`),
  CONSTRAINT `fk4_db_user` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_access_logs`
--

LOCK TABLES `db_access_logs` WRITE;
/*!40000 ALTER TABLE `db_access_logs` DISABLE KEYS */;
INSERT INTO `db_access_logs` VALUES ('ajinkya','view','p'),('anil','view','m'),('shane','view','c');
/*!40000 ALTER TABLE `db_access_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guard_info`
--

DROP TABLE IF EXISTS `guard_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guard_info` (
  `guard_email` varchar(25) NOT NULL,
  `shift` varchar(25) NOT NULL,
  `checkin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checkout_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guard_info`
--

LOCK TABLES `guard_info` WRITE;
/*!40000 ALTER TABLE `guard_info` DISABLE KEYS */;
INSERT INTO `guard_info` VALUES ('pavan','morning 8 to 2','2016-01-01 12:55:00','2016-01-01 07:00:00'),('niraj','afternoon 2 to 8','2016-01-01 13:00:00','2016-01-01 07:00:00'),('rahul','overnight 8 to 8','2016-01-01 13:00:00','2016-01-01 13:00:00');
/*!40000 ALTER TABLE `guard_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_traffic`
--

DROP TABLE IF EXISTS `network_traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_traffic` (
  `email` varchar(25) NOT NULL,
  `ip_address` binary(16) NOT NULL,
  `source` varchar(25) DEFAULT NULL,
  `protocol` varchar(25) DEFAULT NULL,
  KEY `fk3_network` (`email`),
  CONSTRAINT `fk3_network` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_traffic`
--

LOCK TABLES `network_traffic` WRITE;
/*!40000 ALTER TABLE `network_traffic` DISABLE KEYS */;
INSERT INTO `network_traffic` VALUES ('shantanu1','122.67.43.34\0\0\0\0','google','TCP'),('ajinkya','69.87.45.226\0\0\0\0','google','TCP'),('akansha','67.67.43.123\0\0\0\0','website','UDP'),('shantanu1','120.67.43.34\0\0\0\0','google','TCP');
/*!40000 ALTER TABLE `network_traffic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_checkin_time`
--

DROP TABLE IF EXISTS `player_checkin_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_checkin_time` (
  `email` varchar(25) NOT NULL,
  `checkin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `checkout_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `duration` time DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `barcode` varchar(30) DEFAULT NULL,
  KEY `fk2_chechkin_time` (`email`),
  CONSTRAINT `fk2_chechkin_time` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_checkin_time`
--

LOCK TABLES `player_checkin_time` WRITE;
/*!40000 ALTER TABLE `player_checkin_time` DISABLE KEYS */;
INSERT INTO `player_checkin_time` VALUES ('shantanu','2016-01-01 09:34:00','2016-01-08 09:42:00','00:08:00','positive','123454565'),('shantanu1','2016-02-03 09:34:00','2016-02-03 09:41:00','00:07:00','positive','123454678'),('ajinkya','2016-03-03 08:40:00','2016-03-03 08:50:00','00:10:00','positive','675654678'),('akansha','2016-03-04 07:40:00','2016-03-04 07:50:00','00:10:00','negative','234654678');
/*!40000 ALTER TABLE `player_checkin_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_results`
--

DROP TABLE IF EXISTS `player_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_results` (
  `record_id` int(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `date_acquired` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `disposable_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_analyzed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sample_mass` double DEFAULT NULL,
  `drug_ppm` double DEFAULT NULL,
  `manager_id` varchar(25) DEFAULT NULL,
  `manager_name` varchar(25) DEFAULT NULL,
  `Result` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`record_id`,`email`),
  KEY `email` (`email`),
  CONSTRAINT `player_results_ibfk_1` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_results`
--

LOCK TABLES `player_results` WRITE;
/*!40000 ALTER TABLE `player_results` DISABLE KEYS */;
INSERT INTO `player_results` VALUES (1,'shantanu','2016-01-01 09:34:00','2016-01-08 09:34:00','2016-01-02 09:05:00',1.1,120,'sachin','sachin','negative'),(2,'shantanu1','2016-02-03 09:34:00','2016-02-10 09:34:00','2016-02-04 10:05:00',1.5,110,'anil','anil','negative'),(3,'ajinkya','2016-03-03 08:40:00','2016-03-10 08:40:00','2016-03-07 07:56:00',1.5,110,'sachin','sachin','negative'),(4,'akansha','2016-03-04 07:40:00','2016-03-11 07:40:00','2016-03-09 06:56:00',6.5,450,'anil','anil','positive');
/*!40000 ALTER TABLE `player_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `robort_monitoring`
--

DROP TABLE IF EXISTS `robort_monitoring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `robort_monitoring` (
  `email` varchar(25) NOT NULL,
  `sample_input_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `barcode` varchar(30) DEFAULT NULL,
  `wait_of_sample_indays` int(11) DEFAULT NULL,
  `result` varchar(20) DEFAULT NULL,
  `analize_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `robort_monitoring`
--

LOCK TABLES `robort_monitoring` WRITE;
/*!40000 ALTER TABLE `robort_monitoring` DISABLE KEYS */;
INSERT INTO `robort_monitoring` VALUES ('shantanu','2016-01-01 09:32:00','123454565',7,'positive','2016-01-02 09:05:00'),('shantanu1','2016-02-03 09:34:00','123454678',7,'positive','2016-02-04 10:05:00'),('ajinkya','2016-03-03 08:40:00','675654678',7,'positive','2016-03-07 07:56:00'),('akansha','2016-03-04 07:40:00','234654678',7,'negative','2016-03-09 06:56:00');
/*!40000 ALTER TABLE `robort_monitoring` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_info`
--

DROP TABLE IF EXISTS `server_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_info` (
  `server_id` varchar(25) NOT NULL,
  `server_load` varchar(25) DEFAULT NULL,
  `cpu_usage_in_percentage` int(11) DEFAULT NULL,
  `disk_space_in_GB` int(11) DEFAULT NULL,
  `number_of_hits` int(11) DEFAULT NULL,
  `status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_info`
--

LOCK TABLES `server_info` WRITE;
/*!40000 ALTER TABLE `server_info` DISABLE KEYS */;
INSERT INTO `server_info` VALUES ('web server','high',90,120,670,'active'),('database server','high',94,820,1000,'active');
/*!40000 ALTER TABLE `server_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `email` varchar(25) NOT NULL,
  `pwd` varchar(25) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('ajinkya','wakhale',0,'p'),('akansha','akansha',0,'p'),('anil','anil',0,'m'),('prachi','dharurkar',0,'p'),('rahul','dravid',0,'m'),('sachin','sachin',0,'m'),('saila','pisupati',0,'p'),('shane','warne',0,'c'),('shantanu','shantanu',0,'p'),('shantanu1','shantanu1',0,'p');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-01 12:31:15
