<?php
class Training extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function get_popular_lesson() {
        $this->load->database();
        $limit_amount = $this->input->post('limit_amount');

        $query = "CALL get_popular_lesson(?)";
        $result = $this->db->query($query, array('p_limit_amount' => $limit_amount));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_daily_lesson() {
        $this->load->database();

        $query = "CALL get_daily_lesson()";
        $result = $this->db->query($query);
        echo json_encode($result->result_array());
        $this->db->close();
    }

    public function get_rating_lesson() {
        $this->load->database();
        $limit_amount = $this->input->post('limit_amount');

        $query = "CALL get_rating_lesson(?)";
        $result = $this->db->query($query, array('p_limit_amount' => $limit_amount));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_user_lesson() {
        $this->load->database();
        $user_id = $this->input->post('user_id');

        $query = "CALL get_user_lesson(?)";
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
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
        $ls_id = $this->input->post('ls_id');
        $ls_progress = $this->input->post('ls_progress');
        $this->load->database();
            $query = "CALL update_lesson_progress(?,?,?)";
            $result = $this->db->query($query,array('p_user_id' => $user_id,'p_ls_id' => $ls_id,'p_ls_progress'=>$ls_progress));
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
    public function get_first_lesson_unit() {
        $this->load->database();
        $ls_id = $this->input->post('ls_id');
        $query = "CALL get_first_lesson_unit(?)";
        $result = $this->db->query($query, array('p_ls_id' => $ls_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function rating_lesson(){
        $this->load->database();
        $ls_id = $this->input->post('ls_id');
        $rating_point = $this->input->post('rating_point');
        $query = "CALL rating_lesson(?,?)";
        $result = $this->db->query($query, array('p_ls_id' => $ls_id, 'p_rating_point'=>$rating_point));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_all_source_unit() {
        $this->load->database();
        $query = "CALL get_all_source_unit()";
        $result = $this->db->query($query);
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_list_source() {
        $this->load->database();
        $query = "CALL get_list_source()";
        $result = $this->db->query($query);
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_lesson_by_category() {
        $this->load->database();
        $source_unit = $this->input->post('source_unit');
        $query = "CALL get_lesson_by_category(?)";
        $result = $this->db->query($query, array('p_source_unit' => $source_unit));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_list_channel(){
        $this->load->database();
        $query = "CALL get_list_channel()";
        $result = $this->db->query($query);
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function update_progress_chart(){
        $this->load->database();
        
        $user_id = $this->input->post('user_id');
        
        $query = "CALL update_progress_chart(?)";
        
        
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        
        echo json_encode($result->result_array());
        
        $this->db->close();
    }
    public function get_chart_progress(){
        $this->load->database();
        
        $user_id = $this->input->post('user_id');
        //
        $query = "CALL get_chart_progress(?)";
        
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        
        echo json_encode($result->result_array());
        
        $this->db->close();
    }
}