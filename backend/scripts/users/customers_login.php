<?php

require_once('db_connection.php');

$email = $_POST['email'];
$password = $_POST['password'];

$userLoginSql = "SELECT * FROM `customers` WHERE `email` = '$email' AND `password` = '$password'";
$checkEmailExistenceSql = "SELECT * FROM `customers` WHERE `email` = '$email'";

$response = $db->query($userLoginSql);

if($response->num_rows == 1){
    $result = $response->fetch_array();
    echo json_encode($result);
}
else if ($db->query($checkEmailExistenceSql)->num_rows == 1){
    echo 'Wrong Password';
}
else{
    echo 'Email not found';
}

?>