<?php

require_once('db_connection.php');

$customerEmail = $_POST['customerEmail'];
$newName = $_POST['newName'];
$newAddress = $_POST['newAddress'];
$newPhoneNum = $_POST['newPhoneNum'];
$newPassword = $_POST['newPassword'];

$updateSql = "UPDATE
`customers`
SET
`name` = '$newName',
`address` = '$newAddress',
`phoneNumber` = '$newPhoneNum',
`password` = '$newPassword'
WHERE
`email` = '$customerEmail'";

$db->query($updateSql);

$result = $db->query("SELECT * FROM `customers` WHERE `email` = '$customerEmail'")->fetch_array();
$newData =  json_encode($result);
echo $newData;
?>
