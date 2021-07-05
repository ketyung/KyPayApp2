<?php
namespace Core\Controllers;

use Core\Db\KypaySellerItem as Item;
use Core\Db\KypayUser as User;
use Core\Db\KypayUserWallet as Wallet;
use Core\Db\KypaySellerItemImage as ItemImage;
use Core\Db\KypaySellerCategory as Category;
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
    
    protected function getDbObjects(){
            
        echo "n/a";
    }
}

?>
