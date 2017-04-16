<?php
class Inbox extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function get_inbox()
    {
        $user_id = $this->input->post('user_id');
        
        if($user_id == null || $user_id == "")
        {
            echo "User name can not be null!";
        }
        else
        {
            $this->load->database();
            $inbox_query = "CALL get_inbox_items(?)";
            $result = $this->db->query($inbox_query, array('p_user_id' => $user_id));
            echo json_encode(array('data' => $result->result_array()));
            $this->db.close();
        }
    }
    
    public function remove_mail()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        if($user_id == null || $user_id == "")
        {
            echo "User name can not be null!";
        }
        else if($mail_id == null || $mail_id == "")
        {
            echo "Mail id can not me null!";
        }
        else
        {
            $this->load->database();
            $remove_query = "CALL remove_mail(?, ?)";
            $result = $this->db->query($remove_query, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
            echo json_encode(array('data' => $result->result_array()));
            $this->db.close();
        }
    }
}