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
  $idContenido = $_GET['idContenido'];
  $URL_contenido = $_GET['URL_contenido'];
  $titulo = $_GET['titulo'];
  $resumen = $_GET['resumen'];
  $idioma = $_GET['idioma'];
  $subtitulos = $_GET['subtitulos'];
  $actores = $_GET['actores'];
  $director = $_GET['director'];
  $emailAdministrador = $_GET['emailAdministrador'];
  $tipoGenero = $_GET['tipoGenero'];
  ?>

  <form action='' class='form'>
    <label class='label required'>idContenido</label>
    <input class='text-input' id='idContenido' name='idContenido' required type='text' placeholder="<?=utf8_encode($idContenido)?>" readonly="">
    <label class='label required'>URL_contenido</label>
    <input class='text-input' id='URL_contenido' name='URL_contenido' required type='text' placeholder="<?=utf8_encode($URL_contenido)?>" value="<?=utf8_encode($URL_contenido)?>">
    <label class='label required'>Titulo</label>
    <input class='text-input' id='titulo' name='titulo' required type='text' placeholder="<?=utf8_encode($titulo)?>" value="<?=utf8_encode($titulo)?>">
    <label class='label required'>Resumen</label>
    <input class='text-input' id='resumen' name='resumen' required type='text' placeholder="<?=utf8_encode($resumen)?>" value="<?=utf8_encode($resumen)?>">
    <label class='label required'>Idioma</label>
    <input class='text-input' id='idioma' name='idioma' required type='text' placeholder="<?=utf8_encode($idioma)?>" value="<?=utf8_encode($idioma)?>">
    <label class='label required'>Subtitulos</label>
    <input class='text-input' id='subtitulos' name='subtitulos' required type='text' placeholder="<?=utf8_encode($subtitulos)?>" value="<?=utf8_encode($subtitulos)?>">
    <label class='label required'>Actores</label>
    <input class='text-input' id='actores' name='actores' required type='text' placeholder="<?=utf8_encode($actores)?>" value="<?=utf8_encode($actores)?>">
    <label class='label required'>Director</label>
    <input class='text-input' id='director' name='director' required type='text' placeholder="<?=utf8_encode($director)?>" value="<?=utf8_encode($director)?>">
    <label class='label required'>emailAdministrador</label>
    <input class='text-input' id='emailAdministrador' name='emailAdministrador' required type='text' placeholder="<?=utf8_encode($emailAdministrador)?>" readonly="">
    <label class='label required'>tipoGenero</label>
    <input class='text-input' id='tipoGenero' name='tipoGenero' required type='text' placeholder="<?=utf8_encode($tipoGenero)?>" value="<?=utf8_encode($tipoGenero)?>">
  </form>

  <div><a>
      <p><span class="bg"></span><span class="base"></span><span id="bg" class="text">¿Seguro que quieres modificar <?=utf8_encode($titulo)?> ?</span></p></a>
  </div>


  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">

$(document).ready(function() {

  $('#bg').on('click', function(){

  	var idContenido = <?php echo $idContenido ?>;
  	var URL_contenido = $('#URL_contenido').val();
    var titulo = $('#titulo').val();
    var resumen = $('#resumen').val();
    var idioma = $('#idioma').val();
    var subtitulos = $('#subtitulos').val();
    var actores = $('#actores').val();
    var director = $('#director').val();
    var emailAdministrador = <?php echo json_encode($emailAdministrador) ?>;
    var tipoGenero = $('#tipoGenero').val();

  	$.ajax({
      type: 'POST',
      url: 'cruds/modificarContenido.php',
      data: {idContenido:idContenido,URL_contenido:URL_contenido,titulo:titulo,resumen:resumen,idioma:idioma,subtitulos:subtitulos,actores:actores,director:director,emailAdministrador:emailAdministrador,tipoGenero:tipoGenero},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });

});

</script>

</html>