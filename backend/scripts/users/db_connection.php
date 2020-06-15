<?php

$hostname = "localhost";
$username = "id12916651_clothes_map";
$password = "Amr2549315#7";
$db_name  = "id12916651_users";

$db = new mysqli($hostname, $username, $password, $db_name);
$db->query("SET NAMES utf8");
$db->query("SET CHARACTER SET UTF8");

if ($db->connect_error) {
    die('connection failed');
}

?>