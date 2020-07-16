<?php

require_once('db_connection.php');

$email = $_POST['email'];
$password = $_POST['password'];

$userLoginSql = "SELECT * FROM `customers` WHERE `email` = '$email' AND `password` = '$password'";

$signedInWithFacebookSql = "SELECT * FROM `customers` WHERE `email` = '$email'
 AND `password` = '%facebook%heda7'";

 $signedInWithGoogleSql = "SELECT * FROM `customers` WHERE `email` = '$email'
 AND `password` = '%google%heda7'";

$checkEmailExistenceSql = "SELECT * FROM `customers` WHERE `email` = '$email'";

$response = $db->query($userLoginSql);

if($response->num_rows == 1){
    $result = $response->fetch_array();
    echo json_encode($result);
}
else if ($db->query($signedInWithGoogleSql)->num_rows == 1){
    echo "SignedInWithGoogle";
}
else if ($db->query($signedInWithFacebookSql)->num_rows == 1){
    echo "SignedInWithFacebook";
}
else if ($db->query($checkEmailExistenceSql)->num_rows == 1){
    echo 'WrongPassword';
}
else{
    echo 'EmailNotFound';
}

?>