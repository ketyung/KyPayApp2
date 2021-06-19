<?php
namespace Core\Db;

use Core\Db\KypayDbObject as KypayDbObject;
use Util\EncUtil as EncUtil;
use Util\StrUtil as StrUtil;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;


class KypayUserWallet extends KypayDbObject{
    
    public $id;
    
    public $refId;
    
    public float $balance;
    
    public $currency;
    
    public $type;
    
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_user_wallet");
    }
    
    
    function doesWalletExist( $userId , $walletType = 'P', $currency = 'MYR' ){
        
        $a = new ArrayOfSQLWhereCol();
        $a[] = new SQLWhereCol("id", "=", "AND", $userId);
        $a[] = new SQLWhereCol("type", "=", "AND", $walletType);
        $a[] = new SQLWhereCol("currency", "=", "AND", $currency);

        $res = $this->findByWhere($a, true);
        if (count($res)){
            
            $res = null;
            return true ;
        }
        
        return false;
    
    }
    
    
    private function genRefId(&$input){
        
        if (!isset($input['ref_id'])){
            
            $rid = EncUtil::randomString(8);
            
            $count = $this->count(array('id'=>$input['id'], 'ref_id'=>$rid));
            
            if ($count > 0)
            {
                $rid .= EncUtil::randomString(3). ($count + 1);
            }
            
            $input['ref_id'] = StrUtil::escapeBase64($rid);
        }
        
    }
    
    
    public function insert(Array &$input){
    
        $this->genRefId($input);
        return parent::insert($input);
        
    }
}
?>
