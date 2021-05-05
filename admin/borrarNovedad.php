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
  $titulo = $_GET['titulo'];
  $idNovedades = $_GET['idNovedades'];
  ?>

  <div><a>
      <p><span class="bg"></span><span class="base"></span><span id="bg" class="text">¿Seguro que quieres borrar <?=utf8_encode($titulo)?> ?</span></p></a>
  </div>

  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">

$(document).ready(function() {

  $('#bg').on('click', function(){
  	var idNovedades = <?php echo $idNovedades ?>;
  	var titulo = <?php echo json_encode($titulo); ?>;

  	$.ajax({
      type: 'POST',
      url: 'cruds/borrarNovedades.php',
      data: {idNovedades:idNovedades, titulo:titulo},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });

});

</script>

</html>