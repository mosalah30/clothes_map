<?php

require_once('db_connection.php');

$email = $_POST['email'];

$response = $db->query("SELECT * FROM `customers` WHERE email = '$email'");
$already_exists = $response->num_rows == 1;
echo $already_exists ? "true" : "false";

?>