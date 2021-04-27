<?php

$account_id = "" ;
$token = "" ;

if ( isset( $_GET['account_id'] ) ) {

$account_id = $_GET['account_id'];
$token = $_GET['token'];

$servername = "localhost";
$dbname     = "fenix";
$username   = "admin";
$password   = "qwerty794613Q!";

$conn = new mysqli($servername, $username, $password, $dbname);

$sql = "insert into tbl_token ( account_id , value ) values ( '".$account_id."' , '".$token."' )";
$result = $conn->query($sql);

$conn->close();

}

?>
