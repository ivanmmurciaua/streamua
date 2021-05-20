<?php
session_start();
include('./db/database.php');
$emailcliente = $_SESSION['emailusu'];
?>
<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/estilosIndex.css">
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
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
</style>
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
            echo "<a href='milista.php' class='activo'> Mi Lista </a>";  
          }
        ?>
        <?php
          if(!isset($_SESSION["logged"])) {
            echo "<a href='login.php'>Login</a>"; 
          }
          else{
            echo "<a href='cerrarsesion.php'>Cerrar sesión</a>";
          }
        ?>
        
      </nav>
    </div>
  </header>

  <!-- HACER AQUI COSAS -->

  <div class="contenedor-titulo-controles">
      <h3>Mi lista</h3>
      <div class="indicadores"></div>
    </div>
    <div id="contenedor_peliculas">
      <div class="row">
        <?php
          $qry = "SELECT titulo FROM Contenido WHERE idContenido IN (SELECT idContenido FROM Lista WHERE emailCliente LIKE '$emailcliente')";

          if ($resultado = $conn->query($qry)) {

              /* obtener un array asociativo */
              while ($fila = $resultado->fetch_assoc()) {
                  echo "<div class='col'>".$fila["titulo"]."</div>";
              }

              /* liberar el conjunto de resultados */
              $resultado->free();
          }

        ?>
      </div>    
    </div>
  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

<!-- Footer -->
<footer class="bg-light text-center text-lg-start">
  <!-- Grid container -->
  <div class="container p-4">

  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    GI 2020/21
    <a class="text-dark" href="http://streamua.ddnsking.com/">StreamUA</a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->

</html>