<?php
session_start();
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

<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="../index.php">Inicio</a>
        <a href="anadirContenido.php">Añadir Contenido</a>
        <a href="listarContenido.php">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="anadirCaratula.php">Añadir Caratula</a>
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="#" class="activo">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
      </nav>
    </div>
  </header>

  <form action='' class='form'>
  <p class='field required'>
    <label class='label required'>Titulo</label>
    <input class='text-input' id='titulo' name='titulo' required type='text'>
  </p>
  <p class='field required half'>
    <label class='label'>Descripcion</label>
    <input class='text-input' id='descripcion' name='descripcion' required type='text'>
  </p>
  <p class='field required half'>
    <label class='label'>Fecha Salida</label>
    <input class='text-input' id='fechaSalida' name='fechaSalida' type='date'>
  </p>
  <p class='field required half error'>
    <label class='label'>emailAdministrador</label>
    <input class='text-input' id='emailAdministrador' name='emailAdministrador' required type='email' value="<?=utf8_encode($_SESSION['emailusu'])?>" readonly="">
  </p>
  <p class='field half'>
    <input id="fservice" class="button" value="Enviar" type="button"></input>
  </p>
</form>
  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">
$(document).ready(function() {
  $('#fservice').on('click', function(){
    var titulo = document.getElementById('titulo').value;
    var descripcion = document.getElementById('descripcion').value;
    var fechaSalida = document.getElementById('fechaSalida').value;
    var emailAdministrador = document.getElementById('emailAdministrador').value;

    if(titulo != "" & titulo != "" & descripcion != "" & fechaSalida != "" & emailAdministrador != "") {

      $.ajax({
        type: 'POST',
        url: 'cruds/anadirNovedad.php',
        data: {titulo:titulo, descripcion:descripcion,fechaSalida:fechaSalida,emailAdministrador:emailAdministrador},
        success: function(data) {
          alert(data);
          window.location.reload();
        }
      });
    }
  });
});
</script>

</html>