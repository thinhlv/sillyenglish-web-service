<?php
class ReadDir extends CI_Controller{
    public function __construct() {
        parent::__construct();
    }
    function splitstring($s){
        for($i = strlen($s); $i>0; $i--){
            if($s[$i-1]=='\\')
            {
                return substr($s, $i);
            }
        }
    }
    public function addlesson(){
    foreach (glob(APPPATH."resource\*") as $folder) {
        $p_lesson_title = $this->splitstring($folder);
        $p_lesson_url = $folder;
        $p_lesson_price = 140;
        $p_lesson_avatar_url = "";
        $p_lesson_max_hear_times = 5;
        //print("VALUES ('".$p_lesson_title."',".$p_lesson_price.",$p_lesson_max_hear_times,'".$folder."'),");
        $s = ("INSERT INTO `silly_english`.`lesson`
            (`ls_title`,
             `ls_price`,
             `ls_max_hear_times`,
             `ls_url`)"."<br />");
        print("VALUES ('".$p_lesson_title."',".$p_lesson_price.",".$p_lesson_max_hear_times.",'".$folder."');");
                    foreach (glob($folder."\*.mp3") as $file)
                    {
                        //print($file."<br />");
                        //print("VALUES ('".$this->splitstring($file)."',1,18,'C:\xampp\htdocs\sillyenglish-web-service\application\resource\OBL St1 A Ghost in Love and Other Plays\01.mp3',1);")
                    } 
        }
    }
    function processString($s){
        $a = @"\\\\";
        return str_replace("\\",$a,$s);
        return $s;
    }
    public function addlessonunit(){
    foreach (glob("Resources\*") as $folder) {
        //print("VALUES ('".$p_lesson_title."',".$p_lesson_price.",".$p_lesson_max_hear_times.",'".$folder."');");
        $p = $this->processString("INSERT INTO `silly_english`.`lesson_unit`
            (`lu_name`,
             `lu_sequence`,
             `ls_id`,
             `lu_url`,
             `lu_type`) VALUES");
        print($p."<br />");
                    foreach (glob($folder."\*.mp3") as $file)
                    {
                        //print($file."<br />");
                        $a = "";
                        if($this->splitstring($file)[0]=="0")
                        {
                            $a = substr($this->splitstring($file), 1);
                        }
                        $a = ("('".$this->splitstring($file)."',".intval($this->splitstring($file)).",20,'".$file."',1),");
                        print($this->processString($a));
                        print("<br />");
                    } 
        }
    }
    
    
}