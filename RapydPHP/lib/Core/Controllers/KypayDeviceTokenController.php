<?php
namespace Core\Controllers;

use Core\Db\KypayDeviceToken as DeviceToken;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;


class KypayDeviceTokenController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new DeviceToken($this->db);
    }

    protected function createDbObjectFromRequest(){
    
        $input = $this->getInput();
      
        StrUtil::arrayKeysToSnakeCase($input);
       
        $response['status_code_header'] = 'HTTP/1.1 201 Create';
      
        
       // Log::printRToErrorLog($input);
                                            
        if ($this->dbObject->save($input) > 0){
            
            $response['body'] = json_encode(array('status'=>1, 'id'=>$input['id'], 'text'=>'Created!'));
        
        }
        else {
            $response['body'] = json_encode(array('status'=> -1 , 'id'=>null, 'text'=>$this->dbObject->getErrorMessage()));
        }
        
       
        return $response;
        
    }
    
    
    protected function getDbObjects(){
        
        echo "n/a";
    
    }
    
}
?>
