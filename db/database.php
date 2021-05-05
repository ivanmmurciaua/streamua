<?php
	$servername = "bbdd.dlsi.ua.es";
	$username = "gi_streamua";
	$password = ".gi_streamua.";

	/// connection and character encoding ///
	$conn = new mysqli($servername, $username, $password, "gi_streamua2");

	if ($conn->connect_error) {
		die("Connection failed: " . $conn->connect_error);
	}
	/* echo "Connected successfully"; */

	/* cambiar el conjunto de caracteres a utf8 */
	if (!$conn->set_charset("utf8")) {
		/* printf("Error cargando el conjunto de caracteres utf8: %s\n", $conn->error); */
		exit();
	} else {
		/* printf("Conjunto de caracteres actual: %s\n", $conn->character_set_name()); */
	}
?>