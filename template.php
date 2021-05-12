<?php
session_start();
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

  <!-- HACER AQUI COSAS -->









  
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