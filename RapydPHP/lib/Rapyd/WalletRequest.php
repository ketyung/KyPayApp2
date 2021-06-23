<?php
require_once "RapydRequest.php";

class WalletRequest extends RapydRequest{
    
    function getAllContacts($walletId){
        
        return $this->request("get","/v1/ewallets/$walletId/contacts");
    }
 
    
    function getPaymentMethodOptions($paymentType){
        
        try
        {
            $object = $this->request('get', "/v1/payment_methods/required_fields/$paymentType");
        
            return $object;
        }
        catch(Exception $e) {
    
            echo "Error: $e";
        }
    }
    
    
    
    function getRequiredFields($paymentType) {
        try
        {
            $object = $this->request('get', "/v1/payment_methods/required_fields/$paymentType");
            return $object;
        }
        catch(Exception $e) {
            echo "Error: $e";
        }
    }
    
    
    
}
?>
