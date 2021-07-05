<?php
namespace Core\Controllers;

use Core\Db\KypayOrder as Order;
use Core\Db\KypayUser as User;
use Core\Db\KypayUserWallet as Wallet;
use Core\Db\KypaySellerOrder as SellerOrder;
use Core\Db\KypaySellerOrderItem as SellerOrderItem;
use Core\Db\KypaySeller as Seller;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;

class KypayOrderController extends Controller {
    

    protected function createDbObjectFromRequest(){
    
        $input = $this->getInput();
      //  Log::printRToErrorLog($input);
      
        $this->createOrder($input);
        
        return $this->notFoundResponse();
    }
    
    
    protected function createOrder($input) {
        
        $sellerorders = $input['orders'];
        
        $input['date_ordered'] = date('Y-m-d H:i:s');
        
        $order =  new Order($this->db);
        $sorder =  new SellerOrder($this->db);
        $sorderItem =  new SellerOrderItem($this->db);
      
        if ($order->insert ($input)){
            
            //Log::printRToErrorLog($input);
            
            foreach ($sellerorders as $sellerorder){
                
                $so = array('total'=>$sellerorder['total'], 'service_payment_id'=>$sellerorder['service_payment_id'],
                            'order_id'=>$input['id'], 'seller_id'=>$sellerorder['seller']['id'],
                            'currency'=>$input['currency'], 'date_ordered'=>  $input['date_ordered'] );
                $sorder->insert($so);
                
                //Log::printRToErrorLog($order);
                $items = $sellerorder['items'];
                foreach( $items as $item ){
                    
                    $newitem = array ('item_id'=>$item['item']['id'], 'quantity'=>$item['quantity'],
                                      'price' => $item['item']['price'], 'item_name'=>$item['item']['name'], 
                                      'total'=> $item['item']['price'] * $item['quantity'],
                                      'seller_order_id'=>$so['id']);
                    
                    $sorderItem->insert($newitem);
                }
                
                
            }
          
        }
        
    }
    
    
    protected function getDbObjects(){
            
        echo "n/a";
    }
}

?>
