<?php 
session_start();
include_once "conexionBD.inc";

$usuario = $_POST['login-name'];
$clave = $_POST['login-pass'];

$consulta = "SELECT * FROM usuario WHERE email = '$usuario' and contrasena = '$clave';";
//echo $consulta;
$query=$link -> query("SELECT * FROM usuario WHERE email = '$usuario' and contrasena = '$clave';");

if($row = mysqli_fetch_array($query))
//Validamos si el nombre del administrador existe en la base de datos o es correcto
 {
  //Si el usuario es correcto ahora validamos su contraseña
   if($row["contrasena"] == $clave)
   {
   	   if($row['estado'] == 'Inactivo'){
   	   	
   	   	   $query2 = $link ->query("UPDATE usuario SET estado='Activo' WHERE email = '$usuario';");
   	   }
    //Creamos sesión
    
    //Almacenamos el nombre de usuario en una variable de sesión usuario
    $_SESSION["usuario"] = $usuario;
    //Redireccionamos a la pagina: admin.php
      header('Location: admin.php');
   }
 }
 else
 {
  //En caso que la contraseña sea incorrecta enviamos un msj y redireccionamos a login.php
  $_SESSION["error"]=1;
  header('Location: indexAdmin.php');
 }
  //Mysql_free_result() se usa para liberar la memoria empleada al realizar una consulta
  mysql_free_result($result);

  /*Mysql_close() se usa para cerrar la conexión a la Base de datos y es
  **necesario hacerlo para no sobrecargar al servidor, bueno en el caso de
  **programar una aplicación que tendrá muchas visitas ;) .*/
  mysql_close();
?>
