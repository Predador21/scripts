<?php

include 'config.php';

$conn = new mysqli($host, $username, $password, $database);

$session = 'g'.bin2hex(random_bytes(3));

$sql = "insert into tbl_session ( session ) values ( '".$session."')";
$result = $conn->query($sql);

$conn->close();

echo "Usuario: "."<br>".$session;

?>
