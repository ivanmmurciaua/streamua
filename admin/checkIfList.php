<?php

include('../db/database.php');

$idContenido = $_POST['idContenido'];
$emailcliente = $_POST['emailcliente'];

$qry = "SELECT * FROM Lista WHERE idContenido=$idContenido AND emailCliente LIKE '$emailcliente'";
$resultado = $conn->query($qry);
echo count($resultado->fetch_assoc());

$conn->close();

?>