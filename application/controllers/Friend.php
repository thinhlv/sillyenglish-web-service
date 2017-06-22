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
}
