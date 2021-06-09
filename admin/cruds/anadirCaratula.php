<?php

session_start();

include('../../db/database.php');

 $archivo     = $_FILES["archivito"]["tmp_name"]; 
 $tamanio     = $_FILES["archivito"]["size"];
 $idContenido = $_POST["idContenido"];

 if ( $archivo != "none" ){
    $fp = fopen($archivo, "rb");
    $caratula = fread($fp, $tamanio);
    $caratula = addslashes($caratula);
    fclose($fp);

    $res = mysqli_query($conn, "UPDATE Contenido SET imagenPortada = '$caratula' WHERE idContenido = $idContenido");
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../../css/estilosIndex.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>
</head>
<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="../listarContenido.php">Volver a admin</a>
      </nav>
    </div>
  </header>
  <h1 style="color:white"> Carátula añadida </h1>
</body>

</html>