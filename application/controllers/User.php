<?php
class User extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function getinfo()
    {
        $user_id = $this->input->post('user_id');
        if($user_id == null || $user_id == "")
            echo "missing parameter!";
        else
        {
            $this->load->database();
            $query = "CALL get_user_info(?)";
            $result = $this->db->query($query, array('p_user_id'=>$user_id));
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
}
