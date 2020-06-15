<?php

$hostname = "localhost";
$username = "id12916651_clothesmap";
$password = "Amr2549315#7";
$db_name  = "id12916651_products";

$db = new mysqli($hostname, $username, $password, $db_name);
$db->query("SET NAMES utf8");
$db->query("SET CHARACTER SET UTF8");

if ($db->connect_error) {
    die('connection failed');
}

?>