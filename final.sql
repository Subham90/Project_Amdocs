-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `AdminID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  PRIMARY KEY (`AdminID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'admin',''),(2,'Subh','Subham123@'),(3,'',''),(4,'prachi','praaa');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `Appointment_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_ID` int NOT NULL,
  `Doctor_ID` int NOT NULL,
  `Date_time` datetime NOT NULL,
  PRIMARY KEY (`Appointment_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Doctor_ID` (`Doctor_ID`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `patient_details` (`Patient_ID`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`Doctor_ID`) REFERENCES `doctor` (`Doct_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (101,1,1,'2025-06-20 09:00:00'),(102,2,2,'2025-06-20 10:00:00'),(103,3,3,'2025-06-21 11:00:00'),(104,4,4,'2025-06-21 12:30:00'),(105,5,5,'2025-06-22 14:00:00'),(106,6,6,'2025-06-22 15:30:00'),(107,7,7,'2025-06-23 10:15:00'),(108,8,8,'2025-06-23 16:00:00'),(109,9,9,'2025-06-24 09:45:00'),(110,10,10,'2025-06-24 11:30:00'),(111,11,11,'2025-06-25 10:00:00'),(112,12,12,'2025-06-25 11:30:00'),(113,13,13,'2025-06-26 13:00:00'),(114,14,14,'2025-06-26 14:45:00'),(115,15,15,'2025-06-27 15:15:00'),(116,16,16,'2025-06-27 16:00:00'),(117,17,17,'2025-06-28 09:00:00'),(118,18,18,'2025-06-28 10:30:00'),(119,19,19,'2025-06-29 11:00:00'),(120,20,20,'2025-06-29 13:00:00'),(122,22,1,'2025-06-20 11:00:00'),(123,1,6,'2025-01-01 09:09:09'),(124,2,1,'2025-06-30 09:09:09'),(125,22,1,'2025-06-30 09:09:09'),(126,10,1,'2025-06-30 09:09:09'),(127,25,1,'2025-06-24 03:00:00'),(128,25,1,'2025-06-30 03:00:00'),(129,1,1,'2025-06-25 09:00:00'),(130,5,6,'2025-06-30 05:00:00'),(131,7,17,'2025-06-30 17:20:34'),(132,9,10,'2025-06-30 05:30:30'),(133,2,1,'2025-06-30 22:22:22'),(134,17,12,'2025-02-07 09:00:00'),(135,12,1,'2025-01-21 12:00:00');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing` (
  `Bill_id` int NOT NULL AUTO_INCREMENT,
  `Bill_date_time` date DEFAULT NULL,
  `Appoint_ID` int NOT NULL,
  `Amount` int DEFAULT NULL,
  PRIMARY KEY (`Bill_id`),
  KEY `billing_ibfk_1` (`Appoint_ID`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`Appoint_ID`) REFERENCES `appointment` (`Appointment_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` VALUES (301,'2025-06-20',101,NULL),(302,'2025-06-20',102,NULL),(303,'2025-06-21',103,NULL),(304,'2025-06-21',104,NULL),(305,'2025-06-22',105,NULL),(306,'2025-06-22',106,NULL),(307,'2025-06-23',107,NULL),(308,'2025-06-23',108,NULL),(309,'2025-06-24',109,NULL),(310,'2025-06-24',110,NULL),(311,'2025-06-25',111,NULL),(312,'2025-06-25',112,NULL),(313,'2025-06-26',113,NULL),(314,'2025-06-26',114,NULL),(315,'2025-06-27',115,NULL),(316,'2025-06-27',116,NULL),(317,'2025-06-28',117,NULL),(318,'2025-06-28',118,NULL),(319,'2025-06-29',120,NULL),(320,'2025-06-29',119,NULL),(321,'2025-06-29',122,NULL);
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `Dept_ID` varchar(10) NOT NULL,
  `Dept_name` varchar(20) DEFAULT NULL,
  `Dept_fee` int NOT NULL,
  `Dept_Symptoms` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Dept_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('1','HEART',331,'PAIN'),('132','Gastro',1260,'Discomfort, pain'),('DPT001','Cardiology',5789,'Chest pain, palpitations, dizziness'),('DPT002','Neurology',5209,'Headaches, seizures, numbness'),('DPT003','Orthopedics',4631,'Joint pain, fractures, back pain'),('DPT004','Pediatrics',3473,'Fever, cough in children, rashes'),('DPT005','Dermatology',2894,'Skin rashes, acne, eczema'),('DPT006','ENT',2315,'Ear pain, sore throat, hearing loss'),('DPT007','Gynecology',4052,'Irregular periods, pelvic pain'),('DPT008','Psychiatry',5789,'Anxiety, depression, mood swings'),('DPT009','Gastroenterology',4631,'Stomach pain, bloating, nausea'),('DPT010','Urology',4400,'Urine infection, kidney pain'),('DPT011','STONE',551,'\'PAIN\',\'DISCOMFORT\',\'SLEEPY\''),('DPT012','Gyno',1050,'pain'),('DPT013','NEFRO',2000,'PAIN , KIDNEY INFECTION'),('DPT016','opd',300,'pain'),('FH','HFH',331,'3443');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `Doct_ID` int NOT NULL AUTO_INCREMENT,
  `Doct_name` varchar(100) NOT NULL,
  `Doct_gender` varchar(10) NOT NULL,
  `Doct_Contact` varchar(15) NOT NULL,
  `Doct_Email` varchar(100) NOT NULL,
  `Dept_ID` varchar(10) DEFAULT NULL,
  `Doctor_Experience` int DEFAULT NULL,
  PRIMARY KEY (`Doct_ID`),
  KEY `Dept_ID` (`Dept_ID`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`Dept_ID`) REFERENCES `departments` (`Dept_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Dr. Arjun Mehta','Male','9876543210','arjun@hospital.com','DPT001',15),(2,'Dr. Neha Sharma','Female','9123456780','neha@hospital.com','DPT002',10),(3,'Dr. Rahul Kapoor','Male','9345678901','rahul@hospital.com','DPT003',12),(4,'Dr. Anjali Nair','Female','9456789012','anjali@hospital.com','DPT004',8),(5,'Dr. Rohan Das','Male','9567890123','rohan@hospital.com','DPT005',6),(6,'Dr. Isha Verma','Female','9678901234','isha@hospital.com','DPT006',9),(7,'Dr. Priya Menon','Female','9789012345','priya@hospital.com','DPT007',11),(8,'Dr. Aman Sinha','Male','9890123456','aman@hospital.com','DPT008',14),(9,'Dr. Kavita Rao','Female','9901234567','kavita@hospital.com','DPT009',7),(10,'Dr. Sameer Khan','Male','9012345678','sameer@hospital.com','DPT010',13),(11,'Dr. Alok Bhat','Male','9341112223','alok@hospital.com','DPT001',9),(12,'Dr. Tanya Roy','Female','9322113344','tanya@hospital.com','DPT002',10),(13,'Dr. Devika Sharma','Female','9388881111','devika@hospital.com','DPT003',8),(14,'Dr. Tarun Patel','Male','9444112233','tarun@hospital.com','DPT004',6),(15,'Dr. Meenakshi Iyer','Female','9555223344','meenakshi@hospital.com','DPT005',7),(16,'Dr. Siddharth Jain','Male','9666334455','siddharth@hospital.com','DPT006',11),(17,'Dr. Aarti Saxena','Female','9777445566','aarti@hospital.com','DPT007',13),(18,'Dr. Vikram Oberoi','Male','9888556677','vikram@hospital.com','DPT008',12),(19,'Dr. Seema Agarwal','Female','9999667788','seema@hospital.com','DPT009',10),(20,'Dr. Yash Malhotra','Male','9000111222','yash@hospital.com','DPT010',15),(22,'chandu','M','123456789','chandu123@gmail.com','DPT001',7),(29,'LLK','M','389490893489453','suasbhdjddsckm','DPT011',10),(30,'SUBHAM','MALE','9090879800','jaisjisdu@.com','DPT013',5);
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ff`
--

DROP TABLE IF EXISTS `ff`;
/*!50001 DROP VIEW IF EXISTS `ff`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ff` AS SELECT 
 1 AS `Appointment_ID`,
 1 AS `Patient_ID`,
 1 AS `Doctor_ID`,
 1 AS `Date_time`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patient_arrival_info`
--

DROP TABLE IF EXISTS `patient_arrival_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_arrival_info` (
  `Pat_ID` int NOT NULL,
  `Arrival_Date` date DEFAULT NULL,
  `Symptoms` varchar(255) DEFAULT NULL,
  KEY `Patient_ID` (`Pat_ID`),
  CONSTRAINT `patient_arrival_info_ibfk_1` FOREIGN KEY (`Pat_ID`) REFERENCES `patient_details` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_arrival_info`
--

LOCK TABLES `patient_arrival_info` WRITE;
/*!40000 ALTER TABLE `patient_arrival_info` DISABLE KEYS */;
INSERT INTO `patient_arrival_info` VALUES (1,'2025-06-20','Chest pain'),(2,'2025-06-20','Headache'),(3,'2025-06-21','Back pain'),(4,'2025-06-21','Fever and cough'),(5,'2025-06-22','Skin irritation'),(6,'2025-06-22','Ear pain'),(7,'2025-06-23','Depression symptoms'),(8,'2025-06-23','Urine infection'),(9,'2025-06-24','Abdominal pain'),(10,'2025-06-24','Pelvic cramps'),(11,'2025-06-25','High BP'),(12,'2025-06-25','Migraine'),(13,'2025-06-26','Joint stiffness'),(14,'2025-06-26','Cough'),(15,'2025-06-27','Acne breakout'),(16,'2025-06-27','Ear blockage'),(17,'2025-06-28','Mood swings'),(18,'2025-06-28','Kidney pain'),(19,'2025-06-29','Bloating'),(20,'2025-06-29','Menstrual cramps');
/*!40000 ALTER TABLE `patient_arrival_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_details`
--

DROP TABLE IF EXISTS `patient_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_details` (
  `Patient_ID` int NOT NULL AUTO_INCREMENT,
  `Patient_Contacts` varchar(15) DEFAULT NULL,
  `Patient_Gender` varchar(10) NOT NULL,
  `Patient_Age` int NOT NULL,
  `BloogGrp` varchar(5) NOT NULL,
  `Patient_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`),
  KEY `idx_patient_contact` (`Patient_Contacts`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_details`
--

LOCK TABLES `patient_details` WRITE;
/*!40000 ALTER TABLE `patient_details` DISABLE KEYS */;
INSERT INTO `patient_details` VALUES (1,'9871112233','Male',45,'A+',NULL),(2,'9122223344','Female',32,'B+',NULL),(3,'9343334455','Female',28,'O+',NULL),(4,'9454445566','Male',50,'AB+',NULL),(5,'9565556677','Female',38,'A-',NULL),(6,'9676667788','Male',60,'B-',NULL),(7,'9787778899','Female',41,'O-',NULL),(8,'9898889900','Male',35,'A+',NULL),(9,'9909990011','Female',29,'AB-',NULL),(10,'9010001122','Male',47,'B+',NULL),(11,'9121112233','Female',52,'O+',NULL),(12,'9232223344','Male',36,'A-',NULL),(13,'9343334455','Female',40,'B-',NULL),(14,'9454445566','Male',31,'AB+',NULL),(15,'9565556677','Female',26,'O-',NULL),(16,'9676667788','Male',55,'A+',NULL),(17,'9787778899','Female',33,'B+',NULL),(18,'9898889900','Male',46,'O+',NULL),(19,'9909990011','Female',48,'AB-',NULL),(20,'9010001122','Male',30,'A+',NULL),(22,'9999999999','M',30,'O+',NULL),(23,'9064911158','M',12,'A+',NULL),(24,'9064567890','M',22,'A+',NULL),(25,'098765876','Femal',21,'+A',NULL),(26,'23456789','M',23,'A=+',NULL),(27,'3456789','M',90,'m',NULL),(28,'23456789','M',233,'A+','subham'),(29,'8498577523','FEMALE',22,'B+','Yashashvi');
/*!40000 ALTER TABLE `patient_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_prescription_history`
--

DROP TABLE IF EXISTS `patient_prescription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_prescription_history` (
  `Appt_ID` int NOT NULL,
  `Diagnosis` varchar(255) DEFAULT NULL,
  `Prescription` varchar(255) DEFAULT NULL,
  KEY `patient_prescription_history_ibfk_1` (`Appt_ID`),
  CONSTRAINT `patient_prescription_history_ibfk_1` FOREIGN KEY (`Appt_ID`) REFERENCES `appointment` (`Appointment_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_prescription_history`
--

LOCK TABLES `patient_prescription_history` WRITE;
/*!40000 ALTER TABLE `patient_prescription_history` DISABLE KEYS */;
INSERT INTO `patient_prescription_history` VALUES (101,'Hypertension','Amlodipine 5mg daily'),(102,'Migraine','Sumatriptan 50mg PRN'),(103,'Lower back pain','Ibuprofen 400mg BID'),(104,'Fever & viral infection','Paracetamol + Rest'),(105,'Eczema','Topical Hydrocortisone'),(106,'Otitis Media','Ciprofloxacin ear drops'),(107,'Depression','Sertraline 50mg OD'),(108,'UTI','Nitrofurantoin 100mg BID'),(109,'Gastritis','Pantoprazole 40mg before food'),(110,'Menstrual cramps','Mefenamic acid 500mg'),(111,'Hypertension','Lifestyle mod. + ACE inhibitor'),(112,'Migraine','Avoid triggers + pain relief'),(113,'Arthritis','Diclofenac gel + hot compress'),(114,'Common Cold','Antihistamine + warm fluids'),(115,'Acne Vulgaris','Benzoyl peroxide 2.5% cream'),(116,'Earwax buildup','Olive oil ear drops'),(117,'Anxiety Disorder','Cognitive therapy sessions'),(118,'Kidney stone','Tamsulosin + hydration'),(101,'Hypertension','Amlodipine 5mg daily'),(102,'Migraine','Sumatriptan 50mg PRN'),(103,'Lower back pain','Ibuprofen 400mg BID'),(104,'Fever & viral infection','Paracetamol + Rest'),(105,'Eczema','Topical Hydrocortisone'),(106,'Otitis Media','Ciprofloxacin ear drops'),(107,'Depression','Sertraline 50mg OD'),(108,'UTI','Nitrofurantoin 100mg BID'),(109,'Gastritis','Pantoprazole 40mg before food'),(110,'Menstrual cramps','Mefenamic acid 500mg'),(111,'Hypertension','Lifestyle mod. + ACE inhibitor'),(112,'Migraine','Avoid triggers + pain relief'),(113,'Arthritis','Diclofenac gel + hot compress'),(114,'Common Cold','Antihistamine + warm fluids'),(115,'Acne Vulgaris','Benzoyl peroxide 2.5% cream'),(116,'Earwax buildup','Olive oil ear drops'),(117,'Anxiety Disorder','Cognitive therapy sessions'),(118,'Kidney stone','Tamsulosin + hydration'),(129,'nbcjd','hbjdwjc'),(101,'CANCER','CHEMO THEREPY'),(112,'CANCER','CHEMO');
/*!40000 ALTER TABLE `patient_prescription_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `ff`
--

/*!50001 DROP VIEW IF EXISTS `ff`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ff` AS select `appointment`.`Appointment_ID` AS `Appointment_ID`,`appointment`.`Patient_ID` AS `Patient_ID`,`appointment`.`Doctor_ID` AS `Doctor_ID`,`appointment`.`Date_time` AS `Date_time` from `appointment` */;
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

-- Dump completed on 2025-07-02 14:23:19
