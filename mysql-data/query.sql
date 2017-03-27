DELIMITER $$

USE `silly_english`$$

DROP PROCEDURE IF EXISTS `check_battle_end_time`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_battle_end_time`(
	IN p_battle_id INT(11)
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
	SET @max_time = DATE_ADD(@attacker_begin_time, INTERVAL @max_answer_time MINUTE);
	IF((@max_time - NOW()) < 0)
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
	SET @max_def_time = DATE_ADD(@defender_begin_time, INTERVAL @max_answer_time MINUTE);
	
	/*If over*/
	IF((@max_def_time - NOW()) < 0)
	THEN
		UPDATE battles
		SET battles.`defender_end_time` = @max_def_time
		WHERE battles.`battle_id` = p_battle_id;
		
		UPDATE battle_question
		SET battle_question.`defender_answer` = 6, battle_question.`defender_answer_time` = @max_def_time
		WHERE battle_question.`battle_id`  = p_battle_id AND battle_question.`defender_answer` = 5;
		
		CALL `update_battle_state`(p_battle_id);
	END IF;
END$$

DELIMITER ;