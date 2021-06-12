<?php
session_start();

  $email = $_SESSION['emailusu'];

?>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/admin2.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>
</head>
<style type="text/css">
  .label{
    color:white;
  }
  #subir{
    font: inherit;
    line-height: normal;
    cursor: pointer;
    background: #E8474C;
    color: white;
    font-weight: bold;
    width: auto;
    margin-left: auto;
    font-weight: bold;
    padding-left: 2em;
    padding-right: 2em;
  }
</style>

<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="../index.php">Inicio</a>
        <a href="anadirContenido.php">Añadir Contenido</a>
        <a href="listarContenido.php">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="#" class="activo">Añadir Caratula</a>
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
      </nav>
    </div>
  </header>


  <!-- HACER AQUI COSAS -->

<form enctype="multipart/form-data" action="./cruds/anyadirPortada.php" method="post">
  <p class='field required half'>
    <label class='label'>idContenido</label>
    <input class='text-input' id='idContenido' name='idContenido' required type='number'>
  </p>
  <p class='field required half'>
     <label class='label'>Caratula</label>
    <input class='text-input' id='archivito' name='archivito' required type='file'>
  </p>
  <p class='field half'>
    <input id="subir" type="submit" value="Subir portada">
  </p>
</form>
  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>


</html>