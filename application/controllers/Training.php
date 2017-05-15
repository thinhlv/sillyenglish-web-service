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
        $this->load->database();
            $query = "CALL buy_lesson(?,?)";
            $result = $this->db->query($query, array('p_user_id' => $user_id, 'p_lesson_id' => $lesson_id));
            echo json_encode($result->result_array());
            $this->db->close();
    }
    public function getlesson(){
        $this->load->database();
            $query = "CALL get_lesson_list()";
            $result = $this->db->query($query);
            echo json_encode(array('data'=>$result->result_array()));
            $this->db->close();
    }
    public function get_lesson_unit(){
        $ls_id = $this->input->post('ls_id');
        $this->load->database();
            $query = "CALL get_lesson_unit(?)";
            $result = $this->db->query($query,array('p_lesson_id' => $ls_id));
            echo json_encode($result->result_array());
            $this->db->close();
    }
    public function check_lesson_was_bought(){
        $user_id = $this->input->post('user_id');
        $lesson_id = $this->input->post('ls_id');
        $this->load->database();
            $query = "CALL check_lesson_was_bought(?,?)";
            $result = $this->db->query($query,array('p_user_id' => $user_id,'p_ls_id' => $lesson_id));
            echo json_encode($result->result_array());
            $this->db->close();
    }
    public function update_lesson_progress(){
        $user_id = $this->input->post('user_id');
        $lu_id = $this->input->post('lu_id');
        $this->load->database();
            $query = "CALL update_lesson(?,?)";
            $result = $this->db->query($query,array('p_user_id' => $user_id,'p_lu_id' => $lu_id));
            echo json_encode($result->result_array());
            $this->db->close();
    }
    public function get_lesson_tracker(){
        $user_id = $this->input->post('user_id');
        $ls_id = $this->input->post('ls_id');
        $this->load->database();
            $query = "CALL get_lesson_tracker(?,?)";
            $result = $this->db->query($query,array('p_user_id' => $user_id,'p_ls_id' => $ls_id));
            echo json_encode($result->result_array());
            $this->db->close();
    }
}