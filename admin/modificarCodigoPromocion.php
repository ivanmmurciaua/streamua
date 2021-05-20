<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/cssBotonBorrar.css">
  <link rel="stylesheet" href="../css/admin2.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

  <!-- HACER AQUI COSAS -->
  <?php
  $codProm = $_GET['codProm'];
  $fechaExpiracion=$_GET['fechaExpiracion'];
  $descuento=$_GET['descuento'];
  $emailAdministrador=$_GET['emailAdministrador'];
  ?>

  <form action='' class='form'>
    <label class='label required'>codProm</label>
    <input class='text-input' id='codProm' name='codProm' required type='text' placeholder="<?=utf8_encode($codProm)?>" readonly="">
    <label class='label required'>fechaExpiracion</label>
    <input class='text-input' id='fechaExpiracion' name='fechaExpiracion' required type='date' placeholder="<?=utf8_encode($fechaExpiracion)?>" value="<?=utf8_encode($fechaExpiracion)?>">
    <label class='label required'>Descuento</label>
    <input class='text-input' id='descuento' name='descuento' required type='text' placeholder="<?=utf8_encode($descuento)?>" value="<?=utf8_encode($descuento)?>">
    <label class='label required'>emailAdministrador</label>
    <input class='text-input' id='emailAdministrador' name='emailAdministrador' required type='text' placeholder="<?=utf8_encode($emailAdministrador)?>" readonly="">
  </form>

  <div><a>
      <p><span class="bg"></span><span class="base"></span><span id="bg" class="text">¿Seguro que quieres modificar <?=utf8_encode($codProm)?> ?</span></p></a>
  </div>

  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">

$(document).ready(function() {

  $('#bg').on('click', function(){
  	var codProm = <?php echo $codProm ?>;
  	var fechaExpiracion = $('#fechaExpiracion').val();
    var descuento = $('#descuento').val();

  	$.ajax({
      type: 'POST',
      url: 'cruds/modificarCodigoPromocion.php',
      data: {codProm:codProm, fechaExpiracion:fechaExpiracion, descuento:descuento},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });

});

</script>

</html>