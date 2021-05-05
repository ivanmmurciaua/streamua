<?php

include('../../db/database.php');

$idNovedades = $_POST['idNovedades'];
$titulo = $_POST['titulo'];

$qry = "DELETE from Novedades where idNovedades=$idNovedades";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "La novedad '$titulo' se ha borrado con exito.";
}

$conn->close();

?>