<?php

session_start();
include('../db/database.php');
error_reporting(0);

$id = $_POST['id'];
$usuario = $_POST['usu'];
$password = $_POST['pwd'];

/*
	Comprobamos usu y pwd en la BBDD, si sale a falso, pos gg bro
	SELECT AES_DECRYPT(AES_ENCRYPT(Usuario.password,'1234'),'1234') FROM Usuario WHERE Usuario.email LIKE '$usuario' == SELECT AES_ENCRYPT('ivan','1234') AS 'escrita'
*/

$resultado = mysqli_query($conn,"SELECT AES_ENCRYPT('$password','1234') AS 'escrita'");

while ($fila = $resultado->fetch_assoc()) {
    $ecn = utf8_encode($fila["escrita"]);
}

$resultado2 = mysqli_query($conn,"SELECT AES_DECRYPT(AES_ENCRYPT(Usuario.password,'1234'),'1234') AS 'original' FROM Usuario WHERE Usuario.email LIKE '$usuario'");

while ($fila2 = $resultado2->fetch_assoc()) {
    $encc = utf8_encode($fila2["original"]);
}

if(strcmp($ecn, $encc) == 0){
	if($_SESSION['logged'] = $id) {
		$_SESSION['emailusu'] = $usuario;
		$_SESSION['iniciado'] = 1;
		$data["iniciado"] = 1;
	}

	$resultado3 = mysqli_query($conn,"SELECT tipoUsuario('$usuario') AS 'tipoUsu'");
	while ($fila3 = $resultado3->fetch_assoc()) {
		$tipoUsuario = $fila3['tipoUsu'];
	}

	if($tipoUsuario== 1){
		$_SESSION['admin'] = 1;
	}

	$data["tipoUsu"] = $tipoUsuario;
	
}
else{
	$data["iniciado"] = 0;
	echo "Error con el usuario/contraseña";
}

echo json_encode($data);

?>