<?php
require_once "lib/Rapyd/CollectRequest.php";

$r = new CollectRequest();
$data = $r->getSupportedCountries();

print_r($data);
?>
