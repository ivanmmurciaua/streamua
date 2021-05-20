<?php

  include('../db/database.php');

?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../css/estilosIndex.css">
  <link rel="stylesheet" href="../css/listContenido.css">
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
        <a href="listarContenido.php" class="activo">Listar Contenido</a>
        <a href="anadirCodigoPromocion.php">Añadir Codigo promocion</a>
        <a href="listarCodigoPromocion.php">Listar Codigo promocion</a>
        <a href="anadirNovedad.php">Añadir Novedad</a>
        <a href="listarNovedades.php">Listar Novedades</a>
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
                  <table class="table table-striped" id="tabla">
                  <thead>
                      <tr>
                          <th>Titulo</th>
                          <th>urlContenido</th>
                          <th>resumen</th>
                          <th>idioma</th>
                          <th>subtitulos</th>
                          <th>actores</th>
                          <th>director</th>
                          <th>Genero</th>
                          
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                $query =$conn -> query("SELECT * from Contenido order by idContenido");
                                while($row = $query->fetch_assoc())
                                {
                                     $idContenido = $row['idContenido'];
                                     $URL_contenido = $row['URL_contenido'];
                                     $titulo = $row['titulo'];
                                     $resumen = $row['resumen'];
                                     $idioma = $row['idioma'];
                                     $subtitulos = $row['subtitulos'];
                                     $actores = $row['actores'];
                                     $director = $row['director'];
                                     $emailAdministrador = $row['emailAdministrador'];
                                     $tipoGenero = $row['tipoGenero'];                                                                                          
                               ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><?php echo utf8_encode($URL_contenido)?></td>
                          <td><?php echo utf8_encode($resumen)?></td>
                          <td><?php echo utf8_encode($idioma)?></td>
                          <td><?php echo utf8_encode($subtitulos)?></td>
                          <td><?php echo utf8_encode($actores)?></td>
                          <td><?php echo utf8_encode($director)?></td>
                          <td><?php echo utf8_encode($tipoGenero)?></td>
                          <td><a href='modificarContenido.php?idContenido=<?=$idContenido?>&URL_contenido=<?=$URL_contenido?>&titulo=<?=$titulo?>&resumen=<?=$resumen?>&resumen=<?=$resumen?>&idioma=<?=$idioma?>&subtitulos=<?=$subtitulos?>&actores=<?=$actores?>&director=<?=$director?>&emailAdministrador=<?=$emailAdministrador?>&tipoGenero=<?=$tipoGenero?>' target="popup" onClick="window.open(this.href, this.target, 'width=400,height=820'); return false;"><img src="../img/iconoEditar.jpg" alt="Editar Contenido"></a></td>
                          <td><a href='borrarContenido.php?titulo=<?=$titulo?>&idContenido=<?=$idContenido?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=320'); return false;"><img src="../img/iconoBorrar.jpg" alt="Borrar Contenido"></a></td>
                     
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