<?php
namespace Core\Db;

use Core\Db\KypayDbObject as KypayDbObject;

class KypayUserPaymentTx extends KypayDbObject {
    
    public $id;
    
    public $uid;
    
    public $toUid;
    
    public $toUidType;
    
    public $amount;
    
    public $currency;
    
    public $method;
    
    public $stat;
    
    public $statMessage;
    
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_user_payment_tx");
    }
    
}
?>
