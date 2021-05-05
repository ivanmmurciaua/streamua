<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
		<style>
			table {
				font-family: arial, sans-serif;
				border-collapse: collapse;
				width: 100%;
			}

			td, th {
				border: 1px solid #dddddd;
				text-align: center;
				padding: 8px;
			}

			<!-- 
			tr:nth-child(even) {
				background-color: #dddddd;
			}
			-->
		</style>

		<title>CONTENIDO DE PELICULAS</title>
	</head>
	<body>
		<h1 align="center">GENEROS DE PELICULAS</h1>
		<table>
			<tr>
				<th colspan="10">
					<center>Contenidos</center>
				</th>
			</tr>
			<tr style="background-color: #dddddd">
				<td>Género</td>
				<td>URL_contenido</td>
				<td>Titulo</td>
				<td>Resumen</td>
				<td>Idioma</td>
				<td>Subtitulos</td>
				<td>Actores</td>
				<td>Director</td>					
			</tr>
			<!-- 
			<xsl:for-each select="generos">
			<xsl:if test="./titulo='TERROR'">
			-->
				<tr style="background-color:#EDBB99">
					<td><strong>Terror</strong></td>
					<td>http://www.mundodelterror.com</td>
					<td>Lo imposible</td>
					<td>Era una historia que...</td>
					<td>Español, ingles</td>
					<td>Chino</td>
					<td>Pedro Pelegrin, Lucia Fernandez</td>
					<td>Carlos Astarloa</td>
				</tr>
			<!-- 
			</xsl:if>
			-->
			<!-- <xsl:if test="./genero = 'Terror'"> -->
			<xsl:for-each select="principal">
			<!-- <xsl:if test="generos[@tipo='Action&amp;Adventure']"> -->
				<!-- <xsl:if test="./generos/tipo='COMEDIA'">-->
					<tr style="background-color:#F5B7B1">
						<td><xsl:value-of select="./generos/@tipo" /></td>
						<td><strong><xsl:value-of select="generos/pelicula/URL_contenido"/></strong></td>						
						<td><xsl:value-of select="generos/pelicula/titulo"/></td>						
						<td><xsl:value-of select="generos/pelicula/resumen"/></td>
						<td><xsl:value-of select="generos//pelicula/idioma"/></td>
						<td><xsl:value-of select="generos/pelicula/subtitulos"/></td>
						<td><xsl:value-of select="generos/pelicula/actores"/></td>
						<td><xsl:value-of select="generos/pelicula/director"/></td>
					</tr>				
				<!-- </xsl:if>-->
			</xsl:for-each>
			
			
			
			
			
			<!--
			
				
				<tr style="background-color:#AEB6BF">
					<td><strong>CrimeTVShows</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='CrimeTVShows'">
						<td>asassa&amp;</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#ABEBC6">
					<td><strong>Documentaries</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='Documentaries'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#D7BDE2">
					<td><strong>Docuseries</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='Docuseries'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#F9E79F">
					<td><strong>IndendentMovies</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='IndendentMovies'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#CD6155">
					<td><strong>HorrorMovies</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='HorrorMovies '">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#9FA8DA">
					<td><strong>Drama</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='Drama'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#FF99FF">
					<td><strong>InternationalMovies</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='InternationalMovies'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#BCAAA4">
					<td><strong>InternationalTVShows</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='InternationalTVShows'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#D4E157">
					<td><strong>Sci-Fi&amp;Fantasy</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='Sci-Fi&amp;Fantasy'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color: #DC7633">
					<td><strong>SportsMovies</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='SportsMovies'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#F1C40F">
					<td><strong>TERROR</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='TERROR'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#52BE80">
					<td><strong>Thrillers</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='Thrillers'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#F06292">
					<td><strong>TVDramas</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='TVDramas'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#17A589">
					<td><strong>TVMysteries</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='TVMysteries'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>
				
				<tr style="background-color:#66CCFF">
					<td><strong>TVSci-Fi&amp;Fantasy</strong></td>
					<td><strong><xsl:value-of select="./generos/pelicula/URL_contenido"/></strong></td>
					
					<xsl:if test="./titulo='TVSci-Fi&amp;Fantasy'">
						<td>asassa</td>
					</xsl:if>
					
					<td><strong><xsl:value-of select="./resumen"/></strong></td>
					<td><strong><xsl:value-of select="./idioma"/></strong></td>
					<td><strong><xsl:value-of select="./subtitulos"/></strong></td>
					<td><strong><xsl:value-of select="./actores"/></strong></td>
					<td><strong><xsl:value-of select="./director"/></strong></td>
				</tr>




			</xsl:for-each>
			
			-->
				
	
		</table>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>


