<?php

include('../db/database.php');

$idContenido = $_POST['idContenido'];
$emailcliente = $_POST['emailcliente'];

$qry = "INSERT INTO Lista VALUES($idContenido, '$emailcliente')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "Se ha añadido este contenido a tu lista.";
}

$conn->close();

?>