/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 10.1.10-MariaDB : Database - silly_english
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`silly_english` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `silly_english`;

/*Table structure for table `answer_key` */

DROP TABLE IF EXISTS `answer_key`;

CREATE TABLE `answer_key` (
  `answer_key_id` int(11) NOT NULL,
  `details` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`answer_key_id`),
  KEY `answer_key_id` (`answer_key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

/*Data for the table `answer_key` */

insert  into `answer_key`(`answer_key_id`,`details`) values ('1','A'),('2','B'),('3','C'),('4','D'),('5','NONE'),('6','OVER');

/*Table structure for table `attach_gifts` */

DROP TABLE IF EXISTS `attach_gifts`;

CREATE TABLE `attach_gifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) DEFAULT NULL,
  `gift_type` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `detail` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gift_type` (`gift_type`),
  CONSTRAINT `attach_gifts_ibfk_1` FOREIGN KEY (`gift_type`) REFERENCES `gift_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `attach_gifts` */

/*Table structure for table `battle_question` */

DROP TABLE IF EXISTS `battle_question`;

CREATE TABLE `battle_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `battle_id` int(11) NOT NULL,
  `attacker_answer` int(11) NOT NULL DEFAULT '5',
  `defender_answer` int(11) NOT NULL DEFAULT '5',
  `attacker_answer_time` datetime DEFAULT NULL,
  `defender_answer_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  KEY `battle_id` (`battle_id`),
  KEY `battle_question_ibfk_3` (`attacker_answer`),
  KEY `battle_question_ibfk_4` (`defender_answer`),
  CONSTRAINT `battle_question_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `battle_question_ibfk_2` FOREIGN KEY (`battle_id`) REFERENCES `battles` (`battle_id`),
  CONSTRAINT `battle_question_ibfk_3` FOREIGN KEY (`attacker_answer`) REFERENCES `answer_key` (`answer_key_id`),
  CONSTRAINT `battle_question_ibfk_4` FOREIGN KEY (`defender_answer`) REFERENCES `answer_key` (`answer_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=574 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battle_question` */

/*Table structure for table `battle_status` */

DROP TABLE IF EXISTS `battle_status`;

CREATE TABLE `battle_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The status''s id',
  `detail` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'The status detail',
  PRIMARY KEY (`status_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battle_status` */

insert  into `battle_status`(`status_id`,`detail`) values ('1','waiting'),('2','completed');

/*Table structure for table `battles` */

DROP TABLE IF EXISTS `battles`;

CREATE TABLE `battles` (
  `battle_id` int(11) NOT NULL AUTO_INCREMENT,
  `attacker_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `defender_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `battle_status` int(11) DEFAULT '1',
  `date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `attacker_begin_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `defender_begin_time` datetime DEFAULT NULL,
  `attacker_end_time` datetime DEFAULT NULL,
  `defender_end_time` datetime DEFAULT NULL,
  `victory_id` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bet_value` int(10) DEFAULT NULL,
  PRIMARY KEY (`battle_id`),
  KEY `attacker_id` (`attacker_id`),
  KEY `defender_id` (`defender_id`),
  KEY `battle_status` (`battle_status`),
  CONSTRAINT `battles_ibfk_1` FOREIGN KEY (`battle_status`) REFERENCES `battle_status` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battles` */

/*Table structure for table `comment_notify` */

DROP TABLE IF EXISTS `comment_notify`;

CREATE TABLE `comment_notify` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_id` int(11) DEFAULT NULL,
  `comment_content` text COLLATE utf8_unicode_ci,
  `comment_time` datetime DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `comment_notify` */

/*Table structure for table `error_code` */

DROP TABLE IF EXISTS `error_code`;

CREATE TABLE `error_code` (
  `code` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `error_code` */

insert  into `error_code`(`code`,`details`) values ('200','completed'),('201','not completed'),('202','battle closed'),('203','battle not found'),('205','lesson was bought'),('206','not enough money'),('207','lesson wasn\'t bought'),('208','inbox item not found'),('209','insert and update progress success'),('210','update progress success'),('211','this lesson unit must higher than current lesson unit in progress'),('212','This lesson unit is the last in this lesson.'),('213','Update lesson progress and bonus coin for user success!'),('214','post new notification success'),('215','Like notify success'),('216','Unlike notify success'),('300','claimed rewards'),('301','user not found'),('302','already friend'),('303','friend not found');

/*Table structure for table `friends` */

DROP TABLE IF EXISTS `friends`;

CREATE TABLE `friends` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the identifier',
  `person_1` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `person_2` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`person_1`,`person_2`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `friends` */

insert  into `friends`(`id`,`person_1`,`person_2`,`date_create`) values ('4','QILvqUWVZjgimSlRkKJjyAwbrok2','jJjig2TxgUQCX6kByk6u8iskXZV2','2017-05-26 13:34:20');

/*Table structure for table `gift_type` */

DROP TABLE IF EXISTS `gift_type`;

CREATE TABLE `gift_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `detail` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `gift_type` */

insert  into `gift_type`(`id`,`type`,`detail`) values ('1','gif_coin','the coin'),('2','gif_lesson','the lesson that unlocked'),('3','battle_challenge_id','the battle identifier'),('4','battle_rank_down_up','the battle rank down up item'),('5','battle_bet_value','the battle bet coins item'),('6','gif_book','the book that unlocked'),('7','battle_win_lost_flag','the lost battle'),('8','add_friend_request','the add friend request');

/*Table structure for table `lesson` */

DROP TABLE IF EXISTS `lesson`;

CREATE TABLE `lesson` (
  `ls_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Listening Unit ID',
  `ls_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Listening Unit Title',
  `ls_price` int(11) DEFAULT NULL COMMENT 'Price of Unit',
  `ls_exp` int(11) DEFAULT NULL COMMENT 'Maximum Exp of Unit',
  `ls_max_hear_times` int(11) DEFAULT NULL COMMENT 'Max hear times',
  `ls_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Link of Listening file',
  `ls_download` int(11) DEFAULT NULL,
  `ls_reading_content` text COLLATE utf8_unicode_ci,
  `ls_avatar_url` text COLLATE utf8_unicode_ci,
  `ls_rate` float DEFAULT NULL,
  `ls_file_url` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ls_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson` */

insert  into `lesson`(`ls_id`,`ls_title`,`ls_price`,`ls_exp`,`ls_max_hear_times`,`ls_url`,`ls_download`,`ls_reading_content`,`ls_avatar_url`,`ls_rate`,`ls_file_url`) values ('4','OBL St1 A Ghost in Love and Other Plays','140',NULL,'2','Resources/OBL St1 A Ghost in Love and Other Plays','0',NULL,'http://images.gr-assets.com/books/1348282197l/12600363.jpg','4.5','Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/A%20Ghost%20in%20Love.pdf'),('5','OBL St1 Goodbye, Mr. Hollywood','140',NULL,'2','Resources/OBL St1 Goodbye, Mr. Hollywood','0',NULL,'http://images.gr-assets.com/books/1356447934l/150869.jpg','3.7','Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/Goodbye,_Mr_Hollywood.PDF'),('6','OBL St1 Love or Money','140',NULL,'2','Resources\\OBL St1 Love or Money','0',NULL,'http://isach.info/images/story/cover/love_or_money__khong_xac_dinh.jpg','0','Resources/OBL%20St1%20Love%20or%20Money/Love%20or%20Money.PDF');

/*Table structure for table `lesson_source` */

DROP TABLE IF EXISTS `lesson_source`;

CREATE TABLE `lesson_source` (
  `source_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_image_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_source` */

insert  into `lesson_source`(`source_id`,`source_name`,`source_image_url`) values ('1','Oxford BookWorm','oxford bookworm'),('2','Podcast In English','Podcast In English'),('3','BBC English','BBC ENGLISH');

/*Table structure for table `lesson_storage` */

DROP TABLE IF EXISTS `lesson_storage`;

CREATE TABLE `lesson_storage` (
  `st_id` int(11) NOT NULL AUTO_INCREMENT,
  `ls_id` int(11) DEFAULT NULL,
  `user_id` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bonus_coin` int(11) DEFAULT NULL,
  PRIMARY KEY (`st_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_storage` */

insert  into `lesson_storage`(`st_id`,`ls_id`,`user_id`,`bonus_coin`) values ('13','1','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80',NULL),('14','2','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80',NULL),('15','4','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80',NULL),('16','5','QILvqUWVZjgimSlRkKJjyAwbrok2',NULL),('17','4','QILvqUWVZjgimSlRkKJjyAwbrok2',NULL),('18','6','QILvqUWVZjgimSlRkKJjyAwbrok2',NULL),('19','6','GAMJNCtdsAVT2O7CRCFxN38QLnX2',NULL),('20','4','GAMJNCtdsAVT2O7CRCFxN38QLnX2',NULL),('21','5','GAMJNCtdsAVT2O7CRCFxN38QLnX2',NULL),('22','4','jJjig2TxgUQCX6kByk6u8iskXZV2',NULL);

/*Table structure for table `lesson_tracker` */

DROP TABLE IF EXISTS `lesson_tracker`;

CREATE TABLE `lesson_tracker` (
  `lst_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ls_id` int(11) DEFAULT NULL,
  `ls_progress` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lst_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_tracker` */

insert  into `lesson_tracker`(`lst_id`,`user_id`,`ls_id`,`ls_progress`) values ('12','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','5','1'),('13','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','6','1'),('15','b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','4','1'),('18','GAMJNCtdsAVT2O7CRCFxN38QLnX2','4','1'),('19','jJjig2TxgUQCX6kByk6u8iskXZV2','4','1'),('20','QILvqUWVZjgimSlRkKJjyAwbrok2','5','1'),('21','QILvqUWVZjgimSlRkKJjyAwbrok2','4','209'),('22','Y4iIFhYqnPVgvb38Xxjv0Fckv6w1','5','0'),('23','QILvqUWVZjgimSlRkKJjyAwbrok2',NULL,'0');

/*Table structure for table `lesson_unit` */

DROP TABLE IF EXISTS `lesson_unit`;

CREATE TABLE `lesson_unit` (
  `lu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Lesson Unit Id',
  `lu_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Lesson Unit Name',
  `lu_sequence` int(11) DEFAULT NULL,
  `ls_id` int(11) DEFAULT NULL COMMENT 'Reference to Lesson',
  `lu_max_hear` int(11) DEFAULT NULL COMMENT 'Lesson Unit Max Hear Time',
  `lu_url` text COLLATE utf8_unicode_ci COMMENT 'Lesson Unit Url',
  `lu_note` text COLLATE utf8_unicode_ci COMMENT 'Lesson Unit Note',
  `lu_type` int(11) DEFAULT NULL COMMENT 'Type of Unit',
  `lu_duration` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`lu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_unit` */

insert  into `lesson_unit`(`lu_id`,`lu_name`,`lu_sequence`,`ls_id`,`lu_max_hear`,`lu_url`,`lu_note`,`lu_type`,`lu_duration`) values ('31','1.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/01.mp3',NULL,NULL,'05:40'),('32','2.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/02.mp3',NULL,NULL,'06:31'),('33','3.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/03.mp3',NULL,NULL,'00:57'),('34','4.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/04.mp3',NULL,NULL,'02:45'),('35','5.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/05.mp3',NULL,NULL,'02:36'),('36','6.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/06.mp3',NULL,NULL,'04:11'),('37','7.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/07.mp3',NULL,NULL,'01:07'),('38','8.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/08.mp3',NULL,NULL,'02:24'),('39','9.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/09.mp3',NULL,NULL,'06:26'),('40','10.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/10.mp3',NULL,NULL,'01:11'),('41','11.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/11.mp3',NULL,NULL,'02:19'),('42','12.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/12.mp3',NULL,NULL,'03:24'),('43','13.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/13.mp3',NULL,NULL,'01:12'),('44','14.mp3',NULL,'4',NULL,'Resources/OBL%20St1%20A%20Ghost%20in%20Love%20and%20Other%20Plays/14.mp3',NULL,NULL,'01:54'),('45','1.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/1.mp3',NULL,NULL,'11:25'),('46','2.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/2.mp3',NULL,NULL,'08:23'),('47','3.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/3.mp3',NULL,NULL,'06:50'),('48','4.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/4.mp3',NULL,NULL,'05:17'),('49','5.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/5.mp3',NULL,NULL,'07:22'),('50','6.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/6.mp3',NULL,NULL,'07:36'),('51','7.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/7.mp3',NULL,NULL,'08:13'),('52','8.mp3',NULL,'5',NULL,'Resources/OBL%20St1%20Goodbye,%20Mr.%20Hollywood/8.mp3',NULL,NULL,'01:41'),('53','Rowena Akinyemi - Love or Money 1.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%201.mp3',NULL,NULL,'05:41'),('54','Rowena Akinyemi - Love or Money 2.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%202.mp3',NULL,NULL,'11:09'),('55','Rowena Akinyemi - Love or Money 3.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%203.mp3',NULL,NULL,'11:36'),('56','Rowena Akinyemi - Love or Money 4.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%204.mp3',NULL,NULL,'12:10'),('57','Rowena Akinyemi - Love or Money 5.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%205.mp3',NULL,NULL,'10:20'),('58','Rowena Akinyemi - Love or Money 6.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%206.mp3',NULL,NULL,'08:06'),('59','Rowena Akinyemi - Love or Money 7.mp3',NULL,'6',NULL,'Resources/OBL%20St1%20Love%20or%20Money/Rowena%20Akinyemi%20-%20Love%20or%20Money%207.mp3',NULL,NULL,'14:05'),('60','1.mp3','0','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\1.mp3',NULL,NULL,NULL),('61','2.mp3','1','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\2.mp3',NULL,NULL,NULL),('62','3.mp3','2','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\3.mp3',NULL,NULL,NULL),('63','4.mp3','3','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\4.mp3',NULL,NULL,NULL),('64','5.mp3','4','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\5.mp3',NULL,NULL,NULL),('65','6.mp3','5','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\6.mp3',NULL,NULL,NULL),('66','7.mp3','6','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\7.mp3',NULL,NULL,NULL),('67','8.mp3','7','5','2','Resources\\OBL St1 Goodbye, Mr. Hollywood\\8.mp3',NULL,NULL,NULL);

/*Table structure for table `level` */

DROP TABLE IF EXISTS `level`;

CREATE TABLE `level` (
  `lv_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Level ID',
  `lv_exp_point` int(11) DEFAULT NULL COMMENT 'Exp must have to reach this level',
  `lv_leter` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'The letter of Level',
  `lv_metal_kind` int(11) DEFAULT NULL COMMENT 'Metal Kind of Level',
  PRIMARY KEY (`lv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `level` */

/*Table structure for table `like_notify` */

DROP TABLE IF EXISTS `like_notify`;

CREATE TABLE `like_notify` (
  `like_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notify_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `like_notify` */

/*Table structure for table `mail` */

DROP TABLE IF EXISTS `mail`;

CREATE TABLE `mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `sender` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'SYSTEM',
  `content` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  `mail_type` int(11) NOT NULL,
  `value` int(11) NOT NULL COMMENT 'battle_id or lesson_id or coin number',
  `is_read` tinyint(1) DEFAULT '0',
  `sender_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `is_rated` tinyint(1) DEFAULT '0',
  `is_received` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mail_type` (`mail_type`),
  CONSTRAINT `mail_ibfk_1` FOREIGN KEY (`mail_type`) REFERENCES `mail_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mail` */

/*Table structure for table `mail_type` */

DROP TABLE IF EXISTS `mail_type`;

CREATE TABLE `mail_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `details` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mail_type` */

insert  into `mail_type`(`id`,`type_name`,`details`) values ('1','GIFT_COIN','Sent gift as coin to user'),('2','BATTLE_CHALLENGE','The battle challenge message'),('3','BATTLLE_RESULT','The battle result'),('4','SYSTEM_MESSAGE','The system message'),('5','FRIEND_REQUEST','The friend request');

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `notify_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_location` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `notify_content` text COLLATE utf8_unicode_ci NOT NULL,
  `post_time` datetime NOT NULL,
  `like_count` int(11) DEFAULT '0',
  `comment_count` int(11) DEFAULT '0',
  PRIMARY KEY (`notify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `notification` */

insert  into `notification`(`notify_id`,`user_id`,`user_location`,`notify_content`,`post_time`,`like_count`,`comment_count`) values ('1','QILvqUWVZjgimSlRkKJjyAwbrok2','Viet Nam','','2017-05-29 15:11:27','0','0'),('2','jJjig2TxgUQCX6kByk6u8iskXZV2','Viet Nam','','2017-05-29 15:23:03','0','0'),('3','jJjig2TxgUQCX6kByk6u8iskXZV2','Viet Nam','Hello everyone!','2017-05-29 15:26:34','0','0');

/*Table structure for table `parameter` */

DROP TABLE IF EXISTS `parameter`;

CREATE TABLE `parameter` (
  `param_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) DEFAULT NULL,
  `detais` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `parameter` */

insert  into `parameter`(`param_id`,`value`,`detais`) values ('bronze_chain','1','Battles number of broze chains (to increase level)'),('gold_chain','5','Battles number of gold chains need to increase level'),('mail_saved_time','30','Over 30 days from mail has sent. The mail will be removed'),('max_answer_time','5','Max answer time (Minute)'),('sliver_chain','3','Battles number of sliver chains need to increase level');

/*Table structure for table `question_type` */

DROP TABLE IF EXISTS `question_type`;

CREATE TABLE `question_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `details` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `question_type` */

insert  into `question_type`(`type_id`,`details`) values ('1','listening'),('2','reading');

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` int(11) DEFAULT NULL,
  `question_content` text COLLATE utf8_unicode_ci,
  `answer_a` text COLLATE utf8_unicode_ci,
  `answer_b` text COLLATE utf8_unicode_ci,
  `audio_source` text COLLATE utf8_unicode_ci,
  `true_answer` int(11) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `fk_question_type` (`question_type`),
  KEY `true_answer` (`true_answer`),
  CONSTRAINT `fk_question_type` FOREIGN KEY (`question_type`) REFERENCES `question_type` (`type_id`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`true_answer`) REFERENCES `answer_key` (`answer_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `questions` */

insert  into `questions`(`question_id`,`question_type`,`question_content`,`answer_a`,`answer_b`,`audio_source`,`true_answer`) values ('1','1','What are they talking about?','A movie','A film','http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991','1'),('2','2','This is a reading question.','This is answer A','This is answer B',NULL,'2'),('3','1','This is a listening question.','Answer A...','Answer B...','http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991','2'),('4','2','reading reading reading','The answer a... kaka','bbbbbbbbb',NULL,'2'),('5','1','this is 5th question','Answer for question 5 - A','Answer for question 5 - B',NULL,'1'),('6','2','test test','haha','hehe','\"mp3 link!\"','1');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the auto increment id',
  `user_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User Name',
  `facebook_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'User''s Facebook Id',
  `coin` int(11) DEFAULT '500' COMMENT 'User Coin',
  `rank` int(11) DEFAULT '-1' COMMENT 'Exp of User',
  `level` int(11) DEFAULT '1' COMMENT 'Level of User',
  `win_match` int(11) DEFAULT '0' COMMENT 'Win Match Number of User',
  `total_match` int(11) DEFAULT '0' COMMENT 'Total Match Number of User',
  `avatar_url` text COLLATE utf8_unicode_ci COMMENT 'User''s avatar url - from facebook or default',
  `chain_for_rank` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'bronze_chain' COMMENT 'Current chains to increase level',
  `current_battle` int(11) DEFAULT '0' COMMENT 'Current battles of chains (must be done)',
  PRIMARY KEY (`id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`user_id`,`name`,`facebook_id`,`coin`,`rank`,`level`,`win_match`,`total_match`,`avatar_url`,`chain_for_rank`,`current_battle`) values ('7','Y4iIFhYqnPVgvb38Xxjv0Fckv6w1','Oat Oal',NULL,'3000','16','1','570','1254','https://scontent.xx.fbcdn.net/v/t1.0-1/s100x100/10516852_1522711454624210_7874811916751681734_n.jpg?oh=ff8bf12a8bfc9988a8abc1beb6aa9970&oe=5927D229','bronze_chain','0'),('8','jJjig2TxgUQCX6kByk6u8iskXZV2','Thinh Nguyen Van',NULL,'23380','27','1','640','1140','https://lh3.googleusercontent.com/-7vzsXOMYn70/AAAAAAAAAAI/AAAAAAAAACA/-bFLL7JC3TU/s96-c/photo.jpg','bronze_chain','0'),('9','GAMJNCtdsAVT2O7CRCFxN38QLnX2','Pamobile Dev02',NULL,'80','55','1','500','654','https://lh4.googleusercontent.com/-l1q24Ib9Tec/AAAAAAAAAAI/AAAAAAAAAAA/AAomvV0E3xjSj2QZn4_MmHKJ1Yk8r58DWg/s96-c/photo.jpg','bronze_chain','0'),('10','QILvqUWVZjgimSlRkKJjyAwbrok2','vin huỳnh',NULL,'2700','60','1','135','235','https://lh6.googleusercontent.com/-xt7Q6VwbVkE/AAAAAAAAAAI/AAAAAAAAAAA/AAomvV0pokJsrFTWYM0mwqFv510J5dkC1w/s96-c/photo.jpg','bronze_chain','0');

/* Procedure structure for procedure `accept_battle` */

/*!50003 DROP PROCEDURE IF EXISTS  `accept_battle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_battle`(
	in p_user_id varchar(40),
	in p_battle_id int(11)
    )
BEGIN
	drop temporary table if exists tmpresult;
	create temporary table tmpresult as
	select battles.`battle_id` as battle_id, 
	questions.`question_id` as question_id, 
	questions.`question_type` as question_type, 
	questions.`question_content` as question_content,
	questions.`answer_a` as answer_a,
	questions.`answer_b` as answer_b,
	questions.`audio_source` as audio_source
	
	from battle_question, questions, battles
	where 	battles.`battle_id` = p_battle_id
		AND battles.`defender_id` = p_user_id
		AND `battle_question`.`battle_id` = battles.`battle_id`
		AND battles.`battle_status` = 1
		and questions.`question_id` = battle_question.`question_id`;
		
	select count(*) from tmpresult into @checker_result;
	if(@checker_result = 0) then
		select 202 as error_code;
	else
		update battles
		set battles.`defender_begin_time` = now()
		where battles.`battle_id` = p_battle_id;
		select * from tmpresult;
	end if;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `accept_friend_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `accept_friend_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `accept_friend_request`(
	IN p_user_id VARCHAR(40),
	IN p_mail_id INT(11)
    )
BEGIN	
	SELECT COUNT(*) 
	FROM mail
	WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id
	INTO @checker;
	
	IF(@checker = 0)
	THEN 
		SELECT * FROM error_code WHERE error_code.`code` = 208;
	ELSE
	
		SELECT COUNT(*) 
		FROM mail
		WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id AND mail.`is_received` = 0
		INTO @receive_checker;
		
		IF(@receive_checker = 0) THEN
			SELECT * FROM error_code WHERE error_code.`code` = 300;
		ELSE
			select attach_gifts.`detail`
			from attach_gifts
			where attach_gifts.`mail_id` = p_mail_id and attach_gifts.`gift_type` = 8
			into @friend_request_identifier;
			
			SELECT COUNT(*) 
			FROM `user`
			WHERE user.`user_id` = @friend_request_identifier
			INTO @friend_checker;
			IF(@friend_checker = 0)
			THEN
				SELECT * FROM error_code WHERE error_code.`code` = 303;
			ELSE
				SELECT COUNT(*)
				FROM friends
				WHERE (friends.`person_1` = p_user_id AND friends.`person_2` = @friend_request_identifier) OR 
					(friends.`person_2` = p_user_id AND friends.`person_1` = @friend_request_identifier)
				INTO @already_friend_checker;
				IF(@already_friend_checker > 0)
				THEN
					SELECT * FROM error_code WHERE error_code.`code` = 302;
				ELSE
					INSERT INTO friends (friends.`person_1`, friends.`person_2`) VALUES (p_user_id, @friend_request_identifier);
					SELECT * FROM error_code WHERE error_code.`code` = 200;
				END IF;
			END IF;
			
			
			UPDATE mail
			SET mail.`is_received`  = 1
			WHERE  mail.`id` = p_mail_id AND mail.`receiver` = p_user_id;
		END IF;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `add_battle_to_chains` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_battle_to_chains` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_battle_to_chains`(
	IN p_user_id VARCHAR(40),
	IN p_battle_id int (11)
    )
BEGIN
    
	select battles.`battle_status` 
	from battles
	where battles.`battle_id` = p_battle_id
	into @battle_status;
	
	
	if(@battle_status = 2) then
		
		SELECT `parameter`.`value` 
		FROM `parameter`
		WHERE `parameter`.`param_id` = user.`chain_for_rank`
		INTO @total_match_of_chain;
		
		SELECT user.`current_battle`
		FROM `user`
		WHERE user.`user_id` = p_user_id
		INTO @current_battle;
		
		IF(@current_battle < @total_match_of_chain) THEN
			SET @current_battle = @current_battle + 1;
			UPDATE `user`
			SET user.`current_battle` = @current_battle
			WHERE user.`user_id` = p_user_id;		
		END IF;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `add_coin` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_coin` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_coin`(in p_user_id varchar(40),
	in p_coin_amount INT(11))
BEGIN
	SELECT user.`coin` FROM `user` WHERE `user`.`user_id` = p_user_id INTO @current_coin;
	Select (@current_coin + p_coin_amount) into @new_coin;
	IF(@new_coin >= 0) THEN
	UPDATE `silly_english`.`user`
	SET 
	  `user`.`coin` = @new_coin
	WHERE `user`.`user_id` = p_user_id;
	
	SELECT "200" AS response_code;
	ELSE
		SELECT "206" AS response_code;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `add_friend` */

/*!50003 DROP PROCEDURE IF EXISTS  `add_friend` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `add_friend`(
	in p_user_id varchar(40),
	in p_friend_id varchar(40)
    )
BEGIN
	select Count(*) 
	from `user`
	where user.`user_id` = p_user_id
	into @user_checker;
	
	if(@user_checker = 0)
	then
		select * from error_code where error_code.`code` = 301;
	else
		SELECT COUNT(*) 
		FROM `user`
		WHERE user.`user_id` = p_friend_id
		INTO @friend_checker;
		if(@friend_checker = 0)
		then
			select * from error_code where error_code.`code` = 303;
		else
			select count(*)
			from friends
			where (friends.`person_1` = p_user_id and friends.`person_2` = p_friend_id) OR 
				(friends.`person_2` = p_user_id and friends.`person_1` = p_friend_id)
			into @already_friend_checker;
			if(@already_friend_checker > 0)
			then
				select * from error_code where error_code.`code` = 302;
			else
				insert into friends (friends.`person_1`, friends.`person_2`) values (p_user_id, p_friend_id);
				select * from error_code where error_code.`code` = 200;
			end if;
		end if;
		
	end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `check_lesson_was_bought` */

/*!50003 DROP PROCEDURE IF EXISTS  `check_lesson_was_bought` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `check_lesson_was_bought`(
		in p_user_id varchar(50),
		in p_ls_id int(11)
    )
BEGIN
	select count(*) from `lesson_storage` where `lesson_storage`.`user_id` = p_user_id and `lesson_storage`.`ls_id`= p_ls_id into @check;
	if(@check = 1) then
	select * from error_code where error_code.`code` = 205;
	else
	select * from error_code where error_code.`code` = 207;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `check_mail_saved_time` */

/*!50003 DROP PROCEDURE IF EXISTS  `check_mail_saved_time` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `check_mail_saved_time`(
	in p_user_id varchar(40)
    )
BEGIN
    END */$$
DELIMITER ;

/* Procedure structure for procedure `comment_notify` */

/*!50003 DROP PROCEDURE IF EXISTS  `comment_notify` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `comment_notify`(
	in p_user_id varchar(50),
	in p_notify_id int(11),
	in p_comment_content text
    )
BEGIN
	SELECT `notification`.`comment_count` FROM `notification` WHERE `notification`.`notify_id` = p_notify_id INTO @comment_count;
	insert into `silly_english`.`comment_notify`
            (`user_id`,
             `notify_id`,
             `comment_content`,
             `comment_notify`.`comment_time`)
values (p_user_id,
        p_notify_id,
        p_comment_content,
        now());
        -- update comment count from notification table
		UPDATE `silly_english`.`notification`
		SET `like_count` = @comment_count+1
		WHERE `notify_id` = p_notify_id;
        
    END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_notification` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_notification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_notification`(
		in p_user_id varchar(50),
		in p_notify_id int(11)
    )
BEGIN
		delete
		from `silly_english`.`notification`
		where `notification`.`user_id` = p_user_id and
				 `notification`.`notify_id` = p_notify_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `answer` */

/*!50003 DROP PROCEDURE IF EXISTS  `answer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `answer`(IN p_user_id varchar(40), in p_battle_id int(11), in p_question_id int(11), in p_chose_answer int(11))
BEGIN
		select battles.`battle_status` from battles where battles.`battle_id` = p_battle_id into @status;
		if(@status = 1) then
			CALL check_battle_end_time(p_battle_id);
			
			
			SELECT IF(battles.`attacker_id` = p_user_id, 1, 0) AS checker FROM battles WHERE (battles.`battle_id` = p_battle_id) INTO @checker;
			IF(@checker = 1) THEN	
				
				
				UPDATE battle_question
				SET	battle_question.`attacker_answer` = p_chose_answer,
					battle_question.`attacker_answer_time` = NOW()
				WHERE (`battle_question`.`battle_id` = p_battle_id && `battle_question`.`question_id` = p_question_id && `battle_question`.`attacker_answer` = 5);
				
				SELECT COUNT(*) FROM battle_question WHERE (battle_question.`battle_id` = p_battle_id AND battle_question.`attacker_answer_time` IS NULL) INTO @tmp;
				IF(@tmp = 0) THEN
					UPDATE battles
					SET battles.`attacker_end_time` = NOW()
					WHERE battles.`battle_id` = p_battle_id;
				END IF;
			ELSE
				
				
				UPDATE battle_question
				SET	battle_question.`defender_answer` = p_chose_answer,
					`battle_question`.`defender_answer_time` = NOW()
				WHERE (`battle_question`.`battle_id` = p_battle_id && `battle_question`.`question_id` = p_question_id && `battle_question`.`defender_answer` = 5);
				
				SELECT COUNT(*) FROM battle_question WHERE (battle_question.`battle_id` = p_battle_id AND battle_question.`defender_answer_time` IS NULL) INTO @tmp;
				IF(@tmp = 0) THEN
					UPDATE battles
					SET battles.`defender_end_time` = NOW()
					WHERE battles.`battle_id` = p_battle_id;
				END IF;
			
			END IF;
			
			CALL `update_battle_state`(p_battle_id);
			
			SELECT IF(questions.`true_answer` = p_chose_answer, 1, 0) AS checker FROM `questions` WHERE (`questions`.`question_id` = p_question_id);
		else
			if(@status = 2) then
				select "202" as checker;
			else
				select "203" as checker;
			end if;
				
		end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `buy_lesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `buy_lesson` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `buy_lesson`(
		IN p_user_id varchar(40),
		IN p_lesson_id INT(11)
	    )
BEGIN		
	select lesson.`ls_price` from lesson where lesson.`ls_id` = p_lesson_id into @lesson_price;
	SELECT COUNT(*) FROM `lesson_storage` where `lesson_storage`.`user_id` = p_user_id and `lesson_storage`.`ls_id` = p_lesson_id into @check_buy;
	iF(@check_buy > 0) then
		SELECT * FROM error_code WHERE error_code.`code` = 205;
	else 
		SELECT user.`coin` FROM `user` WHERE `user`.`user_id` = p_user_id INTO @current_coin;
		SELECT (@current_coin - @lesson_price) INTO @new_coin;
		IF(@new_coin >= 0) THEN
		UPDATE `silly_english`.`user` SET `user`.`coin` = @new_coin WHERE `user`.`user_id` = p_user_id;
		INSERT INTO `silly_english`.`lesson_storage` (`ls_id`,`user_id`) VALUES (p_lesson_id,p_user_id);
		SELECT * from error_code where error_code.`code` = 200;
		ELSE
		SELECT * FROM error_code WHERE error_code.`code` = 206;
		END IF;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `cancel_battle` */

/*!50003 DROP PROCEDURE IF EXISTS  `cancel_battle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_battle`(
	in p_user_id varchar(40),
	in p_battle_id int(11)
    )
BEGIN
	
	SELECT COUNT(*) 
	FROM battles
	WHERE battles.`battle_id` = p_battle_id AND battles.`defender_id` = p_user_id
	INTO @exist_checker;
	
	IF(@exist_checker = 0)
	THEN
		
		SELECT * FROM `error_code` WHERE `error_code`.`code` = 203;
	ELSE
		
		DELETE FROM `battle_question`
		WHERE `battle_question`.`battle_id` = p_battle_id;
		
		
		SELECT battles.`attacker_id` 
		FROM battles
		WHERE battles.`battle_id` = p_battle_id
		INTO @attacker_id;
		
		SELECT battles.`bet_value`
		FROM battles
		WHERE battles.`battle_id` = p_battle_id
		INTO @bet_value;
		
		CALL `add_coin`(@attacker_id, @bet_value);
		
		
		CALL `sent_mail`("SYSTEM", @attacker, CONCAT("Battle with id ", p_battle_id, " has cancel."), 4, @bet_value, "SYSTEM");
		
		
		DELETE FROM battles
		WHERE battles.`battle_id` = p_battle_id AND battles.`defender_id` = p_user_id;
		
		
		SELECT * FROM `error_code` WHERE `error_code`.`code` = 200;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `check_battle_end_time` */

/*!50003 DROP PROCEDURE IF EXISTS  `check_battle_end_time` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `check_battle_end_time`(
	in p_battle_id int(11)
)
BEGIN
	
	SELECT `parameter`.`value` 
	FROM parameter 
	WHERE `parameter`.`param_id` = "max_answer_time" 
	INTO @max_answer_time;	
	
	
	SELECT battles.`attacker_begin_time` 
	FROM battles 
	WHERE battles.`battle_id` = p_battle_id 
	INTO @attacker_begin_time;
	
	
	SET @max_time = UNIX_TIMESTAMP(DATE_ADD(@attacker_begin_time, INTERVAL @max_answer_time MINUTE));
	SET @now = unix_timestamp(Now());
	
	IF((@max_time - @now) < 0)
	THEN
		UPDATE battles
		SET battles.`attacker_end_time` = @max_time
		WHERE battles.`battle_id` = p_battle_id;
		
		UPDATE battle_question
		SET battle_question.`attacker_answer` = 6, battle_question.`attacker_answer_time` = @max_time
		WHERE battle_question.`battle_id`  = p_battle_id AND battle_question.`attacker_answer` = 5;
		
		CALL `update_battle_state`(p_battle_id);
	END IF;
		
	
	SELECT battles.`defender_begin_time` 
	FROM battles 
	WHERE battles.`battle_id` = p_battle_id 
	INTO @defender_begin_time;
	SET @max_def_time = unix_timestamp(DATE_ADD(@defender_begin_time, INTERVAL @max_answer_time MINUTE));
	
	
	IF((@max_def_time - @now) < 0)
	THEN
		UPDATE battles
		SET battles.`defender_end_time` = @max_def_time
		WHERE battles.`battle_id` = p_battle_id;
		
		UPDATE battle_question
		SET battle_question.`defender_answer` = 6, battle_question.`defender_answer_time` = @max_def_time
		WHERE battle_question.`battle_id`  = p_battle_id AND battle_question.`defender_answer` = 5;
		
		CALL `update_battle_state`(p_battle_id);
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `find_battle` */

/*!50003 DROP PROCEDURE IF EXISTS  `find_battle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `find_battle`(
	in p_user_id varchar(40)
    )
BEGIN
	SELECT user.`user_id`, user.`name`, user.`rank`, user.`level`, user.`total_match`, user.`win_match`, user.`avatar_url` 
	FROM `user` 
	where user.`user_id` <> p_user_id
	ORDER BY RAND() 
	LIMIT 1;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_attatch_items` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_attatch_items` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_attatch_items`(
	in p_user_id varchar(40),
	IN p_mail_id int(11)
    )
BEGIN
	Select COUNT(*) 
	from mail
	where mail.`id` = p_mail_id and mail.`receiver` = p_user_id
	into @checker;
	
	if(@checker = 0) 
	then	
		SELECT * 
		FROM `error_code`
		WHERE `error_code`.`code` = 208;
	else
		SELECT *
		FROM `attach_gifts` 
		WHERE `attach_gifts`.`mail_id` = p_mail_id;
		
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_battle_chains` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_battle_chains` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_battle_chains`(
		IN p_user_id varchar(40)
	    )
BEGIN		
	SELECT	battles.`battle_id`, battles.`date_create`, battles.`victory_id`
	FROM 	battles
	WHERE	((battles.`attacker_id` = p_user_id) OR (battles.`defender_id` = p_user_id)) AND (battles.`battle_status` = 2)
	ORDER BY battles.`date_create` DESC
	LIMIT 5;
	
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `create_battle` */

/*!50003 DROP PROCEDURE IF EXISTS  `create_battle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `create_battle`(IN p_attacker_id varchar(40), IN p_defender_id varchar(40), in p_bet_value int(11), in p_message varchar(128))
BEGIN
	INSERT INTO battles (attacker_id, defender_id, bet_value) VALUES(p_attacker_id, p_defender_id, p_bet_value);
	select LAST_INSERT_ID() into @lastid ;
	INSERT INTO battle_question (battle_id, question_id) (SELECT @lastid AS battle_id, question_id FROM questions ORDER BY RAND() LIMIT 5);
	
	select `user`.`name` from `user` where user.`user_id` = p_attacker_id into @sender_name;
	
	select battle_question.`battle_id`, questions.`question_id`, questions.`question_content`, questions.`audio_source`, 
		questions.`question_type`, `questions`.`answer_a`, questions.`answer_b`
	 from battle_question, questions 
	 where battle_id = @lastid and questions.`question_id` = battle_question.`question_id`;
	 
	 /*Sent attack battle mail*/
	CALL sent_challenge_mail(p_attacker_id, p_defender_id, p_message, 2, @lastid, @sender_name, @lastid, p_bet_value);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `decrease_level` */

/*!50003 DROP PROCEDURE IF EXISTS  `decrease_level` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `decrease_level`(
	in p_user_id varchar(40)
    )
BEGIN
	
SELECT user.`level` FROM `user` WHERE user.`user_id` = p_user_id INTO @current_level;
	IF(@current_level = 26) THEN
		SELECT `parameter`.`value` FROM `parameter` WHERE `parameter`.`param_id` = "bronze_chain" INTO @bronze_chain;
		UPDATE `user`
		SET user.`chain_for_rank` = @bronze_chain
		WHERE user.`user_id` = p_user_id;
	END IF;
	
	IF(@current_level = 52) THEN
		SELECT `parameter`.`value` FROM `parameter` WHERE `parameter`.`param_id` = "sliver_chain" INTO @sliver_chain;
		UPDATE `user`
		SET user.`chain_for_rank` = @sliver_chain
		WHERE user.`user_id` = p_user_id;
	END IF;
	
	IF(@current_level > 0) THEN
		SET @current_level = @current_level - 1;
		UPDATE `user`
		SET user.`level` = @current_level
		WHERE user.`user_id` = p_user_id;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `friend_ranking` */

/*!50003 DROP PROCEDURE IF EXISTS  `friend_ranking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `friend_ranking`(
	IN p_user_id VARCHAR(40)
    )
BEGIN
	SELECT COUNT(*) 
	FROM `user` 
	WHERE user.`user_id` = p_user_id 
	INTO @checker;
	
	IF(@checker = 0)
	THEN
		SELECT * FROM error_code WHERE error_code.`code` = 301;
	ELSE
		DROP TEMPORARY TABLE IF EXISTS friends_ranking_tmp;
		CREATE TEMPORARY TABLE friends_ranking_tmp 
		(
			`id` INT(11) NOT NULL,
			`user_id` VARCHAR(40) COLLATE utf8_unicode_ci NOT NULL,
			`name` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL ,
			`rank` INT(11) DEFAULT '-1',
			`level` INT(11) DEFAULT '1',
			`win_match` INT(11) DEFAULT '0',
			`total_match` INT(11) DEFAULT '0',
			`avatar_url` TEXT COLLATE utf8_unicode_ci,
			`is_user_friend` int(11) default '1',
			 PRIMARY KEY (`id`,`user_id`)
		) ENGINE=InnoDB AS 
		(
			SELECT user.`id`, user.`user_id`, user.`name`, user.`rank`, user.`level`, user.`win_match`, user.`total_match`, user.`avatar_url`, 1 as is_user_friend
			FROM `user`, friends 
			WHERE (friends.`person_1` = p_user_id AND friends.`person_2` = `user`.`user_id`) OR (friends.`person_2` = p_user_id AND friends.`person_1` = `user`.`user_id`)
			ORDER BY user.`rank` ASC
			LIMIT 50
		);
		
		INSERT INTO friends_ranking_tmp 
		(
			friends_ranking_tmp.id,
			friends_ranking_tmp.user_id,
			friends_ranking_tmp.name,
			friends_ranking_tmp.rank,
			friends_ranking_tmp.level,
			friends_ranking_tmp.win_match,
			friends_ranking_tmp.total_match,
			friends_ranking_tmp.avatar_url
		)
		SELECT user.`id`, user.`user_id`, user.`name`, user.`rank`, user.`level`, user.`win_match`, user.`total_match`, user.`avatar_url`
		FROM `user`
		WHERE `user`.`user_id` = p_user_id;
		
		SELECT * FROM friends_ranking_tmp
		ORDER BY friends_ranking_tmp.`rank` ASC;
		
		DROP TEMPORARY TABLE IF EXISTS friends_ranking_tmp;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_battle_result` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_battle_result` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_battle_result`(
	in p_user_id varchar(40),
	in p_battle_id int(11)
    )
BEGIN
	
	SELECT IF(battles.`attacker_id` = p_user_id, 1, 0) AS checker 
	FROM battles 
	WHERE (battles.`battle_id` = p_battle_id) 
	INTO @checker;
	
	IF(@checker = 1) THEN
		
		SELECT COUNT(*) 
		FROM battle_question 
		WHERE (battle_question.`battle_id` = p_battle_id 
		AND battle_question.`attacker_answer_time` IS NULL) 
		INTO @tmp;
		
		IF(@tmp = 0) THEN
			SELECT battle_question.`question_id`, battle_question.`attacker_answer` as answer, questions.`true_answer`
			FROM battle_question, questions
			WHERE	(battle_question.`battle_id` = p_battle_id) AND (battle_question.`question_id` = questions.`question_id`);
		else
			select 201 as error_code;
				
		end if;
	else
	
		
		SELECT COUNT(*) 
		FROM battle_question 
		WHERE (battle_question.`battle_id` = p_battle_id 
		AND battle_question.`defender_answer_time` IS NULL) 
		INTO @tmp;
		
		IF(@tmp = 0) THEN
			SELECT battle_question.`question_id`, battle_question.`defender_answer` as answer, questions.`true_answer`
			FROM battle_question, questions
			WHERE	(battle_question.`battle_id` = p_battle_id) AND (battle_question.`question_id` = questions.`question_id`);
		ELSE
			SELECT 201 AS error_code;
				
		END IF;
	
	end if;	
			
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_inbox_items` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_inbox_items` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_inbox_items`(in p_user_id varchar(40))
BEGIN
	select *
	from mail
	where mail.`receiver` = p_user_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_lesson_list` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_lesson_list` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lesson_list`(
    )
BEGIN
	SELECT * FROM lesson;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_lesson_unit` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_lesson_unit` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lesson_unit`(
		IN p_lesson_id INT(11)
    )
BEGIN
	SELECT * FROM `silly_english`.`lesson_unit` where `lesson_unit`.ls_id = p_lesson_id;
	       
END */$$
DELIMITER ;

/* Procedure structure for procedure `get_popular_lesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_popular_lesson` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_popular_lesson`(
	    )
BEGIN		
	SELECT	*
	FROM 	lesson
	ORDER BY lesson.`ls_download` DESC
	LIMIT 5;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_notification` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_notification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_notification`(IN `p_user_id` VARCHAR(50), IN `p_limit_amount` INT(11))
BEGIN
	select `notification`.*	
	from `notification`,`friends`
	where 	(
		(`notification`.`user_id` = `friends`.`person_1` AND `friends`.`person_2` = p_user_id) OR
		(`notification`.`user_id` = `friends`.`person_2` AND `friends`.`person_1` = p_user_id)
		)
	order by(`notification`.`post_time`)  DESC limit p_limit_amount;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `mask_as_opened_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `mask_as_opened_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `mask_as_opened_mail`(
	IN p_user_id varchar(40),
	IN p_mail_id varchar(40)
    )
BEGIN
	Select count(*)
	from `mail`
	where mail.`id` = p_mail_id and mail.`receiver` = p_user_id
	into @checker;
	
	if(@checker = 0)
	then
		select * from error_code where error_code.`code` = 208;
	else
		UPDATE mail
		SET mail.`is_read` = 1
		WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id;
		
		select * from error_code where `error_code`.`code` = 200;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_enemy_duel` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_enemy_duel` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enemy_duel`(
	in p_user_id varchar(40),
	in p_battle_id int(11)
    )
BEGIN
	select count(*)
	from `user`
	where user.`user_id` = p_user_id
	into @user_checker;
	
	if(@user_checker = 0)
	then
		select * from error_code where error_code.`code` = 301;
	else
		select count(*)
		from battles
		where battles.`battle_id` = p_battle_id and battles.`defender_id` = p_user_id
		into @battle_checker;
		
		if(@battle_checker = 0)
		then
			select * from error_code where error_code.`code` = 203;
		else
			SELECT user.`user_id`, user.`name`, user.`rank`, user.`level`, user.`total_match`, user.`win_match`, user.`avatar_url` 
			FROM `user`, `battles`
			WHERE battles.`battle_id` = p_battle_id AND battles.`defender_id` = p_user_id AND user.`user_id` = battles.`attacker_id`;
		end if;
		
		
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_lesson_tracker` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_lesson_tracker` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_lesson_tracker`(
		in p_user_id	varchar(50),
		in p_ls_id int(11)
	)
BEGIN
		select count(*) from `lesson_tracker` where `lesson_tracker`.`ls_id` = p_ls_id and `lesson_tracker`.`user_id` = p_user_id into @check_exist;
		if(@check_exist = 0)
		then  -- neu chua nghe lesson nay lan nao -> insert new row
			INSERT INTO `silly_english`.`lesson_tracker`
				    (`user_id`,
				     `ls_id`,
				     `ls_progress`)
			VALUES (p_user_id,
				p_ls_id,
				0);
		end if;
		-- get max listen time of this lesson
		select `lesson`.`ls_max_hear_times` from `lesson` where `lesson`.`ls_id` = p_ls_id into @max_hear;
		-- get lesson_tracker id 
		select `lesson_tracker`.`lst_id` from `lesson_tracker` where `lesson_tracker`.`user_id` = p_user_id and `lesson_tracker`.`ls_id` = p_ls_id into @lst_id;
		-- get number of lesson unit of this lesson
		select 5* count(*) from `lesson_unit` where `lesson_unit`.`ls_id` = p_ls_id into @lesson_unit_tracker;
		-- get progress 
		select `lesson_tracker`.`ls_progress` from `lesson_tracker` where `lesson_tracker`.`lst_id` = @lst_id into @current_progress;
		-- calculate current listen time
		select floor(@current_progress/@lesson_unit_tracker)+1 into @current_listen_time;
		-- select the first lesson unit id of this lesson
		select `lesson_unit`.`lu_id` from `lesson_unit` where `ls_id` = p_ls_id order by(`lu_id`) asc limit 1 into @first_lu_id;
		-- select lesson_unit id 
		select (@current_progress%@lesson_unit_tracker) into @current_listen_time_progress;
		select @current_listen_time as `current_time`,@current_listen_time_progress as progress, @max_hear as `max_hear`;
		
	END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_info` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_info` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_info`(	IN p_user_id VARCHAR(40),
		IN p_avatar_url varchar(256),
		IN p_user_name varchar(50)
	)
BEGIN
		
		select 	COUNT(*) from `user` where user.`user_id` = p_user_id into @created_state;
		
		if(@created_state = 1) then
			SELECT user.`user_id`, user.`name`, user.`avatar_url`, user.`level`, user.`rank`, user.`win_match`, user.`total_match`, 
			user.`chain_for_rank`, user.`coin`, user.`chain_for_rank`, user.`current_battle`, `parameter`.`value` AS chain_matchs
			FROM `user`, `parameter`
			WHERE user_id = p_user_id AND `parameter`.`param_id` = user.`chain_for_rank`;
		else
			insert into `user`
			(
				user.`user_id`,
				user.`avatar_url`,
				user.`name`
			)
			values
			(
				p_user_id,
				p_avatar_url,
				p_user_name
			);
			
			SELECT user.`user_id`, user.`name`, user.`avatar_url`, user.`level`, user.`rank`, user.`win_match`, user.`total_match`, 
			user.`chain_for_rank`, user.`coin`, user.`chain_for_rank`, user.`current_battle`, `parameter`.`value` AS chain_matchs
			FROM `user`, `parameter`
			WHERE user_id = p_user_id AND `parameter`.`param_id` = user.`chain_for_rank`;
		
		end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `global_ranking` */

/*!50003 DROP PROCEDURE IF EXISTS  `global_ranking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `global_ranking`(
	IN p_user_id VARCHAR(40)
)
BEGIN
	DECLARE total_rows INT DEFAULT 0;
	DECLARE iindex INT DEFAULT 0;
	
	SELECT COUNT(*)
	FROM `user`
	WHERE user.`user_id` = p_user_id
	INTO @checker;
	IF(@checker = 0)
	THEN
		SELECT * FROM error_code WHERE error_code.`code` = 301;
	ELSE
		DROP TEMPORARY TABLE IF EXISTS global_ranking_tmp;
		CREATE TEMPORARY TABLE global_ranking_tmp 
		(
			`id` INT(11) NOT NULL,
			`user_id` VARCHAR(40) COLLATE utf8_unicode_ci NOT NULL,
			`name` VARCHAR(50) COLLATE utf8_unicode_ci NOT NULL ,
			`rank` INT(11) DEFAULT '-1',
			`level` INT(11) DEFAULT '1',
			`win_match` INT(11) DEFAULT '0',
			`total_match` INT(11) DEFAULT '0',
			`avatar_url` TEXT COLLATE utf8_unicode_ci,
			`is_user_friend` INT(11) DEFAULT '1',
			 PRIMARY KEY (`id`,`user_id`)
		) ENGINE=INNODB AS 
		(
			SELECT user.`id`, user.`user_id`, user.`name`, user.`rank`, user.`level`, user.`win_match`, user.`total_match`, user.`avatar_url`, 0 AS is_user_friend
			FROM `user`
			ORDER BY user.`rank` ASC
			LIMIT 50
		);
		
		SELECT COUNT(*) FROM global_ranking_tmp INTO total_rows;
		SET iindex = 0;
		WHILE iindex < total_rows DO 
			SELECT global_ranking_tmp.user_id
			FROM global_ranking_tmp LIMIT iindex,1
			INTO @ranking_user_id;
			
			IF(p_user_id <> @ranking_user_id)
			THEN
				SELECT COUNT(*)
				FROM friends
				WHERE (friends.`person_1` = p_user_id AND friends.`person_2` = @ranking_user_id) OR 
					(friends.`person_2` = p_user_id AND friends.`person_1` = @ranking_user_id)
				INTO @already_friend_checker;
				
				IF(@already_friend_checker > 0)
				THEN
					UPDATE global_ranking_tmp
					SET global_ranking_tmp.is_user_friend = 1
					WHERE global_ranking_tmp.user_id = @ranking_user_id;
				END IF;
			ELSE
				UPDATE global_ranking_tmp
				SET global_ranking_tmp.is_user_friend = 1
				WHERE global_ranking_tmp.user_id = @ranking_user_id;
			END IF;
			
			SET iindex = iindex + 1;
		END WHILE;
			
		
		SELECT * FROM global_ranking_tmp;
		DROP TEMPORARY TABLE IF EXISTS global_ranking_tmp;
		
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `post_new_notification` */

/*!50003 DROP PROCEDURE IF EXISTS  `post_new_notification` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `post_new_notification`(
	in p_user_id varchar(50),
	in p_user_location varchar(30),
	in p_notify_content text
    )
BEGIN
	insert into `silly_english`.`notification`
            (`user_id`,
             `user_location`,
             `notify_content`,
             `post_time`)
		values (p_user_id,
			p_user_location,
			p_notify_content,
			now());
	select * from `error_code` where `error_code`.`code` = 214;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `remove_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `remove_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_mail`(IN p_user_id varchar(40), in p_mail_id int(11))
BEGIN
	select count(*)
	from mail
	where mail.`receiver` = p_user_id and mail.`id` = p_mail_id 
	into @checker;
	if(@checker = 0)
	then
		SELECT * 
		FROM `error_code`
		WHERE `error_code`.`code` = 208;
	else
		DELETE FROM mail 
		WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id;
		
		delete from attach_gifts
		where `attach_gifts`.`mail_id` = p_mail_id;		
		
		select *
		from `error_code`
		where `error_code`.`code` = 200;
	end if;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sent_challenge_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `sent_challenge_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_challenge_mail`(
	IN p_sender VARCHAR(40),
	IN p_receiver VARCHAR(40),
	IN p_content VARCHAR(256),
	IN p_mail_type INT(11),
	IN p_value INT(11),
	IN p_sender_name VARCHAR(50),
	In p_battle_id int(11),
	in p_battle_bet_value int(11)
    )
BEGIN
	
	INSERT INTO mail 
	(
		mail.`sender`,
		mail.`receiver`,
		mail.`content`,
		mail.`mail_type`,
		mail.`value`,
		mail.`sender_name`
	) 
	VALUES
	(
		p_sender, 
		p_receiver,
		p_content,
		p_mail_type,
		p_value,
		p_sender_name
	);
	
	SELECT LAST_INSERT_ID() INTO @lastid ;
	
	insert into attach_gifts
	(
		attach_gifts.`mail_id`,
		attach_gifts.`gift_type`,
		attach_gifts.`value`,
		attach_gifts.`quantity`,
		attach_gifts.`detail`
	)
	values
	(
		@lastid,
		5,
		p_battle_bet_value,
		1,
		"The battle bet value."
	),
	(
		@lastid,
		3,
		p_battle_id,
		1,
		"The battle challenge identifier."
	);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `inbox_claim_rewards` */

/*!50003 DROP PROCEDURE IF EXISTS  `inbox_claim_rewards` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `inbox_claim_rewards`(
	IN p_user_id VARCHAR(40),
	IN p_mail_id INT(11)
    )
BEGIN
	DECLARE total_rows INT DEFAULT 0;
	DECLARE iindex INT DEFAULT 0;
		
	SELECT COUNT(*) 
	FROM mail
	WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id
	INTO @checker;
	
	IF(@checker = 0)
	THEN 
		SELECT * FROM error_code WHERE error_code.`code` = 208;
	ELSE
	
		SELECT COUNT(*) 
		FROM mail
		WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id and mail.`is_received` = 0
		INTO @receive_checker;
		
		if(@receive_checker = 0) then
			SELECT * FROM error_code WHERE error_code.`code` = 300;
		else
			DROP TEMPORARY TABLE IF EXISTS all_gifs;
			CREATE TEMPORARY TABLE all_gifs 
			(
				`id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
				`mail_id` INT(11) DEFAULT NULL,
				`gift_type` INT(11) DEFAULT NULL,
				`value` INT(11) DEFAULT NULL,
				`quantity` INT(11) DEFAULT NULL,
				`detail` VARCHAR(80) COLLATE utf8_unicode_ci DEFAULT NULL
			) ENGINE=MEMORY AS 
			(
				SELECT * 
				FROM attach_gifts 
				WHERE attach_gifts.`mail_id` = p_mail_id
			);
			
			SELECT COUNT(*) FROM all_gifs INTO total_rows;
			SET iindex = 0;
			WHILE iindex < total_rows DO 
				
				SELECT all_gifs.gift_type
				FROM all_gifs LIMIT iindex,1
				INTO @gtype;
				
				IF(@gtype = 1) 
				THEN
					
					SELECT all_gifs.value
					FROM all_gifs LIMIT iindex,1
					INTO @coin_value;
					CALL `add_coin`(p_user_id, @coin_value); 
				END IF;
				
				
				SET iindex = iindex + 1;
			END WHILE;
			
			
			UPDATE mail
			SET mail.`is_received`  = 1
			WHERE  mail.`id` = p_mail_id AND mail.`receiver` = p_user_id;
			
			
			DROP TEMPORARY TABLE IF EXISTS all_gifs;
			
			
			SELECT * FROM error_code WHERE error_code.`code` = 200;
		end if;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `increase_level` */

/*!50003 DROP PROCEDURE IF EXISTS  `increase_level` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `increase_level`(
	IN p_user_id varchar(40)
    )
BEGIN
	select user.`level` from `user` where user.`user_id` = p_user_id into @current_level;
	IF(@current_level = 25) THEN
		SELECT `parameter`.`value` FROM `parameter` WHERE `parameter`.`param_id` = "sliver_chain" INTO @sliver_chain;
		update `user`
		set user.`chain_for_rank` = @sliver_chain
		where user.`user_id` = p_user_id;
	END IF;
	
	IF(@current_level = 51) THEN
		SELECT `parameter`.`value` FROM `parameter` WHERE `parameter`.`param_id` = "gold_chain" INTO @gold_chain;
		UPDATE `user`
		SET user.`chain_for_rank` = @gold_chain
		WHERE user.`user_id` = p_user_id;
	END IF;
	
	if(@current_level < 77) then
		set @current_level = @current_level + 1;
		update `user`
		set user.`level` = @current_level
		where user.`user_id` = p_user_id;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `like_notify` */

/*!50003 DROP PROCEDURE IF EXISTS  `like_notify` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `like_notify`(
	in p_user_id varchar(50),
	in p_notify_id int(11)
    )
BEGIN
	select count(*) from `like_notify` where `like_notify`.`user_id` = p_user_id and `like_notify`.`notify_id` = p_notify_id into @check_liked;
	SELECT `notification`.`like_count` FROM `notification` WHERE `notification`.`notify_id` = p_notify_id INTO @like_count;
	if(@check_liked = 1) 
	then -- neu nhu da like roi thi dislike
		delete
		from `silly_english`.`like_notify`
		where `like_notify`.`notify_id` = p_notify_id and `like_notify`.`user_id` = p_user_id;
		-- update like count from notification table
		update `silly_english`.`notification`
		set `like_count` = @like_count-1
		where `notify_id` = p_notify_id;
		
		select * from `error_code` where `error_code`.`code` = 216;
	else
		insert into `silly_english`.`like_notify`
			    (`user_id`,
			     `notify_id`)
		values (p_user_id,
			p_notify_id);
			
		-- update like count from notification table
		update `silly_english`.`notification`
		set `like_count` = @like_count+1
		where `notify_id` = p_notify_id;
		select * from `error_code` where `error_code`.`code` = 215;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `rating_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `rating_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `rating_mail`(
	in p_user_id varchar(40),
	in p_mail_id int(11)
    )
BEGIN
	select count(*)
	from mail
	where mail.`id` = p_mail_id and mail.`receiver` = p_user_id
	into @checker;
	
	if(@checker = 0)
	then
		select * 
		from `error_code`
		where error_code.`code` = 208;
	else
		select mail.`is_rated`
		from mail
		where mail.`id` = p_mail_id 
		into @is_rated;
		
		if(@is_rated = 0)
		then
			UPDATE mail
			SET mail.`is_rated` = 1
			WHERE mail.`id` = p_mail_id and mail.`receiver` = p_user_id;
		else
			UPDATE mail
			SET mail.`is_rated` = 0
			WHERE mail.`id` = p_mail_id AND mail.`receiver` = p_user_id;
		end if;
		
		select * 
		from error_code 
		where `error_code`.`code` = 200;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sent_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `sent_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_mail`(
	IN p_sender VARCHAR(40),
	in p_receiver varchar(40),
	in p_content varchar(256),
	IN p_mail_type int(11),
	IN p_value INT(11),
	IN p_sender_name varchar(50)
    )
BEGIN
	
	INSERT INTO mail 
	(
		mail.`sender`,
		mail.`receiver`,
		mail.`content`,
		mail.`mail_type`,
		mail.`value`,
		mail.`sender_name`
	) 
	VALUES
	(
		p_sender, 
		p_receiver,
		p_content,
		p_mail_type,
		p_value,
		p_sender_name
	);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `remove_friend_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `remove_friend_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_friend_request`(
	in p_user_id varchar(40),
	in p_friend_id varchar(40)
    )
BEGIN
	select count(*) 
	from `user` 
	where user.`user_id` = p_user_id
	into @user_checker;
	
	if(@user_checker = 0)
	then
		select * from error_code where error_code.`code` = 301;
	else
		select count(*)
		from `user` 
		where user.`user_id` = p_friend_id
		into @friend_checker;
		if(@friend_checker = 0)
		then
			select * from error_code where error_code.`code` = 303;
		else
			DELETE FROM friends 
			WHERE (friends.`person_1` = p_user_id and friends.`person_2` = p_friend_id) 
			or (friends.`person_2` = p_user_id and friends.`person_1` = p_friend_id);
			
			select * from error_code where error_code.`code` = 200;
		end if;
	end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sent_add_friend_request` */

/*!50003 DROP PROCEDURE IF EXISTS  `sent_add_friend_request` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_add_friend_request`(
	in p_user_id varchar(40),
	in p_friend_id varchar(40)
    )
BEGIN
	select count(*)
	from `user`
	where user.`user_id` = p_user_id
	into @user_checker;
	
	if(@user_checker = 0)
	then
		
		select * from error_code where error_code.`code` = 301;
	else
		SELECT COUNT(*)
		FROM `user`
		WHERE user.`user_id` = p_friend_id
		INTO @friend_checker;
		
		if(@friend_checker = 0)
		then
			
			select * from error_code where error_code.`code` = 303;
		else
			
			Select count(*)
			from friends
			where (friends.`person_1` = p_user_id and friends.`person_2` = p_friend_id) 
				OR (friends.`person_2` = p_user_id and friends.`person_1` = p_friend_id)
			into @already_friend_checker;
			
			if(@already_friend_checker = 0)
			then
				
				SELECT user.`name` 
				FROM `user`
				WHERE user.`user_id` = p_user_id
				INTO @sender_name;
				
				INSERT INTO mail 
				(
					mail.`sender`,
					mail.`receiver`,
					mail.`content`,
					mail.`mail_type`,
					mail.`value`,
					mail.`sender_name`
				) 
				VALUES
				(
					p_user_id, 
					p_friend_id,
					"The add friend request.",
					5,
					0,
					@sender_name
				);
				
				SELECT LAST_INSERT_ID() INTO @lastid ;
				INSERT INTO attach_gifts
				(
					attach_gifts.`mail_id`,
					attach_gifts.`gift_type`,
					attach_gifts.`value`,
					attach_gifts.`quantity`,
					attach_gifts.`detail`
				)
				VALUES
				(
					@lastid,
					8,
					0,
					1,
					p_user_id
				);
				
				
				SELECT * FROM error_code WHERE error_code.`code` = 200;
			else
				
				select * from error_code where error_code.`code` = 302;
			end if;
		end if;
	end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_battle_result` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_battle_result` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_battle_result`(
	in p_battle_id int(11)
    )
BEGIN
	
	SELECT IF(battles.`battle_status` = 2, 1, 0) FROM battles WHERE (battles.`battle_id` = p_battle_id) INTO @state_checker;
	if(@state_checker = 1) then
	
		SELECT COUNT(*) 
		FROM battle_question, questions
		WHERE 
			battle_question.`battle_id` = p_battle_id 
			AND questions.`question_id` = battle_question.`question_id`
			AND battle_question.`attacker_answer` = questions.`true_answer` 
		INTO @total_attacker_answer;
		
		SELECT COUNT(*) 
		FROM battle_question, questions
		WHERE 
			battle_question.`battle_id` = p_battle_id 
			AND questions.`question_id` = battle_question.`question_id`
			AND battle_question.`defender_answer` = questions.`true_answer` 
		INTO @total_defender_answer;
		
		IF(@total_attacker_answer > @total_defender_answer) THEN
			
			
			UPDATE battles 
			SET battles.`victory_id` = battles.`attacker_id`
			WHERE battles.`battle_id` = p_battle_id;
			
		END IF;
		
		IF(@total_attacker_answer < @total_defender_answer) THEN
			
			UPDATE battles 
			SET battles.`victory_id` = battles.`defender_id`
			WHERE battles.`battle_id` = p_battle_id;
		END IF;
			
		IF(@total_attacker_answer = @total_defender_answer) THEN
			
			SELECT (battles.`attacker_end_time` - battles.`attacker_begin_time`)
			FROM battles
			WHERE battles.`battle_id` = p_battle_id AND battles.`battle_status` = 2 
			INTO @attacker_time;
			
			SET @attacker_time = unix_timestamp(@attacker_time);
			
			SELECT (battles.`defender_end_time` - battles.`defender_begin_time`)
			FROM battles
			WHERE battles.`battle_id` = p_battle_id AND battles.`battle_status` = 2 INTO @defender_time;
			
			SET @defender_time = unix_timestamp(@defender_time);
			
			IF(@attacker_time > @defender_time) THEN 
				
				UPDATE battles 
				SET battles.`victory_id` = battles.`attacker_id`
				WHERE battles.`battle_id` = p_battle_id;
			END IF;
			
			IF(@attacker_time < @defender_time) THEN 
				
				UPDATE battles 
				SET battles.`victory_id` = battles.`defender_id`
				WHERE battles.`battle_id` = p_battle_id;
			END IF;
			
			IF(@attacker_time = @defender_time) THEN
				UPDATE battles
				SET battles.`victory_id` = "draw"
				WHERE battles.`battle_id` = p_battle_id;
			END IF;
			
		END IF;
	end if;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `update_battle_state` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_battle_state` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_battle_state`(IN p_battle_id int(11))
BEGIN
	SELECT	COUNT(*) 
	FROM 	battle_question 
	WHERE	battle_question.`battle_id` = p_battle_id 
		AND ((battle_question.`defender_answer_time` IS NULL)
		OR (battle_question.`attacker_answer_time` IS NULL))
	INTO @status_checker;
	
	
	IF(@status_checker = 0) THEN
	
		UPDATE battles
		SET battles.`battle_status` = 2
		WHERE battles.`battle_id` = p_battle_id;
		
		
		CALL update_battle_result(p_battle_id);
		
		Select battles.`attacker_id`
		from battles 
		where battles.`battle_id` = p_battle_id into @attacker;
		
		select battles.`defender_id` 
		from battles
		where battles.`battle_id` = p_battle_id into @defender;
		
		call update_user_ranking(@attacker);
		call update_user_ranking(@defender);
		
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `update_lesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_lesson` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lesson`(
		in p_user_id varchar(50),
		in p_lu_id int(11)
    )
BEGIN
		SELECT `ls_id` FROM `lesson_unit` WHERE `lesson_unit`.`lu_id` = p_lu_id INTO @p_ls_id;
		SELECT count(*) FROM `lesson_unit` WHERE `ls_id` = @p_ls_id AND `lesson_unit`.`lu_id` = (p_lu_id+1) into @check_next_lu_id;
	
	
		select count(*) from `lesson_tracker` where `lesson_tracker`.`user_id` = p_user_id and `lesson_tracker`.`ls_id` = @p_ls_id into @check_listened;
	
	
		if (@check_listened = 1) then
				select `lu_id` from `lesson_tracker` where `lesson_tracker`.`user_id` = p_user_id AND `lesson_tracker`.`ls_id` = @p_ls_id into @current_lu;
		
		if(@check_next_lu_id = 1)then 		
		
			IF(@current_lu <= p_lu_id) THEN
				UPDATE `silly_english`.`lesson_tracker`
				SET `lu_id` = (p_lu_id+1)
				WHERE `lesson_tracker`.`ls_id`=@p_ls_id AND `lesson_tracker`.`user_id` = p_user_id;
				SELECT * FROM error_code WHERE error_code.`code` = 209;
			END IF;
		else 			select * from error_code where error_code = 212;
		end if;
		end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `update_lesson_progress` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_lesson_progress` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_lesson_progress`(
	in p_user_id varchar(50),
	in p_ls_id int(11),
	in p_ls_progress int(11)
    )
BEGIN
    
	-- check user da nghe lesson nay lan nao hay chua
	select count(*) from lesson_tracker where `lesson_tracker`.`user_id` = p_user_id and `lesson_tracker`.`ls_id` = p_ls_id into @check_user_listened;
	
	-- lay ra tong cong so tracker cua lesson ma user dang nghe hoac sap nghe
	SELECT (5* COUNT(*)) FROM `lesson_unit` WHERE `lesson_unit`.`ls_id` = p_ls_id INTO @lesson_tracker_amount;
	
	-- lay ra so lan nghe toi da cua lesson do
	select `lesson`.`ls_max_hear_times` from `lesson` where `lesson`.`ls_id` = p_ls_id into @ls_listen_time;
	-- lay ra so coin se cong vao cho user sau khi nghe hoan thanh 1 lan nghe moi
	select floor(`lesson`.`ls_price`/@ls_listen_time) from lesson where `lesson`.`ls_id` = p_ls_id into @bonus_coin;
	
	-- neu user chua nghe lan nao thi insert new record vao bang lesson tracker
	
	if(@check_user_listened = 0) 
	then
		INSERT INTO `silly_english`.`lesson_tracker`
			    (`user_id`,
			     `ls_id`)
		VALUES (p_user_id,
			p_ls_id);
			
			-- return update progress success!
			select * from error_code where error_code.`code` = 210;
			
	 else -- neu da nghe roi thi check xem current progress > new progress hay khong, neu co thi update, neu khong thi tra ve khong
		select `lesson_tracker`.`ls_progress` from `lesson_tracker` where `lesson_tracker`.`user_id` = p_user_id and `lesson_tracker`.`ls_id` = p_ls_id into @current_progress;
		
		-- lay ra current lst cua lesson duoc nghe boi user nay
		select `lesson_tracker`.`lst_id` from `lesson_tracker` where `lesson_tracker`.`user_id` = p_user_id AND `lesson_tracker`.`ls_id` = p_ls_id INTO @current_lst_id;
		
		
		if(@current_progress < p_ls_progress) 
		then -- update new progress
				-- check xem lan update nay co phai la lan update cuoi cung cua lesson unit nay hay khong
				select (floor(p_ls_progress / @lesson_tracker_amount) + 1) into @current_listen_time;
				-- lay chi so cua tracker cuoi cung trong lan nghe nay
				select ((@lesson_tracker_amount * @current_listen_time) - 1) into @last_tracker_for_this_time;
				
				-- update progress cho user 
				UPDATE `silly_english`.`lesson_tracker`
				SET `ls_progress` = p_ls_progress
				WHERE `lst_id` = @current_lst_id;
					
				if(p_ls_progress = @last_tracker_for_this_time and @current_listen_time <= @ls_listen_time) -- neu nhu lan update nay la lan cuoi cung thi + coin cho user
				THEN					
					select `user`.`coin` from `user` where `user`.`id` = p_user_id into @current_coin;
					-- cong coin cho user
					UPDATE `silly_english`.`user`
					SET `coin` = @current_coin + @bonus_coin
					WHERE `user_id` = p_user_id;
					-- tra ve ket qua cho client
					select * from error_code where error_code.`code` = 213;
				else
					SELECT * FROM error_code WHERE error_code.`code` = 210;
				end if;
				
				-- neu nhu lan update nay khong phai la last tracker
				if(p_ls_progress < @last_tracker_for_this_time) 
				then
					-- tra ve ket qua cho client
					SELECT * FROM error_code WHERE error_code.`code` = 210;
				end if;
			
		else
				select * from `error_code` where `error_code`.`code` = 211;
		end if;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `update_user_ranking` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_user_ranking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user_ranking`(
	in p_user_id varchar(40)
    )
BEGIN
SELECT `parameter`.`value` 
	FROM `parameter`, `user`
	WHERE user.`user_id` = p_user_id AND `parameter`.`param_id` = user.`chain_for_rank`
	INTO @total_match_of_chain;
	
	SELECT user.`current_battle`
	FROM `user`
	WHERE user.`user_id` = p_user_id
	INTO @current_battle;
	
	IF(@current_battle = @total_match_of_chain) THEN
	
		Set @win_match = 0;
		if(@total_math_of_chain = 1) then
			SELECT	COUNT(*)
			FROM 	battles
			WHERE	((battles.`attacker_id` = p_user_id) 
				OR (battles.`defender_id` = p_user_id)) 
				AND (battles.`battle_status` = 2)
			ORDER BY battles.`date_create` DESC
			LIMIT 1
			INTO @win_match;
		end if;
		
		IF(@total_match_of_chain = 3) THEN
			SELECT	COUNT(*)
			FROM 	battles
			WHERE	((battles.`attacker_id` = p_user_id) 
				OR (battles.`defender_id` = p_user_id)) 
				AND (battles.`battle_status` = 2)
			ORDER BY battles.`date_create` DESC
			LIMIT 3
			INTO @win_match;
		END IF;
		
		IF(@total_match_of_chain = 5) THEN
			SELECT	COUNT(*)
			FROM 	battles
			WHERE	((battles.`attacker_id` = p_user_id) 
				OR (battles.`defender_id` = p_user_id)) 
				AND (battles.`battle_status` = 2)
			ORDER BY battles.`date_create` DESC
			LIMIT 5
			INTO @win_match;
		END IF;
		
		IF(@win_match > (@total_match_of_chain /2)) THEN
			
			CALL increase_level(p_user_id);
		ELSE
			
			CALL decrease_level(p_user_id);
		END IF;
		
	END IF;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
