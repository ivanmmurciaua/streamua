<?php

include('../../db/database.php');

$codProm = $_POST['codProm'];
$fechaExpiracion = $_POST['fechaExpiracion'];
$descuento = $_POST['descuento'];

$qry = "UPDATE CodigoPromocion SET fechaExpiracion='$fechaExpiracion', descuento=$descuento WHERE codProm = '$codProm'";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El codigo promocional ha sido modificado de la base de datos.";
}

$conn->close();

?>