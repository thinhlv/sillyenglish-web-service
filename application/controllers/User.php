<?php

class User extends CI_Controller {

    public function __construct() {
        parent::__construct();
    }

    public function getinfo() {
        $user_id = $this->input->post('user_id');
        $user_name = $this->input->post('user_name');
        $user_avatar = $this->input->post('user_avatar');

        $this->load->database();
        $query = "CALL get_user_info(?, ?, ?)";
        $result = $this->db->query($query, array(
            'p_user_id' => $user_id,
            'p_avatar_url' => $user_avatar,
            'p_user_name' => $user_name));
        echo json_encode($result->result_array());
        $this->db->close();
    }

    /* Get user ranking */

    public function get_user_ranking() {
        $user_id = $this->input->post('user_id');
        $this->load->database();
        $query = "CALL get_user_ranking(?)";
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }

    /* Get all application parameters. */

    public function get_app_params() {
        $user_id = $this->input->post('user_id');
        $this->load->database();
        $query = "CALL get_app_params(?)";
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }

    public function do_spin() {
        $user_id = $this->input->post('user_id');
        $this->load->database();
        
        $query = "CALL do_spinning(?)";
        $result = $this->db->query($query, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }

}
