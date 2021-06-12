<?php
namespace Core\Db;

use Core\Db\KypayDbObject as KypayDbObject;

class KypayUserAddress extends KypayDbObject {


    public $id;
    
    public $addrType;
    
    public $line1;
    
    public $line2;
    
    public $postCode;
    
    public $city;
    
    public $state;
    
    public $country;

    public $lastUpdated;

    public function __construct($db)
    {
        parent::__construct($db, "kypay_user_address");
    }

}
?>
