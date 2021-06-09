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

<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="../index.php">Inicio</a>
        <a href="#" class="activo">Añadir Contenido</a>
        <a href="listarContenido.php">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="anadirCaratula.php">Añadir Caratula</a>
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
      </nav>
    </div>
  </header>


  <!-- HACER AQUI COSAS -->

<form action='' class='form'>
  <p class='field required half'>
    <label class='label'>URL Contenido</label>
    <input class='text-input' id='urlContenido' name='urlContenido' required type='text'>
  </p>
  <p class='field required half'>
    <label class='label'>Titulo</label>
    <input class='text-input' id='titulo' name='titulo' type='text'>
  </p>
  <p class='field required half'>
    <label class='label'>Resumen</label>
    <input class='text-input' id='resumen' name='resumen' required type='text'>
  </p>
  <p class='field half required'>
    <label class='label'>Idioma</label>
    <input class='text-input' id='idioma' name='idioma' required type='text'>
  </p>
    <p class='field half required'>
    <label class='label'>Subtitulos</label>
    <input class='text-input' id='subtitulos' name='subtitulos' required type='text'>
  </p>
    <p class='field half required'>
    <label class='label'>Actores</label>
    <input class='text-input' id='actores' name='actores' required type='text'>
  </p>
    <p class='field half required'>
    <label class='label'>Director</label>
    <input class='text-input' id='director' name='director' required type='text'>
  </p>
    <p class='field half required'>
    <label class='label'>Genero</label>
    <input class='text-input' id='tipoGenero' name='tipoGenero' required type='text'>
  </p>
  <p class='field half required'>
      <select  id="tipoContenido">
        <option id="1" name="1">Serie</option>
        <option id="2" name="2">Pelicula</option>
      </select>
  </p>
    <p class='field half required error'>
    <label class='label'>Email administrador</label>
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
    var urlContenido = document.getElementById('urlContenido').value;
    var titulo = document.getElementById('titulo').value;
    var resumen = document.getElementById('resumen').value;
    var idioma = document.getElementById('idioma').value;
    var subtitulos = document.getElementById('subtitulos').value;
    var actores = document.getElementById('actores').value;
    var director = document.getElementById('director').value;
    var emailAdministrador = document.getElementById('emailAdministrador').value;;
    var tipoGenero = document.getElementById('tipoGenero').value;
    var tipoContenido = document.getElementById('tipoContenido').value;

    if(urlContenido != "" & titulo != "" & resumen != "" & idioma != "" & subtitulos != "" & actores != "" & director != "" & tipoGenero != "") {

      $.ajax({
        type: 'POST',
        url: 'cruds/anadirContenido.php',
        data: {urlContenido:urlContenido, titulo:titulo, resumen:resumen, idioma:idioma, subtitulos:subtitulos, actores:actores, director:director, emailAdministrador:emailAdministrador, tipoGenero:tipoGenero, tipoContenido:tipoContenido},
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