<?php

include('../db/database.php');

$idCodProm = $_POST['codProm'];


$qry = "DELETE from CodigoPromocion where codProm=$idCodProm";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El codigo de promocion '$idCodProm' se ha borrado con exito.";
}

$conn->close();

?>