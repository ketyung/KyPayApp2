<?php
/**require_once "lib/Rapyd/WalletRequest.php";
require_once "lib/Rapyd/CollectRequest.php";

//$r = new WalletRequest();
//$data = $r->getPaymentMethodOptions("my_cimb_bank");
//$data = $r->getRequiredFields("my_cimb_bank");

$r = new CollectRequest();

$data = $r->getPaymentMethods("US");

print_r($data);*/
?>
<!DOCTYPE html>
<html>
   <body>
      <h2>Web page redirects after 5 seconds.</h2>
    <script>
    let r = Math.floor(Math.random() * 10) + 1;
    var url = "https://techchee.com/KyPaySuccess";
    if ( r % 2 == 1){
        url = "https://techchee.com/KyPayFailed";
    }

   setTimeout(function(){
      window.location.href = url;
   }, 5000);
</script>
   </body>
</html>

