<?php

$cookie = "" ;
$url = "" ;

if ( isset( $_GET['cookie'] ) ) {

$cookie = $_GET['cookie'];
$url    = $_GET['url'];

$servername = "localhost";
$dbname     = "fenix";
$username   = "admin";
$password   = "qwerty794613Q!";

$conn = new mysqli($servername, $username, $password, $dbname);

$sql = "insert into tbl_url ( url ) values ( '".$url."' )";
$result = $conn->query($sql);

$conn->close();

}

?>
