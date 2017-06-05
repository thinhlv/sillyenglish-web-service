<?php
class Inbox extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    /*
     * Get inbox items
     */
    public function get_inbox()
    {
        $user_id = $this->input->post('user_id');
        $this->load->database();
        $inbox_query = "CALL get_inbox_items(?)";
        $result = $this->db->query($inbox_query, array('p_user_id' => $user_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Remove mail
     */
    public function remove_mail()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $remove_query = "CALL remove_mail(?, ?)";
        $result = $this->db->query($remove_query, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Rate the mail
     */
    public function rate()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $remove_query = "CALL rating_mail(?, ?)";
        $result = $this->db->query($remove_query, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Get attatch items
     */
    public function get_attach_item()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $attatch_query = "CALL get_attatch_items(?, ?)";
        $result = $this->db->query($attatch_query, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Mask item as opened
     */
    public function mask_as_opened()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $attatch_query = "CALL mask_as_opened_mail(?, ?)";
        $result = $this->db->query($attatch_query, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /*
     * Claim rewards.
     */
    public function inbox_claim_rewards()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $claim_request = "CALL inbox_claim_rewards(?, ?)";
        $result = $this->db->query($claim_request, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    /**
     * Accept friend request.
     */
    public function accept_friend_request()
    {
        $user_id = $this->input->post('user_id');
        $mail_id = $this->input->post('mail_id');
        
        $this->load->database();
        $claim_request = "CALL accept_friend_request(?, ?)";
        $result = $this->db->query($claim_request, array('p_user_id' => $user_id, 'p_mail_id' => $mail_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
    
    public function delete_selected_mails()
    {
        $user_id = $this->input->post('user_id');
        $delmails_id = $this->input->post('delmails_id');
        
        $this->load->database();
        $delete_selected_mails = "CALL delete_selected_mails(?, ?)";
        $result = $this->db->query($delete_selected_mails, array('p_user_id' => $user_id, 'p_inbox_id' => $delmails_id));
        echo json_encode($result->result_array());
        $this->db->close();
    }
}