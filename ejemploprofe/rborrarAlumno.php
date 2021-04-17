<script type="text/javascript">
function cargar(){
    opener.location.reload();
    window.close();
}
</script>
<?php 



include_once "conexionBD.inc";
$email = $_POST['email'];


$query= $link ->query("DELETE from Alumno where email='".$email."'");


if (!$query)
{
?>

<html>
 <div class="alert alert-success alert-dismissable">
  <h2><strong>Error!</strong> al borrar el alumno</h2>
 </div>
</html>
<?php

}
else
{

?>

<html>
 <div class="alert alert-success alert-dismissable">
  <h2><strong>Felicidades!</strong> Alumno borrado</h2>
 </div>
 
 
   <button onclick="cargar();">Volver</button>
</html>
<?php
}

include_once "desconexionBD.inc";

?>
