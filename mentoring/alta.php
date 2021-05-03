<?php 
session_start();


include_once "conexionBD.inc";

$nombre = $_POST['nombre'];
$email = $_POST['email'];
$uni = $_POST['uni'];
$emailAlu = $_POST['alumno'];


$query= $link ->query("INSERT INTO Mentor(email,nombre,universidad) VALUES('".$email."','".utf8_decode($nombre)."','".$uni."')");

$query2= $link ->query("INSERT INTO Mentoring(emailMentor,emailAlumno) VALUES('".$email."','".$emailAlu."')");

if($query && $query2)
	$_SESSION['ok']=1;
else
	$_SESSION['ok']=0;

header('Location: index.php#contact');


include_once "desconexionBD.inc";

?>
