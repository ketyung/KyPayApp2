<?php
require_once "../bootstrap.php";

use Util\Log as Log;
use Util\StrUtil as StrUtil;
use Core\Controllers\KypayUserController;
use Core\Controllers\KypayUserAddressController;
use Core\Controllers\KypayUserWalletController;
use Core\Controllers\KypayUserPaymentTxController;
use Core\Controllers\KypayDeviceTokenController;
use Core\Controllers\KypayBillerController;
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
    removeStartingSubPathOfURI($uri);
   
    $uri = explode( '/', $uri );
//print_r($uri);
    
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
    else
    if ($uri[1] == 'deviceToken'){

        $u = new KyPayDeviceTokenController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
    else
    if ($uri[1] == 'biller'){

        $u = new KyPayBillerController( DbConn::conn() , $requestMethod, $params );
        $u->processRequest();
    }
   
    else {
        
        header("HTTP/1.1 404 Not Found");
        exit();
        
    }
    
}



function removeStartingSubPathOfURI(&$uri, $subFolder = "/KyPayApiTestPointV1"){
    
    if (str_starts_with($uri, $subFolder )){
        
        $uri = str_replace($subFolder, "", $uri);
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


function checkBasicAuth($header){
    
   
    if (StrUtil::startsWith($header , "Basic://")){
        
        $header = str_replace("Basic://", "", $header);
    
        return (trim($header) == '7625bavaVDf2fnak3lKL908337aland#a2op_j3nankLK_63535vvVAf53535AFAF63663_9283737AHGHgsa_92777jah3TAY3a');
    }
    
    return false ;
    
}


function getAuthorizationHeader(){
    $headers = null;
    
    if (isset($_SERVER['Authorization'])) {
        
        $headers = trim($_SERVER["Authorization"]);
    }
    else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { //Nginx or fast CGI
    
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    }
    elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        
        // Server-side fix for bug in old Android versions (a nice side-effect of this fix means we don't care about capitalization for Authorization)
        $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)),array_values($requestHeaders));
        //print_r($requestHeaders);
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    }
    return $headers;
}

function authenticate() {
    
    try
    {
        
        $authHeader = getAuthorizationHeader();
       
       // Log::printRToErrorLog("auth::$authHeader");
        
        if (checkBasicAuth($authHeader) ){
            return true;
        }
        
        /**
        preg_match('/Bearer\s(\S+)/', $authHeader, $matches);
    
        Log::printRToErrorLog($matches);
        
        if(!isset($matches[1])) {
            throw new \Exception('No Bearer Token');
        }*/
        
        $jwtVerifier = (new \Okta\JwtVerifier\JwtVerifierBuilder())
            ->setIssuer(getenv('OKTAISSUER'))
            ->setAudience('api://default')
            ->setClientId(getenv('OKTACLIENTID'))->build();
                
        return $jwtVerifier->verify(trim($authHeader));
    }
    catch (\Exception $e) {
        
       // Log::printRToErrorLog($e);
        return false;
    }
}
?>
