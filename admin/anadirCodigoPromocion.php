<!DOCTYPE html>
<html lang="es">


<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/admin2.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>

<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="#" class="activo">Inicio</a>
        <a href="anadirContenido.php">Añadir Contenido</a>
        <a href="listarContenido.php">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="listarContenido.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
      </nav>
    </div>
  </header>

<form action='' class='form'>
  <p class='field required'>
    <label class='label required' for='name'>Fecha expiracion</label>
    <input class='text-input' id='fechaExpiracion' name='fechaExpiracion' required type='date'>
  </p>
  <p class='field required half'>
    <label class='label' for='email'>Descuento (%)</label>
    <input class='text-input' id='descuento' name='descuento' required type='number'>
  </p>
  <p class='field half error'>
    <label class='label' for='phone'>emailAdministrador</label>
    <input class='text-input' id='emailAdministrador' name='emailAdministrador' type='text'>
  </p>
  
  <p class='field half'>
    <input id="fservice" class="button " value="Enviar" type="button"></input>
  </p>
</form>

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


</html>