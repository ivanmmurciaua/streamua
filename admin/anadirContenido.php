<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/admin.css">
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
        <a href="series.php">Series</a>
        <a href="peliculas.php">Películas</a>
      </nav>
    </div>
  </header>


  <!-- HACER AQUI COSAS -->

 <div class="row">
  <div class="col-75">
    <div class="container">
      <form action="/action_page.php">

        <div class="row">
          <div class="col-50">
    <h1>Añadir contenido</h1>
    <hr>
    <!-- Son 10, 5 en cada columna -->
            <label for="fname"><i class="fa fa-user"></i> idContenido</label>
            <input type="text" id="idContenido" name="idContenido">
            <label for="email"><i class="fa fa-envelope"></i> urlContenido</label>
            <input type="text" id="urlContenido" name="urlContenido">
            <label for="adr"><i class="fa fa-address-card-o"></i> Título</label>
            <input type="text" id="titulo" name="titulo">
            <label for="city"><i class="fa fa-institution"></i> Resumen</label>
            <input type="text" id="resumen" name="resumen">
            <label for="city"><i class="fa fa-institution"></i> Idioma</label>
            <input type="text" id="idioma" name="idioma">

          <div class="row">
              
            </div>
          </div>

          <div class="col-50">
              <br><br><br>
            <label for="cname">Subtitulos</label>
            <input type="text" id="subtitulos" name="subtitulos">
            <label for="ccnum">Actores</label>
            <input type="text" id="actores" name="actores">
            <label for="expmonth">Director</label>
            <input type="text" id="director" name="director">
            <label for="expmonth">Email administrador</label>
            <input type="text" id="emailAdministrador" name="emailAdministrador">
            <label for="expmonth">Género de la película</label>
            <input type="text" id="tipoGenero" name="tipoGenero">

            <div class="row">
              
            </div>
          </div>

        </div>
        <input id="fservice" class="registerbtn" value="Enviar" type="button"></input> 
      </form>
    </div>
  </div>

</div>
</div>
  
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<script type="text/javascript">
$(document).ready(function() {
  $('#fservice').on('click', function(){
    var idContenido = document.getElementById('idContenido').value;
    var urlContenido = document.getElementById('urlContenido').value;
    var titulo = document.getElementById('titulo').value;
    var resumen = document.getElementById('resumen').value;
    var idioma = document.getElementById('idioma').value;
    var subtitulos = document.getElementById('subtitulos').value;
    var actores = document.getElementById('actores').value;
    var director = document.getElementById('director').value;
    var emailAdministrador = document.getElementById('emailAdministrador').value;
    var tipoGenero = document.getElementById('tipoGenero').value;
    $.ajax({
      type: 'POST',
      url: 'cruds/anadirContenido.php',
      data: {idContenido:idContenido, urlContenido:urlContenido, titulo:titulo, resumen:resumen, idioma:idioma, subtitulos:subtitulos, actores:actores, director:director, emailAdministrador:emailAdministrador, tipoGenero:tipoGenero},
      success: function(data) {
        alert(data);
        window.location.reload();
      }
    });
  });
});
</script>


</html>