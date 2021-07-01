<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;

class KypayBiller extends KypayDbObject {
    
    public $id;
    public $serviceBid;
    public $name;
    public $addrLine1;
    public $addrLine2;
    public $postCode;
    public $city;
    public $state;
    public $country;
    public $iconUrl;
    public $status;
    public $lastUpdated;
    
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_biller");
    }
    
}
?>
