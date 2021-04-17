<?php 
session_start();
//validamos si se ha hecho o no el inicio de sesion correctamente
if(!isset($_SESSION['usuario']))
{
	header('Location: indexAdmin.php');
}
?>
