<!DOCTYPE html>
<html lang="es">


<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/admin.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>

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
    Fecha expiracion
    <input type="date" id="fechaExpiracion" name="fechaExpiracion">
  <br><br><br>
  	Descuento (%)
    <input type="number" id="descuento" name="descuento">
  <br><br><br>
    emailAdministrador
    <input type="text" id="emailAdministrador" name="emailAdministrador">
  <br><br><br>

  <input id="fservice" class="send" value="Enviar" type="button"></input> 

</body>

<script type="text/javascript">
$(document).ready(function() {
  $('#fservice').on('click', function(){
    var fechaExpiracion = document.getElementById('fechaExpiracion').value;
    var descuento = document.getElementById('descuento').value;
    var emailAdministrador = document.getElementById('emailAdministrador').value;
    $.ajax({
      type: 'POST',
      url: 'cruds/anadirCodigoPromocion.php',
      data: {fechaExpiracion:fechaExpiracion, descuento:descuento, emailAdministrador:emailAdministrador},
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