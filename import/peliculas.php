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

$ficherocsv = "netflix_titles2.csv";

// Leemos el fichero de peliculas

/*
	datos[1] ->  tipo
	datos[2] ->  titulo
	datos[3] ->  director
	datos[4] ->  actores
	datos[10] -> genero/s
	datos[11] -> resumen
*/

$id = 10;

/* Rellenando PELICULAS */

if (($fichy = fopen($ficherocsv, "r")) !== FALSE) {
    while (($datos = fgetcsv($fichy, 50000, ",")) !== FALSE) {

      echo "idContenido -> ".$id."<br />";
      $idContenido = $id;
      
      if(strcmp($datos[1], "Movie") !== 0){
        echo "URL_contenido -> https://www.streamua.ddnsking.com/series/".str_replace(" ","",$datos[2])."<br />";
        $URL_contenido = "https://www.streamua.ddnsking.com/series/".str_replace(" ","",$datos[2]);
      }else{
        echo "URL_contenido -> https://www.streamua.ddnsking.com/peliculas/".str_replace(" ","",$datos[2])."<br />";
        $URL_contenido = "https://www.streamua.ddnsking.com/peliculas/".str_replace(" ","",$datos[2]);
      }
      
      echo "titulo -> ".$datos[2]."<br />";
      $titulo = $datos[2];

      echo "resumen -> ".$datos[11]."<br />";
      $resumen = $datos[11];

      echo "idioma -> ".$datos[5]."<br />";
      $idioma = $datos[5];

      echo "actores -> ".$datos[4]."<br />";
      $actores = $datos[4];
      if(is_null($actores)){$actores='';}

      echo "director -> ".$datos[3]."<br />";
      $director = $datos[3];
      if(is_null($director)){$director='';}

      echo "emailAdministrador -> admin1@gmail.com"."<br />";
      $emailAdministrador = "admin1@gmail.com"; 

      echo "tipoGenero -> ".str_replace(" ","",explode(",",$datos[10])[0])."<br />";
      $tipoGenero = str_replace(" ","",explode(",",$datos[10])[0]);

      // Rellenamos la tabla Contenido
      $query1 = "INSERT INTO Contenido(idContenido,URL_contenido,titulo,resumen,idioma,actores,director,emailAdministrador,tipoGenero) VALUES (".$idContenido.",'".$URL_contenido."','".$titulo."','".$resumen."','".$idioma."','".$actores."','".$director."','".$emailAdministrador."','".$tipoGenero."')";
      $result1 = $conn->query($query1);

      // Metemos la serie/pelicula en su tabla correspondiente
      
      // *******************************************MIRAR ESTA MIERDA****************************************
      /*if(strcmp($datos[1], "Movie") !== 0){
        $query2 = "INSERT INTO Serie(idContenido) VALUES (".$idContenido.")";
      }else{
        $query2 = "INSERT INTO Pelicula(idContenido) VALUES (".$idContenido.")";
      }

      $result2 = $conn->query($query2);*/

      echo "------------------------------------------ <br />";

      $id++;

    }

    fclose($fichy);
}

?>