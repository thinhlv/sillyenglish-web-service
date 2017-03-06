<?php
class Arena extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function create_battle()
    {
        $this->load->database();
        $attacker_id = $_POST['attacker_id'];
        $defender_id = $_POST['defender_id'];
        
        if($attacker_id == '' || $defender_id == '')
        {
            echo 'attacker and defender can not be null';
        }
        else
        {
            $create_battle = "CALL create_battle(?, ?)";
            $result = $this->db->query($create_battle, array('p_attacker_id' => $attacker_id, 'p_defender_id' => $defender_id));
            echo json_encode(array('data'=>$result->result_array()));
        }
        
        $this->db->close();
    }
	
	public function index()
	{
		echo 'this is arena service!';
	}
}
