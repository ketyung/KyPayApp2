<?php
require_once "lib/Rapyd/WalletRequest.php";
require_once "lib/Rapyd/CollectRequest.php";

//$r = new WalletRequest();
//$data = $r->getPaymentMethodOptions("my_cimb_bank");
//$data = $r->getRequiredFields("my_cimb_bank");

$r = new CollectRequest();

$data = $r->getPaymentMethods("US");

print_r($data);
?>
