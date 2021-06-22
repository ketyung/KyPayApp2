//
//  WalletContactRequest.php
//  KyPayApp2
//
//  Created by Chee Ket Yung on 22/06/2021.
//
<?php
require_once "RapydRequest.php";

class WalletContactRequest extends RapydRequest{
    
    function getAllContacts($walletId){
        
        return $this->request("get","/v1/ewallets/$walletId/contacts");
    }
 
}
?>
