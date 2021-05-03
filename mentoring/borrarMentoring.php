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


$emailMentor = $_GET['mentor'];
$emailAlumno = $_GET['alumno'];
$query =$link -> query("SELECT m.nombre as nombreMentor,a.nombre as nombreAlumno from Mentoring me, Mentor m, Alumno a where me.emailMentor='".$emailMentor."' and me.emailMentor=m.email and me.emailAlumno='".$emailAlumno."' and me.emailAlumno=a.email");

if($row = mysqli_fetch_array($query))
{
       $nombreM=$row['nombreMentor'];
       $nombreA=$row['nombreAlumno'];
    
     
}

?>
 <body id="page-top">
    <div class="container">
        <div class="row">
          <div class="col-lg-12 text-center">
            <h2 class="section-heading">Borrar Mentoring</h2>
          </div>
        </div>
        <div class="row">
         <div class="col-lg-12">
           <form id="apuntateAlu" name="apuntateAlu" method="POST" action="rborrarMentoring.php">
             <div class="row">
               <div class="col-md-12">
                  <div class="form-group">
                    <b>Seguro que desea borrar el Mentoring entre:</b><?php echo utf8_encode($nombreM)?> y <?php echo utf8_encode($nombreA)?>
                    <input class="form-control" id="emailM" name="emailM" type="hidden"  value="<?php echo $emailMentor?>">
					<input class="form-control" id="emailA" name="emailA" type="hidden"  value="<?php echo $emailAlumno?>">
                    <p class="help-block text-danger"></p>
                  </div>
                 
                </div>
                
                <div class="clearfix"></div>
                <div class="col-lg-12 text-center">
                <div id="success"></div>
                  <button id="apuntate2" class="btn btn-xl" type="submit">Borrar Mentoring</button>
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
