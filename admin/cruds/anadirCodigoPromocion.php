<?php

include('../../db/database.php');

$fechaExpiracion = $_POST['fechaExpiracion'];
$descuento = $_POST['descuento'];
$emailAdministrador = $_POST['emailAdministrador'];

$qry = "INSERT INTO CodigoPromocion(fechaExpiracion,descuento,emailAdministrador) VALUES ('$fechaExpiracion',$descuento,'$emailAdministrador')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El codigo promocional ha sido añadido a la base de datos.";
}

$conn->close();

?>