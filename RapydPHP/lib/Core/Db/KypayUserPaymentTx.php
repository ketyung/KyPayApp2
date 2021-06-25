<?php
namespace Core\Db;

use Core\Db\KypayDbObject as KypayDbObject;
use Util\EncUtil as EncUtil;
use Util\StrUtil as StrUtil;


class KypayUserPaymentTx extends KypayDbObject {
    
    public $id;
    
    public $uid;
    
    public $toUid;
    
    public $toUidType;
    
    public $txType;
    
    public $walletRefId;
    
    public $toWalletRefId;
    
    public float $amount;
    
    public $currency;
    
    public $method;
    
    public $stat;
    
    public $statMessage;
    
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_user_payment_tx");
    }
    
    
    private function genId(&$input){
        
        if (!isset($input['id'])){
            
            $rid = EncUtil::randomString(16);
            
            $count = $this->count(array('id'=>$rid));
            
            if ($count > 0)
            {
                $rid .= EncUtil::randomString(3). ($count + 1);
            }
            
            $input['id'] = StrUtil::escapeBase64($rid);
        }
    }

    public function insert(Array &$input){
      
        $this->genId($input);
        return parent::insert($input);
    }
}
?>
