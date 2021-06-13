<?php
require_once "bootstrap.php";
use Util\DotEnv as DotEnv;
DotEnv::load_by("/config/.env");


$clientId     = getenv('OKTA_CLIENT_ID');
$clientSecret = getenv('OKTA_CLIENT_SECRET');
$scope        = getenv('OKTA_SCOPE');
$issuer       = getenv('OKTA_ISSUER');

// obtain an access token
$token = obtainToken($issuer, $clientId, $clientSecret, $scope);
header('Content-type:text/plain');

getUser($token,"Yon_pgP5FOzMeJM2");


function getUser($token, $id) {
    echo "Getting user with id#$id...\n";
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, "http://localhost:808/user/id/" . $id);
    curl_setopt( $ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        "Authorization: $token"
    ]);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);

    var_dump($response);
}

function obtainToken($issuer, $clientId, $clientSecret, $scope)
{
    // prepare the request
    $uri = $issuer . '/v1/token';
    $token = base64_encode("$clientId:$clientSecret");
    
    
    $payload = http_build_query([
        'grant_type' => 'client_credentials',
        'scope'      => $scope
    ]);

    
    
    
    // build the curl request
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $uri);
    curl_setopt( $ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/x-www-form-urlencoded',
        "Authorization: Basic $token"
    ]);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // process and return the response
    $response = curl_exec($ch);
    $response = json_decode($response, true);
    if (! isset($response['access_token'])
        || ! isset($response['token_type'])) {
        exit('failed, exiting.');
    }

    // here's your token to use in API requests
    return $response['access_token'];
}
?>
