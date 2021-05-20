<?php

include('../db/database.php');

 $archivo = $_FILES["archivito"]["tmp_name"]; 
 $tamanio = $_FILES["archivito"]["size"];
 /*$tipo    = $_FILES["archivito"]["type"];
 $nombre  = $_FILES["archivito"]["name"];
 $titulo  = $_POST["titulo"];*/

 if ( $archivo != "none" )
 {
    $fp = fopen($archivo, "rb");
    $caratula = fread($fp, $tamanio);
    $caratula = addslashes($caratula);
    fclose($fp);

    $res = mysqli_query($conn, "UPDATE Contenido SET imagenPortada = '$caratula' WHERE idContenido = 1846");

    if(mysql_affected_rows($res) > 0)
       print "Se ha guardado el archivo en la base de datos.";
    else
       print "NO se ha podido guardar el archivo en la base de datos.";
 }
 else
    print "No se ha podido subir el archivo al servidor";