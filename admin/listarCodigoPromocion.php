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
        <a href="listarContenido.php" class="activo">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
      </nav>
    </div>
  </header>

  <!-- HACER AQUI COSAS --


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
                  <table class="table table-striped" id="tabla">
                  <thead>
                      <tr>
                          <th>Codigo Promocion (codProm)</th>
                          <th>Fecha creacion</th>
                          <th>Fecha expiracion</th>
                          <th>Activo</th>
                          <th>Descuento</th>
                          <th>Email Administrador</th>
                          
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                $query =$conn -> query("SELECT * from CodigoPromocion order by fechaCreacion");
                                while($row = $query->fetch_assoc())
                                {
                                      $codProm = $row['codProm'];
                                      $fechaCreacion=$row['fechaCreacion'];
                                      $fechaExpiracion=$row['fechaExpiracion'];
                                      $activo=$row['activo'];
                                      $descuento=$row['descuento'];
                                      $emailAdministrador=$row['emailAdministrador'];
                                                                                                                                                                               
                               ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($codProm)?></td>
                          <td><?php echo utf8_encode($fechaCreacion)?></td>
                          <td><?php echo utf8_encode($fechaExpiracion)?></td>
                          <td><?php echo utf8_encode($activo)?></td>
                          <td><?php echo utf8_encode($descuento)?></td>
                          <td><?php echo utf8_encode($emailAdministrador)?></td>
                          <td><a href='modificarCodigoPromocion.php?codProm=<?=$codProm?>&fechaExpiracion=<?=$fechaExpiracion?>&descuento=<?=$descuento?>&emailAdministrador=<?=$emailAdministrador?>' target="popup" onClick="window.open(this.href, this.target, 'width=400,height=820'); return false;"><img src="../img/iconoEditar.jpg" alt="Editar CodigoPromocion"></a></td>
                          <td><a href='borrarCodigoPromocion.php?codProm=<?=$codProm?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=320'); return false;"><img src="../img/iconoBorrar.jpg" alt="Borrar CodigoPromocion"></a></td>
                     
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