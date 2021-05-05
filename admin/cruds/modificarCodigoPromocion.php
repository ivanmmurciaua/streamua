<?php

include('../../db/database.php');

$fechaExpiracion = $_POST['fechaExpiracion'];
$descuento = $_POST['descuento'];
$emailAdministrador = $_POST['emailAdministrador'];

$qry = "UPDATE CodigoPromocion SET fechaExpiracion='$fechaExpiracion', descuento=$descuento, emailAdministrador='$emailAdministrador')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El codigo promocional ha sido modificado de la base de datos.";
}

$conn->close();

?>