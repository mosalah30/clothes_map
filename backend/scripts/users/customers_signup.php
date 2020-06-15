<?php

require_once('db_connection.php');

$name = $_POST['name'];
$email = $_POST['email'];
$phoneNumber = $_POST['phoneNumber'];
$address = $_POST['address'];
$password = $_POST['password'];
$avatarExtension = $_POST['avatarExtension'];

$userCreationSql = "INSERT INTO
  `customers` (
   `id`,
    `name`,
    `email`,
    `phoneNumber`,
    `address`,
    `password`,
    `avatarExtension`
  )
VALUES
  (
    NULL,
    '$name',
    '$email',
    '$phoneNumber',
    '$address',
    '$password',
    '$avatarExtension'
  )";

$response = $db->query($userCreationSql);

if ($response == TRUE) {
    echo "New user added successfully";
} else {
    echo 'Error';
}

?>