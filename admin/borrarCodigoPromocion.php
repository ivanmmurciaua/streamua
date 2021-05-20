<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/cssBotonBorrar.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

  <!-- HACER AQUI COSAS -->

  <?php
  $codProm = $_GET['codProm'];
  ?>

<div><a>
    <p><span class="bg"></span><span class="base"></span><span id="bg" class="text">¿Seguro que quieres borrar <?=utf8_encode($codProm)?> ?</span></p></a>
</div>

  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">

$(document).ready(function() {

  $('#bg').on('click', function(){
  	var codProm = <?php echo $codProm ?>;

  	$.ajax({
      type: 'POST',
      url: 'cruds/borrarCodigoPromocion.php',
      data: {codProm:codProm},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });

});

</script>

</html>