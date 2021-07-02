<?php
namespace Core\Db;

use Db\DbObject as DbObject;
use Core\Db\KypayDbObject as KypayDbObject;
use Util\Log as Log;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;

define('ICON_URL_PREFIX', 'http://127.0.0.1:808/KyPay');

class KypayBiller extends KypayDbObject {
    
    public $id;
    public $serviceBid;
    public $payoutMethod;
    public $name;
    public $addrLine1;
    public $addrLine2;
    public $postCode;
    public $city;
    public $state;
    public $country;
    public $iconUrl;
    public $status;
    public $byType;
    public $numberValidator;
    public $lastUpdated;
    
    
    public function __construct($db)
    {
        parent::__construct($db, "kypay_biller");
    }
    
    
    function findBillersBy( $country = "MY", $limit = null, $offset = null ){
        
        $a = new ArrayOfSQLWhereCol();
        $a[] = new SQLWhereCol("country", "=", "", $country);

        $res = $this->findByWhere($a, true, null, $limit, $offset,
        array('icon_url'=>"concat('".ICON_URL_PREFIX."', icon_url)"));
        
        return $res;

    }
    
}
?>
