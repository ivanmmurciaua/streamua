<?php

include('../../db/database.php');

$codProm = $_POST['codProm'];


$qry = "DELETE from CodigoPromocion where codProm=$codProm";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {
	echo "El codigo de promocion '$codProm' se ha borrado con exito.";
}

$conn->close();

?>