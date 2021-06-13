<?php
require_once "../bootstrap.php";

use Util\Log as Log;
use Core\Controllers\KypayUserController;
use Core\Controllers\KypayUserAddressController;
use Core\Controllers\KypayUserWalletController;
use Core\Controllers\KypayUserPaymentTxController;
use Db\DbConnector as DbConn;

date_default_timezone_set('Asia/Brunei');

checkIfAuthorized();

headers();

processUri();


function headers(){
    
    header("Access-Control-Allow-Origin: *");
    header("Content-Type: application/json; charset=UTF-8");
    header("Access-Control-Allow-Methods: OPTIONS,GET,POST,PUT,DELETE");
    header("Access-Control-Max-Age: 3600");
    header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
}

function processUri(){
    
    //Log::printRToErrorLog($_SERVER['REQUEST_URI']);
    
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $uri = explode( '/', $uri );
    
    $requestMethod = $_SERVER["REQUEST_METHOD"];
    
    $params = extractParams($uri,2);
    
    if ($uri[1] == 'user'){

        $u = new KyPayUserController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
    else
    if ($uri[1] == 'userAddress'){

        $u = new KyPayUserAddressController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
    else
    if ($uri[1] == 'userWallet'){

        $u = new KyPayUserWalletController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
    else
    if ($uri[1] == 'userPayment'){

        $u = new KyPayUserPaymentTxController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
   
    else {
        
        header("HTTP/1.1 404 Not Found");
        exit();
        
    }
    
}


function extractParams ($uri, $from){
    
    $max = ((count($uri) - $from) + 1) + $from;
    
    $params = array();
    
    for ($i = $from; $i < $max; $i++){
        
        if (isset($uri[$i])) {
   
            $params[] = $uri[$i];
        }
    }
    
    return $params;
    
}

function checkIfAuthorized(){
    
    if (!authenticate()) {
        header("HTTP/1.1 401 Unauthorized");
        header("Content-type:text/plain");
        exit('Unauthorized');
    }
}



function authenticate() {
    
    try
    {
        switch(true)
        {
            case array_key_exists('HTTP_AUTHORIZATION', $_SERVER) :
                $authHeader = $_SERVER['HTTP_AUTHORIZATION'];
                break;
            case array_key_exists('Authorization', $_SERVER) :
                $authHeader = $_SERVER['Authorization'];
                break;
            default :
                $authHeader = null;
                break;
        }
        
        preg_match('/Bearer\s(\S+)/', $authHeader, $matches);
    
        if(!isset($matches[1])) {
            throw new \Exception('No Bearer Token');
        }
        
        $jwtVerifier = (new \Okta\JwtVerifier\JwtVerifierBuilder())
            ->setIssuer(getenv('OKTAISSUER'))
            ->setAudience('api://default')
            ->setClientId(getenv('OKTACLIENTID'))->build();
                
        return $jwtVerifier->verify($matches[1]);
    }
    catch (\Exception $e) {
        return false;
    }
}
?>
