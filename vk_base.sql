-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_22
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

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
-- Table structure for table `comments`
--
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autor_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `autor_id` (`autor_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,15,8,'1985-02-07 09:30:38','1979-08-11 12:39:17'),(2,7,10,'1984-07-25 11:41:54','1972-06-30 21:56:36'),(3,10,14,'1995-11-08 02:32:23','1982-12-28 09:29:42'),(4,13,1,'1995-08-15 04:09:54','1991-01-15 04:29:04'),(5,13,9,'1993-08-15 19:35:11','2006-12-01 23:35:02'),(6,5,5,'2007-08-05 03:02:08','1996-02-23 11:38:45'),(7,15,9,'1997-12-29 06:21:45','2011-04-04 22:31:26'),(8,8,8,'2009-11-10 05:05:44','1987-06-26 16:57:47'),(9,7,9,'2009-09-23 18:44:22','1971-02-05 06:36:40'),(10,15,2,'2007-11-30 17:40:42','1972-01-16 15:23:22'),(11,3,13,'2006-05-25 00:18:07','1995-07-13 16:25:59'),(12,15,6,'1988-08-07 14:28:44','1970-11-30 17:55:30'),(13,4,4,'1983-11-15 07:22:22','2009-05-27 01:20:41'),(14,13,6,'2010-08-28 03:00:28','1975-10-22 04:19:51'),(15,4,3,'2016-01-23 04:07:04','2005-11-09 18:47:29');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'quod',14),(2,'perspiciatis',12),(3,'et',8),(4,'corrupti',4),(5,'delectus',8),(6,'qui',7),(7,'quam',4),(8,'ipsam',7),(9,'expedita',2),(10,'reprehenderit',11),(11,'aspernatur',6),(12,'quia',13),(13,'at',6),(14,'quia',1),(15,'aliquid',12);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_resquest`
--

DROP TABLE IF EXISTS `friend_resquest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_resquest` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_resquest_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_resquest_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`initiator_user_id` <> `target_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_resquest`
--

LOCK TABLES `friend_resquest` WRITE;
/*!40000 ALTER TABLE `friend_resquest` DISABLE KEYS */;
INSERT INTO `friend_resquest` VALUES (2,10,'approved','2003-11-04 00:39:55','2010-04-22 17:49:03'),(3,1,'unfriended','1977-05-07 18:23:22','1978-02-12 10:27:02'),(3,8,'declined','1988-10-25 02:12:30','1982-09-17 17:45:44'),(3,15,'approved','2019-08-09 08:55:42','2012-07-22 04:11:57'),(6,10,'approved','1980-07-02 16:41:46','2011-10-21 03:50:45'),(7,12,'unfriended','1997-11-28 15:42:12','1991-09-20 23:10:54'),(7,14,'requested','2018-03-18 00:34:41','1989-12-07 15:44:49'),(8,5,'unfriended','1977-08-06 20:14:46','1999-08-14 17:41:00'),(9,6,'approved','2013-08-17 01:47:16','1991-01-11 06:36:17'),(10,3,'declined','1985-04-23 08:39:19','2017-06-29 12:02:58'),(12,9,'declined','2008-10-27 10:57:41','1986-10-20 02:47:45'),(14,4,'declined','2011-07-16 10:48:30','1996-06-29 12:45:27'),(15,3,'requested','1990-02-26 15:33:33','2014-02-02 20:17:45'),(15,8,'approved','2007-10-19 23:36:31','2001-08-30 03:38:52');
/*!40000 ALTER TABLE `friend_resquest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,14,13,'2011-03-10 07:21:19'),(2,3,11,'2001-12-23 09:12:58'),(3,14,1,'2015-05-16 14:33:25'),(4,12,4,'2016-05-01 15:30:55'),(5,6,1,'1977-01-19 05:22:28'),(6,13,2,'2007-10-31 02:44:09'),(7,7,12,'1993-04-16 14:49:32'),(8,14,12,'1988-06-24 10:01:36'),(9,15,5,'1993-12-05 16:18:12'),(10,2,1,'1992-02-23 20:23:25'),(11,7,11,'2013-04-19 15:15:49'),(12,2,3,'1993-12-26 19:17:17'),(13,5,5,'2018-03-20 00:59:43'),(14,3,2,'2005-09-10 15:44:46'),(15,1,15,'1973-07-09 01:25:47');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metadata` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,5,12,'Voluptate in architecto qui aut. Vel odio earum enim rerum sit reiciendis sapiente. Ullam dignissimos enim suscipit ipsum. Quaerat id nihil unde id odit quis.','application/vnd.ms-powerpoint.presentation.macroenabled.12','Sit facere aliquid sapiente dolore. Cum velit in esse quia maxime eius dolorem. Dolore voluptas delectus itaque voluptatem asperiores. Labore sunt tempore beatae excepturi omnis distinctio.'),(2,6,1,'Possimus dignissimos ab alias earum aut suscipit autem. Ab rerum facere laudantium assumenda non deleniti. Enim eius ut magnam voluptatem.','application/x-t3vm-image','Iste aliquam ut amet aut dicta minus quis. Repudiandae corporis voluptas dolorem eos sed nihil.'),(3,4,14,'Placeat et culpa id autem tenetur et. Iure voluptas voluptatibus animi commodi quisquam mollitia. Quis qui sint minus iure.','application/vnd.oasis.opendocument.chart','Cum eum omnis officiis laboriosam. A et maiores quae. Aperiam sed deleniti laudantium veritatis sit.'),(4,2,7,'Eum natus ullam similique laudantium. Voluptates qui voluptas adipisci. Aut quod earum facere enim. Blanditiis nam aut est harum aut cum ut aut. Doloremque nihil et et quasi soluta.','application/vnd.igloader','Voluptatem earum consequatur rerum totam blanditiis architecto odio alias. Tempore sit dolor voluptatibus quia officiis odio ipsum.'),(5,5,6,'Aut cumque dolorem hic et dolores ad. Aut aut iusto quis sit. Sed magni porro odio aut eum. Officia voluptatum velit distinctio fugiat.','application/vnd.ecowin.chart','At expedita dolor officiis nesciunt quibusdam. Rerum ad quibusdam aliquam libero non unde quisquam. A at aut velit a est libero reprehenderit.'),(6,9,14,'Magnam quidem et est vel ipsam dolorum. Quaerat vel earum at voluptatem. Quia est eligendi sit. Qui facere aspernatur est minus corporis eos est.','application/vnd.sun.xml.writer.global','Aspernatur ut a perferendis aperiam quo doloremque et. Iste ut illo consequatur soluta corrupti quod. Dolore modi blanditiis enim et ut. Debitis ut et possimus quisquam.'),(7,10,11,'Dolor nihil ex nam animi. Autem et dolores sunt sunt nihil voluptas. Quod corrupti aut consequatur velit aut.','application/x-debian-package','Impedit qui labore libero in ex. Ea hic fuga explicabo. Sit animi accusantium error odio autem.'),(8,11,14,'Corporis quas sint distinctio suscipit quae sunt occaecati. Saepe voluptatum fuga autem. Perferendis corrupti dolorem impedit nam.','image/cgm','Placeat fugit quia ipsum repellat id magnam aliquid. Sint expedita aliquid dignissimos quisquam autem a voluptate aut.'),(9,7,7,'Vel nihil ipsam recusandae laborum doloremque beatae. Aut laborum incidunt et dolor tempore amet. Qui et quis ex magni necessitatibus nihil.','application/vnd.kinar','Aliquid qui voluptatum accusamus. Vitae est ab ratione.'),(10,9,1,'At officiis quia reiciendis explicabo vel sapiente. Voluptatem tenetur provident veniam consequatur mollitia et ea molestiae. Qui voluptatem incidunt quisquam consequatur voluptatibus placeat. Amet aliquam provident libero ex eligendi sint ullam.','application/vnd.igloader','Autem cum quos incidunt quaerat nisi totam. Ea reprehenderit voluptas id quasi quas. Et natus ad ut voluptatem quas. Iste ipsum facilis minus tempora ut autem labore.'),(11,7,14,'Qui blanditiis voluptatem voluptatem quaerat. Labore harum recusandae ipsum debitis temporibus ut. Id voluptates necessitatibus voluptates totam voluptas placeat sed.','application/wspolicy+xml','Repudiandae magni asperiores reiciendis ut. Aut pariatur a cumque quaerat ut nisi vero. Voluptates a laboriosam vel odit aliquam aut ut nobis. In aut impedit voluptas voluptas.'),(12,15,14,'Corrupti assumenda soluta autem aut ex. Excepturi blanditiis et molestiae quod. Sunt distinctio earum dignissimos eaque. Voluptatem eveniet dolorem quia sint quaerat in et quia.','application/x-gnumeric','Ut tempore quae maxime atque. Aperiam quia optio qui quae amet sit. Aut est qui veritatis aut maxime facere.'),(13,9,7,'Dignissimos sint rem mollitia doloremque quia. Earum ut deleniti voluptas officiis et autem. Voluptas tempora fugiat consequuntur expedita nihil ex earum.','video/x-matroska','Nesciunt ut enim officia. Aliquid libero optio praesentium temporibus animi. Eum quae vitae adipisci facilis. Quidem quos facilis quae sunt.'),(14,13,14,'Enim officia culpa rem ratione et soluta velit. Quibusdam dolor qui omnis. Illum animi provident est provident dolorem. Et quo expedita delectus aut consequuntur nesciunt.','application/x-research-info-systems','Qui quae nostrum ut voluptatem. Nulla sunt quod eum quibusdam blanditiis aut ipsum. Eum possimus ut sunt rem. Nihil eveniet nihil ad earum eum minima.'),(15,1,13,'Magni pariatur rerum sit ea et. Dolorem et placeat rerum error voluptas accusamus deserunt. Sint eos nesciunt similique ipsam impedit quo explicabo et.','application/xaml+xml','Quibusdam et ipsum debitis voluptas a eos. Alias dolorem aut quia sit.\nMinus architecto voluptates cum sint nam quasi. Saepe et fugiat quas culpa et enim.');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'eos','2005-04-26 20:13:52','1997-11-27 07:45:58'),(2,'ipsum','2011-11-18 06:53:01','2015-10-12 01:38:16'),(3,'mollitia','2001-12-12 13:03:11','1985-04-01 22:57:51'),(4,'ut','1987-02-25 21:06:23','2015-03-06 07:31:57'),(5,'neque','1976-02-26 02:43:08','1999-05-26 13:10:25'),(6,'eligendi','1970-12-25 05:12:08','2005-04-24 23:49:34'),(7,'hic','1987-11-13 21:34:59','2020-03-17 05:47:18'),(8,'voluptatum','2019-07-23 07:29:59','1990-01-19 10:16:10'),(9,'architecto','2002-09-15 00:13:24','1995-02-07 01:10:56'),(10,'esse','1973-10-07 03:29:11','2010-04-12 18:00:02'),(11,'omnis','1973-10-21 01:06:52','1993-09-13 09:12:20'),(12,'vero','1981-12-21 08:57:21','2014-06-18 00:32:17'),(13,'quasi','2008-05-14 07:25:53','2010-12-22 01:42:38'),(14,'corrupti','2014-11-19 05:05:02','1970-12-09 19:13:31'),(15,'dolorum','2005-12-01 07:03:58','1999-03-31 18:28:09');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,12,4,'Velit unde et distinctio rerum consequatur voluptatem sint. Voluptatem reprehenderit quis quisquam ipsum quo. Itaque non veritatis consequuntur consequatur voluptatem.','2015-09-06 01:15:24'),(2,7,13,'Quia consequatur veniam et. Pariatur dolor et dolore laboriosam. Ut qui quia aspernatur.','2002-02-21 13:09:51'),(3,9,11,'Est nam enim labore iste est ipsum doloremque. Repellat ut cupiditate vero rerum consequatur aspernatur repudiandae. Consequatur et blanditiis assumenda et quas quia neque. Cupiditate qui labore dignissimos consequatur blanditiis.','2019-12-06 13:44:28'),(4,6,10,'Placeat odit architecto quisquam non et sint dolor. Rerum autem qui quia eos. Beatae est velit ipsa earum. Dignissimos id ipsam qui vero.','1975-10-16 16:34:03'),(5,1,11,'Et in voluptas ea recusandae perferendis sed. Qui cumque sapiente quas rerum est quia. Ut inventore animi inventore iusto sed nisi quia. Culpa dolore voluptate illum cupiditate repudiandae.','1972-08-31 05:58:27'),(6,12,11,'Delectus et aliquam quaerat dignissimos aut voluptatem. Necessitatibus placeat neque dolore distinctio quam ut distinctio. Et inventore omnis voluptatum in dolor. Occaecati aperiam et blanditiis modi et voluptatum.','2019-06-03 17:29:42'),(7,3,14,'Repellat ea odio molestiae et sapiente nihil eligendi. Ipsum sit consequatur libero inventore porro et harum. Nobis hic veritatis incidunt et. Minima atque aliquam recusandae veritatis quisquam sed ipsam.','1992-06-17 22:56:22'),(8,11,11,'Magni ut voluptas hic quis consequatur ea explicabo. Aspernatur ex labore qui soluta similique occaecati magni. Ut dignissimos similique amet enim iste veritatis consequatur.','1982-05-08 14:36:12'),(9,10,14,'Perferendis quaerat quia pariatur quos laboriosam. Aut aut totam porro. Facere corporis numquam aut eum nisi praesentium. Consectetur enim necessitatibus mollitia in et non dolor.','1975-10-27 20:37:22'),(10,11,7,'Nisi perspiciatis fugiat sint eum consequatur. Occaecati et sint ullam adipisci.','1972-05-20 10:44:40'),(11,14,8,'Nesciunt a unde corporis illum et. Et aut dolore optio quis est. Molestiae dolore perspiciatis quos non.','1985-08-12 15:17:53'),(12,8,11,'Laudantium et repellendus velit. Iusto eum voluptatem optio ut voluptatem accusamus ut. Quis voluptatem officiis et blanditiis magni temporibus. Quae repellendus est voluptatum est assumenda dolore aliquam qui.','1977-02-28 13:47:45'),(13,9,14,'Accusamus dolorem nisi eos est harum aspernatur. Doloremque et quo ad saepe ipsa. Aut et ratione hic quam corrupti distinctio id. Omnis et vel modi quam illo. Tempore ut eum beatae fugiat beatae delectus voluptates.','2011-07-22 00:24:02'),(14,15,3,'Molestiae atque vel impedit quisquam cum quia. Dolore facilis commodi ullam culpa consequatur qui. Et explicabo eos possimus sapiente hic et. Qui voluptatem dolorum ut quisquam.','1979-11-21 14:44:14'),(15,1,8,'Aliquid esse dignissimos ea voluptate. Quos nobis illo ut occaecati est quibusdam. Ipsa numquam sequi quis voluptatem molestiae consectetur enim.','1973-05-06 01:20:23');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `autor_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `autor_id` (`autor_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,7,9,'2014-03-16 15:28:28','1984-10-15 00:10:07'),(2,13,2,'2000-05-13 20:22:51','1975-07-26 14:12:32'),(3,6,3,'1999-05-27 10:51:11','1985-08-25 15:25:43'),(4,9,7,'2003-09-28 22:51:04','1970-04-30 01:33:35'),(5,10,7,'1986-09-06 10:25:46','2019-06-04 01:17:08'),(6,6,1,'2013-07-01 20:56:27','2001-05-30 21:25:21'),(7,2,15,'1989-09-29 07:27:29','1995-05-22 17:27:55'),(8,5,4,'2002-05-08 10:59:27','2015-08-26 11:44:31'),(9,14,4,'2001-04-10 09:44:33','1974-11-19 03:07:21'),(10,5,11,'2017-09-16 19:56:18','2022-03-04 16:22:22'),(11,14,4,'1999-05-01 00:59:46','1981-03-22 21:29:08'),(12,15,1,'1988-12-18 11:22:37','1996-08-07 22:33:39'),(13,10,9,'2003-02-22 06:25:17','1989-06-30 04:39:59'),(14,3,12,'2020-08-21 12:46:32','2004-10-26 22:01:58'),(15,15,14,'2014-02-24 08:28:30','1995-09-10 20:15:34');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hometown` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,NULL,'Lake Ara','2012-04-04 10:45:06'),(2,NULL,'Danielland','1989-10-24 07:01:29'),(3,NULL,'Dickiside','2021-07-18 21:38:48'),(4,NULL,'Goldnerville','1972-04-26 19:05:23'),(5,NULL,'Collinsville','1972-01-21 18:09:00'),(6,NULL,'West Zenafort','1994-03-05 09:55:09'),(7,NULL,'Alvinaton','1989-06-04 10:31:23'),(8,NULL,'South Virgieton','2012-11-30 13:55:41'),(9,NULL,'Godfreyfort','1986-03-13 23:03:19'),(10,NULL,'Sabrinaborough','2009-09-11 19:20:13'),(11,NULL,'Konopelskibury','1983-11-11 03:28:48'),(12,NULL,'Marcellechester','1997-04-24 21:38:31'),(13,NULL,'South Marcellamouth','2003-12-08 15:35:35'),(14,NULL,'Richiechester','2011-10-11 18:26:58'),(15,NULL,'Krajcikhaven','1978-12-15 05:42:42');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reposts`
--

DROP TABLE IF EXISTS `reposts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reposts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `repost_autor_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `post_id` (`post_id`),
  KEY `repost_autor_id` (`repost_autor_id`),
  CONSTRAINT `reposts_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reposts_ibfk_2` FOREIGN KEY (`repost_autor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reposts`
--

LOCK TABLES `reposts` WRITE;
/*!40000 ALTER TABLE `reposts` DISABLE KEYS */;
INSERT INTO `reposts` VALUES (1,15,11,'1991-10-23 05:32:46','1984-05-05 00:12:30'),(2,6,7,'1989-06-03 08:50:07','1983-07-28 21:49:39'),(3,11,4,'1973-07-06 03:26:15','1989-04-03 08:55:32'),(4,1,12,'1984-04-22 04:05:30','2021-02-17 20:08:16'),(5,6,13,'2009-09-18 00:59:40','1988-06-22 00:07:12'),(6,13,10,'2005-05-27 08:32:43','1995-12-16 00:23:52'),(7,2,3,'2014-08-13 06:16:27','2019-10-10 21:52:32'),(8,10,15,'1997-07-04 22:59:24','2003-03-21 14:12:23'),(9,2,5,'1992-04-05 13:46:06','1982-09-17 21:44:38'),(10,3,5,'2020-01-09 06:27:17','2006-02-15 15:28:53'),(11,13,8,'1979-01-25 06:30:15','2018-11-17 00:38:32'),(12,14,12,'1979-05-22 00:51:43','1987-02-02 20:53:14'),(13,7,13,'2006-10-14 18:29:34','2022-03-03 17:19:13'),(14,4,10,'1988-01-21 17:12:41','2003-07-20 16:10:08'),(15,11,2,'1994-12-31 05:15:07','2016-10-06 05:47:15');
/*!40000 ALTER TABLE `reposts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `password_hash` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `idx_users_username` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Stewart','Berge','turcotte.eliza@example.net',89377316038,'1976-10-15','c24283cf02d045120aa23d5f66b8bd04ecd1788e'),(2,'Moshe','Von','ileannon@example.org',89794376141,'1976-04-30','d28bb8d51a6a57736c990bac51c5675eedf6faca'),(3,'Casey','Cummerata','sturcotte@example.org',89644016569,'1971-02-16','27616e9c34ab9629d8ae8a8eea30522893fc5a82'),(4,'Reva','Stanton','lblock@example.org',89210105670,'2018-06-30','af6d9ebf54cbcda3b03a0e064965a099017fc97e'),(5,'Kathryn','Greenholt','magali79@example.com',89529783268,'2004-10-07','87d3765a93d301ccbfb2b032e2a21b63a5c770dc'),(6,'Frederick','Moen','aracely47@example.com',89845185092,'1988-06-02','3eef423eec05b44c9230f4bad353b7dfd2b24bf2'),(7,'Amely','Tromp','macejkovic.darrin@example.com',89851603400,'2000-05-08','4cd82e575eca78b38b00a58391208127667bb328'),(8,'Dixie','Ankunding','abashirian@example.com',89381193826,'1993-12-31','b504e675d5bbc52908d02f89d5820b8d8310374e'),(9,'Alison','Collins','ferne.cronin@example.org',89329889672,'2005-07-16','fa2d079247dc817171d55f623aa102ccd3f2f9de'),(10,'Ansley','Grant','kallie.conroy@example.org',89632935373,'2014-06-17','8cbc82500c94d7db7ef7e4d955d5ac796a0b6c89'),(11,'Retta','Schiller','breanne38@example.com',89653613280,'2008-08-29','720ba2dd215b865af1d306486c7c6bdc4a377f4d'),(12,'Mohammed','Windler','xadams@example.org',89248783030,'2015-04-05','25e50cd740bd110f7b3fae105daf852ac4e359c9'),(13,'Oral','Waters','gregoria.morar@example.com',89122961092,'2017-11-17','573a39d9039c6c03b92e566c860f9fd693bf0144'),(14,'Rene','Hilll','lorine.quitzon@example.net',89403834809,'1993-04-09','98f9bec55e835a68718fc82008acf60bef9b2361'),(15,'Arturo','Dibbert','kosinski@example.org',89946316783,'2002-03-11','334e919d16b95cd4d35350774bfeafd6d806001b');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,5),(1,6),(2,2),(2,9),(4,3),(4,11),(5,10),(6,2),(6,7),(6,11),(7,7),(13,1),(13,13),(15,10),(15,15);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-22 14:54:54
