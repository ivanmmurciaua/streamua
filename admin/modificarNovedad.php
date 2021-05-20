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
  $idNovedades = $_GET['idNovedades'];
  $titulo = $_GET['titulo']; 
  $descripcion = $_GET['descripcion'];
  $emailAdministrador = $_GET['emailAdministrador']; 
  ?>

  <form action='' class='form'>
    <label class='label required'>idNovedades</label>
    <input class='text-input' id='idNovedades' name='idNovedades' required type='text' placeholder="<?=utf8_encode($idNovedades)?>" readonly="">
    <label class='label required'>Titulo</label>
    <input class='text-input' id='titulo' name='titulo' required type='text' placeholder="<?=utf8_encode($titulo)?>" value="<?=utf8_encode($titulo)?>">
    <label class='label required'>Descripcion</label>
    <input class='text-input' id='descripcion' name='descripcion' required type='text' placeholder="<?=utf8_encode($descripcion)?>" value="<?=utf8_encode($descripcion)?>">
    <label class='label required'>emailAdministrador</label>
    <input class='text-input' id='emailAdministrador' name='emailAdministrador' required type='text' placeholder="<?=utf8_encode($emailAdministrador)?>" readonly="">
  </form>

  <div><a>
      <p><span class="bg"></span><span class="base"></span><span id="bg" class="text">¿Seguro que quieres modificar <?=utf8_encode($titulo)?> ?</span></p></a>
  </div>

  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">

$(document).ready(function() {

  $('#bg').on('click', function(){
  	var idNovedades = <?php echo $idNovedades ?>;
  	var titulo = $('#titulo').val();
    var descripcion = $('#descripcion').val();

  	$.ajax({
      type: 'POST',
      url: 'cruds/modificarNovedades.php',
      data: {idNovedades:idNovedades, titulo:titulo, descripcion:descripcion},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });

});

</script>

</html>