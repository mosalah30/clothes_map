<?php

require_once('db_connection.php');

$northBounds = $_POST['north'];
$southBounds = $_POST['south'];
$westBounds = $_POST['west'];
$eastBounds = $_POST['east'];

$getMarkersSql = "SELECT shops.shop_id, shops.owner_id, shops.shopName, shops.latitude, shops.longitude,
 shops.markerExtension, dealers.dealerName, dealers.phoneNumber
 FROM `shops` INNER JOIN  `dealers` ON shops.owner_id=dealers.id
  WHERE (`latitude` BETWEEN $southBounds AND $northBounds) AND 
 (`longitude`) BETWEEN  $westBounds AND $eastBounds";

$response = $db->query($getMarkersSql);

$result = array();

while($row = mysqli_fetch_assoc($response)) {
    $result[] = $row;
}

echo json_encode($result);

?>