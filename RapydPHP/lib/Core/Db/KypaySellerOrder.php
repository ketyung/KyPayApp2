<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;
use Util\EncUtil as EncUtil;
use Util\StrUtil as StrUtil;

class KypaySellerOrder extends KypayDbObject {
    
    public $id;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_seller_order");
    }
    
    private function genId(&$input){
        
        if (!isset($input['id'])){
            
            $rid = strtoupper( EncUtil::randomString(14) );
            
            $count = $this->count(array('id'=>$rid));
            
            if ($count > 0)
            {
                $rid .= EncUtil::randomString(3). ($count + 1);
            }
            
            $input['id'] = "SO".strtoupper( StrUtil::escapeBase64($rid) );
        }
        
    }
    
    public function insert(Array &$input){
      
        $this->genId($input);
        return parent::insert($input);
    }
}
?>
