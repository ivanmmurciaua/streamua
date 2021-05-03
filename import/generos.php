<?php

// Datos
$servername = "bbdd.dlsi.ua.es";
$username = "gi_streamua";
$password = ".gi_streamua.";
$bbdd = "gi_streamua2";

// Creamos conex
$conn = new mysqli($servername, $username, $password, $bbdd);

// Hay conex?
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
else{
  $conn->set_charset("utf8");
}

$ficherocsv = "netflix_titles.csv";

/* GENEROS */
$generos = array();

/* Rellenando GENEROS */

if (($fichy = fopen($ficherocsv, "r")) !== FALSE) {
    while (($datos = fgetcsv($fichy, 1000, ",")) !== FALSE) {
		$generosseparados = explode(",", $datos[10]);
     		for($in = 0 ; $in < count($generosseparados); $in++){
	     		array_push($generos,str_replace(" ","",$generosseparados[$in]));
     		}
   	}

   	$generoslimpios = array_unique($generos);

   	// Limpiando los generos y añadimos
    for($in = 1 ; $in < count($generoslimpios); $in++){
    		if(isset($generoslimpios[$in])){
    				
    			$query2 = "INSERT INTO Genero(tipo,descripcion) VALUES('".$generoslimpios[$in]."','".$generoslimpios[$in]."')";

    			$result2 = $conn->query($query2);
    		}		
    }

    fclose($fichy);
}

?>