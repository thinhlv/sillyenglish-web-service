<?php
class Arena extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    /*
     * Create battle
     */
    public function create_battle()
    {
        $attacker_id = $this->input->post('attacker_id');
        $defender_id = $this->input->post('defender_id');
        $bet_value = $this->input->post('bet_value');
        $message = $this->input->post('message');
        
        if($attacker_id == '' || $defender_id == '')
        {
            echo 'attacker and defender can not be null';
        }
        else
        {
            $this->load->database();
            $create_battle = "CALL create_battle(?, ?, ?, ?)";
            $result = $this->db->query($create_battle, array('p_attacker_id' => $attacker_id, 'p_defender_id' => $defender_id, 'p_bet_value' => $bet_value, 'p_message' => $message));
            echo json_encode($result->result_array());
            $this->db->close();
        }   
    }
    
    /*
     * Cancel battle
     */
    public function cancel_battle()
    {
        $defender_id = $this->input->post('user_id');
        $battle_id = $this->input->post('battle_id');
        
        $this->load->database();
        $cancel_query = "CALL cancel_battle(?, ?)";
        $result = $this->db->query($cancel_query, array('p_user_id' => $defender_id, 'battle_id' => $battle_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Chose answer
     */
    public function chose_answer()
    {
        $user_id = $this->input->post('user_id');
        $battle_id = $this->input->post('battle_id');
        $question_id = $this->input->post('question_id');
        $chose_answer = $this->input->post('chose_answer');
        
        if($user_id == null
            || $battle_id == null
            || $question_id == null
            || $chose_answer == NULL
            || $user_id == ""
            || $battle_id == ""
            || $question_id == ""
            || $chose_answer == "")
        {
            echo 'missing parameter!';
        }
        else
        {
            $this->load->database();
            $answer = "CALL answer(?, ?, ?, ?)";
            $result = $this->db->query($answer, array
                    (
                        'p_user_id' => $user_id, 
                        'p_battle_id' => $battle_id, 
                        'p_question_id' => $question_id, 
                        'p_chose_answer' => $chose_answer));
            echo json_encode($result->result_array());
            $this->db->close();
        }
    }
    
    /*
     * accept battle
     */
    public function accept_battle()
    {
        $defender_id = $this->input->post('defender_id');
        $battle_id = $this->input->post('battle_id');
        
        if($defender_id == null 
            || $battle_id == null 
            || $defender_id == "" 
            || $battle_id == "")
        {
            echo 'battle id and defender id can not be empty!';
        }
        else
        {
            $this->load->database();
            $accept_battle = "CALL accept_battle(?, ?)";
            $result = $this->db->query($accept_battle, array('p_user_id' => $defender_id, 'p_battle_id' => $battle_id));
            echo json_encode($result->result_array());
            $this->db->close();
        }
    }
    
    /*
     * user's battle chains
     */
    public function get_battle_chains()
    {
        $user_id = $this->input->post('user_id');
        if($user_id == null || $user_id == "")
        {
            echo 'user id can not be empty!';
        }
        else
        {
            $this->load->database();
            $battle_chains = "CALL get_battle_chains(?)";
            $result = $this->db->query($battle_chains, array('p_user_id' => $user_id));
            $chains = $result->result_array();
            foreach ($chains as &$row)
            {
                $victory_id = &$row['victory_id'];
                if(strcmp($victory_id, $user_id) == 0)
                {
                    $row['victory_id'] = "1";
                }
                else 
                    if(strcmp($victory_id, "draw") == 0)
                {
                    $row['victory_id'] = "0";
                }
                else
                {
                    $row['victory_id'] = "-1";
                }
            }
            
            echo json_encode($chains);
            $this->db->close();
        }
    }
    
    /*
     * Check battle over time
     */
    private function check_battle_over_time($battle_id)
    {
        if($user_id == null 
            || $battle_id == null
            || $user_id == ""
            || $battle_id == "")
        {
            return;
        }
        
        $this->load->database();
        $checker = "CALL check_battle_end_time(?)";
        $this->db->query($checker, array('p_battle_id' => $battle_id));
        $this->db->close();
    }
    
    /*
     * Find enemy
     */
    public function find_battle()
    {
		//get parameter
        $user_id = $this->input->post('user_id');
		$current_enemy_id = $this->input->post('current_enemy_id');
		
		//Query enemy to start battle.
        $this->load->database();
		$finder = "CALL find_battle(?, ?)";
		$result = $this->db->query($finder, array('p_user_id' => $user_id, 'p_current_enemy' => $current_enemy_id));
		echo json_encode($result->result_array());
		$this->db->close();
    }
    
    /*
     * Get battle result
     */
    public function get_battle_result()
    {
        $user_id = $this->input->post('user_id');
        $battle_id = $this->input->post('battle_id');
        
        if($user_id == null 
                || $battle_id == null
                || $user_id == ""
                || $battle_id == "")
        {
            echo "missing parameter!";
        }
        else
        {
            $this->load->database();
            $battle_result = "CALL get_battle_result(?, ?)";
            $result = $this->db->query($battle_result, array('p_user_id' => $user_id, 'p_battle_id' => $battle_id));
            echo json_encode($result->result_array());
            $this->db->close();
        }
    }
    
    /*
     * Get duel enemy
     */
    public function get_enemy_duel()
    {
        $user_id = $this->input->post('user_id');
        $battle_id = $this->input->post('battle_id');
        
        $this->load->database();
        $enemy_duel = "CALL get_enemy_duel(?, ?)";
        $result = $this->db->query($enemy_duel, array('p_user_id' => $user_id, 'p_battle_id' => $battle_id));
        echo json_encode($result->result_array());
    }
    
    public function get_battle_history()
    {   
        $user_id = $this->input->post('user_id');   
        $this->load->database();
        $enemy_duel = "CALL get_battle_history(?)";
        $result = $this->db->query($enemy_duel, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
    }
    
    /*
     * Gets enemy information from enemy's identifier.
     */
    public function find_enemy_with_identifier()
    {
        $user_id = $this->input->post('user_id');  
        $enemy_id = $this->input->post('enemy_id');
        $this->load->database();
        $result_enemy = "CALL find_enemy_with_identifier(?, ?)";
        
        $result = $this->db->query($result_enemy, array('p_user_id' => $user_id, 'p_enemy_id' => $enemy_id));
        echo json_encode($result->result_array());
    }
}
