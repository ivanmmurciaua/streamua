<?php session_start();?>
<!DOCTYPE html>

<html lang="en">

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
        <a class="navbar-brand js-scroll-trigger" href="indexAdmin.php">PLN.NET</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#services">Programa mentoring</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#contact">Mentores</a>
            </li>
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#contact2">Alumnos</a>
            </li>
            
            <li class="nav-item">
              <a class="nav-link js-scroll-trigger" href="#team">Contacto</a>
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
          <div class="intro-heading">Programa Mentoring 2017/2018</div>
          <a class="btn btn-xl js-scroll-trigger" href="#services">Quiero Saber Más!</a>
        </div>
      </div>
    </header>

    <!-- Que es mentoring -->
    <section id="services">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">¿Qué es mentoring?</h2>
            <h3 class="section-subheading text-muted">El programa MENTORING es una herramienta destinada a aumentar el potencial de los doctorandos, basándose en la transferencia de conocimientos y en el aprendizaje a través de la experiencia de los mentores, y establecer una relación personal y de confianza entre un MENTOR/A que guía y estimula al alumno para que obtenga lo mejor de si mismo a nivel de investigación. </h3>
          </div>
        </div>
        <div class="row text-center">
          <div class="col-md-4">
            <span class="fa-stack fa-4x">
              <i class="fa fa-circle fa-stack-2x text-primary"></i>
              <i class="fa fa-shopping-cart fa-stack-1x fa-inverse"></i>
            </span>
            <h4 class="service-heading">Tranferencias know-how</h4>
            <p class="text-muted">Utilizar por parte de los alumnos el saber acumulado por investigadores senior para que les aporten su experiencia investigadora.</p>
         
          </div>
          <div class="col-md-4">
            <span class="fa-stack fa-4x">
              <i class="fa fa-circle fa-stack-2x text-primary"></i>
              <i class="fa fa-laptop fa-stack-1x fa-inverse"></i>
            </span>
            <h4 class="service-heading">Potenciar conocimientos</h4>
            <p class="text-muted">Acelerar el proceso de desarrollo investigador a través del apoyo de una persona de larga experiencia en el área.</p>
        
             </div>
          <div class="col-md-4">
            <span class="fa-stack fa-4x">
              <i class="fa fa-circle fa-stack-2x text-primary"></i>
              <i class="fa fa-lock fa-stack-1x fa-inverse"></i>
            </span>
            <h4 class="service-heading">Formentar relaciones</h4>
            <p class="text-muted">Generar vínculos entre los mentores y los alumnos tanto a nivel profesional como personal, preparando al alumno para un mayor éxito en su investigacion.</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Apúntate -->
    <section id="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Apúntate</h2>
            <h3 class="section-subheading text-muted">¿Quieres ser mentor? Danos tus datos y elige al alumno.</h3>
          </div>
        </div>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntate" name="apuntate" method="POST" action="alta.php">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                    <input class="form-control" id="name" name="nombre" type="text" placeholder="Nombre*" required data-validation-required-message="Por favor, introduce tu nombre.">
                    <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                     <input class="form-control" id="email" name="email" type="email" placeholder="Email *" required data-validation-required-message="Por favor, introduce tu email.">
                     <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                        <select class="selectpicker form-control" id="universidad" name="uni">
                            <option data-hidden="true">Selecciona tu universidad...</option>
                             <?php
                                $query =$link -> query("SELECT * from Universidad");
                                while($row = mysqli_fetch_array($query))
                                {
                                      $id = $row['id'];
                                      $nombre=$row['nombre'];
                                                                                                                                                                               
                               ?>
                                                                                                                                                                                                   
                                                                                                                                                                                                   
                              <option value='<?php echo $id?>'><?php echo utf8_encode($nombre)?></option>
                              <?php
                                 }
                               ?>   
                         </select>
                     <p class="help-block text-danger"></p>
                  </div>   
                <!--</div>-->
                
                <!--<div class="col-md-6">-->
                    <div class="form-group">
                      <p class="text-muted">Alumnos</p>
             
                      <select class="selectpicker form-control" id="alumno" name="alumno" title="Selecciona un alumno...">
                      <option data-hidden="true">Selecciona un alumno...</option>
                            
                             <?php
                                $query =$link -> query("SELECT * from Alumno");
                                while($row = mysqli_fetch_array($query))
                                {
                                      $email = $row['email'];
                                      $nombre=$row['nombre'];
                                      $uniAlu=$row['universidad'];
                                      $titulo=$row['titulo'];
                                      $tema=$row['tema'];                                                                                                                                         
                               ?>
                                                                                                                                                                                                   
                                                                                                                                                                                                   
                              <option value='<?php echo $email?>'><?php echo utf8_encode($nombre)."(".$uniAlu.")".":".utf8_encode($tema)?></option>
                              <?php
                                 }
                               ?>   
                         </select>
                      <p class="help-block text-danger"></p>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-lg-12 text-center">
                <div id="success"></div>
                  <?php
				  if(isset($_SESSION['ok']) && $_SESSION['ok']==1)
                  {
				  ?>
                  <div class="alert alert-success alert-dismissable">
                    <a href="index.php#contact" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Felicidades!</strong> Ya estas dado de alta como mentor.
                    </div>                  
                  <?php
				  }
				  if(isset($_SESSION['ok']) && $_SESSION['ok']==0)
                  {
				  ?>
                  <div class="alert alert-success alert-dismissable">
                    <a href="index.php#contact" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>ERROR!</strong> Al insertar los datos. Vuelva a intentarlo.
                    </div>                  
                  <?php
					
				  }
				  unset($_SESSION['ok']);
                  
                  ?>
                  <button id="apuntate" class="btn btn-xl" type="submit">Hacerse Mentor</button>
                </div>
              </div>
          </form>
         </div>
        </div>
      </div>      
    </section>

    <!-- Alumnos -->
    <section id="contact2">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Nuevos alumnos</h2>
            <h3 class="section-subheading text-muted">¿Quieres tener un mentor? Danos tus datos.</h3>
          </div>
        </div>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntateAlu" name="apuntateAlu" method="POST" action="altaAlu.php">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                    <input class="form-control" id="name" name="nombre" type="text" placeholder="Nombre*" required data-validation-required-message="Por favor, introduce tu nombre.">
                    <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                     <input class="form-control" id="email" name="email" type="email" placeholder="Email *" required data-validation-required-message="Por favor, introduce tu email.">
                     <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                     <input class="form-control" id="titulo" name="titulo" type="text" placeholder="Título Tesis *" required data-validation-required-message="Por favor, introduce el título de tu tesis.">
                     <p class="help-block text-danger"></p>
                  </div>
                  <div class="form-group">
                     <input class="form-control" id="tema" name="tema" type="text" placeholder="Tema Tesis *" required data-validation-required-message="Por favor, introduce brevemente la temática.">
                     <p class="help-block text-danger"></p>
                  </div>
                 
                  <div class="form-group">
                        <select class="selectpicker form-control" id="universidad" name="uni" data-width="100%">
                            <option data-hidden="true">Selecciona tu universidad...</option>
                             <?php
                                $query =$link -> query("SELECT * from Universidad");
                                while($row = mysqli_fetch_array($query))
                                {
                                      $id = $row['id'];
                                      $nombre=$row['nombre'];
                                                                                                                                                                               
                               ?>
                                                                                                                                                                                                   
                                                                                                                                                                                                   
                              <option value='<?php echo $id?>'><?php echo utf8_encode($nombre)?></option>
                              <?php
                                 }
                               ?>   
                         </select>
                     <p class="help-block text-danger"></p>
                  </div>   
                </div>
                
                <div class="clearfix"></div>
                <div class="col-lg-12 text-center">
                <div id="success"></div>
                  <?php
                  if(isset($_SESSION['ok2']) && $_SESSION['ok2']==1)
                  {
                  ?>
                  <div class="alert alert-success alert-dismissable">
                    <a href="index.php#contact2" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>Felicidades!</strong> Ya estas dado de alta como alumno.
                    </div>                  
                  <?php
				  }
				  if(isset($_SESSION['ok2']) && $_SESSION['ok2']==0)
                  {
                  ?>
                  <div class="alert alert-success alert-dismissable">
                    <a href="index.php#contact2" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <strong>ERROR!</strong> Al darte de alta como alumno. Vuelva a intentarlo!
                    </div>                  
                  <?php
				  } 	
				   unset($_SESSION['ok2']);	

                  ?>
                  <button id="apuntate2" class="btn btn-xl" type="submit">Alta nuevo alumno</button>
                </div>
              </div>
          </form>
         </div>
        </div>
      </div>      
    </section>


    <!-- Equipo -->
    <section class="bg-light" id="team">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Equipo contacto</h2>
            <h3 class="section-subheading text-muted">Si tienes dudas contacta con nosotr@s.</h3>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4">
            <div class="team-member">
              <img class="mx-auto rounded-circle" src="img/team/3.jpg" alt="">
              <h4>Estela Saquete</h4>
              <p class="text-muted">Investigadora senior GPLSI (UA)</p>

              <a href="mailto:prueba@dlsi.ua.es" class="btn btn-info btn-xl">
              <span class="glyphicon glyphicon-envelope"></span> Contactar 
              </a>
            </div>
          </div>
          <div class="col-sm-4">
            <div class="team-member">
              <img class="mx-auto rounded-circle" src="img/team/3.jpg" alt="">
              <h4>Paloma Moreda</h4>
              <p class="text-muted">Investigadora senior GPLSI (UA)</p>
              <a href="mailto:prueba@dlsi.ua.es" class="btn btn-info btn-xl">
              <span class="glyphicon glyphicon-envelope"></span> Contactar 
              </a>
            </div>
          </div>
          <div class="col-sm-4">
            <div class="team-member">
              <img class="mx-auto rounded-circle" src="img/team/logo_2.jpg" alt="">
              <h4><a href="https://gplsi.dlsi.ua.es/pln">PLN.net</a></h4>
              <p class="text-muted">RED DE DINAMIZACIÓN DE ACTIVIDADES EN TECNOLOGÍAS DE PROCESAMIENTO DEL LENGUAJE NATURAL</p>
              <ul class="list-inline social-buttons">
                <li class="list-inline-item">
                  <a href="@PLNnet">
                    <i class="fa fa-twitter"></i>
                  </a>
                </li>
                <!--<li class="list-inline-item">
                  <a href="#">
                    <i class="fa fa-facebook"></i>
                  </a>
                </li>-->
                <li class="list-inline-item">
                  <a href="https://www.linkedin.com/groups/8621981">
                    <i class="fa fa-linkedin"></i>
                  </a>
                </li>
              </ul>
            </div>
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
