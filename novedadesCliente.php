<?php

  include('db/database.php');
  session_start();

  $email = $_SESSION['emailusu'];

?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/estilosIndex.css">
  <link rel="stylesheet" href="../css/listNovedades.css">
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
        <a href="novedadesCliente.php" class="activo">Novedades</a>

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

<!-- Listado Visitas -->
    <section id="alumnos">
      <div class="container">
        <br>
        <br>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntate" name="apuntate" method="POST">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                  <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Título</th>
                          <th>Resumen</th>
                          <th>Fecha Salida</th>
                          
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                $query =$conn -> query("SELECT * from Novedades order by fechaSalida");
                                while($row = $query->fetch_assoc())
                                {
                                      $idNovedades = $row['idNovedades'];
                                      $titulo=$row['titulo'];
                                      $descripcion=$row['descripcion'];
                                      $fechaSalida=$row['fechaSalida'];
                                      $emailAdministrador=$row['emailAdministrador'];
                                                                                                                                                                               
                               ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><?php echo utf8_encode($descripcion)?></td>
                          <td><?php echo utf8_encode($fechaSalida)?></td>                     
                      </tr>
                      <?php
                }
             ?>
                  </tbody>
                  </table>
                  </div>
                                                                                                                                                                                                   
                </div>
              </div>
          </form>
         </div>
        </div>
      </div>      
    </section>

  <!-- CIERRE HACER AQUI COSAS -->
  
</body>

</html>