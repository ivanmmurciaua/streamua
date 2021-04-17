<?php session_start();?>
<!DOCTYPE html>
<html >
  <head>

 <meta charset="utf-8">
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
         <meta name="description" content="">
             <meta name="author" content="">
             
                 <title>Administracion Programa Mentoring. Red de excelencia PLN.NET</title>
                 
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

  <body>

  <header class="masthead">
        <div class="container">
                <div class="intro-text">
                          <div class="intro-lead-in">Administracion Programa Mentoring</div>
                          <form method ="post" action="comprobar_login.php">
                            <div class="login">
                              <div class="login-screen">
                                <div class="app-title">
				<h1>Iniciar sesion</h1>
				<?php 
						if(isset($_SESSION["error"]) && $_SESSION["error"]==1){
							echo "<span>Error en la autenticacion</span>";
						}
						unset($_SESSION["error"]);
						unset($_SESSION["usuario"]);
				?>


				</div>

				<div class="login-form">
				<form method = "post" action="comprobar_login.php">
				  <div class="control-group">
				  <input required type="text" name="login-name" class="login-field" value="" placeholder="Usuario" id="login-name">
				  <label class="login-field-icon fui-user" for="login-name"></label>
				  </div>

				<div class="control-group">
				<input required type="password" name="login-pass" class="login-field" value="" placeholder="Contraseña" id="login-pass">
				<label class="login-field-icon fui-lock" for="login-pass"></label>
				</div>

				<input type="submit" class="btn btn-xl" href="#"></input>

		
                                </form>
		      	</div>
		</div>
	</div>
       </form>



              </div>
      </div>
  </header>




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
</html>
