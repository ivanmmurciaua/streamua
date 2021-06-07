<?php

include('db/database.php');

$valoracion = $_POST['valoracion'];
$emailCliente = $_POST['emailCliente'];
$idContenido = $_POST['idContenido'];

$qry = "INSERT into Seleccionar(idContenido,emailCliente,puntuacion) VALUES ('$idContenido','$emailCliente','2')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "Se ha añadido la valoración";
}

$conn->close();

?>