<?php
namespace Core\Controllers;

use Core\Db\KypayUser as User;
use Core\Db\KypayMessage as Message;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;

class KypayMessageController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new Message($this->db);
    }
    
    protected function getDbObjects(){
        
        $param1 = "";
        $param2 = "";
        
        
       // Log::printRToErrorLog($this->params);
       
        if (isset($this->params)) {
            
            if (isset($this->params[0])){
                $param1 = $this->params[0];
            }
            
            if (isset($this->params[1])){
                $param2 = $this->params[1] ;
            }
          
        }
        
        if ($param1 == 'user' && $param2 != '' ){
        
            return $this->getByUserId($param2);
            
        }
        else {
         
            return $this->notFoundResponse();
        }
        
    
    }
    
    
    private function getByUserId($userId){
        
        $result = $this->dbObject->findByUserId($userId) ;
        
        if (count($result) > 0){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = json_encode($result);
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
    }
    
    
    
    function notifyOfMoneySent(Array $paymentTx){
        
        $input = array();
        $input['uid'] = $paymentTx['to_uid'];
        $input['item_id'] = $paymentTx['id'];
       
        $user = new User($this->db);
        
        $pk['id'] = $paymentTx['uid'];
        
        
        $userName = "Someone";
        if ($user->findByPK($pk)){
            $userName = $user->firstName . " ".$user->lastName;
        }
        /**
        Log::printRToErrorLog($pk);
        Log::printRToErrorLog($user);*/
        
        $input['title'] = "Money Received!";
        $input['sub_title'] = $userName . " sent you money ". $paymentTx['currency'].' '.abs( $paymentTx['amount'] );
        
        $input['type'] = 'SM';
        
        $mesg = new Message($this->db);
        $mesg->insert($input);
        
    }
    
}

?>
