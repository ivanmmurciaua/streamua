<script type="text/javascript">
function cargar(){
    opener.location.reload();
    window.close();
}
</script>
<?php 



include_once "conexionBD.inc";

$email = $_POST['email'];
$nombre = $_POST['nombre'];
$titulo= $_POST['titulo'];
$tema= $_POST['tema'];



$query= $link ->query("UPDATE Alumno SET nombre='".utf8_decode($nombre)."',titulo='".utf8_decode($titulo)."',tema='".utf8_decode($tema)."' where email='".$email."'");



?>

<html>
 <div class="alert alert-success alert-dismissable">
  <h2><strong>Felicidades!</strong> Alumno actualizado</h2>
 </div>
 
   <button onclick="cargar();">Volver</button>
</html>
<?php

include_once "desconexionBD.inc";

?>
