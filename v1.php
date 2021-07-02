<?php

include 'config.php';

$cookie=$_COOKIE['fingerprint'];

if (is_null($cookie) == 1) {
    $cookie=bin2hex(random_bytes(5));
    setcookie('fingerprint',$cookie);
}

$conn = new mysqli($host, $username, $password, $database);

$session='g'.bin2hex(random_bytes(3));

$sql = "insert into tbl_session ( fingerprint, session ) values ('".$cookie."','".$session."')";
$result = $conn->query($sql);

$conn->close();

echo "Usuario: "."<br>".$session;

?>
