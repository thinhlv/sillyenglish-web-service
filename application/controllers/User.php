<?php
class User extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function getinfo()
    {
        $this->load->database();
        
        $user_id = $_GET['user_id'];
        $query = "CALL get_user_info(?)";
        $result = $this->db->query($query, array('user_id'=>$user_id));
        if($result->num_rows() == 0)
        {
            echo 'Can not find any matching result!';
        }
        else
        {
            echo json_encode($result->first_row());
        }
        
        $this->db->close();
    }
}
