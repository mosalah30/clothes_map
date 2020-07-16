<?php

$hostname = "localhost";
$username = "YOUR_USER_NAME";
$password = "YOUR_PASSWORD";
$db_name  = "DATABASE_NAME";

$db = new mysqli($hostname, $username, $password, $db_name);
$db->query("SET NAMES utf8");
$db->query("SET CHARACTER SET UTF8");

if ($db->connect_error) {
    die('connection failed');
}

?>