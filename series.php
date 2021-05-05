<?php
include('./db/database.php');
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/estilosIndex.css">
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
        <a href="./index.php" class="activo">Inicio</a>
        <a href="series.php">Series</a>
        <a href="peliculas.php">Películas</a>
        <a href='milista.php'> Mi Lista </a> 
       <!-- <a href='./cerrarsesion.php'>Cerrar sesión</a>  -->
      </nav>
    </div>
  </header>
  <div class="contenedor-titulo-controles">
    <h3>Series</h3>
    <div class="indicadores"></div>
  </div>
  <div id="contenedor_peliculas">
    <div class="row">
      <?php
        $qry = "SELECT * FROM Contenido WHERE idContenido IN (SELECT idContenido FROM Serie)";

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
</body>
</html>