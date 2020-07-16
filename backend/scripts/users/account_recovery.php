<?php

require_once("db_connection.php");

$phoneNum = $_POST["phoneNum"];
$newPassword = $_POST["newPassword"];
$userType = $_POST["userType"];

$updatePasswordSql = "UPDATE `$userType` SET `password` = '$newPassword'
WHERE `phoneNumber` = '$phoneNum'";

$response = $db->query($updatePasswordSql);

if($db->affected_rows >= 0){
    echo "AccountRecovered";
}
else{
    echo "failed";
}
?>