<script type="text/javascript">
function cargar(){
    opener.location.reload();
    window.close();
}
</script>
<?php 
include_once "conexionBD.inc";
$emailM = $_POST['emailM'];
$emailA = $_POST['emailA'];

$query= $link ->query("DELETE from Mentoring where emailMentor='".$emailM."' and emailAlumno='".$emailA."'");


if (!$query)
{
?>

<html>
 <div class="alert alert-success alert-dismissable">
  <h2><strong>Error!</strong> al borrar el mentoring</h2>

 </div>
</html>
<?php

}
else
{

?>

<html>
 <div class="alert alert-success alert-dismissable">
  <h2><strong>Felicidades!</strong> Mentoring borrado</h2>
 </div>
 
   <button onclick="cargar();">Volver</button>
</html>
<?php
}

include_once "desconexionBD.inc";

?>
