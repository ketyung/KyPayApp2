<?php
namespace Core\Controllers;

use Core\Db\KypayUserWallet as Wallet;
use Core\Db\KypayUser as User;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;

class KypayUserWalletController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new Wallet($this->db);
    }
    
    
    
    protected function getDbObjects(){
        
        $param1 = "";
        $param2 = "";
        $param3 = "";
        
        if (isset($this->params)) {
            
            if (isset($this->params[0])){
                $param1 = $this->params[0];
            }
            
            if (isset($this->params[1])){
                $param2 = $this->params[1] ;
            }
            
            if (isset($this->params[2])){
                $param3 = $this->params[2] ;
            }
        }
        
        if ($param1 == 'id' && $param2 != '' && $param3 != ''){
            
            return $this->getBy($param2, $param3);
        }
        else {
         
            return $this->notFoundResponse();
        }
    }
    
    
    private function getBy($id, $refId){
        
        
        $pk['id'] = $id;
        $pk['ref_id'] = $refId;
      
        if ($this->dbObject->findBy($pk)){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson();
            
           // Log::printRToErrorLog($response);
            
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
        
    }
    

    
    
    protected function createDbObjectFromRequest(){
    
        $input = $this->getInput();
      
        StrUtil::arrayKeysToSnakeCase($input);
       
        $response['status_code_header'] = 'HTTP/1.1 201 Create';
        
        if (!User::exists($input['id'], $this->db)){
            
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'User NOT found!'));
    
            return $response;
        }
        
      
        if ($this->dbObject->insert($input) > 0){
            
            
            $obj = array('id'=>$input['id'], 'ref_id'=>$input['ref_id']);
            
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'],
            'text'=>'Created!','returnedObject'=> $obj));
            
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
        
        
        if (!User::exists($input['id'], $this->db)){
            
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'User NOT found!'));
    
            return $response;
        }
        
       
       
        if ($this->dbObject->update($input) > 0){
            
            $obj = array('id'=>$input['id'], 'ref_id'=>$input['ref_id']);

            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Updated!',
                                                  'returnedObject'=> $obj));
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
        
        return $response;
        
    }
    
    
    protected function deleteDbObject(){
        
        $response['status_code_header'] = 'HTTP/1.1 202 Deletion';
       
        $input = $this->getInput();
        
        StrUtil::arrayKeysToSnakeCase($input);
       
    
        if ( $this->dbObject->delete($input) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'].'-'.$input['ref_id'], 'text'=>'Deleted!'));
       
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
      
                                            
        return $response;
                                    
        
    }
    
}
?>
