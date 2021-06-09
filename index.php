<?php
session_start();
?>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="css/estilosIndex.css">
	<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Open+Sans:wght@400;600&display=swap" rel="stylesheet"> 
	<title>StreamUA</title>
</head>
<body>
	<header>
		<div class="contenedor">
			<h2 class="logotipo">STREAMUA</h2>
			<nav>
				<a href="#" class="activo">Inicio</a>
				<a href="series.php">Series</a>
				<a href="peliculas.php">Películas</a>
				<a href="novedadesCliente.php">Novedades</a>

				<?php
					if(isset($_SESSION["logged"])) {
						echo "<a href='milista.php'> Mi Lista </a>";	
					}
				?>

				<?php
					if(!isset($_SESSION["admin"])) {
					}
					else{
						echo "<a href='./admin/listarContenido.php'>Admin</a>";
					}
				?>

				
				<?php
					if(!isset($_SESSION["logged"])) {
						echo "<a href='./login.php'>Login</a>";	
					}
					else{
						echo "<a href='./cerrarsesion.php'>Cerrar sesión</a>";
					}
				?>
				
			</nav>
		</div>
	</header>

	<main>
		<div class="pelicula-principal">
			<div class="contenedor">
				<br>
				<br>
				<h3 class="titulo">La casa de papel</h3>
				<p class="descripcion">
					Este documental analiza cómo y por qué "La casa de papel" ha logrado que el mundo entero apoye entusiasmado a una banda de ladrones y su líder.
				</p>
				<button role="button" class="boton"><i class="fas fa-play"></i><a style="text-decoration: none; color:white;" href="./detalle.php?idContenido=5994">Reproducir</a></button>
				<button role="button" class="boton"><i class="fas fa-info-circle"></i><a style="text-decoration: none; color:white;" href="https://www.netflix.com/es/title/81098822">Más información</a></button>
			</div>
		</div>

		<div class="peliculas-recomendadas contenedor">
			<div class="contenedor-titulo-controles">
				<h3>Películas Recomendadas</h3>
				<div class="indicadores"></div>
			</div>

			<div class="contenedor-principal">
				<button role="button" id="flecha-izquierda" class="flecha-izquierda"><i class="fas fa-angle-left"></i></button>

				<div class="contenedor-carousel">
					<div class="carousel">
						<div class="pelicula">
							<a href="#"><img src="img/1.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/2.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/3.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/4.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/5.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/6.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/7.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/8.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/9.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/10.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/11.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/12.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/13.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/14.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/15.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/16.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/17.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/18.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/19.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/20.png" alt=""></a>
						</div>
						<div class="pelicula">
							<a href="#"><img src="img/21.png" alt=""></a>
						</div>
					</div>
				</div>

				<button role="button" id="flecha-derecha" class="flecha-derecha"><i class="fas fa-angle-right"></i></button>
			</div>
		</div>

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

	</main>
	
	<script src="https://kit.fontawesome.com/2c36e9b7b1.js" crossorigin="anonymous"></script>
	<script src="js/main.js"></script>
</body>
</html>