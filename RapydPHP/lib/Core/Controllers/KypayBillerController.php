<?php
namespace Core\Controllers;

use Core\Db\KypayBiller as Biller;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;


class KypayBillerController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new Biller($this->db);
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
        
        if ($param1 == 'id' && $param2 != '' ){
        
            return $this->getById($param2);
            
        }
        else
        if ($param1 == 'country' && $param2 != ''){
            
            $param3 = null;
            if (isset($this->params[2])){
                $param3 = $this->params[2] ;
            }
        
            $param4 = null;
            if (isset($this->params[3])){
                $param4 = $this->params[3] ;
            }
        
            return $this->getByCountry($param2, $param3, $param4);
        }
        else {
         
            return $this->notFoundResponse();
        }
    }
    
    
    private function getById($id){
        
        $pk['id'] = $id;
        
        
        if ($this->dbObject->findByPK($pk)){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson();
            
            //Log::printRToErrorLog($response);
            
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
    }

    
    private function getByCountry($country, $limit = null, $offset = null){
        
        $result = $this->dbObject->findBillersBy($country, $limit, $offset) ;
        
        if (count($result) > 0){
       
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = json_encode($result);
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
        
    }

}
?>
