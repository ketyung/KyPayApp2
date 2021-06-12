<?php
require_once "RapydRequest.php";

class CollectRequest extends RapydRequest{


	function getSupportedCountries(){
		
		return $this->request("get","/v1/data/countries");		
	}
		
	function getPaymentMethods($countryCode = 'MY'){
		
		$object = $this->request('get', '/v1/payment_methods/country?country='.$countryCode);
		return $object;
	}
}
?>
