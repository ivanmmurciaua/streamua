<?php

include('../../db/database.php');

$urlContenido = $_POST['urlContenido'];
$titulo = $_POST['titulo'];
$resumen = $_POST['resumen'];
$idioma = $_POST['idioma'];
$subtitulos = $_POST['subtitulos'];
$actores = $_POST['actores'];
$director = $_POST['director'];
$emailAdministrador = $_POST['emailAdministrador'];
$tipoGenero = $_POST['tipoGenero'];
$tipoContenido = $_POST['tipoContenido'];

$qry = "call anadirContenido('$urlContenido','$titulo','$resumen','$idioma','$subtitulos','$actores','$director','$emailAdministrador','$tipoGenero')";

if(!mysqli_query($conn,$qry)) {
	echo  $conn->error;
} else {

	$query1 = "SELECT MAX(idContenido) AS id FROM Contenido";
	
	if($resultado = mysqli_query($conn,$query1)) {

		while($row = $resultado->fetch_assoc())
        {
              $id = $row['id'];
        }                                                                                                                                               

		if(strcmp($tipoContenido, "Pelicula") !== 0){

	        $query2 = "INSERT INTO Serie(idContenido) VALUES (".$id.")";

	    }else{

	        $query2 = "INSERT INTO Pelicula(idContenido) VALUES (".$id.")";
	    }

	    if(!mysqli_query($conn,$query2)) {
			echo  $conn->error;
		}
		else{
	    	echo "El contenido '$titulo' ha sido añadido a la base de datos.";
		}
		
	} else {
		echo  $conn->error;
	}

}

$conn->close();

?>