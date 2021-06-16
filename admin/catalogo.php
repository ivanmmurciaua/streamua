<?php

  include('../db/database.php');
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
        <a href="../index.php">Inicio</a>
        <a href="anadirContenido.php">Añadir Contenido</a>
        <a href="listarContenido.php">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="anadirCaratula.php">Añadir Caratula</a>
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="#" class="activo">Listar Novedades</a>
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
                          <th>Tamaño BBDD</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                // TAMAÑO BBDD
                                $query1 =$conn -> query("SELECT SUM((data_length+index_length)/1024/1024) AS 'tamanyo', 'MB' FROM information_schema.tables WHERE table_schema='gi_streamua2'");

                                while($row = $query1->fetch_assoc())
                                {
                                      $tamanyo = $row['tamanyo'];
                                }
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($tamanyo)?> MB</td>                      
                      </tr>
                  </tbody>
                  </table>
                  <br>
                  <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Tamaño de tablas</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                // TAMAÑO BBDD
                                $query1 =$conn -> query("SELECT TABLE_NAME, (data_length+index_length)/1024/1024 AS 'tamanyo', 'MB' FROM information_schema.tables WHERE table_schema='gi_streamua2'");

                                while($row = $query1->fetch_assoc())
                                {
                                      $tablename = $row['TABLE_NAME'];
                                      $tamanyo = $row['tamanyo'];
                                      if(is_null($tamanyo)) $tamanyo = 0;
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <th><?php echo utf8_encode($tablename)?></th>                     
                          <td><?php echo utf8_encode($tamanyo)?> MB</td>                     
                      </tr>

                      <?php
                        }
                      ?>
                  </tbody>
                  </table>
                  <br>
                  <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Procedimientos</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                // TAMAÑO BBDD
                                $query1 =$conn -> query(" SELECT SPECIFIC_NAME FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA LIKE 'gi_streamua2' AND ROUTINE_TYPE LIKE 'PROCEDURE'");

                                while($row = $query1->fetch_assoc())
                                {
                                      $SPECIFIC_NAME = $row['SPECIFIC_NAME'];
                                
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($SPECIFIC_NAME)?></td>                      
                      </tr>
                      <?php
                        }
                      ?>
                  </tbody>
                  </table>
<br>
                                    <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Funciones</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                // TAMAÑO BBDD
                                $query33 =$conn -> query("  SELECT SPECIFIC_NAME FROM information_schema.ROUTINES WHERE ROUTINE_SCHEMA LIKE 'gi_streamua2' AND ROUTINE_TYPE LIKE 'FUNCTION'");

                                while($row = $query33->fetch_assoc())
                                {
                                      $SPECIFIC_NAME = $row['SPECIFIC_NAME'];
                                
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($SPECIFIC_NAME)?></td>                      
                      </tr>
                      <?php
                        }
                      ?>
                  </tbody>
                  </table>
                  <br>
                                    <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Eventos</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                // TAMAÑO BBDD
                                $query22 =$conn -> query("SELECT EVENT_NAME FROM information_schema.EVENTS WHERE EVENT_SCHEMA LIKE 'gi_streamua2'");

                                while($row = $query22->fetch_assoc())
                                {
                                      $EVENT_NAME = $row['EVENT_NAME'];
                                
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($EVENT_NAME)?></td>                      
                      </tr>
                      <?php
                        }
                      ?>
                  </tbody>
                  </table>
                  <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Triggers</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php

                                // TAMAÑO BBDD
                                $query1 =$conn -> query("SELECT TRIGGER_NAME FROM information_schema.TRIGGERS WHERE TRIGGER_SCHEMA LIKE 'gi_streamua2'");

                                while($row = $query1->fetch_assoc())
                                {
                                      $TRIGGER_NAME = $row['TRIGGER_NAME'];
                                
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($TRIGGER_NAME)?></td>                      
                      </tr>
                      <?php
                        }
                      ?>
                  </tbody>
                  <br>
                  </table>
                  <br>
                        <table id="tabla" class="table table-striped">
                  <thead>
                      <tr>
                          <th>Vistas</th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php

                                // TAMAÑO BBDD
                                $query1 =$conn -> query("SELECT TABLE_NAME FROM information_schema.VIEWS WHERE TABLE_SCHEMA LIKE 'gi_streamua2'");

                                while($row = $query1->fetch_assoc())
                                {
                                      $TABLE_NAME = $row['TABLE_NAME'];
                                
                                                                                                                                                                               
                        ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($TABLE_NAME)?></td>                      
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
