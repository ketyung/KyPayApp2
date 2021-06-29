<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;

class KypayDeviceToken extends KypayDbObject {

    public $id;
    public $token;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_device_token");
    }
    
    public function save(Array &$input){
    
        if ($this->findByPk($input)) {
    
            return $this->update($input);
    
        }
        else {
    
            return $this->insert($input);
        }
    }
    
    

}
?>
