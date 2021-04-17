<?php


$HEADERS = "MIME-Version: 1.0\r\n".
           "Content-type: text/html; charset=utf-8\r\n".
	   "From: mentoringplnnet@dlsi.ua.es\r\n".
	   "Reply-To: mentoringplnnet@dlsi.ua.es\r\n";

  mail("mvaro@dlsi.ua.es, tecs@dlsi.ua.es","HOLA 2","<html><h1>HTML</h1></html>",$HEADERS);

echo "Ya!";
?>
