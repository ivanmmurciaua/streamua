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
                                          <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="
                                              <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text
                                                  <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' re
                                                      <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='styleshee
                                                      
                                                          <!-- Custom styles for this template -->
                                                              <link href="css/agency.min.css" rel="stylesheet">
                                                              
                                                                </head>
                                                                

<?php 



include_once "conexionBD.inc";


$email = $_GET['email'];
$query =$link -> query("SELECT * from Alumno where email='".$email."'");

if($row = mysqli_fetch_array($query))
{
       $nombre=$row['nombre'];
       $uni=$row['universidad'];
       $titulo=$row['titulo'];
       $tema=$row['tema'];
     
}

?>
<body id="page-top">
    <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Actualizar Alumno</h2>
          </div>
        </div>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntateAlu" name="apuntateAlu" method="POST" action="reditarAlumno.php">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                     <b>Nombre</b>
                     <input class="form-control" id="nombre" name="nombre" type="text" value="<?=$nombre?>" placeholder="Nombre Alumno*" required data-validation-required-message="Introduce el nombre del alumno">
                     <input class="form-control" id="email" name="email" type="hidden" value="<?=$email?>">
                     
					 <p class="help-block text-danger"></p>
                  </div>
                 <div class="form-group">
                     <b>Titulo Tesis</b>
                     <input class="form-control" id="titulo" name="titulo" type="text" value="<?=utf8_encode($titulo)?>" placeholder="Titulo Tesis*" required data-validation-required-message="Introduce el titulo de la tesis">
                     <p class="help-block text-danger"></p>
                  </div>
                 
                 <div class="form-group">
                     <b>Tema</b>
                     <input class="form-control" id="tema" name="tema" type="text" value="<?=utf8_encode($tema)?>" placeholder="Tema*" required data-validation-required-message="Introduce tema tesis">
                     <p class="help-block text-danger"></p>
                  </div>
                
                 
                </div>
                
                <div class="clearfix"></div>
                <div class="col-lg-12 text-center">
                <div id="success"></div>
                  <button id="apuntate2" class="btn btn-xl" type="submit">Actualizar Alumno</button>
                </div>
              </div>
          </form>
         </div>
        </div>
      </div>  

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



<?
include_once "desconexionBD.inc";

?>
