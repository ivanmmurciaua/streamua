<?php

include('../../db/database.php');

$nombre = $_POST['nombre'];
$ap1 = $_POST['ap1'];
$ap2 = $_POST['ap2'];
$tiposusc = $_POST['tiposusc'];
$idioma = utf8_encode($_POST['idioma']);
$email = $_POST['email'];
$password = $_POST['password'];

$qry = "call registrarUsuario('$email','$ap1','$ap2','$idioma',0,'$tiposusc',4,'$password','$nombre')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El usuario ha sido añadido a la base de datos.";
}

$conn->close();

?>