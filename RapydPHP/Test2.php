<?php
require_once "bootstrap.php";

use Util\EncUtil as EncUtil;
use Util\KeyManager as KM;
use Db\SQLWhereCol as SQLWhereCol;
use Db\ArrayOfSQLWhereCol as ArrayOfSQLWhereCol;
use Db\DbObject as DbObject;
use Db\DbConnector as DbConn;
use Core\Db\KypayUser as User;
use Util\StrUtil as StrUtil;


$str = "/+9028Bga=8+/Nm\ou73/";
echo "ori..: $str<br/>";
echo "esc..: ".StrUtil::escapeBase64($str)."<br/>";

$str = EncUtil::randomString(12);
echo "ori..: $str<br/>";
echo "esc..: ".StrUtil::escapeBase64($str)."<br/>";


$conn = DbConn::conn() ;

User::testInsertUsers($conn);


$sql = (new DbObject($conn, "kypay_user"))->buildUpdateSql(array("first_name"=>"K Y Chee", "phone_number"=>"+60138634848", "id"=>"xxx"));
echo "update.sql:: [$sql]<br/>";

$u = new User($conn);
if ($u->findByPhone("+60138634848")){
    
    echo "<p>FindByPhone::$u->id :: $u->lastName $u->firstName : $u->phoneNumber : $u->email</p>";
}

if ($u->findByPhone("+60128119009")){
    
    echo "<p>FindByPhone::$u->id :: $u->lastName $u->firstName : $u->phoneNumber : $u->email</p>";
}


$key = KM::key($seed);

echo "<p>$key :: $seed</p>";

$id = (new User($conn))->generateId(array("last_name"=> "Ket Yung"));


$str = EncUtil::randomString(3);
echo "rstr ::  $str:: id : $id <br/>";

$dbo = new DbObject($conn, "kypay_user");
echo "sql :: ".$dbo->buildFindAllSql("start")."<br/>";


$res = $dbo->findBy(array('id'=>'x625gs'));
print_r($res);

echo "<p></p>";

$count = $dbo->count(array('id'=>'x625gs'));

echo "<p>cnt::$count</p>";


$a = new ArrayOfSQLWhereCol();
$a[] = new SQLWhereCol("id", "LIKE", "OR");
$a[] = new SQLWhereCol("first_name", "LIKE", "OR");

//ArrayOfSQLWhereCol::init(new SQLWhereCol("id", "LIKE", "OR"));




$sql = $dbo->buildFindBySql( $a  );
echo "<p>sql...x.:: $sql</p>";


$plainText = "Hello you!!! fool ###";

if ( isset($_REQUEST['t']) ){

	$plainText = $_REQUEST['t'];
	
}

$key = null;


$encrypted = EncUtil::encrypt($plainText, $key);

echo "encrypted :: $encrypted <br/>";


$decrypted = EncUtil::decrypt($encrypted, $key);

echo "decrypted :: $decrypted <br/>";

//echo "key :: $key \n";
 
?>
