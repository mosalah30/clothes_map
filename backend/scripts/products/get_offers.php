<?php

require_once('db_connection.php');

$requestedPage = $_POST['nextPage'];
$tableName = $_POST['tableName'];

$receivedHotOffers = ($requestedPage - 1) * 10;

$getPageSql = "SELECT * FROM `$tableName` ORDER BY `id` DESC LIMIT $receivedHotOffers, 10";

$response = $db->query($getPageSql);

$result = array();

while($row = mysqli_fetch_assoc($response)) {
    $result[] = $row;
}

echo json_encode($result);

?>