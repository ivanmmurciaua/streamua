<?php
session_start();

$_SESSION['usuario']=false;
header("location: indexAdmin.php");

?>