<?php 
session_start();



include_once "conexionBD.inc";

$nombre = $_POST['nombre'];
$email = $_POST['email'];
$uni = $_POST['uni'];
$titulo = $_POST['titulo'];
$tema=$_POST['tema'];


$query= $link ->query("INSERT INTO Alumno(email,nombre,universidad,titulo,tema) VALUES('".$email."','".utf8_decode($nombre)."','".$uni."','".utf8_decode($titulo)."','".utf8_decode($tema)."')");

if(!$query)
	$_SESSION['ok2']=0;
else
	$_SESSION['ok2']=1;

header('Location: index.php#contact2');


include_once "desconexionBD.inc";

?>
