<?php
class Friend extends CI_Controller {
        public function __construct() {
        parent::__construct();
    }
    public function find_friends() {
        $this->load->database();
        $query = "CALL find_friends()";
        $result = $this->db->query($query);
        echo json_encode($result->result_array());
        $this->db->close();
    }
}
