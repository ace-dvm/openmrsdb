-- MySQL dump 10.18  Distrib 10.3.27-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: openmrs
-- ------------------------------------------------------
-- Server version	10.3.27-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `allergy`
--

DROP TABLE IF EXISTS `allergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy` (
  `allergy_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `severity_concept_id` int(11) DEFAULT NULL,
  `coded_allergen` int(11) NOT NULL,
  `non_coded_allergen` varchar(255) DEFAULT NULL,
  `allergen_type` varchar(50) NOT NULL,
  `comments` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 1,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_id`),
  UNIQUE KEY `allergy_id` (`allergy_id`),
  KEY `allergy_changed_by_fk` (`changed_by`),
  KEY `allergy_coded_allergen_fk` (`coded_allergen`),
  KEY `allergy_creator_fk` (`creator`),
  KEY `allergy_patient_id_fk` (`patient_id`),
  KEY `allergy_severity_concept_id_fk` (`severity_concept_id`),
  KEY `allergy_voided_by_fk` (`voided_by`),
  CONSTRAINT `allergy_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_coded_allergen_fk` FOREIGN KEY (`coded_allergen`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_severity_concept_id_fk` FOREIGN KEY (`severity_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy`
--

LOCK TABLES `allergy` WRITE;
/*!40000 ALTER TABLE `allergy` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allergy_reaction`
--

DROP TABLE IF EXISTS `allergy_reaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergy_reaction` (
  `allergy_reaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `allergy_id` int(11) NOT NULL,
  `reaction_concept_id` int(11) NOT NULL,
  `reaction_non_coded` varchar(255) DEFAULT NULL,
  `uuid` char(38) DEFAULT NULL,
  PRIMARY KEY (`allergy_reaction_id`),
  UNIQUE KEY `allergy_reaction_id` (`allergy_reaction_id`),
  KEY `allergy_reaction_allergy_id_fk` (`allergy_id`),
  KEY `allergy_reaction_reaction_concept_id_fk` (`reaction_concept_id`),
  CONSTRAINT `allergy_reaction_allergy_id_fk` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`allergy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `allergy_reaction_reaction_concept_id_fk` FOREIGN KEY (`reaction_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allergy_reaction`
--

LOCK TABLES `allergy_reaction` WRITE;
/*!40000 ALTER TABLE `allergy_reaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `allergy_reaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `care_setting`
--

DROP TABLE IF EXISTS `care_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `care_setting` (
  `care_setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `care_setting_type` varchar(50) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`care_setting_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `care_setting_changed_by` (`changed_by`),
  KEY `care_setting_creator` (`creator`),
  KEY `care_setting_retired_by` (`retired_by`),
  CONSTRAINT `care_setting_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `care_setting_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `care_setting`
--

LOCK TABLES `care_setting` WRITE;
/*!40000 ALTER TABLE `care_setting` DISABLE KEYS */;
INSERT INTO `care_setting` VALUES (1,'Outpatient','Out-patient care setting','OUTPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'6f0c9a92-6f24-11e3-af88-005056821db0'),(2,'Inpatient','In-patient care setting','INPATIENT',1,'2013-12-27 00:00:00',0,NULL,NULL,NULL,NULL,NULL,'c365e560-c3ec-11e3-9c1a-0800200c9a66');
/*!40000 ALTER TABLE `care_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clob_datatype_storage`
--

DROP TABLE IF EXISTS `clob_datatype_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clob_datatype_storage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` char(38) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clob_datatype_storage`
--

LOCK TABLES `clob_datatype_storage` WRITE;
/*!40000 ALTER TABLE `clob_datatype_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `clob_datatype_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort`
--

DROP TABLE IF EXISTS `cohort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort` (
  `cohort_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_creator` (`creator`),
  KEY `user_who_changed_cohort` (`changed_by`),
  KEY `user_who_voided_cohort` (`voided_by`),
  CONSTRAINT `cohort_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_cohort` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_cohort` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort`
--

LOCK TABLES `cohort` WRITE;
/*!40000 ALTER TABLE `cohort` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cohort_member`
--

DROP TABLE IF EXISTS `cohort_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohort_member` (
  `cohort_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `cohort_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`cohort_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `cohort_member_creator` (`creator`),
  KEY `member_patient` (`patient_id`),
  KEY `parent_cohort` (`cohort_id`),
  CONSTRAINT `cohort_member_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `member_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_cohort` FOREIGN KEY (`cohort_id`) REFERENCES `cohort` (`cohort_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cohort_member`
--

LOCK TABLES `cohort_member` WRITE;
/*!40000 ALTER TABLE `cohort_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `cohort_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept`
--

DROP TABLE IF EXISTS `concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept` (
  `concept_id` int(11) NOT NULL AUTO_INCREMENT,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `short_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `form_text` text DEFAULT NULL,
  `datatype_id` int(11) NOT NULL DEFAULT 0,
  `class_id` int(11) NOT NULL DEFAULT 0,
  `is_set` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_classes` (`class_id`),
  KEY `concept_creator` (`creator`),
  KEY `concept_datatypes` (`datatype_id`),
  KEY `user_who_changed_concept` (`changed_by`),
  KEY `user_who_retired_concept` (`retired_by`),
  CONSTRAINT `concept_classes` FOREIGN KEY (`class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_datatypes` FOREIGN KEY (`datatype_id`) REFERENCES `concept_datatype` (`concept_datatype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_concept` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept`
--

LOCK TABLES `concept` WRITE;
/*!40000 ALTER TABLE `concept` DISABLE KEYS */;
INSERT INTO `concept` VALUES (1,0,'','',NULL,4,11,0,1,'2018-06-04 18:29:58',NULL,NULL,NULL,NULL,NULL,NULL,'cf82933b-3f3f-45e7-a5ab-5d31aaee3da3'),(2,0,'','',NULL,4,11,0,1,'2018-06-04 18:29:58',NULL,NULL,NULL,NULL,NULL,NULL,'488b58ff-64f5-4f8a-8979-fa79940b1594');
/*!40000 ALTER TABLE `concept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_answer`
--

DROP TABLE IF EXISTS `concept_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_answer` (
  `concept_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `answer_concept` int(11) DEFAULT NULL,
  `answer_drug` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer` (`answer_concept`),
  KEY `answer_answer_drug_fk` (`answer_drug`),
  KEY `answer_creator` (`creator`),
  KEY `answers_for_concept` (`concept_id`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_concept`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_answer_drug_fk` FOREIGN KEY (`answer_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answers_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_answer`
--

LOCK TABLES `concept_answer` WRITE;
/*!40000 ALTER TABLE `concept_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute`
--

DROP TABLE IF EXISTS `concept_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute` (
  `concept_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `concept_attribute_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_concept_fk` (`concept_id`),
  KEY `concept_attribute_creator_fk` (`creator`),
  KEY `concept_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `concept_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `concept_attribute_type` (`concept_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_concept_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute`
--

LOCK TABLES `concept_attribute` WRITE;
/*!40000 ALTER TABLE `concept_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_attribute_type`
--

DROP TABLE IF EXISTS `concept_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_attribute_type` (
  `concept_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_attribute_type_changed_by_fk` (`changed_by`),
  KEY `concept_attribute_type_creator_fk` (`creator`),
  KEY `concept_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `concept_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_attribute_type`
--

LOCK TABLES `concept_attribute_type` WRITE;
/*!40000 ALTER TABLE `concept_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_class`
--

DROP TABLE IF EXISTS `concept_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_class` (
  `concept_class_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_class_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_class_changed_by` (`changed_by`),
  KEY `concept_class_creator` (`creator`),
  KEY `concept_class_name_index` (`name`),
  KEY `concept_class_retired_status` (`retired`),
  KEY `user_who_retired_concept_class` (`retired_by`),
  CONSTRAINT `concept_class_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_class_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_class` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_class`
--

LOCK TABLES `concept_class` WRITE;
/*!40000 ALTER TABLE `concept_class` DISABLE KEYS */;
INSERT INTO `concept_class` VALUES (1,'Test','Acq. during patient encounter (vitals, labs, etc.)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4907b2-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(2,'Procedure','Describes a clinical procedure',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d490bf4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(3,'Drug','Drug',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d490dfc-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(4,'Diagnosis','Conclusion drawn through findings',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4918b0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(5,'Finding','Practitioner observation/finding',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491a9a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(6,'Anatomy','Anatomic sites / descriptors',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491c7a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(7,'Question','Question (eg, patient history, SF36 items)',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d491e50-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(8,'LabSet','Term to describe laboratory sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492026-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(9,'MedSet','Term to describe medication sets',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4923b4-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(10,'ConvSet','Term to describe convenience sets',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492594-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(11,'Misc','Terms which don\'t fit other categories',1,'2004-03-02 00:00:00',0,NULL,NULL,NULL,'8d492774-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(12,'Symptom','Patient-reported observation',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492954-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(13,'Symptom/Finding','Observation that can be reported from patient or found on exam',1,'2004-10-04 00:00:00',0,NULL,NULL,NULL,'8d492b2a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(14,'Specimen','Body or fluid specimen',1,'2004-12-02 00:00:00',0,NULL,NULL,NULL,'8d492d0a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(15,'Misc Order','Orderable items which aren\'t tests or drugs',1,'2005-02-17 00:00:00',0,NULL,NULL,NULL,'8d492ee0-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(16,'Frequency','A class for order frequencies',1,'2014-03-06 00:00:00',0,NULL,NULL,NULL,'8e071bfe-520c-44c0-a89b-538e9129b42a',NULL,NULL);
/*!40000 ALTER TABLE `concept_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_complex`
--

DROP TABLE IF EXISTS `concept_complex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_complex` (
  `concept_id` int(11) NOT NULL,
  `handler` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `concept_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_complex`
--

LOCK TABLES `concept_complex` WRITE;
/*!40000 ALTER TABLE `concept_complex` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_complex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_datatype`
--

DROP TABLE IF EXISTS `concept_datatype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_datatype` (
  `concept_datatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `hl7_abbreviation` varchar(3) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_datatype_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_datatype_creator` (`creator`),
  KEY `concept_datatype_name_index` (`name`),
  KEY `concept_datatype_retired_status` (`retired`),
  KEY `user_who_retired_concept_datatype` (`retired_by`),
  CONSTRAINT `concept_datatype_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_datatype` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_datatype`
--

LOCK TABLES `concept_datatype` WRITE;
/*!40000 ALTER TABLE `concept_datatype` DISABLE KEYS */;
INSERT INTO `concept_datatype` VALUES (1,'Numeric','NM','Numeric value, including integer or float (e.g., creatinine, weight)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4488-c2cc-11de-8d13-0010c6dffd0f'),(2,'Coded','CWE','Value determined by term dictionary lookup (i.e., term identifier)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a48b6-c2cc-11de-8d13-0010c6dffd0f'),(3,'Text','ST','Free text',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4ab4-c2cc-11de-8d13-0010c6dffd0f'),(4,'N/A','ZZ','Not associated with a datatype (e.g., term answers, sets)',1,'2004-02-02 00:00:00',0,NULL,NULL,NULL,'8d4a4c94-c2cc-11de-8d13-0010c6dffd0f'),(5,'Document','RP','Pointer to a binary or text-based document (e.g., clinical document, RTF, XML, EKG, image, etc.) stored in complex_obs table',1,'2004-04-15 00:00:00',0,NULL,NULL,NULL,'8d4a4e74-c2cc-11de-8d13-0010c6dffd0f'),(6,'Date','DT','Absolute date',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a505e-c2cc-11de-8d13-0010c6dffd0f'),(7,'Time','TM','Absolute time of day',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a591e-c2cc-11de-8d13-0010c6dffd0f'),(8,'Datetime','TS','Absolute date and time',1,'2004-07-22 00:00:00',0,NULL,NULL,NULL,'8d4a5af4-c2cc-11de-8d13-0010c6dffd0f'),(10,'Boolean','BIT','Boolean value (yes/no, true/false)',1,'2004-08-26 00:00:00',0,NULL,NULL,NULL,'8d4a5cca-c2cc-11de-8d13-0010c6dffd0f'),(11,'Rule','ZZ','Value derived from other data',1,'2006-09-11 00:00:00',0,NULL,NULL,NULL,'8d4a5e96-c2cc-11de-8d13-0010c6dffd0f'),(12,'Structured Numeric','SN','Complex numeric values possible (ie, <5, 1-10, etc.)',1,'2005-08-06 00:00:00',0,NULL,NULL,NULL,'8d4a606c-c2cc-11de-8d13-0010c6dffd0f'),(13,'Complex','ED','Complex value.  Analogous to HL7 Embedded Datatype',1,'2008-05-28 12:25:34',0,NULL,NULL,NULL,'8d4a6242-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `concept_datatype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_description`
--

DROP TABLE IF EXISTS `concept_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_description` (
  `concept_description_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_description_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `description_for_concept` (`concept_id`),
  KEY `user_who_changed_description` (`changed_by`),
  KEY `user_who_created_description` (`creator`),
  CONSTRAINT `description_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_description` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_description` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_description`
--

LOCK TABLES `concept_description` WRITE;
/*!40000 ALTER TABLE `concept_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_map_type`
--

DROP TABLE IF EXISTS `concept_map_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_map_type` (
  `concept_map_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_user_changed_concept_map_type` (`changed_by`),
  KEY `mapped_user_creator_concept_map_type` (`creator`),
  KEY `mapped_user_retired_concept_map_type` (`retired_by`),
  CONSTRAINT `mapped_user_changed_concept_map_type` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_concept_map_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired_concept_map_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_map_type`
--

LOCK TABLES `concept_map_type` WRITE;
/*!40000 ALTER TABLE `concept_map_type` DISABLE KEYS */;
INSERT INTO `concept_map_type` VALUES (1,'SAME-AS',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'35543629-7d8c-11e1-909d-c80aa9edcf4e'),(2,'NARROWER-THAN',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'43ac5109-7d8c-11e1-909d-c80aa9edcf4e'),(3,'BROADER-THAN',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'4b9d9421-7d8c-11e1-909d-c80aa9edcf4e'),(4,'Associated finding',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'55e02065-7d8c-11e1-909d-c80aa9edcf4e'),(5,'Associated morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'605f4a61-7d8c-11e1-909d-c80aa9edcf4e'),(6,'Associated procedure',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'6eb1bfce-7d8c-11e1-909d-c80aa9edcf4e'),(7,'Associated with',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'781bdc8f-7d8c-11e1-909d-c80aa9edcf4e'),(8,'Causative agent',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'808f9e19-7d8c-11e1-909d-c80aa9edcf4e'),(9,'Finding site',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'889c3013-7d8c-11e1-909d-c80aa9edcf4e'),(10,'Has specimen',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'929600b9-7d8c-11e1-909d-c80aa9edcf4e'),(11,'Laterality',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'999c6fc0-7d8c-11e1-909d-c80aa9edcf4e'),(12,'Severity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,0,0,NULL,NULL,NULL,'a0e52281-7d8c-11e1-909d-c80aa9edcf4e'),(13,'Access',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f9e90b29-7d8c-11e1-909d-c80aa9edcf4e'),(14,'After',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'01b60e29-7d8d-11e1-909d-c80aa9edcf4e'),(15,'Clinical course',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5f7c3702-7d8d-11e1-909d-c80aa9edcf4e'),(16,'Component',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'67debecc-7d8d-11e1-909d-c80aa9edcf4e'),(17,'Direct device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'718c00da-7d8d-11e1-909d-c80aa9edcf4e'),(18,'Direct morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7b9509cb-7d8d-11e1-909d-c80aa9edcf4e'),(19,'Direct substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'82bb495d-7d8d-11e1-909d-c80aa9edcf4e'),(20,'Due to',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8b77f7d3-7d8d-11e1-909d-c80aa9edcf4e'),(21,'Episodicity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'94a81179-7d8d-11e1-909d-c80aa9edcf4e'),(22,'Finding context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'9d23c22e-7d8d-11e1-909d-c80aa9edcf4e'),(23,'Finding informer',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a4524368-7d8d-11e1-909d-c80aa9edcf4e'),(24,'Finding method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'af089254-7d8d-11e1-909d-c80aa9edcf4e'),(25,'Has active ingredient',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b65aa605-7d8d-11e1-909d-c80aa9edcf4e'),(26,'Has definitional manifestation',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c2b7b2fa-7d8d-11e1-909d-c80aa9edcf4'),(27,'Has dose form',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'cc3878e6-7d8d-11e1-909d-c80aa9edcf4e'),(28,'Has focus',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d67c5840-7d8d-11e1-909d-c80aa9edcf4e'),(29,'Has intent',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'de2fb2c5-7d8d-11e1-909d-c80aa9edcf4e'),(30,'Has interpretation',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e758838b-7d8d-11e1-909d-c80aa9edcf4e'),(31,'Indirect device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ee63c142-7d8d-11e1-909d-c80aa9edcf4e'),(32,'Indirect morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f4f36681-7d8d-11e1-909d-c80aa9edcf4e'),(33,'Interprets',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fc7f5fed-7d8d-11e1-909d-c80aa9edcf4e'),(34,'Measurement method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06b11d79-7d8e-11e1-909d-c80aa9edcf4e'),(35,'Method',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0efb4753-7d8e-11e1-909d-c80aa9edcf4e'),(36,'Occurrence',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'16e7b617-7d8e-11e1-909d-c80aa9edcf4e'),(37,'Part of',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1e82007b-7d8e-11e1-909d-c80aa9edcf4e'),(38,'Pathological process',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2969915e-7d8e-11e1-909d-c80aa9edcf4e'),(39,'Priority',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32d57796-7d8e-11e1-909d-c80aa9edcf4e'),(40,'Procedure context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3f11904c-7d8e-11e1-909d-c80aa9edcf4e'),(41,'Procedure device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'468c4aa3-7d8e-11e1-909d-c80aa9edcf4e'),(42,'Procedure morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5383e889-7d8e-11e1-909d-c80aa9edcf4e'),(43,'Procedure site',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'5ad2655d-7d8e-11e1-909d-c80aa9edcf4e'),(44,'Procedure site - Direct',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'66085196-7d8e-11e1-909d-c80aa9edcf4e'),(45,'Procedure site - Indirect',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7080e843-7d8e-11e1-909d-c80aa9edcf4e'),(46,'Property',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'76bfb796-7d8e-11e1-909d-c80aa9edcf4e'),(47,'Recipient category',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'7e7d00e4-7d8e-11e1-909d-c80aa9edcf4e'),(48,'Revision status',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'851e14c1-7d8e-11e1-909d-c80aa9edcf4e'),(49,'Route of administration',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'8ee5b13d-7d8e-11e1-909d-c80aa9edcf4e'),(50,'Scale type',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'986acf48-7d8e-11e1-909d-c80aa9edcf4e'),(51,'Specimen procedure',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'a6937642-7d8e-11e1-909d-c80aa9edcf4e'),(52,'Specimen source identity',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b1d6941e-7d8e-11e1-909d-c80aa9edcf4e'),(53,'Specimen source morphology',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'b7c793c1-7d8e-11e1-909d-c80aa9edcf4e'),(54,'Specimen source topography',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'be9f9eb8-7d8e-11e1-909d-c80aa9edcf4e'),(55,'Specimen substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'c8f2bacb-7d8e-11e1-909d-c80aa9edcf4e'),(56,'Subject of information',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'d0664c4f-7d8e-11e1-909d-c80aa9edcf4e'),(57,'Subject relationship context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'dace9d13-7d8e-11e1-909d-c80aa9edcf4e'),(58,'Surgical approach',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'e3cd666d-7d8e-11e1-909d-c80aa9edcf4e'),(59,'Temporal context',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'ed96447d-7d8e-11e1-909d-c80aa9edcf4e'),(60,'Time aspect',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'f415bcce-7d8e-11e1-909d-c80aa9edcf4e'),(61,'Using access device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'fa9538a9-7d8e-11e1-909d-c80aa9edcf4e'),(62,'Using device',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'06588655-7d8f-11e1-909d-c80aa9edcf4e'),(63,'Using energy',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'0c2ae0bc-7d8f-11e1-909d-c80aa9edcf4e'),(64,'Using substance',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'13d2c607-7d8f-11e1-909d-c80aa9edcf4e'),(65,'IS A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'1ce7a784-7d8f-11e1-909d-c80aa9edcf4e'),(66,'MAY BE A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'267812a3-7d8f-11e1-909d-c80aa9edcf4e'),(67,'MOVED FROM',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'2de3168e-7d8f-11e1-909d-c80aa9edcf4e'),(68,'MOVED TO',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'32f0fd99-7d8f-11e1-909d-c80aa9edcf4e'),(69,'REPLACED BY',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'3b3b9a7d-7d8f-11e1-909d-c80aa9edcf4e'),(70,'WAS A',NULL,1,'2018-06-04 00:00:00',NULL,NULL,1,0,NULL,NULL,NULL,'41a034da-7d8f-11e1-909d-c80aa9edcf4e');
/*!40000 ALTER TABLE `concept_map_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name`
--

DROP TABLE IF EXISTS `concept_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name` (
  `concept_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `locale` varchar(50) NOT NULL DEFAULT '',
  `locale_preferred` tinyint(1) DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `concept_name_type` varchar(50) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_changed_by` (`changed_by`),
  KEY `name_for_concept` (`concept_id`),
  KEY `name_of_concept` (`name`),
  KEY `user_who_created_name` (`creator`),
  KEY `user_who_voided_this_name` (`voided_by`),
  CONSTRAINT `concept_name_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `name_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_this_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name`
--

LOCK TABLES `concept_name` WRITE;
/*!40000 ALTER TABLE `concept_name` DISABLE KEYS */;
INSERT INTO `concept_name` VALUES (1,1,'Verdadeiro','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'7561f550-ccee-43b6-bcf4-269992d6c284',NULL,NULL),(2,1,'Sim','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'89522273-55b5-4c4a-8e0b-cc7a66f3f3aa',NULL,NULL),(3,1,'True','en',1,1,'2018-06-04 18:29:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'111eb000-3113-4d74-9d9b-98ae5d566a98',NULL,NULL),(4,1,'Yes','en',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'a31778d2-53ab-4c4b-a333-a0149d1c25c6',NULL,NULL),(5,1,'Vero','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'a069d777-3999-4bb4-8217-d4fae1f337bc',NULL,NULL),(6,1,'Sì','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'f16c811c-d970-4f02-be47-0c7afea9eddc',NULL,NULL),(7,1,'Vrai','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'bb75175c-5d1b-492a-8c38-98506e2e6b2d',NULL,NULL),(8,1,'Oui','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'c4c4b0f6-c80c-410b-9f48-72b683072184',NULL,NULL),(9,1,'Verdadero','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'bf9ace2a-ff96-44fc-b529-172f5c3ac0b0',NULL,NULL),(10,1,'Sí','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'b58d53a3-c6dd-469a-8db1-0a80dfe4c542',NULL,NULL),(11,2,'Falso','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'2553457e-849d-4a5c-9824-2f0a9ba79461',NULL,NULL),(12,2,'Não','pt',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'38a0828c-c54e-4bdb-8217-defb0fdfc4b6',NULL,NULL),(13,2,'False','en',1,1,'2018-06-04 18:29:58','FULLY_SPECIFIED',0,NULL,NULL,NULL,'ac6d888e-dc00-4402-9a2a-576438161f96',NULL,NULL),(14,2,'No','en',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'17a5cdd3-a0a9-406a-b39f-5cd7e8d634c4',NULL,NULL),(15,2,'Falso','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'026e4e70-28c5-458d-8bbf-be7abaf09519',NULL,NULL),(16,2,'No','it',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'23851ffa-da5d-4086-8107-e0318b4d26eb',NULL,NULL),(17,2,'Faux','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'5709a1b5-b3de-472f-bf7a-eb57c5cb7144',NULL,NULL),(18,2,'Non','fr',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'3990b17b-22a0-4b66-9d06-1645030e6b60',NULL,NULL),(19,2,'Falso','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'ae3cf994-72e1-471d-9af0-96dace0b6787',NULL,NULL),(20,2,'No','es',0,1,'2018-06-04 18:29:58',NULL,0,NULL,NULL,NULL,'72071f05-d7e2-4687-ac2e-c7d9809d888a',NULL,NULL);
/*!40000 ALTER TABLE `concept_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag`
--

DROP TABLE IF EXISTS `concept_name_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag` (
  `concept_name_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_name_tag_id`),
  UNIQUE KEY `tag` (`tag`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_name_tag_changed_by` (`changed_by`),
  KEY `user_who_created_name_tag` (`creator`),
  KEY `user_who_voided_name_tag` (`voided_by`),
  CONSTRAINT `concept_name_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag`
--

LOCK TABLES `concept_name_tag` WRITE;
/*!40000 ALTER TABLE `concept_name_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_name_tag_map`
--

DROP TABLE IF EXISTS `concept_name_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_name_tag_map` (
  `concept_name_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_name` (`concept_name_id`),
  KEY `mapped_concept_name_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_name` FOREIGN KEY (`concept_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_name_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_name_tag_map`
--

LOCK TABLES `concept_name_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_name_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_name_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_numeric`
--

DROP TABLE IF EXISTS `concept_numeric`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_numeric` (
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `hi_absolute` double DEFAULT NULL,
  `hi_critical` double DEFAULT NULL,
  `hi_normal` double DEFAULT NULL,
  `low_absolute` double DEFAULT NULL,
  `low_critical` double DEFAULT NULL,
  `low_normal` double DEFAULT NULL,
  `units` varchar(50) DEFAULT NULL,
  `allow_decimal` tinyint(1) DEFAULT NULL,
  `display_precision` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_id`),
  CONSTRAINT `numeric_attributes` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_numeric`
--

LOCK TABLES `concept_numeric` WRITE;
/*!40000 ALTER TABLE `concept_numeric` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_numeric` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal`
--

DROP TABLE IF EXISTS `concept_proposal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal` (
  `concept_proposal_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `original_text` varchar(255) NOT NULL DEFAULT '',
  `final_text` varchar(255) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `obs_concept_id` int(11) DEFAULT NULL,
  `state` varchar(32) NOT NULL DEFAULT 'UNMAPPED',
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `locale` varchar(50) NOT NULL DEFAULT '',
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_proposal_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_proposal` (`concept_id`),
  KEY `encounter_for_proposal` (`encounter_id`),
  KEY `proposal_obs_concept_id` (`obs_concept_id`),
  KEY `proposal_obs_id` (`obs_id`),
  KEY `user_who_changed_proposal` (`changed_by`),
  KEY `user_who_created_proposal` (`creator`),
  CONSTRAINT `concept_for_proposal` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_for_proposal` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_concept_id` FOREIGN KEY (`obs_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `proposal_obs_id` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_proposal` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_proposal` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal`
--

LOCK TABLES `concept_proposal` WRITE;
/*!40000 ALTER TABLE `concept_proposal` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_proposal_tag_map`
--

DROP TABLE IF EXISTS `concept_proposal_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_proposal_tag_map` (
  `concept_proposal_id` int(11) NOT NULL,
  `concept_name_tag_id` int(11) NOT NULL,
  KEY `mapped_concept_proposal` (`concept_proposal_id`),
  KEY `mapped_concept_proposal_tag` (`concept_name_tag_id`),
  CONSTRAINT `mapped_concept_proposal` FOREIGN KEY (`concept_proposal_id`) REFERENCES `concept_proposal` (`concept_proposal_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_proposal_tag` FOREIGN KEY (`concept_name_tag_id`) REFERENCES `concept_name_tag` (`concept_name_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_proposal_tag_map`
--

LOCK TABLES `concept_proposal_tag_map` WRITE;
/*!40000 ALTER TABLE `concept_proposal_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_proposal_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_map`
--

DROP TABLE IF EXISTS `concept_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_map` (
  `concept_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_reference_term_id` int(11) NOT NULL,
  `concept_map_type_id` int(11) NOT NULL DEFAULT 1,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `map_creator` (`creator`),
  KEY `map_for_concept` (`concept_id`),
  KEY `mapped_concept_map_type` (`concept_map_type_id`),
  KEY `mapped_concept_reference_term` (`concept_reference_term_id`),
  KEY `mapped_user_changed_ref_term` (`changed_by`),
  CONSTRAINT `map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `map_for_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_map_type` FOREIGN KEY (`concept_map_type_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_concept_reference_term` FOREIGN KEY (`concept_reference_term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_map`
--

LOCK TABLES `concept_reference_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_source`
--

DROP TABLE IF EXISTS `concept_reference_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_source` (
  `concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hl7_code` varchar(50) DEFAULT '',
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `unique_id` varchar(250) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`concept_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `hl7_code` (`hl7_code`),
  UNIQUE KEY `unique_id` (`unique_id`),
  KEY `concept_reference_source_changed_by` (`changed_by`),
  KEY `concept_source_creator` (`creator`),
  KEY `user_who_retired_concept_source` (`retired_by`),
  CONSTRAINT `concept_reference_source_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_source_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_concept_source` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_source`
--

LOCK TABLES `concept_reference_source` WRITE;
/*!40000 ALTER TABLE `concept_reference_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term`
--

DROP TABLE IF EXISTS `concept_reference_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term` (
  `concept_reference_term_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `version` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `idx_code_concept_reference_term` (`code`),
  KEY `mapped_concept_source` (`concept_source_id`),
  KEY `mapped_user_changed` (`changed_by`),
  KEY `mapped_user_creator` (`creator`),
  KEY `mapped_user_retired` (`retired_by`),
  CONSTRAINT `mapped_concept_source` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_retired` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term`
--

LOCK TABLES `concept_reference_term` WRITE;
/*!40000 ALTER TABLE `concept_reference_term` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_reference_term_map`
--

DROP TABLE IF EXISTS `concept_reference_term_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_reference_term_map` (
  `concept_reference_term_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `term_a_id` int(11) NOT NULL,
  `term_b_id` int(11) NOT NULL,
  `a_is_to_b_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_reference_term_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `mapped_concept_map_type_ref_term_map` (`a_is_to_b_id`),
  KEY `mapped_term_a` (`term_a_id`),
  KEY `mapped_term_b` (`term_b_id`),
  KEY `mapped_user_changed_ref_term_map` (`changed_by`),
  KEY `mapped_user_creator_ref_term_map` (`creator`),
  CONSTRAINT `mapped_concept_map_type_ref_term_map` FOREIGN KEY (`a_is_to_b_id`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_a` FOREIGN KEY (`term_a_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_term_b` FOREIGN KEY (`term_b_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_changed_ref_term_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `mapped_user_creator_ref_term_map` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_reference_term_map`
--

LOCK TABLES `concept_reference_term_map` WRITE;
/*!40000 ALTER TABLE `concept_reference_term_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_reference_term_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_set`
--

DROP TABLE IF EXISTS `concept_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_set` (
  `concept_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `concept_set` int(11) NOT NULL DEFAULT 0,
  `sort_weight` double DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `has_a` (`concept_set`),
  KEY `idx_concept_set_concept` (`concept_id`),
  KEY `user_who_created` (`creator`),
  CONSTRAINT `has_a` FOREIGN KEY (`concept_set`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_set`
--

LOCK TABLES `concept_set` WRITE;
/*!40000 ALTER TABLE `concept_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_state_conversion`
--

DROP TABLE IF EXISTS `concept_state_conversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_state_conversion` (
  `concept_state_conversion_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) DEFAULT 0,
  `program_workflow_id` int(11) DEFAULT 0,
  `program_workflow_state_id` int(11) DEFAULT 0,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_state_conversion_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_workflow_concept_in_conversion` (`program_workflow_id`,`concept_id`),
  KEY `concept_triggers_conversion` (`concept_id`),
  KEY `conversion_to_state` (`program_workflow_state_id`),
  CONSTRAINT `concept_triggers_conversion` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_involves_workflow` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conversion_to_state` FOREIGN KEY (`program_workflow_state_id`) REFERENCES `program_workflow_state` (`program_workflow_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_state_conversion`
--

LOCK TABLES `concept_state_conversion` WRITE;
/*!40000 ALTER TABLE `concept_state_conversion` DISABLE KEYS */;
/*!40000 ALTER TABLE `concept_state_conversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `concept_stop_word`
--

DROP TABLE IF EXISTS `concept_stop_word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `concept_stop_word` (
  `concept_stop_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) NOT NULL,
  `locale` varchar(50) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`concept_stop_word_id`),
  UNIQUE KEY `Unique_StopWord_Key` (`word`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `concept_stop_word`
--

LOCK TABLES `concept_stop_word` WRITE;
/*!40000 ALTER TABLE `concept_stop_word` DISABLE KEYS */;
INSERT INTO `concept_stop_word` VALUES (1,'A','en','f5f45540-e2a7-11df-87ae-18a905e044dc'),(2,'AND','en','f5f469ae-e2a7-11df-87ae-18a905e044dc'),(3,'AT','en','f5f47070-e2a7-11df-87ae-18a905e044dc'),(4,'BUT','en','f5f476c4-e2a7-11df-87ae-18a905e044dc'),(5,'BY','en','f5f47d04-e2a7-11df-87ae-18a905e044dc'),(6,'FOR','en','f5f4834e-e2a7-11df-87ae-18a905e044dc'),(7,'HAS','en','f5f48a24-e2a7-11df-87ae-18a905e044dc'),(8,'OF','en','f5f49064-e2a7-11df-87ae-18a905e044dc'),(9,'THE','en','f5f496ae-e2a7-11df-87ae-18a905e044dc'),(10,'TO','en','f5f49cda-e2a7-11df-87ae-18a905e044dc');
/*!40000 ALTER TABLE `concept_stop_word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `condition_id` int(11) NOT NULL AUTO_INCREMENT,
  `additional_detail` varchar(255) DEFAULT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `condition_coded` int(11) DEFAULT NULL,
  `condition_non_coded` varchar(255) DEFAULT NULL,
  `condition_coded_name` int(11) DEFAULT NULL,
  `clinical_status` varchar(50) NOT NULL,
  `verification_status` varchar(50) DEFAULT NULL,
  `onset_date` datetime DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`condition_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `condition_changed_by_fk` (`changed_by`),
  KEY `condition_condition_coded_fk` (`condition_coded`),
  KEY `condition_condition_coded_name_fk` (`condition_coded_name`),
  KEY `condition_creator_fk` (`creator`),
  KEY `condition_patient_fk` (`patient_id`),
  KEY `condition_previous_version_fk` (`previous_version`),
  KEY `condition_voided_by_fk` (`voided_by`),
  KEY `conditions_encounter_id_fk` (`encounter_id`),
  CONSTRAINT `condition_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_fk` FOREIGN KEY (`condition_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_condition_coded_name_fk` FOREIGN KEY (`condition_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_previous_version_fk` FOREIGN KEY (`previous_version`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `condition_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `conditions_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `combination` tinyint(1) NOT NULL DEFAULT 0,
  `dosage_form` int(11) DEFAULT NULL,
  `maximum_daily_dose` double DEFAULT NULL,
  `minimum_daily_dose` double DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `strength` varchar(255) DEFAULT NULL,
  `dose_limit_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `dosage_form_concept` (`dosage_form`),
  KEY `drug_changed_by` (`changed_by`),
  KEY `drug_creator` (`creator`),
  KEY `drug_dose_limit_units_fk` (`dose_limit_units`),
  KEY `drug_retired_by` (`retired_by`),
  KEY `primary_drug_concept` (`concept_id`),
  KEY `route_concept` (`route`),
  CONSTRAINT `dosage_form_concept` FOREIGN KEY (`dosage_form`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_dose_limit_units_fk` FOREIGN KEY (`dose_limit_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `primary_drug_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `route_concept` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_ingredient`
--

DROP TABLE IF EXISTS `drug_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_ingredient` (
  `drug_id` int(11) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `strength` double DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  PRIMARY KEY (`drug_id`,`ingredient_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `drug_ingredient_ingredient_id_fk` (`ingredient_id`),
  KEY `drug_ingredient_units_fk` (`units`),
  CONSTRAINT `drug_ingredient_drug_id_fk` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_ingredient_id_fk` FOREIGN KEY (`ingredient_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_ingredient_units_fk` FOREIGN KEY (`units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_ingredient`
--

LOCK TABLES `drug_ingredient` WRITE;
/*!40000 ALTER TABLE `drug_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_order`
--

DROP TABLE IF EXISTS `drug_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_order` (
  `order_id` int(11) NOT NULL DEFAULT 0,
  `drug_inventory_id` int(11) DEFAULT NULL,
  `dose` double DEFAULT NULL,
  `as_needed` tinyint(1) DEFAULT NULL,
  `dosing_type` varchar(255) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `as_needed_condition` varchar(255) DEFAULT NULL,
  `num_refills` int(11) DEFAULT NULL,
  `dosing_instructions` text DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `duration_units` int(11) DEFAULT NULL,
  `quantity_units` int(11) DEFAULT NULL,
  `route` int(11) DEFAULT NULL,
  `dose_units` int(11) DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `dispense_as_written` tinyint(1) NOT NULL DEFAULT 0,
  `drug_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `drug_order_dose_units` (`dose_units`),
  KEY `drug_order_duration_units_fk` (`duration_units`),
  KEY `drug_order_frequency_fk` (`frequency`),
  KEY `drug_order_quantity_units` (`quantity_units`),
  KEY `drug_order_route_fk` (`route`),
  KEY `inventory_item` (`drug_inventory_id`),
  CONSTRAINT `drug_order_dose_units` FOREIGN KEY (`dose_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_duration_units_fk` FOREIGN KEY (`duration_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_quantity_units` FOREIGN KEY (`quantity_units`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_order_route_fk` FOREIGN KEY (`route`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `extends_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `inventory_item` FOREIGN KEY (`drug_inventory_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_order`
--

LOCK TABLES `drug_order` WRITE;
/*!40000 ALTER TABLE `drug_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug_reference_map`
--

DROP TABLE IF EXISTS `drug_reference_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug_reference_map` (
  `drug_reference_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `term_id` int(11) NOT NULL,
  `concept_map_type` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`drug_reference_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_map_type_for_drug_reference_map` (`concept_map_type`),
  KEY `concept_reference_term_for_drug_reference_map` (`term_id`),
  KEY `drug_for_drug_reference_map` (`drug_id`),
  KEY `drug_reference_map_creator` (`creator`),
  KEY `user_who_changed_drug_reference_map` (`changed_by`),
  KEY `user_who_retired_drug_reference_map` (`retired_by`),
  CONSTRAINT `concept_map_type_for_drug_reference_map` FOREIGN KEY (`concept_map_type`) REFERENCES `concept_map_type` (`concept_map_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `concept_reference_term_for_drug_reference_map` FOREIGN KEY (`term_id`) REFERENCES `concept_reference_term` (`concept_reference_term_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_for_drug_reference_map` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_reference_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_drug_reference_map` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_drug_reference_map` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug_reference_map`
--

LOCK TABLES `drug_reference_map` WRITE;
/*!40000 ALTER TABLE `drug_reference_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `drug_reference_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_type` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL DEFAULT 0,
  `location_id` int(11) DEFAULT NULL,
  `form_id` int(11) DEFAULT NULL,
  `encounter_datetime` datetime NOT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_changed_by` (`changed_by`),
  KEY `encounter_datetime_idx` (`encounter_datetime`),
  KEY `encounter_form` (`form_id`),
  KEY `encounter_ibfk_1` (`creator`),
  KEY `encounter_location` (`location_id`),
  KEY `encounter_patient` (`patient_id`),
  KEY `encounter_type_id` (`encounter_type`),
  KEY `encounter_visit_id_fk` (`visit_id`),
  KEY `user_who_voided_encounter` (`voided_by`),
  CONSTRAINT `encounter_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_form` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `encounter_type_id` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_visit_id_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_encounter` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_diagnosis`
--

DROP TABLE IF EXISTS `encounter_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_diagnosis` (
  `diagnosis_id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_coded` int(11) DEFAULT NULL,
  `diagnosis_non_coded` varchar(255) DEFAULT NULL,
  `diagnosis_coded_name` int(11) DEFAULT NULL,
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `condition_id` int(11) DEFAULT NULL,
  `certainty` varchar(255) NOT NULL,
  `rank` int(11) NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`diagnosis_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_diagnosis_changed_by_fk` (`changed_by`),
  KEY `encounter_diagnosis_coded_fk` (`diagnosis_coded`),
  KEY `encounter_diagnosis_coded_name_fk` (`diagnosis_coded_name`),
  KEY `encounter_diagnosis_condition_id_fk` (`condition_id`),
  KEY `encounter_diagnosis_creator_fk` (`creator`),
  KEY `encounter_diagnosis_encounter_id_fk` (`encounter_id`),
  KEY `encounter_diagnosis_patient_fk` (`patient_id`),
  KEY `encounter_diagnosis_voided_by_fk` (`voided_by`),
  CONSTRAINT `encounter_diagnosis_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_fk` FOREIGN KEY (`diagnosis_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_coded_name_fk` FOREIGN KEY (`diagnosis_coded_name`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_condition_id_fk` FOREIGN KEY (`condition_id`) REFERENCES `conditions` (`condition_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_diagnosis_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_diagnosis`
--

LOCK TABLES `encounter_diagnosis` WRITE;
/*!40000 ALTER TABLE `encounter_diagnosis` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_diagnosis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_provider`
--

DROP TABLE IF EXISTS `encounter_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_provider` (
  `encounter_provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `encounter_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `encounter_role_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `date_voided` datetime DEFAULT NULL,
  `voided_by` int(11) DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_id_fk` (`encounter_id`),
  KEY `encounter_provider_changed_by` (`changed_by`),
  KEY `encounter_provider_creator` (`creator`),
  KEY `encounter_provider_voided_by` (`voided_by`),
  KEY `encounter_role_id_fk` (`encounter_role_id`),
  KEY `provider_id_fk` (`provider_id`),
  CONSTRAINT `encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_provider_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_id_fk` FOREIGN KEY (`encounter_role_id`) REFERENCES `encounter_role` (`encounter_role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_id_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_provider`
--

LOCK TABLES `encounter_provider` WRITE;
/*!40000 ALTER TABLE `encounter_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_role`
--

DROP TABLE IF EXISTS `encounter_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_role` (
  `encounter_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`encounter_role_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_role_changed_by_fk` (`changed_by`),
  KEY `encounter_role_creator_fk` (`creator`),
  KEY `encounter_role_retired_by_fk` (`retired_by`),
  CONSTRAINT `encounter_role_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_role_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_role`
--

LOCK TABLES `encounter_role` WRITE;
/*!40000 ALTER TABLE `encounter_role` DISABLE KEYS */;
INSERT INTO `encounter_role` VALUES (1,'Unknown','Unknown encounter role for legacy providers with no encounter role set',1,'2011-08-18 14:00:00',NULL,NULL,0,NULL,NULL,NULL,'a0b03050-c99b-11e0-9572-0800200c9a66');
/*!40000 ALTER TABLE `encounter_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_type`
--

DROP TABLE IF EXISTS `encounter_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter_type` (
  `encounter_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `view_privilege` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`encounter_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_type_changed_by` (`changed_by`),
  KEY `encounter_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit_encounter_type` (`edit_privilege`),
  KEY `privilege_which_can_view_encounter_type` (`view_privilege`),
  KEY `user_who_created_type` (`creator`),
  KEY `user_who_retired_encounter_type` (`retired_by`),
  CONSTRAINT `encounter_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit_encounter_type` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_view_encounter_type` FOREIGN KEY (`view_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_encounter_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_type`
--

LOCK TABLES `encounter_type` WRITE;
/*!40000 ALTER TABLE `encounter_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_concept_source`
--

DROP TABLE IF EXISTS `fhir_concept_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_concept_source` (
  `fhir_concept_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_source_id` int(11) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  PRIMARY KEY (`fhir_concept_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_concept_source_concept_reference_source_fk` (`concept_source_id`),
  KEY `fhir_concept_source_creator_fk` (`creator`),
  KEY `fhir_concept_source_changed_by_fk` (`changed_by`),
  KEY `fhir_concept_source_retired_by_fk` (`retired_by`),
  CONSTRAINT `fhir_concept_source_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_concept_source_concept_reference_source_fk` FOREIGN KEY (`concept_source_id`) REFERENCES `concept_reference_source` (`concept_source_id`),
  CONSTRAINT `fhir_concept_source_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_concept_source_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_concept_source`
--

LOCK TABLES `fhir_concept_source` WRITE;
/*!40000 ALTER TABLE `fhir_concept_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_concept_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report` (
  `diagnostic_report_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_diagnostic_report_creator` (`creator`),
  KEY `fhir_diagnostic_report_changed_by` (`changed_by`),
  KEY `fhir_diagnostic_report_voided_by` (`voided_by`),
  KEY `fhir_diagnostic_report_code` (`concept_id`),
  KEY `fhir_diagnostic_report_subject` (`subject_id`),
  KEY `fhir_diagnostic_report_encounter` (`encounter_id`),
  CONSTRAINT `fhir_diagnostic_report_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_diagnostic_report_code` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `fhir_diagnostic_report_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_diagnostic_report_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`),
  CONSTRAINT `fhir_diagnostic_report_subject` FOREIGN KEY (`subject_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fhir_diagnostic_report_voided_by` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report`
--

LOCK TABLES `fhir_diagnostic_report` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report_performers`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report_performers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report_performers` (
  `diagnostic_report_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`,`provider_id`),
  KEY `fhir_diagnostic_report_performers_reference` (`provider_id`),
  CONSTRAINT `fhir_diagnostic_report_performers_diagnostic_report` FOREIGN KEY (`diagnostic_report_id`) REFERENCES `fhir_diagnostic_report` (`diagnostic_report_id`),
  CONSTRAINT `fhir_diagnostic_report_performers_reference` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report_performers`
--

LOCK TABLES `fhir_diagnostic_report_performers` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report_performers` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report_performers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_diagnostic_report_results`
--

DROP TABLE IF EXISTS `fhir_diagnostic_report_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_diagnostic_report_results` (
  `diagnostic_report_id` int(11) NOT NULL,
  `obs_id` int(11) NOT NULL,
  PRIMARY KEY (`diagnostic_report_id`,`obs_id`),
  KEY `fhir_diagnostic_report_results_reference` (`obs_id`),
  CONSTRAINT `fhir_diagnostic_report_results_diagnostic_report` FOREIGN KEY (`diagnostic_report_id`) REFERENCES `fhir_diagnostic_report` (`diagnostic_report_id`),
  CONSTRAINT `fhir_diagnostic_report_results_reference` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_diagnostic_report_results`
--

LOCK TABLES `fhir_diagnostic_report_results` WRITE;
/*!40000 ALTER TABLE `fhir_diagnostic_report_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_diagnostic_report_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_encounter_class_map`
--

DROP TABLE IF EXISTS `fhir_encounter_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_encounter_class_map` (
  `encounter_class_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  `encounter_class` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(36) NOT NULL,
  PRIMARY KEY (`encounter_class_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_encounter_class_map_creator` (`creator`),
  KEY `fhir_encounter_class_map_changed_by` (`changed_by`),
  KEY `fhir_encounter_class_map_retired_by` (`retired_by`),
  KEY `fhir_encounter_class_map_location` (`location_id`),
  CONSTRAINT `fhir_encounter_class_map_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_encounter_class_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_encounter_class_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `fhir_encounter_class_map_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_encounter_class_map`
--

LOCK TABLES `fhir_encounter_class_map` WRITE;
/*!40000 ALTER TABLE `fhir_encounter_class_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_encounter_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_observation_category_map`
--

DROP TABLE IF EXISTS `fhir_observation_category_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_observation_category_map` (
  `observation_category_map_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_class_id` int(11) DEFAULT NULL,
  `observation_category` varchar(255) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(36) NOT NULL,
  PRIMARY KEY (`observation_category_map_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_observation_category_map_creator` (`creator`),
  KEY `fhir_observation_category_map_changed_by` (`changed_by`),
  KEY `fhir_observation_category_map_retired_by` (`retired_by`),
  KEY `fhir_observation_category_map_concept_class` (`concept_class_id`),
  KEY `fhir_observation_category_map_observation_category` (`observation_category`),
  CONSTRAINT `fhir_observation_category_map_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_observation_category_map_concept_class` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`),
  CONSTRAINT `fhir_observation_category_map_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_observation_category_map_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_observation_category_map`
--

LOCK TABLES `fhir_observation_category_map` WRITE;
/*!40000 ALTER TABLE `fhir_observation_category_map` DISABLE KEYS */;
INSERT INTO `fhir_observation_category_map` VALUES (1,1,'laboratory',1,'2021-04-19 09:48:04',NULL,NULL,0,NULL,NULL,NULL,'92b06faf-a0e3-11eb-9d6a-005056bcd993'),(2,2,'procedure',1,'2021-04-19 09:48:04',NULL,NULL,0,NULL,NULL,NULL,'92b090e9-a0e3-11eb-9d6a-005056bcd993'),(3,5,'exam',1,'2021-04-19 09:48:04',NULL,NULL,0,NULL,NULL,NULL,'92b0aea0-a0e3-11eb-9d6a-005056bcd993');
/*!40000 ALTER TABLE `fhir_observation_category_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_reference`
--

DROP TABLE IF EXISTS `fhir_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_reference` (
  `reference_id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(255) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  `target_uuid` char(32) DEFAULT NULL,
  PRIMARY KEY (`reference_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `target_uuid` (`target_uuid`),
  KEY `fhir_reference_creator_fk` (`creator`),
  KEY `fhir_reference_changed_by_fk` (`changed_by`),
  KEY `fhir_reference_retired_by_fk` (`retired_by`),
  CONSTRAINT `fhir_reference_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_reference_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_reference_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_reference`
--

LOCK TABLES `fhir_reference` WRITE;
/*!40000 ALTER TABLE `fhir_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task`
--

DROP TABLE IF EXISTS `fhir_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) NOT NULL DEFAULT 'UNKNOWN',
  `status_reason` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `intent` varchar(255) NOT NULL,
  `owner_reference_id` int(11) DEFAULT NULL,
  `encounter_reference_id` int(11) DEFAULT NULL,
  `for_reference_id` int(11) DEFAULT NULL,
  `based_on` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `task_creator` (`creator`),
  KEY `task_changed_by` (`changed_by`),
  KEY `fhir_task_retired_by_fk` (`retired_by`),
  KEY `task_owner_reference_fk` (`owner_reference_id`),
  KEY `task_for_reference_fk` (`for_reference_id`),
  KEY `task_encounter_reference_fk` (`encounter_reference_id`),
  CONSTRAINT `fhir_task_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `task_encounter_reference_fk` FOREIGN KEY (`encounter_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_for_reference_fk` FOREIGN KEY (`for_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_owner_reference_fk` FOREIGN KEY (`owner_reference_id`) REFERENCES `fhir_reference` (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task`
--

LOCK TABLES `fhir_task` WRITE;
/*!40000 ALTER TABLE `fhir_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_based_on_reference`
--

DROP TABLE IF EXISTS `fhir_task_based_on_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_based_on_reference` (
  `task_id` int(11) NOT NULL,
  `reference_id` int(11) NOT NULL,
  UNIQUE KEY `reference_id` (`reference_id`),
  KEY `task_based_on_fk` (`task_id`),
  CONSTRAINT `reference_based_on_fk` FOREIGN KEY (`reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `task_based_on_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_based_on_reference`
--

LOCK TABLES `fhir_task_based_on_reference` WRITE;
/*!40000 ALTER TABLE `fhir_task_based_on_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_based_on_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_input`
--

DROP TABLE IF EXISTS `fhir_task_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_input` (
  `task_input_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_text` varchar(255) DEFAULT NULL,
  `value_reference_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  PRIMARY KEY (`task_input_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_task_input_creator_fk` (`creator`),
  KEY `fhir_task_input_changed_by_fk` (`changed_by`),
  KEY `fhir_task_input_retired_by_fk` (`retired_by`),
  KEY `input_type_fk` (`type_id`),
  KEY `input_reference_fk` (`value_reference_id`),
  KEY `input_task_fk` (`task_id`),
  CONSTRAINT `fhir_task_input_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_input_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_input_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `input_reference_fk` FOREIGN KEY (`value_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `input_task_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`),
  CONSTRAINT `input_type_fk` FOREIGN KEY (`type_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_input`
--

LOCK TABLES `fhir_task_input` WRITE;
/*!40000 ALTER TABLE `fhir_task_input` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_input` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fhir_task_output`
--

DROP TABLE IF EXISTS `fhir_task_output`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fhir_task_output` (
  `task_output_id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_text` varchar(255) DEFAULT NULL,
  `value_reference_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` varchar(38) NOT NULL,
  PRIMARY KEY (`task_output_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `fhir_task_output_creator_fk` (`creator`),
  KEY `fhir_task_output_changed_by_fk` (`changed_by`),
  KEY `fhir_task_output_retired_by_fk` (`retired_by`),
  KEY `output_type_fk` (`type_id`),
  KEY `output_reference_fk` (`value_reference_id`),
  KEY `output_task_fk` (`task_id`),
  CONSTRAINT `fhir_task_output_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_output_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fhir_task_output_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `output_reference_fk` FOREIGN KEY (`value_reference_id`) REFERENCES `fhir_reference` (`reference_id`),
  CONSTRAINT `output_task_fk` FOREIGN KEY (`task_id`) REFERENCES `fhir_task` (`task_id`),
  CONSTRAINT `output_type_fk` FOREIGN KEY (`type_id`) REFERENCES `concept` (`concept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fhir_task_output`
--

LOCK TABLES `fhir_task_output` WRITE;
/*!40000 ALTER TABLE `fhir_task_output` DISABLE KEYS */;
/*!40000 ALTER TABLE `fhir_task_output` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field`
--

DROP TABLE IF EXISTS `field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field` (
  `field_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `field_type` int(11) DEFAULT NULL,
  `concept_id` int(11) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `attribute_name` varchar(50) DEFAULT NULL,
  `default_value` text DEFAULT NULL,
  `select_multiple` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `concept_for_field` (`concept_id`),
  KEY `field_retired_status` (`retired`),
  KEY `type_of_field` (`field_type`),
  KEY `user_who_changed_field` (`changed_by`),
  KEY `user_who_created_field` (`creator`),
  KEY `user_who_retired_field` (`retired_by`),
  CONSTRAINT `concept_for_field` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_of_field` FOREIGN KEY (`field_type`) REFERENCES `field_type` (`field_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_field` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field`
--

LOCK TABLES `field` WRITE;
/*!40000 ALTER TABLE `field` DISABLE KEYS */;
/*!40000 ALTER TABLE `field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_answer`
--

DROP TABLE IF EXISTS `field_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_answer` (
  `field_id` int(11) NOT NULL DEFAULT 0,
  `answer_id` int(11) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_id`,`answer_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_answer_concept` (`answer_id`),
  KEY `user_who_created_field_answer` (`creator`),
  CONSTRAINT `answers_for_field` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `field_answer_concept` FOREIGN KEY (`answer_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_field_answer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_answer`
--

LOCK TABLES `field_answer` WRITE;
/*!40000 ALTER TABLE `field_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_type`
--

DROP TABLE IF EXISTS `field_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_type` (
  `field_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_set` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`field_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_field_type` (`creator`),
  CONSTRAINT `user_who_created_field_type` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_type`
--

LOCK TABLES `field_type` WRITE;
/*!40000 ALTER TABLE `field_type` DISABLE KEYS */;
INSERT INTO `field_type` VALUES (1,'Concept','',0,1,'2005-02-22 00:00:00','8d5e7d7c-c2cc-11de-8d13-0010c6dffd0f'),(2,'Database element','',0,1,'2005-02-22 00:00:00','8d5e8196-c2cc-11de-8d13-0010c6dffd0f'),(3,'Set of Concepts','',1,1,'2005-02-22 00:00:00','8d5e836c-c2cc-11de-8d13-0010c6dffd0f'),(4,'Miscellaneous Set','',1,1,'2005-02-22 00:00:00','8d5e852e-c2cc-11de-8d13-0010c6dffd0f'),(5,'Section','',1,1,'2005-02-22 00:00:00','8d5e86fa-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `field_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(50) NOT NULL DEFAULT '',
  `build` int(11) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `xslt` text DEFAULT NULL,
  `template` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `encounter_type` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retired_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `form_encounter_type` (`encounter_type`),
  KEY `form_published_and_retired_index` (`published`,`retired`),
  KEY `form_published_index` (`published`),
  KEY `form_retired_index` (`retired`),
  KEY `user_who_created_form` (`creator`),
  KEY `user_who_last_changed_form` (`changed_by`),
  KEY `user_who_retired_form` (`retired_by`),
  CONSTRAINT `form_encounter_type` FOREIGN KEY (`encounter_type`) REFERENCES `encounter_type` (`encounter_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_form` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_last_changed_form` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_form` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `form_field_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT 0,
  `field_id` int(11) NOT NULL DEFAULT 0,
  `field_number` int(11) DEFAULT NULL,
  `field_part` varchar(5) DEFAULT NULL,
  `page_number` int(11) DEFAULT NULL,
  `parent_form_field` int(11) DEFAULT NULL,
  `min_occurs` int(11) DEFAULT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `sort_weight` float DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`form_field_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `field_within_form` (`field_id`),
  KEY `form_containing_field` (`form_id`),
  KEY `form_field_hierarchy` (`parent_form_field`),
  KEY `user_who_created_form_field` (`creator`),
  KEY `user_who_last_changed_form_field` (`changed_by`),
  CONSTRAINT `field_within_form` FOREIGN KEY (`field_id`) REFERENCES `field` (`field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_containing_field` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_field_hierarchy` FOREIGN KEY (`parent_form_field`) REFERENCES `form_field` (`form_field_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_form_field` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_last_changed_form_field` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_resource`
--

DROP TABLE IF EXISTS `form_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_resource` (
  `form_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value_reference` text NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`form_resource_id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `unique_form_and_name` (`form_id`,`name`),
  KEY `form_resource_changed_by` (`changed_by`),
  CONSTRAINT `form_resource_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `form_resource_form_fk` FOREIGN KEY (`form_id`) REFERENCES `form` (`form_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_resource`
--

LOCK TABLES `form_resource` WRITE;
/*!40000 ALTER TABLE `form_resource` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `global_property`
--

DROP TABLE IF EXISTS `global_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_property` (
  `property` varchar(255) NOT NULL DEFAULT '',
  `property_value` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`property`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `global_property_changed_by` (`changed_by`),
  CONSTRAINT `global_property_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `global_property`
--

LOCK TABLES `global_property` WRITE;
/*!40000 ALTER TABLE `global_property` DISABLE KEYS */;
INSERT INTO `global_property` VALUES ('allergy.allergen.ConceptClasses','Drug,MedSet','A comma-separated list of the allowed concept classes for the allergen field of the allergy dialog','a7ecdbf2-69d1-4b0b-8f78-8d3015f67e0c',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.drug','162552AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the drug allergens concept','60839165-c080-41ee-9af7-eef9b18990f7',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.environment','162554AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the environment allergens concept','1362f403-26df-455c-b52d-9086b95ad9d7',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.allergen.food','162553AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the food allergens concept','8a0e7ef8-db7a-42f5-81d8-ad6e1d1e6238',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.otherNonCoded','5622AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy other non coded concept','b1d6323d-df06-4cad-9b3a-88ee0267e538',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.reactions','162555AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy reactions concept','180b304c-a8ae-4dbd-8c22-04ec26ee03bb',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.mild','1498AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MILD severity concept','8032b188-a1b3-4d88-9982-8e5a6de9d7fe',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.moderate','1499AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the MODERATE severity concept','63b6f25b-2805-4b4b-87b7-982244ad2786',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.severity.severe','1500AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the SEVERE severity concept','0e6d95b0-5dc4-4642-abb1-c66d9e1c6f46',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.concept.unknown','1067AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA','UUID for the allergy unknown concept','c2aec1a1-2385-4fed-bf05-0307a9c6961d',NULL,NULL,NULL,NULL,NULL,NULL),('allergy.reaction.ConceptClasses','Symptom','A comma-separated list of the allowed concept classes for the reaction field of the allergy dialog','516b740f-e67b-4dbb-8b74-9aaf927b213c',NULL,NULL,NULL,NULL,NULL,NULL),('application.name','OpenMRS','The name of this application, as presented to the user, for example on the login and welcome pages.','8052c2fb-e38c-4038-a9fb-52a9fc490252',NULL,NULL,NULL,NULL,NULL,NULL),('concept.defaultConceptMapType','NARROWER-THAN','Default concept map type which is used when no other is set','0419f733-f159-4e34-9c9c-2361396b9ed8',NULL,NULL,NULL,NULL,NULL,NULL),('concept.height','5090','Concept id of the concept defining the HEIGHT concept','38833481-ed6e-4fcc-9e47-ea76d9efd729',NULL,NULL,NULL,NULL,NULL,NULL),('concept.medicalRecordObservations','1238','The concept id of the MEDICAL_RECORD_OBSERVATIONS concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','03b17706-a6ee-42aa-af5c-4f6743a9e98c',NULL,NULL,NULL,NULL,NULL,NULL),('concept.none','1107','Concept id of the concept defining the NONE concept','25a9e682-6adc-42ac-be2d-cb25c7de7a06',NULL,NULL,NULL,NULL,NULL,NULL),('concept.otherNonCoded','5622','Concept id of the concept defining the OTHER NON-CODED concept','d1b6dbae-59d4-432f-bbd3-5fef4d613965',NULL,NULL,NULL,NULL,NULL,NULL),('concept.problemList','1284','The concept id of the PROBLEM LIST concept.  This concept_id is presumed to be the generic grouping (obr) concept in hl7 messages.  An obs_group row is not created for this concept.','b35abd8a-292f-44c1-9523-cbef0871431b',NULL,NULL,NULL,NULL,NULL,NULL),('concept.weight','5089','Concept id of the concept defining the WEIGHT concept','9a6bdc5c-43dd-43ad-82c0-e950c6960ec5',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.dosageForm.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the dosage form field of the concept drug management form.','711ddfbd-3676-4cc8-998c-0c0f8a16ad4b',NULL,NULL,NULL,NULL,NULL,NULL),('conceptDrug.route.conceptClasses',NULL,'A comma-separated list of the allowed concept classes for the route field of the concept drug management form.','ef6dfe9e-aabd-4350-81e5-da36bd11ce0b',NULL,NULL,NULL,NULL,NULL,NULL),('concepts.locked','false','if true, do not allow editing concepts','136b687b-8dce-4d08-8781-9ad702daa5d4','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('concept_map_type_management.enable','false','Enables or disables management of concept map types','fbccbd65-c489-472f-a68d-df64c59dbda9','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.maximumNumberToShow','3','An integer which, if specified, would determine the maximum number of encounters to display on the encounter tab of the patient dashboard.','f217fb0d-b43f-46a6-a002-9918e1f7d8bb',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.providerDisplayRoles',NULL,'A comma-separated list of encounter roles (by name or id). Providers with these roles in an encounter will be displayed on the encounter tab of the patient dashboard.','29df9807-5336-4a02-ba06-f794e8529d18',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEditLink','true','true/false whether or not to show the \'Edit Encounter\' link on the patient dashboard','5cf8cb57-a46e-4609-ba69-96e51fe06d75','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showEmptyFields','true','true/false whether or not to show empty fields on the \'View Encounter\' window','705643d2-daa6-4e42-970e-c81975ef8f80','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.showViewLink','true','true/false whether or not to show the \'View Encounter\' link on the patient dashboard','8190a588-0f16-47b3-b5bd-6bc9989c3ca2','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('dashboard.encounters.usePages','smart','true/false/smart on how to show the pages on the \'View Encounter\' window.  \'smart\' means that if > 50% of the fields have page numbers defined, show data in pages','54b28579-f2ef-44b7-9835-982a07774503',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.programs_to_show',NULL,'List of programs to show Enrollment details of in the patient header. (Should be an ordered comma-separated list of program_ids or names.)','07531548-7de2-4b02-b678-deaafe2e4cf8',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.showConcept','5497','Comma delimited list of concepts ids to show on the patient header overview','79ede121-61c1-4447-b551-6a903a5b61a2',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.header.workflows_to_show',NULL,'List of programs to show Enrollment details of in the patient header. List of workflows to show current status of in the patient header. These will only be displayed if they belong to a program listed above. (Should be a comma-separated list of program_workflow_ids.)','896fd064-e77a-4918-8386-9b99232fb06c',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.metadata.caseConversion',NULL,'Indicates which type automatic case conversion is applied to program/workflow/state in the patient dashboard. Valid values: lowercase, uppercase, capitalize. If empty no conversion is applied.','9a9d1006-f878-45df-9b24-8c0a04e2a006',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.overview.showConcepts',NULL,'Comma delimited list of concepts ids to show on the patient dashboard overview tab','99681b68-68b8-44d6-b01a-dc00086ebb8a',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayDrugSetIds','ANTIRETROVIRAL DRUGS,TUBERCULOSIS TREATMENT DRUGS','Drug sets that appear on the Patient Dashboard Regimen tab. Comma separated list of name of concepts that are defined as drug sets.','0425437b-8747-4051-a78e-16447b667dba',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.regimen.displayFrequencies','7 days/week,6 days/week,5 days/week,4 days/week,3 days/week,2 days/week,1 days/week','Frequency of a drug order that appear on the Patient Dashboard. Comma separated list of name of concepts that are defined as drug frequencies.','46211e86-bc96-4fc8-bb9e-bc6b81afa2a2',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.relationships.show_types',NULL,'Types of relationships separated by commas.  Doctor/Patient,Parent/Child','eedd168b-c2c8-48cb-82e0-671056e25667',NULL,NULL,NULL,NULL,NULL,NULL),('dashboard.showPatientName','false','Whether or not to display the patient name in the patient dashboard title. Note that enabling this could be security risk if multiple users operate on the same computer.','4d6806ac-993b-460b-85cb-439be8b9b6e4','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('datePicker.weekStart','0','First day of the week in the date picker. Domingo/Dimanche/Sunday:0  Lunes/Lundi/Monday:1','5736a8f8-71a6-44cb-9172-29e114965663',NULL,NULL,NULL,NULL,NULL,NULL),('default_locale','en_GB','Specifies the default locale. You can specify both the language code(ISO-639) and the country code(ISO-3166), e.g. \'en_GB\' or just country: e.g. \'en\'','c52c6627-0d56-47b1-a155-6c72634786fb',NULL,NULL,NULL,NULL,NULL,NULL),('default_location','Unknown Location','The name of the location to use as a system default','db8f8a65-7a60-4e83-95dc-05c3e71f04b9',NULL,NULL,NULL,NULL,NULL,NULL),('default_theme',NULL,'Default theme for users.  OpenMRS ships with themes of \'green\', \'orange\', \'purple\', and \'legacy\'','a2ba1288-60fa-42da-aafd-c3badc2bd242',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.drugOther',NULL,'Specifies the uuid of the concept which represents drug other non coded','d37d00ca-e806-48dd-86db-eb76769bec32',NULL,NULL,NULL,NULL,NULL,NULL),('drugOrder.requireDrug','false','Set to value true if you need to specify a formulation(Drug) when creating a drug order.','15975c2c-65ec-4a93-bb4a-6319767b500a',NULL,NULL,NULL,NULL,NULL,NULL),('encounterForm.obsSortOrder','number','The sort order for the obs listed on the encounter edit form.  \'number\' sorts on the associated numbering from the form schema.  \'weight\' sorts on the order displayed in the form schema.','832b21a7-73e3-4351-8bc5-d46c12611238',NULL,NULL,NULL,NULL,NULL,NULL),('EncounterType.encounterTypes.locked','false','saving, retiring or deleting an Encounter Type is not permitted, if true','5a6af0fd-7dfe-4815-a11f-e14b6ad5f7e2','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('fhir2.locationContactPointAttributeTypeUuid','abcde432-1691-11df-97a5-7038c432abcd','Set location attribute type uuid','e7d57286-69fa-4734-a48a-dc03db66077d',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.mandatory','false','true/false whether or not the fhir2 module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','6310e69a-7c5c-4dc9-af60-d7a67d2dadd6',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.narrativesOverridePropertyFile',NULL,'Path of narrative override properties file','5a9192bf-4d5b-4b28-963b-b240c3b6fa3c',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.paging.default','10','Set default page size','7bc61740-c596-4560-bd7e-f6ab1b7288a7',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.paging.maximum','100','Set maximum page size','60aaf6d3-d5fd-4926-aa95-ffb4498fd95a',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.personContactPointAttributeTypeUuid','14d4f066-15f5-102d-96e4-000c29c2a5d7','Set person attribute type uuid','59cf6463-ca98-461a-8ca0-66df7dcabcc3',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.providerContactPointAttributeTypeUuid','5021b1a1-e7f6-44b4-ba02-da2f2bcf8718','Set provider attribute type uuid','d2a8edf6-4d02-44c5-a35f-5a68e8bb6393',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.started','true','DO NOT MODIFY. true/false whether or not the fhir2 module has been started.  This is used to make sure modules that were running  prior to a restart are started again','a569443d-f2da-4524-a06e-213602e72c1b',NULL,NULL,NULL,NULL,NULL,NULL),('fhir2.uriPrefix',NULL,'Prefix for the FHIR server in case this cannot be automatically detected','97d59329-58e2-450c-83a9-a670d0b20e65',NULL,NULL,NULL,NULL,NULL,NULL),('FormEntry.enableDashboardTab','true','true/false whether or not to show a Form Entry tab on the patient dashboard','21cb9ffb-dc5d-4543-a131-d363fa11ef70','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('FormEntry.enableOnEncounterTab','false','true/false whether or not to show a Enter Form button on the encounters tab of the patient dashboard','6d60d0c7-7bfd-4cb7-a01f-3e0fc4af4262','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('forms.locked','false','Set to a value of true if you do not want any changes to be made on forms, else set to false.','6a466202-e197-4872-a41e-fb0dbbd64450',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.absolute','rgb(20,20,20)','Color of the \'invalid\' section of numeric graphs on the patient dashboard.','de0fd758-18e1-4476-8d96-1c7b6b67f4e5',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.critical','rgb(200,0,0)','Color of the \'critical\' section of numeric graphs on the patient dashboard.','f6d2b5a3-0c4f-42ea-b284-e692c148b7e7',NULL,NULL,NULL,NULL,NULL,NULL),('graph.color.normal','rgb(255,126,0)','Color of the \'normal\' section of numeric graphs on the patient dashboard.','483c2a3e-0a38-44d0-bebc-860801a307e5',NULL,NULL,NULL,NULL,NULL,NULL),('gzip.enabled','false','Set to \'true\' to turn on OpenMRS\'s gzip filter, and have the webapp compress data before sending it to any client that supports it. Generally use this if you are running Tomcat standalone. If you are running Tomcat behind Apache, then you\'d want to use Apache to do gzip compression.','a1e0eef7-0de6-496b-9450-c81e0bd20946','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('hl7_archive.dir','hl7_archives','The default name or absolute path for the folder where to write the hl7_in_archives.','877a3e47-53ca-42e2-81ec-aa9e8a327b41',NULL,NULL,NULL,NULL,NULL,NULL),('hl7_processor.ignore_missing_patient_non_local','false','If true, hl7 messages for patients that are not found and are non-local will silently be dropped/ignored','5b465825-d44d-4372-9d33-ba8fdb227ef9','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('host.url',NULL,'The URL to redirect to after requesting for a password reset. Always provide a place holder in this url with name {activationKey}, it will get substituted by the actual activation key.','ad5cde81-5d80-430b-a395-75c7bf40f900',NULL,NULL,NULL,NULL,NULL,NULL),('layout.address.format','<org.openmrs.layout.address.AddressTemplate>\n    <nameMappings class=\"properties\">\n      <property name=\"postalCode\" value=\"Location.postalCode\"/>\n      <property name=\"address2\" value=\"Location.address2\"/>\n      <property name=\"address1\" value=\"Location.address1\"/>\n      <property name=\"country\" value=\"Location.country\"/>\n      <property name=\"stateProvince\" value=\"Location.stateProvince\"/>\n      <property name=\"cityVillage\" value=\"Location.cityVillage\"/>\n    </nameMappings>\n    <sizeMappings class=\"properties\">\n      <property name=\"postalCode\" value=\"10\"/>\n      <property name=\"address2\" value=\"40\"/>\n      <property name=\"address1\" value=\"40\"/>\n      <property name=\"country\" value=\"10\"/>\n      <property name=\"stateProvince\" value=\"10\"/>\n      <property name=\"cityVillage\" value=\"10\"/>\n    </sizeMappings>\n    <lineByLineFormat>\n      <string>address1</string>\n      <string>address2</string>\n      <string>cityVillage stateProvince country postalCode</string>\n    </lineByLineFormat>\n   <requiredElements>\\n\" + \" </requiredElements>\\n\" + \" </org.openmrs.layout.address.AddressTemplate>','XML description of address formats','666fcf28-f6c1-4e71-a34c-ee912bab0b2e',NULL,NULL,NULL,NULL,NULL,NULL),('layout.name.format','short','Format in which to display the person names.  Valid values are short, long','2283342f-8484-483d-92f7-8bbe5a52a501',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.enableExitFromCare','false','true/false whether or not to show the Exit / Resume Care button on the patient dashboard','591f48c8-7dcb-487f-9af6-d441854d969e',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.mandatory','false','true/false whether or not the legacyui module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','338d3abb-7734-4fb1-8df2-505685a7e70b',NULL,NULL,NULL,NULL,NULL,NULL),('legacyui.started','true','DO NOT MODIFY. true/false whether or not the legacyui module has been started.  This is used to make sure modules that were running  prior to a restart are started again','f120fb8d-eb13-4da1-9fde-945097a96390',NULL,NULL,NULL,NULL,NULL,NULL),('locale.allowed.list','en, en_GB, es, fr, it, pt','Comma delimited list of locales allowed for use on system','06347e37-9bb6-4cd7-bac2-edfb470d8f9c',NULL,NULL,NULL,NULL,NULL,NULL),('location.field.style','default','Type of widget to use for location fields','d4f811ff-096a-4d6c-b568-38e8057f7350',NULL,NULL,NULL,NULL,NULL,NULL),('log.layout','%p - %C{1}.%M(%L) |%d{ISO8601}| %m%n','A log layout pattern which is used by the OpenMRS file appender.','7026c6b1-cba2-407e-8c20-986dbd0cf995',NULL,NULL,NULL,NULL,NULL,NULL),('log.level','org.openmrs.api:info','Logging levels for log4j2.xml. Valid format is class:level,class:level. If class not specified, \'org.openmrs.api\' presumed. Valid levels are trace, debug, info, warn, error or fatal','7c08939d-d1b4-4789-9d63-502079ea115f',NULL,NULL,NULL,NULL,NULL,NULL),('log.location',NULL,'A directory where the OpenMRS log file appender is stored. The log file name is \'openmrs.log\'.','c1ff3347-8466-4ac9-b8c5-f21357fabf37',NULL,NULL,NULL,NULL,NULL,NULL),('login.url','owa/addonmanager/index.html','Responsible for defining the Authentication URL','a42af908-0ccc-479a-b66e-dbae7391049a',NULL,NULL,NULL,NULL,NULL,NULL),('mail.debug','false','true/false whether to print debugging information during mailing','998028da-81b3-448b-9edb-5bd9a1ea3d05',NULL,NULL,NULL,NULL,NULL,NULL),('mail.default_content_type','text/plain','Content type to append to the mail messages','cf918d11-554c-4e51-b3b9-3fa0bd392344',NULL,NULL,NULL,NULL,NULL,NULL),('mail.from','info@openmrs.org','Email address to use as the default from address','6dca0ed9-f73a-4987-86ed-e0ec50ee0674',NULL,NULL,NULL,NULL,NULL,NULL),('mail.password','test','Password for the SMTP user (if smtp_auth is enabled)','e559e190-c155-43f8-b821-2c0b1f37f5db',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp.starttls.enable','false','Set to true to enable TLS encryption, else set to false','db0b5b6d-fd05-428d-9555-2d8a00470a05',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_auth','false','true/false whether the smtp host requires authentication','b969a24a-e28a-4665-b2be-e824ded563ae',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_host','localhost','SMTP host name','e9668370-54b4-45c0-af53-b53e054746e3',NULL,NULL,NULL,NULL,NULL,NULL),('mail.smtp_port','25','SMTP port','be637a88-68ae-444d-8743-0b07e4c85cc0',NULL,NULL,NULL,NULL,NULL,NULL),('mail.transport_protocol','smtp','Transport protocol for the messaging engine. Valid values: smtp','3d0ac4fa-e10e-45dc-912f-648441f30df6',NULL,NULL,NULL,NULL,NULL,NULL),('mail.user','test','Username of the SMTP user (if smtp_auth is enabled)','56bb0224-0e3d-4e23-9f43-73ac69890a73',NULL,NULL,NULL,NULL,NULL,NULL),('minSearchCharacters','2','Number of characters user must input before searching is started.','d421264e-84ca-4024-87e3-ec8e148f5ab7',NULL,NULL,NULL,NULL,NULL,NULL),('module_repository_folder','modules','Name of the folder in which to store the modules','4eeaf088-4446-40cd-92fc-a233566316b0',NULL,NULL,NULL,NULL,NULL,NULL),('newPatientForm.relationships',NULL,'Comma separated list of the RelationshipTypes to show on the new/short patient form.  The list is defined like \'3a, 4b, 7a\'.  The number is the RelationshipTypeId and the \'a\' vs \'b\' part is which side of the relationship is filled in by the user.','226bcd99-df05-468f-a94d-518744b6e259',NULL,NULL,NULL,NULL,NULL,NULL),('new_patient_form.showRelationships','false','true/false whether or not to show the relationship editor on the addPatient.htm screen','16c1585b-c24e-4195-9cd3-ab1ee387c8d1','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('obs.complex_obs_dir','complex_obs','Default directory for storing complex obs.','648eac0a-5aaa-421c-8543-731d08ddb45a',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDispensingUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug dispensing units','a2008189-c80d-43e1-a87b-291d6e366501',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugDosingUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug dosing units','3f707755-fa34-417c-827c-3532ff6d2fa4',NULL,NULL,NULL,NULL,NULL,NULL),('order.drugRoutesConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible drug routes','5f891c7c-d440-4b06-aacc-1a69c8ef8107',NULL,NULL,NULL,NULL,NULL,NULL),('order.durationUnitsConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible duration units','90fd85e7-e250-4b84-962b-63fbf72d87da',NULL,NULL,NULL,NULL,NULL,NULL),('order.nextOrderNumberSeed','1','The next order number available for assignment','68e648e0-c52d-4ba1-b03c-b22419d255a3',NULL,NULL,NULL,NULL,NULL,NULL),('order.orderNumberGeneratorBeanId',NULL,'Specifies spring bean id of the order generator to use when assigning order numbers','99166160-30e3-4c17-8252-15972ff7e382',NULL,NULL,NULL,NULL,NULL,NULL),('order.testSpecimenSourcesConceptUuid',NULL,'Specifies the uuid of the concept set where its members represent the possible test specimen sources','4e9e2190-0e33-4b76-b261-12f34da71d80',NULL,NULL,NULL,NULL,NULL,NULL),('owa.appBaseUrl',NULL,'The base URL from where the Open Web Apps are hosted','1507129a-f243-47a2-9835-d74b6dcfc018',NULL,NULL,NULL,NULL,NULL,NULL),('owa.appFolderPath','/data/webapps/tomcat/openmrs-test/.OpenMRS/owa','The default location where the apps are stored on disk','4ce985a9-c554-4e9a-801c-00198e952fb2',NULL,NULL,NULL,NULL,NULL,NULL),('owa.appStoreUrl','http://modules.openmrs.org','The default URL for the OpenMRS appstore','1a1422ff-48be-4cc9-9f6a-c63b5480f25e',NULL,NULL,NULL,NULL,NULL,NULL),('owa.mandatory','false','true/false whether or not the owa module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','309f8cf7-10df-41e4-9bb9-0506498e6349',NULL,NULL,NULL,NULL,NULL,NULL),('owa.started','true','DO NOT MODIFY. true/false whether or not the owa module has been started.  This is used to make sure modules that were running  prior to a restart are started again','3b708868-3ca6-4014-a1f2-c46528a143da',NULL,NULL,NULL,NULL,NULL,NULL),('patient.defaultPatientIdentifierValidator','org.openmrs.patient.impl.LuhnIdentifierValidator','This property sets the default patient identifier validator.  The default validator is only used in a handful of (mostly legacy) instances.  For example, it\'s used to generate the isValidCheckDigit calculated column and to append the string \"(default)\" to the name of the default validator on the editPatientIdentifierType form.','0b1e0891-b2cf-46a0-b5c3-0c499fc52d5b',NULL,NULL,NULL,NULL,NULL,NULL),('patient.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the patient dashboard','d3aff1a7-6248-4297-abe8-ce385a385f62',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierPrefix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','c17ddfa1-2812-4354-b529-de40f505fa2a',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierRegex',NULL,'WARNING: Using this search property can cause a drop in mysql performance with large patient sets.  A MySQL regular expression for the patient identifier search strings.  The @SEARCH@ string is replaced at runtime with the user\'s search string.  An empty regex will cause a simply \'like\' sql search to be used. Example: ^0*@SEARCH@([A-Z]+-[0-9])?$','587bc496-110c-4d13-8df5-6bfd4404246f',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSearchPattern',NULL,'If this is empty, the regex or suffix/prefix search is used.  Comma separated list of identifiers to check.  Allows for faster searching of multiple options rather than the slow regex. e.g. @SEARCH@,0@SEARCH@,@SEARCH-1@-@CHECKDIGIT@,0@SEARCH-1@-@CHECKDIGIT@ would turn a request for \"4127\" into a search for \"in (\'4127\',\'04127\',\'412-7\',\'0412-7\')\"','425c6829-e61c-4b1a-ac23-5293317df26b',NULL,NULL,NULL,NULL,NULL,NULL),('patient.identifierSuffix',NULL,'This property is only used if patient.identifierRegex is empty.  The string here is prepended to the sql indentifier search string.  The sql becomes \"... where identifier like \'<PREFIX><QUERY STRING><SUFFIX>\';\".  Typically this value is either a percent sign (%) or empty.','1958c024-f292-456a-b674-ad2303d5e535',NULL,NULL,NULL,NULL,NULL,NULL),('patient.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients in _lists_','474cd8ed-3aaf-4593-a729-c7584779c5f7',NULL,NULL,NULL,NULL,NULL,NULL),('patient.nameValidationRegex',NULL,'Names of the patients must pass this regex. Eg : ^[a-zA-Z \\-]+$ contains only english alphabet letters, spaces, and hyphens. A value of .* or the empty string means no validation is done.','0e56c391-33ef-459f-be94-bea0574c5826',NULL,NULL,NULL,NULL,NULL,NULL),('patient.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for patients when _viewing individually_','bb06510e-1af6-47ba-9c56-c380784d64bb',NULL,NULL,NULL,NULL,NULL,NULL),('patientIdentifierSearch.matchMode','EXACT','Specifies how patient identifiers are matched while searching for a patient. Valid values are \'EXACT, \'ANYWHERE\' or \'START\'. Defaults to \'EXACT\' if missing or invalid value is present.','851962cb-82e7-409b-a8b9-8631721b9f9f',NULL,NULL,NULL,NULL,NULL,NULL),('patientIdentifierTypes.locked','false','Set to a value of true if you do not want allow editing patient identifier types, else set to false.','de7c5291-cc3d-4fb3-ba00-7aa8bf6b0af4',NULL,NULL,NULL,NULL,NULL,NULL),('patientSearch.matchMode','START','Specifies how patient names are matched while searching patient. Valid values are \'ANYWHERE\' or \'START\'. Defaults to start if missing or invalid value is present.','076b344d-17e7-4f93-99ad-5f26ecdb834a',NULL,NULL,NULL,NULL,NULL,NULL),('patient_identifier.importantTypes',NULL,'A comma delimited list of PatientIdentifier names : PatientIdentifier locations that will be displayed on the patient dashboard.  E.g.: TRACnet ID:Rwanda,ELDID:Kenya','23fb83df-9fbe-4278-8903-479cbbc48ac4',NULL,NULL,NULL,NULL,NULL,NULL),('person.attributeSearchMatchMode','EXACT','Specifies how person attributes are matched while searching person. Valid values are \'ANYWHERE\' or \'EXACT\'. Defaults to exact if missing or invalid value is present.','365d8491-f824-4885-a63a-6cc13efc1671',NULL,NULL,NULL,NULL,NULL,NULL),('person.searchMaxResults','1000','The maximum number of results returned by patient searches','8096246e-f419-4e75-9fb5-543cae75be9d',NULL,NULL,NULL,NULL,NULL,NULL),('personAttributeTypes.locked','false','Set to a value of true if you do not want allow editing person attribute types, else set to false.','2cdd86cf-734f-4074-817f-35148e87590b',NULL,NULL,NULL,NULL,NULL,NULL),('provider.unknownProviderUuid',NULL,'Specifies the uuid of the Unknown Provider account','0d29ebd1-ed32-445f-8178-445058613481',NULL,NULL,NULL,NULL,NULL,NULL),('providerSearch.matchMode','EXACT','Specifies how provider identifiers are matched while searching for providers. Valid values are START,EXACT, END or ANYWHERE','387d8296-795a-4b14-8812-0687bc256a95',NULL,NULL,NULL,NULL,NULL,NULL),('reportProblem.url','http://errors.openmrs.org/scrap','The openmrs url where to submit bug reports','e27bed0b-7973-419a-b9cc-3f72fcc0c123',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.password','test','Password for the OpenMRS user that will perform the scheduler activities','45fbb8b7-4dc2-4673-a70c-f368f7fecac3',NULL,NULL,NULL,NULL,NULL,NULL),('scheduler.username','admin','Username for the OpenMRS user that will perform the scheduler activities','055454f5-8689-4bfd-a46e-0baea64e62e0',NULL,NULL,NULL,NULL,NULL,NULL),('search.caseSensitiveDatabaseStringComparison','false','Indicates whether database string comparison is case sensitive or not. Setting this to false for MySQL with a case insensitive collation improves search performance.','3e669b02-90cf-4adc-8649-aafef69c9aad',NULL,NULL,NULL,NULL,NULL,NULL),('search.indexVersion','7','Indicates the index version. If it is blank, the index needs to be rebuilt.','051164d6-10a2-4069-8984-864b22f01e8e',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.batchSize','200','The maximum number of search results that are returned by an ajax call','2ad9b7be-1610-46af-af2c-0919ce5a5420',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.dateDisplayFormat',NULL,'Date display format to be used to display the date somewhere in the UI i.e the search widgets and autocompletes','bd5907bf-4424-4da9-ba50-d621632175c2',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.maximumResults','2000','Specifies the maximum number of results to return from a single search in the search widgets','034fd3de-a321-4a8c-a822-64e8c2b216b4',NULL,NULL,NULL,NULL,NULL,NULL),('searchWidget.runInSerialMode','false','Specifies whether the search widgets should make ajax requests in serial or parallel order, a value of true is appropriate for implementations running on a slow network connection and vice versa','d45e2fb3-c8ab-4401-bb97-33159174c516','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('searchWidget.searchDelayInterval','300','Specifies time interval in milliseconds when searching, between keyboard keyup event and triggering the search off, should be higher if most users are slow when typing so as to minimise the load on the server','1928df73-b8c2-493c-beac-b3b32a11639a',NULL,NULL,NULL,NULL,NULL,NULL),('security.allowedFailedLoginsBeforeLockout','7','Maximum number of failed logins allowed after which username is locked out','5a1009d3-89fc-439b-81e2-85f688724757',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordCannotMatchUsername','true','Configure whether passwords must not match user\'s username or system id','4d2762ef-10cc-4e93-b530-7acda0b869f7','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordCustomRegex',NULL,'Configure a custom regular expression that a password must match','d7d5be57-d05d-46a5-a0f0-e8f1f649fe61',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordMinimumLength','8','Configure the minimum length required of all passwords','ce4da716-b202-4d21-a693-0f6df2932eef',NULL,NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresDigit','true','Configure whether passwords must contain at least one digit','05c85025-e8ba-44c1-a6ee-3aff1a7364fa','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresNonDigit','true','Configure whether passwords must contain at least one non-digit','1cb3cf3b-0cd5-49c4-be8e-3c334088e4c1','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.passwordRequiresUpperAndLowerCase','true','Configure whether passwords must contain both upper and lower case characters','209c8476-b706-434c-9101-b80c8111bcad','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('security.validTime','600000','Specifies the duration of time in seconds for which a password reset token is valid, the default value is 10 minutes and the allowed values range from 1 minute to 12hrs','b5cfd9e8-b389-4f64-9fdc-9bc4ab6324d0',NULL,NULL,NULL,NULL,NULL,NULL),('user.headerAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that will be shown on the user dashboard. (not used in v1.5)','a6375d0a-454a-49fe-b509-13b6df3aab44',NULL,NULL,NULL,NULL,NULL,NULL),('user.listingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users in _lists_','0306506f-6589-44a5-ac29-a4b2de623088',NULL,NULL,NULL,NULL,NULL,NULL),('user.requireEmailAsUsername','false','Indicates whether a username must be a valid e-mail or not.','a78d2b77-eedc-468a-a4ae-b734cf348edf','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('user.viewingAttributeTypes',NULL,'A comma delimited list of PersonAttributeType names that should be displayed for users when _viewing individually_','f40d6686-5de3-48ac-a496-e6b029175479',NULL,NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.healthCenter','false','Indicates whether or not the \'health center\' attribute is shown when viewing/searching for patients','070fcf4e-3c85-4183-8704-0083f952cd82','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('use_patient_attribute.mothersName','false','Indicates whether or not mother\'s name is able to be added/viewed for a patient','0d2ff5f1-ebd3-462a-b4a3-69aa5f85c128','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('validation.disable','false','Disables validation of OpenMRS Objects. Only takes affect on next restart. Warning: only do this is you know what you are doing!','779cc2a0-59dd-4443-9793-fe732bc80dda',NULL,NULL,NULL,NULL,NULL,NULL),('visits.allowOverlappingVisits','true','true/false whether or not to allow visits of a given patient to overlap','c74128b6-e78a-4ed7-9f7e-9d1863d1e6fd','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.assignmentHandler','org.openmrs.api.handler.ExistingVisitAssignmentHandler','Set to the name of the class responsible for assigning encounters to visits.','1ef8674f-60dd-4aad-b97e-100762cc9f80',NULL,NULL,NULL,NULL,NULL,NULL),('visits.autoCloseVisitType',NULL,'comma-separated list of the visit type(s) to automatically close','db98ceef-7aea-451e-a0a5-4ac17324e13a',NULL,NULL,NULL,NULL,NULL,NULL),('visits.enabled','true','Set to true to enable the Visits feature. This will replace the \'Encounters\' tab with a \'Visits\' tab on the dashboard.','776fdb0f-a8c6-4e2d-8be8-1b11709d9c45','org.openmrs.customdatatype.datatype.BooleanDatatype',NULL,NULL,NULL,NULL,NULL),('visits.encounterTypeToVisitTypeMapping',NULL,'Specifies how encounter types are mapped to visit types when automatically assigning encounters to visits. e.g 1:1, 2:1, 3:2 in the format encounterTypeId:visitTypeId or encounterTypeUuid:visitTypeUuid or a combination of encounter/visit type uuids and ids e.g 1:759799ab-c9a5-435e-b671-77773ada74e4','5644f4ed-a948-4147-9513-30aed85080c3',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.allowedips',NULL,'A comma-separate list of IP addresses that are allowed to access the web services. An empty string allows everyone to access all ws. \n        IPs can be declared with bit masks e.g. 10.0.0.0/30 matches 10.0.0.0 - 10.0.0.3 and 10.0.0.0/24 matches 10.0.0.0 - 10.0.0.255.','d5ceb8a1-05b5-4e13-9de5-91759667f71c',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.mandatory','false','true/false whether or not the webservices.rest module MUST start when openmrs starts.  This is used to make sure that mission critical modules are always running if openmrs is running.','46bc6f42-d1dd-4073-b1eb-bb029522641f',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsAbsolute','100','The absolute max results limit. If the client requests a larger number of results, then will get an error','ae7f0b9a-ad17-42b4-839e-1a675ba4fa19',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.maxResultsDefault','50','The default max results limit if the user does not provide a maximum when making the web service call.','d69d3893-ecc6-4640-b468-d069f7b2b3b2',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.quietDocs','true','If the value of this setting is \"true\", then nothing is logged while the Swagger specification is being generated.','34d37c6d-3b0f-4f0d-a842-613243693e7f',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.started','true','DO NOT MODIFY. true/false whether or not the webservices.rest module has been started.  This is used to make sure modules that were running  prior to a restart are started again','b43393f7-11f7-47bf-ab93-f06178493ae1',NULL,NULL,NULL,NULL,NULL,NULL),('webservices.rest.uriPrefix',NULL,'The URI prefix through which clients consuming web services will connect to the web application, should be of the form http://{ipAddress}:{port}/{contextPath}','63356cf5-9461-4bea-8020-402fce27526f',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `global_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_archive`
--

DROP TABLE IF EXISTS `hl7_in_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_archive` (
  `hl7_in_archive_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT 0,
  `hl7_source_key` varchar(255) DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `date_created` datetime NOT NULL,
  `message_state` int(11) DEFAULT 2,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_archive_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_in_archive_message_state_idx` (`message_state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_archive`
--

LOCK TABLES `hl7_in_archive` WRITE;
/*!40000 ALTER TABLE `hl7_in_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_error`
--

DROP TABLE IF EXISTS `hl7_in_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_error` (
  `hl7_in_error_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT 0,
  `hl7_source_key` text DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `error` varchar(255) NOT NULL DEFAULT '',
  `error_details` mediumtext DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_error_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_error`
--

LOCK TABLES `hl7_in_error` WRITE;
/*!40000 ALTER TABLE `hl7_in_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_in_queue`
--

DROP TABLE IF EXISTS `hl7_in_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_in_queue` (
  `hl7_in_queue_id` int(11) NOT NULL AUTO_INCREMENT,
  `hl7_source` int(11) NOT NULL DEFAULT 0,
  `hl7_source_key` text DEFAULT NULL,
  `hl7_data` text NOT NULL,
  `message_state` int(11) NOT NULL DEFAULT 0,
  `date_processed` datetime DEFAULT NULL,
  `error_msg` text DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_in_queue_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `hl7_source_with_queue` (`hl7_source`),
  CONSTRAINT `hl7_source_with_queue` FOREIGN KEY (`hl7_source`) REFERENCES `hl7_source` (`hl7_source_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_in_queue`
--

LOCK TABLES `hl7_in_queue` WRITE;
/*!40000 ALTER TABLE `hl7_in_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `hl7_in_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hl7_source`
--

DROP TABLE IF EXISTS `hl7_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7_source` (
  `hl7_source_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`hl7_source_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_who_created_hl7_source` (`creator`),
  CONSTRAINT `user_who_created_hl7_source` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hl7_source`
--

LOCK TABLES `hl7_source` WRITE;
/*!40000 ALTER TABLE `hl7_source` DISABLE KEYS */;
INSERT INTO `hl7_source` VALUES (1,'LOCAL','',1,'2006-09-01 00:00:00','8d6b8bb6-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `hl7_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangelog`
--

DROP TABLE IF EXISTS `liquibasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangelog`
--

LOCK TABLES `liquibasechangelog` WRITE;
/*!40000 ALTER TABLE `liquibasechangelog` DISABLE KEYS */;
INSERT INTO `liquibasechangelog` VALUES ('1582473628795-1','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',1,'EXECUTED','8:238fe3f03c37d18fd5117d58579b728e','createTable tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-2','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',2,'EXECUTED','8:66bfc8234785132bb19d738a38149dac','createTable tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-3','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',3,'EXECUTED','8:a1cf873fe69c959aac6a8bc560123db3','createTable tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-4','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',4,'EXECUTED','8:08dd21485e374a9c23ba168f86e688d8','createTable tableName=clob_datatype_storage','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-5','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',5,'EXECUTED','8:98cad85af2e0bb7a64b85d4b476095a7','createTable tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-6','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',6,'EXECUTED','8:4df18ea17f9c077a6c66cf1609c031dd','createTable tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-7','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',7,'EXECUTED','8:439539bcb3d94c4d0e269296b23ef70b','createTable tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-8','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',8,'EXECUTED','8:c34dc6adc6f35bd0c9051ba65a015005','createTable tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-9','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',9,'EXECUTED','8:ef8fd51526a17665cadd10c91742740f','createTable tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-10','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',10,'EXECUTED','8:142ed55c82ea3c39531b89202caf1bc1','createTable tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-11','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',11,'EXECUTED','8:f44a280ff3f4b390728c61c709126fbd','createTable tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-12','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',12,'EXECUTED','8:9095b0e88b571c2edd43af0e662c9d54','createTable tableName=concept_complex','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-13','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',13,'EXECUTED','8:3679f7729afe800446d8cedf68fd3c26','createTable tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-14','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',14,'EXECUTED','8:006e0e83f27be58d38265254c4c73a18','createTable tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-15','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',15,'EXECUTED','8:201f1eee264b3524160f726e2bb01ad4','createTable tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-16','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',16,'EXECUTED','8:496f72fa38dba348042ab0cf169341cb','createTable tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-17','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',17,'EXECUTED','8:ef87738c7dadd667412bfa1d9b334ee0','createTable tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-18','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',18,'EXECUTED','8:2ad1f3969d4447ec88134a92452372cc','createTable tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-19','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',19,'EXECUTED','8:5c452fab1bf82808191c0e716b21495d','createTable tableName=concept_numeric','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-20','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',20,'EXECUTED','8:19ca40eebcedeaaa6a79f23969cff287','createTable tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-21','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',21,'EXECUTED','8:32485f3a60b8038b6bec0697ec1925c8','createTable tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-22','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',22,'EXECUTED','8:6e89e74287cb308de5f82102413a0439','createTable tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-23','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',23,'EXECUTED','8:8c39f2171bac697c43c1aec40549978b','createTable tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-24','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',24,'EXECUTED','8:2311a8ad536e93f51f23b6330144974c','createTable tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-25','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',25,'EXECUTED','8:db7361e2e3134136d7311020e001dfe3','createTable tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-26','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',26,'EXECUTED','8:6d84f3d7e12a72c45f6a9be7eb4b36a7','createTable tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-27','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',27,'EXECUTED','8:ec244808f1b0894a53f3c73acdd09692','createTable tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-28','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',28,'EXECUTED','8:03eb15e1b88a1c9f5d95079011881fcb','createTable tableName=concept_stop_word','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-29','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',29,'EXECUTED','8:dd9d9e6b445cbced1ae746e0bc039cd5','createTable tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-30','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',30,'EXECUTED','8:75fe79aac8155c708d4d886d97edc2ad','createTable tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-31','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',31,'EXECUTED','8:fa53b9d6b5ca90f4f1dd3f9b7dc6ac7b','createTable tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-32','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',32,'EXECUTED','8:e1931d61b5e0d3f19ca14dd4a3f8d470','createTable tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-33','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',33,'EXECUTED','8:789061a8116ebbcc436e7184ea642fc0','createTable tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-34','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',34,'EXECUTED','8:e01652d1cc10267c54c08aa6c69fa267','createTable tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-35','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',35,'EXECUTED','8:327278fc23b24c74246bc786b3aa86d9','createTable tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-36','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',36,'EXECUTED','8:d39433ac66c5db9697439993cd37745d','createTable tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-37','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',37,'EXECUTED','8:2ea2d318a7d4712bb4ec4ac5a23acb95','createTable tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-38','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',38,'EXECUTED','8:23ef531c5e1cfa984985d17897f153c8','createTable tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-39','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',39,'EXECUTED','8:948f7dfe7f7d954636d2ddceba471b2d','createTable tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-40','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',40,'EXECUTED','8:dd5b1cadb5a56575a7e8cd8462fbb7e1','createTable tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-41','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',41,'EXECUTED','8:9d0f4e40b82245078bcd22174f82452f','createTable tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-42','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',42,'EXECUTED','8:62cab75a02e38a79d1cf948219d8189a','createTable tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-43','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',43,'EXECUTED','8:3de5017a3753d3a6e0a7593c6411e260','createTable tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-44','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',44,'EXECUTED','8:91e80c748bf1462e41411ac3feadfd57','createTable tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-45','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',45,'EXECUTED','8:a295f3ad50a0faab26d885e4a3ffc386','createTable tableName=global_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-46','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',46,'EXECUTED','8:02ce7a54be6683048b3bfd01944c0303','createTable tableName=hl7_in_archive','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-47','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',47,'EXECUTED','8:089a56e623784de5510d377e1a5c0fb7','createTable tableName=hl7_in_error','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-48','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',48,'EXECUTED','8:ca099d7b4600624db7b78b762b0a3b02','createTable tableName=hl7_in_queue','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-49','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',49,'EXECUTED','8:0c39e5581a2dd23a769b82b1a0377d3a','createTable tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-52','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',50,'EXECUTED','8:e8848a5f02cf220d27fb281cb8cc858c','createTable tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-53','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',51,'EXECUTED','8:f0ad9d30f2a4eb80b5d14f22fb2414e8','createTable tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-54','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',52,'EXECUTED','8:51c85eeebcc3a9312db41105fe3dca49','createTable tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-55','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',53,'EXECUTED','8:b9360b112a62e90b0014e49f835c5d3d','createTable tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-56','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',54,'EXECUTED','8:c1c62de3067d99bd88bd0ddda1e4ff19','createTable tableName=location_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-57','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',55,'EXECUTED','8:81ceb9f89c4271def4031a92a4c93664','createTable tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-58','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',56,'EXECUTED','8:eace5025507e76a3678701a1382782c4','createTable tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-59','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',57,'EXECUTED','8:295b72dcc114cfa85d967adc8b27a01a','createTable tableName=notification_alert_recipient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-60','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',58,'EXECUTED','8:e9e05b5a3371d945f2e773f3d1ada6c1','createTable tableName=notification_template','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-61','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',59,'EXECUTED','8:9ec0fb1d838b0a5fdfed897f841c6c2e','createTable tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-62','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',60,'EXECUTED','8:53a44b946d8ca5c27930fa1b821a9c0b','createTable tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-63','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',61,'EXECUTED','8:f21d6287908349a10902b5ddad46a444','createTable tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-64','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',62,'EXECUTED','8:b0e480c587aad19df5fe32c3e8de3026','createTable tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-65','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',63,'EXECUTED','8:51966d28f8d45998212887fc2d6658e0','createTable tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-66','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',64,'EXECUTED','8:f65d4f171b22df2632798a54d9d71bc5','createTable tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-67','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',65,'EXECUTED','8:3617a5326201bdd34ee64548fa81f670','createTable tableName=order_type_class_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-68','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',66,'EXECUTED','8:16b1d52d372ef877b87c83683a6f412e','createTable tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-69','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',67,'EXECUTED','8:8954c91117bc5b5d8c4e035c59f2d3f5','createTable tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-70','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',68,'EXECUTED','8:8079e93f1a5eb390c72f60f03ea38633','createTable tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-71','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:28',69,'EXECUTED','8:45adf630810c6bc7baedc9e80f3fa78f','createTable tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-72','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',70,'EXECUTED','8:6441e3670907d81ad00d689d1b84a44b','createTable tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-73','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',71,'EXECUTED','8:05b0103e4d69508557b17249ff869b0c','createTable tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-74','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',72,'EXECUTED','8:c6e7edf42161c56fcab9d2cefb8053a8','createTable tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-75','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',73,'EXECUTED','8:2d5da170c140d7e80e2f9e8b6c0ea2f4','createTable tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-76','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',74,'EXECUTED','8:47e57060ce4d4799b75ed23a8c8d5069','createTable tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-77','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',75,'EXECUTED','8:5403117950f628ee69d642012e32ed76','createTable tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-78','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',76,'EXECUTED','8:805580f60917bb3713db9bf2bce7b8c5','createTable tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-79','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',77,'EXECUTED','8:ef9fa12dd20b6d69932251edf73787aa','createTable tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-80','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',78,'EXECUTED','8:bfd52cee713336403616d1c16ecfff94','createTable tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-81','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',79,'EXECUTED','8:bc93a477857f42a0a2f5ce0cf130c06f','createTable tableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-82','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',80,'EXECUTED','8:6d47747541bf72c208d48bd34639725d','createTable tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-83','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',81,'EXECUTED','8:0b8b7645ef730dba3a0845533b18d2cf','createTable tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-84','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',82,'EXECUTED','8:52d5ade33710854bcdf137920a600e33','createTable tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-85','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',83,'EXECUTED','8:6165bf55147465316ff8a4db11aa3d7e','createTable tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-86','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',84,'EXECUTED','8:aad0b2a94e29051a379ec9d731994627','createTable tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-87','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',85,'EXECUTED','8:e707b8ba8979f2e6161dc9b2c3789165','createTable tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-88','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',86,'EXECUTED','8:b0ef5d173d29f94047ae72eaa975ec0e','createTable tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-89','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',87,'EXECUTED','8:028a98c61666a9ef47936fd43f604f74','createTable tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-90','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',88,'EXECUTED','8:b9a14edd7429c747153832947b450e8f','createTable tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-91','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',89,'EXECUTED','8:206b767bb1c039465101506583b16269','createTable tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-92','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',90,'EXECUTED','8:0d190523553cd8b01deffceac791821a','createTable tableName=report_schema_xml','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-93','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',91,'EXECUTED','8:aeae38f3d61d4fa234c16de406c8ce5a','createTable tableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-94','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',92,'EXECUTED','8:262d2a3bec8ed138c8341604ed61623b','createTable tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-95','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',93,'EXECUTED','8:08f5e5ca18573dc55e4b21c1310ea6a1','createTable tableName=role_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-96','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',94,'EXECUTED','8:795792e2c4a34a1b14e315c33c26aad7','createTable tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-97','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',95,'EXECUTED','8:9417a129dd10a6b5084c58753a8d7e8e','createTable tableName=scheduler_task_config_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-98','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',96,'EXECUTED','8:af1fe94b4ccbbcb29ded2279e2b21e95','createTable tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-99','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',97,'EXECUTED','8:43237f7dd8bb33bb478bdaf0bb725a05','createTable tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-100','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',98,'EXECUTED','8:5311325d6a46d0feb522ff60d8a5cf80','createTable tableName=user_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-101','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',99,'EXECUTED','8:5a15316575ed6969069e2c906af3b12b','createTable tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-102','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',100,'EXECUTED','8:8097a95686fc72d4eee52b904b8517f1','createTable tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-103','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',101,'EXECUTED','8:4c2f1c04b745bbf720c94d08f824439d','createTable tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-104','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',102,'EXECUTED','8:94fc7056b587c4d5291ae12880439d10','createTable tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-105','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',103,'EXECUTED','8:e3fff16d34de807a446d0d5a331ef929','createTable tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-106','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',104,'EXECUTED','8:fe8c5f6c57c52f28ac22bcf213575434','createTable tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-107','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',105,'EXECUTED','8:e6e767dc77131b1867f0eca3cf137607','addUniqueConstraint constraintName=Unique_StopWord_Key, tableName=concept_stop_word','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-108','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',106,'EXECUTED','8:89adbb595c96cd430a0b511ae01ff6a0','addUniqueConstraint constraintName=unique_form_and_name, tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-109','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',107,'EXECUTED','8:3164a86460597775566f339b7988025b','addUniqueConstraint constraintName=unique_workflow_concept_in_conversion, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-110','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',108,'EXECUTED','8:b333d65cbce8404063a1a9c49de4448f','createIndex indexName=address_for_person, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-111','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',109,'EXECUTED','8:66771b59765b7d074573fc820d0cd3fe','createIndex indexName=alert_creator, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-112','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',110,'EXECUTED','8:8147fa6e97c11507e1f592303259720e','createIndex indexName=alert_date_to_expire_idx, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-113','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',111,'EXECUTED','8:3191e265a3b57b0521ac0f34acec54a3','createIndex indexName=alert_read_by_user, tableName=notification_alert_recipient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-114','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',112,'EXECUTED','8:f5fae48654f180b62cf26898cd7f9459','createIndex indexName=allergy_changed_by_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-115','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',113,'EXECUTED','8:21221492eb4e97daa9035b20a84f906a','createIndex indexName=allergy_coded_allergen_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-116','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',114,'EXECUTED','8:b1d6b67f44e93f9b02919352b5aacaad','createIndex indexName=allergy_creator_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-117','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',115,'EXECUTED','8:3802de1996f1d6d8960ff81b4e7a8490','createIndex indexName=allergy_patient_id_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-118','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',116,'EXECUTED','8:73c8f4df0e4b017640c1dbd16aa29dc7','createIndex indexName=allergy_reaction_allergy_id_fk, tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-119','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',117,'EXECUTED','8:0c7772d6190cbac7f586dddedfddc53a','createIndex indexName=allergy_reaction_reaction_concept_id_fk, tableName=allergy_reaction','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-120','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',118,'EXECUTED','8:1c9aac1012a9f0aa9ffd18108fb78c7b','createIndex indexName=allergy_severity_concept_id_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-121','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',119,'EXECUTED','8:26d5e7fcd5345ba55707d1e45d68f384','createIndex indexName=allergy_voided_by_fk, tableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-122','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',120,'EXECUTED','8:6085d7b477502bb8c100914454572165','createIndex indexName=answer, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-123','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',121,'EXECUTED','8:6b328688423a699018d015f3de50e7d9','createIndex indexName=answer_answer_drug_fk, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-124','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',122,'EXECUTED','8:e149c8cd912ab791878266048cdc5f66','createIndex indexName=answer_concept, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-125','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',123,'EXECUTED','8:4cff1dfa775ab85432147fc7a9bc45bb','createIndex indexName=answer_concept_drug, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-126','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',124,'EXECUTED','8:cb0f8b09f946ae6f4de454a9b3c73d14','createIndex indexName=answer_creator, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-127','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',125,'EXECUTED','8:aafb0f0bbcc38efaea28ef6a0d0279b9','createIndex indexName=answers_for_concept, tableName=concept_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-128','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',126,'EXECUTED','8:b932dbce6343d0824d78fb1ab6bafe63','createIndex indexName=attribute_changer, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-129','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',127,'EXECUTED','8:5efc1f8e26031e3b01c73abefbd04d97','createIndex indexName=attribute_creator, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-130','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',128,'EXECUTED','8:9685bc73a05b10f134eb4094de4454fd','createIndex indexName=attribute_is_searchable, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-131','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',129,'EXECUTED','8:8ee4bc666d3f825b7fd1b219483b31c9','createIndex indexName=attribute_type_changer, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-132','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',130,'EXECUTED','8:2d33f303d66728b36c2613fbdbf1aaee','createIndex indexName=attribute_type_creator, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-133','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',131,'EXECUTED','8:cdc02e232fe6637a419142acd22d6931','createIndex indexName=attribute_voider, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-134','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',132,'EXECUTED','8:58d7b7938a86384a410898cb2af13e8c','createIndex indexName=care_setting_changed_by, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-135','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',133,'EXECUTED','8:bbe2e850c9553c682b0b81a09d28bea2','createIndex indexName=care_setting_creator, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-136','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',134,'EXECUTED','8:5cf3a54d398cc896218fbf6e3b298995','createIndex indexName=care_setting_retired_by, tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-137','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',135,'EXECUTED','8:6e0c003dc134e780289f4bbed82aa8ac','createIndex indexName=category_order_set_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-138','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',136,'EXECUTED','8:f09e2fb2224ce21fcef36d29b130aa92','createIndex indexName=cohort_creator, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-139','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',137,'EXECUTED','8:4029038a2a09d5f0815d7e34592c64be','createIndex indexName=cohort_member_creator, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-140','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',138,'EXECUTED','8:606356b2cb0496204c4d88883957bd25','createIndex indexName=concept_attribute_attribute_type_id_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-141','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',139,'EXECUTED','8:1e05001c3a7a9e8a9eb97183fc608c2b','createIndex indexName=concept_attribute_changed_by_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-142','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',140,'EXECUTED','8:5f96f8798e5b7b9da72c45b3dc81ac9d','createIndex indexName=concept_attribute_concept_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-143','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',141,'EXECUTED','8:c89c712442a89f2d07ea21f6b60ffc1a','createIndex indexName=concept_attribute_creator_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-144','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',142,'EXECUTED','8:c10f39874bf68963958a72412fe6bcac','createIndex indexName=concept_attribute_type_changed_by_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-145','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',143,'EXECUTED','8:28845acfb2c6fa84d47ce725c57f8794','createIndex indexName=concept_attribute_type_creator_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-146','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',144,'EXECUTED','8:edf32967a9d82155a0ea8dd8eb2ab6e1','createIndex indexName=concept_attribute_type_retired_by_fk, tableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-147','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',145,'EXECUTED','8:723ad3f4df5d4e3dfd3a85d5ab9b541e','createIndex indexName=concept_attribute_voided_by_fk, tableName=concept_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-148','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',146,'EXECUTED','8:4074c61d6b4dae4ab5df098dc9546d7b','createIndex indexName=concept_class_changed_by, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-149','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',147,'EXECUTED','8:d2fe72bcd363d8819fae99cfa833b6bb','createIndex indexName=concept_class_creator, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-150','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',148,'EXECUTED','8:6e676415380fef7f1ac0d9f9033aca69','createIndex indexName=concept_class_name_index, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-151','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',149,'EXECUTED','8:38e8f613e1b7a518ba6ed47e80e6f8ca','createIndex indexName=concept_class_retired_status, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-152','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',150,'EXECUTED','8:b74346ab17f12599f02e5bea00781e31','createIndex indexName=concept_classes, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-153','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',151,'EXECUTED','8:f302942598e5281d4edaa8eab7b4ade4','createIndex indexName=concept_creator, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-154','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',152,'EXECUTED','8:8af66bd30f40514f5663229d3f558a52','createIndex indexName=concept_datatype_creator, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-155','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',153,'EXECUTED','8:0eb97161e6a7cea441a2ed63e804feaa','createIndex indexName=concept_datatype_name_index, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-156','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',154,'EXECUTED','8:988e10b41ee14ab190aabac3111ecc84','createIndex indexName=concept_datatype_retired_status, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-157','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',155,'EXECUTED','8:e9d6fb1e47328e7d59c1ddbf308dea70','createIndex indexName=concept_datatypes, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-158','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',156,'EXECUTED','8:b245869dccd4b5adbc79240f66334db4','createIndex indexName=concept_for_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-159','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',157,'EXECUTED','8:b47fb81e5fd807f6999454f313e4fb88','createIndex indexName=concept_for_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-160','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',158,'EXECUTED','8:9d6067722574739babcf829fd7005083','createIndex indexName=concept_map_type_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-161','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',159,'EXECUTED','8:446797c99cbd566e631792db3f446eb0','createIndex indexName=concept_name_changed_by, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-162','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',160,'EXECUTED','8:fe80f22f46e05ec71478e7ce7c665681','createIndex indexName=concept_name_tag_changed_by, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-163','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',161,'EXECUTED','8:97a9fac7c24c6ceb695c173082b6de53','createIndex indexName=concept_reference_source_changed_by, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-164','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',162,'EXECUTED','8:983653514a7c9e3c9e7cb3f06f845759','createIndex indexName=concept_reference_term_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-165','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',163,'EXECUTED','8:11669081562535928754bc5bcc11a180','createIndex indexName=concept_source_creator, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-166','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',164,'EXECUTED','8:87a8f1b58cf4f932acdd05c7e1590ff4','createIndex indexName=concept_triggers_conversion, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-167','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',165,'EXECUTED','8:7369c064030a14e98be1c1b9dd0680bb','createIndex indexName=condition_changed_by_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-168','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',166,'EXECUTED','8:b3b1a267e2f70b822a9ea1dfe6755b1e','createIndex indexName=condition_condition_coded_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-169','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',167,'EXECUTED','8:babb1074f32abb1122b552ca0eda2abd','createIndex indexName=condition_condition_coded_name_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-170','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',168,'EXECUTED','8:e2bda57c42c5a9bf7c854a67b55bf3c7','createIndex indexName=condition_creator_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-171','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',169,'EXECUTED','8:ee4160d92a93933a9b2d17ff9f6b60c5','createIndex indexName=condition_patient_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-172','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',170,'EXECUTED','8:1aa6149355334eb5629ba66c9f4e8488','createIndex indexName=condition_previous_version_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-173','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',171,'EXECUTED','8:a0f5c5a8139591a6dfaa0ebdcb1abf91','createIndex indexName=condition_voided_by_fk, tableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-174','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',172,'EXECUTED','8:9036796f0a8298a97e6ebbbb44f60269','createIndex indexName=conversion_to_state, tableName=concept_state_conversion','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-175','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',173,'EXECUTED','8:ca5f8b4206708c7a0b265ec52b2036f1','createIndex indexName=defines_attribute_type, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-176','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:29',174,'EXECUTED','8:0e8c8a71f1d7106ab0ee2b7a4e9c1a8e','createIndex indexName=defines_identifier_type, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-177','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',175,'EXECUTED','8:21f248120c7e245a62a62a73f0bca3ac','createIndex indexName=description_for_concept, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-178','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',176,'EXECUTED','8:3947bfa70f2dd628ef3693ef16865e27','createIndex indexName=discontinued_because, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-179','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',177,'EXECUTED','8:16bae96e0a9575b80f7436b65b3c901f','createIndex indexName=dosage_form_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-180','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',178,'EXECUTED','8:aa2f3c125c218015850faf6902216f15','createIndex indexName=drug_changed_by, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-181','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',179,'EXECUTED','8:7923f05b615200e9a0074c5891d30bf9','createIndex indexName=drug_creator, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-182','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',180,'EXECUTED','8:12c2cab925c834a4e3cfd42d35177396','createIndex indexName=drug_dose_limit_units_fk, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-183','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',181,'EXECUTED','8:5504067b12cf6ae817487a6ca5d52d1d','createIndex indexName=drug_for_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-184','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',182,'EXECUTED','8:b3ff030e8d493d861782b7f31a050e0f','createIndex indexName=drug_ingredient_ingredient_id_fk, tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-185','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',183,'EXECUTED','8:bb3a92181d3b62e7473b880f3d1091c8','createIndex indexName=drug_ingredient_units_fk, tableName=drug_ingredient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-186','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',184,'EXECUTED','8:2247879088e4582d25b5375883a3831b','createIndex indexName=drug_order_dose_units, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-187','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',185,'EXECUTED','8:a120dbdf3e345dca7ed6ad9f16ee5ee2','createIndex indexName=drug_order_duration_units_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-188','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',186,'EXECUTED','8:3b8d08a476c29d5fd436f49598aeff80','createIndex indexName=drug_order_frequency_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-189','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',187,'EXECUTED','8:6abde870ce9c60dbf78776b3ab7b0747','createIndex indexName=drug_order_quantity_units, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-190','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',188,'EXECUTED','8:5962c1ccc35a4201ad511c5972e4d773','createIndex indexName=drug_order_route_fk, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-191','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',189,'EXECUTED','8:194d1348aad83d4663ff157b6980811b','createIndex indexName=drug_reference_map_creator, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-192','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',190,'EXECUTED','8:7197cb961f010b43e23b0f22fcc8f111','createIndex indexName=drug_retired_by, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-193','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',191,'EXECUTED','8:31c423c71c17e8760f26658c86d6f6e3','createIndex indexName=encounter_changed_by, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-194','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',192,'EXECUTED','8:4afd4079efd3ff663172a71a656cb0af','createIndex indexName=encounter_datetime_idx, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-195','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',193,'EXECUTED','8:dede34974de7f23b44244760df684f5a','createIndex indexName=encounter_diagnosis_changed_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-196','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',194,'EXECUTED','8:ce1e96338f2fd38358218a1b00930ecf','createIndex indexName=encounter_diagnosis_coded_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-197','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',195,'EXECUTED','8:4cf956666910b129c0ba36fc14010d11','createIndex indexName=encounter_diagnosis_coded_name_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-198','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',196,'EXECUTED','8:18e31313b0721289a6b9f980c3483ecc','createIndex indexName=encounter_diagnosis_condition_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-199','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',197,'EXECUTED','8:558a51844de3da4468a37e556f88550c','createIndex indexName=encounter_diagnosis_creator_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-200','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',198,'EXECUTED','8:ba1b9af8999b961c8bd24b959adda690','createIndex indexName=encounter_diagnosis_encounter_id_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-201','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',199,'EXECUTED','8:4751d44aad47533f7134557462f454d1','createIndex indexName=encounter_diagnosis_patient_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-202','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',200,'EXECUTED','8:517763278ae916a8f65aeb738b9071cb','createIndex indexName=encounter_diagnosis_voided_by_fk, tableName=encounter_diagnosis','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-203','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',201,'EXECUTED','8:82914cb547a4e291a05eff545a62e372','createIndex indexName=encounter_for_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-204','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',202,'EXECUTED','8:dfea9f5ed02652ffc5e82180f2b5992e','createIndex indexName=encounter_form, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-205','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',203,'EXECUTED','8:6a5edd213c96575bd6da0b995778673c','createIndex indexName=encounter_ibfk_1, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-206','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',204,'EXECUTED','8:dda7f3b1c8972a907b426fd36ba0602e','createIndex indexName=encounter_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-207','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',205,'EXECUTED','8:1b085e5a93b7f65318144bdce78c779a','createIndex indexName=encounter_location, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-208','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',206,'EXECUTED','8:3c53772159fdf4203993da96963deb97','createIndex indexName=encounter_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-209','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',207,'EXECUTED','8:4336db4180aeb8bb560bc2d8c97f6a73','createIndex indexName=encounter_observations, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-210','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',208,'EXECUTED','8:c12352d4cf4efd3d17dd66f10d27d583','createIndex indexName=encounter_patient, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-211','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',209,'EXECUTED','8:672cc0e9cd6fea831298ed3ffaf45b10','createIndex indexName=encounter_provider_changed_by, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-212','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',210,'EXECUTED','8:d77e3dc635af12b46d4053e839f9e56a','createIndex indexName=encounter_provider_creator, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-213','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',211,'EXECUTED','8:eda86bd1660dca81f84a0dd9779884f4','createIndex indexName=encounter_provider_voided_by, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-214','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',212,'EXECUTED','8:a0c736f940893bf5c0a56c15d99d7e21','createIndex indexName=encounter_role_changed_by_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-215','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',213,'EXECUTED','8:3b49284874dfe876e87273e8f2688bed','createIndex indexName=encounter_role_creator_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-216','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',214,'EXECUTED','8:a4a01769a58e5cd2dbd901d9b72c6dac','createIndex indexName=encounter_role_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-217','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',215,'EXECUTED','8:4d72025c8c4bac3cd6be806e49d67b7c','createIndex indexName=encounter_role_retired_by_fk, tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-218','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',216,'EXECUTED','8:9d45a4c24d04a5d65220c7f89899c24a','createIndex indexName=encounter_type_changed_by, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-219','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',217,'EXECUTED','8:c5a4bab1f539bd4ced495c005c1a6f7f','createIndex indexName=encounter_type_id, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-220','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',218,'EXECUTED','8:06769795c33557f4889394fc30179450','createIndex indexName=encounter_type_retired_status, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-221','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',219,'EXECUTED','8:1a50f14ad002e48115436ef3665f4c43','createIndex indexName=encounter_visit_id_fk, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-222','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',220,'EXECUTED','8:d37207a166aaca60d194ee966bc7e120','createIndex indexName=family_name2, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-223','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',221,'EXECUTED','8:d4aa398734c837519572e6fcb143f355','createIndex indexName=field_answer_concept, tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-224','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',222,'EXECUTED','8:5dd4c8d34f9c8e04b99ccb7c2d12598f','createIndex indexName=field_retired_status, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-225','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',223,'EXECUTED','8:3b5c94c711a49af9fb71d08971423bb8','createIndex indexName=field_within_form, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-226','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',224,'EXECUTED','8:38c45e1e9f4030e9e93022f6dc4ed350','createIndex indexName=first_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-227','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',225,'EXECUTED','8:5fcbc0fefca2b7bb36b0d15a0eb99e8f','createIndex indexName=fk_orderer_provider, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-228','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',226,'EXECUTED','8:92329d4c3a194f8543b93d67fccecd19','createIndex indexName=form_containing_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-229','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',227,'EXECUTED','8:a8c8db5b52aa3122f0d65888b7700398','createIndex indexName=form_encounter_type, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-230','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',228,'EXECUTED','8:5fd7daba08733913b3e5dcf044c4a82a','createIndex indexName=form_field_hierarchy, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-231','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',229,'EXECUTED','8:c8a1b0aeda085a3c343812e6e2daa18d','createIndex indexName=form_published_and_retired_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-232','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',230,'EXECUTED','8:024161f440c8e3fbbf85b098b439ae3f','createIndex indexName=form_published_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-233','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',231,'EXECUTED','8:4c6571095e0adeb94f37286e43b5b9d2','createIndex indexName=form_resource_changed_by, tableName=form_resource','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-234','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',232,'EXECUTED','8:023c3e2259f8bb56b2a1cb4a8c35a867','createIndex indexName=form_retired_index, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-235','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',233,'EXECUTED','8:077ed81c7d1f405c4ac4eac7e218fa43','createIndex indexName=global_property_changed_by, tableName=global_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-236','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',234,'EXECUTED','8:43a5867d586a7bb3465aa89d95198815','createIndex indexName=has_a, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-237','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',235,'EXECUTED','8:117418151837815057613901205a080b','createIndex indexName=hl7_in_archive_message_state_idx, tableName=hl7_in_archive','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-238','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',236,'EXECUTED','8:6d3741d2da44192d82d16931f1ac6ac3','createIndex indexName=hl7_source_with_queue, tableName=hl7_in_queue','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-239','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',237,'EXECUTED','8:d95090902ac2b5d451f06d171c4cbf17','createIndex indexName=identifier_creator, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-240','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',238,'EXECUTED','8:5f75e8eaf134aa378d6abed32e7ffef2','createIndex indexName=identifier_name, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-241','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',239,'EXECUTED','8:27c4e5b6e65968bc70a736d1c002ee4f','createIndex indexName=identifier_voider, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-242','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',240,'EXECUTED','8:85e6b78d6cd2d2b38288c093ed45a50c','createIndex indexName=identifies_person, tableName=person_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-243','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',241,'EXECUTED','8:d2ad7f39efadf4ae6e8cc21e028d3ae2','createIndex indexName=idx_code_concept_reference_term, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-244','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',242,'EXECUTED','8:604f6d74b4b564008d52f4e4724025e0','createIndex indexName=idx_concept_set_concept, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-245','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',243,'EXECUTED','8:073d2de556dcb0d7069d64fc1ac853ac','createIndex indexName=idx_patient_identifier_patient, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-246','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',244,'EXECUTED','8:a7118f2301f4b24a6342ef5b45ff9310','createIndex indexName=inherited_role, tableName=role_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-247','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',245,'EXECUTED','8:adebe6e37634bbab5e47e52c6f001b6e','createIndex indexName=inventory_item, tableName=drug_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-248','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',246,'EXECUTED','8:9ab129f6cd9a2eb318aa9b6188e10a05','createIndex indexName=last_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-249','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',247,'EXECUTED','8:7116fd0aa0d86192591b5b05562321f7','createIndex indexName=location_attribute_attribute_type_id_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-250','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',248,'EXECUTED','8:55a0e386a302774eb39a51199113f194','createIndex indexName=location_attribute_changed_by_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-251','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',249,'EXECUTED','8:73ff410750d5bd6be3065cf8872da7ad','createIndex indexName=location_attribute_creator_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-252','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',250,'EXECUTED','8:49f63762203223d15f120ef9e10e0d37','createIndex indexName=location_attribute_location_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-253','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',251,'EXECUTED','8:9f081da2d2b5de2bde1c4fffa582c2ff','createIndex indexName=location_attribute_type_changed_by_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-254','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',252,'EXECUTED','8:dc08777f447f2daa7b3882f86c1bc70e','createIndex indexName=location_attribute_type_creator_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-255','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',253,'EXECUTED','8:08cd9b26671410fa217fcbda4a00df29','createIndex indexName=location_attribute_type_retired_by_fk, tableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-256','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',254,'EXECUTED','8:a8104ab3f954e872c1e57069d16b49ba','createIndex indexName=location_attribute_voided_by_fk, tableName=location_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-257','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',255,'EXECUTED','8:f7bfde79464fa0eef95da29ea2ce350e','createIndex indexName=location_changed_by, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-258','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',256,'EXECUTED','8:da61c541398842b05fb3fdc5a2d44825','createIndex indexName=location_retired_status, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-259','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',257,'EXECUTED','8:a76d70c3f03f3db902cc9fb070564974','createIndex indexName=location_tag_changed_by, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-260','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',258,'EXECUTED','8:c1e4a003467d3a7586507788c79d6632','createIndex indexName=location_tag_creator, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-261','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',259,'EXECUTED','8:40cceeab104549fd7756a182c7b31fce','createIndex indexName=location_tag_map_tag, tableName=location_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-262','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',260,'EXECUTED','8:af9d4ce6100a5afe145c856afc419037','createIndex indexName=location_tag_retired_by, tableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-263','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',261,'EXECUTED','8:b88c90f1f923cde2f9e5b575bc897d24','createIndex indexName=map_creator, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-264','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',262,'EXECUTED','8:aaec6329d2d4888261e450178f7169e0','createIndex indexName=map_for_concept, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-265','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',263,'EXECUTED','8:30d99738aea457ba6229a7b6f5e20cbd','createIndex indexName=mapped_concept_map_type, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-266','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',264,'EXECUTED','8:10e3e6f6299728e62066649948857d9a','createIndex indexName=mapped_concept_map_type_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-267','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',265,'EXECUTED','8:51f56c62985729cfea11d79bef2c188b','createIndex indexName=mapped_concept_name, tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-268','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',266,'EXECUTED','8:d83c81bd65c2723b6e2db5d44a0c99b1','createIndex indexName=mapped_concept_name_tag, tableName=concept_name_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-269','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',267,'EXECUTED','8:b0c3a30b6d83eba35cc271b97bf2b88f','createIndex indexName=mapped_concept_proposal, tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-270','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',268,'EXECUTED','8:a3c3c7616093618de7f90a3bac2d27bc','createIndex indexName=mapped_concept_proposal_tag, tableName=concept_proposal_tag_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-271','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',269,'EXECUTED','8:17a6d1ea0726018afcd68f60d77159f4','createIndex indexName=mapped_concept_reference_term, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-272','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',270,'EXECUTED','8:9a0d34b3c6b7086cbc977a8be7baaff0','createIndex indexName=mapped_concept_source, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-273','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',271,'EXECUTED','8:b550cb7b0906479412351e273260ad7f','createIndex indexName=mapped_term_a, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-274','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',272,'EXECUTED','8:6e11a8dd0c3441dadbe67e7c9c68bf42','createIndex indexName=mapped_term_b, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-275','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',273,'EXECUTED','8:76d42b1c3a55e113b21aa47ccf41907e','createIndex indexName=mapped_user_changed, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-276','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',274,'EXECUTED','8:19b3d065a2f192cbe7698cdfdfec4eb0','createIndex indexName=mapped_user_changed_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-277','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',275,'EXECUTED','8:46f0c2de79abb084376f3d0dd760bbd5','createIndex indexName=mapped_user_changed_ref_term, tableName=concept_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-278','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',276,'EXECUTED','8:a2cf7b4567d193532eaefe2ce29aff62','createIndex indexName=mapped_user_changed_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-279','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',277,'EXECUTED','8:64ea4ebae8ea496a009d1f525367370a','createIndex indexName=mapped_user_creator, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-280','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',278,'EXECUTED','8:b3435d6dd1b7880e93aa5edcc74846c7','createIndex indexName=mapped_user_creator_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-281','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:30',279,'EXECUTED','8:3dc54f80ef612321c91462eccd3a55ec','createIndex indexName=mapped_user_creator_ref_term_map, tableName=concept_reference_term_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-282','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',280,'EXECUTED','8:0a3503af05a7bd7897d95be10c3b3688','createIndex indexName=mapped_user_retired, tableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-283','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',281,'EXECUTED','8:31d72025fbec4406f9f1cb7c1f033cdb','createIndex indexName=mapped_user_retired_concept_map_type, tableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-284','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',282,'EXECUTED','8:aad8af5f9b037c94eac525a386375b06','createIndex indexName=member_patient, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-285','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',283,'EXECUTED','8:bc24e713e119554b17147a3f6a2dfb93','createIndex indexName=middle_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-286','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',284,'EXECUTED','8:4ee87d8b126bd60cc9275e7f68c8015d','createIndex indexName=name_for_concept, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-287','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',285,'EXECUTED','8:b9d77080d671f9befc731734d1082d2c','createIndex indexName=name_for_person, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-288','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',286,'EXECUTED','8:e1cf3551a6093982be076e202c877bea','createIndex indexName=name_of_attribute, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-289','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',287,'EXECUTED','8:f20bfdf41671ea836878754bf85cefaf','createIndex indexName=name_of_concept, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-290','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',288,'EXECUTED','8:6ab3606ad0d1274f0f855eb01769c936','createIndex indexName=name_of_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-291','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',289,'EXECUTED','8:04a2e1643f8c67411cae4177290f22b5','createIndex indexName=note_hierarchy, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-292','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',290,'EXECUTED','8:502b5e5c51859e2eec91b875bc9abcb0','createIndex indexName=obs_concept, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-293','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',291,'EXECUTED','8:722b0dba4b61dcab30b52c887cf9e0b8','createIndex indexName=obs_datetime_idx, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-294','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',292,'EXECUTED','8:dce7042a64be9d3a55a5cbcf432e7bf5','createIndex indexName=obs_enterer, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-295','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',293,'EXECUTED','8:2c33da9c17d2eaeaee93fc90591b033d','createIndex indexName=obs_grouping_id, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-296','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',294,'EXECUTED','8:d84954ea35e785f43984207b617ed02f','createIndex indexName=obs_location, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-297','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',295,'EXECUTED','8:b5a33a8491f791f267384902aa798522','createIndex indexName=obs_name_of_coded_value, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-298','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',296,'EXECUTED','8:83f5de226100f7e8c6ee067396be02a7','createIndex indexName=obs_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-299','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',297,'EXECUTED','8:a192ac50b1fd406192f9924692d4b796','createIndex indexName=obs_order, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-300','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',298,'EXECUTED','8:0c18f787da491494b46284585cd17820','createIndex indexName=order_creator, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-301','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',299,'EXECUTED','8:1667c90052e388e32df606174648c13a','createIndex indexName=order_for_patient, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-302','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',300,'EXECUTED','8:c7b2f400292b0f1b2b3371c9c64e46f1','createIndex indexName=order_frequency_changed_by_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-303','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',301,'EXECUTED','8:9dce146c0bdb56e141c57d01f0a3d7a6','createIndex indexName=order_frequency_creator_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-304','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',302,'EXECUTED','8:87f2104877646004907ff88af1d0f110','createIndex indexName=order_frequency_retired_by_fk, tableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-305','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',303,'EXECUTED','8:a6d743bf0f9e2a56558455fa5a1d87fa','createIndex indexName=order_group_changed_by_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-306','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',304,'EXECUTED','8:a1aafa6be68646d6461ea2ffbf1a8eaa','createIndex indexName=order_group_creator_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-307','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',305,'EXECUTED','8:1fd62bd470c97ec9131e196ac9cb2653','createIndex indexName=order_group_encounter_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-308','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',306,'EXECUTED','8:b5d584dae229bb43b3d5dfac96ff4baa','createIndex indexName=order_group_patient_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-309','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',307,'EXECUTED','8:3f6b7823a7e57010dc4b96a25697e015','createIndex indexName=order_group_set_id_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-310','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',308,'EXECUTED','8:a2b48e2bbe4c1757ae3a99938d81eac5','createIndex indexName=order_group_voided_by_fk, tableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-311','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',309,'EXECUTED','8:a5912184a23044851e8ef42a1b48a7e4','createIndex indexName=order_set_changed_by_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-312','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',310,'EXECUTED','8:fb89530b109069ba8be1c3bb717c2121','createIndex indexName=order_set_creator_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-313','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',311,'EXECUTED','8:a9f9b14070164cc2407c05f8d78b0aa2','createIndex indexName=order_set_member_changed_by_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-314','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',312,'EXECUTED','8:9e380798192199cc558dcf76b86ee383','createIndex indexName=order_set_member_concept_id_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-315','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',313,'EXECUTED','8:ab47cf75996ecd79d4f3e7d51add4f85','createIndex indexName=order_set_member_creator_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-316','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',314,'EXECUTED','8:a4486ddcf3e2bfe7c2af98f689f999f0','createIndex indexName=order_set_member_order_set_id_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-317','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',315,'EXECUTED','8:c33913fec57162ef1d536665aefaa1c4','createIndex indexName=order_set_member_order_type_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-318','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',316,'EXECUTED','8:2038b70c44473ef106edbf302edd26a4','createIndex indexName=order_set_member_retired_by_fk, tableName=order_set_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-319','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',317,'EXECUTED','8:e6296cd5b7a15e29ffbcde45a4cd0268','createIndex indexName=order_set_retired_by_fk, tableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-320','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',318,'EXECUTED','8:8cd746d20e2d3f0cfb478b8fbb3b7976','createIndex indexName=order_type_changed_by, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-321','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',319,'EXECUTED','8:f2dc37c519d6795fd871c18435980f70','createIndex indexName=order_type_parent_order_type, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-322','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',320,'EXECUTED','8:644ef92f3d47d365532eff9953db9793','createIndex indexName=order_type_retired_status, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-323','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',321,'EXECUTED','8:ecd6c3abe3ba7670d05bb4f66036e2d0','createIndex indexName=orders_care_setting, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-324','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',322,'EXECUTED','8:d43c7046b4cc96fb2bab5c015230ea82','createIndex indexName=orders_in_encounter, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-325','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',323,'EXECUTED','8:411231af101070ffc908d7c86640b5de','createIndex indexName=orders_order_group_id_fk, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-326','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',324,'EXECUTED','8:b015ed6aaed23eda9c8e04dad894a859','createIndex indexName=parent_cohort, tableName=cohort_member','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-327','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',325,'EXECUTED','8:7bd03f793dfec28e378b4c7b5f193b83','createIndex indexName=parent_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-328','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',326,'EXECUTED','8:e9b88deaeac31b0432fbd4d4d483691e','createIndex indexName=patient_address_creator, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-329','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',327,'EXECUTED','8:4afe3b113bc16965b318ebd554a09bc8','createIndex indexName=patient_address_void, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-330','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',328,'EXECUTED','8:ace943334658479bf77701411c6be732','createIndex indexName=patient_identifier_changed_by, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-331','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',329,'EXECUTED','8:6d42130aab478c32de45a24a4bac2a24','createIndex indexName=patient_identifier_ibfk_2, tableName=patient_identifier','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-332','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',330,'EXECUTED','8:95435cb6c7ff578eb26059b6a7321f72','createIndex indexName=patient_identifier_type_changed_by, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-333','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',331,'EXECUTED','8:38fdd8b1bdea75698ea31430790b340e','createIndex indexName=patient_identifier_type_retired_status, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-334','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',332,'EXECUTED','8:dcfc5706248f1defc7ea124dbef8ec14','createIndex indexName=patient_in_program, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-335','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',333,'EXECUTED','8:0ef5c8042260eb5634b1665a3f970dc8','createIndex indexName=patient_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-336','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',334,'EXECUTED','8:f6981472e24eb69ed6a696561588fd0e','createIndex indexName=patient_program_attribute_attributetype_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-337','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',335,'EXECUTED','8:f449c5e93c69745dc202a964eb95b43f','createIndex indexName=patient_program_attribute_changed_by_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-338','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',336,'EXECUTED','8:2beba5b0be222efca6a121d118a4ab09','createIndex indexName=patient_program_attribute_creator_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-339','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',337,'EXECUTED','8:958d8644d04dcbe96aad90bb7ca4eed6','createIndex indexName=patient_program_attribute_programid_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-340','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',338,'EXECUTED','8:4b4e07cc31c923fa37f0caaa8bf323df','createIndex indexName=patient_program_attribute_voided_by_fk, tableName=patient_program_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-341','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',339,'EXECUTED','8:ef920ed5a34363bd9ece75f6eb9071d7','createIndex indexName=patient_program_creator, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-342','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',340,'EXECUTED','8:2ce117f1b4c309dd58b48915890bba97','createIndex indexName=patient_program_for_state, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-343','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',341,'EXECUTED','8:5e6d0c02499f229cf931498b8c6ae898','createIndex indexName=patient_program_location_id, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-344','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',342,'EXECUTED','8:e28c5452f1d034a0ad4f3cf5a0f1df95','createIndex indexName=patient_program_outcome_concept_id_fk, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-345','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',343,'EXECUTED','8:e1cab1a84a4e9594b95d9eb6e9643932','createIndex indexName=patient_state_changer, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-346','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',344,'EXECUTED','8:59094c6a8698fa471c9b14945960111a','createIndex indexName=patient_state_creator, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-347','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',345,'EXECUTED','8:f61e718deb4467f134397c85a65cd48c','createIndex indexName=patient_state_voider, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-348','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',346,'EXECUTED','8:c4934fbf7bce4899a852b7e2ac7a0c62','createIndex indexName=person_a_is_person, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-349','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',347,'EXECUTED','8:b66c5278a9277f8055bf6e303d4276e8','createIndex indexName=person_address_changed_by, tableName=person_address','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-350','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',348,'EXECUTED','8:f3ec96539a9c6fa4a8e93f2387d65b25','createIndex indexName=person_attribute_type_retired_status, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-351','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',349,'EXECUTED','8:32c296ff73a60f3b9f44519f4e05ada3','createIndex indexName=person_b_is_person, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-352','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',350,'EXECUTED','8:0ffc099ac596e6a1e0623448a12d32b7','createIndex indexName=person_birthdate, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-353','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',351,'EXECUTED','8:5d335cd48c9c3622ecdbc9398fba5a49','createIndex indexName=person_death_date, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-354','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',352,'EXECUTED','8:fa9376ea58b6f400fd7b37c634f8439e','createIndex indexName=person_died_because, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-355','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',353,'EXECUTED','8:af83ca3362c3219a38a424b25e6cb9a0','createIndex indexName=person_id_for_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-356','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',354,'EXECUTED','8:10e7a7009c8a68479c8b5d3a3bd723e1','createIndex indexName=person_merge_log_changed_by_fk, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-357','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',355,'EXECUTED','8:aeba6374ce79692cc6c4afdbcbdae230','createIndex indexName=person_merge_log_creator, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-358','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',356,'EXECUTED','8:44d3661ba03f1283fd7ad325dac42206','createIndex indexName=person_merge_log_loser, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-359','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',357,'EXECUTED','8:c85e6c020114981ada1c3e475de966c4','createIndex indexName=person_merge_log_voided_by_fk, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-360','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',358,'EXECUTED','8:03ad1a480aa9c0448d3fd383e831beff','createIndex indexName=person_merge_log_winner, tableName=person_merge_log','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-361','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',359,'EXECUTED','8:f7b462971b2248a9a77bd476ce5591dc','createIndex indexName=person_obs, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-362','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',360,'EXECUTED','8:87b5dc4984cd482af28b829d4a3411e5','createIndex indexName=previous_order_id_order_id, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-363','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',361,'EXECUTED','8:481f14ae80e10723e8cdd4d957a32b18','createIndex indexName=previous_version, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-364','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',362,'EXECUTED','8:8b988fc20cd05cce87dfca918a67a853','createIndex indexName=primary_drug_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-365','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',363,'EXECUTED','8:8035e065236d99f2120a0e0ae7e00e19','createIndex indexName=privilege_definitions, tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-366','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',364,'EXECUTED','8:569e556b5127fb85bbd2f762b8abcb0d','createIndex indexName=privilege_which_can_edit, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-367','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',365,'EXECUTED','8:b2d66237cf16273ca43a279787abd289','createIndex indexName=privilege_which_can_edit_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-368','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',366,'EXECUTED','8:0bad7afd4996f4532aabecc55c05c6f9','createIndex indexName=privilege_which_can_view_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-369','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',367,'EXECUTED','8:1b95d72f022d870a00e7a1306eaed6af','createIndex indexName=program_attribute_type_changed_by_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-370','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',368,'EXECUTED','8:0666dfeda180082f4a8ce20d4672aabb','createIndex indexName=program_attribute_type_creator_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-371','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',369,'EXECUTED','8:cb4803b0dcbc70a13a2bf54dd7b04c93','createIndex indexName=program_attribute_type_retired_by_fk, tableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-372','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',370,'EXECUTED','8:4fceeddc65527f6aff2db27629515acc','createIndex indexName=program_concept, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-373','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',371,'EXECUTED','8:c860ac227d0114f62112a04072c5d8b3','createIndex indexName=program_creator, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-374','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',372,'EXECUTED','8:fc67efa5176469047ee0366b3cf61606','createIndex indexName=program_for_patient, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-375','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:31',373,'EXECUTED','8:802d71f2abb2ed1c9596adaefa80f25a','createIndex indexName=program_for_workflow, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-376','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',374,'EXECUTED','8:6de848917d554d43146c6d60ce7c1654','createIndex indexName=program_outcomes_concept_id_fk, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-377','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',375,'EXECUTED','8:a40909e40fd6c37a4c77d0db07af0c35','createIndex indexName=proposal_obs_concept_id, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-378','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',376,'EXECUTED','8:97f396dababa47ad282f35d66387010f','createIndex indexName=proposal_obs_id, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-379','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',377,'EXECUTED','8:7878b52a263400367ae2f19ee2ffea2c','createIndex indexName=provider_attribute_attribute_type_id_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-380','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',378,'EXECUTED','8:b1e716f65494df103352dce39165d467','createIndex indexName=provider_attribute_changed_by_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-381','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',379,'EXECUTED','8:1a3991173a1a6c1cbedcfd8f38b23d46','createIndex indexName=provider_attribute_creator_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-382','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',380,'EXECUTED','8:2f926bc27f17c6b5761c743e12bc4704','createIndex indexName=provider_attribute_provider_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-383','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',381,'EXECUTED','8:c82699b775351d2324ca4f3797bd2aa0','createIndex indexName=provider_attribute_type_changed_by_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-384','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',382,'EXECUTED','8:c8769a761efe89c1327d1f45c3e6804b','createIndex indexName=provider_attribute_type_creator_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-385','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',383,'EXECUTED','8:5a015c038de4e1bfb150845cc8dcd1fd','createIndex indexName=provider_attribute_type_retired_by_fk, tableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-386','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',384,'EXECUTED','8:071b3b36b034dde1fb3eac03d76dc3c2','createIndex indexName=provider_attribute_voided_by_fk, tableName=provider_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-387','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',385,'EXECUTED','8:28391123e016ecedc9e92aaa7002a9a5','createIndex indexName=provider_changed_by_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-388','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',386,'EXECUTED','8:6150efa0ff3b5fd0ac858125c1a470ce','createIndex indexName=provider_creator_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-389','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',387,'EXECUTED','8:14b0b358db728ed4432e8de5dc0909e4','createIndex indexName=provider_id_fk, tableName=encounter_provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-390','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',388,'EXECUTED','8:60671017da9f7c68ceeb70574da92295','createIndex indexName=provider_person_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-391','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',389,'EXECUTED','8:d1b4399b5599817e9b1159107eefe938','createIndex indexName=provider_retired_by_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-392','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',390,'EXECUTED','8:0faeedc4e3cb554ffcfb7d184a9b8ca5','createIndex indexName=provider_role_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-393','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',391,'EXECUTED','8:3b20f44b1dbc5ad8f3bd825b45e89984','createIndex indexName=provider_speciality_id_fk, tableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-394','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',392,'EXECUTED','8:c1d0126a6bf573cae8fcb664270333c7','createIndex indexName=relation_creator, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-395','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',393,'EXECUTED','8:727751987bccbb0bd271dcb57a46e2f3','createIndex indexName=relation_voider, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-396','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',394,'EXECUTED','8:02c1b06ef9c6be308a00d4df8da55eb6','createIndex indexName=relationship_changed_by, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-397','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',395,'EXECUTED','8:975371d15b7b0a5e52af044c7d3f6a28','createIndex indexName=relationship_type_changed_by, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-398','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',396,'EXECUTED','8:2f66bc5bb41570ae45a5ab255469fcd4','createIndex indexName=relationship_type_id, tableName=relationship','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-399','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',397,'EXECUTED','8:60c176b60dcff5580d0f22a012633b25','createIndex indexName=report_object_creator, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-400','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',398,'EXECUTED','8:7c638e546bd699a279d62b0d36489c57','createIndex indexName=role_definitions, tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-401','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',399,'EXECUTED','8:c89862f1966d03c0884d245fdaf4a88f','createIndex indexName=role_privilege_to_role, tableName=role_privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-402','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',400,'EXECUTED','8:58a56ac393d2f6c48126a8adba8a9a66','createIndex indexName=route_concept, tableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-403','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',401,'EXECUTED','8:345907215bab087d0035d000afa9a514','createIndex indexName=scheduler_changer, tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-404','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',402,'EXECUTED','8:8ba6f3cf03f4489d612f25773dcad889','createIndex indexName=scheduler_creator, tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-405','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',403,'EXECUTED','8:99d9e2f3721be928d0c43ca256e12728','createIndex indexName=serialized_object_changed_by, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-406','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',404,'EXECUTED','8:dc694719e402b67c9639afee8af3b75c','createIndex indexName=serialized_object_creator, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-407','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',405,'EXECUTED','8:7437d93c8757fb55aa919bf21b456a0f','createIndex indexName=serialized_object_retired_by, tableName=serialized_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-408','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',406,'EXECUTED','8:e8e2d575a45d7de72c502acc8d6c006c','createIndex indexName=state_changed_by, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-409','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',407,'EXECUTED','8:3f7b636456460832ee260a18eb162a6c','createIndex indexName=state_concept, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-410','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',408,'EXECUTED','8:81fc984d8bff19515079254bdfce4802','createIndex indexName=state_creator, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-411','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',409,'EXECUTED','8:f2c40d95494570530e077694d500fbba','createIndex indexName=state_for_patient, tableName=patient_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-412','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',410,'EXECUTED','8:11c673d5fe793dde11022be10f69d93f','createIndex indexName=task_config_for_property, tableName=scheduler_task_config_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-413','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',411,'EXECUTED','8:0b3d1d47a36a661b8367b2d90e21e362','createIndex indexName=test_order_frequency_fk, tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-414','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',412,'EXECUTED','8:cee34c547f13180783fb9f02e79a28e0','createIndex indexName=test_order_specimen_source_fk, tableName=test_order','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-415','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',413,'EXECUTED','8:30777b65a5778c2830ab812ea875d684','createIndex indexName=type_created_by, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-416','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',414,'EXECUTED','8:4f750963d8d22945764a40f9349c9bb9','createIndex indexName=type_creator, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-417','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',415,'EXECUTED','8:72c791b5132cf0715a6f75e6339c2780','createIndex indexName=type_of_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-418','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',416,'EXECUTED','8:2635f2461e75c0f71a74049ee425d379','createIndex indexName=type_of_order, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-419','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',417,'EXECUTED','8:98a1414be57317ab27d544e18c5ff1a8','createIndex indexName=user_creator, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-420','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',418,'EXECUTED','8:6a79b0e1a0cf53e5fe69cd7e9fdb1a23','createIndex indexName=user_role_to_users, tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-421','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',419,'EXECUTED','8:4916c9528fc492d433ad57cef358518d','createIndex indexName=user_who_changed, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-422','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',420,'EXECUTED','8:2dcbd1f067b5fe3c83c2613efd2d1ce3','createIndex indexName=user_who_changed_alert, tableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-423','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',421,'EXECUTED','8:c22cb21d67fe46c765e31421cbdbba78','createIndex indexName=user_who_changed_cohort, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-424','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',422,'EXECUTED','8:12e40bf834814c64bd67441cc66450b8','createIndex indexName=user_who_changed_concept, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-425','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',423,'EXECUTED','8:97f4d48da9b98a9797f11bd2e121e3bb','createIndex indexName=user_who_changed_description, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-426','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',424,'EXECUTED','8:31934f744d48a9d20bbd99af206f3666','createIndex indexName=user_who_changed_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-427','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',425,'EXECUTED','8:1b013a4f078f3b18bba0c97bd807be90','createIndex indexName=user_who_changed_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-428','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',426,'EXECUTED','8:84e66526131ba5b2f75ef7b0a475cb97','createIndex indexName=user_who_changed_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-429','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',427,'EXECUTED','8:3b0867d2fa7c5bbfa2e0151ff998c0a9','createIndex indexName=user_who_changed_pat, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-430','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',428,'EXECUTED','8:0122464ab2e25489a251a835254933b2','createIndex indexName=user_who_changed_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-431','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',429,'EXECUTED','8:295451a8413d60bf3a126b7c0a377dec','createIndex indexName=user_who_changed_program, tableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-432','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',430,'EXECUTED','8:2a9363c78f4846cf41045c6f203573b8','createIndex indexName=user_who_changed_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-433','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',431,'EXECUTED','8:80eaf4b1de0dda76c24bf41ada886534','createIndex indexName=user_who_changed_report_object, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-434','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',432,'EXECUTED','8:d08c61d242968617b703fc25d88d2c97','createIndex indexName=user_who_changed_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-435','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',433,'EXECUTED','8:e9b1959ae3773a7b5381225a307b25a7','createIndex indexName=user_who_created, tableName=concept_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-436','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',434,'EXECUTED','8:dec84946e9ef350fee9bf9e564565ae7','createIndex indexName=user_who_created_description, tableName=concept_description','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-437','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',435,'EXECUTED','8:2267a0e2ef7c5c12e1136d8fc58ee817','createIndex indexName=user_who_created_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-438','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',436,'EXECUTED','8:cc980da2d5334af135b31baab720a8b7','createIndex indexName=user_who_created_field_answer, tableName=field_answer','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-439','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',437,'EXECUTED','8:b4e1b4ef31eed23b036e69759ed6d362','createIndex indexName=user_who_created_field_type, tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-440','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',438,'EXECUTED','8:4c9ab7f6f116fb6d180165aa4314c4f9','createIndex indexName=user_who_created_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-441','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',439,'EXECUTED','8:d1435b63968d4ac2ff7656d2f26c596d','createIndex indexName=user_who_created_form_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-442','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',440,'EXECUTED','8:d60b12848c9dbbf1c87a640ba1f1464e','createIndex indexName=user_who_created_hl7_source, tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-443','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',441,'EXECUTED','8:77e3f63aae12ba9d898a35ab6fe95592','createIndex indexName=user_who_created_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-444','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',442,'EXECUTED','8:e5b1e2c2a208fc667cab964139db2a5b','createIndex indexName=user_who_created_name, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-445','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',443,'EXECUTED','8:482b94f4c8a17498c0ea738a069e3b64','createIndex indexName=user_who_created_name_tag, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-446','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',444,'EXECUTED','8:b7ac3e14096bec7ec7488c25b0f3a459','createIndex indexName=user_who_created_note, tableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-447','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',445,'EXECUTED','8:831f45000783dbdccbd088d9f1fe2b94','createIndex indexName=user_who_created_patient, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-448','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',446,'EXECUTED','8:cf226ccbf7971a8a9ca0d248d495ba02','createIndex indexName=user_who_created_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-449','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',447,'EXECUTED','8:35887a2b53f4cdfc1d6bfbdf1f08c935','createIndex indexName=user_who_created_proposal, tableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-450','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',448,'EXECUTED','8:4f2fdf3f432374182921e1e7549ec23c','createIndex indexName=user_who_created_rel, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-451','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',449,'EXECUTED','8:2e9acebbfe25234f77fb27d8073d54a3','createIndex indexName=user_who_created_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-452','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',450,'EXECUTED','8:efc6dd67eaa7c5c4d10a3ec3a31b6ffb','createIndex indexName=user_who_last_changed_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-453','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',451,'EXECUTED','8:3626af26aefa67355dbdc1443c425dc9','createIndex indexName=user_who_last_changed_form_field, tableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-454','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',452,'EXECUTED','8:dba003f29a0c1a018bb4d6b19bb8ea82','createIndex indexName=user_who_made_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-455','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',453,'EXECUTED','8:596d63992b7500d2857ff9b591a5867a','createIndex indexName=user_who_retired_concept, tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-456','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',454,'EXECUTED','8:22c383f0c05fdab71781e7a590e548e6','createIndex indexName=user_who_retired_concept_class, tableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-457','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',455,'EXECUTED','8:38342c5f7d175b5085fe7779daed6a25','createIndex indexName=user_who_retired_concept_datatype, tableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-458','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',456,'EXECUTED','8:6b4329d504bbeef8d05f63c829474fa5','createIndex indexName=user_who_retired_concept_source, tableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-459','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',457,'EXECUTED','8:be03b0886a60a4801fd01afe63879796','createIndex indexName=user_who_retired_drug_reference_map, tableName=drug_reference_map','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-460','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',458,'EXECUTED','8:e16cbf2b5aaefb822e1077ad4752fcd7','createIndex indexName=user_who_retired_encounter_type, tableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-461','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',459,'EXECUTED','8:cc548a866306eedbab3ba3ccd03d87fa','createIndex indexName=user_who_retired_field, tableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-462','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',460,'EXECUTED','8:81ce0f64dd3f0a7e91dcdbdeefd2eabf','createIndex indexName=user_who_retired_form, tableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-463','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',461,'EXECUTED','8:b71173f28e535bf7348e6a3c7557dd7b','createIndex indexName=user_who_retired_location, tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-464','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',462,'EXECUTED','8:6372653c2c49f52453fbf46af792d8a8','createIndex indexName=user_who_retired_order_type, tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-465','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',463,'EXECUTED','8:d3e96ecd89da6c8fe015b2574708eca0','createIndex indexName=user_who_retired_patient_identifier_type, tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-466','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',464,'EXECUTED','8:d833b27872a872339fc8028162d0cdc8','createIndex indexName=user_who_retired_person_attribute_type, tableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-467','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',465,'EXECUTED','8:7fd5577476509af77746aecc8b078ab6','createIndex indexName=user_who_retired_relationship_type, tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-468','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',466,'EXECUTED','8:1d661628f98b448fce38d7aa3e0bede7','createIndex indexName=user_who_retired_this_user, tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-469','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',467,'EXECUTED','8:5852f80d0e0ef4359873f542c2747a63','createIndex indexName=user_who_voided_cohort, tableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-470','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',468,'EXECUTED','8:ab96b9937398cd4e1449dec3506e528e','createIndex indexName=user_who_voided_encounter, tableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-471','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',469,'EXECUTED','8:2bf627a24b3a4101ad2cf42aebc6f170','createIndex indexName=user_who_voided_name, tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-472','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',470,'EXECUTED','8:988da7b1d6f2c4056885ecfcf0f9a57d','createIndex indexName=user_who_voided_name_tag, tableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-473','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',471,'EXECUTED','8:2219bbfb05637be221bef4bc9a853477','createIndex indexName=user_who_voided_obs, tableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-474','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',472,'EXECUTED','8:9e19e62c8650a5aefb0e6c2602764586','createIndex indexName=user_who_voided_order, tableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-475','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',473,'EXECUTED','8:6e61ed99aa6f483b97bd3d01301171f9','createIndex indexName=user_who_voided_patient, tableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-476','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',474,'EXECUTED','8:35bb5780c5059d400cac524f0301abd0','createIndex indexName=user_who_voided_patient_program, tableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-477','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',475,'EXECUTED','8:714686779f3d31877568eccb91700375','createIndex indexName=user_who_voided_person, tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-478','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',476,'EXECUTED','8:9eeded0707368de50c3ee0add3c2e8b2','createIndex indexName=user_who_voided_report_object, tableName=report_object','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-479','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',477,'EXECUTED','8:3f9860528ccc3a3ae04d7e8aca6f44e1','createIndex indexName=user_who_voided_this_name, tableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-480','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',478,'EXECUTED','8:b9a65b7ab309bdd46ba4f2c449115ff7','createIndex indexName=visit_attribute_attribute_type_id_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-481','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',479,'EXECUTED','8:abb19811e24e0f8e496c1fa04d44c32e','createIndex indexName=visit_attribute_changed_by_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-482','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',480,'EXECUTED','8:a2626b27d70186539932878526685946','createIndex indexName=visit_attribute_creator_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-483','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',481,'EXECUTED','8:303466c6d7bf9f3da0b0d284d6ceb254','createIndex indexName=visit_attribute_type_changed_by_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-484','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',482,'EXECUTED','8:9e79bc736ad1da58baa5e7e6a7865b63','createIndex indexName=visit_attribute_type_creator_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-485','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',483,'EXECUTED','8:d7b6dd39ec5c3dbd6ede2a3c125c2109','createIndex indexName=visit_attribute_type_retired_by_fk, tableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-486','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',484,'EXECUTED','8:7abf34988c450d665e0cdeb647f80119','createIndex indexName=visit_attribute_visit_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-487','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:32',485,'EXECUTED','8:a988a83b44131d10905757c01b41d39e','createIndex indexName=visit_attribute_voided_by_fk, tableName=visit_attribute','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-488','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',486,'EXECUTED','8:ed5026748c07dc69aa88ee02efc0d531','createIndex indexName=visit_changed_by_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-489','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',487,'EXECUTED','8:821728f2ac5511a778103702e2758d66','createIndex indexName=visit_creator_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-490','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',488,'EXECUTED','8:3c6b43e507d00b5bfb092c11eb16b0ec','createIndex indexName=visit_indication_concept_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-491','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',489,'EXECUTED','8:026070962492dcdc88e33096b8f34690','createIndex indexName=visit_location_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-492','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',490,'EXECUTED','8:fe8454bcd5df128318c029e22ad9e9ea','createIndex indexName=visit_patient_index, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-493','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',491,'EXECUTED','8:422143f23d4dd075db333a41c242fe94','createIndex indexName=visit_type_changed_by, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-494','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',492,'EXECUTED','8:d334a839fdff81402550989673440de6','createIndex indexName=visit_type_creator, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-495','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',493,'EXECUTED','8:42aae037b40bfe2fae6e57dba78e4381','createIndex indexName=visit_type_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-496','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',494,'EXECUTED','8:f947d1867f95025430145d95911af633','createIndex indexName=visit_type_retired_by, tableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-497','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',495,'EXECUTED','8:c4045e420af7ca5b14cf317fd211cda1','createIndex indexName=visit_voided_by_fk, tableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-498','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',496,'EXECUTED','8:3d95ff0d3142092fa058978762d39599','createIndex indexName=workflow_changed_by, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-499','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',497,'EXECUTED','8:3000c224f29f0dae2ab9005d36b178a0','createIndex indexName=workflow_concept, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-500','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',498,'EXECUTED','8:6bcb3a192f7a5cf3c1ace2f3bd41cd77','createIndex indexName=workflow_creator, tableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-501','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',499,'EXECUTED','8:eb75a8f45e6abce58d20c2215b7e4f14','createIndex indexName=workflow_for_state, tableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-502','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',500,'EXECUTED','8:b6e1c8e8fc47af4830e99c9013b80fb2','addForeignKeyConstraint baseTableName=person_address, constraintName=address_for_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-503','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',501,'EXECUTED','8:1ec946ec8939be01efbbb88cf8fa56f9','addForeignKeyConstraint baseTableName=notification_alert, constraintName=alert_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-504','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',502,'EXECUTED','8:39db8f28c8000a553adb6ba15530c4b6','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=alert_read_by_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-505','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',503,'EXECUTED','8:973d36344c1dfc1c9b50e8e088c0652a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-506','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',504,'EXECUTED','8:a8a2bfcfcd93cbed9981ac64456f5854','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_coded_allergen_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-507','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',505,'EXECUTED','8:25b1d85ad004674ca5a2eb96e5c42fb2','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-508','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',506,'EXECUTED','8:b8da87293e10f64fcfe4746997cf1194','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_patient_id_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-509','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:33',507,'EXECUTED','8:da9b1b2931d5cb6d8467df67e4170771','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_allergy_id_fk, referencedTableName=allergy','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-510','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',508,'EXECUTED','8:23d4467b422513efd10b68ef30607187','addForeignKeyConstraint baseTableName=allergy_reaction, constraintName=allergy_reaction_reaction_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-511','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',509,'EXECUTED','8:0b98d57fb66075dffdc6f0327b0ed51a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_severity_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-512','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',510,'EXECUTED','8:76c04d554dccd13fe1668f569b17e62a','addForeignKeyConstraint baseTableName=allergy, constraintName=allergy_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-513','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',511,'EXECUTED','8:bacea2a759845361696795b01b15a774','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-514','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',512,'EXECUTED','8:5425a5305a81c382842f827738b2eba7','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_answer_drug_fk, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-515','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',513,'EXECUTED','8:d08eeab2acb74694acb823d3bd33683c','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-516','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',514,'EXECUTED','8:993ba5f29b8b033d85f2d67278b91aeb','addForeignKeyConstraint baseTableName=obs, constraintName=answer_concept_drug, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-517','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',515,'EXECUTED','8:ff36e32f75908f129f488a847418993a','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answer_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-518','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',516,'EXECUTED','8:99814a0e717b6e85599784487fa515ed','addForeignKeyConstraint baseTableName=concept_answer, constraintName=answers_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-519','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',517,'EXECUTED','8:f654d22286db16b023d7c8efc12b6dbd','addForeignKeyConstraint baseTableName=field_answer, constraintName=answers_for_field, referencedTableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-520','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',518,'EXECUTED','8:8604b3b4fb3677cd5d849d27de8f6747','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-521','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',519,'EXECUTED','8:1f3af68eb9a72c0828976c0c988bc2ef','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-522','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',520,'EXECUTED','8:35eada7bb99cf639a17421fc86975d2a','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-523','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',521,'EXECUTED','8:5564f9398f0cb98de98d54685d56f91d','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=attribute_type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-524','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',522,'EXECUTED','8:fd53f94868cf335848f17cc5af41ebe6','addForeignKeyConstraint baseTableName=person_attribute, constraintName=attribute_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-525','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',523,'EXECUTED','8:6ff79c01470986df7e6fd8389a055b34','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-526','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',524,'EXECUTED','8:d5d65fa61eacf27e22c3b73bf4964280','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-527','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',525,'EXECUTED','8:1262c08379f097648c81983b83c828ab','addForeignKeyConstraint baseTableName=care_setting, constraintName=care_setting_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-528','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',526,'EXECUTED','8:14f51cb7024cf4b9d0cf5de40b1bd656','addForeignKeyConstraint baseTableName=order_set, constraintName=category_order_set_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-529','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',527,'EXECUTED','8:28f0560443db9c0778378585f3aba7c0','addForeignKeyConstraint baseTableName=cohort, constraintName=cohort_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-530','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:34',528,'EXECUTED','8:3b4adf2a5b7f7ceb9a15070e9a5a9dea','addForeignKeyConstraint baseTableName=cohort_member, constraintName=cohort_member_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-531','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',529,'EXECUTED','8:676a6c5d4e74361903a325056751786c','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_attribute_type_id_fk, referencedTableName=concept_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-532','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',530,'EXECUTED','8:12553549877cfe05e628cc81edc92430','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-533','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',531,'EXECUTED','8:8f623fcdb9898edc0c01116c3e0246b7','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_concept_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-534','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',532,'EXECUTED','8:d78557d92aea1aab6f039afdd95277f6','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-535','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',533,'EXECUTED','8:d5726b2f1d411facb9f9cc2b4c1c8d74','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-536','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',534,'EXECUTED','8:d8810b69d852f158a0a6a8d090746c1d','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-537','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',535,'EXECUTED','8:4732421cdb4b33ae6a472a42ab7e5ac7','addForeignKeyConstraint baseTableName=concept_attribute_type, constraintName=concept_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-538','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',536,'EXECUTED','8:2818e68c416aa6371d7f7f2e0d5bf4a8','addForeignKeyConstraint baseTableName=concept_attribute, constraintName=concept_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-539','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',537,'EXECUTED','8:2a31268e8389ead337d01f761437ef02','addForeignKeyConstraint baseTableName=concept_complex, constraintName=concept_attributes, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-540','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',538,'EXECUTED','8:649f717179083bfdd1724cef6b4bae49','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-541','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',539,'EXECUTED','8:16116d24f478ae4256a3f4cd89ddf1b8','addForeignKeyConstraint baseTableName=concept_class, constraintName=concept_class_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-542','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',540,'EXECUTED','8:aa266368ce23dab47453fe16faf532fc','addForeignKeyConstraint baseTableName=concept, constraintName=concept_classes, referencedTableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-543','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',541,'EXECUTED','8:ae87e3825b9e50d9e517b0730d8283a9','addForeignKeyConstraint baseTableName=concept, constraintName=concept_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-544','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',542,'EXECUTED','8:d103964c3dc48330db9e9a25c14291bf','addForeignKeyConstraint baseTableName=concept_datatype, constraintName=concept_datatype_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-545','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',543,'EXECUTED','8:f373e4b204964bdfe5f5bd88655f08ca','addForeignKeyConstraint baseTableName=concept, constraintName=concept_datatypes, referencedTableName=concept_datatype','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-546','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',544,'EXECUTED','8:da92ad33e8b6e0303f010ea16f828c4f','addForeignKeyConstraint baseTableName=field, constraintName=concept_for_field, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-547','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',545,'EXECUTED','8:c903a4ac7b7d7c3af47dff734b968c05','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=concept_for_proposal, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-548','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',546,'EXECUTED','8:1754fb36a03905b0820d15547552be80','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_map_type_for_drug_reference_map, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-549','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',547,'EXECUTED','8:f8cc69b9aaf639c2a557ed449dafb707','addForeignKeyConstraint baseTableName=concept_name, constraintName=concept_name_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-550','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',548,'EXECUTED','8:a0b92c973cbe7a7186c5b1b3247c8324','addForeignKeyConstraint baseTableName=concept_name_tag, constraintName=concept_name_tag_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-551','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',549,'EXECUTED','8:7f55c49f252271863a74efec5dca6963','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_reference_source_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-552','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',550,'EXECUTED','8:8200585e5fc54aad32f7e13429a7b028','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=concept_reference_term_for_drug_reference_map, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-553','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',551,'EXECUTED','8:45d8c4a52f4c4ae3d8a2bff4c1781651','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=concept_source_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-554','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',552,'EXECUTED','8:00339eef1ba1912570d3ea905417c5b1','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=concept_triggers_conversion, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-555','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',553,'EXECUTED','8:e85ae80b67cfd4db417e33e318701d3c','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-556','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',554,'EXECUTED','8:ab139110539c388d66a8f2f0013d1b0b','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-557','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',555,'EXECUTED','8:58d73cee6c614043fb3733e0dbe6d479','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_condition_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-558','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',556,'EXECUTED','8:bc12d124077f87e9da7cdb1e8ef07f1e','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-559','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:35',557,'EXECUTED','8:aa7b42a352b4fc7b59f2d8229b1c5bb6','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-560','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',558,'EXECUTED','8:2090aa26bbe56d51c4b25f009036d3cd','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_previous_version_fk, referencedTableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-561','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',559,'EXECUTED','8:a6662d3138a91c5451f019920120b309','addForeignKeyConstraint baseTableName=conditions, constraintName=condition_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-562','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',560,'EXECUTED','8:c45d4124278063454e28412966c3d075','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_involves_workflow, referencedTableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-563','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',561,'EXECUTED','8:f783ec8d57cab054d9d241495c7cdcab','addForeignKeyConstraint baseTableName=concept_state_conversion, constraintName=conversion_to_state, referencedTableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-564','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',562,'EXECUTED','8:af744a99c04da67bf99e80174bebe15f','addForeignKeyConstraint baseTableName=person_attribute, constraintName=defines_attribute_type, referencedTableName=person_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-565','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',563,'EXECUTED','8:faed525320f2f83c920d665a965001e5','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=defines_identifier_type, referencedTableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-566','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',564,'EXECUTED','8:09c26ff9f5c725b7cb40b0c494295c95','addForeignKeyConstraint baseTableName=concept_description, constraintName=description_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-567','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',565,'EXECUTED','8:105fb4739f59d253dc1a015f98cd10d4','addForeignKeyConstraint baseTableName=orders, constraintName=discontinued_because, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-568','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',566,'EXECUTED','8:3830fd8cdd434be82eaac016e4edab36','addForeignKeyConstraint baseTableName=drug, constraintName=dosage_form_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-569','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',567,'EXECUTED','8:d03afbcbe53ba5021acef4dd28552fb7','addForeignKeyConstraint baseTableName=drug, constraintName=drug_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-570','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',568,'EXECUTED','8:5231d12b016b67bfb9e12b2d17abbfe6','addForeignKeyConstraint baseTableName=drug, constraintName=drug_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-571','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',569,'EXECUTED','8:f4810867e925ce07cf7d723360968d1a','addForeignKeyConstraint baseTableName=drug, constraintName=drug_dose_limit_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-572','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',570,'EXECUTED','8:a6c3f0bd9a47a1717f792d0578b70e2f','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_for_drug_reference_map, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-573','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',571,'EXECUTED','8:d662c80d9c600f694ddaea7c0192f451','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_drug_id_fk, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-574','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',572,'EXECUTED','8:36e2d9e76e86ddcbea122d2e144cdbd9','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_ingredient_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-575','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',573,'EXECUTED','8:34084dad7a3a236ceebdb83b3a9e0c1f','addForeignKeyConstraint baseTableName=drug_ingredient, constraintName=drug_ingredient_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-576','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',574,'EXECUTED','8:c44f51f79df5d4e0468b64f40b5e4f97','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_dose_units, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-577','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',575,'EXECUTED','8:b33243e95f8262831338df6e20a6d881','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_duration_units_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-578','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',576,'EXECUTED','8:53cd923fbefd9a4dd6733945a28a9b62','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_frequency_fk, referencedTableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-579','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',577,'EXECUTED','8:0b31914637b8b4e844a556d5c1ea031a','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_quantity_units, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-580','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',578,'EXECUTED','8:c7f6ed748327e9baac7ed7953d18ec1c','addForeignKeyConstraint baseTableName=drug_order, constraintName=drug_order_route_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-581','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',579,'EXECUTED','8:0253b90367453adf19c09c3013fb8dc3','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=drug_reference_map_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-582','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',580,'EXECUTED','8:4dc230f5d02486b8d9c58ae8a01628fc','addForeignKeyConstraint baseTableName=drug, constraintName=drug_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-583','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',581,'EXECUTED','8:f143d21018358409bb9581c3e29fc160','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-584','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',582,'EXECUTED','8:e25f3380836582dc8052bc1c445f8b60','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-585','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',583,'EXECUTED','8:e8554f1f03f07ee3cd1f6b7fe3bf493e','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-586','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',584,'EXECUTED','8:da2a7be9e55bd45cd780a8df20af60d4','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_coded_name_fk, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-587','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',585,'EXECUTED','8:c5afe7b601dafc0c40a3cad845fe64fc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_condition_id_fk, referencedTableName=conditions','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-588','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',586,'EXECUTED','8:36b1ccb71ae92fd5223d074da16d632b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-589','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',587,'EXECUTED','8:801acff9a2798f43e2a3641139ad113b','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-590','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',588,'EXECUTED','8:8aa55bb7c0d793aa392b59f9f93e99ee','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-591','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',589,'EXECUTED','8:02bd0156780b3e6d53cc1e4bb4dce8cc','addForeignKeyConstraint baseTableName=encounter_diagnosis, constraintName=encounter_diagnosis_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-592','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',590,'EXECUTED','8:3970a663eed3b6c3f188662c64edc543','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=encounter_for_proposal, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-593','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',591,'EXECUTED','8:210039b231ee3c0e460e0218988e91cc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_form, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-594','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',592,'EXECUTED','8:e22246ade5c0e680a0e498c71dd213b7','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_ibfk_1, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-595','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',593,'EXECUTED','8:a67709326ffdec1fb396b1945a70027b','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-596','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',594,'EXECUTED','8:e97e2d0264ee91758e2c6fba9d8c4588','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-597','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',595,'EXECUTED','8:012e16d01037b4d01bfb7116d59a8291','addForeignKeyConstraint baseTableName=note, constraintName=encounter_note, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-598','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',596,'EXECUTED','8:2d63bc1fade593ead70c0eea87128c8c','addForeignKeyConstraint baseTableName=obs, constraintName=encounter_observations, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-599','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:36',597,'EXECUTED','8:c7012fabbc2393f393eda9ce1520fd2b','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-600','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',598,'EXECUTED','8:541ce5d1093fdecc87ecc8a765cc324f','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-601','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',599,'EXECUTED','8:76deded3b3e88e71af862e958685591a','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-602','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',600,'EXECUTED','8:d5db7b8e7b82e7ac83321c0f7db7fdaa','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_provider_voided_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-603','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',601,'EXECUTED','8:316c689f0dd949635c6b461d6da844cb','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-604','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',602,'EXECUTED','8:aad73f4eac8d37b4ff91cfae56647778','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-605','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',603,'EXECUTED','8:6b5d33f7502fa361cccb208ba3ca9612','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=encounter_role_id_fk, referencedTableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-606','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',604,'EXECUTED','8:63c33f11d1048f4a376ee1988bedcb22','addForeignKeyConstraint baseTableName=encounter_role, constraintName=encounter_role_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-607','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',605,'EXECUTED','8:e85bacc187b63072f286b97de56ed71d','addForeignKeyConstraint baseTableName=encounter_type, constraintName=encounter_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-608','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',606,'EXECUTED','8:4ecf31c173230b5b38207132ccc18bfd','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_type_id, referencedTableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-609','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',607,'EXECUTED','8:01343cf01ebe1e2d3fb1fe460d1b52fc','addForeignKeyConstraint baseTableName=encounter, constraintName=encounter_visit_id_fk, referencedTableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-610','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',608,'EXECUTED','8:fde37b9094cc447bbef2e81aea9d5f9a','addForeignKeyConstraint baseTableName=drug_order, constraintName=extends_order, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-611','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',609,'EXECUTED','8:15986d2715766d22ca5aee2fc0fb9760','addForeignKeyConstraint baseTableName=field_answer, constraintName=field_answer_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-612','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',610,'EXECUTED','8:40aac8b7fd4955579e5a4335c1ad496e','addForeignKeyConstraint baseTableName=form_field, constraintName=field_within_form, referencedTableName=field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-613','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',611,'EXECUTED','8:0fc24b5eb57987ea58550b45692a876d','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_class_map_concept_class_concept_class_id, referencedTableName=concept_class','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-614','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',612,'EXECUTED','8:f8ff2cf7060d71390dd68da84014956c','addForeignKeyConstraint baseTableName=order_type_class_map, constraintName=fk_order_type_order_type_id, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-615','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',613,'EXECUTED','8:d6a297a45ab7034c4550d06b241d10a9','addForeignKeyConstraint baseTableName=orders, constraintName=fk_orderer_provider, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-616','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',614,'EXECUTED','8:d4002ab7f9a0f0a7d4276f208e5496c7','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=fk_patient_id_patient_identifier, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-617','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',615,'EXECUTED','8:058ade5e67a5e4c9f6774fe26e41cb70','addForeignKeyConstraint baseTableName=form_field, constraintName=form_containing_field, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-618','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',616,'EXECUTED','8:02b36c3723f68bc2b4bdd77b801e3b70','addForeignKeyConstraint baseTableName=form, constraintName=form_encounter_type, referencedTableName=encounter_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-619','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',617,'EXECUTED','8:6e714deb4047c385619bb35497f4dc4e','addForeignKeyConstraint baseTableName=form_field, constraintName=form_field_hierarchy, referencedTableName=form_field','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-620','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',618,'EXECUTED','8:ff86dcb00584315dbb04c6e51c410bb5','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-621','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',619,'EXECUTED','8:ae518a8608ae65f4606e10547d866504','addForeignKeyConstraint baseTableName=form_resource, constraintName=form_resource_form_fk, referencedTableName=form','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-622','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',620,'EXECUTED','8:66a6f7b82373f3c0c08a68a662f0b4af','addForeignKeyConstraint baseTableName=global_property, constraintName=global_property_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-623','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',621,'EXECUTED','8:0a584ebf18cd8dbc521ecb2689f0a1ac','addForeignKeyConstraint baseTableName=concept_set, constraintName=has_a, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-624','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',622,'EXECUTED','8:fc455ba76ca852afe49f6e7ce37b1c9d','addForeignKeyConstraint baseTableName=hl7_in_queue, constraintName=hl7_source_with_queue, referencedTableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-625','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',623,'EXECUTED','8:de4d1a28261c165a0f1b8f0cd3e2c00b','addForeignKeyConstraint baseTableName=notification_alert_recipient, constraintName=id_of_alert, referencedTableName=notification_alert','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-626','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',624,'EXECUTED','8:b89d5041997285d87092384134d988e2','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-627','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',625,'EXECUTED','8:45b1f2e72faae44c6aabb846eb7a7990','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=identifier_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-628','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',626,'EXECUTED','8:1ec314a54566d8a1749a7ed7297cbda4','addForeignKeyConstraint baseTableName=person_attribute, constraintName=identifies_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-629','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',627,'EXECUTED','8:db807c956e45a33f21cc15672920101a','addForeignKeyConstraint baseTableName=role_role, constraintName=inherited_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-630','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',628,'EXECUTED','8:da5615ab343e9ed9a7d0604ff50bb049','addForeignKeyConstraint baseTableName=drug_order, constraintName=inventory_item, referencedTableName=drug','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-631','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',629,'EXECUTED','8:559103057592c513461e34872ab98c82','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_attribute_type_id_fk, referencedTableName=location_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-632','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',630,'EXECUTED','8:f0ed1db50d2aaef52d7787e729067765','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-633','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',631,'EXECUTED','8:9053697625cec4b7181154ede82af8e1','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-634','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:37',632,'EXECUTED','8:25fa762d4a54cb768494393188a40f13','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_location_fk, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-635','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',633,'EXECUTED','8:55bfc1c498d66b56056252e5e1bf38e3','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-636','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',634,'EXECUTED','8:caaf7c26f7283691746ca5cf776e17e1','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-637','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',635,'EXECUTED','8:b28edd14d548454ee5e31d5129932600','addForeignKeyConstraint baseTableName=location_attribute_type, constraintName=location_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-638','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',636,'EXECUTED','8:c9858f861bc729085245ab56d1db294c','addForeignKeyConstraint baseTableName=location_attribute, constraintName=location_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-639','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',637,'EXECUTED','8:9c5f3393d4a9a88d9b4bd434ea9e1033','addForeignKeyConstraint baseTableName=location, constraintName=location_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-640','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',638,'EXECUTED','8:0bd00341f91fb696b1bedccccd73f6c2','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-641','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',639,'EXECUTED','8:91fc0e963eae16130bcfdd515a5ae281','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-642','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',640,'EXECUTED','8:61c3eccfbd38970237b9757fb3002fb8','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-643','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',641,'EXECUTED','8:49c4b5a03214ea9e7195d1a5fcc2b353','addForeignKeyConstraint baseTableName=location_tag_map, constraintName=location_tag_map_tag, referencedTableName=location_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-644','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',642,'EXECUTED','8:4f3813eecf2d7b5e04f9863404258d84','addForeignKeyConstraint baseTableName=location_tag, constraintName=location_tag_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-645','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',643,'EXECUTED','8:c5fdb5309db2ec8e9ed2f0510c9c2138','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-646','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',644,'EXECUTED','8:4a43c5a94c750536bee6b283c505f829','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=map_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-647','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',645,'EXECUTED','8:54becb16ae94c3222c044550d5d6f056','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_map_type, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-648','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',646,'EXECUTED','8:2467bca4029d86bceb6827936123016a','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_concept_map_type_ref_term_map, referencedTableName=concept_map_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-649','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',647,'EXECUTED','8:2c8ee6ec62f93dcc0f2c5b8049c2302e','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-650','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',648,'EXECUTED','8:123dae6f3c1bdbba9f0e038a75cadd18','addForeignKeyConstraint baseTableName=concept_name_tag_map, constraintName=mapped_concept_name_tag, referencedTableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-651','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',649,'EXECUTED','8:6113bb795c41cd648452833ad0042a6f','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal, referencedTableName=concept_proposal','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-652','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',650,'EXECUTED','8:bb379d0d109c494e25d0aad46c4b708a','addForeignKeyConstraint baseTableName=concept_proposal_tag_map, constraintName=mapped_concept_proposal_tag, referencedTableName=concept_name_tag','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-653','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',651,'EXECUTED','8:d43ec007e993bc1ba8a32131d99c4934','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_concept_reference_term, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-654','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',652,'EXECUTED','8:082f379958b4b6b0b60f8dacf700120d','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_concept_source, referencedTableName=concept_reference_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-655','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',653,'EXECUTED','8:fbaa69db4de6c1eeb907ffe63b8c0c10','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_a, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-656','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',654,'EXECUTED','8:24f9c07d372054537e2a2ea87bd9631c','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_term_b, referencedTableName=concept_reference_term','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-657','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',655,'EXECUTED','8:30b7404b3900c6211bca9aed71900491','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_changed, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-658','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',656,'EXECUTED','8:57c58bfdec0f073948d2e817b630dcab','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_changed_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-659','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',657,'EXECUTED','8:c821ce1c018a6faf63dd71082055395e','addForeignKeyConstraint baseTableName=concept_reference_map, constraintName=mapped_user_changed_ref_term, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-660','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',658,'EXECUTED','8:5b7076881c0ac0cf99d8c95b7d444aee','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_changed_ref_term_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-661','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',659,'EXECUTED','8:a1638b45c453e9eb9a3b134bde3f7511','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-662','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',660,'EXECUTED','8:7de2f45294f47a0e11920b3b35c80afc','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_creator_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-663','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',661,'EXECUTED','8:8e584e915ed85cf967e02bba69ac0dc8','addForeignKeyConstraint baseTableName=concept_reference_term_map, constraintName=mapped_user_creator_ref_term_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-664','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',662,'EXECUTED','8:9134c8a4af26c7c2ea22247618bdfb40','addForeignKeyConstraint baseTableName=concept_reference_term, constraintName=mapped_user_retired, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-665','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',663,'EXECUTED','8:9cc8c64a1e7940f2bb38355dd376c886','addForeignKeyConstraint baseTableName=concept_map_type, constraintName=mapped_user_retired_concept_map_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-666','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',664,'EXECUTED','8:3d4258ef0daff9793f9a952fdffb0c41','addForeignKeyConstraint baseTableName=cohort_member, constraintName=member_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-667','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',665,'EXECUTED','8:666bc2a7c0279cbfd0305d8ff49ba8ee','addForeignKeyConstraint baseTableName=concept_name, constraintName=name_for_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-668','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',666,'EXECUTED','8:701e3bc4a6970fabf97dc342030a4c06','addForeignKeyConstraint baseTableName=person_name, constraintName=name_for_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-669','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',667,'EXECUTED','8:d1866f483f3bb96a94eac81896ac1953','addForeignKeyConstraint baseTableName=note, constraintName=note_hierarchy, referencedTableName=note','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-670','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:38',668,'EXECUTED','8:cb4d919e70133e597f64007fbf2948b3','addForeignKeyConstraint baseTableName=concept_numeric, constraintName=numeric_attributes, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-671','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',669,'EXECUTED','8:ce723ec131e65372d698e8f4f17c31ca','addForeignKeyConstraint baseTableName=obs, constraintName=obs_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-672','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',670,'EXECUTED','8:8f9bbcbadb0451fa6b7ce24203ce8657','addForeignKeyConstraint baseTableName=obs, constraintName=obs_enterer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-673','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',671,'EXECUTED','8:19db7630095b44733983eb4220261063','addForeignKeyConstraint baseTableName=obs, constraintName=obs_grouping_id, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-674','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',672,'EXECUTED','8:f3778f9e0c00c315c3800bc7b782a671','addForeignKeyConstraint baseTableName=obs, constraintName=obs_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-675','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',673,'EXECUTED','8:b25c922870449bd0907794c59d83e383','addForeignKeyConstraint baseTableName=obs, constraintName=obs_name_of_coded_value, referencedTableName=concept_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-676','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',674,'EXECUTED','8:04161767dc1175e6bcde6531da741346','addForeignKeyConstraint baseTableName=note, constraintName=obs_note, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-677','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',675,'EXECUTED','8:e470661ffd302542439b7eb3609111cd','addForeignKeyConstraint baseTableName=obs, constraintName=obs_order, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-678','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',676,'EXECUTED','8:2cb7f76a9d99495e812c39ec388a6bef','addForeignKeyConstraint baseTableName=orders, constraintName=order_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-679','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',677,'EXECUTED','8:d9ed04c8d5baddb3d68fb12d393837cc','addForeignKeyConstraint baseTableName=orders, constraintName=order_for_patient, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-680','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',678,'EXECUTED','8:82c1c50be676174f52ee01c3f08a6c97','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-681','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',679,'EXECUTED','8:1a5d93f4f0b06bd21bb8601483b68297','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-682','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',680,'EXECUTED','8:4e10969a38735815960341380ee10035','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-683','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',681,'EXECUTED','8:f1ccac259e4279e39ffaf281cb75e5ef','addForeignKeyConstraint baseTableName=order_frequency, constraintName=order_frequency_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-684','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',682,'EXECUTED','8:b06b7ad924250754d8e4ae05f8375ca6','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-685','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',683,'EXECUTED','8:db59f16b55000d806437669be4338965','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-686','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',684,'EXECUTED','8:801a71a6636913fac4ab3edba7b5ea43','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_encounter_id_fk, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-687','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',685,'EXECUTED','8:b51974fd7cb54147c5708857c63b5f4b','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_patient_id_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-688','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',686,'EXECUTED','8:054d2e2db4143462eeea6ad1e06e5356','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_set_id_fk, referencedTableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-689','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',687,'EXECUTED','8:1745fc0d80bb9bcbdb08abda3b6f7565','addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-690','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',688,'EXECUTED','8:07198ea1b745a2d72fcaa28d994e72b9','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-691','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',689,'EXECUTED','8:83e6ccf66b8ed79ba263a796dd149baf','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-692','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',690,'EXECUTED','8:94e75871390bb64fcccb47aa1725903c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-693','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',691,'EXECUTED','8:c8c694b06dd35f1da3426ac3181d9a74','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-694','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',692,'EXECUTED','8:384c4abbf62461cd49ef2dc527d12722','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-695','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',693,'EXECUTED','8:c6f489f4278cf19fa33e39a0cd31a101','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_set_id_fk, referencedTableName=order_set','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-696','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',694,'EXECUTED','8:2633d85c3af4c94cbf2301fd3146086c','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_order_type_fk, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-697','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',695,'EXECUTED','8:fef4d230928bf3ea7e4ece1161013076','addForeignKeyConstraint baseTableName=order_set_member, constraintName=order_set_member_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-698','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',696,'EXECUTED','8:8cacc6031f21735211f4abcd31ddd88f','addForeignKeyConstraint baseTableName=order_set, constraintName=order_set_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-699','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',697,'EXECUTED','8:b68e6a401034b93cf919550ae7c01236','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-700','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:39',698,'EXECUTED','8:8f9a1f9b5c29d91a7cfca6410ff23f99','addForeignKeyConstraint baseTableName=order_type, constraintName=order_type_parent_order_type, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-701','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',699,'EXECUTED','8:8a5e47f2adbd789c9b8ddbdefd413a27','addForeignKeyConstraint baseTableName=orders, constraintName=orders_care_setting, referencedTableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-702','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',700,'EXECUTED','8:b34eac879f2fb2d08e968218747ad8ab','addForeignKeyConstraint baseTableName=orders, constraintName=orders_in_encounter, referencedTableName=encounter','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-703','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',701,'EXECUTED','8:9bddd80656976d26e20202f8e5f0ffc8','addForeignKeyConstraint baseTableName=orders, constraintName=orders_order_group_id_fk, referencedTableName=order_group','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-704','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',702,'EXECUTED','8:8669298d0fbb0b0136fdd9233857d4ad','addForeignKeyConstraint baseTableName=cohort_member, constraintName=parent_cohort, referencedTableName=cohort','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-705','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',703,'EXECUTED','8:1438af742d5acc5940365ede8f3ceceb','addForeignKeyConstraint baseTableName=location, constraintName=parent_location, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-706','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',704,'EXECUTED','8:9fcbe6d2601cac51aa3f458d6a035c60','addForeignKeyConstraint baseTableName=role_role, constraintName=parent_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-707','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',705,'EXECUTED','8:1bd029cf8717e512c685cad38cf4d12b','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-708','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',706,'EXECUTED','8:06fa710137b97c922bfaab061ad9293c','addForeignKeyConstraint baseTableName=person_address, constraintName=patient_address_void, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-709','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',707,'EXECUTED','8:aab960ea913b6ddd3127c14baf73c823','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-710','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',708,'EXECUTED','8:17cb9af404062b01a5ab912efd281339','addForeignKeyConstraint baseTableName=patient_identifier, constraintName=patient_identifier_ibfk_2, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-711','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',709,'EXECUTED','8:c0b1f393954a90918f009d1cbc32cb63','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=patient_identifier_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-712','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',710,'EXECUTED','8:34dec67047f0a39b208918ec21db5893','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_in_program, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-713','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',711,'EXECUTED','8:9ee961926d38a101798bb447b92a6c2d','addForeignKeyConstraint baseTableName=note, constraintName=patient_note, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-714','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',712,'EXECUTED','8:52a51ec6cd1c0737ad6a5f719c910969','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_attributetype_fk, referencedTableName=program_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-715','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',713,'EXECUTED','8:e161fefafcfee7977591996d6a1c53d6','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-716','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',714,'EXECUTED','8:0bd38a9b69329f52f5468385a98d774f','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-717','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',715,'EXECUTED','8:60e5ba2f6405a0116d60c2a952a25190','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_programid_fk, referencedTableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-718','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',716,'EXECUTED','8:8f15d936795e44307bec87846cd65b00','addForeignKeyConstraint baseTableName=patient_program_attribute, constraintName=patient_program_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-719','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',717,'EXECUTED','8:391cfe0ab46ac6cea973cea3a3545e33','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-720','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',718,'EXECUTED','8:7bd5776b0be8fac9dc94dfb88f00da7f','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_program_for_state, referencedTableName=patient_program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-721','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',719,'EXECUTED','8:9190ba5bf9823cd885efa25a83a578d9','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_location_id, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-722','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',720,'EXECUTED','8:04b0bde679cb2101a63bd18d29aeee77','addForeignKeyConstraint baseTableName=patient_program, constraintName=patient_program_outcome_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-723','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',721,'EXECUTED','8:09c964b19c46ae35f0861344281d0d91','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-724','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',722,'EXECUTED','8:8b7ac0848be5c70d19764d59ca40aff4','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-725','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',723,'EXECUTED','8:b06ac13374b66e1d56e008b9dca28a88','addForeignKeyConstraint baseTableName=patient_state, constraintName=patient_state_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-726','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',724,'EXECUTED','8:4166e03396d5cdbee3c4ea94ba58bfa2','addForeignKeyConstraint baseTableName=relationship, constraintName=person_a_is_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-727','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',725,'EXECUTED','8:996e5f32a4912adeed25e0bd685f1269','addForeignKeyConstraint baseTableName=person_address, constraintName=person_address_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-728','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',726,'EXECUTED','8:d4d0032894d6ebee123d06ce5349464e','addForeignKeyConstraint baseTableName=relationship, constraintName=person_b_is_person, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-729','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',727,'EXECUTED','8:22477dea7d8ed4bbc85cc65f207ee05d','addForeignKeyConstraint baseTableName=person, constraintName=person_died_because, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-730','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',728,'EXECUTED','8:7d03edea9ef8a1f11bf2f6116a9f47fe','addForeignKeyConstraint baseTableName=patient, constraintName=person_id_for_patient, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-731','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',729,'EXECUTED','8:6138e932a8f7dc672b976c44a3c5619c','addForeignKeyConstraint baseTableName=users, constraintName=person_id_for_user, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-732','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',730,'EXECUTED','8:567fe452a2e7ae893a17afcc6103dd6f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-733','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',731,'EXECUTED','8:2ad1f60029f2ce1b182f59e5d4220425','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-734','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',732,'EXECUTED','8:0350eec9ec5bfdd57c8ad13fbf5bbb2d','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_loser, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-735','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',733,'EXECUTED','8:1c08d6a13ef8d9666cb6c1b83a73861f','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-736','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',734,'EXECUTED','8:f87ea09206b90f73bd071fb61cf567f4','addForeignKeyConstraint baseTableName=person_merge_log, constraintName=person_merge_log_winner, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-737','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',735,'EXECUTED','8:f0b2534406dbc50e53da76f45facc93e','addForeignKeyConstraint baseTableName=obs, constraintName=person_obs, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-738','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',736,'EXECUTED','8:70c3d0c0adaa5e68504b6f778c5dbc8c','addForeignKeyConstraint baseTableName=orders, constraintName=previous_order_id_order_id, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-739','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',737,'EXECUTED','8:8bfedf09577dff4983a279b26382c718','addForeignKeyConstraint baseTableName=obs, constraintName=previous_version, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-740','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:40',738,'EXECUTED','8:0e582969c42698d575c944782d71ec2c','addForeignKeyConstraint baseTableName=drug, constraintName=primary_drug_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-741','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',739,'EXECUTED','8:3504918956d1525b97cc077a5f91c544','addForeignKeyConstraint baseTableName=role_privilege, constraintName=privilege_definitions, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-742','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',740,'EXECUTED','8:d1bda4909128e34a7312587b02425cb6','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=privilege_which_can_edit, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-743','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',741,'EXECUTED','8:456e9cc829e92a93994e9029368d90f9','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_edit_encounter_type, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-744','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',742,'EXECUTED','8:8ce1f2486f15760dc9c942bb41cafadb','addForeignKeyConstraint baseTableName=encounter_type, constraintName=privilege_which_can_view_encounter_type, referencedTableName=privilege','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-745','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',743,'EXECUTED','8:cf0afb19ccd46f8be51d48a105be071c','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-746','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',744,'EXECUTED','8:d72f0c2b1ada2b3b917ebe3937480494','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-747','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',745,'EXECUTED','8:3b575ae1da7da6e2bef9733217b30260','addForeignKeyConstraint baseTableName=program_attribute_type, constraintName=program_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-748','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',746,'EXECUTED','8:e1259106d9e68fbc9f745ff166d0f607','addForeignKeyConstraint baseTableName=program, constraintName=program_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-749','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',747,'EXECUTED','8:83c1da42e28b3ee703b4ba9f7a135b52','addForeignKeyConstraint baseTableName=program, constraintName=program_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-750','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',748,'EXECUTED','8:04b4751737c937eff17ef2586b6c329c','addForeignKeyConstraint baseTableName=patient_program, constraintName=program_for_patient, referencedTableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-751','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',749,'EXECUTED','8:7b2cc29cbc7bcfee9385f6c53f6c6d6c','addForeignKeyConstraint baseTableName=program_workflow, constraintName=program_for_workflow, referencedTableName=program','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-752','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',750,'EXECUTED','8:3debc27e4493cc2fc2e55763a55fd7c6','addForeignKeyConstraint baseTableName=program, constraintName=program_outcomes_concept_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-753','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',751,'EXECUTED','8:0fb2cdfa9a72f2d9dccfc130f52f2d48','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_concept_id, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-754','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',752,'EXECUTED','8:da7e5963f137ab11e91395eb1741fbd8','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=proposal_obs_id, referencedTableName=obs','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-755','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',753,'EXECUTED','8:92a0046d7220d0babd6f79e0e9865916','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_attribute_type_id_fk, referencedTableName=provider_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-756','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',754,'EXECUTED','8:20003c0fdad7306a5e412886292a7c77','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-757','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',755,'EXECUTED','8:feb5a286ea545d2728cdf5c68111912e','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-758','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',756,'EXECUTED','8:0b35858ba17ecf9119cf411483e8daed','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_provider_fk, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-759','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',757,'EXECUTED','8:94a278f074a8888c6427057ccc32b1bb','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-760','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',758,'EXECUTED','8:11860c0597990b2c67542686de9d2cf6','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-761','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',759,'EXECUTED','8:8fdd1ede94e8599cf1d9fe227cfa8192','addForeignKeyConstraint baseTableName=provider_attribute_type, constraintName=provider_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-762','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',760,'EXECUTED','8:bbd0dc028d9a990920f3fede1a61b9d9','addForeignKeyConstraint baseTableName=provider_attribute, constraintName=provider_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-763','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',761,'EXECUTED','8:773a137334f412fdddd5794722a62d6f','addForeignKeyConstraint baseTableName=provider, constraintName=provider_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-764','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',762,'EXECUTED','8:678427eb05d7006cf4cb8ecbf476ae97','addForeignKeyConstraint baseTableName=provider, constraintName=provider_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-765','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',763,'EXECUTED','8:a98883bbc5a9e95b4b4339e582e68904','addForeignKeyConstraint baseTableName=encounter_provider, constraintName=provider_id_fk, referencedTableName=provider','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-766','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',764,'EXECUTED','8:a299d0163ac084da10e40fae6b26ceb7','addForeignKeyConstraint baseTableName=provider, constraintName=provider_person_id_fk, referencedTableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-767','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',765,'EXECUTED','8:cbcc38df4bb40d2f4a3e452ebe63066b','addForeignKeyConstraint baseTableName=provider, constraintName=provider_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-768','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',766,'EXECUTED','8:c5138ee0dee48dc58d500b894959d6de','addForeignKeyConstraint baseTableName=provider, constraintName=provider_role_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-769','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',767,'EXECUTED','8:14d6672acbc0af6d8c20c6078cd17978','addForeignKeyConstraint baseTableName=provider, constraintName=provider_speciality_id_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-770','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',768,'EXECUTED','8:953e367b53682b0551c7e40af2068510','addForeignKeyConstraint baseTableName=relationship, constraintName=relation_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-771','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:41',769,'EXECUTED','8:4736f9c1f0b4e23b49eafbd66940897e','addForeignKeyConstraint baseTableName=relationship, constraintName=relation_voider, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-772','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',770,'EXECUTED','8:859f426e7688f2a6e3650dbac0c8f391','addForeignKeyConstraint baseTableName=relationship, constraintName=relationship_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-773','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',771,'EXECUTED','8:42d2aecdf81a6beccdae99a76efa2b82','addForeignKeyConstraint baseTableName=relationship_type, constraintName=relationship_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-774','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',772,'EXECUTED','8:db79dc9316e5eff81facd0534df2e867','addForeignKeyConstraint baseTableName=relationship, constraintName=relationship_type_id, referencedTableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-775','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',773,'EXECUTED','8:e9a4a2686ab894f6d6d65b1403bba1be','addForeignKeyConstraint baseTableName=report_object, constraintName=report_object_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-776','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',774,'EXECUTED','8:3605be008701c5f97ed0b61c9e8476ba','addForeignKeyConstraint baseTableName=user_role, constraintName=role_definitions, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-777','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',775,'EXECUTED','8:ed35add50325e7e46d19eb06a86e3170','addForeignKeyConstraint baseTableName=role_privilege, constraintName=role_privilege_to_role, referencedTableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-778','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',776,'EXECUTED','8:c5e494e00386eed180600bd83720f4a8','addForeignKeyConstraint baseTableName=drug, constraintName=route_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-779','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',777,'EXECUTED','8:2471acb08411a2ed9b18e6d54e6d80af','addForeignKeyConstraint baseTableName=scheduler_task_config, constraintName=scheduler_changer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-780','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',778,'EXECUTED','8:91e35611e9aec46355a05e527e801108','addForeignKeyConstraint baseTableName=scheduler_task_config, constraintName=scheduler_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-781','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',779,'EXECUTED','8:306c6553b0165752abf8fc5692a40a1c','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-782','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',780,'EXECUTED','8:d776831690cd0c8ff682d473f4173ba6','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-783','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',781,'EXECUTED','8:7f585c84e6d7b418571133f2abcbe097','addForeignKeyConstraint baseTableName=serialized_object, constraintName=serialized_object_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-784','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',782,'EXECUTED','8:c4745e7a2ebce7e4de6c75bec8536a4c','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-785','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',783,'EXECUTED','8:543b58a4476314cc03d3e5aea555ed54','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-786','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',784,'EXECUTED','8:3b0623a033f8c4485d7de9608d4adc46','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=state_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-787','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',785,'EXECUTED','8:d259f64350c6bcc62781d0941e875a4b','addForeignKeyConstraint baseTableName=patient_state, constraintName=state_for_patient, referencedTableName=program_workflow_state','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-788','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',786,'EXECUTED','8:4699bb58a3e9c3109d45ec160b91a5c4','addForeignKeyConstraint baseTableName=scheduler_task_config_property, constraintName=task_config_for_property, referencedTableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-789','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',787,'EXECUTED','8:b2c41edb9570e45b19680dfb4313c7b8','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_frequency_fk, referencedTableName=order_frequency','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-790','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',788,'EXECUTED','8:851021811c95c7a27abec26b75eb967c','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_order_id_fk, referencedTableName=orders','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-791','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',789,'EXECUTED','8:82e3660096af40dfdc2593f87134763d','addForeignKeyConstraint baseTableName=test_order, constraintName=test_order_specimen_source_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-792','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',790,'EXECUTED','8:08125ec6956668d97ce903be720109e5','addForeignKeyConstraint baseTableName=order_type, constraintName=type_created_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-793','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',791,'EXECUTED','8:30e98ca3bb206741fc25d7a34246a9e0','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-794','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',792,'EXECUTED','8:452ad77fe1b9a2a6687e12c5908e5788','addForeignKeyConstraint baseTableName=field, constraintName=type_of_field, referencedTableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-795','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',793,'EXECUTED','8:00115b4d90be3b35a91bb9c4fbb2924f','addForeignKeyConstraint baseTableName=orders, constraintName=type_of_order, referencedTableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-796','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',794,'EXECUTED','8:ea9c4a34ef2daab2fd9bf8b0ff0140cb','addForeignKeyConstraint baseTableName=users, constraintName=user_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-797','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',795,'EXECUTED','8:723e6bb5c15ad073a48b332dcadf864a','addForeignKeyConstraint baseTableName=user_property, constraintName=user_property_to_users, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-798','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',796,'EXECUTED','8:fefff412b97d1d643149c053635ce767','addForeignKeyConstraint baseTableName=user_role, constraintName=user_role_to_users, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-799','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',797,'EXECUTED','8:1305a6c0dae52a22c43a9b57a940fa44','addForeignKeyConstraint baseTableName=patient_program, constraintName=user_who_changed, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-800','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',798,'EXECUTED','8:343eb8be828a5ba4f3841b8d77566b04','addForeignKeyConstraint baseTableName=notification_alert, constraintName=user_who_changed_alert, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-801','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',799,'EXECUTED','8:5fc975ec849f698e4287a09acb421d7e','addForeignKeyConstraint baseTableName=cohort, constraintName=user_who_changed_cohort, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-802','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',800,'EXECUTED','8:2265b40b243ac793f14ef309795080fc','addForeignKeyConstraint baseTableName=concept, constraintName=user_who_changed_concept, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-803','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',801,'EXECUTED','8:c261c1e65549e34ee71f80efb3505c60','addForeignKeyConstraint baseTableName=concept_description, constraintName=user_who_changed_description, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-804','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',802,'EXECUTED','8:77bb092390a513da2ffc945456c2d209','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=user_who_changed_drug_reference_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-805','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',803,'EXECUTED','8:f13ca2f63daf6edfabf8529407243217','addForeignKeyConstraint baseTableName=field, constraintName=user_who_changed_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-806','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',804,'EXECUTED','8:0fca81deba1a33b52f26baf88bbef7df','addForeignKeyConstraint baseTableName=note, constraintName=user_who_changed_note, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-807','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',805,'EXECUTED','8:20e416bb6651a6f0c9ed2e7573ddc370','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_changed_pat, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-808','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',806,'EXECUTED','8:df236e4b1ed69a28387ff87739d53074','addForeignKeyConstraint baseTableName=person, constraintName=user_who_changed_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-809','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',807,'EXECUTED','8:bd1a4300a5ab91f5829e17f9e78685d2','addForeignKeyConstraint baseTableName=program, constraintName=user_who_changed_program, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-810','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',808,'EXECUTED','8:c06c37d1888e2616ed164c564c9691ea','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=user_who_changed_proposal, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-811','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:42',809,'EXECUTED','8:26a5df123f658da8ce9d43ee7be84c01','addForeignKeyConstraint baseTableName=report_object, constraintName=user_who_changed_report_object, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-812','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',810,'EXECUTED','8:08adce9cac2fc5812ae1467bb01f7c68','addForeignKeyConstraint baseTableName=users, constraintName=user_who_changed_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-813','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',811,'EXECUTED','8:dc181c03d81a5aa13b2adba0895e7cc7','addForeignKeyConstraint baseTableName=concept_set, constraintName=user_who_created, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-814','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',812,'EXECUTED','8:280744cd6ef9a10c033ea227aa23ad75','addForeignKeyConstraint baseTableName=concept_description, constraintName=user_who_created_description, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-815','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',813,'EXECUTED','8:c2ddd6a153ea5fac2642af8cd8b0f417','addForeignKeyConstraint baseTableName=field, constraintName=user_who_created_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-816','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',814,'EXECUTED','8:93f04f5f6488c7f6766b3b96133ec156','addForeignKeyConstraint baseTableName=field_answer, constraintName=user_who_created_field_answer, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-817','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',815,'EXECUTED','8:9031282bc3ec4aeff106fdb5cc5a6cc9','addForeignKeyConstraint baseTableName=field_type, constraintName=user_who_created_field_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-818','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',816,'EXECUTED','8:8f148b88a5ad5a7b78587b3d31c8e684','addForeignKeyConstraint baseTableName=form, constraintName=user_who_created_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-819','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',817,'EXECUTED','8:603a206dd14a3675c9cef971ffa9020c','addForeignKeyConstraint baseTableName=form_field, constraintName=user_who_created_form_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-820','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',818,'EXECUTED','8:983988bb480395808f1e41aa51180e5c','addForeignKeyConstraint baseTableName=hl7_source, constraintName=user_who_created_hl7_source, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-821','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',819,'EXECUTED','8:1a458577d2ac4dfe1e97a89ae1f57368','addForeignKeyConstraint baseTableName=location, constraintName=user_who_created_location, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-822','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',820,'EXECUTED','8:5e7978a742cc48bf0314fa94ea09c2f9','addForeignKeyConstraint baseTableName=concept_name, constraintName=user_who_created_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-823','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',821,'EXECUTED','8:6db6284b31bcc268b3ac4e6fb8bd1a60','addForeignKeyConstraint baseTableName=note, constraintName=user_who_created_note, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-824','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',822,'EXECUTED','8:d9f70cb2cb2d2e385450fff9de81a3f0','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_created_patient, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-825','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',823,'EXECUTED','8:f646acccb57f4c6fdf595d6cac79b9d6','addForeignKeyConstraint baseTableName=person, constraintName=user_who_created_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-826','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',824,'EXECUTED','8:96b9e9096245e655ed5447e1952205cb','addForeignKeyConstraint baseTableName=concept_proposal, constraintName=user_who_created_proposal, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-827','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',825,'EXECUTED','8:fb7754b5708a79f2dfa48548a2a9927b','addForeignKeyConstraint baseTableName=relationship_type, constraintName=user_who_created_rel, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-828','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',826,'EXECUTED','8:bcb154a1a744dcabb2b0a086183cb828','addForeignKeyConstraint baseTableName=encounter_type, constraintName=user_who_created_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-829','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',827,'EXECUTED','8:13951420223e47ff313feb89df69fbee','addForeignKeyConstraint baseTableName=form, constraintName=user_who_last_changed_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-830','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',828,'EXECUTED','8:929037fffaac667470943ea65d399a45','addForeignKeyConstraint baseTableName=form_field, constraintName=user_who_last_changed_form_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-831','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',829,'EXECUTED','8:4f451f31dd229342b58289e42e768bd9','addForeignKeyConstraint baseTableName=person_name, constraintName=user_who_made_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-832','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',830,'EXECUTED','8:7eff96a285820c8da251930fa92ada8f','addForeignKeyConstraint baseTableName=concept, constraintName=user_who_retired_concept, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-833','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',831,'EXECUTED','8:9afbf53a06102f16c1f2390d0d46da52','addForeignKeyConstraint baseTableName=concept_class, constraintName=user_who_retired_concept_class, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-834','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',832,'EXECUTED','8:442e2f78bf23bcffe3965637d672416d','addForeignKeyConstraint baseTableName=concept_datatype, constraintName=user_who_retired_concept_datatype, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-835','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',833,'EXECUTED','8:0272c11d12cfea2978d5f553e74b1207','addForeignKeyConstraint baseTableName=concept_reference_source, constraintName=user_who_retired_concept_source, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-836','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',834,'EXECUTED','8:6750966353811ea85969a5b6652bd400','addForeignKeyConstraint baseTableName=drug_reference_map, constraintName=user_who_retired_drug_reference_map, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-837','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',835,'EXECUTED','8:d8872ccdfc762e9ce6e7886b20af7047','addForeignKeyConstraint baseTableName=encounter_type, constraintName=user_who_retired_encounter_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-838','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',836,'EXECUTED','8:0d01bd36170b64d389b69701c176442b','addForeignKeyConstraint baseTableName=field, constraintName=user_who_retired_field, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-839','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',837,'EXECUTED','8:5f23970d3a6caa80f3ecd0ef1900a45f','addForeignKeyConstraint baseTableName=form, constraintName=user_who_retired_form, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-840','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',838,'EXECUTED','8:5b0c2285f25c215a1bf6410892a713f5','addForeignKeyConstraint baseTableName=location, constraintName=user_who_retired_location, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-841','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',839,'EXECUTED','8:01b5dff30c21f152aa9bd8f401119e58','addForeignKeyConstraint baseTableName=order_type, constraintName=user_who_retired_order_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-842','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',840,'EXECUTED','8:10d3b2af7431d877008130ea136a8f8b','addForeignKeyConstraint baseTableName=patient_identifier_type, constraintName=user_who_retired_patient_identifier_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-843','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',841,'EXECUTED','8:38014a0af7e337583bef8e7e2589eabd','addForeignKeyConstraint baseTableName=person_attribute_type, constraintName=user_who_retired_person_attribute_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-844','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',842,'EXECUTED','8:8b7b02faed336699f601e3f2ca01c199','addForeignKeyConstraint baseTableName=relationship_type, constraintName=user_who_retired_relationship_type, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-845','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:43',843,'EXECUTED','8:a938f103add4c8156b7d6f4bdf9cf374','addForeignKeyConstraint baseTableName=users, constraintName=user_who_retired_this_user, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-846','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',844,'EXECUTED','8:67f1fa8fefbe2640ead279cb4e48ba0f','addForeignKeyConstraint baseTableName=cohort, constraintName=user_who_voided_cohort, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-847','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',845,'EXECUTED','8:5f9f7cd2bdd2ec0cd2d9bdd274457200','addForeignKeyConstraint baseTableName=encounter, constraintName=user_who_voided_encounter, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-848','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',846,'EXECUTED','8:b4973e2fd09493cf0f779120fa5dbec4','addForeignKeyConstraint baseTableName=person_name, constraintName=user_who_voided_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-849','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',847,'EXECUTED','8:3776cdd75708aa75f1b0c7f622897c64','addForeignKeyConstraint baseTableName=obs, constraintName=user_who_voided_obs, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-850','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',848,'EXECUTED','8:97cec80e22dce555f78fdc488260e742','addForeignKeyConstraint baseTableName=orders, constraintName=user_who_voided_order, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-851','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',849,'EXECUTED','8:eb239c8401ccfe026e802654d4a310e9','addForeignKeyConstraint baseTableName=patient, constraintName=user_who_voided_patient, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-852','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',850,'EXECUTED','8:613426ab4712afa00f70cf6f1afc96ef','addForeignKeyConstraint baseTableName=patient_program, constraintName=user_who_voided_patient_program, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-853','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',851,'EXECUTED','8:7ccc3031ce247fa4e894db35c9b50fd3','addForeignKeyConstraint baseTableName=person, constraintName=user_who_voided_person, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-854','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',852,'EXECUTED','8:e244aaca4e65338555a63e63c3a29d81','addForeignKeyConstraint baseTableName=report_object, constraintName=user_who_voided_report_object, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-855','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',853,'EXECUTED','8:b04b2982766556b661da185bcfd5fa3d','addForeignKeyConstraint baseTableName=concept_name, constraintName=user_who_voided_this_name, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-856','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',854,'EXECUTED','8:ed2242f9b321d4ea63f247eb2ccaab7f','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_attribute_type_id_fk, referencedTableName=visit_attribute_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-857','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',855,'EXECUTED','8:ba1d3c056667eba3267ca5afb097d975','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-858','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',856,'EXECUTED','8:bbc8336b3b28d4287d5551a41b6fde79','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-859','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',857,'EXECUTED','8:f86c560b2a70405529674304425df5fd','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-860','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',858,'EXECUTED','8:277d9c4b7ca3a79e0a60454f1434bb3e','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-861','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',859,'EXECUTED','8:2b44a508a72aa9bd225c944bd3e784b9','addForeignKeyConstraint baseTableName=visit_attribute_type, constraintName=visit_attribute_type_retired_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-862','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',860,'EXECUTED','8:7df3a3f6836940b959be0c1d6748b1f8','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_visit_fk, referencedTableName=visit','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-863','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',861,'EXECUTED','8:d2fafd7800497279bd5d22adbf2c1d36','addForeignKeyConstraint baseTableName=visit_attribute, constraintName=visit_attribute_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-864','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',862,'EXECUTED','8:432af25b3923438b732e18b0fffbe3d0','addForeignKeyConstraint baseTableName=visit, constraintName=visit_changed_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-865','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',863,'EXECUTED','8:faf16d1e38c1c8e3215f1060a914bec7','addForeignKeyConstraint baseTableName=visit, constraintName=visit_creator_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-866','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',864,'EXECUTED','8:5fe911e0be2b2624c1f66d0bb0ea9aa2','addForeignKeyConstraint baseTableName=visit, constraintName=visit_indication_concept_fk, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-867','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',865,'EXECUTED','8:769b35555b05d6fe5eb2b15a224c8993','addForeignKeyConstraint baseTableName=visit, constraintName=visit_location_fk, referencedTableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-868','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',866,'EXECUTED','8:943d07508b9fe5db0c12046214218373','addForeignKeyConstraint baseTableName=visit, constraintName=visit_patient_fk, referencedTableName=patient','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-869','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',867,'EXECUTED','8:c1a1fde06b4f60e5a7039dda1fd5deb8','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-870','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',868,'EXECUTED','8:c0157445b774208a4e1a6b155d825cda','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-871','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',869,'EXECUTED','8:3337dd30628c280bba9aefcb7259bf1d','addForeignKeyConstraint baseTableName=visit, constraintName=visit_type_fk, referencedTableName=visit_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-872','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',870,'EXECUTED','8:7f760a43389b5133e928bd462a1cbfee','addForeignKeyConstraint baseTableName=visit_type, constraintName=visit_type_retired_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-873','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',871,'EXECUTED','8:f80450b35384e476f2fad09174dc36e6','addForeignKeyConstraint baseTableName=visit, constraintName=visit_voided_by_fk, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-874','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',872,'EXECUTED','8:83bb8ae02918954c7eecc8830e5760cc','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_changed_by, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-875','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',873,'EXECUTED','8:5f29c1197b461a3a2ab56cabe6393b12','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_concept, referencedTableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-876','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:44',874,'EXECUTED','8:2ca2fb755d66b8fc57de0239557b3836','addForeignKeyConstraint baseTableName=program_workflow, constraintName=workflow_creator, referencedTableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473628795-877','wolf (generated)','liquibase-schema-only.xml','2021-04-19 09:47:45',875,'EXECUTED','8:f028f6c6fcd341c50dcf6b328bb20814','addForeignKeyConstraint baseTableName=program_workflow_state, constraintName=workflow_for_state, referencedTableName=program_workflow','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-17','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',876,'EXECUTED','8:255e6601599e56ae696678ceaa497147','insert tableName=person','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-27','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',877,'EXECUTED','8:82560e46ae141efa9cae337db977af6d','insert tableName=users; insert tableName=users','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-1','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',878,'EXECUTED','8:15e1a2cab8858f62d69204ccd0b30c82','insert tableName=care_setting; insert tableName=care_setting','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-3','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',879,'EXECUTED','8:7f05eb80307fdfc709eb088650d15a6e','insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concept_class; insert tableName=concep...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-4','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',880,'EXECUTED','8:50ec890abd419ac57991bbd28127253d','insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; insert tableName=concept_datatype; in...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-2','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',881,'EXECUTED','8:7cc25ed675cea3aab16933306a6f926c','insert tableName=concept; insert tableName=concept','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-5','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',882,'EXECUTED','8:5b490bb870c72fb23233b094c26046fe','insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; insert tableName=concept_map_type; in...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-6','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',883,'EXECUTED','8:02641afe8826c2086d092326d2760279','insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name; insert tableName=concept_name;...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-7','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',884,'EXECUTED','8:f20b5d7db739e72d0254bcc5badd9393','insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_word; insert tableName=concept_stop_w...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-8','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',885,'EXECUTED','8:6801580817ea05b1c8d3031de247112a','insert tableName=encounter_role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-9','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',886,'EXECUTED','8:80d9a081c517c5450b311b2076411160','insert tableName=field_type; insert tableName=field_type; insert tableName=field_type; insert tableName=field_type; insert tableName=field_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-11','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',887,'EXECUTED','8:98aae149885eadc3ec45db23026d263f','insert tableName=hl7_source','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-14','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',888,'EXECUTED','8:78aba44d5fd8096db49515cb30cec7b9','insert tableName=location','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-15','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',889,'EXECUTED','8:01249863645b038d25a5e3865b630bee','insert tableName=order_type; insert tableName=order_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-16','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',890,'EXECUTED','8:8d099363142933cea82f5ddfddcb28af','insert tableName=patient_identifier_type; insert tableName=patient_identifier_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-18','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',891,'EXECUTED','8:1690ac38e5c1c4dcea2d7dced569f187','insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert tableName=person_attribute_type; insert ...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-19','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',892,'EXECUTED','8:1458c1fc57bc69a529569da02ca87f72','insert tableName=person_name','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-20','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',893,'EXECUTED','8:7d55ef76a56d3cc4bd16bf9f8bb5e918','insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privilege; insert tableName=privil...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-21','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',894,'EXECUTED','8:28a763094594b829bc80f3d6a894d450','insert tableName=relationship_type; insert tableName=relationship_type; insert tableName=relationship_type; insert tableName=relationship_type','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-22','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',895,'EXECUTED','8:3e059f57b088f635d2c19d2e3cbb488e','insert tableName=role; insert tableName=role; insert tableName=role; insert tableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-23','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',896,'EXECUTED','8:21180f55b63fb7d74dc53d35b827746b','insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName=role_privilege; insert tableName...','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-24','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',897,'EXECUTED','8:0cb4daf54d5d34edb866c37179b22284','insert tableName=scheduler_task_config','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-25','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',898,'EXECUTED','8:bc693063e2acfa6f3c00f400eee5d20b','insert tableName=user_property; insert tableName=user_property','',NULL,'3.10.2',NULL,NULL,NULL),('1582473679024-26','wolf (generated)','liquibase-core-data.xml','2021-04-19 09:47:45',899,'EXECUTED','8:c2366d8db8ef9d8a623360430d7a1115','insert tableName=user_role; insert tableName=user_role','',NULL,'3.10.2',NULL,NULL,NULL),('201109030450-1','sunbiz','liquibase-schema-only.xml','2021-04-19 09:47:50',900,'EXECUTED','8:6a15cdba1c413c98d85196aeb1debcf6','insertWithUuid tableName=role; insertWithUuid tableName=role; insertWithUuid tableName=role','',NULL,'3.10.2',NULL,NULL,NULL),('1226412230538-1','ben (generated)','liquibase-schema-only.xml','2021-04-19 09:47:50',901,'EXECUTED','8:7ddd7a1e132051df4ecd942547b76f04','insert tableName=role_role; insert tableName=role_role','',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5412','gitacliff','liquibase-update-to-latest.xml','2021-04-19 09:47:50',902,'EXECUTED','8:097971ad4b683c624ef7b5d9afb8faea','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_order_group_reason_fk, referencedTableName=concept','Adding \"order_group_reason\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5650','gitacliff','liquibase-update-to-latest.xml','2021-04-19 09:47:50',903,'EXECUTED','8:683558c2e7716af357494252a94aee20','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_parent_order_group_fk, referencedTableName=order_group','Adding \"parent_order_group\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5728-2020-05-20','samuel34','liquibase-update-to-latest.xml','2021-04-19 09:47:50',904,'EXECUTED','8:2a90bedc8b02e4c89e1a37dc1110014b','addColumn tableName=conditions; addForeignKeyConstraint baseTableName=conditions, constraintName=conditions_encounter_id_fk, referencedTableName=encounter','Adding \'encounter_id\' column to \'conditions\' table',NULL,'3.10.2',NULL,NULL,NULL),('20190815-Trunk-5651','gitacliff','liquibase-update-to-latest.xml','2021-04-19 09:47:50',905,'EXECUTED','8:f57b630542abaf86eb5f11cb4c3e9ad5','addColumn tableName=order_group; addForeignKeyConstraint baseTableName=order_group, constraintName=order_group_previous_order_group_fk, referencedTableName=order_group','Adding \"previous_order_group\" column to order_group table',NULL,'3.10.2',NULL,NULL,NULL),('20200714-Trunk-5862','loliveira','liquibase-update-to-latest.xml','2021-04-19 09:47:50',906,'EXECUTED','8:c2d4c311dcab0c2c9507b75bfdd78a3c','addColumn tableName=conditions','Adding \"form_namespace_and_path\" column to conditions table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5835-2020-07-09-1600','gitacliff','liquibase-update-to-latest.xml','2021-04-19 09:47:50',907,'EXECUTED','8:b744e5bfec82a26f3ed1e8a71fc8d5e5','createTable tableName=order_set_attribute_type; addForeignKeyConstraint baseTableName=order_set_attribute_type, constraintName=order_set_attribute_type_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=order_set_attribut...','Creating order_set_attribute_type table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5835-2020-07-09-1700','gitacliff','liquibase-update-to-latest.xml','2021-04-19 09:47:50',908,'EXECUTED','8:8877d8978506c3107937fb42e6c6634b','createTable tableName=order_set_attribute; addForeignKeyConstraint baseTableName=order_set_attribute, constraintName=order_set_attribute_order_set_fk, referencedTableName=order_set; addForeignKeyConstraint baseTableName=order_set_attribute, constr...','Creating order_set_attribute table',NULL,'3.10.2',NULL,NULL,NULL),('TRUNK-5410','tendomart','liquibase-update-to-latest.xml','2021-04-19 09:47:50',909,'EXECUTED','8:7a314d2f15c425b8fc40545505441ce3','createTable tableName=order_group_attribute_type; addForeignKeyConstraint baseTableName=order_group_attribute_type, constraintName=order_group_attribute_type_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=order_group_...','Creating order_group_attribute_type table',NULL,'3.10.2',NULL,NULL,NULL),('20200723-TRUNK-5410','tendomart','liquibase-update-to-latest.xml','2021-04-19 09:47:50',910,'EXECUTED','8:47b18620e5dd10a8c0f7a13281af80ce','createTable tableName=order_group_attribute; addForeignKeyConstraint baseTableName=order_group_attribute, constraintName=order_group_attribute_order_group_fk, referencedTableName=order_group; addForeignKeyConstraint baseTableName=order_group_attri...','Creating order_group_attribute table',NULL,'3.10.2',NULL,NULL,NULL),('2020-08-31-2200-TRUNK-5821','miirochristopher','liquibase-update-to-latest.xml','2021-04-19 09:47:51',911,'EXECUTED','8:b19d78a89af7cbbc1146acfdc3bc9ee5','createIndex indexName=orders_order_number, tableName=orders','Adding index to order_number column in Orders table',NULL,'3.10.2',NULL,NULL,NULL),('2020-08-32-100-TRUNK-5821','miirochristopher','liquibase-update-to-latest.xml','2021-04-19 09:47:51',912,'EXECUTED','8:ebab8d61ca65d04b73dbed42acebbe6e','createIndex indexName=orders_accession_number, tableName=orders','Adding index to accession_number column in Orders table',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_concept_source_20200105','ibacher','liquibase.xml','2021-04-19 09:48:02',913,'EXECUTED','8:32021b3c1947c434aa9b2c00d550a0d4','createTable tableName=fhir_concept_source; addForeignKeyConstraint baseTableName=fhir_concept_source, constraintName=fhir_concept_source_concept_reference_source_fk, referencedTableName=concept_reference_source; addForeignKeyConstraint baseTableNa...','',NULL,'3.10.2',NULL,NULL,NULL),('add_loinc_fhir_concept_source_20200221','ibacher','liquibase.xml','2021-04-19 09:48:02',914,'EXECUTED','8:3a65e41b9238d0feab36ef2e7c0022d3','sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_ciel_fhir_concept_source_20200221','ibacher','liquibase.xml','2021-04-19 09:48:02',915,'EXECUTED','8:719ab651e116abf26ad2d0aa3e0ff14e','sql','',NULL,'3.10.2',NULL,NULL,NULL),('change_ciel_url_fhir_concept_source_20200820','ibacher','liquibase.xml','2021-04-19 09:48:02',916,'EXECUTED','8:e21abac1fac251c4d8dfd0f8f732c765','sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_20200311','pmanko','liquibase.xml','2021-04-19 09:48:03',917,'EXECUTED','8:e1ec059d84b15074664e277fe1d2d2dd','createTable tableName=fhir_task; addForeignKeyConstraint baseTableName=fhir_task, constraintName=task_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task, constraintName=task_changed_by, referencedTableName=users; a...','Create Task table for the Task FHIR resource',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_reference_20200311','pmanko','liquibase.xml','2021-04-19 09:48:03',918,'EXECUTED','8:4af2620a8401719ce59a4b4ba75b7eb4','createTable tableName=fhir_reference; addForeignKeyConstraint baseTableName=fhir_reference, constraintName=fhir_reference_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_reference, constraintName=fhir_reference_ch...','',NULL,'3.10.2',NULL,NULL,NULL),('add_based_on_reference_join_table_20200311','pmanko','liquibase.xml','2021-04-19 09:48:03',919,'EXECUTED','8:9fed57d573d504ea890f9f13132f55fe','createTable tableName=fhir_task_based_on_reference; addForeignKeyConstraint baseTableName=fhir_task_based_on_reference, constraintName=task_based_on_fk, referencedTableName=fhir_task; addForeignKeyConstraint baseTableName=fhir_task_based_on_refere...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_output_20200311','pmanko','liquibase.xml','2021-04-19 09:48:03',920,'EXECUTED','8:591e2822f354ee07598a8f13a8de6307','createTable tableName=fhir_task_output; addForeignKeyConstraint baseTableName=fhir_task_output, constraintName=fhir_task_output_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task_output, constraintName=fhir_task...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_task_input_20200308','pmanko','liquibase.xml','2021-04-19 09:48:03',921,'EXECUTED','8:347812d29adfbbaf3b757f8e9832738e','createTable tableName=fhir_task_input; addForeignKeyConstraint baseTableName=fhir_task_input, constraintName=fhir_task_input_creator_fk, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_task_input, constraintName=fhir_task_inp...','',NULL,'3.10.2',NULL,NULL,NULL),('add_target_uuid_to_fhir_reference_202020917','ibacher','liquibase.xml','2021-04-19 09:48:03',922,'EXECUTED','8:34e6228e38f3e8434003dd0e71cbf682','addColumn tableName=fhir_reference; sql','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_20200917','ibacher','liquibase.xml','2021-04-19 09:48:03',923,'EXECUTED','8:8e027c92045d9cdc7817bcdcf72079ac','createTable tableName=fhir_diagnostic_report; addForeignKeyConstraint baseTableName=fhir_diagnostic_report, constraintName=fhir_diagnostic_report_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_diagnostic_report, con...','Create the table for storing Diagnostic Reports',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_performers_20200917','ibacher','liquibase.xml','2021-04-19 09:48:03',924,'EXECUTED','8:82f5bbdcf8b2bd705a2c20c61a27d977','createTable tableName=fhir_diagnostic_report_performers; addForeignKeyConstraint baseTableName=fhir_diagnostic_report_performers, constraintName=fhir_diagnostic_report_performers_diagnostic_report, referencedTableName=fhir_diagnostic_report; addFo...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_diagnostic_report_results_20201020','ibacher','liquibase.xml','2021-04-19 09:48:03',925,'EXECUTED','8:0e92072a259d4762a0f1b3bb2749f444','createTable tableName=fhir_diagnostic_report_results; addForeignKeyConstraint baseTableName=fhir_diagnostic_report_results, constraintName=fhir_diagnostic_report_results_diagnostic_report, referencedTableName=fhir_diagnostic_report; addForeignKeyC...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_encounter_class_map_20200930','ibacher','liquibase.xml','2021-04-19 09:48:04',926,'EXECUTED','8:c07b71cc89518e9c89054145d3d3851c','createTable tableName=fhir_encounter_class_map; addForeignKeyConstraint baseTableName=fhir_encounter_class_map, constraintName=fhir_encounter_class_map_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_encounter_class_...','',NULL,'3.10.2',NULL,NULL,NULL),('add_fhir_observation_category_map_20200930','ibacher','liquibase.xml','2021-04-19 09:48:04',927,'EXECUTED','8:8406cad7f81cab2dfa52a98702256f17','createTable tableName=fhir_observation_category_map; addForeignKeyConstraint baseTableName=fhir_observation_category_map, constraintName=fhir_observation_category_map_creator, referencedTableName=users; addForeignKeyConstraint baseTableName=fhir_o...','',NULL,'3.10.2',NULL,NULL,NULL),('add_default_observation_categories_20200930','ibacher','liquibase.xml','2021-04-19 09:48:04',928,'EXECUTED','8:73affe6c6768796f73b415e5ce59f160','sql; sql; sql','',NULL,'3.10.2',NULL,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liquibasechangeloglock`
--

DROP TABLE IF EXISTS `liquibasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liquibasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liquibasechangeloglock`
--

LOCK TABLES `liquibasechangeloglock` WRITE;
/*!40000 ALTER TABLE `liquibasechangeloglock` DISABLE KEYS */;
INSERT INTO `liquibasechangeloglock` VALUES (1,0,NULL,NULL);
/*!40000 ALTER TABLE `liquibasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `parent_location` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_changed_by` (`changed_by`),
  KEY `location_retired_status` (`retired`),
  KEY `name_of_location` (`name`),
  KEY `parent_location` (`parent_location`),
  KEY `user_who_created_location` (`creator`),
  KEY `user_who_retired_location` (`retired_by`),
  CONSTRAINT `location_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_location` FOREIGN KEY (`parent_location`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_location` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_location` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Unknown Location',NULL,'','','','','','',NULL,NULL,1,'2005-09-22 00:00:00',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'8d6c993e-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute`
--

DROP TABLE IF EXISTS `location_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute` (
  `location_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `location_attribute_changed_by_fk` (`changed_by`),
  KEY `location_attribute_creator_fk` (`creator`),
  KEY `location_attribute_location_fk` (`location_id`),
  KEY `location_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `location_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `location_attribute_type` (`location_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute`
--

LOCK TABLES `location_attribute` WRITE;
/*!40000 ALTER TABLE `location_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_attribute_type`
--

DROP TABLE IF EXISTS `location_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_attribute_type` (
  `location_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`location_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_attribute_type_changed_by_fk` (`changed_by`),
  KEY `location_attribute_type_creator_fk` (`creator`),
  KEY `location_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `location_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_attribute_type`
--

LOCK TABLES `location_attribute_type` WRITE;
/*!40000 ALTER TABLE `location_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag`
--

DROP TABLE IF EXISTS `location_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag` (
  `location_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`location_tag_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `location_tag_changed_by` (`changed_by`),
  KEY `location_tag_creator` (`creator`),
  KEY `location_tag_retired_by` (`retired_by`),
  CONSTRAINT `location_tag_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag`
--

LOCK TABLES `location_tag` WRITE;
/*!40000 ALTER TABLE `location_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_tag_map`
--

DROP TABLE IF EXISTS `location_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_tag_map` (
  `location_id` int(11) NOT NULL,
  `location_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`location_id`,`location_tag_id`),
  KEY `location_tag_map_tag` (`location_tag_id`),
  CONSTRAINT `location_tag_map_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_tag_map_tag` FOREIGN KEY (`location_tag_id`) REFERENCES `location_tag` (`location_tag_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_tag_map`
--

LOCK TABLES `location_tag_map` WRITE;
/*!40000 ALTER TABLE `location_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_tag_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL DEFAULT 0,
  `note_type` varchar(50) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `obs_id` int(11) DEFAULT NULL,
  `encounter_id` int(11) DEFAULT NULL,
  `text` text NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`note_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `encounter_note` (`encounter_id`),
  KEY `note_hierarchy` (`parent`),
  KEY `obs_note` (`obs_id`),
  KEY `patient_note` (`patient_id`),
  KEY `user_who_changed_note` (`changed_by`),
  KEY `user_who_created_note` (`creator`),
  CONSTRAINT `encounter_note` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `note_hierarchy` FOREIGN KEY (`parent`) REFERENCES `note` (`note_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_note` FOREIGN KEY (`obs_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_note` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_note` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_note` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert`
--

DROP TABLE IF EXISTS `notification_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert` (
  `alert_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(512) NOT NULL,
  `satisfied_by_any` tinyint(1) NOT NULL DEFAULT 0,
  `alert_read` tinyint(1) NOT NULL DEFAULT 0,
  `date_to_expire` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `alert_creator` (`creator`),
  KEY `alert_date_to_expire_idx` (`date_to_expire`),
  KEY `user_who_changed_alert` (`changed_by`),
  CONSTRAINT `alert_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_alert` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert`
--

LOCK TABLES `notification_alert` WRITE;
/*!40000 ALTER TABLE `notification_alert` DISABLE KEYS */;
INSERT INTO `notification_alert` VALUES (1,'There was an error starting the module: Admin UI Module',1,0,NULL,2,'2021-04-20 09:35:52',NULL,NULL,'1015ff88-c60d-44d9-a023-3c2f47a8511d'),(2,'There was an error starting the module: Admin UI Module',1,0,NULL,2,'2021-04-20 09:41:22',NULL,NULL,'5d2af95c-4d07-4380-82cf-619a1e8b4dd2'),(3,'There was an error starting the module: Admin UI Module',1,0,NULL,2,'2021-04-20 09:46:50',NULL,NULL,'ae4eea90-554d-4a63-a42f-020b7adc958f'),(4,'There was an error starting the module: Admin UI Module',1,0,NULL,2,'2021-04-20 09:48:42',NULL,NULL,'a93398af-ae3d-4ef1-8762-3ee272d8fd85');
/*!40000 ALTER TABLE `notification_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_alert_recipient`
--

DROP TABLE IF EXISTS `notification_alert_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_alert_recipient` (
  `alert_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `alert_read` tinyint(1) NOT NULL DEFAULT 0,
  `date_changed` timestamp NOT NULL DEFAULT current_timestamp(),
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`alert_id`,`user_id`),
  KEY `alert_read_by_user` (`user_id`),
  CONSTRAINT `alert_read_by_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_of_alert` FOREIGN KEY (`alert_id`) REFERENCES `notification_alert` (`alert_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_alert_recipient`
--

LOCK TABLES `notification_alert_recipient` WRITE;
/*!40000 ALTER TABLE `notification_alert_recipient` DISABLE KEYS */;
INSERT INTO `notification_alert_recipient` VALUES (1,1,0,'2021-04-20 09:35:52','453cce1a-36e3-4f69-9e36-300f562f696f'),(2,1,0,'2021-04-20 09:41:22','0efaf496-6827-474c-bf31-6fb8c9c7f1fb'),(3,1,0,'2021-04-20 09:46:50','d37d0d5b-fabc-4eb9-a534-39ee6666d239'),(4,1,0,'2021-04-20 09:48:42','dcab6652-ad4e-4a43-9ed9-b72c728f2b7e');
/*!40000 ALTER TABLE `notification_alert_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `template` text DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `recipients` varchar(512) DEFAULT NULL,
  `ordinal` int(11) DEFAULT 0,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obs`
--

DROP TABLE IF EXISTS `obs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obs` (
  `obs_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `encounter_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `obs_datetime` datetime NOT NULL,
  `location_id` int(11) DEFAULT NULL,
  `obs_group_id` int(11) DEFAULT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `value_group_id` int(11) DEFAULT NULL,
  `value_coded` int(11) DEFAULT NULL,
  `value_coded_name_id` int(11) DEFAULT NULL,
  `value_drug` int(11) DEFAULT NULL,
  `value_datetime` datetime DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_modifier` varchar(2) DEFAULT NULL,
  `value_text` text DEFAULT NULL,
  `value_complex` varchar(1000) DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `previous_version` int(11) DEFAULT NULL,
  `form_namespace_and_path` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'FINAL',
  `interpretation` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`obs_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `answer_concept` (`value_coded`),
  KEY `answer_concept_drug` (`value_drug`),
  KEY `encounter_observations` (`encounter_id`),
  KEY `obs_concept` (`concept_id`),
  KEY `obs_datetime_idx` (`obs_datetime`),
  KEY `obs_enterer` (`creator`),
  KEY `obs_grouping_id` (`obs_group_id`),
  KEY `obs_location` (`location_id`),
  KEY `obs_name_of_coded_value` (`value_coded_name_id`),
  KEY `obs_order` (`order_id`),
  KEY `person_obs` (`person_id`),
  KEY `previous_version` (`previous_version`),
  KEY `user_who_voided_obs` (`voided_by`),
  CONSTRAINT `answer_concept` FOREIGN KEY (`value_coded`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `answer_concept_drug` FOREIGN KEY (`value_drug`) REFERENCES `drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `encounter_observations` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_enterer` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_grouping_id` FOREIGN KEY (`obs_group_id`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_name_of_coded_value` FOREIGN KEY (`value_coded_name_id`) REFERENCES `concept_name` (`concept_name_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `obs_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_obs` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `previous_version` FOREIGN KEY (`previous_version`) REFERENCES `obs` (`obs_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_obs` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obs`
--

LOCK TABLES `obs` WRITE;
/*!40000 ALTER TABLE `obs` DISABLE KEYS */;
/*!40000 ALTER TABLE `obs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_frequency`
--

DROP TABLE IF EXISTS `order_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_frequency` (
  `order_frequency_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL,
  `frequency_per_day` double DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_frequency_id`),
  UNIQUE KEY `concept_id` (`concept_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_frequency_changed_by_fk` (`changed_by`),
  KEY `order_frequency_creator_fk` (`creator`),
  KEY `order_frequency_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_frequency_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_frequency_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_frequency`
--

LOCK TABLES `order_frequency` WRITE;
/*!40000 ALTER TABLE `order_frequency` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_frequency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group`
--

DROP TABLE IF EXISTS `order_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group` (
  `order_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `order_group_reason` int(11) DEFAULT NULL,
  `parent_order_group` int(11) DEFAULT NULL,
  `previous_order_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_group_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_changed_by_fk` (`changed_by`),
  KEY `order_group_creator_fk` (`creator`),
  KEY `order_group_encounter_id_fk` (`encounter_id`),
  KEY `order_group_patient_id_fk` (`patient_id`),
  KEY `order_group_set_id_fk` (`order_set_id`),
  KEY `order_group_voided_by_fk` (`voided_by`),
  KEY `order_group_order_group_reason_fk` (`order_group_reason`),
  KEY `order_group_parent_order_group_fk` (`parent_order_group`),
  KEY `order_group_previous_order_group_fk` (`previous_order_group`),
  CONSTRAINT `order_group_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_encounter_id_fk` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_order_group_reason_fk` FOREIGN KEY (`order_group_reason`) REFERENCES `concept` (`concept_id`),
  CONSTRAINT `order_group_parent_order_group_fk` FOREIGN KEY (`parent_order_group`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_patient_id_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_previous_order_group_fk` FOREIGN KEY (`previous_order_group`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_group_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group`
--

LOCK TABLES `order_group` WRITE;
/*!40000 ALTER TABLE `order_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group_attribute`
--

DROP TABLE IF EXISTS `order_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group_attribute` (
  `order_group_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_group_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_group_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_attribute_order_group_fk` (`order_group_id`),
  KEY `order_group_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `order_group_attribute_creator_fk` (`creator`),
  KEY `order_group_attribute_changed_by_fk` (`changed_by`),
  KEY `order_group_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `order_group_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `order_group_attribute_type` (`order_group_attribute_type_id`),
  CONSTRAINT `order_group_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_order_group_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`),
  CONSTRAINT `order_group_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group_attribute`
--

LOCK TABLES `order_group_attribute` WRITE;
/*!40000 ALTER TABLE `order_group_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_group_attribute_type`
--

DROP TABLE IF EXISTS `order_group_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_group_attribute_type` (
  `order_group_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_group_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_group_attribute_type_creator_fk` (`creator`),
  KEY `order_group_attribute_type_changed_by_fk` (`changed_by`),
  KEY `order_group_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_group_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_group_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_group_attribute_type`
--

LOCK TABLES `order_group_attribute_type` WRITE;
/*!40000 ALTER TABLE `order_group_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_group_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set`
--

DROP TABLE IF EXISTS `order_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set` (
  `order_set_id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_set_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `category_order_set_fk` (`category`),
  KEY `order_set_changed_by_fk` (`changed_by`),
  KEY `order_set_creator_fk` (`creator`),
  KEY `order_set_retired_by_fk` (`retired_by`),
  CONSTRAINT `category_order_set_fk` FOREIGN KEY (`category`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set`
--

LOCK TABLES `order_set` WRITE;
/*!40000 ALTER TABLE `order_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_attribute`
--

DROP TABLE IF EXISTS `order_set_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_attribute` (
  `order_set_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_set_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`order_set_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_attribute_order_set_fk` (`order_set_id`),
  KEY `order_set_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `order_set_attribute_creator_fk` (`creator`),
  KEY `order_set_attribute_changed_by_fk` (`changed_by`),
  KEY `order_set_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `order_set_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `order_set_attribute_type` (`order_set_attribute_type_id`),
  CONSTRAINT `order_set_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_order_set_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`),
  CONSTRAINT `order_set_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_attribute`
--

LOCK TABLES `order_set_attribute` WRITE;
/*!40000 ALTER TABLE `order_set_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_attribute_type`
--

DROP TABLE IF EXISTS `order_set_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_attribute_type` (
  `order_set_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_set_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_attribute_type_creator_fk` (`creator`),
  KEY `order_set_attribute_type_changed_by_fk` (`changed_by`),
  KEY `order_set_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_set_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`),
  CONSTRAINT `order_set_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_attribute_type`
--

LOCK TABLES `order_set_attribute_type` WRITE;
/*!40000 ALTER TABLE `order_set_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_set_member`
--

DROP TABLE IF EXISTS `order_set_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_set_member` (
  `order_set_member_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type` int(11) NOT NULL,
  `order_template` text DEFAULT NULL,
  `order_template_type` varchar(1024) DEFAULT NULL,
  `order_set_id` int(11) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `concept_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`order_set_member_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_set_member_changed_by_fk` (`changed_by`),
  KEY `order_set_member_concept_id_fk` (`concept_id`),
  KEY `order_set_member_creator_fk` (`creator`),
  KEY `order_set_member_order_set_id_fk` (`order_set_id`),
  KEY `order_set_member_order_type_fk` (`order_type`),
  KEY `order_set_member_retired_by_fk` (`retired_by`),
  CONSTRAINT `order_set_member_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_concept_id_fk` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_set_id_fk` FOREIGN KEY (`order_set_id`) REFERENCES `order_set` (`order_set_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_order_type_fk` FOREIGN KEY (`order_type`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_set_member_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_set_member`
--

LOCK TABLES `order_set_member` WRITE;
/*!40000 ALTER TABLE `order_set_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_set_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type`
--

DROP TABLE IF EXISTS `order_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type` (
  `order_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `java_class_name` varchar(255) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  PRIMARY KEY (`order_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `order_type_changed_by` (`changed_by`),
  KEY `order_type_parent_order_type` (`parent`),
  KEY `order_type_retired_status` (`retired`),
  KEY `type_created_by` (`creator`),
  KEY `user_who_retired_order_type` (`retired_by`),
  CONSTRAINT `order_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_type_parent_order_type` FOREIGN KEY (`parent`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_created_by` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_order_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type`
--

LOCK TABLES `order_type` WRITE;
/*!40000 ALTER TABLE `order_type` DISABLE KEYS */;
INSERT INTO `order_type` VALUES (2,'Drug Order','An order for a medication to be given to the patient',1,'2010-05-12 00:00:00',0,NULL,NULL,NULL,'131168f4-15f5-102d-96e4-000c29c2a5d7','org.openmrs.DrugOrder',NULL,NULL,NULL),(3,'Test Order','Order type for test orders',1,'2014-03-09 00:00:00',0,NULL,NULL,NULL,'52a447d3-a64a-11e3-9aeb-50e549534c5e','org.openmrs.TestOrder',NULL,NULL,NULL);
/*!40000 ALTER TABLE `order_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_type_class_map`
--

DROP TABLE IF EXISTS `order_type_class_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_type_class_map` (
  `order_type_id` int(11) NOT NULL,
  `concept_class_id` int(11) NOT NULL,
  PRIMARY KEY (`order_type_id`,`concept_class_id`),
  UNIQUE KEY `concept_class_id` (`concept_class_id`),
  CONSTRAINT `fk_order_type_class_map_concept_class_concept_class_id` FOREIGN KEY (`concept_class_id`) REFERENCES `concept_class` (`concept_class_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_type_order_type_id` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_type_class_map`
--

LOCK TABLES `order_type_class_map` WRITE;
/*!40000 ALTER TABLE `order_type_class_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_type_class_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_type_id` int(11) NOT NULL DEFAULT 0,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `orderer` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `instructions` text DEFAULT NULL,
  `date_activated` datetime DEFAULT NULL,
  `auto_expire_date` datetime DEFAULT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `order_reason` int(11) DEFAULT NULL,
  `order_reason_non_coded` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `patient_id` int(11) NOT NULL,
  `accession_number` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `urgency` varchar(50) NOT NULL DEFAULT 'ROUTINE',
  `order_number` varchar(50) NOT NULL,
  `previous_order_id` int(11) DEFAULT NULL,
  `order_action` varchar(50) NOT NULL,
  `comment_to_fulfiller` varchar(1024) DEFAULT NULL,
  `care_setting` int(11) NOT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `order_group_id` int(11) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `fulfiller_comment` varchar(1024) DEFAULT NULL,
  `fulfiller_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `discontinued_because` (`order_reason`),
  KEY `fk_orderer_provider` (`orderer`),
  KEY `order_creator` (`creator`),
  KEY `order_for_patient` (`patient_id`),
  KEY `orders_care_setting` (`care_setting`),
  KEY `orders_in_encounter` (`encounter_id`),
  KEY `orders_order_group_id_fk` (`order_group_id`),
  KEY `previous_order_id_order_id` (`previous_order_id`),
  KEY `type_of_order` (`order_type_id`),
  KEY `user_who_voided_order` (`voided_by`),
  KEY `orders_order_number` (`order_number`),
  KEY `orders_accession_number` (`accession_number`),
  CONSTRAINT `discontinued_because` FOREIGN KEY (`order_reason`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderer_provider` FOREIGN KEY (`orderer`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `orders_care_setting` FOREIGN KEY (`care_setting`) REFERENCES `care_setting` (`care_setting_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_in_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`encounter_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `orders_order_group_id_fk` FOREIGN KEY (`order_group_id`) REFERENCES `order_group` (`order_group_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `previous_order_id_order_id` FOREIGN KEY (`previous_order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_of_order` FOREIGN KEY (`order_type_id`) REFERENCES `order_type` (`order_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_order` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `allergy_status` varchar(50) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`patient_id`),
  KEY `user_who_changed_pat` (`changed_by`),
  KEY `user_who_created_patient` (`creator`),
  KEY `user_who_voided_patient` (`voided_by`),
  CONSTRAINT `person_id_for_patient` FOREIGN KEY (`patient_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_changed_pat` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_patient` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_patient` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier`
--

DROP TABLE IF EXISTS `patient_identifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier` (
  `patient_identifier_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT 0,
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `identifier_type` int(11) NOT NULL DEFAULT 0,
  `preferred` tinyint(1) NOT NULL DEFAULT 0,
  `location_id` int(11) DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_identifier_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `defines_identifier_type` (`identifier_type`),
  KEY `identifier_creator` (`creator`),
  KEY `identifier_name` (`identifier`),
  KEY `identifier_voider` (`voided_by`),
  KEY `idx_patient_identifier_patient` (`patient_id`),
  KEY `patient_identifier_changed_by` (`changed_by`),
  KEY `patient_identifier_ibfk_2` (`location_id`),
  CONSTRAINT `defines_identifier_type` FOREIGN KEY (`identifier_type`) REFERENCES `patient_identifier_type` (`patient_identifier_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_id_patient_identifier` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifier_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_identifier_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier`
--

LOCK TABLES `patient_identifier` WRITE;
/*!40000 ALTER TABLE `patient_identifier` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_identifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_identifier_type`
--

DROP TABLE IF EXISTS `patient_identifier_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_identifier_type` (
  `patient_identifier_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `check_digit` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `format_description` varchar(255) DEFAULT NULL,
  `validator` varchar(200) DEFAULT NULL,
  `location_behavior` varchar(50) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `uniqueness_behavior` varchar(50) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`patient_identifier_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_identifier_type_changed_by` (`changed_by`),
  KEY `patient_identifier_type_retired_status` (`retired`),
  KEY `type_creator` (`creator`),
  KEY `user_who_retired_patient_identifier_type` (`retired_by`),
  CONSTRAINT `patient_identifier_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_patient_identifier_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_identifier_type`
--

LOCK TABLES `patient_identifier_type` WRITE;
/*!40000 ALTER TABLE `patient_identifier_type` DISABLE KEYS */;
INSERT INTO `patient_identifier_type` VALUES (1,'OpenMRS Identification Number','Unique number used in OpenMRS','',1,1,'2005-09-22 00:00:00',0,NULL,'org.openmrs.patient.impl.LuhnIdentifierValidator',NULL,0,NULL,NULL,NULL,'8d793bee-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL),(2,'Old Identification Number','Number given out prior to the OpenMRS system (No check digit)','',0,1,'2005-09-22 00:00:00',0,NULL,NULL,NULL,0,NULL,NULL,NULL,'8d79403a-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL,NULL);
/*!40000 ALTER TABLE `patient_identifier_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program`
--

DROP TABLE IF EXISTS `patient_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program` (
  `patient_program_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL DEFAULT 0,
  `program_id` int(11) NOT NULL DEFAULT 0,
  `date_enrolled` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `outcome_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_in_program` (`patient_id`),
  KEY `patient_program_creator` (`creator`),
  KEY `patient_program_location_id` (`location_id`),
  KEY `patient_program_outcome_concept_id_fk` (`outcome_concept_id`),
  KEY `program_for_patient` (`program_id`),
  KEY `user_who_changed` (`changed_by`),
  KEY `user_who_voided_patient_program` (`voided_by`),
  CONSTRAINT `patient_in_program` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_outcome_concept_id_fk` FOREIGN KEY (`outcome_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_for_patient` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_patient_program` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program`
--

LOCK TABLES `patient_program` WRITE;
/*!40000 ALTER TABLE `patient_program` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_program_attribute`
--

DROP TABLE IF EXISTS `patient_program_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_program_attribute` (
  `patient_program_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`patient_program_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_attribute_attributetype_fk` (`attribute_type_id`),
  KEY `patient_program_attribute_changed_by_fk` (`changed_by`),
  KEY `patient_program_attribute_creator_fk` (`creator`),
  KEY `patient_program_attribute_programid_fk` (`patient_program_id`),
  KEY `patient_program_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `patient_program_attribute_attributetype_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `program_attribute_type` (`program_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_programid_fk` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_program_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_program_attribute`
--

LOCK TABLES `patient_program_attribute` WRITE;
/*!40000 ALTER TABLE `patient_program_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_program_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_state`
--

DROP TABLE IF EXISTS `patient_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_state` (
  `patient_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_program_id` int(11) NOT NULL DEFAULT 0,
  `state` int(11) NOT NULL DEFAULT 0,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`patient_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `patient_program_for_state` (`patient_program_id`),
  KEY `patient_state_changer` (`changed_by`),
  KEY `patient_state_creator` (`creator`),
  KEY `patient_state_voider` (`voided_by`),
  KEY `state_for_patient` (`state`),
  CONSTRAINT `patient_program_for_state` FOREIGN KEY (`patient_program_id`) REFERENCES `patient_program` (`patient_program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_state_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_for_patient` FOREIGN KEY (`state`) REFERENCES `program_workflow_state` (`program_workflow_state_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_state`
--

LOCK TABLES `patient_state` WRITE;
/*!40000 ALTER TABLE `patient_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(50) DEFAULT '',
  `birthdate` date DEFAULT NULL,
  `birthdate_estimated` tinyint(1) NOT NULL DEFAULT 0,
  `dead` tinyint(1) NOT NULL DEFAULT 0,
  `death_date` datetime DEFAULT NULL,
  `cause_of_death` int(11) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `deathdate_estimated` tinyint(1) NOT NULL DEFAULT 0,
  `birthtime` time DEFAULT NULL,
  `cause_of_death_non_coded` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_birthdate` (`birthdate`),
  KEY `person_death_date` (`death_date`),
  KEY `person_died_because` (`cause_of_death`),
  KEY `user_who_changed_person` (`changed_by`),
  KEY `user_who_created_person` (`creator`),
  KEY `user_who_voided_person` (`voided_by`),
  CONSTRAINT `person_died_because` FOREIGN KEY (`cause_of_death`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_person` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_person` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_person` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'M',NULL,0,0,NULL,NULL,NULL,'2005-01-01 00:00:00',NULL,NULL,0,NULL,NULL,NULL,'5f87c042-6814-11e8-923f-e9a88dcb533f',0,NULL,NULL),(2,'M',NULL,0,0,NULL,NULL,1,'2021-04-20 11:01:34',NULL,NULL,0,NULL,NULL,NULL,'04fb3eaf-dcb3-4f90-a34f-f3515c285137',0,NULL,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_address`
--

DROP TABLE IF EXISTS `person_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_address` (
  `person_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT 0,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city_village` varchar(255) DEFAULT NULL,
  `state_province` varchar(255) DEFAULT NULL,
  `postal_code` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `latitude` varchar(50) DEFAULT NULL,
  `longitude` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `county_district` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `address4` varchar(255) DEFAULT NULL,
  `address5` varchar(255) DEFAULT NULL,
  `address6` varchar(255) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `address7` varchar(255) DEFAULT NULL,
  `address8` varchar(255) DEFAULT NULL,
  `address9` varchar(255) DEFAULT NULL,
  `address10` varchar(255) DEFAULT NULL,
  `address11` varchar(255) DEFAULT NULL,
  `address12` varchar(255) DEFAULT NULL,
  `address13` varchar(255) DEFAULT NULL,
  `address14` varchar(255) DEFAULT NULL,
  `address15` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_address_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `address_for_person` (`person_id`),
  KEY `patient_address_creator` (`creator`),
  KEY `patient_address_void` (`voided_by`),
  KEY `person_address_changed_by` (`changed_by`),
  CONSTRAINT `address_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `patient_address_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `patient_address_void` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_address_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_address`
--

LOCK TABLES `person_address` WRITE;
/*!40000 ALTER TABLE `person_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute`
--

DROP TABLE IF EXISTS `person_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute` (
  `person_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL DEFAULT 0,
  `value` varchar(50) NOT NULL DEFAULT '',
  `person_attribute_type_id` int(11) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_changer` (`changed_by`),
  KEY `attribute_creator` (`creator`),
  KEY `attribute_voider` (`voided_by`),
  KEY `defines_attribute_type` (`person_attribute_type_id`),
  KEY `identifies_person` (`person_id`),
  CONSTRAINT `attribute_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `defines_attribute_type` FOREIGN KEY (`person_attribute_type_id`) REFERENCES `person_attribute_type` (`person_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifies_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute`
--

LOCK TABLES `person_attribute` WRITE;
/*!40000 ALTER TABLE `person_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_attribute_type`
--

DROP TABLE IF EXISTS `person_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_attribute_type` (
  `person_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` text DEFAULT NULL,
  `format` varchar(50) DEFAULT NULL,
  `foreign_key` int(11) DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `edit_privilege` varchar(255) DEFAULT NULL,
  `sort_weight` double DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `attribute_is_searchable` (`searchable`),
  KEY `attribute_type_changer` (`changed_by`),
  KEY `attribute_type_creator` (`creator`),
  KEY `name_of_attribute` (`name`),
  KEY `person_attribute_type_retired_status` (`retired`),
  KEY `privilege_which_can_edit` (`edit_privilege`),
  KEY `user_who_retired_person_attribute_type` (`retired_by`),
  CONSTRAINT `attribute_type_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `attribute_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privilege_which_can_edit` FOREIGN KEY (`edit_privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_person_attribute_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_attribute_type`
--

LOCK TABLES `person_attribute_type` WRITE;
/*!40000 ALTER TABLE `person_attribute_type` DISABLE KEYS */;
INSERT INTO `person_attribute_type` VALUES (1,'Race','Group of persons related by common descent or heredity','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,6,'8d871386-c2cc-11de-8d13-0010c6dffd0f'),(2,'Birthplace','Location of persons birth','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,0,'8d8718c2-c2cc-11de-8d13-0010c6dffd0f'),(3,'Citizenship','Country of which this person is a member','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,1,'8d871afc-c2cc-11de-8d13-0010c6dffd0f'),(4,'Mother\'s Name','First or last name of this person\'s mother','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,5,'8d871d18-c2cc-11de-8d13-0010c6dffd0f'),(5,'Civil Status','Marriage status of this person','org.openmrs.Concept',1054,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,2,'8d871f2a-c2cc-11de-8d13-0010c6dffd0f'),(6,'Health District','District/region in which this patient\' home health center resides','java.lang.String',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,4,'8d872150-c2cc-11de-8d13-0010c6dffd0f'),(7,'Health Center','Specific Location of this person\'s home health center.','org.openmrs.Location',0,0,1,'2007-05-04 00:00:00',NULL,NULL,0,NULL,NULL,NULL,NULL,3,'8d87236c-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `person_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_merge_log`
--

DROP TABLE IF EXISTS `person_merge_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_merge_log` (
  `person_merge_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_person_id` int(11) NOT NULL,
  `loser_person_id` int(11) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `merged_data` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_merge_log_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_merge_log_changed_by_fk` (`changed_by`),
  KEY `person_merge_log_creator` (`creator`),
  KEY `person_merge_log_loser` (`loser_person_id`),
  KEY `person_merge_log_voided_by_fk` (`voided_by`),
  KEY `person_merge_log_winner` (`winner_person_id`),
  CONSTRAINT `person_merge_log_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_loser` FOREIGN KEY (`loser_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_merge_log_winner` FOREIGN KEY (`winner_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_merge_log`
--

LOCK TABLES `person_merge_log` WRITE;
/*!40000 ALTER TABLE `person_merge_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_merge_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_name`
--

DROP TABLE IF EXISTS `person_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_name` (
  `person_name_id` int(11) NOT NULL AUTO_INCREMENT,
  `preferred` tinyint(1) NOT NULL DEFAULT 0,
  `person_id` int(11) NOT NULL,
  `prefix` varchar(50) DEFAULT NULL,
  `given_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `family_name_prefix` varchar(50) DEFAULT NULL,
  `family_name` varchar(50) DEFAULT NULL,
  `family_name2` varchar(50) DEFAULT NULL,
  `family_name_suffix` varchar(50) DEFAULT NULL,
  `degree` varchar(50) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`person_name_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `family_name2` (`family_name2`),
  KEY `first_name` (`given_name`),
  KEY `last_name` (`family_name`),
  KEY `middle_name` (`middle_name`),
  KEY `name_for_person` (`person_id`),
  KEY `user_who_made_name` (`creator`),
  KEY `user_who_voided_name` (`voided_by`),
  CONSTRAINT `name_for_person` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `user_who_made_name` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_name` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_name`
--

LOCK TABLES `person_name` WRITE;
/*!40000 ALTER TABLE `person_name` DISABLE KEYS */;
INSERT INTO `person_name` VALUES (1,1,1,NULL,'Super',NULL,NULL,'User',NULL,NULL,NULL,1,'2005-01-01 00:00:00',0,NULL,NULL,NULL,1,'2021-04-20 11:00:20','5f897a68-6814-11e8-923f-e9a88dcb533f'),(2,0,2,NULL,'davy',NULL,NULL,'paulus',NULL,NULL,NULL,1,'2021-04-20 11:01:34',0,NULL,NULL,NULL,NULL,NULL,'03851736-2b3c-4c91-a075-f697019618b2');
/*!40000 ALTER TABLE `person_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `privilege` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`privilege`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES ('Add Allergies','Add allergies','8d04fc61-45de-4d16-a2f7-39ccbda88739'),('Add Cohorts','Able to add a cohort to the system','5f8a2896-6814-11e8-923f-e9a88dcb533f'),('Add Concept Proposals','Able to add concept proposals to the system','5f8a2a1c-6814-11e8-923f-e9a88dcb533f'),('Add Encounters','Able to add patient encounters','5f8a2a8a-6814-11e8-923f-e9a88dcb533f'),('Add HL7 Inbound Archive','Able to add an HL7 archive item','3192b2c9-3844-42f7-8e8e-f8964768ca26'),('Add HL7 Inbound Exception','Able to add an HL7 error item','e41c644c-1866-4572-a78d-6bfe36dd6a4b'),('Add HL7 Inbound Queue','Able to add an HL7 Queue item','b20ee658-9faa-4c6a-bc95-b5a9a4bfa4c2'),('Add HL7 Source','Able to add an HL7 Source','b8a2625f-3130-4b15-a3ba-907600d1bb03'),('Add Observations','Able to add patient observations','5f8a2ada-6814-11e8-923f-e9a88dcb533f'),('Add Orders','Able to add orders','5f8a2b7a-6814-11e8-923f-e9a88dcb533f'),('Add Patient Identifiers','Able to add patient identifiers','5f8a2bc0-6814-11e8-923f-e9a88dcb533f'),('Add Patient Programs','Able to add patients to programs','5f8a2c10-6814-11e8-923f-e9a88dcb533f'),('Add Patients','Able to add patients','5f8a2c56-6814-11e8-923f-e9a88dcb533f'),('Add People','Able to add person objects','5f8a2c92-6814-11e8-923f-e9a88dcb533f'),('Add Problems','Add problems','2f6d256a-1f73-4776-ad5b-f94c80f7beea'),('Add Relationships','Able to add relationships','5f8a2cce-6814-11e8-923f-e9a88dcb533f'),('Add Report Objects','Able to add report objects','5f8a2cf6-6814-11e8-923f-e9a88dcb533f'),('Add Reports','Able to add reports','5f8a2d32-6814-11e8-923f-e9a88dcb533f'),('Add Users','Able to add users to OpenMRS','5f8a2d5a-6814-11e8-923f-e9a88dcb533f'),('Add Visits','Able to add visits','65d14b28-3989-11e6-899a-a4d646d86a8a'),('Assign System Developer Role','Able to assign System Developer role','09cbaabc-ae63-44ed-9d4d-34ec6610e0a5'),('Configure Visits','Able to choose encounter visit handler and enable/disable encounter visits','d7899df6-68d7-49f1-bc3a-a1a64be157d6'),('Delete Cohorts','Able to add a cohort to the system','5f8a2d8c-6814-11e8-923f-e9a88dcb533f'),('Delete Concept Proposals','Able to delete concept proposals from the system','5f8a2dbe-6814-11e8-923f-e9a88dcb533f'),('Delete Conditions','Able to delete conditions','ef725ffa-2d14-41d8-b655-2d2430963b21'),('Delete Diagnoses','Able to delete diagnoses','a7882352-41b4-4da7-b422-84470ede7052'),('Delete Encounters','Able to delete patient encounters','5f8a2de6-6814-11e8-923f-e9a88dcb533f'),('Delete HL7 Inbound Archive','Able to delete/retire an HL7 archive item','7cd1f479-4e6a-422d-8b4d-7a7e5758d253'),('Delete HL7 Inbound Exception','Able to delete an HL7 archive item','25109fd5-edd1-4d11-84fe-a50b4001b50b'),('Delete HL7 Inbound Queue','Able to delete an HL7 Queue item','0e39bf44-a08b-4d61-9d20-08d2cc0ab51e'),('Delete Notes','Able to delete patient notes','ff39bade-4ea2-463b-8a66-ff4b26f85f25'),('Delete Observations','Able to delete patient observations','5f8a2e18-6814-11e8-923f-e9a88dcb533f'),('Delete Orders','Able to delete orders','5f8a2e40-6814-11e8-923f-e9a88dcb533f'),('Delete Patient Identifiers','Able to delete patient identifiers','5f8a2e72-6814-11e8-923f-e9a88dcb533f'),('Delete Patient Programs','Able to delete patients from programs','5f8a2ea4-6814-11e8-923f-e9a88dcb533f'),('Delete Patients','Able to delete patients','5f8a2ecc-6814-11e8-923f-e9a88dcb533f'),('Delete People','Able to delete objects','5f8a2efe-6814-11e8-923f-e9a88dcb533f'),('Delete Relationships','Able to delete relationships','5f8a2f26-6814-11e8-923f-e9a88dcb533f'),('Delete Report Objects','Able to delete report objects','5f8a2f58-6814-11e8-923f-e9a88dcb533f'),('Delete Reports','Able to delete reports','5f8a2f8a-6814-11e8-923f-e9a88dcb533f'),('Delete Users','Able to delete users in OpenMRS','5f8a2fb2-6814-11e8-923f-e9a88dcb533f'),('Delete Visits','Able to delete visits','02d02051-931b-4325-88d9-bf1a6cc85f5d'),('Edit Allergies','Able to edit allergies','507e9f66-ee25-4113-a55a-4b050022f55a'),('Edit Cohorts','Able to add a cohort to the system','5f8a2fe4-6814-11e8-923f-e9a88dcb533f'),('Edit Concept Proposals','Able to edit concept proposals in the system','5f8a300c-6814-11e8-923f-e9a88dcb533f'),('Edit Conditions','Able to edit conditions','910ec2ec-a87b-4528-ad5c-02c500068bf0'),('Edit Diagnoses','Able to edit diagnoses','107f5169-77a2-48d3-9f69-9f2ca9b419ca'),('Edit Encounters','Able to edit patient encounters','5f8a303e-6814-11e8-923f-e9a88dcb533f'),('Edit Notes','Able to edit patient notes','888fe070-549c-429a-9784-edbaf42e3229'),('Edit Observations','Able to edit patient observations','5f8a3066-6814-11e8-923f-e9a88dcb533f'),('Edit Orders','Able to edit orders','5f8a308e-6814-11e8-923f-e9a88dcb533f'),('Edit Patient Identifiers','Able to edit patient identifiers','5f8a30c0-6814-11e8-923f-e9a88dcb533f'),('Edit Patient Programs','Able to edit patients in programs','5f8a30e8-6814-11e8-923f-e9a88dcb533f'),('Edit Patients','Able to edit patients','5f8a311a-6814-11e8-923f-e9a88dcb533f'),('Edit People','Able to edit person objects','5f8a3142-6814-11e8-923f-e9a88dcb533f'),('Edit Problems','Able to edit problems','5131daf7-2c4d-4c2b-8f6e-bf7cf8290444'),('Edit Relationships','Able to edit relationships','5f8a3174-6814-11e8-923f-e9a88dcb533f'),('Edit Report Objects','Able to edit report objects','5f8a319c-6814-11e8-923f-e9a88dcb533f'),('Edit Reports','Able to edit reports','5f8a31ce-6814-11e8-923f-e9a88dcb533f'),('Edit User Passwords','Able to change the passwords of users in OpenMRS','5f8a31f6-6814-11e8-923f-e9a88dcb533f'),('Edit Users','Able to edit users in OpenMRS','5f8a3228-6814-11e8-923f-e9a88dcb533f'),('Edit Visits','Able to edit visits','14f4da3c-d1e1-4571-b379-0b533496f5b7'),('Form Entry','Allows user to access Form Entry pages/functions','5f8a3250-6814-11e8-923f-e9a88dcb533f'),('Get Allergies','Able to get allergies','d05118c6-2490-4d78-a41a-390e3596a220'),('Get Care Settings','Able to get Care Settings','1ab26030-a207-4a22-be52-b40be3e401dd'),('Get Concept Attribute Types','Able to get concept attribute types','498317ea-e55f-4488-9e87-0db1349c3d11'),('Get Concept Classes','Able to get concept classes','d05118c6-2490-4d78-a41a-390e3596a238'),('Get Concept Datatypes','Able to get concept datatypes','d05118c6-2490-4d78-a41a-390e3596a237'),('Get Concept Map Types','Able to get concept map types','d05118c6-2490-4d78-a41a-390e3596a230'),('Get Concept Proposals','Able to get concept proposals to the system','d05118c6-2490-4d78-a41a-390e3596a250'),('Get Concept Reference Terms','Able to get concept reference terms','d05118c6-2490-4d78-a41a-390e3596a229'),('Get Concept Sources','Able to get concept sources','d05118c6-2490-4d78-a41a-390e3596a231'),('Get Concepts','Able to get concept entries','d05118c6-2490-4d78-a41a-390e3596a251'),('Get Conditions','Able to get conditions','6b470c18-04e8-42c5-bc34-0ac871a0beb6'),('Get Database Changes','Able to get database changes from the admin screen','d05118c6-2490-4d78-a41a-390e3596a222'),('Get Diagnoses','Able to get diagnoses','77b0b402-c928-4811-b084-f0ef7087a49c'),('Get Encounter Roles','Able to get encounter roles','d05118c6-2490-4d78-a41a-390e3596a210'),('Get Encounter Types','Able to get encounter types','d05118c6-2490-4d78-a41a-390e3596a247'),('Get Encounters','Able to get patient encounters','d05118c6-2490-4d78-a41a-390e3596a248'),('Get Field Types','Able to get field types','d05118c6-2490-4d78-a41a-390e3596a234'),('Get Forms','Able to get forms','d05118c6-2490-4d78-a41a-390e3596a240'),('Get Global Properties','Able to get global properties on the administration screen','d05118c6-2490-4d78-a41a-390e3596a226'),('Get HL7 Inbound Archive','Able to get an HL7 archive item','d05118c6-2490-4d78-a41a-390e3596a217'),('Get HL7 Inbound Exception','Able to get an HL7 error item','d05118c6-2490-4d78-a41a-390e3596a216'),('Get HL7 Inbound Queue','Able to get an HL7 Queue item','d05118c6-2490-4d78-a41a-390e3596a218'),('Get HL7 Source','Able to get an HL7 Source','d05118c6-2490-4d78-a41a-390e3596a219'),('Get Identifier Types','Able to get patient identifier types','d05118c6-2490-4d78-a41a-390e3596a239'),('Get Location Attribute Types','Able to get location attribute types','d05118c6-2490-4d78-a41a-390e3596a212'),('Get Locations','Able to get locations','d05118c6-2490-4d78-a41a-390e3596a246'),('Get Notes','Able to get patient notes','dcd11774-e77c-48d5-8f34-685741dec359'),('Get Observations','Able to get patient observations','d05118c6-2490-4d78-a41a-390e3596a245'),('Get Order Frequencies','Able to get Order Frequencies','c78007dd-c641-400b-9aac-04420aecc5b6'),('Get Order Set Attribute Types','Able to get order set attribute types','a89ade98-9326-4acd-a5db-e77d722b1c41'),('Get Order Sets','Able to get order sets','e52af909-2baf-4ab6-9862-8a6848448ec0'),('Get Order Types','Able to get order types','d05118c6-2490-4d78-a41a-390e3596a233'),('Get Orders','Able to get orders','d05118c6-2490-4d78-a41a-390e3596a241'),('Get Patient Cohorts','Able to get patient cohorts','d05118c6-2490-4d78-a41a-390e3596a242'),('Get Patient Identifiers','Able to get patient identifiers','d05118c6-2490-4d78-a41a-390e3596a243'),('Get Patient Programs','Able to get which programs that patients are in','d05118c6-2490-4d78-a41a-390e3596a227'),('Get Patients','Able to get patients','d05118c6-2490-4d78-a41a-390e3596a244'),('Get People','Able to get person objects','d05118c6-2490-4d78-a41a-390e3596a224'),('Get Person Attribute Types','Able to get person attribute types','d05118c6-2490-4d78-a41a-390e3596a225'),('Get Privileges','Able to get user privileges','d05118c6-2490-4d78-a41a-390e3596a236'),('Get Problems','Able to get problems','d05118c6-2490-4d78-a41a-390e3596a221'),('Get Programs','Able to get patient programs','d05118c6-2490-4d78-a41a-390e3596a228'),('Get Providers','Able to get Providers','d05118c6-2490-4d78-a41a-390e3596a211'),('Get Relationship Types','Able to get relationship types','d05118c6-2490-4d78-a41a-390e3596a232'),('Get Relationships','Able to get relationships','d05118c6-2490-4d78-a41a-390e3596a223'),('Get Roles','Able to get user roles','d05118c6-2490-4d78-a41a-390e3596a235'),('Get Users','Able to get users in OpenMRS','d05118c6-2490-4d78-a41a-390e3596a249'),('Get Visit Attribute Types','Able to get visit attribute types','d05118c6-2490-4d78-a41a-390e3596a213'),('Get Visit Types','Able to get visit types','d05118c6-2490-4d78-a41a-390e3596a215'),('Get Visits','Able to get visits','d05118c6-2490-4d78-a41a-390e3596a214'),('Manage Address Templates','Able to add/edit/delete address templates','fb21b9ee-fd8a-47b6-8656-bd3a68a44925'),('Manage Alerts','Able to add/edit/delete user alerts','5f8a3282-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Attribute Types','Able to add/edit/retire concept attribute types','7550fbcb-cb61-4a9f-94d5-eb376afc727f'),('Manage Concept Classes','Able to add/edit/retire concept classes','5f8a32aa-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Datatypes','Able to add/edit/retire concept datatypes','5f8a32dc-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Map Types','Able to add/edit/retire concept map types','385096c5-6492-41f3-8304-c0144e8fb2e6'),('Manage Concept Name tags','Able to add/edit/delete concept name tags','401cc09a-84c6-4d9e-bf93-4659837edbde'),('Manage Concept Reference Terms','Able to add/edit/retire reference terms','80e45896-d4cd-48a1-b35e-30709bab36b6'),('Manage Concept Sources','Able to add/edit/delete concept sources','5f8a3304-6814-11e8-923f-e9a88dcb533f'),('Manage Concept Stop Words','Able to view/add/remove the concept stop words','47b5b16e-0ff5-4a4a-ae26-947af73c88ca'),('Manage Concepts','Able to add/edit/delete concept entries','5f8a3336-6814-11e8-923f-e9a88dcb533f'),('Manage Encounter Roles','Able to add/edit/retire encounter roles','0fbaddea-b053-4841-a1f1-2ca93fd71d9a'),('Manage Encounter Types','Able to add/edit/delete encounter types','5f8a3368-6814-11e8-923f-e9a88dcb533f'),('Manage Field Types','Able to add/edit/retire field types','5f8a3390-6814-11e8-923f-e9a88dcb533f'),('Manage FormEntry XSN','Allows user to upload and edit the xsns stored on the server','5f8a33b8-6814-11e8-923f-e9a88dcb533f'),('Manage Forms','Able to add/edit/delete forms','5f8a33ea-6814-11e8-923f-e9a88dcb533f'),('Manage Global Properties','Able to add/edit global properties','5f8a341c-6814-11e8-923f-e9a88dcb533f'),('Manage HL7 Messages','Able to add/edit/delete HL7 messages','e43b8830-7c95-42e6-8259-538fec951c66'),('Manage Identifier Types','Able to add/edit/delete patient identifier types','5f8a3444-6814-11e8-923f-e9a88dcb533f'),('Manage Implementation Id','Able to view/add/edit the implementation id for the system','20e102e1-74b4-4198-905e-9b598c8474f1'),('Manage Location Attribute Types','Able to add/edit/retire location attribute types','5c266720-20c2-4fa2-89d3-56886176d63a'),('Manage Location Tags','Able to add/edit/delete location tags','d6d83d7f-9241-42e6-9689-393920a4f733'),('Manage Locations','Able to add/edit/delete locations','5f8a3476-6814-11e8-923f-e9a88dcb533f'),('Manage Modules','Able to add/remove modules to the system','5f8a349e-6814-11e8-923f-e9a88dcb533f'),('Manage Order Frequencies','Able to add/edit/retire Order Frequencies','e3a5205d-ab12-40ca-9160-9ba02198e389'),('Manage Order Set Attribute Types','Able to add/edit/retire order set attribute types','abcb7caf-5c6e-4714-baca-a4de19bf743a'),('Manage Order Sets','Able to manage order sets','059955e6-014f-4e50-b198-24e179784025'),('Manage Order Types','Able to add/edit/retire order types','5f8a34c6-6814-11e8-923f-e9a88dcb533f'),('Manage OWA','Allows to configure OWA module, upload modules','13610e32-a549-4640-ae0e-0bdfc542a0a0'),('Manage Person Attribute Types','Able to add/edit/delete person attribute types','5f8a34f8-6814-11e8-923f-e9a88dcb533f'),('Manage Privileges','Able to add/edit/delete privileges','5f8a3520-6814-11e8-923f-e9a88dcb533f'),('Manage Programs','Able to add/view/delete patient programs','5f8a3552-6814-11e8-923f-e9a88dcb533f'),('Manage Providers','Able to edit Provider','b0b6fe18-9940-42b4-80fc-b05e6ee546f5'),('Manage Relationship Types','Able to add/edit/retire relationship types','5f8a357a-6814-11e8-923f-e9a88dcb533f'),('Manage Relationships','Able to add/edit/delete relationships','5f8a35ac-6814-11e8-923f-e9a88dcb533f'),('Manage RESTWS','Allows to configure RESTWS module','cb5c124f-245f-4174-a4f3-c70ba3e51fc8'),('Manage Roles','Able to add/edit/delete user roles','5f8a35d4-6814-11e8-923f-e9a88dcb533f'),('Manage Scheduler','Able to add/edit/remove scheduled tasks','5f8a3606-6814-11e8-923f-e9a88dcb533f'),('Manage Search Index','Able to manage the search index','657bfbbb-a008-43f3-85ac-3163d201b389'),('Manage Visit Attribute Types','Able to add/edit/retire visit attribute types','d0e19ed6-a299-4435-ab8f-2ea76e22fcc4'),('Manage Visit Types','Able to add/edit/delete visit types','f9196849-164f-4522-80d8-488d36faeec2'),('Patient Dashboard - View Demographics Section','Able to view the \'Demographics\' tab on the patient dashboard','5f8a362e-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Encounters Section','Able to view the \'Encounters\' tab on the patient dashboard','5f8a3660-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Forms Section','Allows user to view the Forms tab on the patient dashboard','5f8a3692-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Graphs Section','Able to view the \'Graphs\' tab on the patient dashboard','5f8a36ce-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Overview Section','Able to view the \'Overview\' tab on the patient dashboard','5f8a3700-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Patient Summary','Able to view the \'Summary\' tab on the patient dashboard','5f8a3732-6814-11e8-923f-e9a88dcb533f'),('Patient Dashboard - View Regimen Section','Able to view the \'Regimen\' tab on the patient dashboard','5f8a375a-6814-11e8-923f-e9a88dcb533f'),('Patient Overview - View Allergies','Able to view the Allergies portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a261'),('Patient Overview - View Patient Actions','Able to view the Patient Actions portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a264'),('Patient Overview - View Problem List','Able to view the Problem List portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a260'),('Patient Overview - View Programs','Able to view the Programs portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a263'),('Patient Overview - View Relationships','Able to view the Relationships portlet on the patient overview tab','d05118c6-2490-4d78-a41a-390e3596a262'),('Purge Field Types','Able to purge field types','5f8a3796-6814-11e8-923f-e9a88dcb533f'),('Remove Allergies','Remove allergies','dbdea8f5-9fca-4527-9ef6-5fa03eebf2bd'),('Remove Problems','Remove problems','28ea7e84-e21a-4031-9f9f-2d3eda9d1200'),('Task: Modify Allergies','Able to add, edit, delete allergies','eeb9108e-6905-4712-a13c-b9435db4abcb'),('Update HL7 Inbound Archive','Able to update an HL7 archive item','5dd8306f-eeb4-430e-b5da-a6e02bcafb79'),('Update HL7 Inbound Exception','Able to update an HL7 archive item','e2614f6d-a730-4292-9c10-baf6d912500f'),('Update HL7 Inbound Queue','Able to update an HL7 Queue item','f82b7723-110e-47d3-a35b-4552ea1bff9e'),('Update HL7 Source','Able to update an HL7 Source','6e0abfb7-e95c-4efd-82a0-00a02b0e8335'),('Upload XSN','Allows user to upload/overwrite the XSNs defined for forms','5f8a37c8-6814-11e8-923f-e9a88dcb533f'),('View Administration Functions','Able to view the \'Administration\' link in the navigation bar','5f8a37fa-6814-11e8-923f-e9a88dcb533f'),('View Allergies','Able to view allergies in OpenMRS','5f8a382c-6814-11e8-923f-e9a88dcb533f'),('View Concept Classes','Able to view concept classes','5f8a3958-6814-11e8-923f-e9a88dcb533f'),('View Concept Datatypes','Able to view concept datatypes','5f8a398a-6814-11e8-923f-e9a88dcb533f'),('View Concept Proposals','Able to view concept proposals to the system','5f8a39bc-6814-11e8-923f-e9a88dcb533f'),('View Concept Sources','Able to view concept sources','5f8a39ee-6814-11e8-923f-e9a88dcb533f'),('View Concepts','Able to view concept entries','5f8a3a16-6814-11e8-923f-e9a88dcb533f'),('View Data Entry Statistics','Able to view data entry statistics from the admin screen','5f8a3a48-6814-11e8-923f-e9a88dcb533f'),('View Encounter Types','Able to view encounter types','5f8a3a7a-6814-11e8-923f-e9a88dcb533f'),('View Encounters','Able to view patient encounters','5f8a3aa2-6814-11e8-923f-e9a88dcb533f'),('View Field Types','Able to view field types','5f8a3ad4-6814-11e8-923f-e9a88dcb533f'),('View Forms','Able to view forms','5f8a3afc-6814-11e8-923f-e9a88dcb533f'),('View Global Properties','Able to view global properties on the administration screen','5f8a3b2e-6814-11e8-923f-e9a88dcb533f'),('View Identifier Types','Able to view patient identifier types','5f8a3b60-6814-11e8-923f-e9a88dcb533f'),('View Locations','Able to view locations','5f8a3b88-6814-11e8-923f-e9a88dcb533f'),('View Navigation Menu','Ability to see the navigation menu','5f8a3bba-6814-11e8-923f-e9a88dcb533f'),('View Observations','Able to view patient observations','5f8a3be2-6814-11e8-923f-e9a88dcb533f'),('View Order Types','Able to view order types','5f8a3c14-6814-11e8-923f-e9a88dcb533f'),('View Orders','Able to view orders','5f8a3c46-6814-11e8-923f-e9a88dcb533f'),('View Patient Cohorts','Able to view patient cohorts','5f8a3c6e-6814-11e8-923f-e9a88dcb533f'),('View Patient Identifiers','Able to view patient identifiers','5f8a3ca0-6814-11e8-923f-e9a88dcb533f'),('View Patient Programs','Able to see which programs that patients are in','5f8a3cd2-6814-11e8-923f-e9a88dcb533f'),('View Patients','Able to view patients','5f8a3cfa-6814-11e8-923f-e9a88dcb533f'),('View People','Able to view person objects','5f8a3d2c-6814-11e8-923f-e9a88dcb533f'),('View Person Attribute Types','Able to view person attribute types','5f8a3d5e-6814-11e8-923f-e9a88dcb533f'),('View Privileges','Able to view user privileges','5f8a3d86-6814-11e8-923f-e9a88dcb533f'),('View Problems','Able to view problems in OpenMRS','5f8a3db8-6814-11e8-923f-e9a88dcb533f'),('View Programs','Able to view patient programs','5f8a3de0-6814-11e8-923f-e9a88dcb533f'),('View Relationship Types','Able to view relationship types','5f8a3e12-6814-11e8-923f-e9a88dcb533f'),('View Relationships','Able to view relationships','5f8a3e44-6814-11e8-923f-e9a88dcb533f'),('View Report Objects','Able to view report objects','5f8a3e6c-6814-11e8-923f-e9a88dcb533f'),('View Reports','Able to view reports','5f8a3e9e-6814-11e8-923f-e9a88dcb533f'),('View RESTWS','Gives access to RESTWS in administration','b9543413-8619-4a9a-a056-360f1620fe0e'),('View Roles','Able to view user roles','5f8a3ec6-6814-11e8-923f-e9a88dcb533f'),('View Unpublished Forms','Able to view and fill out unpublished forms','5f8a3ef8-6814-11e8-923f-e9a88dcb533f'),('View Users','Able to view users in OpenMRS','5f8a3f2a-6814-11e8-923f-e9a88dcb533f');
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `outcomes_concept_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_concept` (`concept_id`),
  KEY `program_creator` (`creator`),
  KEY `program_outcomes_concept_id_fk` (`outcomes_concept_id`),
  KEY `user_who_changed_program` (`changed_by`),
  CONSTRAINT `program_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_outcomes_concept_id_fk` FOREIGN KEY (`outcomes_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_program` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_attribute_type`
--

DROP TABLE IF EXISTS `program_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_attribute_type` (
  `program_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_attribute_type_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_attribute_type_changed_by_fk` (`changed_by`),
  KEY `program_attribute_type_creator_fk` (`creator`),
  KEY `program_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `program_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `program_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_attribute_type`
--

LOCK TABLES `program_attribute_type` WRITE;
/*!40000 ALTER TABLE `program_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow`
--

DROP TABLE IF EXISTS `program_workflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow` (
  `program_workflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_id` int(11) NOT NULL DEFAULT 0,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `program_for_workflow` (`program_id`),
  KEY `workflow_changed_by` (`changed_by`),
  KEY `workflow_concept` (`concept_id`),
  KEY `workflow_creator` (`creator`),
  CONSTRAINT `program_for_workflow` FOREIGN KEY (`program_id`) REFERENCES `program` (`program_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow`
--

LOCK TABLES `program_workflow` WRITE;
/*!40000 ALTER TABLE `program_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program_workflow_state`
--

DROP TABLE IF EXISTS `program_workflow_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_workflow_state` (
  `program_workflow_state_id` int(11) NOT NULL AUTO_INCREMENT,
  `program_workflow_id` int(11) NOT NULL DEFAULT 0,
  `concept_id` int(11) NOT NULL DEFAULT 0,
  `initial` tinyint(1) NOT NULL DEFAULT 0,
  `terminal` tinyint(1) NOT NULL DEFAULT 0,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`program_workflow_state_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `state_changed_by` (`changed_by`),
  KEY `state_concept` (`concept_id`),
  KEY `state_creator` (`creator`),
  KEY `workflow_for_state` (`program_workflow_id`),
  CONSTRAINT `state_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_concept` FOREIGN KEY (`concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `workflow_for_state` FOREIGN KEY (`program_workflow_id`) REFERENCES `program_workflow` (`program_workflow_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program_workflow_state`
--

LOCK TABLES `program_workflow_state` WRITE;
/*!40000 ALTER TABLE `program_workflow_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `program_workflow_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `speciality_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_changed_by_fk` (`changed_by`),
  KEY `provider_creator_fk` (`creator`),
  KEY `provider_person_id_fk` (`person_id`),
  KEY `provider_retired_by_fk` (`retired_by`),
  KEY `provider_role_id_fk` (`role_id`),
  KEY `provider_speciality_id_fk` (`speciality_id`),
  CONSTRAINT `provider_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_person_id_fk` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_role_id_fk` FOREIGN KEY (`role_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_speciality_id_fk` FOREIGN KEY (`speciality_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (1,1,NULL,'UNKNOWN',2,'2018-10-05 12:12:56',2,'2018-10-05 12:13:08',0,NULL,NULL,NULL,'e5533452-a11e-11eb-867f-005056bcd993',NULL,NULL);
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute`
--

DROP TABLE IF EXISTS `provider_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute` (
  `provider_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`provider_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `provider_attribute_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_creator_fk` (`creator`),
  KEY `provider_attribute_provider_fk` (`provider_id`),
  KEY `provider_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `provider_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `provider_attribute_type` (`provider_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_provider_fk` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute`
--

LOCK TABLES `provider_attribute` WRITE;
/*!40000 ALTER TABLE `provider_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider_attribute_type`
--

DROP TABLE IF EXISTS `provider_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_attribute_type` (
  `provider_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`provider_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `provider_attribute_type_changed_by_fk` (`changed_by`),
  KEY `provider_attribute_type_creator_fk` (`creator`),
  KEY `provider_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `provider_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `provider_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_attribute_type`
--

LOCK TABLES `provider_attribute_type` WRITE;
/*!40000 ALTER TABLE `provider_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship`
--

DROP TABLE IF EXISTS `relationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship` (
  `relationship_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_a` int(11) NOT NULL,
  `relationship` int(11) NOT NULL DEFAULT 0,
  `person_b` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`relationship_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `person_a_is_person` (`person_a`),
  KEY `person_b_is_person` (`person_b`),
  KEY `relation_creator` (`creator`),
  KEY `relation_voider` (`voided_by`),
  KEY `relationship_changed_by` (`changed_by`),
  KEY `relationship_type_id` (`relationship`),
  CONSTRAINT `person_a_is_person` FOREIGN KEY (`person_a`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `person_b_is_person` FOREIGN KEY (`person_b`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relation_voider` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relationship_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `relationship_type_id` FOREIGN KEY (`relationship`) REFERENCES `relationship_type` (`relationship_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship`
--

LOCK TABLES `relationship` WRITE;
/*!40000 ALTER TABLE `relationship` DISABLE KEYS */;
/*!40000 ALTER TABLE `relationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relationship_type`
--

DROP TABLE IF EXISTS `relationship_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationship_type` (
  `relationship_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_is_to_b` varchar(50) NOT NULL,
  `b_is_to_a` varchar(50) NOT NULL,
  `preferred` tinyint(1) NOT NULL DEFAULT 0,
  `weight` int(11) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`relationship_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `relationship_type_changed_by` (`changed_by`),
  KEY `user_who_created_rel` (`creator`),
  KEY `user_who_retired_relationship_type` (`retired_by`),
  CONSTRAINT `relationship_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_created_rel` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_relationship_type` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relationship_type`
--

LOCK TABLES `relationship_type` WRITE;
/*!40000 ALTER TABLE `relationship_type` DISABLE KEYS */;
INSERT INTO `relationship_type` VALUES (1,'Doctor','Patient',0,0,'Relationship from a primary care provider to the patient',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d919b58-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(2,'Sibling','Sibling',0,0,'Relationship between brother/sister, brother/brother, and sister/sister',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a01c-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(3,'Parent','Child',0,0,'Relationship from a mother/father to the child',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a210-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL),(4,'Aunt/Uncle','Niece/Nephew',0,0,'Relationship from a parent\'s sibling to a child of that parent',1,'2007-05-04 00:00:00',0,NULL,NULL,NULL,'8d91a3dc-c2cc-11de-8d13-0010c6dffd0f',NULL,NULL);
/*!40000 ALTER TABLE `relationship_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_object`
--

DROP TABLE IF EXISTS `report_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_object` (
  `report_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `report_object_type` varchar(255) NOT NULL,
  `report_object_sub_type` varchar(255) NOT NULL,
  `xml_data` text DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `report_object_creator` (`creator`),
  KEY `user_who_changed_report_object` (`changed_by`),
  KEY `user_who_voided_report_object` (`voided_by`),
  CONSTRAINT `report_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_report_object` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_voided_report_object` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_object`
--

LOCK TABLES `report_object` WRITE;
/*!40000 ALTER TABLE `report_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_schema_xml`
--

DROP TABLE IF EXISTS `report_schema_xml`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_schema_xml` (
  `report_schema_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `xml_data` text NOT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`report_schema_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_schema_xml`
--

LOCK TABLES `report_schema_xml` WRITE;
/*!40000 ALTER TABLE `report_schema_xml` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_schema_xml` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`role`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES ('Anonymous','Privileges for non-authenticated users.','774b2af3-6437-4e5a-a310-547554c7c65c'),('Authenticated','Privileges gained once authentication has been established.','f7fd42ef-880e-40c5-972d-e4ae7c990de2'),('Clinician','Privileges for doctors','e46ae936-a591-4a51-993d-29f1dcde3c86'),('Data Assistant','Privileges for data-entry operators.','bf9ca47d-cee4-433a-b35b-4bfa46f823fa'),('Data Manager','Privileges for user who manage data entered by data-entry operators','65e2070a-8ffd-473e-8555-3953714a950a'),('Provider','All users with the \'Provider\' role will appear as options in the default Infopath','8d94f280-c2cc-11de-8d13-0010c6dffd0f'),('System Developer','Developers of the OpenMRS .. have additional access to change fundamental structure of the database model.','8d94f852-c2cc-11de-8d13-0010c6dffd0f');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role` varchar(50) NOT NULL DEFAULT '',
  `privilege` varchar(255) NOT NULL,
  PRIMARY KEY (`role`,`privilege`),
  KEY `privilege_definitions` (`privilege`),
  KEY `role_privilege_to_role` (`role`),
  CONSTRAINT `privilege_definitions` FOREIGN KEY (`privilege`) REFERENCES `privilege` (`privilege`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `role_privilege_to_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES ('Authenticated','Get Concept Classes'),('Authenticated','Get Concept Datatypes'),('Authenticated','Get Encounter Types'),('Authenticated','Get Field Types'),('Authenticated','Get Global Properties'),('Authenticated','Get Identifier Types'),('Authenticated','Get Locations'),('Authenticated','Get Order Types'),('Authenticated','Get Person Attribute Types'),('Authenticated','Get Privileges'),('Authenticated','Get Relationship Types'),('Authenticated','Get Relationships'),('Authenticated','Get Roles'),('Authenticated','Patient Overview - View Relationships'),('Authenticated','View Concept Classes'),('Authenticated','View Concept Datatypes'),('Authenticated','View Encounter Types'),('Authenticated','View Field Types'),('Authenticated','View Global Properties'),('Authenticated','View Identifier Types'),('Authenticated','View Locations'),('Authenticated','View Order Types'),('Authenticated','View Person Attribute Types'),('Authenticated','View Privileges'),('Authenticated','View Relationship Types'),('Authenticated','View Relationships'),('Authenticated','View Roles');
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_role`
--

DROP TABLE IF EXISTS `role_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_role` (
  `parent_role` varchar(50) NOT NULL DEFAULT '',
  `child_role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`parent_role`,`child_role`),
  KEY `inherited_role` (`child_role`),
  CONSTRAINT `inherited_role` FOREIGN KEY (`child_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `parent_role` FOREIGN KEY (`parent_role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_role`
--

LOCK TABLES `role_role` WRITE;
/*!40000 ALTER TABLE `role_role` DISABLE KEYS */;
INSERT INTO `role_role` VALUES ('Data Assistant','Data Manager'),('Provider','Clinician');
/*!40000 ALTER TABLE `role_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config`
--

DROP TABLE IF EXISTS `scheduler_task_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config` (
  `task_config_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `schedulable_class` text DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `start_time_pattern` varchar(50) DEFAULT NULL,
  `repeat_interval` int(11) NOT NULL DEFAULT 0,
  `start_on_startup` tinyint(1) NOT NULL DEFAULT 0,
  `started` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` int(11) DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `last_execution_time` datetime DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`task_config_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `scheduler_changer` (`changed_by`),
  KEY `scheduler_creator` (`created_by`),
  CONSTRAINT `scheduler_changer` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scheduler_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config`
--

LOCK TABLES `scheduler_task_config` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config` DISABLE KEYS */;
INSERT INTO `scheduler_task_config` VALUES (2,'Auto Close Visits Task','Stops all active visits that match the visit type(s) specified by the value of the global property \'visits.autoCloseVisitType\'','org.openmrs.scheduler.tasks.AutoCloseVisitsTask','2011-11-28 23:59:59','MM/dd/yyyy HH:mm:ss',86400,0,0,1,'2018-06-04 18:30:16',NULL,NULL,NULL,'8c17b376-1a2b-11e1-a51a-00248140a5eb');
/*!40000 ALTER TABLE `scheduler_task_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduler_task_config_property`
--

DROP TABLE IF EXISTS `scheduler_task_config_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduler_task_config_property` (
  `task_config_property_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `task_config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_config_property_id`),
  KEY `task_config_for_property` (`task_config_id`),
  CONSTRAINT `task_config_for_property` FOREIGN KEY (`task_config_id`) REFERENCES `scheduler_task_config` (`task_config_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduler_task_config_property`
--

LOCK TABLES `scheduler_task_config_property` WRITE;
/*!40000 ALTER TABLE `scheduler_task_config_property` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduler_task_config_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialized_object`
--

DROP TABLE IF EXISTS `serialized_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialized_object` (
  `serialized_object_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `subtype` varchar(255) NOT NULL,
  `serialization_class` varchar(255) NOT NULL,
  `serialized_data` mediumtext NOT NULL,
  `date_created` datetime NOT NULL,
  `creator` int(11) NOT NULL,
  `date_changed` datetime DEFAULT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `date_retired` datetime DEFAULT NULL,
  `retired_by` int(11) DEFAULT NULL,
  `retire_reason` varchar(1000) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`serialized_object_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `serialized_object_changed_by` (`changed_by`),
  KEY `serialized_object_creator` (`creator`),
  KEY `serialized_object_retired_by` (`retired_by`),
  CONSTRAINT `serialized_object_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `serialized_object_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `serialized_object_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialized_object`
--

LOCK TABLES `serialized_object` WRITE;
/*!40000 ALTER TABLE `serialized_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialized_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_order`
--

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL DEFAULT 0,
  `specimen_source` int(11) DEFAULT NULL,
  `laterality` varchar(20) DEFAULT NULL,
  `clinical_history` text DEFAULT NULL,
  `frequency` int(11) DEFAULT NULL,
  `number_of_repeats` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `test_order_frequency_fk` (`frequency`),
  KEY `test_order_specimen_source_fk` (`specimen_source`),
  CONSTRAINT `test_order_frequency_fk` FOREIGN KEY (`frequency`) REFERENCES `order_frequency` (`order_frequency_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `test_order_order_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `test_order_specimen_source_fk` FOREIGN KEY (`specimen_source`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_order`
--

LOCK TABLES `test_order` WRITE;
/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_property`
--

DROP TABLE IF EXISTS `user_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_property` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `property` varchar(100) NOT NULL DEFAULT '',
  `property_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`property`),
  CONSTRAINT `user_property_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_property`
--

LOCK TABLES `user_property` WRITE;
/*!40000 ALTER TABLE `user_property` DISABLE KEYS */;
INSERT INTO `user_property` VALUES (1,'defaultLocation',''),(1,'lockoutTimestamp',''),(1,'loginAttempts','0'),(1,'notification',''),(1,'notificationAddress',''),(1,'showRetired','false'),(1,'showVerbose','false'),(3,'lockoutTimestamp',''),(3,'loginAttempts','0');
/*!40000 ALTER TABLE `user_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `role` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`role`),
  KEY `role_definitions` (`role`),
  KEY `user_role_to_users` (`user_id`),
  CONSTRAINT `role_definitions` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_role_to_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'Provider'),(1,'System Developer'),(3,'Authenticated'),(3,'Data Assistant'),(3,'Data Manager'),(3,'Provider'),(3,'System Developer');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `system_id` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `salt` varchar(128) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `creator` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  `activation_key` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `person_id_for_user` (`person_id`),
  KEY `user_creator` (`creator`),
  KEY `user_who_changed_user` (`changed_by`),
  KEY `user_who_retired_this_user` (`retired_by`),
  CONSTRAINT `person_id_for_user` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_changed_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_who_retired_this_user` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',NULL,'f2b2e644371c726d5f01ad4555051d15f44b4804aee390bb20aecdb291852fe8bd55ca6de0f2dd7f34438308d60d746b66e1dcf5fd871f0410fd00d1eebcd3c6','ff25e727d769601071f01d3294d5d9b4593d4142f0e2fe669a217f71cc287785790866bd4765a1012218a1e49192bd23458824aae45363fd6d2c5ea4047c7125',NULL,NULL,1,'2005-01-01 00:00:00',1,'2021-04-20 11:00:20',1,0,NULL,NULL,NULL,'82f18b44-6814-11e8-923f-e9a88dcb533f',NULL,NULL),(2,'daemon','daemon',NULL,NULL,NULL,NULL,1,'2010-04-26 13:25:00',NULL,NULL,1,0,NULL,NULL,NULL,'A4F30A1B-5EB9-11DF-A648-37A07F9C90FB',NULL,NULL),(3,'3-4','djpaulus','c55d47f2190b0bd05983b6d41dc0352a3b411a07914b2ea9b68cf603300eb8c18bd9202a494cad15887f3b31eb03d5295ef83fd547190ad3307320d31e70bee4','68fbf916ef20cb1b0ef98a24028eb8bb37071027cc188032d357331c6dc77ed826a7bed3fb7e02e8ff296253723bfcae15e26831df6ab5105329abfd10a484c3',NULL,NULL,1,'2021-04-20 11:01:34',1,'2021-04-20 11:01:34',2,0,NULL,NULL,NULL,'3087cd12-32c3-4e1d-9d5b-6b700eab7aa2',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit` (
  `visit_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) NOT NULL,
  `visit_type_id` int(11) NOT NULL,
  `date_started` datetime NOT NULL,
  `date_stopped` datetime DEFAULT NULL,
  `indication_concept_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_changed_by_fk` (`changed_by`),
  KEY `visit_creator_fk` (`creator`),
  KEY `visit_indication_concept_fk` (`indication_concept_id`),
  KEY `visit_location_fk` (`location_id`),
  KEY `visit_patient_index` (`patient_id`),
  KEY `visit_type_fk` (`visit_type_id`),
  KEY `visit_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_indication_concept_fk` FOREIGN KEY (`indication_concept_id`) REFERENCES `concept` (`concept_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_location_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_patient_fk` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_fk` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_type` (`visit_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute`
--

DROP TABLE IF EXISTS `visit_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute` (
  `visit_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `visit_id` int(11) NOT NULL,
  `attribute_type_id` int(11) NOT NULL,
  `value_reference` text NOT NULL,
  `uuid` char(38) NOT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `voided` tinyint(1) NOT NULL DEFAULT 0,
  `voided_by` int(11) DEFAULT NULL,
  `date_voided` datetime DEFAULT NULL,
  `void_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`visit_attribute_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_attribute_type_id_fk` (`attribute_type_id`),
  KEY `visit_attribute_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_creator_fk` (`creator`),
  KEY `visit_attribute_visit_fk` (`visit_id`),
  KEY `visit_attribute_voided_by_fk` (`voided_by`),
  CONSTRAINT `visit_attribute_attribute_type_id_fk` FOREIGN KEY (`attribute_type_id`) REFERENCES `visit_attribute_type` (`visit_attribute_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_visit_fk` FOREIGN KEY (`visit_id`) REFERENCES `visit` (`visit_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_voided_by_fk` FOREIGN KEY (`voided_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute`
--

LOCK TABLES `visit_attribute` WRITE;
/*!40000 ALTER TABLE `visit_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_attribute_type`
--

DROP TABLE IF EXISTS `visit_attribute_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_attribute_type` (
  `visit_attribute_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `datatype_config` text DEFAULT NULL,
  `preferred_handler` varchar(255) DEFAULT NULL,
  `handler_config` text DEFAULT NULL,
  `min_occurs` int(11) NOT NULL,
  `max_occurs` int(11) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_attribute_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_attribute_type_changed_by_fk` (`changed_by`),
  KEY `visit_attribute_type_creator_fk` (`creator`),
  KEY `visit_attribute_type_retired_by_fk` (`retired_by`),
  CONSTRAINT `visit_attribute_type_changed_by_fk` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_type_creator_fk` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_attribute_type_retired_by_fk` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_attribute_type`
--

LOCK TABLES `visit_attribute_type` WRITE;
/*!40000 ALTER TABLE `visit_attribute_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_attribute_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit_type`
--

DROP TABLE IF EXISTS `visit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visit_type` (
  `visit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `creator` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `changed_by` int(11) DEFAULT NULL,
  `date_changed` datetime DEFAULT NULL,
  `retired` tinyint(1) NOT NULL DEFAULT 0,
  `retired_by` int(11) DEFAULT NULL,
  `date_retired` datetime DEFAULT NULL,
  `retire_reason` varchar(255) DEFAULT NULL,
  `uuid` char(38) NOT NULL,
  PRIMARY KEY (`visit_type_id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `visit_type_changed_by` (`changed_by`),
  KEY `visit_type_creator` (`creator`),
  KEY `visit_type_retired_by` (`retired_by`),
  CONSTRAINT `visit_type_changed_by` FOREIGN KEY (`changed_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_creator` FOREIGN KEY (`creator`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `visit_type_retired_by` FOREIGN KEY (`retired_by`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_type`
--

LOCK TABLES `visit_type` WRITE;
/*!40000 ALTER TABLE `visit_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-20 15:33:56
