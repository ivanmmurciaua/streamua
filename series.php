<?php
session_start();
include('./db/database.php');
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/estilosIndex.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"><script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
  <title>StreamUA</title>
</head>
<style type="text/css">
  .row {
    display: flex;
    flex-wrap: wrap;
  }

  .col {
    flex: 1 0 18%;
    margin: 5px;
    background: #E50914;
    height: 150px;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
  }
  #buscador{
    width: 500px;
    height: 30px;
    border-radius: 10px;
  }
</style>
<body>
  <header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="index.php">Inicio</a>
        <a href="series.php" class="activo">Series</a>
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
  <div class="contenedor-titulo-controles">
    <h3>Series</h3>
    <div class="indicadores"></div><input type="search" placeholder="   Escribe la serie a buscar y dale a intro" id="buscador" />
  </div>
  
  <div id="contenedor_peliculas">
    <div class="row">
      <?php

        if(isset($_GET['buscar'])){
          $srch = "AND titulo LIKE '%".$_GET['buscar']."%'";  
        }
        else{
          $srch = "";
        }

        $qry = "SELECT * FROM Contenido WHERE idContenido IN (SELECT idContenido FROM Serie) $srch";

        if ($resultado = $conn->query($qry)) {

            /* obtener un array asociativo */
            while ($fila = $resultado->fetch_assoc()) {
                $idContenido = $fila["idContenido"];
                $titulo = $fila["titulo"];

                echo "<div id='".$idContenido."'class='col'>";
                echo "<a style='text-decoration:none; color:white;' href='./detalle.php?idContenido=$idContenido' onClick='window.open(this.href, this.target); return false;''>".$titulo;
                echo "</a></div>";
            }

            /* liberar el conjunto de resultados */
            $resultado->free();
        }

      ?>
    </div>    
  </div>
</body>
<script type="text/javascript">
  //ENTER SOBRE LA CASILLA
  $('#buscador').keypress(function(e){
    if(e.which == 13){
      if($('#buscador').val() != ""){
        var url = 'http://streamua.ddnsking.com/series.php';
        url += '?buscar='+$('#buscador').val();
        window.location.href = url;
      }
      else{
        window.location.href = 'http://streamua.ddnsking.com/series.php';
      }
    }
  });
</script>
</html>