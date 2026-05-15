<?php

$host = "mariadb";
$username = "cs332b21";
$password = "BauIcWf8";
$database = "cs332b21";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Database connection failed: " . $conn->connect_error);
}
?>