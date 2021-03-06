<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;


class KypaySellerItemImage extends KypayDbObject {
    
    public $id;
    public $itemId;
    public $type;
    public $url;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_seller_item_image");
    }
    
    
    function findImagesBy( $itemId, $limit = null, $offset = null ){
        
        $a = new ArrayOfSQLWhereCol();
        $a[] = new SQLWhereCol("item_id", "=", "", $itemId);
        

        $res = $this->findByWhere($a, true, "ORDER BY id", $limit, $offset,
        array('url'=>"concat('".IMAGE_URL_PREFIX."', url)"));
        
        return $res;

    }
}
?>
