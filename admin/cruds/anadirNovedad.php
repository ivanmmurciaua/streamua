<?php

include('../../db/database.php');

$titulo = $_POST['titulo'];
$descripcion = $_POST['descripcion'];
$fechaSalida = $_POST['fechaSalida'];
$emailAdministrador = $_POST['emailAdministrador'];

$qry = "INSERT INTO Novedades(titulo,descripcion,fechaSalida,emailAdministrador) VALUES ('$titulo','$descripcion','$fechaSalida','$emailAdministrador')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "La novedad $titulo ha sido añadido a la base de datos.";
}

$conn->close();

?>