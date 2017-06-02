<?php
class Social extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    public function post_new_notification(){
            $user_id = $this->input->post('user_id');
            $user_location = $this->input->post('user_location');
            $notify_content = $this->input->post('notify_content');
            $this->load->database();
            $inbox_query = "CALL post_new_notification(?,?,?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id,'p_user_location'=>$user_location,'p_notify_content'=>$notify_content));
            echo json_encode($result->result_array());
            $this->db->close();
    }
    public function get_user_notification(){
            $user_id = $this->input->post('user_id');
            $limit_amount = $this->input->post('limit_amount');
            $this->load->database();
            $inbox_query = "CALL get_user_notification(?,?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id,'p_limit_amount'=>$limit_amount));
            echo json_encode($result->result_array());
            $this->db->close();
    }
}