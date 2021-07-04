<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;

class KypaySellerItem extends KypayDbObject {
    
    public $id;
    public $sellerId;
    public $name;
    public $description;
    public $category;
    public $price;
    public $currency;
    public $qoh;
    public $shippingFee;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_seller_item");
    }
    
    
    function findItemsBy( $currency = "MYR", $limit = null, $offset = null ){
        
        $a = new ArrayOfSQLWhereCol();
        $a[] = new SQLWhereCol("currency", "=", "AND", $currency);
        $a[] = new SQLWhereCol("qoh", ">", "", 0);
        

        $res = $this->findByWhere($a, true, "ORDER BY last_updated DESC", $limit, $offset);
        
        return $res;

    }
}
?>
