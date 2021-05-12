<?php

session_start();
include('../db/database.php');

$id = $_POST['id'];
$usuario = $_POST['usu'];
$password = $_POST['pwd'];

/*
	Comprobamos usu y pwd en la BBDD, si sale a falso, pos gg bro
	SELECT AES_DECRYPT(AES_ENCRYPT(Usuario.password,'1234'),'1234') FROM Usuario WHERE Usuario.email LIKE '$usuario' == SELECT AES_ENCRYPT('ivan','1234') AS 'escrita'
*/


	if($_SESSION['logged'] = $id) {
		echo  "Sesión iniciada";
	} else {
		echo "Error al iniciar sesión";
	}

?>