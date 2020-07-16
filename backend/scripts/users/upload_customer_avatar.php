<?php

require_once("../../constants.php");

echo $upload_point;

$image = $_POST['image'];
$filePath = $upload_point . $_POST['fileName'];

$real_image = base64_decode($image);

file_put_contents($filePath, $real_image);

?>