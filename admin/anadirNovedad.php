<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/estilosIndex.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>
</head>

<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>

        <a href="#" class="activo">Inicio</a>
        <a href="#">Mi lista</a>
      </nav>
    </div>
  </header>

  <!-- HACER AQUI COSAS -->
  Titulo
    <input type="text" id="titulo" name="titulo">
  <br><br><br>
  Descripcion
    <input type="text" id="descripcion" name="descripcion">
  <br><br><br>
  Fecha salida
    <input type="date" id="fechaSalida" name="fechaSalida">
  <br><br><br>

    emailAdministrador
    <input type="text" id="emailAdministrador" name="emailAdministrador">
  <br><br><br>

  <input id="fservice" class="send" value="Enviar" type="button"></input> 
  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">
$(document).ready(function() {
  $('#fservice').on('click', function(){
    var titulo = document.getElementById('titulo').value;
    var descripcion = document.getElementById('descripcion').value;
    var fechaSalida = document.getElementById('fechaSalida').value;
    var emailAdministrador = document.getElementById('emailAdministrador').value;
    $.ajax({
      type: 'POST',
      url: 'cruds/anadirNovedad.php',
      data: {titulo:titulo, descripcion:descripcion,fechaSalida:fechaSalida,emailAdministrador:emailAdministrador},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });
});
</script>

<!-- Footer -->
<footer class="bg-light text-center text-lg-start">
  <!-- Grid container -->
  <div class="container p-4">

  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    GI 2020/21
    <a class="text-dark" href="http://streamua.ddnsking.com/">StreamUA</a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->

</html>