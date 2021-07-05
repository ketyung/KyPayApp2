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
        Log::printRToErrorLog($input);
        
        return $this->notFoundResponse();
    }
    
    
    protected function createOrder($input) {
        
        $orders = $input['order'];
        
        $order =  new Order($this->db);
      
        if ($order->insert ($input)){
            
            
        }
        
    }
    
    
    protected function getDbObjects(){
            
        echo "n/a";
    }
}

?>
