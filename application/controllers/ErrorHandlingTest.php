<?php

class ErrorHandlingTest extends CI_Controller
{
    public function __construct() {
        parent::__construct();
    }
    
    public function response()
    {
        $this->response(json_decode(array('response' => array('message' => "Something wrong", 'code' => 205))), 300);
    }
}