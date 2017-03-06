-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 06, 2017 at 04:32 PM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `silly_english`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `answer` (IN `p_user_id` INT(11), IN `p_battle_id` INT(11), IN `p_question_id` INT(11), IN `p_chose_answer` INT(11))  BEGIN
		/*Check if current user are attacker or defender*/
		SELECT IF(battles.`attacker_id` = p_user_id, 1, 0) AS checker FROM battles WHERE (battles.`battle_id` = p_battle_id) into @checker;
		if(@checker = 1) then	
			/*for attacker*/
			/*update only available for first time(current answer = 5: 'NONE')*/
			update battle_question
			set battle_question.`attacker_answer` = p_chose_answer
			where (`battle_question`.`battle_id` = p_battle_id && `battle_question`.`question_id` = p_question_id && `battle_question`.`attacker_answer` = 5);
		else
			/*for defender*/
			/*update only available for first time (current answer = 5: 'NONE')*/
			UPDATE battle_question
			SET battle_question.`defender_answer` = p_chose_answer
			WHERE (`battle_question`.`battle_id` = p_battle_id && `battle_question`.`question_id` = p_question_id && `battle_question`.`defender_answer` = 5);
		
		end if;
		
		SELECT IF(questions.`true_answer` = p_chose_answer, 1, 0) AS checker FROM `questions` WHERE (`questions`.`question_id` = p_question_id);
		
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_battle` (IN `p_attacker_id` VARCHAR(40), IN `p_defender_id` VARCHAR(40))  BEGIN
	
	INSERT INTO battles (attacker_id, defender_id) VALUES(p_attacker_id, p_defender_id);
	select LAST_INSERT_ID() into @lastid ;
	INSERT INTO battle_question (battle_id, question_id) (SELECT @lastid AS battle_id, question_id FROM questions ORDER BY RAND() LIMIT 5);
	select * from battle_question where battle_id = @lastid;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_info` (IN `p_user_id` VARCHAR(40))  BEGIN
		select `user_id`, `name`, `coin`, `rank`, `level`, `win_match`, `total_match`, `avatar_url` from `user`
		where user_id = p_user_id;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `answer_key`
--

CREATE TABLE `answer_key` (
  `answer_key_id` int(11) NOT NULL,
  `details` tinytext CHARACTER SET utf8 COLLATE utf8_vietnamese_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `answer_key`
--

INSERT INTO `answer_key` (`answer_key_id`, `details`) VALUES
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'NONE');

-- --------------------------------------------------------

--
-- Table structure for table `battles`
--

