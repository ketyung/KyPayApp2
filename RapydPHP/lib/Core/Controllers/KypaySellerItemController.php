<?php
namespace Core\Controllers;

use Core\Db\KypaySellerItem as Item;
use Core\Db\KypaySellerItemImage as ItemImage;
use Core\Db\KypaySellerCategory as Category;
use Core\Db\KypaySeller as Seller;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;


class KypaySellerItemController extends Controller {
    
    protected function createDbObject(){
        
        $this->dbObject = new Item($this->db);
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
        
            return $this->getById($param2);
            
        }
        else
        if ($param1 == 'currency' && $param2 != ''){
            
            return $this->getByCurrency($param2);
        }
        else {
         
            return $this->notFoundResponse();
        }
    }
    
    
    protected function getById($id) {
        
        $pk = array('id'=>$id);
        
        if ( $this->dbObject->findByPK($pk)){
            
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = $this->dbObject->toJson();
            
            return $response;
        }
        else {
            
            return $this->notFoundResponse();
        }
    }
    
    
    protected function getByCurrency($currency) {
        
        $result = $this->dbObject->findItemsBy($currency, 0, 50) ;
        
        if (count($result) > 0){
       
            $this->addRequiredFields($result);
            
            $response['status_code_header'] = 'HTTP/1.1 200 OK';
            $response['body'] = json_encode($result);
            return $response;
           
        }
        else {
            
            return $this->notFoundResponse();
        }
      
    }
    
    
    protected function addRequiredFields (&$res){
        
        $itemImage = new ItemImage($this->db);
        $cat = new Category($this->db);
        $seller = new Seller($this->db);
      
        for($r=0; $r < count($res); $r++ ){
            
            $row = $res[$r];
            
            
            $row['price'] = floatval($row['price']);
            $row['qoh'] = intval($row['qoh']);
            
            $pk['id'] = $row['category'];
            if ( $cat->findByPK($pk, true))
                $row['category'] = $cat->getRowArray();
            
            $pk['id'] = $row['seller_id'];
            if ( $seller->findByPK($pk, true))
                $row['seller'] = $seller->getRowArray();
          
            unset($row['seller_id']); // remove
            
            
            $images = $itemImage->findImagesBy($row['id']);
            $row['images'] = $images;
            
            $res[$r] = $row;
        }
    }
    
    
    
}
?>
