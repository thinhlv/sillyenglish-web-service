/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.1.21-MariaDB : Database - silly_english
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

insert  into `answer_key`(`answer_key_id`,`details`) values (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'NONE'),(6,'OVER');

/*Table structure for table `attach_gifts` */

DROP TABLE IF EXISTS `attach_gifts`;

CREATE TABLE `attach_gifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_id` int(11) DEFAULT NULL,
  `gift_type` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battle_question` */

insert  into `battle_question`(`id`,`question_id`,`battle_id`,`attacker_answer`,`defender_answer`,`attacker_answer_time`,`defender_answer_time`) values (249,6,37,2,1,'2017-03-25 16:02:38','2017-03-25 16:03:14'),(250,3,37,1,1,'2017-03-25 16:02:41','2017-03-25 16:03:16'),(251,4,37,1,2,'2017-03-25 16:02:43','2017-03-25 16:03:18'),(252,2,37,2,1,'2017-03-25 16:02:45','2017-03-25 16:03:20'),(253,5,37,2,2,'2017-03-25 16:02:47','2017-03-25 16:03:21');

/*Table structure for table `battle_status` */

DROP TABLE IF EXISTS `battle_status`;

CREATE TABLE `battle_status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The status''s id',
  `detail` tinytext COLLATE utf8_unicode_ci NOT NULL COMMENT 'The status detail',
  PRIMARY KEY (`status_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battle_status` */

insert  into `battle_status`(`status_id`,`detail`) values (1,'waiting'),(2,'completed');

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
  PRIMARY KEY (`battle_id`),
  KEY `attacker_id` (`attacker_id`),
  KEY `defender_id` (`defender_id`),
  KEY `battle_status` (`battle_status`),
  CONSTRAINT `battles_ibfk_1` FOREIGN KEY (`battle_status`) REFERENCES `battle_status` (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `battles` */

insert  into `battles`(`battle_id`,`attacker_id`,`defender_id`,`battle_status`,`date_create`,`attacker_begin_time`,`defender_begin_time`,`attacker_end_time`,`defender_end_time`,`victory_id`) values (37,'b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','7817469c39d0539775a545fd4357e671414fcbf3',2,'2017-03-25 16:02:17','2017-03-25 16:02:17','2017-03-25 16:02:57','2017-03-25 16:02:47','2017-03-25 16:04:10','7817469c39d0539775a545fd4357e671414fcbf3');

/*Table structure for table `error_code` */

DROP TABLE IF EXISTS `error_code`;

CREATE TABLE `error_code` (
  `error_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` int(11) NOT NULL,
  `details` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`error_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `error_code` */

insert  into `error_code`(`error_id`,`code`,`details`) values (1,200,'completed'),(2,201,'not completed'),(3,202,'battle closed'),(4,203,'battle not found');

/*Table structure for table `gift_type` */

DROP TABLE IF EXISTS `gift_type`;

CREATE TABLE `gift_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `detail` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `gift_type` */

insert  into `gift_type`(`id`,`type`,`detail`) values (1,'coin','the coin'),(2,'lession','the lession id');

/*Table structure for table `lesson` */

DROP TABLE IF EXISTS `lesson`;

CREATE TABLE `lesson` (
  `ls_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Listening Unit ID',
  `ls_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Listening Unit Title',
  `ls_level` int(11) DEFAULT NULL COMMENT 'Level of Listening Unit',
  `ls_chapter` int(11) DEFAULT NULL COMMENT 'Chapter Number of Listening Unit',
  `ls_source` int(11) DEFAULT NULL COMMENT 'Source of Infomation',
  `ls_price` int(11) DEFAULT NULL COMMENT 'Price of Unit',
  `ls_exp` int(11) DEFAULT NULL COMMENT 'Maximum Exp of Unit',
  `ls_max_hear_times` int(11) DEFAULT NULL COMMENT 'Max hear times',
  `ls_url` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Link of Listening file',
  `ls_note` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'User Note for Unit file',
  PRIMARY KEY (`ls_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson` */

insert  into `lesson`(`ls_id`,`ls_title`,`ls_level`,`ls_chapter`,`ls_source`,`ls_price`,`ls_exp`,`ls_max_hear_times`,`ls_url`,`ls_note`) values (1,'A Ghost in Love and Other Plays',1,14,0,140,140,2,'null _url','note'),(2,'Goodbye, Mr. Hollywood',1,8,0,80,80,2,'null _url','note');

/*Table structure for table `lesson_source` */

DROP TABLE IF EXISTS `lesson_source`;

CREATE TABLE `lesson_source` (
  `source_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source_image_url` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_source` */

insert  into `lesson_source`(`source_id`,`source_name`,`source_image_url`) values (1,'Oxford BookWorm','oxford bookworm'),(2,'Podcast In English','Podcast In English'),(3,'BBC English','BBC ENGLISH');

/*Table structure for table `lesson_unit` */

DROP TABLE IF EXISTS `lesson_unit`;

CREATE TABLE `lesson_unit` (
  `lu_id` int(11) NOT NULL COMMENT 'Lesson Unit Id',
  `lu_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Lesson Unit Name',
  `lu_sequence` int(11) DEFAULT NULL COMMENT 'Lesson Unit Sequence Number',
  `ls_id` int(11) DEFAULT NULL COMMENT 'Reference to Lesson',
  `lu_max_hear` int(11) DEFAULT NULL COMMENT 'Lesson Unit Max Hear Time',
  `lu_url` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Lesson Unit Url',
  `lu_exp` int(11) DEFAULT NULL COMMENT 'Exp get every time',
  `lu_note` text COLLATE utf8_unicode_ci COMMENT 'Lesson Unit Note',
  `lu_type` int(11) DEFAULT NULL COMMENT 'Type of Unit',
  PRIMARY KEY (`lu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lesson_unit` */

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

/*Table structure for table `mail` */

DROP TABLE IF EXISTS `mail`;

CREATE TABLE `mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `date_create` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `mail` */

insert  into `mail`(`id`,`user_id`,`content`,`date_create`) values (1,'b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','Here are you reward with you ranking!','2017-03-25 17:12:23');

/*Table structure for table `parameter` */

DROP TABLE IF EXISTS `parameter`;

CREATE TABLE `parameter` (
  `param_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) DEFAULT NULL,
  `detais` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `parameter` */

insert  into `parameter`(`param_id`,`value`,`detais`) values ('bronze_chain',1,'Battles number of broze chains (to increase level)'),('gold_chain',5,'Battles number of gold chains need to increase level'),('max_answer_time',5,'Max answer time (Minute)'),('sliver_chain',3,'Battles number of sliver chains need to increase level');

/*Table structure for table `question_type` */

DROP TABLE IF EXISTS `question_type`;

CREATE TABLE `question_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `details` tinytext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `question_type` */

insert  into `question_type`(`type_id`,`details`) values (1,'listening'),(2,'reading');

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

insert  into `questions`(`question_id`,`question_type`,`question_content`,`answer_a`,`answer_b`,`audio_source`,`true_answer`) values (1,1,'What are they talking about?','A movie','A film','http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991',1),(2,2,'This is a reading question.','This is answer A','This is answer B',NULL,2),(3,1,'This is a listening question.','Answer A...','Answer B...','http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991',2),(4,2,'reading reading reading','The answer a... kaka','bbbbbbbbb',NULL,2),(5,1,'this is 5th question','Answer for question 5 - A','Answer for question 5 - B',NULL,1),(6,2,'test test','haha','hehe','\"mp3 link!\"',1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the auto increment id',
  `user_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'User Name',
  `facebook_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'User''s Facebook Id',
  `coin` int(11) DEFAULT NULL COMMENT 'User Coin',
  `rank` int(11) DEFAULT NULL COMMENT 'Exp of User',
  `level` int(11) DEFAULT NULL COMMENT 'Level of User',
  `win_match` int(11) DEFAULT NULL COMMENT 'Win Match Number of User',
  `total_match` int(11) DEFAULT NULL COMMENT 'Total Match Number of User',
  `avatar_url` text COLLATE utf8_unicode_ci COMMENT 'User''s avatar url - from facebook or default',
  `chain_for_rank` varchar(40) COLLATE utf8_unicode_ci DEFAULT 'bronze_chain' COMMENT 'Current chains to increase level',
  `current_battle` int(11) DEFAULT '0' COMMENT 'Current battles of chains (must be done)',
  PRIMARY KEY (`id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`user_id`,`name`,`facebook_id`,`coin`,`rank`,`level`,`win_match`,`total_match`,`avatar_url`,`chain_for_rank`,`current_battle`) values (1,'b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80','sillyenglish',NULL,1000,2000,2,10,20,'http://images.google.com/folder/125a1241a/gks.jpg','bronze_chain',0),(2,'7817469c39d0539775a545fd4357e671414fcbf3','Huỳnh Khoa Vin','728517987296641',1222,3333,4,54,222,'http://images.google.com/folder/125a1241a/gks.jpg','bronze_chain',0),(3,'bc76c6649b2b7ab5b6d6f19292c4de33173c5ea7','OatOal','100006561107068',13025,52,5,10,30,NULL,'bronze_chain',0);

/*Table structure for table `user_lesson` */

DROP TABLE IF EXISTS `user_lesson`;

CREATE TABLE `user_lesson` (
  `us_id` int(11) DEFAULT NULL COMMENT 'user_id',
  `ls_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `user_lesson` */

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
	
	/*Only add battle to chains if battle has done*/
	if(@battle_status = 2) then
		
		SELECT `parameter`.`value` 
		FROM `parameter`
		WHERE `parameter`.`param_id` = user.`chain_for_rank`
		INTO @total_match_of_chain;
		
		SELECT user.`current_battle`
		FROM `user`
		WHERE user.`user_id` = p_user_id
		INTO @current_battle;
		/*Only add battle to chain if current battle < total battle of chain*/
		IF(@current_battle < @total_match_of_chain) THEN
			SET @current_battle = @current_battle + 1;
			UPDATE `user`
			SET user.`current_battle` = @current_battle
			WHERE user.`user_id` = p_user_id;		
		END IF;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `answer` */

/*!50003 DROP PROCEDURE IF EXISTS  `answer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `answer`(IN p_user_id int(11), in p_battle_id int(11), in p_question_id int(11), in p_chose_answer int(11))
BEGIN
		select battles.`battle_status` from battles where battles.`battle_id` = p_battle_id into @status;
		if(@status = 1) then
			CALL check_battle_end_time(p_battle_id);
			
			/*Check if current user are attacker or defender*/
			SELECT IF(battles.`attacker_id` = p_user_id, 1, 0) AS checker FROM battles WHERE (battles.`battle_id` = p_battle_id) INTO @checker;
			IF(@checker = 1) THEN	
				/*for attacker*/
				/*update only available for first time(current answer = 5: 'NONE')*/
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
				/*for defender*/
				/*update only available for first time (current answer = 5: 'NONE')*/
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

/* Procedure structure for procedure `check_battle_end_time` */

/*!50003 DROP PROCEDURE IF EXISTS  `check_battle_end_time` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `check_battle_end_time`(
	in p_battle_id int(11)
)
BEGIN
	/*Find max answer time on parameter table*/
	SELECT `parameter`.`value` 
	FROM parameter 
	WHERE `parameter`.`param_id` = "max_answer_time" 
	INTO @max_answer_time;	
	
	/*Find attacker begin time to cal how much times have been use*/
	SELECT battles.`attacker_begin_time` 
	FROM battles 
	WHERE battles.`battle_id` = p_battle_id 
	INTO @attacker_begin_time;
	
	/*If over*/
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
		
	/*If find defender begin time to cal how much times have been use*/
	SELECT battles.`defender_begin_time` 
	FROM battles 
	WHERE battles.`battle_id` = p_battle_id 
	INTO @defender_begin_time;
	SET @max_def_time = unix_timestamp(DATE_ADD(@defender_begin_time, INTERVAL @max_answer_time MINUTE));
	
	/*If over*/
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

/* Procedure structure for procedure `create_battle` */

/*!50003 DROP PROCEDURE IF EXISTS  `create_battle` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `create_battle`(IN p_attacker_id varchar(40), IN p_defender_id varchar(40))
BEGIN
	INSERT INTO battles (attacker_id, defender_id) VALUES(p_attacker_id, p_defender_id);
	select LAST_INSERT_ID() into @lastid ;
	INSERT INTO battle_question (battle_id, question_id) (SELECT @lastid AS battle_id, question_id FROM questions ORDER BY RAND() LIMIT 5);
	
	select battle_question.`battle_id`, questions.`question_id`, questions.`question_content`, questions.`audio_source`, 
		questions.`question_type`, `questions`.`answer_a`, questions.`answer_b`
	 from battle_question, questions 
	 where battle_id = @lastid and questions.`question_id` = battle_question.`question_id`;
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
		/*for attacker*/
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
	
		/*for defender*/
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

/* Procedure structure for procedure `get_mails` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_mails` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_mails`(	
	in p_user_id varchar(40)
    )
BEGIN
	select * from mail where mail.`user_id` = p_user_id;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `get_user_info` */

/*!50003 DROP PROCEDURE IF EXISTS  `get_user_info` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_info`(IN p_user_id VARCHAR(40))
BEGIN
		select user.`user_id`, user.`name`, user.`avatar_url`, user.`level`, user.`rank`, user.`win_match`, user.`total_match`, 
		user.`chain_for_rank`, user.`coin`, user.`chain_for_rank`, user.`current_battle`, `parameter`.`value` as chain_matchs
		from `user`, `parameter`
		where user_id = p_user_id and `parameter`.`param_id` = user.`chain_for_rank`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `global_ranking` */

/*!50003 DROP PROCEDURE IF EXISTS  `global_ranking` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `global_ranking`()
BEGIN
	select user.`name`, user.`rank`, user.`level`, user.`win_match`, user.`total_match`, user.`avatar_url` 
	from `user`
	order BY user.`rank` ASC
	limit 50;
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

/* Procedure structure for procedure `sent_mail` */

/*!50003 DROP PROCEDURE IF EXISTS  `sent_mail` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sent_mail`(
	in p_receiver varchar(40),
	in p_content varchar(256)
    )
BEGIN
	
	INSERT INTO mail (mail.`user_id`, mail.`content`) VALUES(p_receiver, p_content);
	
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
	/*If battle has completed*/
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
			
			/*Attacker win*/
			UPDATE battles 
			SET battles.`victory_id` = battles.`attacker_id`
			WHERE battles.`battle_id` = p_battle_id;
			
		END IF;
		
		IF(@total_attacker_answer < @total_defender_answer) THEN
			/*Defender win*/
			UPDATE battles 
			SET battles.`victory_id` = battles.`defender_id`
			WHERE battles.`battle_id` = p_battle_id;
		END IF;
			
		IF(@total_attacker_answer = @total_defender_answer) THEN
			/*If attacker true answer equal defender true answer, we compare total answer time*/
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
				/*Attacker win*/
				UPDATE battles 
				SET battles.`victory_id` = battles.`attacker_id`
				WHERE battles.`battle_id` = p_battle_id;
			END IF;
			
			IF(@attacker_time < @defender_time) THEN 
				/*Attacker win*/
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
	
	/*Set battle status to completed*/
	IF(@status_checker = 0) THEN
	
		UPDATE battles
		SET battles.`battle_status` = 2
		WHERE battles.`battle_id` = p_battle_id;
		
		/*Set battle result*/
		CALL update_battle_result(p_battle_id);
		/*Update user ranking when completed battle*/
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
			/*Increase level*/
			CALL increase_level(p_user_id);
		ELSE
			/*Decrease level*/
			CALL decrease_level(p_user_id);
		END IF;
		
	END IF;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
