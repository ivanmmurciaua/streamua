<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/cssBotonBorrar.css">
</head>

<body>

  <!-- HACER AQUI COSAS -->
  <?php
  $codProm = $_GET['codProm'];
  ?>

<div><a href="#">
    <p><span class="bg"></span><span class="base"></span><span class="text">¿Seguro que quieres borrar el codigo <?=utf8_encode($codProm)?> ?</span></p></a>
</div>

  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

</html>