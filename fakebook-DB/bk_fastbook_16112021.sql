-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: fastbook.c8ubzxgz4vns.ap-southeast-1.rds.amazonaws.com    Database: fastbook
-- ------------------------------------------------------
-- Server version	8.0.23

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `comment_table`
--

DROP TABLE IF EXISTS `comment_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_table` (
  `cmt_id` int NOT NULL AUTO_INCREMENT,
  `cmt_content` varchar(1000) NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmt_id`),
  KEY `post_id_idx` (`post_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `comment_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `comment_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_table`
--

LOCK TABLES `comment_table` WRITE;
/*!40000 ALTER TABLE `comment_table` DISABLE KEYS */;
INSERT INTO `comment_table` VALUES (1,'DM thiennn',103,1,'2021-11-15 08:24:09',0),(2,'dm thienn',103,1,'2021-11-15 08:24:29',0),(3,'This is a comment',103,2,'2021-11-15 10:06:52',1),(4,'This is a comment',103,2,'2021-11-16 02:21:25',1),(5,'This is a comment',103,2,'2021-11-16 02:23:01',1),(6,'This is a comment',103,2,'2021-11-16 02:30:00',1),(7,'This is a comment',103,2,'2021-11-16 02:31:07',1),(8,'This is a comment',103,2,'2021-11-16 02:32:06',1),(9,'This is a comment',103,2,'2021-11-16 02:32:17',1),(10,'This is a comment',103,2,'2021-11-16 02:32:20',1),(11,'This is a comment',103,2,'2021-11-16 02:35:23',1),(12,'This is a comment',103,2,'2021-11-16 02:35:51',1),(14,'This is a comment',103,2,'2021-11-16 03:24:28',1),(15,'This is a comment',103,2,'2021-11-16 03:28:47',1),(16,'This is a comment',103,2,'2021-11-16 03:30:04',1),(17,'H&iacute; Hi \\n &#128523;&#128155;&#128155;',103,2,'2021-11-16 03:33:07',1),(18,'Newest',103,1,'2021-11-16 08:33:17',1),(19,'Hiiii',103,1,'2021-11-16 10:06:48',1),(20,'TEST',103,1,'2021-11-16 10:09:19',1),(21,'test',103,1,'2021-11-16 10:16:39',1),(22,'test',103,1,'2021-11-16 10:17:52',1),(23,'asdasda',103,1,'2021-11-16 10:19:14',1),(24,'asd',103,1,'2021-11-16 10:21:10',1),(25,'asd',103,1,'2021-11-16 10:21:25',1),(26,'asdasdasd',103,1,'2021-11-16 10:23:13',1),(27,'asd',103,1,'2021-11-16 10:23:39',1),(28,'aaa',103,1,'2021-11-16 10:24:43',1),(29,'asd',103,1,'2021-11-16 10:25:47',1),(30,'Ghe qua',106,1,'2021-11-16 10:27:41',0),(31,'Ghe nuon',106,10,'2021-11-16 10:30:53',0),(32,'dm thien',103,9,'2021-11-16 10:48:58',0),(33,'dm thiennnn',103,5,'2021-11-16 10:51:20',0),(34,'&Dstrok;&#7865;p trai qu&aacute; n&#7841;\ny&ecirc;u n&#7841;kkk',106,5,'2021-11-16 10:53:14',0),(35,'&#10084;&#129505;&#128155;&#128154;&#128154;&#128154;&#128154;',107,1,'2021-11-16 10:58:43',0),(36,'dm tuy&#7873;n l&#7855;p',103,13,'2021-11-16 11:07:50',0),(37,'&#128561;&#128561;&#128561;',107,21,'2021-11-16 11:17:26',0),(38,'ahihi',103,10,'2021-11-16 12:00:23',0),(39,'Hi',86,1,'2021-11-16 12:07:48',0);
/*!40000 ALTER TABLE `comment_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `link` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postID_idx` (`post_id`),
  CONSTRAINT `images_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (19,9,'https://i.ibb.co/VBqjxsL/08c9dbac7b61.jpg'),(44,34,'https://i.ibb.co/wgHD6Vv/3def42ed801b.png'),(45,35,'https://i.ibb.co/n12nYGH/2b1559f3d963.jpg'),(46,36,'https://i.ibb.co/PmHCv4D/36fd8d8ffc36.jpg'),(47,37,'https://i.ibb.co/47MmG1R/91b36dd7c0db.png'),(48,38,'https://i.ibb.co/Kmhqzm6/67193c23f6ee.jpg'),(49,39,'https://i.ibb.co/fS9WnBc/6efde332f721.jpg'),(50,40,'https://i.ibb.co/sjZ0jf0/1c8b68b680c3.jpg'),(51,41,'https://i.ibb.co/fHfwxGd/3e384485bb1d.jpg'),(52,42,'https://i.ibb.co/LNx1TGy/3da46d055729.jpg'),(53,43,'https://i.ibb.co/w7C8Mcb/c38c9a64673d.png'),(54,44,'https://i.ibb.co/w7C8Mcb/c38c9a64673d.png'),(55,65,'https://i.ibb.co/4P5VzMV/4e7fc05513d6.jpg'),(56,66,'https://i.ibb.co/4P5VzMV/4e7fc05513d6.jpg'),(57,67,'https://i.ibb.co/qnCp4MG/1e86a51c92bf.jpg'),(58,68,'https://i.ibb.co/sPQcpmr/984fd3fa4b32.jpg'),(59,69,'https://i.ibb.co/yS3ShqS/41f18dd77162.jpg'),(60,70,'https://i.ibb.co/mDx7wyM/28e742c6e562.jpg'),(61,74,'https://i.ibb.co/YPXkz60/802bbd567310.jpg'),(62,75,'https://i.ibb.co/Qr0ZxFF/c0cf8d74c523.jpg'),(63,76,'https://i.ibb.co/k3pbPfq/7358071f15c5.jpg'),(64,77,'https://i.ibb.co/s64WzN3/292eb1fa9513.jpg'),(65,86,'https://i.ibb.co/JtRLgtZ/392d1468456d.jpg'),(66,87,'https://i.ibb.co/SXZVN4B/0b6d133ab907.png'),(67,88,'https://i.ibb.co/qrt5pHb/7658c73039ba.jpg'),(68,90,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(69,91,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(70,92,'https://i.ibb.co/pPP7V8P/38dbe981d549.jpg'),(71,93,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(72,94,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(73,95,'https://i.ibb.co/kHgmGCL/dfbbd8c468bb.jpg'),(74,96,'https://i.ibb.co/kHgmGCL/dfbbd8c468bb.jpg'),(75,97,'https://i.ibb.co/cJWLTQw/cbaeb87ec4db.jpg'),(76,98,'https://i.ibb.co/WvjSRjX/d3ce5e318319.jpg'),(77,99,'https://i.ibb.co/GJ9brF1/2ed8991c1af4.png'),(78,100,'https://i.ibb.co/J3X1Pdt/384a9fbdea8e.png'),(79,101,'https://i.ibb.co/R7HtwSs/5b8f0ea3da46.png'),(80,104,'https://i.ibb.co/Bst2qP5/26b0613d689f.png'),(81,105,'https://i.ibb.co/xsMX2NH/b2b68e3e7631.jpg'),(82,106,'https://i.ibb.co/Mn9gyQR/e938a09874c6.jpg'),(83,107,'https://i.ibb.co/VVPvt01/71d87b62b663.jpg'),(84,108,'https://i.ibb.co/mqVdc1g/db8f285b2413.jpg');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_table`
--

DROP TABLE IF EXISTS `like_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_table` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`like_id`),
  KEY `like_table_idx` (`user_id`),
  KEY `like_posts_idx` (`post_id`),
  CONSTRAINT `like_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `like_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_table`
--

LOCK TABLES `like_table` WRITE;
/*!40000 ALTER TABLE `like_table` DISABLE KEYS */;
INSERT INTO `like_table` VALUES (1,1,88,'2021-10-20 21:12:21'),(2,2,88,'2021-10-20 21:13:14'),(3,10,88,'2021-11-11 15:01:20'),(4,10,86,'2021-11-11 15:02:57');
/*!40000 ALTER TABLE `like_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `noti_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `noti_content` varchar(200) NOT NULL,
  `noti_read` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`noti_id`),
  KEY `noti_table_idx` (`user_id`),
  CONSTRAINT `noti_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'Upload image',
  `likes` int NOT NULL DEFAULT '0',
  `comments` int NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `posts_users_idx` (`user_id`),
  CONSTRAINT `posts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,10,'Hiiii\n&#127880;&#127880;&#128536;&#128536;&#128536;&#129392;',0,0,'2021-10-24 10:58:20',0),(9,1,'',0,0,'2021-10-24 15:27:19',0),(34,1,'',0,0,'2021-10-24 17:41:03',0),(35,10,'Hoa &dstrok;&atilde; th&ecirc;m 1 &#7843;nh m&#7899;i',0,0,'2021-10-24 19:07:03',0),(36,1,'ahihi',0,0,'2021-10-24 19:56:02',0),(37,9,'&#10084;&#10084;&#10084;&#129505;&#129505;&#129505;&#128155;&#128155;\nLove ziuuu',0,0,'2021-10-24 21:10:36',0),(38,9,'Moahhhh &#128150;&#128150;',0,0,'2021-10-24 21:11:25',0),(39,5,'Trong ch&#432;&#417;ng tr&igrave;nh Today show h&ocirc;m 5.12, Lady Gaga ti&#7871;t l&#7897; c&acirc;u chuy&#7879;n bu&#7891;n v&#7873; cu&#7897;c &dstrok;&#7901;i m&igrave;nh khi t&#7915;ng b&#7883; x&acirc;m h&#7841;i t&igrave;nh d&#7909;c n&abreve;m 19 tu&#7893;i v&agrave; m&#7855;c PTSD. N&#7919; ca s&itilde; sau &dstrok;&oacute; quy&#7871;t &dstrok;&#7883;nh vi&#7871;t m&#7897;t b&#7913;c th&#432; th&#7859;ng th&#7855;n, mi&ecirc;u t&#7843; v&#7873; cu&#7897;c s&#7889;ng c&#7911;a m&igrave;nh khi s&#7889;ng chung v&#7899;i ch&#7913;ng r&#7889;i lo&#7841;n t&acirc;m l&yacute; v&agrave; &dstrok;&abreve;ng tr&ecirc;n trang Born This Way Foundation. ',0,0,'2021-10-25 10:58:26',0),(40,5,'Lady Gaga &dstrok;&atilde; th&ecirc;m 1 &#7843;nh m&#7899;i',0,0,'2021-10-25 11:00:16',0),(41,10,'n&abreve;m &#9996;',0,0,'2021-10-25 20:28:37',0),(42,9,'<b>You&rsquor;ve gotta dance like there&rsquor;s nobody watching, love like you&rsquor;ll never be hurt, sing like there&rsquor;s nobody listening, and live like it&rsquor;s heaven on earth.</b>\r &#128523;&#129392;',0,0,'2021-10-26 17:05:21',0),(43,9,'Hello hii',0,0,'2021-10-26 22:11:09',1),(44,9,'Hello hii',0,0,'2021-10-26 22:11:12',1),(45,1,'Hello, this is a new post',0,0,'2021-11-06 19:16:19',1),(46,1,'Hello, this is a new post',0,0,'2021-11-06 19:19:12',1),(47,1,'Hello, this is a new post',0,0,'2021-11-06 19:20:26',1),(48,1,'Hello, this is a new post',0,0,'2021-11-06 19:20:54',1),(49,2,'new post',0,0,'2021-11-06 19:28:59',1),(50,2,'Hello, this is a new post',0,0,'2021-11-06 19:30:21',1),(51,2,'Hello, this is a new post',0,0,'2021-11-06 19:33:50',1),(52,2,'Hello, this is a new post',0,0,'2021-11-06 19:37:35',1),(53,2,'Hello, this is a new post',0,0,'2021-11-06 19:40:05',1),(54,9,'Meww\n&#129505;',0,0,'2021-11-06 19:43:40',1),(55,9,'Meww\n&#129505;',0,0,'2021-11-06 19:44:09',1),(56,9,'Meww\n&#129505;',0,0,'2021-11-06 19:46:17',1),(57,9,'Meww\n&#129505;',0,0,'2021-11-06 19:46:17',1),(58,9,'Meww\n&#129505;',0,0,'2021-11-06 19:47:02',1),(59,2,'Hello, this is a new post',0,0,'2021-11-06 19:53:37',1),(60,2,'Hello, this is a new post',0,0,'2021-11-06 19:55:21',1),(61,9,'Meww\n&#129505;',0,0,'2021-11-06 19:55:21',1),(62,2,'Hello, this is a new post',0,0,'2021-11-06 19:56:25',1),(63,2,'New post with image',0,0,'2021-11-07 08:08:59',1),(64,2,'New post with image',0,0,'2021-11-07 08:09:52',1),(65,2,'New post with image',0,0,'2021-11-07 08:10:49',1),(66,2,'New post with image',0,0,'2021-11-07 08:11:25',1),(67,1,'Chi&#7873;u t&#7889;i nay c&oacute; kh&ocirc;ng kh&iacute; l&#7841;nh !!',0,0,'2021-11-07 14:43:54',0),(68,10,'Nay l&#7841;nh 18 &dstrok;&#7897; ',0,0,'2021-11-09 09:40:08',0),(69,10,'&Dstrok;&atilde; c&#7853;p nh&#7853;t &#7843;nh b&igrave;a.',0,0,'2021-11-09 13:07:24',0),(70,6,'I am spider man &#128375;&#128375;',0,0,'2021-11-09 16:10:25',0),(73,6,'Hello, I am spiderman',0,0,'2021-11-09 16:25:28',1),(74,1,'Th&ecirc;m &#7843;nh b&igrave;a m&#7863;c &dstrok;&#7883;nh.',0,0,'2021-11-09 16:50:08',1),(75,9,'&Dstrok;&atilde; c&#7853;p nh&#7853;t &#7843;nh b&igrave;a c&#7911;a c&ocirc; &#7845;y.',0,0,'2021-11-10 19:38:24',0),(76,1,'C&#7853;p nh&#7853;t &#7843;nh b&igrave;a.',0,0,'2021-11-10 22:39:08',0),(77,10,'Nay l&#7841;nh v&#7915;a ph&#7843;i. V&#7873; c&#417; b&#7843;n l&agrave; v&#7851;n &#7845;m.',0,0,'2021-11-11 11:47:31',0),(78,10,'SELECT * FROM users',0,0,'2021-11-11 12:55:36',1),(79,10,'TEST',0,0,'2021-11-11 13:00:27',1),(80,10,'TEST',0,0,'2021-11-11 13:02:03',1),(81,10,'Hello',0,0,'2021-11-11 13:34:53',1),(82,10,'test',0,0,'2021-11-11 13:35:48',1),(83,10,'etst',0,0,'2021-11-11 13:37:00',1),(84,10,'testtest',0,0,'2021-11-11 13:37:32',1),(85,10,'test',0,0,'2021-11-11 13:37:42',1),(86,10,'H&iacute; Hi\n&#128523;&#128155;&#128155;',1,1,'2021-11-11 13:42:21',0),(87,10,'',0,0,'2021-11-11 13:44:05',1),(88,10,'Helloo',3,0,'2021-11-11 14:41:36',1),(89,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:46:00',1),(90,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:46:55',1),(91,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:51:00',1),(92,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:52:06',1),(93,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:53:22',1),(94,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 15:58:47',0),(95,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 16:12:14',1),(96,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 16:14:14',0),(97,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-13 08:43:08',1),(98,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-13 08:47:35',0),(99,13,'',0,0,'2021-11-13 09:33:19',1),(100,13,'',0,0,'2021-11-13 09:33:19',0),(101,13,'',0,0,'2021-11-13 09:33:19',1),(102,14,'h&uacute;\n',0,0,'2021-11-13 09:35:40',0),(103,14,'DM thi&#7879;n',0,32,'2021-11-13 09:37:01',0),(104,1,'',0,0,'2021-11-13 12:59:36',0),(105,18,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-15 05:38:21',1),(106,21,'Đã cập nhật ảnh đại diện.',0,3,'2021-11-15 14:43:24',0),(107,5,'Đã cập nhật ảnh đại diện.',0,2,'2021-11-16 10:54:37',0),(108,13,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-16 11:08:42',1);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'Người dùng Fakebook',
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `avatar` varchar(200) NOT NULL DEFAULT 'https://i.ibb.co/H4WHmsn/default-avatar.png',
  `cover_photo` varchar(200) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone_number` varchar(18) DEFAULT NULL,
  `blue_tick` tinyint DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `_id_UNIQUE` (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Phạm Công Hải','phamhai','abcabc','phamhai@gmail.com','https://i.ibb.co/WvjSRjX/d3ce5e318319.jpg','https://i.ibb.co/k3pbPfq/7358071f15c5.jpg','1999-05-08','Thai Binh',NULL,1),(2,'Maria Hill','maria','abcabc','','https://pbs.twimg.com/profile_images/1045680769040101376/vokEFgSS_400x400.jpg',NULL,NULL,NULL,NULL,0),(5,'Lady Gaga','ladygaga','abcabc','','https://i.ibb.co/VVPvt01/71d87b62b663.jpg',NULL,NULL,NULL,NULL,0),(6,'Spider Man','spiderman','abcabc','','https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg',NULL,NULL,NULL,NULL,0),(7,'Jonh Cena','jonhcena','abcabc','null','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(8,'Barack Omachi','barackomachi','abcabc','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(9,'Irene','irene','abcabc','irene@gmail.com','https://image.thanhnien.vn/1024/uploaded/trucdl/2020_07_31/irenexinhdepchupquangcao4_qnei.png','https://i.ibb.co/Qr0ZxFF/c0cf8d74c523.jpg','1991-03-29','Buk-gu, Daegu, Korea',NULL,1),(10,'Quỳnh Hoa','quynhhoa','abcabc','hoa9924@gmail.com','https://i.ibb.co/n12nYGH/2b1559f3d963.jpg','https://i.ibb.co/yS3ShqS/41f18dd77162.jpg','2000-02-04','Nam Dinh',NULL,1),(11,'username','username','password','email@email.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(12,'asdasd','asdasd','abcabc','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(13,'Phạm Quang Thiện','Phamquangthien99','thjentb99','phamquangthien99@gmail.com','https://i.ibb.co/mqVdc1g/db8f285b2413.jpg',NULL,NULL,NULL,NULL,1),(14,'Lawps','tuyenthanhbui','tuyenthanhbui','tuyenthanhbui1999@gmail.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,1),(15,'Giang Hồ','Đồng Bún','Chidung761999','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(16,'Giang Hồ Đồng Bún','Giang Hồ Đồng Bún','Chidung761999','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,1),(17,'Sơn','nguyenthanhson','Sonnick31012002@','nguyenthanhsonnbk31012002@gmail.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(18,'Vũ Thanh Tú','tu267','tudz9xtb','vuthanhtu26072002@gmail.com','https://i.ibb.co/xsMX2NH/b2b68e3e7631.jpg',NULL,NULL,NULL,NULL,0),(19,'Lộc Nguyễn','S2boycms2','tymjuchuot1','locnx2001@gmail.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(20,'Lộc','Nguyễn','tymjuchuot1','locnx2001@gmail.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(21,'Hết nước chấm','dat09','dat123456','dat1722002@gmail.com','https://i.ibb.co/Mn9gyQR/e938a09874c6.jpg',NULL,NULL,NULL,NULL,1),(22,'Nguyễn Thanh Sơn','nguyenthanhson311','Sonnick31012002@','nguyenthanhsonnbk31012002@gmail.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-16 21:17:46
