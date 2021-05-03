<!DOCTYPE html>
<html lang="en">
<?php
  include ("seguridad.php");
?>
  
  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Programa Mentoring. Red de excelencia PLN.NET</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Custom styles for this template -->
    <link href="css/agency.min.css" rel="stylesheet">

  </head>

<!--CONEXION CON LA BASE DE DATOS DEL PROYECTO-->
<?php 
                    include "conexionBD.inc";
					
?>


  <body id="page-top">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">PLN.NET</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#listado">Mentores-Alumnos</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#alumnos">Alumnos</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="desconectar.php">Salir</a>
            </li>
            
          </ul>
        </div>
      </div>
    </nav>

    <!-- Header -->
    <header class="masthead">
      <div class="container">
        <div class="intro-text">
          <div class="intro-lead-in">Red PLN.NET</div>
          <div class="intro-heading">Administracion Mentoring</div>
<!--          <a class="btn btn-xl js-scroll-trigger" href="#services">Administracion</a>-->
        </div>
      </div>

    </header>


    <!-- Listado Mentores-Alumnos -->
    <section id="listado">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Listado Mentores-Alumnos 2017-2018</h2>
            <!--<h3 class="section-subheading text-muted">¿Quieres ser mentor? Danos tus datos y elige al alumno.</h3>-->
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
                          <th>Mentor (EMail-Universidad)</th>
                          <th>Alumno (Email-Universidad)</th>
                          <th>Titulo tesis</th>
                          <th> </th>
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                $query =$link -> query("SELECT emailMentor,emailAlumno,m.email,m.nombre as nombreM,m.universidad as uniM,a.email,a.nombre as nombreA,a.titulo,a.universidad as uniA from Mentoring,Mentor m, Alumno a where a.email=emailAlumno and m.email=emailMentor order by nombreA");
                                while($row = mysqli_fetch_array($query))
                                {
                                      $emailMentor = $row['emailMentor'];
                                      $emailAlumno=$row['emailAlumno'];
                                      $nombreMentor=$row['nombreM'];
                                      $uniM=$row['uniM'];
                                      $uniA=$row['uniA'];
                                      $nombreAlumno=$row['nombreA'];
                                      $titulo=$row['titulo'];                                                                                                                                         
                               ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($nombreMentor)."(".$emailMentor."-".$uniM.")"?></td>
                          <td><?php echo utf8_encode($nombreAlumno)."(".$emailAlumno."-".$uniA.")"?></td>
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><a href='borrarMentoring.php?mentor=<?=$emailMentor?>&alumno=<?=$emailAlumno?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=620'); return false;"><img src="img/iconoBorrar.jpg" alt="Registrar visita"></a></td>
						              
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

    <!-- Listado Visitas -->
    <section id="alumnos">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Listado Alumnos</h2>
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
                          <th>Alumno (Email-Universidad)</th>
                          <th>Tesis</th>
                          
                      </tr>
                  </thead>
                  <tbody>
                      <?php
                                $query =$link -> query("SELECT * from Alumno order by nombre");
                                while($row = mysqli_fetch_array($query))
                                {
                                      $email = $row['email'];
                                      $nombre=$row['nombre'];
                                      $uni=$row['universidad'];
                                      $titulo=$row['titulo'];
                                                                                                                                                                               
                               ?>
                             
                      <tr>
                          <td><?php echo utf8_encode($nombre)."(".$email."-".$uni.")"?></td>
                          <td><?php echo utf8_encode($titulo)?></td>
                          <td><a href='editarAlumno.php?email=<?=$email?>' target="popup" onClick="window.open(this.href, this.target, 'width=400,height=820'); return false;"><img src="img/iconoEditar.jpg" alt="Editar Alumno"></a></td>
                          <td><a href='borrarAlumno.php?email=<?=$email?>' target="popup" onClick="window.open(this.href, this.target, 'width=350,height=320'); return false;"><img src="img/iconoBorrar.jpg" alt="Borrar Alumno"></a></td>
                     
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

    
    <!-- Footer -->
    <footer>
      <div class="container">
        <div class="row">
          <div class="col-md-4">
            <span class="copyright">PLN.NET (TIN2016-81739-REDT)</span>
          </div>
          <div class="col-md-4">
            <!--<ul class="list-inline social-buttons">
              <li class="list-inline-item">
                <a href="@gplsi">
                  <i class="fa fa-twitter"></i>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="https://www.facebook.com/gplsi">
                  <i class="fa fa-facebook"></i>
                </a>
              </li>
            </ul>-->
          </div>
          <div class="col-md-4">
            <!--<ul class="list-inline quicklinks">
              <li class="list-inline-item">
                <a href="#">Privacy Policy</a>
              </li>
              <li class="list-inline-item">
                <a href="#">Terms of Use</a>
              </li>
            </ul>-->
          </div>
        </div>
      </div>
    </footer>


    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper/popper.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Contact form JavaScript -->
    <script src="js/jqBootstrapValidation.js"></script>
    <script src="js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="js/agency.min.js"></script>

  </body>

<?php 
                    include "desconexionBD.inc";
?>


</html>
