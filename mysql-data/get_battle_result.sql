DELIMITER $$

CREATE
    /*[DEFINER = { user | CURRENT_USER }]*/
    PROCEDURE `silly_english`.`get_battle_result`
    (
	IN p_user_id VARCHAR(40),
	IN p_battle_id INT(11)
    )
    
    BEGIN
	
	SELECT IF(battles.`attacker_id` = p_user_id, 1, 0) AS checker 
	FROM battles 
	WHERE (battles.`battle_id` = p_battle_id) 
	INTO @checker;
	
	IF(@checker = 1) THEN
	/*for attacker*/
		
	
    END$$

DELIMITER ;