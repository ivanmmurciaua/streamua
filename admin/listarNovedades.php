<?php

  include('../db/database.php');

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
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php" class="activo">Listar Novedades</a>
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
                          <th>Novedad</th>
                          <th>Título</th>
                          <th>Fecha Salida</th>
                          <th>Descripcion</th>
                          
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
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><a href='modificarNovedad.php?titulo=<?=$titulo?>&idNovedades=<?=$idNovedades?>&descripcion=<?=$descripcion?>&emailAdministrador=<?=$emailAdministrador?>' target="popup" onClick="window.open(this.href, this.target, 'width=400,height=820'); return false;"><img src="../img/iconoEditar.jpg" alt="Editar Novedad"></a></td>
                          <td><a href='borrarNovedad.php?titulo=<?=$titulo?>&idNovedades=<?=$idNovedades?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=320'); return false;"><img src="../img/iconoBorrar.jpg" alt="Borrar Novedad"></a></td>
                     
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