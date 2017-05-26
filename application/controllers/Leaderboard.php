<?php
    class Leaderboard extends CI_Controller
    {
        public function __construct() {
            parent::__construct();
        }
        
        /**
         * Gets the global ranking.
         */
        public function global_ranking()
        {
            $user_id = $this->input->post('user_id');
            $this->load->database();
            $inbox_query = "CALL global_ranking(?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id));
            echo json_encode($result->result_array());
            $this->db->close();
        }
        
        /**
         * Gets the friend ranking.
         */
        public function friend_ranking()
        {
            $user_id = $this->input->post('user_id');
            $this->load->database();
            $inbox_query = "CALL friend_ranking(?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id));
            echo json_encode($result->result_array());
            $this->db->close();
        }
        
        /**
         * Sent add friend request to server.
         */
        public function add_friend_request()
        {
             $user_id = $this->input->post('user_id');
            $friend_id = $this->input->post('friend_id');
            $this->load->database();
            $inbox_query = "CALL sent_add_friend_request(?,?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id, 'p_friend_id'=>$friend_id));
            echo json_encode($result->result_array());
            $this->db->close();
        }
    }
?>
