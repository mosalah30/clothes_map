<?php

require_once('db_connection.php');

$section = $_POST['section'];
$minPrice = $_POST['minPrice'];
$maxPrice = $_POST['maxPrice'];
$requestedPage = $_POST['nextPage'];

$receivedRegularProducts = ($requestedPage - 1) * 10;

$getPageSql = "SELECT * FROM `regular_products` WHERE `section` = '$section'
 ORDER BY `price` LIMIT $receivedRegularProducts, 10";

$response = $db->query($getPageSql);

$result = array();

while($row = mysqli_fetch_assoc($response)) {
    $result[] = $row;
}

echo json_encode($result);

?>