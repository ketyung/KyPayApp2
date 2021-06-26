<?php
require_once "bootstrap.php";
use Util\Log as Log;

Log::printRToErrorLog($_REQUEST);
?>
<html lang="en-US"><head><title>Payment Success - KyPay</title><meta
charset="UTF-8" /><meta name="viewport" content="width=device-width, initial-scale=1" />
<style>body {font-family:verdana,arial;font-size:12pt;}
.mybox {font-size:30pt;margin:auto;max-width:400px;max-height:500px;min-height:100px;border-radius:25px;
background:#8D2111;color:white;padding:60px 30px 20px 30px;}</style>
</head><body><center><p>&nbsp;</p><p>&nbsp;</p>
<div class="mybox">Payment Failure!</div></center>
</body></html>
