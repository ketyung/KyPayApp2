<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;

class KypayDeviceToken extends KypayDbObject {

    public $id;
    public $token;
    public $deviceType;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_device_token");
    }
    
    

}
?>
