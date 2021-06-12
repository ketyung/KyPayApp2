<?php
require_once "CollectRequest.php";

$r = new CollectRequest();
$data = $r->getSupportedCountries();

print_r($data);
?>
