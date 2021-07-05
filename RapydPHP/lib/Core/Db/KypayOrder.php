<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;

class KypayOrder extends KypayDbObject {
    
    public $id;
    public $lastUpdated;
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_order");
    }
}
?>
