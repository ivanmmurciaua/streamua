<?php

include('../../db/database.php');

$idNovedades = $_POST['idNovedades'];
$titulo = $_POST['titulo'];
$descripcion = $_POST['descripcion'];
$fechaSalida = $_POST['fechaSalida'];
$emailAdministrador = $_POST['emailAdministrador'];

$qry = "UPDATE Novedades SET titulo='$titulo', descripcion='$descripcion', emailAdministrador='$emailAdministrador', fechaSalida=$fechaSalida WHERE idNovedades ='idNovedades'";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "La novedad ha sido modificada de la base de datos.";
}

$conn->close();

?>