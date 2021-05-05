<?php

/*---------------------- NO FUNCIONA, HACERLO X PROCEDURE-----------------------*/

include('../../db/database.php');

$idContenido = $_POST['idContenido'];


$qry = "DELETE from Contenido where idContenido = $idContenido";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El contenido '$titulo' se ha borrado con exito.";
}

$conn->close();

?>