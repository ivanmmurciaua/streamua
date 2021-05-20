<?php
include('../db/database.php');
session_start();
echo 'session_id(): ' . session_id();

$resultado = mysqli_query($conn,"SELECT AES_ENCRYPT('ivan','1234') AS 'escrita'");

echo "<br />";

while ($fila = $resultado->fetch_assoc()) {
    $ecn = utf8_encode($fila["escrita"]);
    echo $ecn;
}

echo "<br />";

$usuario = 'b@gmail.com';

$resultado2 = mysqli_query($conn,"SELECT AES_DECRYPT(AES_ENCRYPT(Usuario.password,'1234'),'1234') AS 'original' FROM Usuario WHERE Usuario.email LIKE '$usuario'");

while ($fila2 = $resultado2->fetch_assoc()) {
    $encc = utf8_encode($fila2["original"]);
    echo $encc;
}

echo "<br />";

if(strcmp($ecn, $encc) == 0){
	echo "funca";
}
else{
	echo "no funca mike";
}

?>

<form enctype="multipart/form-data" action="guardar_archivo.php" method="post">
Descripción <input type="text" name="titulo" size="30">
Caratula <input type="file" name="archivito">
<input type="submit" value="Enviar archivo">
</form>

<?php
$sql = "SELECT * FROM Contenido WHERE idContenido = 1845";
$sth = $conn->query($sql);
$result=mysqli_fetch_array($sth);
echo '<img src="data:image/jpeg;base64,'.base64_encode( $result['imagenPortada'] ).'"/>';
?>