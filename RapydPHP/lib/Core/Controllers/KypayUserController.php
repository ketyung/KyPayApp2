<?php
namespace Core\Controllers;

use Core\Db\KypayUser as User;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;


class KypayUserController extends Controller {
	
    protected function createDbObject(){
        
        $this->dbObject = new User($this->db);
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
        
        
        if ($param1 == 'id' && $param2 != ''){
            
            return $this->getById($param2);
        }
        else if ( $param1 == 'phoneNumber' && $param2 != '' ){
            
            return $this->getByPhone( $param2 );
        }
        
        else {
         
            return $this->getAll();
        }
    }
    
    
    private function getByPhone($number) {
        
        if ( $this->dbObject->findByPhone( $number )) {
            
            
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson(array("seed"));
          
            return $response;
          
        }
        else {
            
            return $this->notFoundResponse();
        }
    }
    
    
    private function getById($id){
        
        $pk['id'] = $id;
        
        if ($this->dbObject->findBy($pk)){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson(array("seed"));
            
            //Log::printRToErrorLog($response);
            
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
    }
    
    
    private function getAll(){
        
        $result = $this->dbObject->findAll(0,20);
        

        if (count($result) > 0 ){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = json_encode($result);
            
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
      
        
        if ( !$this->validate($input, array('first_name', 'last_name', 'phone_number'), $errorMessage  ) ){
            
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$errorMessage) );
            
            return $response;
        }
        
       // Log::printRToErrorLog($input);
                                            
        if ($this->dbObject->insert($input) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Created!'));
        
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
        else if ($param1 == 'signIn'){
            
            return $this->signInUser();
        }
        else if ($param1 == 'signOut'){
            
            return $this->signOutUser();
        }
      
        
    }
    
    private function signInUser(){
      
        $response['status_code_header'] = 'HTTP/1.1 203 Sign-In';
       
        $input = $this->getInput();
      
        StrUtil::arrayKeysToSnakeCase($input);
      
        if ( isset($input['phone_number'])) {
            
            return $this->signInBy($input,'phone_number');
        }
        
        if ( isset($input['email'])) {
            
            return $this->signInBy($input,'email');
        }
     
        
        $response['body'] = json_encode(array('status'=> -1 , 'id'=>null,
        'text'=> "No valid token for sign-in!"));
 
        return $response;
        
    }
    
    
    private function signInBy($input, $type){
        
        $found = false ;
        
        if ($type == 'phone_number'){
            
            $found = $this->dbObject->findByPhone($input[$type]);
        }
        else if ($type == 'email'){
            
            $found = $this->dbObject->findByEmail($input[$type]);
        }
        
        
        if ($found){
            
            $date = date('Y-m-d H:i:s');
            $input = array('id'=> $this->dbObject->id, 'stat'=>'SI', 'last_stat_time'=> $date) ;
            
            // 3rd param false = no encrypt
            if ($this->dbObject->update($input, true, false) > 0){
                
                $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Signed In!', 'date'=>$date, 'returnedObject'=>$this->dbObject->copy()));
            }
            else {
                $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'Failed to sign in : ' .$this->dbObject->getErrorMessage()));
            }
            
        }
        else {
            
            $typestr = StrUtil::snakeCaseToWords($type);
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null,
            'text'=> "User with $typestr does NOT exist!"));
     
        }
                                            
                                            
        return $response;
    }
    
    
    protected function signOutUser(){
      
        $response['status_code_header'] = 'HTTP/1.1 202 Sign-Out';
       
        $input = $this->getInput();
      
        StrUtil::arrayKeysToSnakeCase($input);
      
        
        $date = date('Y-m-d H:i:s');
      
        $input['stat'] = 'SO';
        $input['last_stat_time'] = $date;
        
        
        if ($this->dbObject->update($input, true) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Signed Out Successfully!', 'date'=>$date));
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>'Failed Signing Out'));
        }
        
        return $response;
    }
    
    
    protected function updateDbObjectNow(){
        
        $response['status_code_header'] = 'HTTP/1.1 202 Update';
       
        $input = $this->getInput();
        
        StrUtil::arrayKeysToSnakeCase($input);
       
       
        if ($this->dbObject->update($input, true) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Updated!'));
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
        
        return $response;
        
    }
    
    
}
?>
