<?php
class Friend extends CI_Controller {
        public function __construct() {
        parent::__construct();
    }
    public function find_friends() {
        $this->load->database();
        $user_id = $this->input->post('user_id');
        $search_keyword = $this->input->post('search_keyword');
        $query = "CALL find_friends(?,?)";
        $result = $this->db->query($query,array('p_user_id'=>$user_id,'p_search_keyword'=>$search_keyword));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function unfriend(){
        $this->load->database();
        $user_id = $this->input->post('user_id');
        $friend_id = $this->input->post('friend_id');
        
        $query = "CALL un_friend(?,?)";
        $result = $this->db->query($query,array('p_user_id'=>$user_id,'p_friend_id'=>$friend_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    public function get_list_friends(){
        $this->load->database();
        $user_id = $this->input->post('user_id');
        $query = "CALL get_list_friend(?)";
        $result = $this->db->query($query,array('p_user_id'=>$user_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
}