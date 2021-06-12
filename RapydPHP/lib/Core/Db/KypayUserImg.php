<?php
namespace Core\Db;

use Core\Db\KypayDbObject as KypayDbObject;

class KypayUserImg extends KypayDbObject{
    
    public $id;
    
    public $pid;
    
    public $ptype;
    
    public $url;
    
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_user_img");
    }
}
?>
