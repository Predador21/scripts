<?php

$cookie = $_COOKIE['session'];

if (is_null($cookie ) == 1) {

   echo "nao existe o cookie";
   setcookie('session', 'V2X9A7K3');

}

?>

<?php
$dbname     = "fenix";
$username   = "admin";
$password   = "qwerty794613Q!";

$cookie = $_COOKIE['session'];

$conn = new mysqli($servername, $username, $password, $dbname);

$sql = "insert into tbl_session ( cookie ) values ( '".$cookie."')";
$result = $conn->query($sql);

echo "Valor do Cookie: $cookie";

$conn->close();
?>
