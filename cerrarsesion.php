<?php

//ob_start();
session_start();

// Cerrar sesión
unset($_SESSION["logged"]);
unset($_SESSION['iniciado']);
unset($_SESSION['admin']);

?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/estilosIndex.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>
</head>
<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="./index.php">Volver a inicio</a>
      </nav>
    </div>
  </header>
  <h1 style="color:white"> Sesión cerrada, pulse en Inicio para volver a la pantalla principal... </h1>
</body>

</html>