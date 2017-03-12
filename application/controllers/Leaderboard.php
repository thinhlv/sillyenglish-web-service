<?php
    class Leaderboard extends CI_Controller
    {
        public function __construct() {
            parent::__construct();
        }
        
        public function global_ranking()
        {
            $this->load->database();
            $global_ranking = "CALL global_ranking()";
            $result = $this->db->query($global_ranking);
            echo json_encode(array('data' => $result->result_array()));
            $this->db->close();
        }
        
        public function friend_ranking()
        {
            $this->load->database();
            $global_ranking = "CALL global_ranking()";
            $result = $this->db->query($global_ranking);
            //echo json_decode(array('data' => $result->result_array()));
            var_dump($result);
            $this->db->close();
        }
    }
?>