CREATE TABLE `battles` (
  `battle_id` int(11) NOT NULL,
  `attacker_id` varchar(40) COLLATE utf8_vietnamese_ci NOT NULL,
  `defender_id` varchar(40) COLLATE utf8_vietnamese_ci NOT NULL,
  `battle_status` int(11) DEFAULT '1',
  `date_create` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `battle_question`
--

CREATE TABLE `battle_question` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `battle_id` int(11) NOT NULL,
  `attacker_answer` int(11) NOT NULL DEFAULT '5',
  `defender_answer` int(11) NOT NULL DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `battle_status`
--

CREATE TABLE `battle_status` (
  `status_id` int(11) NOT NULL COMMENT 'The status''s id',
  `detail` tinytext COLLATE utf8_vietnamese_ci NOT NULL COMMENT 'The status detail'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `battle_status`
--

INSERT INTO `battle_status` (`status_id`, `detail`) VALUES
(1, 'waiting'),
(2, 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `lesson`
--

CREATE TABLE `lesson` (
  `ls_id` int(11) NOT NULL COMMENT 'Listening Unit ID',
  `ls_title` varchar(200) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Listening Unit Title',
  `ls_level` int(11) DEFAULT NULL COMMENT 'Level of Listening Unit',
  `ls_chapter` int(11) DEFAULT NULL COMMENT 'Chapter Number of Listening Unit',
  `ls_source` int(11) DEFAULT NULL COMMENT 'Source of Infomation',
  `ls_price` int(11) DEFAULT NULL COMMENT 'Price of Unit',
  `ls_exp` int(11) DEFAULT NULL COMMENT 'Maximum Exp of Unit',
  `ls_max_hear_times` int(11) DEFAULT NULL COMMENT 'Max hear times',
  `ls_url` varchar(200) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Link of Listening file',
  `ls_note` varchar(500) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'User Note for Unit file'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `lesson`
--

INSERT INTO `lesson` (`ls_id`, `ls_title`, `ls_level`, `ls_chapter`, `ls_source`, `ls_price`, `ls_exp`, `ls_max_hear_times`, `ls_url`, `ls_note`) VALUES
(1, 'A Ghost in Love and Other Plays', 1, 14, 0, 140, 140, 2, 'null _url', 'note'),
(2, 'Goodbye, Mr. Hollywood', 1, 8, 0, 80, 80, 2, 'null _url', 'note');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_source`
--

CREATE TABLE `lesson_source` (
  `source_id` int(11) NOT NULL,
  `source_name` varchar(100) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `source_image_url` varchar(100) COLLATE utf8_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `lesson_source`
--

INSERT INTO `lesson_source` (`source_id`, `source_name`, `source_image_url`) VALUES
(1, 'Oxford BookWorm', 'oxford bookworm'),
(2, 'Podcast In English', 'Podcast In English'),
(3, 'BBC English', 'BBC ENGLISH');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_unit`
--

CREATE TABLE `lesson_unit` (
  `lu_id` int(11) NOT NULL COMMENT 'Lesson Unit Id',
  `lu_name` varchar(100) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Lesson Unit Name',
  `lu_sequence` int(11) DEFAULT NULL COMMENT 'Lesson Unit Sequence Number',
  `ls_id` int(11) DEFAULT NULL COMMENT 'Reference to Lesson',
  `lu_max_hear` int(11) DEFAULT NULL COMMENT 'Lesson Unit Max Hear Time',
  `lu_url` varchar(50) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'Lesson Unit Url',
  `lu_exp` int(11) DEFAULT NULL COMMENT 'Exp get every time',
  `lu_note` text COLLATE utf8_vietnamese_ci COMMENT 'Lesson Unit Note',
  `lu_type` int(11) DEFAULT NULL COMMENT 'Type of Unit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `lv_id` int(11) NOT NULL COMMENT 'Level ID',
  `lv_exp_point` int(11) DEFAULT NULL COMMENT 'Exp must have to reach this level',
  `lv_leter` char(1) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'The letter of Level',
  `lv_metal_kind` int(11) DEFAULT NULL COMMENT 'Metal Kind of Level'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `question_type` int(11) DEFAULT NULL,
  `question_content` text COLLATE utf8_vietnamese_ci,
  `answer_a` text COLLATE utf8_vietnamese_ci,
  `answer_b` text COLLATE utf8_vietnamese_ci,
  `audio_source` text COLLATE utf8_vietnamese_ci,
  `true_answer` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `question_type`, `question_content`, `answer_a`, `answer_b`, `audio_source`, `true_answer`) VALUES
(1, 1, 'What are they talking about?', 'A movie', 'A film', 'http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991', 1),
(2, 2, 'This is a reading question.', 'This is answer A', 'This is answer B', NULL, 2),
(3, 1, 'This is a listening question.', 'Answer A...', 'Answer B...', 'http://zmp3-mp3-s1.zmp3-vtnhcm-1.za.zdn.vn/733db67cbd3854660d29/8356612300525677950?key=6TMyDmH3yfbpxB5M7tuq9Q&expires=1488043991', 2),
(4, 2, 'reading reading reading', 'The answer a... kaka', 'bbbbbbbbb', NULL, 2),
(5, 1, 'this is 5th question', 'Answer for question 5 - A', 'Answer for question 5 - B', NULL, 1),
(6, 2, 'test test', 'haha', 'hehe', '\"mp3 link!\"', 1);

-- --------------------------------------------------------

--
-- Table structure for table `question_type`
--

CREATE TABLE `question_type` (
  `type_id` int(11) NOT NULL,
  `details` tinytext COLLATE utf8_vietnamese_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `question_type`
--

INSERT INTO `question_type` (`type_id`, `details`) VALUES
(1, 'listening'),
(2, 'reading');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT 'the auto increment id',
  `user_id` varchar(40) COLLATE utf8_vietnamese_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_vietnamese_ci NOT NULL COMMENT 'User Name',
  `facebook_id` varchar(20) COLLATE utf8_vietnamese_ci DEFAULT NULL COMMENT 'User''s Facebook Id',
  `coin` int(11) DEFAULT NULL COMMENT 'User Coin',
  `rank` int(11) DEFAULT NULL COMMENT 'Exp of User',
  `level` int(11) DEFAULT NULL COMMENT 'Level of User',
  `win_match` int(11) DEFAULT NULL COMMENT 'Win Match Number of User',
  `total_match` int(11) DEFAULT NULL COMMENT 'Total Match Number of User',
  `avatar_url` text COLLATE utf8_vietnamese_ci COMMENT 'User''s avatar url - from facebook or default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `user_id`, `name`, `facebook_id`, `coin`, `rank`, `level`, `win_match`, `total_match`, `avatar_url`) VALUES
(1, 'b1d7dd8f11b32c9a0f66ea3c4416ca7f0aa02c80', 'sillyenglish', NULL, 1000, 2000, 2, 10, 20, 'http://images.google.com/folder/125a1241a/gks.jpg'),
(2, '7817469c39d0539775a545fd4357e671414fcbf3', 'Huỳnh Khoa Vin', '728517987296641', 1222, 3333, 4, 54, 222, 'http://images.google.com/folder/125a1241a/gks.jpg'),
(3, 'bc76c6649b2b7ab5b6d6f19292c4de33173c5ea7', 'OatOal', '100006561107068', 13025, 52, 5, 10, 30, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_lesson`
--

CREATE TABLE `user_lesson` (
  `us_id` int(11) DEFAULT NULL COMMENT 'user_id',
  `ls_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answer_key`
--
ALTER TABLE `answer_key`
  ADD PRIMARY KEY (`answer_key_id`),
  ADD KEY `answer_key_id` (`answer_key_id`);

--
-- Indexes for table `battles`
--
ALTER TABLE `battles`
  ADD PRIMARY KEY (`battle_id`),
  ADD KEY `attacker_id` (`attacker_id`),
  ADD KEY `defender_id` (`defender_id`),
  ADD KEY `battle_status` (`battle_status`);

--
-- Indexes for table `battle_question`
--
ALTER TABLE `battle_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `battle_id` (`battle_id`),
  ADD KEY `battle_question_ibfk_3` (`attacker_answer`),
  ADD KEY `battle_question_ibfk_4` (`defender_answer`);

--
-- Indexes for table `battle_status`
--
ALTER TABLE `battle_status`
  ADD PRIMARY KEY (`status_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`ls_id`);

--
-- Indexes for table `lesson_source`
--
ALTER TABLE `lesson_source`
  ADD PRIMARY KEY (`source_id`);

--
-- Indexes for table `lesson_unit`
--
ALTER TABLE `lesson_unit`
  ADD PRIMARY KEY (`lu_id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`lv_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `fk_question_type` (`question_type`),
  ADD KEY `true_answer` (`true_answer`);

--
-- Indexes for table `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`,`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `battles`
--
ALTER TABLE `battles`
  MODIFY `battle_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `battle_question`
--
ALTER TABLE `battle_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `battle_status`
--
ALTER TABLE `battle_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The status''s id', AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `lesson`
--
ALTER TABLE `lesson`
  MODIFY `ls_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Listening Unit ID', AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `lesson_source`
--
ALTER TABLE `lesson_source`
  MODIFY `source_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
  MODIFY `lv_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Level ID';
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `question_type`
--
ALTER TABLE `question_type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'the auto increment id', AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `battles`
--
ALTER TABLE `battles`
  ADD CONSTRAINT `battles_ibfk_1` FOREIGN KEY (`battle_status`) REFERENCES `battle_status` (`status_id`);

--
-- Constraints for table `battle_question`
--
ALTER TABLE `battle_question`
  ADD CONSTRAINT `battle_question_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`),
  ADD CONSTRAINT `battle_question_ibfk_2` FOREIGN KEY (`battle_id`) REFERENCES `battles` (`battle_id`),
  ADD CONSTRAINT `battle_question_ibfk_3` FOREIGN KEY (`attacker_answer`) REFERENCES `answer_key` (`answer_key_id`),
  ADD CONSTRAINT `battle_question_ibfk_4` FOREIGN KEY (`defender_answer`) REFERENCES `answer_key` (`answer_key_id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_question_type` FOREIGN KEY (`question_type`) REFERENCES `question_type` (`type_id`),
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`true_answer`) REFERENCES `answer_key` (`answer_key_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
