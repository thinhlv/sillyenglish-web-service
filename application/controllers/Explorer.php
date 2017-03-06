<?php
class Explorer extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    
    public function index()
    {
        echo 'this is explorer view!';
    }
    
    public function comment()
    {
        echo 'this is comment view';
    }
}
