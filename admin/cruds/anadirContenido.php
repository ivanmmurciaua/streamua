<?php

include('../db/database.php');

$idContenido = $_POST['idContenido'];
$urlContenido = $_POST['urlContenido'];
$titulo = $_POST['titulo'];
$resumen = $_POST['resumen'];
$idioma = $_POST['idioma'];
$subtitulos = $_POST['subtitulos'];
$actores = $_POST['actores'];
$director = $_POST['director'];
$emailAdministrador = $_POST['emailAdministrador'];
$tipoGenero = $_POST['tipoGenero'];

$qry = "call añadirContenido($idContenido,'$urlContenido','$titulo','$resumen','$idioma','$subtitulos','$actores','$director','$emailAdministrador','$tipoGenero')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El contenido '$titulo' ha sido añadido a la base de datos.";
}

$conn->close();

?>