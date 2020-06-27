<?php

require_once('db_connection.php');

$section = $_POST['section'];
$category = $_POST['category'];
$requestedPage = $_POST['nextPage'];

$receivedRegularProducts = ($requestedPage - 1) * 10;

$getPageSql = "SELECT * FROM `regular_products` WHERE `section` = '$section'
AND `category` = '$category'
ORDER BY `price` LIMIT $receivedRegularProducts, 10";

$response = $db->query($getPageSql);

$result = array();

while($row = mysqli_fetch_assoc($response)) {
    $result[] = $row;
}

echo json_encode($result);

?>