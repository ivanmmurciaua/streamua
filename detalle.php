<?php
session_start();
include('./db/database.php');
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link rel="stylesheet" href="css/detalle.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
  <title>StreamUA</title>
</head>
<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="index.php">Inicio</a>
        <a href="series.php">Series</a>
        <a href="peliculas.php">Películas</a>
        
        <?php
          if(isset($_SESSION["logged"])) {
            echo "<a href='milista.php'> Mi Lista </a>";  
          }
        ?>

        <?php
          if(!isset($_SESSION["logged"])) {
            echo "<a href='./login.php'>Login</a>"; 
          }
          else{
            echo "<a href='./cerrarsesion.php'>Cerrar sesión</a>";
          }
        ?>
        
      </nav>
    </div>
  </header>
  <body>
  <?php

    if(isset($_GET['idContenido'])){
      $idContenido = $_GET['idContenido'];
      $qry = "SELECT * FROM Contenido WHERE idContenido=$idContenido";
      if ($resultado = $conn->query($qry)) {
        while ($fila = $resultado->fetch_assoc()) {
          $imagenPortada = $fila['imagenPortada'];
          $titulo = $fila['titulo'];
          $resumen = $fila['resumen'];
          $pais = $fila['idioma'];
          $director = $fila['director'];
          $genero = $fila['tipoGenero'];
          $actores = $fila['actores'];
          $puntuacionMedia = $fila['puntuacionMedia'];
        }
      }
  ?>

  <div class='card'>
  <div class='card_left'>
    <?php echo '<img src="data:image/jpeg;base64,'.base64_encode( $imagenPortada ).'"/>'; ?>
  </div>
  <div class='card_right'>
    <h1><?php echo $titulo; ?></h1>
    <div class='card_right__details'>
      <ul>
        <li>País: <?php echo $pais; ?></li>
        <li>Director: <?php echo $director; ?></li>
        <li>Género: <?php echo $genero; ?></li>
      </ul>
      <div class='card_right__rating'>
        <div class='card_right__rating__stars'>
          <fieldset class='rating'>
            <input id='star10' name='rating' type='radio' value='10'>
            <label class='full' for='star10' title='10 stars'></label>
            <input id='star9half' name='rating' type='radio' value='9 and a half'>
            <label class='half' for='star9half' title='9.5 stars'></label>
            <input id='star9' name='rating' type='radio' value='9'>
            <label class='full' for='star9' title='9 stars'></label>
            <input id='star8half' name='rating' type='radio' value='8 and a half'>
            <label class='half' for='star8half' title='8.5 stars'></label>
            <input id='star8' name='rating' type='radio' value='8'>
            <label class='full' for='star8' title='8 stars'></label>
            <input id='star7half' name='rating' type='radio' value='7 and a half'>
            <label class='half' for='star7half' title='7.5 stars'></label>
            <input id='star7' name='rating' type='radio' value='7'>
            <label class='full' for='star7' title='7 stars'></label>
            <input id='star6half' name='rating' type='radio' value='6 and a half'>
            <label class='half' for='star6half' title='6.5 stars'></label>
            <input id='star6' name='rating' type='radio' value='6'>
            <label class='full' for='star6' title='6 star'></label>
            <input id='star5half' name='rating' type='radio' value='5 and a half'>
            <label class='half' for='star5half' title='5.5 stars'></label>
            <input id='star5' name='rating' type='radio' value='5'>
            <label class='full' for='star5' title='5 stars'></label>
            <input id='star4half' name='rating' type='radio' value='4 and a half'>
            <label class='half' for='star4half' title='4.5 stars'></label>
            <input id='star4' name='rating' type='radio' value='4'>
            <label class='full' for='star4' title='4 stars'></label>
            <input id='star3half' name='rating' type='radio' value='3 and a half'>
            <label class='half' for='star3half' title='3.5 stars'></label>
            <input id='star3' name='rating' type='radio' value='3'>
            <label class='full' for='star3' title='3 stars'></label>
            <input id='star2half' name='rating' type='radio' value='2 and a half'>
            <label class='half' for='star2half' title='2.5 stars'></label>
            <input id='star2' name='rating' type='radio' value='2'>
            <label class='full' for='star2' title='2 stars'></label>
            <input id='star1half' name='rating' type='radio' value='1 and a half'>
            <label class='half' for='star1half' title='1.5 stars'></label>
            <input id='star1' name='rating' type='radio' value='1'>
            <label class='full' for='star1' title='1 star'></label>
            <input id='starhalf' name='rating' type='radio' value='half'>
            <label class='half' for='starhalf' title='0.5 stars'></label>
          </fieldset>
        </div>
      </div>
      <div class='card_right__review'>
        <p>Descripción</p>
        <p> <?php echo $resumen; ?> </p>
        <!-- <a href='http://www.imdb.com/title/tt0266697/plotsummary?ref_=tt_stry_pl' target='_blank'>Leer más</a> -->
      </div>
      <div class='card_right__button'>
        <a id="repro">REPRODUCIR</a>
      </div>
      <?php
        if(isset($_SESSION["logged"])) { ?>
          <div id="anyadir_div" class='card_left__button'>
            <a id="anyadir">AÑADIR A MI LISTA</a>
          </div>    
      <?php  
        }
      ?>
      
    </div>
  </div>
</div>
<?php

    }
    else{
      echo "<div class='card'>
              <div class='card_right'>
              <h1>No tan rápido!</h1>
              <br>
              <h1>Selecciona un contenido a visualizar</h1>
              </div>
            </div>";
    }

?>

  </body>

  <script type="text/javascript">
    
    $(document).ready(function() {

      var idContenido = <?php echo $idContenido ?>;
      var emailcliente = <?php echo json_encode($_SESSION["emailusu"]); ?>;

      if(emailcliente!=""){
        $.ajax({
          type: 'POST',
          url: 'admin/checkIfList.php',
          data: {idContenido:idContenido, emailcliente:emailcliente},
          success: function(data) {
            if(data==2){
              var div = document.getElementById('anyadir_div')
              if(div !== null){
                  while (div.hasChildNodes()){
                      div.removeChild(div.lastChild);
                  }
              }
            }
          }
        });
      }

      $('#repro').on('click', function(){
        <?php 
          if(!isset($_SESSION["logged"])) {
        ?>
            window.location.href = "/login.php";
        <?php
        } else{
        ?>
            window.alert("En construcción :)");
        <?php
        }
        ?>
      });

      $('#anyadir').on('click', function(){
        
        var idContenido = <?php echo $idContenido ?>;
        var emailcliente = <?php echo json_encode($_SESSION["emailusu"]); ?>;

        $.ajax({
          type: 'POST',
          url: 'admin/anyadirMiLista.php',
          data: {idContenido:idContenido, emailcliente:emailcliente},
          success: function(data) {
            alert(data);
            window.location.reload();
          }
        });

      });

    });

  </script>
  </html>
