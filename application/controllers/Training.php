<?php
class Training extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function getpopolarlesson()
    {
            $this->load->database();
            $query = "CALL get_popular_lesson()";
            $result = $this->db->query($query);
                echo json_encode(array('data'=>$result->result_array()));
            $this->db->close();
    }
    public function buylesson(){
        
        $user_id = $this->input->post('user_id');
        $lesson_id = $this->input->post('ls_id');
        if($user_id == '' || $lesson_id == '')
        {
            echo 'User ID and Lesson ID cant be null';
        }
        else
        {
        $this->load->database();
            $query = "CALL buy_lesson(?,?)";
            $result = $this->db->query($query, array('p_user_id' => $user_id, 'p_lesson_id' => $lesson_id));
            echo json_encode($result->first_row());
            $this->db->close();
        }
        
    }
}