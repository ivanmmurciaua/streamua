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
    <input type="hidden" class='text-input' id='emailCliente' name='emailCliente' required type='email' value="<?=utf8_encode($_SESSION['emailusu'])?>" readonly="">
 
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
      <div class='card_right__button'>

            <select  id="valoracion">
              <option id="1" name="1">1</option>
              <option id="2" name="2">2</option>
              <option id="3" name="3">3</option>
              <option id="4" name="4">4</option>
              <option id="5" name="5">5</option>
            </select>

            
            <div id="anyadir_div" class='card_left__button'>
            <a id="valoración">VALORACION</a>
          </div>  
      </div>
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
      var emailcliente = document.getElementById('emailCliente').value;

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
        var emailcliente = document.getElementById('emailCliente').value;

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

      $('#valoración').on('click', function(){
        
        var idContenido = <?php echo $idContenido ?>;
        var valoracion = document.getElementById('valoracion').value;
        var emailCliente = document.getElementById('emailCliente').value;

        $.ajax({
          type: 'POST',
          url: 'detalleBD.php',
          data: {valoracion:valoracion, emailCliente:emailCliente,idContenido:idContenido},
          success: function(data) {
            alert(data);
            window.location.reload();
          }
        });

      });

    });

  </script>
  </html>
