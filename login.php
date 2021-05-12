<?php
//ob_start();
session_start();
//
// Cerrar sesión
//unset($_SESSION['logged']);
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css" integrity="sha384-G0fIWCsCzJIMAVNQPfjH08cyYaUtMwjJwqiRKxxE/rx96Uroj1BtIQ6MLJuheaO9" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
  <link rel="stylesheet" href="./css/login.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

  <title>StreamUA</title>
</head>
<body>
  
  <!--<header>
    <div class="contenedor">
      <h2 class="logotipo">STREAMUA</h2>
      <nav>
        <a href="./index.php" class="activo">Inicio</a> 
      </nav>
    </div>
  </header>-->
  
  <div class="wrapper">
    <div class="login-text">
      <button id="cta" class="cta">
        <i class="fas fa-chevron-down fa-1x"></i>
      </button>
    <div class="text">
      <a href="">Login</a>
      <hr>
      <br>
      <input id="Usuario" type="text" placeholder="Usuario">
      <br>
      <input id="Contrasena" type="password" placeholder="Contraseña">
      <br>
      <button style="cursor: pointer;" onClick="login()" class="login-btn">Login</button>
    </div>
  </div>
  <div class="call-text">
    <h1>Únete a la mayor plataforma multimedia</h1>
    <button>Registrarme</button>
    &nbsp&nbsp&nbsp<button><a style="text-decoration: none; color:white" href="./index.php">Volver a inicio</a></button>
  </div>
  </div>
</body>

  <script type="text/javascript">
    var cta = document.querySelector(".cta");
    var check = 0;

    cta.addEventListener('click', function(e){
        var text = e.target.nextElementSibling;
        var loginText = e.target.parentElement;
        text.classList.toggle('show-hide');
        loginText.classList.toggle('expand');
        if(check == 0)
        {
            cta.innerHTML = "<i class='fas fa-chevron-up'></i>";
            check++;
        }
        else
        {
            cta.innerHTML = "<i class='fas fa-chevron-down'></i>";
            check = 0;
        }
    })

    function login(){

      var gofre = $('#Usuario').val();
      var chocolate = $('#Contrasena').val();
      var id = <?php echo json_encode(session_id()); ?>
      
      $.ajax({
        type: 'POST',
        url: 'admin/loginSession.php',
        data: { id: id,
                usu: gofre,
                pwd: chocolate
              },
        success: function(data) {
          alert(data);
        }
      });

    }

  </script>


</html>