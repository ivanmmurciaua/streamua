<?php
//ob_start();
session_start();
//
// Cerrar sesión
//unset($_SESSION['logged']);
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css" integrity="sha384-G0fIWCsCzJIMAVNQPfjH08cyYaUtMwjJwqiRKxxE/rx96Uroj1BtIQ6MLJuheaO9" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
  <link rel="stylesheet" href="css/estilosIndex.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="./css/admin2.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <title>StreamUA</title>
</head>
<style type="text/css">
  .row {
    display: flex;
    flex-wrap: wrap;
  }

  .col {
    flex: 1 0 18%;
    margin: 5px;
    background: #E50914;
    height: 150px;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .heart{
    color: #FFF;
    display: block;
    font-size: 50px;
    margin-top: 1px;
    margin-before: 5px;
    margin-bottom: 0px;
    margin-start: 0; 
    margin-end: 0;
    text-align:right;
    font-weight: bold; 
    float: right;
  }
}

</style>
<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="index.php">Inicio</a>
        <a href="series.php">Series</a>
        <a href="peliculas.php">Películas</a>

  </header>

  
  <div class="wrapper">
    
  <div class="call-text">
    <br />
    <form action='' class='form'>
      <p class='field required half'>
        <label class='label'>Nombre</label>
        <input class='text-input' id='nombre' name='nombre' type='text'>
      </p>
      <p class='field required half'>
        <label class='label'>Apellido 1</label>
        <input class='text-input' id='ap1' name='ap1' required type='text'>
      </p>
      <p class='field half required'>
        <label class='label'>Apellido 2</label>
        <input class='text-input' id='ap2' name='ap2' required type='text'>
      </p>
        <p class='field half required'>
        <label class='label'>Idioma</label>
        <input class='text-input' id='idioma' name='idioma' required type='text'>
      </p>
        <p class='field half required'>
        <label class='label'>Tipo suscripción</label>
        <input class='text-input' id='tiposusc' name='tiposusc' required type='text'>
      </p>
      <p class='field required half'>
        <label class='label'>Email</label>
        <input class='text-input' id='email' name='email' required type='text'>
      </p>
      <p class='field half required error'>
        <label class='label'>Password</label>
        <input class='text-input' id='password' name='password' required type='password'>
      </p>
      <p class='field half'>
        <input id="fservice" class="button" value="Registrarme" type="button"></input>
      </p>
    </form>
  </div>
  </div>
</body>

<script type="text/javascript">
$(document).ready(function() {
  
  $('#fservice').on('click', function(){

    var nombre = $('#nombre').val();
    var ap1 = $('#ap1').val();
    var ap2 = $('#ap2').val();
    var tiposusc = $('#tiposusc').val();
    var idioma = $('#idioma').val();
    var email = $('#email').val();
    var password = $('#password').val();

    $.ajax({
      type: 'POST',
      url: 'admin/cruds/registro.php',
      data: {nombre:nombre, ap1:ap1, ap2:ap2, tiposusc:tiposusc, idioma:idioma, email:email, password:password},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });
});
</script>


</html>