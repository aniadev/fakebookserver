-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: fastbook
-- ------------------------------------------------------
-- Server version	8.0.27

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
  CONSTRAINT `post_id` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (19,9,'https://i.ibb.co/VBqjxsL/08c9dbac7b61.jpg'),(44,34,'https://i.ibb.co/wgHD6Vv/3def42ed801b.png'),(45,35,'https://i.ibb.co/n12nYGH/2b1559f3d963.jpg'),(46,36,'https://i.ibb.co/PmHCv4D/36fd8d8ffc36.jpg'),(47,37,'https://i.ibb.co/47MmG1R/91b36dd7c0db.png'),(48,38,'https://i.ibb.co/Kmhqzm6/67193c23f6ee.jpg'),(49,39,'https://i.ibb.co/fS9WnBc/6efde332f721.jpg'),(50,40,'https://i.ibb.co/sjZ0jf0/1c8b68b680c3.jpg'),(51,41,'https://i.ibb.co/fHfwxGd/3e384485bb1d.jpg'),(52,42,'https://i.ibb.co/LNx1TGy/3da46d055729.jpg'),(53,43,'https://i.ibb.co/w7C8Mcb/c38c9a64673d.png'),(54,44,'https://i.ibb.co/w7C8Mcb/c38c9a64673d.png'),(55,65,'https://i.ibb.co/4P5VzMV/4e7fc05513d6.jpg'),(56,66,'https://i.ibb.co/4P5VzMV/4e7fc05513d6.jpg'),(57,67,'https://i.ibb.co/qnCp4MG/1e86a51c92bf.jpg'),(58,68,'https://i.ibb.co/sPQcpmr/984fd3fa4b32.jpg'),(59,69,'https://i.ibb.co/yS3ShqS/41f18dd77162.jpg'),(60,70,'https://i.ibb.co/mDx7wyM/28e742c6e562.jpg'),(61,74,'https://i.ibb.co/YPXkz60/802bbd567310.jpg'),(62,75,'https://i.ibb.co/Qr0ZxFF/c0cf8d74c523.jpg'),(63,76,'https://i.ibb.co/k3pbPfq/7358071f15c5.jpg'),(64,77,'https://i.ibb.co/s64WzN3/292eb1fa9513.jpg'),(65,86,'https://i.ibb.co/JtRLgtZ/392d1468456d.jpg'),(66,87,'https://i.ibb.co/SXZVN4B/0b6d133ab907.png'),(67,88,'https://i.ibb.co/qrt5pHb/7658c73039ba.jpg'),(68,90,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(69,91,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(70,92,'https://i.ibb.co/pPP7V8P/38dbe981d549.jpg'),(71,93,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(72,94,'https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg'),(73,95,'https://i.ibb.co/kHgmGCL/dfbbd8c468bb.jpg'),(74,96,'https://i.ibb.co/kHgmGCL/dfbbd8c468bb.jpg');
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
  KEY `user_id_idx` (`user_id`),
  KEY `post_id_idx` (`post_id`)
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
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,10,'Hiiii\n&#127880;&#127880;&#128536;&#128536;&#128536;&#129392;',12412,224,'2021-10-24 10:58:20',0),(9,1,'',0,11,'2021-10-24 15:27:19',0),(34,1,'',112,3,'2021-10-24 17:41:03',0),(35,10,'Hoa &dstrok;&atilde; th&ecirc;m 1 &#7843;nh m&#7899;i',223,22,'2021-10-24 19:07:03',0),(36,1,'ahihi',123,1,'2021-10-24 19:56:02',0),(37,9,'&#10084;&#10084;&#10084;&#129505;&#129505;&#129505;&#128155;&#128155;\nLove ziuuu',1244,121,'2021-10-24 21:10:36',0),(38,9,'Moahhhh &#128150;&#128150;',1238,421,'2021-10-24 21:11:25',0),(39,5,'Trong ch&#432;&#417;ng tr&igrave;nh Today show h&ocirc;m 5.12, Lady Gaga ti&#7871;t l&#7897; c&acirc;u chuy&#7879;n bu&#7891;n v&#7873; cu&#7897;c &dstrok;&#7901;i m&igrave;nh khi t&#7915;ng b&#7883; x&acirc;m h&#7841;i t&igrave;nh d&#7909;c n&abreve;m 19 tu&#7893;i v&agrave; m&#7855;c PTSD. N&#7919; ca s&itilde; sau &dstrok;&oacute; quy&#7871;t &dstrok;&#7883;nh vi&#7871;t m&#7897;t b&#7913;c th&#432; th&#7859;ng th&#7855;n, mi&ecirc;u t&#7843; v&#7873; cu&#7897;c s&#7889;ng c&#7911;a m&igrave;nh khi s&#7889;ng chung v&#7899;i ch&#7913;ng r&#7889;i lo&#7841;n t&acirc;m l&yacute; v&agrave; &dstrok;&abreve;ng tr&ecirc;n trang Born This Way Foundation. ',235,33,'2021-10-25 10:58:26',0),(40,5,'Lady Gaga &dstrok;&atilde; th&ecirc;m 1 &#7843;nh m&#7899;i',465,346,'2021-10-25 11:00:16',0),(41,10,'n&abreve;m &#9996;',3441,412,'2021-10-25 20:28:37',0),(42,9,'<b>You&rsquor;ve gotta dance like there&rsquor;s nobody watching, love like you&rsquor;ll never be hurt, sing like there&rsquor;s nobody listening, and live like it&rsquor;s heaven on earth.</b>\r &#128523;&#129392;',1211,321,'2021-10-26 17:05:21',0),(43,9,'Hello hii',0,0,'2021-10-26 22:11:09',1),(44,9,'Hello hii',0,0,'2021-10-26 22:11:12',1),(45,1,'Hello, this is a new post',0,0,'2021-11-06 19:16:19',1),(46,1,'Hello, this is a new post',0,0,'2021-11-06 19:19:12',1),(47,1,'Hello, this is a new post',0,0,'2021-11-06 19:20:26',1),(48,1,'Hello, this is a new post',0,0,'2021-11-06 19:20:54',1),(49,2,'new post',0,0,'2021-11-06 19:28:59',1),(50,2,'Hello, this is a new post',0,0,'2021-11-06 19:30:21',1),(51,2,'Hello, this is a new post',0,0,'2021-11-06 19:33:50',1),(52,2,'Hello, this is a new post',0,0,'2021-11-06 19:37:35',1),(53,2,'Hello, this is a new post',0,0,'2021-11-06 19:40:05',1),(54,9,'Meww\n&#129505;',0,0,'2021-11-06 19:43:40',1),(55,9,'Meww\n&#129505;',0,0,'2021-11-06 19:44:09',1),(56,9,'Meww\n&#129505;',0,0,'2021-11-06 19:46:17',1),(57,9,'Meww\n&#129505;',0,0,'2021-11-06 19:46:17',1),(58,9,'Meww\n&#129505;',0,0,'2021-11-06 19:47:02',1),(59,2,'Hello, this is a new post',0,0,'2021-11-06 19:53:37',1),(60,2,'Hello, this is a new post',0,0,'2021-11-06 19:55:21',1),(61,9,'Meww\n&#129505;',0,0,'2021-11-06 19:55:21',1),(62,2,'Hello, this is a new post',0,0,'2021-11-06 19:56:25',1),(63,2,'New post with image',0,0,'2021-11-07 08:08:59',1),(64,2,'New post with image',0,0,'2021-11-07 08:09:52',1),(65,2,'New post with image',0,0,'2021-11-07 08:10:49',1),(66,2,'New post with image',0,0,'2021-11-07 08:11:25',1),(67,1,'Chi&#7873;u t&#7889;i nay c&oacute; kh&ocirc;ng kh&iacute; l&#7841;nh !!',0,0,'2021-11-07 14:43:54',0),(68,10,'Nay l&#7841;nh 18 &dstrok;&#7897; ',0,0,'2021-11-09 09:40:08',0),(69,10,'&Dstrok;&atilde; c&#7853;p nh&#7853;t &#7843;nh b&igrave;a.',0,0,'2021-11-09 13:07:24',0),(70,6,'I am spider man &#128375;&#128375;',0,0,'2021-11-09 16:10:25',0),(73,6,'Hello, I am spiderman',0,0,'2021-11-09 16:25:28',1),(74,1,'Th&ecirc;m &#7843;nh b&igrave;a m&#7863;c &dstrok;&#7883;nh.',0,0,'2021-11-09 16:50:08',1),(75,9,'&Dstrok;&atilde; c&#7853;p nh&#7853;t &#7843;nh b&igrave;a c&#7911;a c&ocirc; &#7845;y.',0,0,'2021-11-10 19:38:24',0),(76,1,'C&#7853;p nh&#7853;t &#7843;nh b&igrave;a.',0,0,'2021-11-10 22:39:08',0),(77,10,'Nay l&#7841;nh v&#7915;a ph&#7843;i. V&#7873; c&#417; b&#7843;n l&agrave; v&#7851;n &#7845;m.',0,0,'2021-11-11 11:47:31',0),(78,10,'SELECT * FROM users',0,0,'2021-11-11 12:55:36',1),(79,10,'TEST',0,0,'2021-11-11 13:00:27',1),(80,10,'TEST',0,0,'2021-11-11 13:02:03',1),(81,10,'Hello',0,0,'2021-11-11 13:34:53',1),(82,10,'test',0,0,'2021-11-11 13:35:48',1),(83,10,'etst',0,0,'2021-11-11 13:37:00',1),(84,10,'testtest',0,0,'2021-11-11 13:37:32',1),(85,10,'test',0,0,'2021-11-11 13:37:42',1),(86,10,'H&iacute; Hi\n&#128523;&#128155;&#128155;',457941,994,'2021-11-11 13:42:21',0),(87,10,'',0,0,'2021-11-11 13:44:05',1),(88,10,'Helloo',3,0,'2021-11-11 14:41:36',0),(89,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:46:00',1),(90,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:46:55',1),(91,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:51:00',1),(92,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:52:06',1),(93,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 14:53:22',1),(94,6,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 15:58:47',0),(95,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 16:12:14',1),(96,1,'Đã cập nhật ảnh đại diện.',0,0,'2021-11-12 16:14:14',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Phạm Công Hải','phamhai','abcabc','phamhai@gmail.com','https://i.ibb.co/kHgmGCL/dfbbd8c468bb.jpg','https://i.ibb.co/k3pbPfq/7358071f15c5.jpg','1999-05-08','Thai Binh',NULL,1),(2,'Maria Hill','maria','abcabc','','https://pbs.twimg.com/profile_images/1045680769040101376/vokEFgSS_400x400.jpg',NULL,NULL,NULL,NULL,0),(5,'Lady Gaga','ladygaga','abcabc','','https://i.ibb.co/sjZ0jf0/1c8b68b680c3.jpg',NULL,NULL,NULL,NULL,0),(6,'Spider Man','spiderman','abcabc','','https://i.ibb.co/vBkPMSv/75ee21e1c2aa.jpg',NULL,NULL,NULL,NULL,0),(7,'Jonh Cena','jonhcena','abcabc','null','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(8,'Barack Omachi','barackomachi','abcabc','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(9,'Irene','irene','abcabc','irene@gmail.com','https://image.thanhnien.vn/1024/uploaded/trucdl/2020_07_31/irenexinhdepchupquangcao4_qnei.png','https://i.ibb.co/Qr0ZxFF/c0cf8d74c523.jpg','1991-03-29','Buk-gu, Daegu, Korea',NULL,1),(10,'Quỳnh Hoa','quynhhoa','abcabc','hoa9924@gmail.com','https://i.ibb.co/n12nYGH/2b1559f3d963.jpg','https://i.ibb.co/yS3ShqS/41f18dd77162.jpg','2000-02-04','Nam Dinh',NULL,1),(11,'username','username','password','email@email.com','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0),(12,'asdasd','asdasd','abcabc','','https://i.ibb.co/H4WHmsn/default-avatar.png',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-12 22:36:21
