<?php
class Arena extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function create_battle()
    {
        $attacker_id = $this->input->post('attacker_id');
        $defender_id = $this->input->post('defender_id');
        
        if($attacker_id == '' || $defender_id == '')
        {
            echo 'attacker and defender can not be null';
        }
        else
        {
            $this->load->database();
            $create_battle = "CALL create_battle(?, ?)";
            $result = $this->db->query($create_battle, array('p_attacker_id' => $attacker_id, 'p_defender_id' => $defender_id));
            echo json_encode(array('data'=>$result->result_array()));
            $this->db->close();
        }   
    }
    
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
            echo json_encode($result->first_row());
            $this->db->close();
        }
    }
    
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
            echo json_encode(array('data' => $result->result_array()));
            $this->db->close();
        }
    }
}
