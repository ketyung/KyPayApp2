<?php
namespace Core\Controllers;

use Core\Db\KypayOrder as Order;
use Core\Db\KypayUser as User;
use Core\Db\KypayUserWallet as Wallet;
use Core\Db\KypaySellerOrder as SellerOrder;
use Core\Db\KypaySellerOrderItem as SellerOrderItem;
use Core\Db\KypayUserPaymentTx as Tx;
use Core\Db\KypaySeller as Seller;
use Core\Controllers\RequestMethod as RM;
use Core\Controllers\Controller as Controller;
use Util\Log as Log;
use Util\StrUtil as StrUtil;

class KypayOrderController extends Controller {
    

    protected function createDbObjectFromRequest(){
    
        $response['status_code_header'] = 'HTTP/1.1 202 Order Completed';
       
        $input = $this->getInput();
        Log::printRToErrorLog($input);
      
        $this->createOrder($input);
        
        $response['body'] = json_encode(array('status'=>1, 'id'=>"none", 'text'=>'Order Completed!'));
    
        return $response;
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
                
                // add the amount to the seller's wallet id
                $this->updateWalletOf($sellerorder['seller']['uid'], $sellerorder['seller']['wallet_ref_id'], $sellerorder['total']);
                // insert a payment transaction for recording purposes
                
                $this->addPaymentTx($input['uid'], $sellerorder['seller']['uid'],
                        $input['wallet_ref_id'], $sellerorder['seller']['wallet_ref_id'],
                        $sellerorder['total'],$input ['payment_method'],
                        "Payment For Order:".$so['id'], $sellerorder['service_payment_id']);
                
            }
         
            // if the payment method is wallet transfer
            if ($input ['payment_method'] == 'kypay_wallet_transfer') {
          
                // deduct the amount from the buyer's wallet
                $this->updateWalletOf($input['uid'], $input['wallet_ref_id'], -floatval($input['total']));
         
            }
          
          
        }
        
    }
    
    
    protected function updateWalletOf ($uid, $refId, $amount) {
        
        $wallet = new Wallet($this->db);
        $pk = array('id'=>$uid, 'ref_id' => $refId);
        
        if ($wallet->findByPK($pk, true)){
            
            $row = $wallet->getRowArray();
            $balance = $row['balance'] + $amount ;
            
            $walletWithNewBalance = array('id'=>$row['id'], 'ref_id'=>$row['ref_id'], 'balance' => $balance);
            
            $wallet->update($walletWithNewBalance);
            
        }
    }
    
    
    protected function addPaymentTx($fromUid, $toUid, $fromWalletRefId,
    $toWalletRefId, $amount, $method, $note, $serviceId){
        
        $tx = new Tx($this->db);
        
        $input = array('uid'=>$fromUid, 'to_uid'=>$toUid, 'wallet_ref_id'=>$fromWalletRefId,
                    'to_wallet_ref_id'=>$toWalletRefId, 'amount'=> -$amount, 'method'=>$method,
                    'note'=>$note, 'service_id'=> $serviceId,'tx_type'=>'OP');
        
        $tx->insert($input);
        
    }
    
    
    protected function getDbObjects(){
            
        echo "n/a";
    }
}

?>
