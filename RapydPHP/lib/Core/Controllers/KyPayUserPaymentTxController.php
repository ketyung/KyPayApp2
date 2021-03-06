<?php
namespace Core\Controllers;

use Core\Db\KypayUserPaymentTx as Payment;
use Core\Db\KypayUser as User;
use Core\Db\KypayUserWallet as Wallet;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Core\Controllers\KypayMessageController as MessageController;
use Util\Log as Log;
use Util\StrUtil as StrUtil;

class KypayUserPaymentTxController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new Payment($this->db);
    }
    
    
    protected function getDbObjects(){
        
        $param1 = "";
        $param2 = "";
        
        if (isset($this->params)) {
            
            if (isset($this->params[0])){
                $param1 = $this->params[0];
            }
            
            if (isset($this->params[1])){
                $param2 = $this->params[1] ;
            }
            
        }
        
        if ($param1 == 'id' && $param2 != '' ){
            
            return $this->getBy($param2);
        }
        else {
         
            return $this->notFoundResponse();
        }
    }
    
    
    private function getBy($id){
        
        
        $pk['id'] = $id;
        
        if ($this->dbObject->findBy($pk)){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson();
            
          //  Log::printRToErrorLog($response);
            
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
        
    }
    
    
    
    protected function updateWalletOfRecipient($input){
        
        if (isset($input['method']) && $input['method'] == 'kypay_send_money' ){
            
            
            if ( isset($input ['to_uid']) && isset($input ['to_wallet_ref_id'])) {
                
                $uw = new Wallet($this->db);
                
                $pk = array();
                $pk['id'] = $input ['to_uid'];
                $pk['ref_id'] = $input ['to_wallet_ref_id'];
                
                
                if ( $uw->findByPK($pk, true)){
                    
                    $row = $uw->getRowArray();
                    $row['balance'] = $row['balance'] + abs( $input['amount'] );
                    $uw->update($row);
                   // Log::printRToErrorLog($row);
                }
                
            }
            
        }
    }
    
    
    
    protected function notifyOfMoneySent(Array $input){
        
        $m = new KypayMessageController($this->db);
        $m->notifyOfMoneySent($input);
        
    }

    
    
    protected function createDbObjectFromRequest(){
    
        $input = $this->getInput();
      
        StrUtil::arrayKeysToSnakeCase($input);
       
        $response['status_code_header'] = 'HTTP/1.1 201 Create';
        
        if (!User::exists($input['uid'], $this->db)){
            
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'User NOT found!'));
    
            return $response;
        }
        
        
        if ($this->dbObject->insert($input) > 0){
            
            $this->updateWalletOfRecipient($input);
            $this->notifyOfMoneySent($input);
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'],
            'text'=>'Created!'));
            
           // Log::printRToErrorLog( $response['body'] );
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
        
       
        return $response;
        
    }
    
    
    protected function updateDbObjectFromRequest(){
    
        $param1 = "";
       
        if (isset($this->params)) {
            
            if (isset($this->params[0])){
                $param1 = $this->params[0];
            }
        }
        
        if ($param1 == 'update'){
            
           return $this->updateDbObjectNow();
        }
       
    }
    
    
    protected function updateDbObjectNow(){
        
        $response['status_code_header'] = 'HTTP/1.1 202 Update';
       
        $input = $this->getInput();
        
        StrUtil::arrayKeysToSnakeCase($input);
        
        if (!User::exists($input['uid'], $this->db)){
            
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'User NOT found!'));
    
            return $response;
        }
        
       
        if ($this->dbObject->update($input, true ) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Updated!'));
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
        
        
        return $response;
        
    }
    
    
    protected function deleteDbObject(){
        
        // Use 202 , as 204 indicates no content 
        $response['status_code_header'] = 'HTTP/1.1 202 Deletion';
       
        $input = $this->getInput();
         
        StrUtil::arrayKeysToSnakeCase($input);
       
        if ( $this->dbObject->delete($input) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Deleted!'));
       
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
      
                                            
        return $response;
                                    
        
    }

    
}
?>
