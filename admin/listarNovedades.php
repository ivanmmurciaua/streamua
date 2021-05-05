<?php

  include('../db/database.php');

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
        <a href="#" class="activo">Inicio</a>
      </nav>
    </div>
  </header>

  <!-- HACER AQUI COSAS -->

<!-- Listado Visitas -->
    <section id="alumnos">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Listado Novedades</h2>
          </div>
        </div>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntate" name="apuntate" method="POST">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                  <table class="table table-striped">
                  <thead>
                      <tr>
                          <th>Novedad (titulo)</th>
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
                          <td><?php echo utf8_encode($titulo)."(".$descripcion."-".$fechaSalida.")"?></td>
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><a href='modificarNovedades.php?email=<?=$email?>' target="popup" onClick="window.open(this.href, this.target, 'width=400,height=820'); return false;"><img src="img/iconoEditar.jpg" alt="Editar Novedad"></a></td>
                          <td><a href='borrarNovedad.php?titulo=<?=$titulo?>&idNovedades=<?=$idNovedades?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=320'); return false;"><img src="img/iconoBorrar.jpg" alt="Borrar Novedad"></a></td>
                     
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