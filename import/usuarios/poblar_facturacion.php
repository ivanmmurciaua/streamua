<?php

include('../../db/database.php');

$qry = $conn->query("SELECT email FROM Cliente");
$id = 1;

while($row = $qry->fetch_assoc()){

  $email = $row['email'];
  $numT = rand(1111111111111111,9999999999999999);
  $CVV = rand(111,999);
  $dia = rand(1,28);
  $mes = rand(1,12);
  $anyo = rand(2022,2050);

  $query = "INSERT INTO Facturacion(idFacturacion,numTarjeta,CVV,fechaCaducidad,diaFacturacion) VALUES ($id,'$numT','$CVV','$anyo.$mes.$dia','2021-05-27')";

  if($conn->query($query)){

    $queryy = "INSERT INTO Abona VALUES ($id,'$email')";

    if($conn->query($queryy)){

      echo "REGISTRO → ".$id;
      echo "<br />";
      echo "------------------------------------------ <br />";
      echo "<h1><b>Registro insertado</b></h1>";
      echo "------------------------------------------ <br />";
    }
    else{

      echo "REGISTRO → ".$id;
      echo "------------------------------------------ <br />";
      echo "<h1>Fallo en 2ª tabla <b>".$conn->error."</b></h1>";
      echo "------------------------------------------ <br />";
    }
  }
  else{

      echo "REGISTRO → ".$id;
      echo "------------------------------------------ <br />";
      echo "<h1><b>".$conn->error."</b></h1>";
      echo "------------------------------------------ <br />";
  }

  $id++;
}


/*for ($i=0; $i < $registros_totales ; $i++) {

  echo "REGISTRO -> ". $i;
  echo "<br />";
  
  $nombre_rand = rand(1,$max_nombres);
  $ap1_rand = rand(1,$max_apellidos);
  $ap2_rand = rand(1,$max_apellidos);
  $ap1 = true;
  $ap2 = true;

  if (($fichy = fopen($ficherocsv1, "r")) !== FALSE) {
    while (($datos = fgetcsv($fichy, 1000, ";")) !== FALSE) {
      if($datos[0] == $nombre_rand)
        $nombre = ucwords(strtolower($datos[1]));
    } 
  }

  fclose($fichy);

  if (($fichy2 = fopen($ficherocsv2, "r")) !== FALSE) {
    while (($datos2 = fgetcsv($fichy2, 1000, ";")) !== FALSE) {
      if($ap1 || $ap2){
        if($datos2[0] == $ap1_rand){
          $apellido1 = ucwords(strtolower($datos2[1]));
          $ap1 = false;
        }
        if($datos2[0] == $ap2_rand){
          $apellido2 = ucwords(strtolower($datos2[1]));
          $ap2 = false;
        }
      }

      else{
        
        $email = strtolower(str_replace(" ","",$nombre)).strtolower(str_replace(" ","",$apellido1)).strtolower(str_replace(" ","",$apellido2))."@gmail.com";;
        echo "Email: ". $email;
        
        echo "<br />";
        echo "Apellido 1: ". $apellido1;
        
        echo "<br />";
        echo "Apellido 2: ". $apellido2;
        echo "<br />";
        
        $idioma = "Español";
        echo "Idioma: ".$idioma;
        echo "<br />";
        
        $permitirDescarga = 0;
        echo "permitirDescarga: ". $permitirDescarga;
        echo "<br />";

        $tiposusc = "normal";
        echo "tipoSuscripcion: normal";
        echo "<br />";
        
        $codProm = 4;
        echo "codProm: 4";
        echo "<br />";
        
        $_4numpass = rand(0,9999);
        $pass = substr(strtolower(str_replace(" ","",$nombre)),0,3).substr(strtolower(str_replace(" ","",$apellido1)),0,3).substr(strtolower(str_replace(" ","",$apellido2)),0,3)."$$".$_4numpass;
        echo "Password: " . $pass;
        echo "<br />";
        
        echo "Nombre: ".$nombre;
        echo "<br />";
        echo "<br />";
        
        break;
      }
    }
  }

  fclose($fichy2);

  // INSERTAR EN BBDD
  $qry = "CALL registrarUsuario('$email','$apellido1','$apellido2','$idioma',$permitirDescarga,'$tiposusc',$codProm,'$pass','$nombre')";

  if($conn->query($qry)){
    echo "------------------------------------------ <br />";
    echo "<h1><b>Registro insertado</b></h1>";
    echo "------------------------------------------ <br />";
  }
  else{
    echo "------------------------------------------ <br />";
    echo "<h1><b>".$conn->error."</b></h1>";
    echo "------------------------------------------ <br />";
  }

}*/


?>