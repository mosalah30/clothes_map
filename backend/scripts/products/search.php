<?php

require_once("db_connection.php");

$keyword = $_POST['search_keyword'];
$requestedPage = $_POST['nextPage'];

$receivedSearchResults = ($requestedPage - 1) * 10;

$searchSql = "SELECT * FROM `regular_products` WHERE `description` LIKE '%$keyword%' 
LIMIT $receivedSearchResults, 10";

$response = $db->query($searchSql);

$result = array();

while($row = mysqli_fetch_assoc($response)) {
    $result[] = $row;
}

echo json_encode($result);

?>