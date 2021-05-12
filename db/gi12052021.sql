/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE IF NOT EXISTS `gi_streamua2` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;
USE `gi_streamua2`;

CREATE TABLE IF NOT EXISTS `Abona` (
  `idFacturacion` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idFacturacion`),
  UNIQUE KEY `numTarjeta` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Abona` DISABLE KEYS */;
/*!40000 ALTER TABLE `Abona` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Administrador` (
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `Administrador_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Usuario` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
INSERT INTO `Administrador` (`email`) VALUES
	('admin1@gmail.com'),
	('admin2@gmail.com');
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` FUNCTION `anadirBanco`(IBAN VARCHAR(24), BIC VARCHAR(11), banco VARCHAR(50)) RETURNS tinyint(1)
BEGIN

-- fecha actual
DECLARE fechaActual DATE;
DECLARE introducido bool DEFAULT false;   

SELECT CURDATE() INTO fechaActual;

IF LENGTH(IBAN) = 24 then

    IF LENGTH(BIC) = 11 then
    	
         -- AÑADIMOS BANCO
         INSERT INTO Facturacion(IBAN,BIC,banco,diaFacturacion) VALUES (IBAN,BIC,banco,fechaActual);
         SET introducido := true;          
        
    END IF;

END IF;

RETURN introducido;

END//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `anadirContenido`(

	IN p_idContenido INT,
	IN p_urlContenido VARCHAR(50),
	IN p_titulo VARCHAR(50),
	IN p_resumen TEXT,
	IN p_idioma VARCHAR(20),
	IN p_subtitulos VARCHAR(20),
	IN p_actores VARCHAR(100),
	IN p_director VARCHAR(50),
	IN p_emailAdministrador VARCHAR(50),
	IN p_tipoGenero VARCHAR(20)
)
BEGIN

	INSERT INTO Contenido(idContenido,URL_contenido,titulo,resumen,idioma,subtitulos,actores,director,emailAdministrador,tipoGenero) VALUES (p_idContenido,p_urlContenido,p_titulo,p_resumen,p_idioma,p_subtitulos,p_actores,p_director,p_emailAdministrador,p_tipoGenero);

END//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` FUNCTION `anadirTarjeta`(numeroTarjeta VARCHAR(16), CVV int, fechaCad DATE) RETURNS tinyint(1)
BEGIN

-- fecha actual
DECLARE fechaActual DATE;
DECLARE introducido bool DEFAULT false;   

SELECT CURDATE() INTO fechaActual;

IF LENGTH(numeroTarjeta) = 16 then

    IF LENGTH(CONVERT(CVV,VARCHAR(16))) = 3 then
    		
        IF fechaCad > fechaActual then
        
            -- AÑADIMOS LA TARJETA
            INSERT INTO Facturacion(numeroTarjeta,fechaCaducidad,CVV,diaFacturacion) VALUES (numeroTarjeta,fechaCad,CVV,fechaActual);
            SET introducido := true;
            
        END IF;
        
    END IF;

END IF;

RETURN introducido;

END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `Cliente` (
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `apellido1` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `apellido2` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `idioma` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `permitirDescarga` tinyint(1) DEFAULT 0,
  `tipoSuscripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `codProm` int(11) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `tipoSuscripcion` (`tipoSuscripcion`),
  KEY `codProm` (`codProm`),
  CONSTRAINT `Cliente_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Usuario` (`email`),
  CONSTRAINT `Cliente_ibfk_2` FOREIGN KEY (`tipoSuscripcion`) REFERENCES `Suscripcion` (`tipo`),
  CONSTRAINT `Cliente_ibfk_3` FOREIGN KEY (`codProm`) REFERENCES `CodigoPromocion` (`codProm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` (`email`, `apellido1`, `apellido2`, `idioma`, `permitirDescarga`, `tipoSuscripcion`, `codProm`) VALUES
	('chocolate@gmail.com', 'gofre', 'croissant', 'español', 1, 'premium', 4),
	('cliente@email', 'martinez', 'perez', 'frances', 1, 'premium', 4),
	('cliente@gmail.com', 'NombreCliente', 'ApellidoCliente', 'español', 1, 'premium', 4),
	('nopuedomas@gmail.com', 'ureña', 'ureña', 'español', 1, 'premium', 4),
	('patriciovaalmedico@gmail.com', 'pña', 'pña', 'español', 0, 'premium', 4),
	('sgs@gmail.com', 'gofre', 'croissant', 'español', 1, 'premium', 4),
	('trucao@gmail.com', 'gofre', 'croissant', 'español', 1, 'premium', 4);
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `CodigoPromocion` (
  `codProm` int(11) NOT NULL AUTO_INCREMENT,
  `fechaCreacion` date DEFAULT curdate(),
  `fechaExpiracion` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `descuento` int(11) DEFAULT NULL,
  `emailAdministrador` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`codProm`),
  KEY `emailAdministrador` (`emailAdministrador`),
  CONSTRAINT `CodigoPromocion_ibfk_1` FOREIGN KEY (`emailAdministrador`) REFERENCES `Administrador` (`email`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `CodigoPromocion` DISABLE KEYS */;
INSERT INTO `CodigoPromocion` (`codProm`, `fechaCreacion`, `fechaExpiracion`, `activo`, `descuento`, `emailAdministrador`) VALUES
	(4, '2021-03-24', '2021-05-24', 1, NULL, 'admin1@gmail.com'),
	(5, '2021-03-24', '2021-03-22', 1, NULL, 'admin2@gmail.com'),
	(13, '2021-05-05', '2030-01-20', 1, 20, 'admin1@gmail.com'),
	(15, '2021-05-05', '2021-05-20', 1, 20, 'admin1@gmail.com'),
	(16, '2021-05-05', '2021-05-29', 1, 20, 'admin1@gmail.com'),
	(18, '2021-05-12', '2021-05-18', 1, 3, 'admin1@gmail.com'),
	(19, '2021-05-12', '2021-05-18', 1, 4, 'admin1@gmail.com');
/*!40000 ALTER TABLE `CodigoPromocion` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Contacto` (
  `idContacto` int(11) NOT NULL AUTO_INCREMENT,
  `asunto` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `emailCliente` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idContacto`),
  KEY `emailCliente` (`emailCliente`),
  CONSTRAINT `Contacto_ibfk_1` FOREIGN KEY (`emailCliente`) REFERENCES `Cliente` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Contacto` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contacto` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Contenido` (
  `idContenido` int(11) NOT NULL AUTO_INCREMENT,
  `URL_contenido` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagenPortada` blob DEFAULT NULL,
  `titulo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `resumen` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `idioma` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `subtitulos` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `actores` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `director` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `puntuacionMedia` int(11) DEFAULT 0,
  `emailAdministrador` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipoGenero` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idContenido`),
  KEY `emailAdministrador` (`emailAdministrador`),
  KEY `tipoGenero` (`tipoGenero`),
  CONSTRAINT `Contenido_ibfk_1` FOREIGN KEY (`emailAdministrador`) REFERENCES `Administrador` (`email`),
  CONSTRAINT `Contenido_ibfk_2` FOREIGN KEY (`tipoGenero`) REFERENCES `Genero` (`tipo`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Contenido` DISABLE KEYS */;
INSERT INTO `Contenido` (`idContenido`, `URL_contenido`, `imagenPortada`, `titulo`, `resumen`, `idioma`, `subtitulos`, `actores`, `director`, `puntuacionMedia`, `emailAdministrador`, `tipoGenero`) VALUES
	(2, 'https://www.streamua.ddnsking.com/series/3%', NULL, '3%', 'In a future where the elite inhabit an island paradise far from the crowded slums, you get one chance to join the 3% saved from squalor.', 'Brazil', NULL, 'João Miguel, Bianca Comparato, Michel Gomes, Rodolfo Valente, Vaneza Oliveira, Rafael Lozano, Vivian', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(3, 'https://www.streamua.ddnsking.com/peliculas/7:19', NULL, '7:19', 'After a devastating earthquake hits Mexico City, trapped survivors from all walks of life wait to be rescued while trying desperately to stay alive.', 'Mexico', NULL, 'Demián Bichir, Héctor Bonilla, Oscar Serrano, Azalia Ortiz, Octavio Michel, Carmen Beato', 'Jorge Michel Grau', 0, 'admin1@gmail.com', 'Dramas'),
	(4, 'https://www.streamua.ddnsking.com/peliculas/23:59', NULL, '23:59', 'When an army recruit is found dead, his fellow soldiers are forced to confront a terrifying secret thats haunting their jungle island training camp.', 'Singapore', NULL, 'Tedd Chan, Stella Chung, Henley Hii, Lawrence Koh, Tommy Kuan, Josh Lai, Mark Lee, Susan Leong, Benj', 'Gilbert Chan', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(5, 'https://www.streamua.ddnsking.com/peliculas/9', NULL, '9', 'In a postapocalyptic world, rag-doll robots hide in fear from dangerous machines out to exterminate them, until a brave newcomer joins the group.', 'United States', NULL, 'Elijah Wood, John C. Reilly, Jennifer Connelly, Christopher Plummer, Crispin Glover, Martin Landau, ', 'Shane Acker', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(6, 'https://www.streamua.ddnsking.com/peliculas/21', NULL, '21', 'A brilliant group of students become card-counting experts with the intent of swindling millions out of Las Vegas casinos by playing blackjack.', 'United States', NULL, 'Jim Sturgess, Kevin Spacey, Kate Bosworth, Aaron Yoo, Liza Lapira, Jacob Pitts, Laurence Fishburne, ', 'Robert Luketic', 0, 'admin1@gmail.com', 'Dramas'),
	(7, 'https://www.streamua.ddnsking.com/series/46', NULL, '46', 'A genetics professor experiments with a treatment for his comatose sister that blends medical and shamanic cures, but unlocks a shocking side effect.', 'Turkey', NULL, 'Erdal Beşikçioğlu, Yasemin Allen, Melis Birkan, Saygın Soysal, Berkan Şal, Metin Belgin, Ayça Eren, ', 'Serdar Akar', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(8, 'https://www.streamua.ddnsking.com/peliculas/122', NULL, '122', 'After an awful accident, a couple admitted to a grisly hospital are separated and must find each other to escape — before death finds them.', 'Egypt', NULL, 'Amina Khalil, Ahmed Dawood, Tarek Lotfy, Ahmed El Fishawy, Mahmoud Hijazi, Jihane Khalil, Asmaa Gala', 'Yasir Al Yasiri', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(9, 'https://www.streamua.ddnsking.com/peliculas/187', NULL, '187', 'After one of his high school students attacks him, dedicated teacher Trevor Garfield grows weary of the gang warfare in the New York City school system and moves to California to teach there, thinking it must be a less hostile environment.', 'United States', NULL, 'Samuel L. Jackson, John Heard, Kelly Rowan, Clifton Collins Jr., Tony Plana', 'Kevin Reynolds', 0, 'admin1@gmail.com', 'Dramas'),
	(10, 'https://www.streamua.ddnsking.com/peliculas/706', NULL, '706', 'When a doctor goes missing, his psychiatrist wife treats the bizarre medical condition of a psychic patient, who knows much more than hes leading on.', 'India', NULL, 'Divya Dutta, Atul Kulkarni, Mohan Agashe, Anupam Shyam, Raayo S. Bakhirta, Yashvit Sancheti, Greeva ', 'Shravan Kumar', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(11, 'https://www.streamua.ddnsking.com/peliculas/1920', NULL, '1920', 'An architect and his wife move into a castle that is slated to become a luxury hotel. But something inside is determined to stop the renovation.', 'India', NULL, 'Rajneesh Duggal, Adah Sharma, Indraneil Sengupta, Anjori Alagh, Rajendranath Zutshi, Vipin Sharma, A', 'Vikram Bhatt', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(12, 'https://www.streamua.ddnsking.com/peliculas/1922', NULL, '1922', 'A farmer pens a confession admitting to his wifes murder, but her death is just the beginning of a macabre tale. Based on Stephen Kings novella.', 'United States', NULL, 'Thomas Jane, Molly Parker, Dylan Schmid, Kaitlyn Bernard, Bob Frazer, Brian dArcy James, Neal McDono', 'Zak Hilditch', 0, 'admin1@gmail.com', 'Dramas'),
	(13, 'https://www.streamua.ddnsking.com/series/1983', NULL, '1983', 'In this dark alt-history thriller, a naïve law student and a world-weary detective uncover a conspiracy that has tyrannized Poland for decades.', 'Poland, United State', NULL, 'Robert Więckiewicz, Maciej Musiał, Michalina Olszańska, Andrzej Chyra, Clive Russell, Zofia Wichłacz', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(14, 'https://www.streamua.ddnsking.com/series/1994', NULL, '1994', 'Archival video and new interviews examine Mexican politics in 1994, a year marked by the rise of the EZLN and the assassination of Luis Donaldo Colosio.', 'Mexico', NULL, '', 'Diego Enrique Osorno', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(15, 'https://www.streamua.ddnsking.com/peliculas/2,215', NULL, '2,215', 'This intimate documentary follows rock star Artiwara Kongmalai on his historic, 2,215-kilometer charity run across Thailand in 2017.', 'Thailand', NULL, 'Artiwara Kongmalai', 'Nottapon Boonprakob', 0, 'admin1@gmail.com', 'Documentaries'),
	(16, 'https://www.streamua.ddnsking.com/peliculas/3022', NULL, '3022', 'Stranded when the Earth is suddenly destroyed in a mysterious cataclysm, the astronauts aboard a marooned space station slowly lose their minds.', 'United States', NULL, 'Omar Epps, Kate Walsh, Miranda Cosgrove, Angus Macfadyen, Jorja Fox, Enver Gjokaj, Haaz Sleiman', 'John Suits', 0, 'admin1@gmail.com', 'IndependentMovies'),
	(17, 'https://www.streamua.ddnsking.com/peliculas/Oct-01', NULL, 'Oct-01', 'Against the backdrop of Nigerias looming independence from Britain, detective Danladi Waziri races to capture a killer terrorizing local women.', 'Nigeria', NULL, 'Sadiq Daba, David Bailie, Kayode Olaiya, Kehinde Bankole, Fabian Adeoye Lojede, Nick Rhys, Kunle Afo', 'Kunle Afolayan', 0, 'admin1@gmail.com', 'Dramas'),
	(18, 'https://www.streamua.ddnsking.com/series/Feb-09', NULL, 'Feb-09', 'As a psychology professor faces Alzheimers, his daughter and her three close female friends experience romance, marriage, heartbreak and tragedy.', '', NULL, 'Shahd El Yaseen, Shaila Sabt, Hala, Hanadi Al-Kandari, Salma Salem, Ibrahim Al-Harbi, Mahmoud Bousha', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(19, 'https://www.streamua.ddnsking.com/peliculas/22-Jul', NULL, '22-Jul', 'After devastating terror attacks in Norway, a young survivor, grieving families and the country rally for justice and healing. Based on a true story.', 'Norway, Iceland, Uni', NULL, 'Anders Danielsen Lie, Jon Øigarden, Jonas Strand Gravli, Ola G. Furuseth, Maria Bock, Thorbjørn Harr', 'Paul Greengrass', 0, 'admin1@gmail.com', 'Dramas'),
	(20, 'https://www.streamua.ddnsking.com/peliculas/15-Aug', NULL, '15-Aug', 'On Indias Independence Day, a zany mishap in a Mumbai chawl disrupts a young love story while compelling the residents to unite in aid of a little boy.', 'India', NULL, 'Rahul Pethe, Mrunmayee Deshpande, Adinath Kothare, Vaibhav Mangale, Jaywant Wadkar, Satish Pulekar, ', 'Swapnaneel Jayakar', 0, 'admin1@gmail.com', 'Comedies'),
	(21, 'https://www.streamua.ddnsking.com/peliculas/89', NULL, '89', 'Mixing old footage with interviews, this is the story of Arsenals improbable win versus Liverpool in the final moments of the 1989 championship game.', 'United Kingdom', NULL, 'Lee Dixon, Ian Wright, Paul Merson', '', 0, 'admin1@gmail.com', 'SportsMovies'),
	(22, 'https://www.streamua.ddnsking.com/peliculas/​​KuchBheegeAlfaaz', NULL, '​​Kuch Bheege Alfaaz', 'After accidentally connecting over the Internet, two strangers form a tight friendship – not knowing they already share a bond.', 'India', NULL, 'Geetanjali Thapa, Zain Khan Durrani, Shray Rai Tiwari, Mona Ambegaonkar, Chandreyee Ghosh, Barun Cha', 'Onir', 0, 'admin1@gmail.com', 'Dramas'),
	(23, 'https://www.streamua.ddnsking.com/peliculas/​GoliSoda2', NULL, '​Goli Soda 2', 'A taxi driver, a gangster and an athlete struggle to better their lives despite obstacles like crooked politicians, evil dons and caste barriers.', 'India', NULL, 'Samuthirakani, Bharath Seeni, Vinoth, Esakki Barath, Chemban Vinod Jose, Gautham Menon, Krisha Kurup', 'Vijay Milton', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(24, 'https://www.streamua.ddnsking.com/peliculas/​MajRati​​Keteki', NULL, '​Maj Rati ​​Keteki', 'A successful writer returns to the town that launched his career, encountering people who spark nostalgic, often painfully illuminating flashbacks.', 'India', NULL, 'Adil Hussain, Shakil Imtiaz, Mahendra Rabha, Sulakshana Baruah, Rahul Gautam Sarma, Kulada Bhattacha', 'Santwana Bardoloi', 0, 'admin1@gmail.com', 'Dramas'),
	(25, 'https://www.streamua.ddnsking.com/peliculas/​Mayurakshi', NULL, '​Mayurakshi', 'When a middle-aged divorcee returns to Kolkata to visit his ailing father, long-buried memories resurface, bringing new discoveries with them.', 'India', NULL, 'Soumitra Chatterjee, Prasenjit Chatterjee, Indrani Haldar, Sudipta Chakraborty, Suman Banerjee, Garg', 'Atanu Ghosh', 0, 'admin1@gmail.com', 'Dramas'),
	(26, 'https://www.streamua.ddnsking.com/series/​SAINTSEIYA:KnightsoftheZodiac', NULL, '​SAINT SEIYA: Knights of the Zodiac', 'Seiya and the Knights of the Zodiac rise again to protect the reincarnation of the goddess Athena, but a dark prophecy hangs over them all.', 'Japan', NULL, 'Bryson Baugus, Emily Neves, Blake Shepard, Patrick Poole, Luci Christian, Adam Gibbs, Masakazu Morit', '', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(27, 'https://www.streamua.ddnsking.com/peliculas/(T)ERROR', NULL, '(T)ERROR', 'This real-life look at FBI counterterrorism operations features access to both sides of a sting: the government informant and the radicalized target.', 'United States', NULL, '', 'Lyric R. Cabral, David Felix Sutcliffe', 0, 'admin1@gmail.com', 'Documentaries'),
	(28, 'https://www.streamua.ddnsking.com/series/(Un)Well', NULL, '(Un)Well', 'This docuseries takes a deep dive into the lucrative wellness industry, which touts health and healing. But do the products live up to the promises?', 'United States', NULL, '', '', 0, 'admin1@gmail.com', 'RealityTV'),
	(29, 'https://www.streamua.ddnsking.com/peliculas/#Alive', NULL, '#Alive', 'As a grisly virus rampages a city, a lone man stays locked inside his apartment, digitally cut off from seeking help and desperate to find a way out.', 'South Korea', NULL, 'Yoo Ah-in, Park Shin-hye', 'Cho Il', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(30, 'https://www.streamua.ddnsking.com/peliculas/#AnneFrank-ParallelStories', NULL, '#AnneFrank - Parallel Stories', 'Through her diary, Anne Franks story is retold alongside those of five Holocaust survivors in this poignant documentary from Oscar winner Helen Mirren.', 'Italy', NULL, 'Helen Mirren, Gengher Gatti', 'Sabina Fedeli, Anna Migotto', 0, 'admin1@gmail.com', 'Documentaries'),
	(31, 'https://www.streamua.ddnsking.com/series/#blackAF', NULL, '#blackAF', 'Kenya Barris and his family navigate relationships, race and culture while grappling with their newfound success in this comedy series.', 'United States', NULL, 'Kenya Barris, Rashida Jones, Iman Benson, Genneya Walton, Scarlet Spencer, Justin Claiborne, Ravi Ca', '', 0, 'admin1@gmail.com', 'TVComedies'),
	(32, 'https://www.streamua.ddnsking.com/peliculas/#cats_the_mewvie', NULL, '#cats_the_mewvie', 'This pawesome documentary explores how our feline friends became online icons, from the earliest text memes to the rise of celebrity cat influencers.', 'Canada', NULL, '', 'Michael Margolis', 0, 'admin1@gmail.com', 'Documentaries'),
	(33, 'https://www.streamua.ddnsking.com/peliculas/#FriendButMarried', NULL, '#FriendButMarried', 'Pining for his high school crush for years, a young man puts up his best efforts to move out of the friend zone until she reveals shes getting married.', 'Indonesia', NULL, 'Adipati Dolken, Vanesha Prescilla, Rendi Jhon, Beby Tsabina, Denira Wiraguna, Refal Hady, Diandra Ag', 'Rako Prijanto', 0, 'admin1@gmail.com', 'Dramas'),
	(34, 'https://www.streamua.ddnsking.com/peliculas/#FriendButMarried2', NULL, '#FriendButMarried 2', 'As Ayu and Ditto finally transition from best friends to newlyweds, a quick pregnancy creates uncertainty for the future of their young marriage.', 'Indonesia', NULL, 'Adipati Dolken, Mawar de Jongh, Sari Nila, Vonny Cornellya, Clay Gribble, Ivan Leonardy, Sarah Secha', 'Rako Prijanto', 0, 'admin1@gmail.com', 'Dramas'),
	(35, 'https://www.streamua.ddnsking.com/peliculas/#realityhigh', NULL, '#realityhigh', 'When nerdy high schooler Dani finally attracts the interest of her longtime crush, she lands in the cross hairs of his ex, a social media celebrity.', 'United States', NULL, 'Nesta Cooper, Kate Walsh, John Michael Higgins, Keith Powers, Alicia Sanz, Jake Borelli, Kid Ink, Yo', 'Fernando Lebrija', 0, 'admin1@gmail.com', 'Comedies'),
	(36, 'https://www.streamua.ddnsking.com/peliculas/#Roxy', NULL, '#Roxy', 'A teenage hacker with a huge nose helps a cool kid woo a girl that he’s secretly in love with.', 'Canada', NULL, 'Jake Short, Sarah Fisher, Booboo Stewart, Danny Trejo, Pippa Mackie, Jake Smith, Patricia Zentilli, ', 'Michael Kennedy', 0, 'admin1@gmail.com', 'Comedies'),
	(37, 'https://www.streamua.ddnsking.com/peliculas/#Rucker50', NULL, '#Rucker50', 'This documentary celebrates the 50th anniversary of the Harlem sports program that has inspired countless city kids to become pro basketball players.', 'United States', NULL, '', 'Robert McCullough Jr.', 0, 'admin1@gmail.com', 'Documentaries'),
	(38, 'https://www.streamua.ddnsking.com/peliculas/#Selfie', NULL, '#Selfie', 'Two days before their final exams, three teen girls make a seaside getaway to end their adolescence with a bang.', 'Romania', NULL, 'Flavia Hojda, Crina Semciuc, Olimpia Melinte, Levent Sali, Vlad Logigan, Alex Calin, Alina Chivulesc', 'Cristina Jacob', 0, 'admin1@gmail.com', 'Comedies'),
	(39, 'https://www.streamua.ddnsking.com/peliculas/#Selfie69', NULL, '#Selfie 69', 'After a painful breakup, a trio of party-loving friends makes a bet: who can get married in three days.', 'Romania', NULL, 'Maia Morgenstern, Olimpia Melinte, Crina Semciuc, Flavia Hojda, Maria Dinulescu, Alex Calin, Vlad Lo', 'Cristina Jacob', 0, 'admin1@gmail.com', 'Comedies'),
	(40, 'https://www.streamua.ddnsking.com/series/แผนร้ายนายเจ้าเล่ห์', NULL, 'แผนร้ายนายเจ้าเล่ห์', 'When two brothers fall for two sisters, they quickly realize the age differences between them are too big to ignore.', '', NULL, 'Chutavuth Pattarakampol, Sheranut Yusananda, Nichaphat Chatchaipholrat, Thassapak Hsu', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(41, 'https://www.streamua.ddnsking.com/peliculas/¡Ay,mimadre!', NULL, '¡Ay, mi madre!', 'When her estranged mother suddenly dies, a woman must follow the quirky instructions laid out in the will in order to collect an important inheritance.', 'Spain', NULL, 'Estefanía de los Santos, Secun de la Rosa, Terele Pávez, María Alfonsa Rosso, Mariola Fuentes, Alfon', 'Frank Ariza', 0, 'admin1@gmail.com', 'Comedies'),
	(42, 'https://www.streamua.ddnsking.com/peliculas/ÇarsiPazar', NULL, 'Çarsi Pazar', 'The slacker owner of a public bath house rallies his community to save it when a big developer comes to town to close it down and open a new mall.', 'Turkey', NULL, 'Erdem Yener, Ayhan Taş, Emin Olcay, Muharrem Gülmez, Elif Nur Kerkük, Tarık Papuççuoğlu, Suzan Aksoy', 'Muharrem Gülmez', 0, 'admin1@gmail.com', 'Comedies'),
	(43, 'https://www.streamua.ddnsking.com/peliculas/Égmanþig', NULL, 'Ég man þig', 'Young urbanites renovating a rundown house, and a psychiatrist grieving his sons disappearance, are connected to a supernatural, decades-old secret.', 'Iceland', NULL, 'Jóhannes Haukur Jóhannesson, Ágústa Eva Erlendsdóttir, Elma Stefania Agustsdottir, Thor Kristjansson', 'Óskar Thór Axelsson', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(44, 'https://www.streamua.ddnsking.com/peliculas/ÇokFilimHareketlerBunlar', NULL, 'Çok Filim Hareketler Bunlar', 'Vignettes of the summer holidays follow vacationers as they battle mosquitoes, suffer ruined plans and otherwise hit snags in their precious time off.', 'Turkey', NULL, 'Ayça Erturan, Aydan Taş, Ayşegül Akdemir, Burcu Gönder, Bülent Emrah Parlak, Büşra Pekin, Emre Canpo', 'Ozan Açıktan', 0, 'admin1@gmail.com', 'Comedies'),
	(45, 'https://www.streamua.ddnsking.com/peliculas/Òlòtūré', NULL, 'Òlòtūré', 'In Lagos, a journalist goes undercover as a prostitute to expose human trafficking. What she finds is a world of exploited women and ruthless violence.', 'Nigeria', NULL, 'Beverly Osu, Sharon Ooja, Omowunmi Dada, Pearl Okorie, Wofai Samuel, Ikechukwu Onunaku, Kemi Lala Ak', 'Kenneth Gyang', 0, 'admin1@gmail.com', 'Dramas'),
	(46, 'https://www.streamua.ddnsking.com/peliculas/ÆonFlux', NULL, 'Æon Flux', 'Aiming to hasten an uprising, the leader of an underground rebellion dispatches acrobatic assassin Aeon Flux to eliminate the governments top leader.', 'United States', NULL, 'Charlize Theron, Marton Csokas, Jonny Lee Miller, Sophie Okonedo, Frances McDormand, Pete Postlethwa', 'Karyn Kusama', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(47, 'https://www.streamua.ddnsking.com/series/Şubat', NULL, 'Şubat', 'An orphan subjected to tests that gave him superpowers is rescued and raised on Istanbuls streets, where he falls for a reporter linked to his past.', 'Turkey', NULL, 'Alican Yücesoy, Melisa Sözen, Musa Uzunlar, Serkan Ercan, Özkan Uğur, Ülkü Duru, Tansu Biçer, Nadir ', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(48, 'https://www.streamua.ddnsking.com/peliculas/1Chance2Dance', NULL, '1 Chance 2 Dance', 'When an aspiring dancer is uprooted during her senior year of high school, she finds herself torn between two boys – and with one shot at her dream.', 'United States', NULL, 'Lexi Giovagnoli, Justin Ray, Rae Latt, Poonam Basu, Teresa Biter, Kalilah Harris, Alexia Dox, Adam P', 'Adam Deyoe', 0, 'admin1@gmail.com', 'Dramas'),
	(49, 'https://www.streamua.ddnsking.com/peliculas/1MiletoYou', NULL, '1 Mile to You', 'After escaping the bus accident that killed his girlfriend, a high school student channels his grief into running, with the help of a new coach.', 'United States', NULL, 'Billy Crudup, Graham Rogers, Liana Liberato, Stefanie Scott, Tim Roth, Melanie Lynskey, Thomas Cocqu', 'Leif Tilden', 0, 'admin1@gmail.com', 'Dramas'),
	(50, 'https://www.streamua.ddnsking.com/peliculas/10DaysinSunCity', NULL, '10 Days in Sun City', 'After his girlfriend wins the Miss Nigeria pageant, a young man faces unexpected competition of his own when he joins her on a campaign in South Africa.', 'South Africa, Nigeri', NULL, 'Ayo Makun, Adesua Etomi, Richard Mofe-Damijo, Mercy Johnson, Falz, Tuface Idibia, Thenjiwe Moseley, ', 'Adze Ugah', 0, 'admin1@gmail.com', 'Comedies'),
	(51, 'https://www.streamua.ddnsking.com/peliculas/10joursenor', NULL, '10 jours en or', 'When a carefree bachelor is unexpectedly left in charge of a young boy, the two embark on a road trip that will change both of their lives.', 'France', NULL, 'Franck Dubosc, Claude Rich, Marie Kremer, Mathis Touré, Rufus, Olivier Claverie', 'Nicolas Brossette', 0, 'admin1@gmail.com', 'Comedies'),
	(52, 'https://www.streamua.ddnsking.com/peliculas/10,000B.C.', NULL, '10,000 B.C.', 'Fierce mammoth hunter DLeh sets out on an impossible journey to rescue the woman he loves from a vicious warlord and save the people of his village.', 'United States, South', NULL, 'Steven Strait, Camilla Belle, Cliff Curtis, Joel Virgel, Affif Ben Badra, Mo Zinal, Nathanael Baring', 'Roland Emmerich', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(53, 'https://www.streamua.ddnsking.com/series/100DaysMyPrince', NULL, '100 Days My Prince', 'Upon losing his memory, a crown prince encounters a commoner’s life and experiences unforgettable love as the husband to Joseon’s oldest bachelorette.', 'South Korea', NULL, 'Doh Kyung-soo, Nam Ji-hyun, Cho Seong-ha, Cho Han-cheul, Kim Seon-ho, Han So-hee', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(54, 'https://www.streamua.ddnsking.com/peliculas/100DaysOfSolitude', NULL, '100 Days Of Solitude', 'Spanish photographer José Díaz spends 100 days living alone on a remote mountain, connecting to nature and documenting the beauty of his surroundings.', 'Spain', NULL, '', '', 0, 'admin1@gmail.com', 'Documentaries'),
	(55, 'https://www.streamua.ddnsking.com/series/100Humans', NULL, '100 Humans', 'One hundred hardy souls from diverse backgrounds participate in playful experiments exploring age, sex, happiness and other aspects of being human.', 'United States', NULL, 'Zainab Johnson, Sammy Obeid, Alie Ward', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(56, 'https://www.streamua.ddnsking.com/peliculas/100Meters', NULL, '100 Meters', 'A man who is diagnosed with multiple sclerosis responds by training for an Ironman triathlon, with his cranky father-in-laws help.', 'Portugal, Spain', NULL, 'Dani Rovira, Karra Elejalde, Alexandra Jiménez, David Verdaguer, Clara Segura, Alba Ribas, Bruno Ber', 'Marcel Barrena', 0, 'admin1@gmail.com', 'Dramas'),
	(57, 'https://www.streamua.ddnsking.com/peliculas/100ThingstodoBeforeHighSchool', NULL, '100 Things to do Before High School', 'Led by seventh-grader C.J., three students who have been warned about the dangers of high school decide to make the best of their middle-school years.', 'United States', NULL, 'Isabela Moner, Jaheem Toombs, Owen Joyner, Jack De Sena, Brady Reiter, Lisa Arch, Stephanie Escajeda', '', 0, 'admin1@gmail.com', 'Movies'),
	(58, 'https://www.streamua.ddnsking.com/peliculas/100Years:OneWomansFightforJustice', NULL, '100 Years: One Womans Fight for Justice', 'This documentary chronicles Elouise Cobells long fight against the U.S. government for the gross mismanagement of mineral-rich Native American land.', 'United States', NULL, '', 'Melinda Janko', 0, 'admin1@gmail.com', 'Documentaries'),
	(59, 'https://www.streamua.ddnsking.com/peliculas/100%Halal', NULL, '100% Halal', 'After high school, a young woman marries the man of her fathers choice but soon faces the possibility that her religion considers the union invalid.', 'Indonesia', NULL, 'Anisa Rahma, Ariyo Wahab, Anandito Dwis, Fitria Rasyidi, Arafah Rianti, Kinaryosih', 'Jastis Arimba', 0, 'admin1@gmail.com', 'Dramas'),
	(60, 'https://www.streamua.ddnsking.com/series/100%Hotter', NULL, '100% Hotter', 'A stylist, a hair designer and a makeup artist team up to give Britains biggest fashion disasters some much-needed makeunders.', 'United Kingdom', NULL, 'Daniel Palmer, Melissa Sophia, Karen Williams, Grace Woodward', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(61, 'https://www.streamua.ddnsking.com/peliculas/1000RupeeNote', NULL, '1000 Rupee Note', 'After randomly receiving a handsome political bribe, a sweet, poor elderly woman decides to treat herself a shopping spree, which doesnt go smoothly.', 'India', NULL, 'Usha Naik, Sandeep Pathak, Shrikant Yadav, Ganesh Yadav, Pooja Nayak, Devendra Gaikwad', 'Shrihari Sathe', 0, 'admin1@gmail.com', 'Dramas'),
	(62, 'https://www.streamua.ddnsking.com/peliculas/12ROUNDGUN', NULL, '12 ROUND GUN', 'Dealing with personal demons and the death of his son, a prizefighter attempts a return to the ring by challenging his rival to a 12-round rematch.', 'United States', NULL, 'Sam Upton, Jared Abrahamson, Mark Boone Junior, Laila Ali, Kate Vernon, Cassi Thomson, Colby French,', 'Sam Upton', 0, 'admin1@gmail.com', 'Dramas'),
	(63, 'https://www.streamua.ddnsking.com/series/12YearsPromise', NULL, '12 Years Promise', 'A pregnant teen is forced by her family to leave her boyfriend and assume a new identity in America, but 12 years later, the couple reunites in Korea.', 'South Korea', NULL, 'So-yeon Lee, Namkoong Min, Tae-im Lee, So-hui Yoon, Won-keun Lee, Hyo-young Ryu', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(64, 'https://www.streamua.ddnsking.com/peliculas/13Cameras', NULL, '13 Cameras', 'Young parents-to-be Claire and Ryan move into a suburban rental home, unaware that someone is secretly watching their every move via hidden cameras.', 'United States', NULL, 'PJ McCabe, Brianne Moncrief, Sarah Baldwin, Jim Cummings, Heidi Niedermeyer, Neville Archambault', 'Victor Zarcoff', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(65, 'https://www.streamua.ddnsking.com/series/13ReasonsWhy', NULL, '13 Reasons Why', 'After a teenage girls perplexing suicide, a classmate receives a series of tapes that unravel the mystery of her tragic choice.', 'United States', NULL, 'Dylan Minnette, Katherine Langford, Kate Walsh, Derek Luke, Brian dArcy James, Alisha Boe, Christian', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(66, 'https://www.streamua.ddnsking.com/series/13ReasonsWhy:BeyondtheReasons', NULL, '13 Reasons Why: Beyond the Reasons', 'Cast members, writers, producers and mental health professionals discuss some of the difficult issues and themes explored in "13 Reasons Why."', 'United States', NULL, 'Dylan Minnette, Katherine Langford, Kate Walsh, Derek Luke, Alisha Boe, Justin Prentice, Brandon Fly', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(67, 'https://www.streamua.ddnsking.com/peliculas/13Sins', NULL, '13 Sins', 'A man agrees to appear on a game show with a $6 million prize. But as the challenges become more extreme, he realizes hes made a grave mistake.', 'United States', NULL, 'Mark Webber, Rutina Wesley, Devon Graye, Tom Bower, Ron Perlman, Pruitt Taylor Vince', 'Daniel Stamm', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(68, 'https://www.streamua.ddnsking.com/peliculas/13TH', NULL, '13TH', 'In this thought-provoking documentary, scholars, activists and politicians analyze the criminalization of African Americans and the U.S. prison boom.', 'United States', NULL, '', 'Ava DuVernay', 0, 'admin1@gmail.com', 'Documentaries'),
	(69, 'https://www.streamua.ddnsking.com/peliculas/13TH:AConversationwithOprahWinfrey&AvaDuVernay', NULL, '13TH: A Conversation with Oprah Winfrey & Ava DuVe', 'Oprah Winfrey sits down with director Ava DuVernay to discuss her Oscar-nominated film, historical cycles of oppression and the broken prison system.', '', NULL, 'Oprah Winfrey, Ava DuVernay', '', 0, 'admin1@gmail.com', 'Movies'),
	(70, 'https://www.streamua.ddnsking.com/peliculas/14Blades', NULL, '14 Blades', 'In the age of the Ming Dynasty, Quinglong is the best of the Jinyiwei, an elite assassin squad made up of highly trained former street urchins. When evil eunuch Jia unseats the emperor, Quinglong is called to action but is quickly betrayed.', 'Hong Kong, China, Si', NULL, 'Donnie Yen, Zhao Wei, Wu Chun, Law Kar-Ying, Kate Tsui, Yuwu Qi, Wu Ma, Chen Kuan Tai, Sammo Kam-Bo ', 'Daniel Lee', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(71, 'https://www.streamua.ddnsking.com/peliculas/14Cameras', NULL, '14 Cameras', 'Upping the “13 Cameras” ante, this sequel finds a family renting a vacation house that’s been customized to violate their privacy.', 'United States', NULL, 'Neville Archambault, Amber Midthunder, Brytnee Ratledge, Hank Rogerson, Chelsea Edmundson, John-Paul', 'Scott Hussion, Seth Fuller', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(72, 'https://www.streamua.ddnsking.com/peliculas/14MinutesfromEarth', NULL, '14 Minutes from Earth', 'A Google executive boldly attempts a death-defying mission to travel to space and free-fall back to Earth without a rocket.', 'United States', NULL, '', 'Adam Davis, Jerry Kolber, Trey Nelson, Erich Sturm', 0, 'admin1@gmail.com', 'Documentaries'),
	(73, 'https://www.streamua.ddnsking.com/peliculas/16Blocks', NULL, '16 Blocks', 'Tasked with escorting a prosecution witness to court, an aging cop gears up for the 16-block trek – but theyll be lucky to make it there alive.', 'United States, Germa', NULL, 'Bruce Willis, Mos Def, David Morse, Jenna Stern, Cylk Cozart, Casey Sander, David Zayas, Robert Rack', 'Richard Donner', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(74, 'https://www.streamua.ddnsking.com/peliculas/17Again', NULL, '17 Again', 'Nearing a midlife crisis, thirty-something Mike wishes for a "do-over" – and thats exactly what he gets when he wakes up to find hes 17 again.', 'United States', NULL, 'Zac Efron, Leslie Mann, Matthew Perry, Thomas Lennon, Michelle Trachtenberg, Melora Hardin, Sterling', 'Burr Steers', 0, 'admin1@gmail.com', 'Comedies'),
	(75, 'https://www.streamua.ddnsking.com/peliculas/18Presents', NULL, '18 Presents', 'A pregnant mother with terminal cancer leaves behind 18 sentimental gifts for her unborn daughter to receive every birthday until she reaches womanhood.', 'Italy', NULL, 'Vittoria Puccini, Benedetta Porcaroli, Edoardo Leo, Sara Lazzaro, Marco Messeri, Betty Pedrazzi, Ale', 'Francesco Amato', 0, 'admin1@gmail.com', 'Dramas'),
	(76, 'https://www.streamua.ddnsking.com/peliculas/1898:OurLastMeninthePhilippines', NULL, '1898: Our Last Men in the Philippines', 'While Spain relinquishes its last colonies, a battle-fatigued outpost engages in a long, brutal and sometimes bizarre clash with Filipino insurgents.', 'Spain', NULL, 'Luis Tosar, Javier Gutiérrez, Álvaro Cervantes, Karra Elejalde, Carlos Hipólito, Ricardo Gómez, Patr', 'Salvador Calvo', 0, 'admin1@gmail.com', 'Dramas'),
	(77, 'https://www.streamua.ddnsking.com/peliculas/1BR', NULL, '1BR', 'Seeking her independence, a young woman moves to Los Angeles and settles into a cozy apartment complex with a disturbing sense of community.', 'United States', NULL, 'Nicole Brydon Bloom, Giles Matthey, Taylor Nichols, Alan Blumenfeld, Celeste Sully, Susan Davis, Cla', 'David Marmor', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(78, 'https://www.streamua.ddnsking.com/peliculas/1stSummoning', NULL, '1st Summoning', 'Student filmmakers uncover occult rituals tied to an abandoned warehouse, then gradually realize the horror is closer than they think.', 'United States', NULL, 'Hayley Lovitt, Teddy Cole, Brook Todd, Ace Harney, Jason Macdonald', 'Raymond Wood', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(79, 'https://www.streamua.ddnsking.com/peliculas/2AloneinParis', NULL, '2 Alone in Paris', 'A bumbling Paris policeman is doggedly determined to capture the master thief that repeatedly eludes him, even when theyre the last two men on Earth.', 'France', NULL, 'Ramzy Bedia, Éric Judor, Benoît Magimel, Kristin Scott Thomas, Élodie Bouchez, Édouard Baer, Fred Te', 'Ramzy Bedia, Éric Judor', 0, 'admin1@gmail.com', 'Comedies'),
	(80, 'https://www.streamua.ddnsking.com/peliculas/2States', NULL, '2 States', 'Graduate students Krish and Ananya hope to win their parents approval before they marry, but the two families clash over their cultural differences.', 'India', NULL, 'Alia Bhatt, Arjun Kapoor, Ronit Roy, Amrita Singh, Revathy, Aru Krishansh Verma', 'Abhishek Varman', 0, 'admin1@gmail.com', 'Comedies'),
	(81, 'https://www.streamua.ddnsking.com/peliculas/20FeetFromStardom', NULL, '20 Feet From Stardom', 'Winner of the 2014 Academy Award for Best Documentary Feature, this film takes a look at the world of backup vocalists and the legends they support.', 'United States', NULL, 'Darlene Love, Merry Clayton, Lisa Fischer, Táta Vega, Claudia Lennear, Judith Hill, Bruce Springstee', 'Morgan Neville', 0, 'admin1@gmail.com', 'Documentaries'),
	(82, 'https://www.streamua.ddnsking.com/series/20Minutes', NULL, '20 Minutes', 'When his wife is convicted of murder, a horrified family man races to prove her innocence while a dogged investigator sets out to uncover the truth.', 'Turkey', NULL, 'Tuba Büyüküstün, Ilker Aksum, Bülent Emin Yarar, İpek Bilgin, Müjde Uzman, Firat Çelik, Ayten Uncuog', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(83, 'https://www.streamua.ddnsking.com/peliculas/2015DreamConcert', NULL, '2015 Dream Concert', 'The worlds biggest K-pop festival marked its 21st year in 2015, with groups such as EXO, 4Minute and SHINee electrifying the Seoul World Cup Stadium.', 'South Korea', NULL, '4Minute, B1A4, BtoB, ELSIE, EXID, EXO, Got7, INFINITE, KARA, Shinee, Sistar, VIXX, Nine Muses, BTS, ', '', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(84, 'https://www.streamua.ddnsking.com/peliculas/2036OriginUnknown', NULL, '2036 Origin Unknown', 'Working with an artificial intelligence to investigate the failure of a deadly Mars landing, a mission controller makes an astonishing discovery.', 'United Kingdom', NULL, 'Katee Sackhoff, Ray Fearon, Julie Cox, Steven Cree, David Tse, Joe David Walters', 'Hasraf Dulull', 0, 'admin1@gmail.com', 'Sci-Fi&Fantasy'),
	(85, 'https://www.streamua.ddnsking.com/peliculas/20thCenturyWomen', NULL, '20th Century Women', 'In 1979, single bohemian mom Dorothea, hoping to help her teen son find his place as a man, asks two young women to share their lives with him.', 'United States', NULL, 'Annette Bening, Elle Fanning, Greta Gerwig, Lucas Jade Zumann, Billy Crudup', 'Mike Mills', 0, 'admin1@gmail.com', 'Dramas'),
	(86, 'https://www.streamua.ddnsking.com/peliculas/21&Over', NULL, '21 & Over', 'Jeffs straight-and-narrow life changes abruptly when his buddies take him out for a birthday bash – the night before a crucial med school interview.', 'United States', NULL, 'Miles Teller, Skylar Astin, Justin Chon, Sarah Wright, Jonathan Keltz, François Chau, Russell Hodgki', 'Jon Lucas, Scott Moore', 0, 'admin1@gmail.com', 'Comedies'),
	(87, 'https://www.streamua.ddnsking.com/series/21Again', NULL, '21 Again', 'In a social experiment, a group of daughters sends their mothers, disguised as 21-year-olds, into the world to experience life as a member of Gen Z.', 'United Kingdom', NULL, 'Laura Morgan', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(88, 'https://www.streamua.ddnsking.com/series/21Sarfarosh:Saragarhi1897', NULL, '21 Sarfarosh: Saragarhi 1897', 'In one of historys greatest last stands, a battalion of 21 Sikh soldiers fights to defend their outpost from attack by over 10,000 Afghans.', 'India', NULL, 'Luke Kenny, Mohit Raina, Mukul Dev', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(89, 'https://www.streamua.ddnsking.com/series/21Thunder', NULL, '21 Thunder', 'Players and coaches for a Montreal soccer team chase dreams of stardom while their personal lives erupt with love, fear, passion and violence.', 'Canada', NULL, 'Stephanie Bennett, Emmanuel Kabongo, RJ Fetherstonhaugh, Andres Joseph, Kevin Claydon, Conrad Pla, C', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(90, 'https://www.streamua.ddnsking.com/peliculas/2307:WintersDream', NULL, '2307: Winters Dream', 'In the frozen tundra of a futuristic Arizona where humans have been forced underground, a soldier hunts the bioengineered leader of a rebellion.', 'United States', NULL, 'Paul Sidhu, Arielle Holmes, Branden Coles, Kelcey Watson, Anne-Solenne Hatte, Brad Potts, Timothy Le', 'Joey Curtis', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(91, 'https://www.streamua.ddnsking.com/peliculas/24HourstoLive', NULL, '24 Hours to Live', 'Revived by an experimental procedure, a hit man gets to live an extra 24 hours – which he uses to avenge his dead wife and child and redeem himself.', 'South Africa, China,', NULL, 'Ethan Hawke, Xu Qing, Paul Anderson, Rutger Hauer, Tyrone Keogh, Nathalie Boltt, Liam Cunningham', 'Brian Smrz', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(92, 'https://www.streamua.ddnsking.com/peliculas/25Kille', NULL, '25 Kille', 'Four brothers learn that they have inherited ancestral land, but must fight to claim it when a greedy feudal lord threatens to take it over.', 'India', NULL, 'Guggu Gill, Yograj Singh, Sonia Mann, Jimmy Sharma, Sapna Bassi, Lakha Lakhwinder Singh, Sandeep Kau', 'Simranjit Singh Hundal', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(93, 'https://www.streamua.ddnsking.com/peliculas/26Years', NULL, '26 Years', 'Twenty-six years after the 1980 massacre at Gwangju, South Korea, three relatives of the victims come together to avenge the infamous orchestrator.', 'South Korea', NULL, 'Goo Jin, Hye-jin Han, Soo-bin Bae, Seul-ong Im, Kyeong-yeong Lee, Gwang Jang, Deok-jae Jo, Eui-sung ', 'Geun-hyun Cho', 0, 'admin1@gmail.com', 'Dramas'),
	(94, 'https://www.streamua.ddnsking.com/peliculas/27,elclubdelosmalditos', NULL, '27, el club de los malditos', 'After a musician dies under suspicious circumstances, a hard-drinking detective and a music fan investigate why rock stars often die at the age of 27.', 'Argentina', NULL, 'Diego Capusotto, Sofía Gala, Daniel Aráoz, Willy Toledo, El Polaco, Paula Manzone, Yayo Guridi, Guil', 'Nicanor Loreti', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(95, 'https://www.streamua.ddnsking.com/peliculas/27:GoneTooSoon', NULL, '27: Gone Too Soon', 'Explore the circumstances surrounding the tragic deaths at 27 of Jimi Hendrix, Jim Morrison, Brian Jones, Janis Joplin, Kurt Cobain and Amy Winehouse.', 'United Kingdom', NULL, 'Janis Joplin, Jimi Hendrix, Amy Winehouse, Jim Morrison, Kurt Cobain', 'Simon Napier-Bell', 0, 'admin1@gmail.com', 'Documentaries'),
	(96, 'https://www.streamua.ddnsking.com/peliculas/28Days', NULL, '28 Days', 'After her drunken antics result in property damage, an alcoholic journalist enters rehab – and soon meets a fellow resident who changes her outlook.', 'United States', NULL, 'Sandra Bullock, Viggo Mortensen, Dominic West, Diane Ladd, Elizabeth Perkins, Steve Buscemi, Alan Tu', 'Betty Thomas', 0, 'admin1@gmail.com', 'Comedies'),
	(97, 'https://www.streamua.ddnsking.com/series/28Moons', NULL, '28 Moons', 'When her fiancé acts strangely upon receiving a mysterious invitation, a florist sets out to find out the truth behind the tiny scrap of paper.', 'South Korea', NULL, 'Jin-sung Yang, Kyu-jong Kim, Tae-hwan Kang, Geummi', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(98, 'https://www.streamua.ddnsking.com/peliculas/3DaystoKill', NULL, '3 Days to Kill', 'A terminally ill secret agent accepts a risky mission in exchange for an experimental drug that might save him – if he can survive its side effects.', 'United States, Franc', NULL, 'Kevin Costner, Amber Heard, Hailee Steinfeld, Connie Nielsen, Tómas Lemarquis, Richard Sammel, Marc ', 'McG', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(99, 'https://www.streamua.ddnsking.com/peliculas/3Deewarein', NULL, '3 Deewarein', 'A reporter interviews three convicts on death row for a documentary but as their stories emerge, so do her own true motivations for soliciting them.', '', NULL, 'Naseeruddin Shah, Jackie Shroff, Juhi Chawla, Nagesh Kukunoor, Gulshan Grover, Aditya Lakhia, Shri V', 'Nagesh Kukunoor', 0, 'admin1@gmail.com', 'Dramas'),
	(100, 'https://www.streamua.ddnsking.com/peliculas/3Generations', NULL, '3 Generations', 'When teenage Ray begins transitioning from female to male, his single mom and grandmother must cope with the change while tracking down his father.', 'United States', NULL, 'Elle Fanning, Naomi Watts, Susan Sarandon, Tate Donovan, Linda Emond, Jordan Carlos, Sam Trammell, M', 'Gaby Dellal', 0, 'admin1@gmail.com', 'Dramas'),
	(101, 'https://www.streamua.ddnsking.com/peliculas/3Heroines', NULL, '3 Heroines', 'Three Indonesian women break records by becoming the first of their nation to medal in archery at the Seoul Olympics in the summer of 1988.', 'Indonesia', NULL, 'Reza Rahadian, Bunga Citra Lestari, Tara Basro, Chelsea Islan', 'Iman Brotoseno', 0, 'admin1@gmail.com', 'Dramas'),
	(102, 'https://www.streamua.ddnsking.com/peliculas/3Idiots', NULL, '3 Idiots', 'While attending one of Indias premier colleges, three miserable engineering students and best friends struggle to beat the schools draconian system.', 'India', NULL, 'Aamir Khan, Kareena Kapoor, Madhavan, Sharman Joshi, Omi Vaidya, Boman Irani, Mona Singh, Javed Jaff', 'Rajkumar Hirani', 0, 'admin1@gmail.com', 'Comedies'),
	(103, 'https://www.streamua.ddnsking.com/peliculas/3SecondsDivorce', NULL, '3 Seconds Divorce', 'A Muslim womens activist group in India protests against oral divorces, starting a movement to reclaim their religious and constitutional rights.', 'Canada', NULL, '', 'Shazia Javed', 0, 'admin1@gmail.com', 'Documentaries'),
	(104, 'https://www.streamua.ddnsking.com/peliculas/3Türken&einBaby', NULL, '3 Türken & ein Baby', 'The lives of three dissatisfied brothers running a family bridal shop turn topsy-turvy when one of them has to care for his ex-girlfriends baby.', 'Germany', NULL, 'Kostja Ullmann, Eko Fresh, Kida Khodr Ramadan, Sabrina Klüber, Sami Nasser, Kayla Rybicka, Jytte-Mer', 'Sinan Akkuş', 0, 'admin1@gmail.com', 'Comedies'),
	(105, 'https://www.streamua.ddnsking.com/peliculas/30DaysofLuxury', NULL, '30 Days of Luxury', 'With the help of his friends, a man breaks out of prison in hopes of restoring a lively nightclub.', 'Egypt', NULL, 'Taher Farouz, Sad Al-Saghir, Ahmad Faloks, Soleiman Eid, Mahmood El-Laithi, Hesham Ismail, Shaima Sa', 'Hani Hamdi', 0, 'admin1@gmail.com', 'Comedies'),
	(106, 'https://www.streamua.ddnsking.com/peliculas/30MinutesorLess', NULL, '30 Minutes or Less', 'Two crooks planning a bank heist wind up abducting a pizza delivery driver and force him to commit the robbery — with a strict time limit.', 'United States', NULL, 'Jesse Eisenberg, Danny McBride, Aziz Ansari, Nick Swardson, Dilshad Vadsaria, Michael Peña, Bianca K', 'Ruben Fleischer', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(107, 'https://www.streamua.ddnsking.com/peliculas/300MilestoHeaven', NULL, '300 Miles to Heaven', 'Hoping to help their dissident parents, two brothers sneak out of Poland and land as refugees in Denmark, where they are prevented from returning home.', 'Denmark, France, Pol', NULL, 'Krzysztof Stroiński, Andrzej Mellin, Adrianna Biedrzyńska, Adrianna Biedrzyńska, Rafał Zimowski, Kam', 'Maciej Dejczer', 0, 'admin1@gmail.com', 'Dramas'),
	(108, 'https://www.streamua.ddnsking.com/peliculas/365Days', NULL, '365 Days', 'A fiery executive in a spiritless relationship falls victim to a dominant mafia boss, who imprisons her and gives her one year to fall in love with him.', 'Poland', NULL, 'Anna-Maria Sieklucka, Michele Morrone, Bronisław Wrocławski, Otar Saralidze, Magdalena Lamparska, Na', 'Barbara Białowąs, Tomasz Mandes', 0, 'admin1@gmail.com', 'Dramas'),
	(109, 'https://www.streamua.ddnsking.com/peliculas/37Seconds', NULL, '37 Seconds', 'Trapped by society and familial obligations, a young manga artist goes on an unconventional journey for sexual freedom and personal liberation.', 'Japan', NULL, 'Mei Kayama, Misuzu Kanno, Shunsuke Daitoh, Makiko Watanabe, Yoshihiko Kumashino, Minori Hagiwara, Sh', 'Hikari', 0, 'admin1@gmail.com', 'Dramas'),
	(111, 'https://www.streamua.ddnsking.com/peliculas/40Sticks', NULL, '40 Sticks', 'When their prison bus crashes in a forest on a rainy night, a group of criminals finds themselves battling wild animals and a mysterious killer.', 'Kenya', NULL, 'Robert Agengo, Mwaura Bilal, Andreo Kamau, Cajetan Boy, Arabron Nyyeneque, Shiviske Shivisi, Xavier ', 'Victor Gatonye', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(112, 'https://www.streamua.ddnsking.com/peliculas/42Grams', NULL, '42 Grams', 'After launching a successful underground restaurant out of their apartment, an ambitious chef and his wife open an all-consuming upscale eatery.', 'United States', NULL, 'Jake Bickelhaupt', 'Jack C. Newell', 0, 'admin1@gmail.com', 'Documentaries'),
	(114, 'https://www.streamua.ddnsking.com/series/45rpm', NULL, '45 rpm', 'In 1960s Madrid, music producer Guillermo Rojas launches a rock n roll label with the help of aspiring singer Robert and clever producer Maribel.', 'Spain', NULL, 'Carlos Cuevas, Guiomar Puerta, Iván Marcos, Israel Elejalde, Eudald Font, Luis Larrodera, Carmen Gut', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(115, 'https://www.streamua.ddnsking.com/peliculas/48ChristmasWishes', NULL, '48 Christmas Wishes', 'When a small towns letters to Santa accidentally go up in smoke, two elves venture out of the North Pole to retrieve every missing wish.', 'Canada', NULL, 'Khiyla Aynne, Noah Dyer, Maya Franzoi, Clara Kushnir, Madeline Leon, Liam MacDonald, Matt Schichter,', 'Marco Deufemia, Justin G. Dyck', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(116, 'https://www.streamua.ddnsking.com/peliculas/4L', NULL, '4L', 'Hoping to reunite with a dying friend, two longtime pals re-create their desert road trip from Spain to Mali, bringing along his estranged daughter.', 'Spain', NULL, 'Jean Reno, Hovik Keuchkerian, Susana Abaitua, Juan Dos Santos, Arturo Valls, Enrique San Francisco, ', 'Gerardo Olivares', 0, 'admin1@gmail.com', 'Comedies'),
	(117, 'https://www.streamua.ddnsking.com/peliculas/4thManOut', NULL, '4th Man Out', 'A young mechanic comes out to his extremely straight best friends. Once they get used to the idea, theyre determined to help him find the right guy.', 'United States', NULL, 'Evan Todd, Parker Young, Chord Overstreet, Jon Gabrus, Kate Flannery, Brooke Dillman, Jennifer Damia', 'Andrew Nackman', 0, 'admin1@gmail.com', 'Comedies'),
	(118, 'https://www.streamua.ddnsking.com/peliculas/4thRepublic', NULL, '4th Republic', 'After the election-night murder of her campaign manager at a polling site, a gubernatorial candidate challenges the corrupt incumbents victory.', 'Nigeria', NULL, 'Kate Henshaw-Nuttal, Enyinna Nwigwe, Linda Ejiofor, Yakubu Mohammed, Bimbo Manuel, Sani Mu’azu, Emil', 'Ishaya Bako', 0, 'admin1@gmail.com', 'Dramas'),
	(119, 'https://www.streamua.ddnsking.com/peliculas/5CowokJagoan', NULL, '5 Cowok Jagoan', 'Yanto asks his friends to help save a girlfriend who was kidnapped by a mobster. Silly slapstick and campy crimefighting ensues.', '', NULL, 'Ario Bayu, Arifin Putra, Dwi Sasono, Muhadkly Acho, Cornelio Sunny, Tika Bravani, Nirina Zubir, Gani', 'Anggy Umbara', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(120, 'https://www.streamua.ddnsking.com/peliculas/5FlightsUp', NULL, '5 Flights Up', 'A couple finds unexpected drama when, after 40 years of living in the same Brooklyn walk-up, they attempt to sell their apartment and buy a new one.', 'United States', NULL, 'Josh Pais, Claire van der Boom, Morgan Freeman, Diane Keaton, Carrie Preston, Cynthia Nixon, Korey J', 'Richard Loncraine', 0, 'admin1@gmail.com', 'Comedies'),
	(121, 'https://www.streamua.ddnsking.com/peliculas/5StarChristmas', NULL, '5 Star Christmas', 'When the Italian prime minister meets his lover and political rival while on an official trip to Budapest during Christmas week, things go topsy-turvy.', 'Italy', NULL, 'Massimo Ghini, Ricky Memphis, Martina Stella, Ralph Palka, Biagio Izzo, Riccardo Rossi, Paola Minacc', 'Marco Risi', 0, 'admin1@gmail.com', 'Comedies'),
	(122, 'https://www.streamua.ddnsking.com/peliculas/5to7', NULL, '5 to 7', 'A young novelists life is turned upside down when a chance encounter outside a New York hotel leads to an intense affair with a diplomats wife.', 'United States', NULL, 'Anton Yelchin, Bérénice Marlohe, Olivia Thirlby, Lambert Wilson, Frank Langella, Glenn Close', 'Victor Levin', 0, 'admin1@gmail.com', 'Comedies'),
	(123, 'https://www.streamua.ddnsking.com/peliculas/50FirstDates', NULL, '50 First Dates', 'After falling for a pretty art teacher who has no short-term memory, a marine veterinarian has to win her over again every single day.', 'United States', NULL, 'Adam Sandler, Drew Barrymore, Rob Schneider, Sean Astin, Lusia Strus, Dan Aykroyd, Amy Hill, Allen C', 'Peter Segal', 0, 'admin1@gmail.com', 'Comedies'),
	(124, 'https://www.streamua.ddnsking.com/peliculas/50/50', NULL, '50/50', 'An otherwise healthy twentysomething has a comically early midlife crisis when he gets slapped with a cancer diagnosis and a 50-50 chance of survival.', 'United States', NULL, 'Joseph Gordon-Levitt, Seth Rogen, Anna Kendrick, Bryce Dallas Howard, Anjelica Huston, Serge Houde, ', 'Jonathan Levine', 0, 'admin1@gmail.com', 'Comedies'),
	(125, 'https://www.streamua.ddnsking.com/peliculas/5CM', NULL, '5CM', 'Five friends embark on a mission to climb the highest peak in Java, overcoming obstacles on the way and discovering the true meaning of friendship.', 'Indonesia', NULL, 'Herjunot Ali, Raline Shah, Fedi Nuril, Pevita Pearce, Saykoji, Denny Sumargo, Didi Petet, Firrina Si', 'Rizal Mantovani', 0, 'admin1@gmail.com', 'Dramas'),
	(126, 'https://www.streamua.ddnsking.com/peliculas/5Gang', NULL, '5Gang', 'To keep the band together, Selly tries to earn money by making an appearance at the birthday party of a mobsters daughter — until he gets kidnapped.', 'Romania', NULL, 'Andrei Selaru, Dorian Popa, Julia Marcan, Ana Radu, Cosmin Nedelcu, Diana Condurache, Andrei Gavril,', 'Matei Dima', 0, 'admin1@gmail.com', 'Comedies'),
	(127, 'https://www.streamua.ddnsking.com/peliculas/6Balloons', NULL, '6 Balloons', 'A loyal sister struggles to stay afloat while driving her heroin-addicted brother to a detox center and looking after his 2-year-old daughter.', 'United States', NULL, 'Abbi Jacobson, Dave Franco, Jane Kaczmarek, Tim Matheson, Charlotte Carel, Madeline Carel, Maya Ersk', 'Marja Lewis Ryan', 0, 'admin1@gmail.com', 'Dramas'),
	(128, 'https://www.streamua.ddnsking.com/peliculas/6Days', NULL, '6 Days', 'When armed gunmen seize the Iranian Embassy in 1980, a tense six-day standoff ensues while elite British soldiers prepare for a dangerous raid.', 'New Zealand, United ', NULL, 'Jamie Bell, Abbie Cornish, Mark Strong, Martin Shaw, Ben Turner, Aymen Hamdouchi, Tim Pigott-Smith, ', 'Toa Fraser', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(129, 'https://www.streamua.ddnsking.com/peliculas/6Underground', NULL, '6 Underground', 'After faking his death, a tech billionaire recruits a team of international operatives for a bold and bloody mission to take down a brutal dictator.', 'United States', NULL, 'Ryan Reynolds, Mélanie Laurent, Corey Hawkins, Dave Franco, Adria Arjona, Manuel Garcia-Rulfo, Ben H', 'Michael Bay', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(130, 'https://www.streamua.ddnsking.com/peliculas/6Years', NULL, '6 Years', 'As a volatile young couple who have been together for six years approach college graduation, unexpected career opportunities threaten their future.', 'United States', NULL, 'Taissa Farmiga, Ben Rosenfield, Lindsay Burdge, Joshua Leonard, Jennifer Lafleur, Peter Vack, Dana W', 'Hannah Fidell', 0, 'admin1@gmail.com', 'Dramas'),
	(131, 'https://www.streamua.ddnsking.com/peliculas/6-5=2', NULL, '6-5=2', 'Six friends decide to undertake a grueling mountain trek, only to find that the difficulties in store for them are not merely physical.', 'India', NULL, 'Prashantt Guptha, Gaurav Paswala, Gaurav Kothari, Disha Kapoor, Niharica Raizada, Ashrut Jain, Darsh', 'Bharat Jain', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(132, 'https://www.streamua.ddnsking.com/series/60DaysIn', NULL, '60 Days In', 'Recruited by a sheriff, volunteers infiltrate county prisons to expose corruption and crime from within the system in this docuseries.', 'United States', NULL, '', '', 0, 'admin1@gmail.com', 'RealityTV'),
	(133, 'https://www.streamua.ddnsking.com/peliculas/68Kill', NULL, '68 Kill', 'A hapless guy agrees to help his stunning – but psychotic – girlfriend rob her loathsome sugar daddy in a scheme as ill-conceived as it is violent.', 'United States', NULL, 'Matthew Gray Gubler, AnnaLynne McCord, Alisha Boe, Sheila Vand, Sam Eidson, James Moses Black, Ajay ', 'Trent Haaga', 0, 'admin1@gmail.com', 'Comedies'),
	(134, 'https://www.streamua.ddnsking.com/series/7(Seven)', NULL, '7 (Seven)', 'Multiple women report their husbands as missing but when it appears they are looking for the same man, a police officer traces their cryptic connection.', 'India', NULL, 'Rahman, Havish, Regina Cassandra, Nandita Swetha, Anisha Ambrose, Tridha Choudhury, Pujitha Ponnada,', 'Nizar Shafi', 0, 'admin1@gmail.com', 'TVShows'),
	(135, 'https://www.streamua.ddnsking.com/peliculas/7años', NULL, '7 años', 'Loyalties are tested and cruelties revealed when four business partners spend a tense evening debating who will pay for the crime they committed.', 'Spain', NULL, 'Paco León, Juana Acosta, Juan Pablo Raba, Alex Brendemühl, Manuel Morón', 'Roger Gual', 0, 'admin1@gmail.com', 'Dramas'),
	(136, 'https://www.streamua.ddnsking.com/series/7DaysOut', NULL, '7 Days Out', 'Witness the excitement and drama behind the scenes in the seven days leading up to major live events in the worlds of sports, fashion, space and food.', 'United States', NULL, '', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(137, 'https://www.streamua.ddnsking.com/peliculas/7DinMohabbatIn', NULL, '7 Din Mohabbat In', 'Given just seven days by a genie to find a girl who will fall for him, a nerdy young man embarks on a madcap and messy search for his would-be wife.', 'Pakistan', NULL, 'Mahira Khan, Sheheryar Munawar, Javed Sheikh, Hina Dilpazeer, Amna Ilyas, Mira Sethi, Rimal Ali, Sal', 'Meenu Gaur, Farjad Nabi', 0, 'admin1@gmail.com', 'Comedies'),
	(138, 'https://www.streamua.ddnsking.com/peliculas/7KhoonMaaf', NULL, '7 Khoon Maaf', 'Spiced liberally with black comedy, this Bollywood drama follows the lethal love life of a woman who marries numerous men – only to find them flawed.', 'India', NULL, 'Priyanka Chopra, Neil Nitin Mukesh, John Abraham, Irrfan Khan, Aleksandr Dyachenko, Annu Kapoor, Nas', 'Vishal Bhardwaj', 0, 'admin1@gmail.com', 'Dramas'),
	(139, 'https://www.streamua.ddnsking.com/series/72CutestAnimals', NULL, '72 Cutest Animals', 'This series examines the nature of cuteness and how adorability helps some animal species to survive and thrive in a variety of environments.', 'Australia', NULL, '', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(140, 'https://www.streamua.ddnsking.com/series/72DangerousAnimals:Asia', NULL, '72 Dangerous Animals: Asia', 'From fangs to claws to venomous stings, they all wield deadly weapons. But which creature will be crowned the fiercest of all?', 'Australia', NULL, 'Bob Brisbane', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(141, 'https://www.streamua.ddnsking.com/series/72DangerousAnimals:LatinAmerica', NULL, '72 Dangerous Animals: Latin America', 'Powerful cats, indestructible arachnids and flesh-melting pit vipers are just the beginning in this series about Latin Americas deadliest creatures.', 'Australia, United St', NULL, 'Bob Brisbane', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(142, 'https://www.streamua.ddnsking.com/series/72DangerousPlacestoLive', NULL, '72 Dangerous Places to Live', 'Get up close and personal with avalanches, fiery volcanoes and other natural cataclysms, and learn why some choose to live in their destructive paths.', 'Australia', NULL, 'Mitch Ryan', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(143, 'https://www.streamua.ddnsking.com/series/7SEEDS', NULL, '7SEEDS', 'Shy Natsu awakens as part of a group chosen to ensure the survival of humanity. Together, they have to survive on a changed Earth.', '', NULL, 'Nao Toyama, Jun Fukuyama, Katsuyuki Konishi, Yoko Soumi, Kana Asumi, Akira Ishida, Aoi Yuki, Kazuhik', '', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(144, 'https://www.streamua.ddnsking.com/series/9MonthsThatMadeYou', NULL, '9 Months That Made You', 'Witness the wonders of human gestation through cutting-edge CGI, and learn how those nine months inside the womb can affect all aspects of ones life.', 'United States', NULL, 'Demetri Goritsas', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(145, 'https://www.streamua.ddnsking.com/peliculas/90ML', NULL, '90 ML', 'Four friends shake up their lives when they meet a new woman in their apartment complex who encourages them to embrace their wild sides.', 'India', NULL, 'Oviya, Masoom Shankar, Bommu Lakshmi, Monisha Ram, Tej Raj, Shree Gopika, Anson Paul, Devadarshini C', 'Anita Udeep', 0, 'admin1@gmail.com', 'Comedies'),
	(146, 'https://www.streamua.ddnsking.com/peliculas/93Days', NULL, '93 Days', 'Heroic health workers fight to contain an Ebola outbreak when a patient arrives in Lagos with symptoms of the deadly virus. Based on a true story.', 'Nigeria', NULL, 'Bimbo Akintola, Somkele Iyamah, Danny Glover, Gideon Okeke, Seun Kentebe, Keppy Ekpenyong, Zara Udof', 'Steve Gukas', 0, 'admin1@gmail.com', 'Dramas'),
	(147, 'https://www.streamua.ddnsking.com/peliculas/A2ndChance', NULL, 'A 2nd Chance', 'A gymnast lacks the confidence she needs to reach the top. But with the help of her new coach, she has the chance to win a spot on the national team.', 'Australia', NULL, 'Nina Pearce, Adam Tuominen, Emily Morris, Amy Handley, Carmel Johnson, Alanah Gilbert, Hapi Murphy, ', 'Clay Glen', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(148, 'https://www.streamua.ddnsking.com/peliculas/A3MinuteHug', NULL, 'A 3 Minute Hug', 'This documentary captures the joy and heartbreak of families separated by the U.S.-Mexico border sharing a short but bittersweet reunion in 2018.', 'Mexico, United State', NULL, '', 'Everardo González', 0, 'admin1@gmail.com', 'Documentaries'),
	(149, 'https://www.streamua.ddnsking.com/peliculas/ABabysittersGuidetoMonsterHunting', NULL, 'A Babysitters Guide to Monster Hunting', 'Recruited by a secret society of babysitters, a high schooler battles the Boogeyman and his monsters when they nab the boy shes watching on Halloween.', 'United States', NULL, 'Tamara Smart, Oona Laurence, Tom Felton, Troy Leigh-Anne Johnson, Lynn Masako Cheng, Ty Consiglio, I', 'Rachel Talalay', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(150, 'https://www.streamua.ddnsking.com/peliculas/ABadMomsChristmas', NULL, 'A Bad Moms Christmas', 'Stressed-out moms Amy, Carla and Kiki are back, and the looming Christmas holiday gets even more daunting when their mothers show up for a visit.', 'United States, China', NULL, 'Mila Kunis, Kristen Bell, Kathryn Hahn, Susan Sarandon, Christine Baranski, Jay Hernandez, Cheryl Hi', 'Jon Lucas, Scott Moore', 0, 'admin1@gmail.com', 'Comedies'),
	(151, 'https://www.streamua.ddnsking.com/peliculas/ABeautifulLife', NULL, 'A Beautiful Life', 'After meeting under awkward circumstances, a glamorous businesswoman and a tradition-bound policeman begin a relationship that changes their lives.', 'China, Hong Kong', NULL, 'Qi Shu, Liu Ye, Anthony Wong Chau-Sang, Liang Tian, Danying Feng, Rina Sa, Zhang Songwen, Tian Gao, ', 'Andrew Lau Wai-Keung', 0, 'admin1@gmail.com', 'Dramas'),
	(152, 'https://www.streamua.ddnsking.com/peliculas/ABillionColourStory', NULL, 'A Billion Colour Story', 'The curious child of idealistic interfaith parents observes an increasingly intolerant world as his family faces financial strain.', 'India', NULL, 'Dhruva Padmakumar, Gaurav Sharma, Vasuki', 'Padmakumar Narasimhamurthy', 0, 'admin1@gmail.com', 'Dramas'),
	(153, 'https://www.streamua.ddnsking.com/peliculas/ABoyCalledPo', NULL, 'A Boy Called Po', 'After his wifes death, an overworked engineer struggles to care for his son with autism, who regresses into a fantasy world to escape real-life bullying.', 'United States', NULL, 'Christopher Gorham, Julian Feder, Kaitlin Doubleday, Andrew Bowen, Caitlin Carmichael, Sean Gunn, Br', 'John Asher', 0, 'admin1@gmail.com', 'Dramas'),
	(154, 'https://www.streamua.ddnsking.com/series/ABoyNameFloraA', NULL, 'A Boy Name Flora A', 'A 28-year-old layabout begins to re-examine his life when his dysfunctional family assembles to pay respects to a dying grandmother who won’t pass on.', 'Taiwan', NULL, 'Crowd Lu, Tsai Chen-nan, Lotus Wang, Fan Chu-Mei, Hsieh Ying-shiuan, Vera Yen, Cammy Chiang', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(155, 'https://www.streamua.ddnsking.com/peliculas/ABridgeTooFar', NULL, 'A Bridge Too Far', 'This wartime drama details a pivotal day in 1944 when an Allied task force tried to win World War II by seizing control of key bridges in Holland.', 'United States, Unite', NULL, 'Dirk Bogarde, James Caan, Michael Caine, Sean Connery, Edward Fox, Elliott Gould, Gene Hackman, Anth', 'Richard Attenborough', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(156, 'https://www.streamua.ddnsking.com/peliculas/ACaliforniaChristmas', NULL, 'A California Christmas', 'With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas.', 'United States', NULL, 'Lauren Swickard, Josh Swickard, Ali Afshar, David Del Rio, Natalia Mann, Katelyn Epperly, Gunnar And', 'Shaun Paul Piccinino', 0, 'admin1@gmail.com', 'Comedies'),
	(157, 'https://www.streamua.ddnsking.com/peliculas/AChampionHeart', NULL, 'A Champion Heart', 'When a grieving teen must work off her debt to a ranch, she cares for a wounded horse that teaches her more about healing than she expected.', 'United States', NULL, 'Mandy Grace, David de Vos, Donna Rusch, Devan Key, Isabella Mancuso, Ariana Guido', 'David de Vos', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(158, 'https://www.streamua.ddnsking.com/peliculas/AChasterMarriage', NULL, 'A Chaster Marriage', 'Forced to wed his childhood friend, a man obsessed with football attempts to get rid of his wife in order to keep the woman he truly loves.', 'Turkey', NULL, 'Emre Karayel, Ceren Moray, Begüm Kütük, Ececan Gümeci, Ümit Erdim, Cem Kiliç, Haldun Boysan, Ferdi A', 'Umut Kirca', 0, 'admin1@gmail.com', 'Comedies'),
	(159, 'https://www.streamua.ddnsking.com/peliculas/AChoo', NULL, 'A Choo', 'Determined to win the heart of his childhood crush from orphanage, EJ becomes a boxer with superpowers and soon confronts a formidable villain.', 'Taiwan', NULL, 'Kai Ko, Ariel Lin, Darren Wang, Zhang Xiaolong, Louis Koo, Vanness Wu, Kate Tsui', 'Kevin Ko, Peter Tsi', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(160, 'https://www.streamua.ddnsking.com/peliculas/AChristmasCatch', NULL, 'A Christmas Catch', 'A cop working undercover to trail a possible diamond thief gets caught in a tricky spot when she finds new clues — and new feelings — for the suspect.', 'Canada', NULL, 'Emily Alatalo, Lauren Holly, Yanic Truesdale, Franco Lo Presti, Andrew Bushell, Genelle Williams, Ky', '', 0, 'admin1@gmail.com', 'Dramas'),
	(161, 'https://www.streamua.ddnsking.com/peliculas/AChristmasPrince', NULL, 'A Christmas Prince', 'Christmas comes early for an aspiring young journalist when shes sent abroad to get the scoop on a dashing prince whos poised to be king.', 'United States', NULL, 'Rose McIver, Ben Lamb, Alice Krige, Honor Kneafsey', 'Alex Zamm', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(162, 'https://www.streamua.ddnsking.com/peliculas/AChristmasPrince:TheRoyalBaby', NULL, 'A Christmas Prince: The Royal Baby', 'Christmas brings the ultimate gift to Aldovia: a royal baby. But first, Queen Amber must save her family and kingdom by unwrapping a monarchy mystery.', 'United States', NULL, 'Rose McIver, Ben Lamb, Alice Krige, Honor Kneafsey, Sarah Douglas, Andy Lucas, Raj Bajaj, Richard As', 'John Schultz', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(163, 'https://www.streamua.ddnsking.com/peliculas/AChristmasPrince:TheRoyalWedding', NULL, 'A Christmas Prince: The Royal Wedding', 'A year after helping Richard secure the crown, Amber returns to Aldovia to plan their wedding. But her simple tastes clash with royal protocol.', 'United States', NULL, 'Rose McIver, Ben Lamb, Alice Krige, Simon Dutton, Honor Kneafsey, Sarah Douglas, Theo Devaney, John ', 'John Schultz', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(164, 'https://www.streamua.ddnsking.com/peliculas/AChristmasSpecial:Miraculous:TalesofLadybug&CatNoir', NULL, 'A Christmas Special: Miraculous: Tales of Ladybug ', 'Parisian teen Marinette transforms herself into superhero Ladybug to find her lonely secret crush Adrien when he runs away from home at Christmas.', 'France, South Korea,', NULL, 'Cristina Vee, Bryce Papenbrook, Keith Silverstein, Mela Lee, Max Mittelman, Carrie Keranen, Stephani', 'Thomas Astruc', 0, 'admin1@gmail.com', 'Movies'),
	(165, 'https://www.streamua.ddnsking.com/peliculas/ACinderellaStory', NULL, 'A Cinderella Story', 'Teen Sam meets the boy of her dreams at a dance before returning to toil in her stepmothers diner. Can her lost cell phone bring them together?', 'United States, Canad', NULL, 'Hilary Duff, Chad Michael Murray, Jennifer Coolidge, Dan Byrd, Regina King, Julie Gonzalo, Lin Shaye', 'Mark Rosman', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(166, 'https://www.streamua.ddnsking.com/peliculas/ACinderellaStory:ChristmasWish', NULL, 'A Cinderella Story: Christmas Wish', 'Despite her vain stepmother and mean stepsisters, an aspiring singer works as an elf at a Christmas tree lot and finds her own holiday miracle.', 'United States', NULL, 'Laura Marano, Gregg Sulkin, Isabella Gomez, Johannah Newmarch, Lillian Doucet-Roche, Chanelle Peloso', 'Michelle Johnston', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(167, 'https://www.streamua.ddnsking.com/peliculas/AClockworkOrange', NULL, 'A Clockwork Orange', 'In this dark satire from director Stanley Kubrick, a young, vicious sociopath in a dystopian England undergoes an experimental rehabilitation therapy.', 'United Kingdom, Unit', NULL, 'Malcolm McDowell, Patrick Magee, Michael Bates, Warren Clarke, Adrienne Corri, Paul Farrell, Miriam ', 'Stanley Kubrick', 0, 'admin1@gmail.com', 'ClassicMovies'),
	(168, 'https://www.streamua.ddnsking.com/peliculas/ADangerousWoman', NULL, 'A Dangerous Woman', 'At the center of this engrossing melodrama is a Golden Globe-nominated turn by Debra Winger, who plays a sheltered, slow-witted woman living with her widowed Aunt Frances while working at a dry cleaners.', 'United States', NULL, 'Debra Winger, Barbara Hershey, Gabriel Byrne, Laurie Metcalf, John Terry, Maggie Gyllenhaal, Jake Gy', 'Stephen Gyllenhaal', 0, 'admin1@gmail.com', 'Dramas'),
	(169, 'https://www.streamua.ddnsking.com/peliculas/AFairlyOddSummer', NULL, 'A Fairly Odd Summer', 'In this live-action adventure, the gang heads to Hawaii, where Timmy learns the source of all fairy magic is in dangerous hands.', 'United States', NULL, 'Drake Bell, Daniella Monet, David Lewis, Susanne Blakeslee, Daran Norris, Scott Baio, Devon Weigel, ', 'Savage Steve Holland', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(170, 'https://www.streamua.ddnsking.com/peliculas/AFallfromGrace', NULL, 'A Fall from Grace', 'When gentle, law-abiding Grace confesses to killing her new husband, her skeptical young lawyer sets out to uncover the truth. A film by Tyler Perry.', 'United States', NULL, 'Crystal Fox, Phylicia Rashad, Cicely Tyson, Bresha Webb, Mehcad Brooks, Adrian Pasdar, Tyler Perry', 'Tyler Perry', 0, 'admin1@gmail.com', 'Dramas'),
	(171, 'https://www.streamua.ddnsking.com/peliculas/AFamilyAffair', NULL, 'A Family Affair', 'The filmmaker hunts for the missing puzzle pieces of his family history during a visit with a complex and controversial figure: his grandmother.', 'Netherlands, Denmark', NULL, 'Tom Fassaert', 'Tom Fassaert', 0, 'admin1@gmail.com', 'Documentaries'),
	(172, 'https://www.streamua.ddnsking.com/peliculas/AFamilyMan', NULL, 'A Family Man', 'A ruthless corporate headhunter battles his rival for a promotion while dealing with a family crisis that threatens to derail his career.', 'Canada, United State', NULL, 'Gerard Butler, Gretchen Mol, Alison Brie, Willem Dafoe, Alfred Molina, Maxwell Jenkins, Anupam Kher,', 'Mark Williams', 0, 'admin1@gmail.com', 'Dramas'),
	(173, 'https://www.streamua.ddnsking.com/peliculas/AFamilyReunionChristmas', NULL, 'A Family Reunion Christmas', 'MDear and her sisters struggle to keep their singing act together before a church Christmas pageant while Grandpa teaches the kids a valuable lesson.', 'United States', NULL, 'Loretta Devine, Tia Mowry-Hardrict, Anthony Alabi, Talia Jackson, Isaiah Russell-Bailey, Cameron J. ', 'Robbie Countryman', 0, 'admin1@gmail.com', 'Movies'),
	(174, 'https://www.streamua.ddnsking.com/peliculas/AFlyingJatt', NULL, 'A Flying Jatt', 'A timid man gets unexpected superpowers while trying to save his familys land and a sacred tree from a ruthless tycoon.', 'India', NULL, 'Tiger Shroff, Jacqueline Fernandez, Nathan Jones, Kay Kay Menon, Amrita Singh, Gaurav Pandey, Shradd', 'Remo DSouza', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(175, 'https://www.streamua.ddnsking.com/peliculas/AFortunateMan', NULL, 'A Fortunate Man', 'A gifted engineer flees his austere roots to pursue wealth and success among Copenhagens elite, but the pride propelling him threatens to be his ruin.', 'Denmark', NULL, 'Esben Smed, Katrine Rosenthal, Benjamin Kitter, Julie Christiansen, Tommy Kenter, Tammi Øst, Rasmus ', 'Bille August', 0, 'admin1@gmail.com', 'Dramas'),
	(176, 'https://www.streamua.ddnsking.com/peliculas/AFutileandStupidGesture', NULL, 'A Futile and Stupid Gesture', 'In a brief life full of triumph and failure, "National Lampoon" co-founder Doug Kenney built a comedy empire, molding pop culture in the 1970s.', 'United States', NULL, 'Will Forte, Domhnall Gleeson, Martin Mull, Joel McHale, Matt Lucas, Thomas Lennon, Seth Green, Jacki', 'David Wain', 0, 'admin1@gmail.com', 'Comedies'),
	(177, 'https://www.streamua.ddnsking.com/peliculas/AGhostStory', NULL, 'A Ghost Story', 'Following a fatal car crash, a mans spirit remains stuck in the home he shared with his wife as doors into the past and future begin to open.', 'United States', NULL, 'Casey Affleck, Rooney Mara, Liz Franke, Rob Zabrecky, Will Oldham, Sonia Acevedo', 'David Lowery', 0, 'admin1@gmail.com', 'Dramas'),
	(178, 'https://www.streamua.ddnsking.com/peliculas/AGlimpseInsidetheMindofCharlesSwanIII', NULL, 'A Glimpse Inside the Mind of Charles Swan III', 'When his girlfriend walks out and leaves him a wreck, a graphic designer – who seemed to have it all – sets out to discover where he went wrong.', 'United States', NULL, 'Charlie Sheen, Jason Schwartzman, Bill Murray, Katheryn Winnick, Patricia Arquette, Aubrey Plaza, Ma', 'Roman Coppola', 0, 'admin1@gmail.com', 'Comedies'),
	(179, 'https://www.streamua.ddnsking.com/peliculas/AGo!Go!CoryCarsonChristmas', NULL, 'A Go! Go! Cory Carson Christmas', 'When a familiar-looking stranger crashes in without a memory, Cory helps him remember the magic of Christmas to save the holiday for everyone.', 'United States', NULL, 'Alan C. Lim, Taron C. Hensley, Maisie Benson, Kerry Gudjohnsen, Paul Killam, Smith Foreman, Ann Kend', 'Stanley Moore, Alex Woo', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(180, 'https://www.streamua.ddnsking.com/peliculas/AGo!Go!CoryCarsonHalloween', NULL, 'A Go! Go! Cory Carson Halloween', 'Cory, Chrissy and Freddie are on the hunt for king-sized candy bars this Halloween! But are all the treats worth the trek to the spooky side of town?', '', NULL, 'Alan C. Lim, Smith Foreman, Maisie Benson, Ann Kendrick, Kerry Gudjohnsen, Paul Killam, Stanley Moor', 'Alex Woo, Stanley Moore', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(181, 'https://www.streamua.ddnsking.com/peliculas/AGo!Go!CoryCarsonSummerCamp', NULL, 'A Go! Go! Cory Carson Summer Camp', 'Corys spending the summer at Camp Friendship with his best friend, Freddie. But jealousy flares when Freddie brings his cousin Rosie along for the ride.', '', NULL, 'Alan C. Lim, Smith Foreman, Abigail Vibat, Pfifer Chastain, Jim Capobianco, Neena-Sinaii Simpo, Eli ', 'Stanley Moore, Alex Woo', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(182, 'https://www.streamua.ddnsking.com/series/AGoodWife', NULL, 'A Good Wife', 'As her seemingly idyllic life begins to crumble, a lonely woman in a restrictive marriage starts an affair with a gentle bookstore owner.', 'Taiwan', NULL, 'Tien Hsin, Christopher Lee, Darren Chiu, Shara Lin, Blaire Chang, Xi Man-Ning, Chu De-Kang', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(183, 'https://www.streamua.ddnsking.com/peliculas/AGrandNightIn:TheStoryofAardman', NULL, 'A Grand Night In: The Story of Aardman', 'Aardman Animations icons Wallace & Gromit, Morph and more join fans and collaborators for a retrospective celebrating the studios 40th anniversary.', 'United Kingdom', NULL, 'Julie Walters', 'Richard Mears', 0, 'admin1@gmail.com', 'Documentaries'),
	(184, 'https://www.streamua.ddnsking.com/peliculas/AGrayState', NULL, 'A Gray State', 'This documentary dissects the case of a filmmaker whose death, along with the deaths of his wife and daughter, sparked alt-right conspiracy theories.', 'United States', NULL, '', 'Erik Nelson', 0, 'admin1@gmail.com', 'Documentaries'),
	(185, 'https://www.streamua.ddnsking.com/peliculas/AHauntedHouse', NULL, 'A Haunted House', 'This spoof on scary movies follows a young couple settling into a new home, where an evil spirit — and horrifyingly hilarious antics — await.', 'United States', NULL, 'Marlon Wayans, Essence Atkins, Cedric the Entertainer, Nick Swardson, David Koechner, Dave Sheridan,', 'Michael Tiddes', 0, 'admin1@gmail.com', 'Comedies'),
	(186, 'https://www.streamua.ddnsking.com/peliculas/AHauntingatSilverFalls:TheReturn', NULL, 'A Haunting at Silver Falls: The Return', 'When the ghost of her serial killer aunt seemingly resurfaces, Jordan must return to Silver Falls in hopes of finally putting an end to the torment.', 'United States', NULL, 'Laura Flannery, James Cavlo, Harry Hains, Clemmie Dugdale, Dendrie Taylor, Bryan Chesters, Jennifer ', 'Teo Konuralp', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(187, 'https://www.streamua.ddnsking.com/peliculas/AHeavyHeart', NULL, 'A Heavy Heart', 'Long past his heyday, a still-virile boxer tries to reconnect with his daughter as he confronts the onset of a terminal, degenerative neural disorder.', 'Germany', NULL, 'Peter Kurth, Lena Lauzemis, Lina Wendel, Edin Hasanovic, Marko Dyrlich, Peter Schneider, Reiner Schö', 'Thomas Stuber', 0, 'admin1@gmail.com', 'Dramas'),
	(188, 'https://www.streamua.ddnsking.com/peliculas/AHolidayEngagement', NULL, 'A Holiday Engagement', 'Hilarys plan to hire a good-looking guy to act as her boyfriend backfires when she brings him home for the holidays to try and fool her family.', 'United States', NULL, 'Bonnie Somerville, Shelley Long, Jordan Bridges, Sam McMurray, Haylie Duff, Sam Horrigan, Carrie Wii', 'Jim Fall', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(189, 'https://www.streamua.ddnsking.com/peliculas/AHomewithAView', NULL, 'A Home with A View', 'When a neighbor blocks their view of the city with a commercial billboard, a Hong Kong family resorts to drastic, imaginative measures to take it down.', 'Hong Kong', NULL, 'Francis Chun-Yu Ng, Louis Koo, Anita Yuen, Tat-Ming Cheung, Jocelyn Choi, Ng Siu-hin, Lam Suet, Anth', 'Herman Yau', 0, 'admin1@gmail.com', 'Comedies'),
	(190, 'https://www.streamua.ddnsking.com/series/AHouseofBlocks', NULL, 'A House of Blocks', 'Yijuan and her mentally ill sister Kaiqi struggle to be happy in the face of misfortune, criminal intrigue, marital strife, an exorcism and a ghost.', 'Taiwan', NULL, 'Eli Shi, Phoebe Lin, Chen Wan-ting, Fan Chen-fei, Lu Hsueh-feng, Figaro Tseng, Winnie Chang, Elten T', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(191, 'https://www.streamua.ddnsking.com/peliculas/AKidfromConeyIsland', NULL, 'A Kid from Coney Island', 'From gifted athlete to professional NBA hooper, Coney Islands Stephon Marbury navigates the pressures, pitfalls and peaks of his basketball journey.', 'United States, China', NULL, 'Stephon Marbury', 'Coodie, Chike', 0, 'admin1@gmail.com', 'Documentaries'),
	(192, 'https://www.streamua.ddnsking.com/peliculas/AKindofMurder', NULL, 'A Kind of Murder', 'Obsessed with an unsolved murder case, a crime novelist stuck in an unhappy marriage fantasizes about killing his wife, who soon turns up dead.', 'United States', NULL, 'Patrick Wilson, Jessica Biel, Vincent Kartheiser, Haley Bennett, Eddie Marsan, Jon Osbeck, Radek Lor', 'Andy Goddard', 0, 'admin1@gmail.com', 'Thrillers'),
	(193, 'https://www.streamua.ddnsking.com/series/AKoreanOdyssey', NULL, 'A Korean Odyssey', 'A self-serving mythical creatures bid for invincibility backfires when he finds himself at the mercy of a woman who can see otherworldly beings.', 'South Korea', NULL, 'Lee Seung-gi, Cha Seung-won, Oh Yeon-seo, Lee Hong-gi, Jang Gwang, Lee Se-young', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(194, 'https://www.streamua.ddnsking.com/peliculas/ALandImagined', NULL, 'A Land Imagined', 'A cop in Singapore investigates the disappearance of a Chinese migrant construction worker who spent sleepless nights playing a mysterious video game.', 'France, Netherlands,', NULL, 'Peter Yu, Liu Xiaoyi, Guo Yue, Ishtiaque Zico, Jack Tan', 'Yeo Siew Hua', 0, 'admin1@gmail.com', 'Dramas'),
	(195, 'https://www.streamua.ddnsking.com/peliculas/ALeafofFaith', NULL, 'A Leaf of Faith', 'This documentary takes a deep dive into the benefits, dangers and lingering questions around Kratom leaf as an alternative to opioid painkillers.', 'United States', NULL, '', 'Chris Bell', 0, 'admin1@gmail.com', 'Documentaries'),
	(196, 'https://www.streamua.ddnsking.com/peliculas/ALifeofSpeed:TheJuanManuelFangioStory', NULL, 'A Life of Speed: The Juan Manuel Fangio Story', 'Juan Manuel Fangio was the Formula One king, winning five world championships in the early 1950s — before protective gear or safety features were used.', 'Argentina', NULL, '', 'Francisco Macri', 0, 'admin1@gmail.com', 'Documentaries'),
	(197, 'https://www.streamua.ddnsking.com/series/ALionintheHouse', NULL, 'A Lion in the House', 'Five kids and their resilient families navigate the treatments and traumas of pediatric cancer in this documentary filmed over the course of six years.', 'United States', NULL, '', 'Steven Bognar, Julia Reichert', 0, 'admin1@gmail.com', 'TVShows'),
	(198, 'https://www.streamua.ddnsking.com/peliculas/ALittleChaos', NULL, 'A Little Chaos', 'A willful young woman is hired to design a garden at Versailles for Louis XIV. Soon, shes ensnared in political and romantic complications.', 'United Kingdom', NULL, 'Kate Winslet, Matthias Schoenaerts, Alan Rickman, Stanley Tucci, Helen McCrory, Steven Waddington, J', 'Alan Rickman', 0, 'admin1@gmail.com', 'Dramas'),
	(199, 'https://www.streamua.ddnsking.com/series/ALittleHelpwithCarolBurnett', NULL, 'A Little Help with Carol Burnett', 'Comedy icon Carol Burnett returns to TV with a panel of clever kids, who help adults and celebrity guests solve their problems with brutal honesty.', 'United States', NULL, 'Carol Burnett, Russell Peters, Mark Cuban, Taraji P. Henson, Brittany Snow, Wanda Sykes, Derek Hough', '', 0, 'admin1@gmail.com', 'Stand-UpComedy&TalkS'),
	(200, 'https://www.streamua.ddnsking.com/series/ALittleThingCalledFirstLove', NULL, 'A Little Thing Called First Love', 'A shy college student with a knack for drawing develops a crush on a musically gifted classmate and embarks on a journey of self-discovery.', 'China', NULL, 'Lai Kuan-lin, Zhao Jinmai, Wang Runze, Chai Wei, Wang Bowen', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(201, 'https://www.streamua.ddnsking.com/series/ALoveSoBeautiful', NULL, 'A Love So Beautiful', 'Love is as tough as it is sweet for a lovestruck teenager, whose relationship with her next-door neighbor transforms as they grow into adulthood.', 'South Korea', NULL, 'Kim Yo-han, So Joo-yeon, Yeo Hoi-hyun, Jeong Jin-hwan, Jo Hye-joo, Yun Seo-hyun, Cho Ryun, Kim Sung-', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(202, 'https://www.streamua.ddnsking.com/peliculas/ALoveSongforLatasha', NULL, 'A Love Song for Latasha', 'The killing of Latasha Harlins became a flashpoint for the 1992 LA uprising. This documentary evocatively explores the 15-year-olds life and dreams.', 'United States', NULL, '', 'Sophia Nahli Allison', 0, 'admin1@gmail.com', 'Documentaries'),
	(203, 'https://www.streamua.ddnsking.com/peliculas/ALoveStory', NULL, 'A Love Story', 'Self-made millionaire Ian thinks hes found happiness when he marries caring Joanna, but his love is put to the test when he meets stewardess Karyn.', 'Philippines', NULL, 'Maricel Soriano, Aga Muhlach, Angelica Panganiban, Dante Rivero, Chin Chin Gutierrez, Bobby Andrews,', 'Maryo J. De los Reyes', 0, 'admin1@gmail.com', 'Dramas'),
	(204, 'https://www.streamua.ddnsking.com/series/AManCalledGod', NULL, 'A Man Called God', 'Raised in America, government agent Choi Kang-Ta returns to Korea with the skills of an assassin and a thirst for revenge on his father’s killers.', 'South Korea', NULL, 'Song Il-gook, Han Chae-young, Kim Min-jong, Go Eun Han, Jung Hoon Lee, Nam Da-Reum, Yoo In-young', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(205, 'https://www.streamua.ddnsking.com/peliculas/AMightyTeam', NULL, 'A Mighty Team', 'When a fit of anger leads to a serious injury, a sidelined soccer star returns to his hometown and reluctantly agrees to train the local youth.', 'France', NULL, 'Gérard Depardieu, Chantal Lauby, Medi Sadoun, Ilian Bergala, Blanche Gardin, Patrick Timsit, Barbara', 'Thomas Sorriaux', 0, 'admin1@gmail.com', 'Comedies'),
	(206, 'https://www.streamua.ddnsking.com/peliculas/AMissioninanOldMovie', NULL, 'A Mission in an Old Movie', 'A young man struggles with his overbearing mother while looking for romance and a way to kick-start his show business career.', '', NULL, 'Edward, Fifi Abdo, Lotfy Labib, Madeleine Matar, Nahla Zaki, Ahmed Fathy, Said Tarabeek, Badriya Tol', 'Ahmad El-Badri', 0, 'admin1@gmail.com', 'Comedies'),
	(207, 'https://www.streamua.ddnsking.com/peliculas/AMonsterCalls', NULL, 'A Monster Calls', 'Overwhelmed by his mother’s illness, a young boy begins to understand human complexity through the fantastic tales of a consoling tree monster.', 'United Kingdom, Spai', NULL, 'Lewis MacDougall, Sigourney Weaver, Felicity Jones, Liam Neeson, Toby Kebbell, Ben Moor, James Melvi', 'J.A. Bayona', 0, 'admin1@gmail.com', 'Dramas'),
	(208, 'https://www.streamua.ddnsking.com/peliculas/AMostViolentYear', NULL, 'A Most Violent Year', 'Abel Morales tries to avoid corruptions easy path as he pursues the American Dream amid an increasingly violent business war in 1981 New York City.', 'United Arab Emirates', NULL, 'Oscar Isaac, Jessica Chastain, David Oyelowo, Albert Brooks, Elyes Gabel, Catalina Sandino Moreno, C', 'J.C. Chandor', 0, 'admin1@gmail.com', 'Dramas'),
	(209, 'https://www.streamua.ddnsking.com/peliculas/AMurderinthePark', NULL, 'A Murder in the Park', 'This documentary excoriates a noted anti-death-penalty activist and his team, whose questionable methods got a convicted killer freed in 1999.', 'United States', NULL, '', 'Christopher S. Rech, Brandon Kimber', 0, 'admin1@gmail.com', 'Documentaries'),
	(210, 'https://www.streamua.ddnsking.com/peliculas/AnewCapitalism', NULL, 'A new Capitalism', 'Entrepreneurs worldwide explore alternatives to current capitalist structures, advocating for profitable businesses that also tackle social inequality.', 'Brazil', NULL, '', '', 0, 'admin1@gmail.com', 'Documentaries'),
	(211, 'https://www.streamua.ddnsking.com/peliculas/ANewYorkChristmasWedding', NULL, 'A New York Christmas Wedding', 'As her wedding nears, a bride-to-be is visited by an angel who reveals what could have been if shed followed feelings for her childhood best friend.', 'United States', NULL, 'Nia Fairweather, Chris Noth, Cooper Koch, Tyra Ferrell, Denny Dillon, Adriana DeMeo, Otoja Abit, Dav', 'Otoja Abit', 0, 'admin1@gmail.com', 'Dramas'),
	(212, 'https://www.streamua.ddnsking.com/peliculas/ANightattheRoxbury', NULL, 'A Night at the Roxbury', 'After a run-in with Richard Grieco, dimwits Doug and Steve gain entry to a swanky nightclub in this comedy based on a "Saturday Night Live" sketch.', 'United States', NULL, 'Will Ferrell, Chris Kattan, Dan Hedaya, Molly Shannon, Richard Grieco, Loni Anderson, Elisa Donovan,', 'John Fortenberry', 0, 'admin1@gmail.com', 'Comedies'),
	(213, 'https://www.streamua.ddnsking.com/peliculas/ANobleIntention', NULL, 'A Noble Intention', 'In 1888 Amsterdam, a headstrong violin maker finds himself immersed in peril and tragedy after challenging businessmen who threaten his community.', 'Netherlands', NULL, 'Gijs Scholten van Aschat, Jacob Derwig, Rifka Lodeizen, Juda Goslinga, Zeb Troostwijk, Elisabeth Hes', 'Joram Lürsen', 0, 'admin1@gmail.com', 'Dramas'),
	(214, 'https://www.streamua.ddnsking.com/peliculas/APatchofFog', NULL, 'A Patch of Fog', 'When a guard catches a writer-television host shoplifting, instead of turning him in, he only asks to be a friend, then begins to rule his life.', 'United Kingdom', NULL, 'Stephen Graham, Conleth Hill, Lara Pulver, Arsher Ali, Stuart Graham, Ian McElhinney', 'Michael Lennox', 0, 'admin1@gmail.com', 'Dramas'),
	(215, 'https://www.streamua.ddnsking.com/series/APerfectCrime', NULL, 'A Perfect Crime', 'This docuseries investigates the 1991 killing of politician Detlev Rohwedder, an unsolved mystery at the heart of Germanys tumultuous reunification.', 'Germany', NULL, '', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(216, 'https://www.streamua.ddnsking.com/peliculas/APerfectEnding', NULL, 'A Perfect Ending', 'After confessing an unusual secret, a repressed wife – prompted by her friends – decides to explore her sexuality with a high-priced call girl.', 'United States', NULL, 'Barbara Niven, Jessica Clark, John Heard, Morgan Fairchild, Kerry Knuppe, Imelda Corcoran, Mary Jane', 'Nicole Conn', 0, 'admin1@gmail.com', 'Dramas'),
	(217, 'https://www.streamua.ddnsking.com/peliculas/APerfectMan', NULL, 'A Perfect Man', 'Nina thinks her husband, James, is cheating on her, and she sets out to prove it by calling him and pretending to be another woman.', 'United States', NULL, 'Liev Schreiber, Jeanne Tripplehorn, Joelle Carter, Louise Fletcher, Katie Carr, Renée Soutendijk, Hu', 'Kees Van Oostrum', 0, 'admin1@gmail.com', 'Dramas'),
	(218, 'https://www.streamua.ddnsking.com/peliculas/APlasticOcean', NULL, 'A Plastic Ocean', 'When he discovers the worlds oceans brimming with plastic waste, a documentary filmmaker investigates the pollutions environmental impacts.', 'United Kingdom, Hong', NULL, 'Tanya Streeter', '', 0, 'admin1@gmail.com', 'Documentaries'),
	(219, 'https://www.streamua.ddnsking.com/peliculas/APrincessforChristmas', NULL, 'A Princess for Christmas', 'At the invitation of a relative, young Jules Daly travels with her niece and nephew to a castle in Europe, where Jules falls for a dashing prince.', 'United States', NULL, 'Katie McGrath, Sir Roger Moore, Sam Heughan, Travis Turner, Leilah de Meza, Miles Richardson, Charlo', 'Michael Damian', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(220, 'https://www.streamua.ddnsking.com/series/AQueenIsBorn', NULL, 'A Queen Is Born', 'Gloria Groove and Alexia Twister make drag dreams come true as they help six artists find the confidence to own the stage in this makeover show.', 'Brazil', NULL, 'Gloria Groove, Alexia Twister', 'Carla Barros', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(221, 'https://www.streamua.ddnsking.com/peliculas/ARemarkableTale', NULL, 'A Remarkable Tale', 'The residents of an isolated town look to revive their homes identity when a group of foreigners unexpectedly arrive, bringing culture shock with them.', 'Spain', NULL, 'Carmen Machi, Pepón Nieto, Kiti Mánver, Jon Kortajarena, Jimmy Castro, Ricardo Nkosi, Montse Pla, Ma', 'Marina Seresesky', 0, 'admin1@gmail.com', 'Comedies'),
	(222, 'https://www.streamua.ddnsking.com/peliculas/ARussellPetersChristmas', NULL, 'A Russell Peters Christmas', 'Inspired by the variety shows of the 1970s, "A Russell Peters Christmas" is a sweet, silly, sentimental and, most of all, funny Christmas special.', 'Canada', NULL, 'Russell Peters, Pamela Anderson, Michael Bublé, Jon Lovitz, Scott Thompson, Faizon Love, Goapele, Te', 'Henry Sarwer-Foner', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(223, 'https://www.streamua.ddnsking.com/peliculas/AScandall', NULL, 'A Scandall', 'A film school graduate is interested in making a movie about his girlfriends uncle, who claims that he can see his long-dead daughter.', 'India', NULL, 'Johnny Baweja, Reeth Mazumder, Manav Kaul, Tanvi Vyas, Puru Chibber, Vasundhara Kaul, Aayam Mehta, N', 'Ishaan Trivedi', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(224, 'https://www.streamua.ddnsking.com/peliculas/ASecondChance', NULL, 'A Second Chance', 'Following their storybook wedding, Popoy and Basha find married life – and starting a business together – more challenging than they ever imagined.', 'Philippines', NULL, 'John Lloyd Cruz, Bea Alonzo, Dimples Romana, Janus del Prado, James Blanco, Ahron Villena, Beatriz S', 'Cathy Garcia-Molina', 0, 'admin1@gmail.com', 'Dramas'),
	(225, 'https://www.streamua.ddnsking.com/peliculas/ASecretLove', NULL, 'A Secret Love', 'Amid shifting times, two women kept their decades-long love a secret. But coming out later in life comes with its own set of challenges.', 'United States', NULL, '', 'Chris Bolan', 0, 'admin1@gmail.com', 'Documentaries'),
	(226, 'https://www.streamua.ddnsking.com/peliculas/ASeparation', NULL, 'A Separation', 'Amid an impasse in his marriage, a father in Tehran is beset by a bitter feud involving the family of a pious caretaker he hired for his aging dad.', 'Iran, France', NULL, 'Leila Hatami, Peyman Moaadi, Shahab Hosseini, Sareh Bayat, Sarina Farhadi, Babak Karimi, Ali-Asghar ', 'Asghar Farhadi', 0, 'admin1@gmail.com', 'Dramas'),
	(228, 'https://www.streamua.ddnsking.com/peliculas/ASeriousMan', NULL, 'A Serious Man', 'With every aspect of his life unraveling, a Jewish physics professor seeks out three rabbis for spiritual guidance.', 'United States, Unite', NULL, 'Michael Stuhlbarg, Richard Kind, Fred Melamed, Sari Lennick, Adam Arkin, Amy Landecker, Alan Mandell', 'Ethan Coen, Joel Coen', 0, 'admin1@gmail.com', 'Comedies'),
	(229, 'https://www.streamua.ddnsking.com/peliculas/AShauntheSheepMovie:Farmageddon', NULL, 'A Shaun the Sheep Movie: Farmageddon', 'Shaun and the flock race to help an adorable alien find her way home after her ship crash-lands near Mossy Bottom Farm and sparks a UFO frenzy.', 'United Kingdom, Fran', NULL, 'Justin Fletcher, John Sparkes, Amalia Vitale, Kate Harbour, David Holt', 'Richard Phelan, Will Becher', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(231, 'https://www.streamua.ddnsking.com/peliculas/ASingleMan', NULL, 'A Single Man', 'This stream-of-consciousness drama centers on a day in the life of a gay college professor whos reeling from his longtime lovers recent death.', 'United States', NULL, 'Colin Firth, Julianne Moore, Nicholas Hoult, Ginnifer Goodwin, Matthew Goode, Paul Butler, Ryan Simp', 'Tom Ford', 0, 'admin1@gmail.com', 'Dramas'),
	(232, 'https://www.streamua.ddnsking.com/peliculas/ASortofFamily', NULL, 'A Sort of Family', 'An Argentine doctor faces legal and ethical challenges when she travels to the countryside to pick up the infant she has been waiting to adopt.', 'Argentina, Brazil, F', NULL, 'Bárbara Lennie, Daniel Aráoz, Claudio Tolcachir, Paula Cohen, Yanina Ávila', 'Diego Lerman', 0, 'admin1@gmail.com', 'Dramas'),
	(233, 'https://www.streamua.ddnsking.com/peliculas/ASortofHomecoming', NULL, 'A Sort of Homecoming', 'Ace news producer Amy is called back to her Louisiana hometown where memories of what used to be – and what might have been – come flooding back.', 'United States', NULL, 'Laura Marano, Parker Mack, Katherine McNamara, Marcus Lyle Brown, Shayne Topp, Michelle Clunie, Kath', 'Maria Burton', 0, 'admin1@gmail.com', 'Dramas'),
	(234, 'https://www.streamua.ddnsking.com/peliculas/AStoninginFulhamCounty', NULL, 'A Stoning in Fulham County', 'After reckless teens kill an Amish child, a prosecutor attempts to bring the youths to justice despite the condemnation he faces from the community.', 'United States', NULL, 'Ken Olin, Jill Eikenberry, Maureen Mueller, Gregg Henry, Nicholas Pryor, Noble Willingham, Peter Mic', 'Larry Elikann', 0, 'admin1@gmail.com', 'Dramas'),
	(235, 'https://www.streamua.ddnsking.com/peliculas/AStoryBotsChristmas', NULL, 'A StoryBots Christmas', 'Bo thinks her holiday gift-giving isnt good enough, so she heads north to study under Santa Claus – only to find hes missing.', 'United States', NULL, 'Edward Asner, Judy Greer, Erin Fitzgerald, Fred Tatasciore, Jeff Gill, Gregg Spiridellis, Evan Spiri', 'Evan Spiridellis, Jeff Gill', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(236, 'https://www.streamua.ddnsking.com/peliculas/ASun', NULL, 'A Sun', 'A family reckons with the aftermath of their younger sons incarceration and a greater misfortune that follows.', 'Taiwan', NULL, 'Wu Chien-ho, Chen Yi-wen, Samantha Ko, Liu Kuan-ting, Greg Hsu, Wu Tai-ling, Wen Chen-ling, Yin Shin', 'Chung Mong-hong', 0, 'admin1@gmail.com', 'Dramas'),
	(237, 'https://www.streamua.ddnsking.com/series/ATaiwaneseTaleofTwoCities', NULL, 'A Taiwanese Tale of Two Cities', 'A Taipei doctor and a San Francisco engineer swap homes in a daring pact, embarking on journeys filled with trials, secrets and unexpected encounters.', 'Taiwan', NULL, 'Tammy Chen, James Wen, Peggy Tseng, Denny Huang', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(238, 'https://www.streamua.ddnsking.com/peliculas/ATaleofLoveandDarkness', NULL, 'A Tale of Love and Darkness', 'Based on the memoirs of author Amos Oz, this poetic drama shares his familys tale of suffering and survival in the early years of independent Israel.', 'Israel, United State', NULL, 'Natalie Portman, Gilad Kahana, Amir Tessler, Moni Moshonov, Ohad Knoller, Makram Khoury, Neta Riskin', 'Natalie Portman', 0, 'admin1@gmail.com', 'Dramas'),
	(239, 'https://www.streamua.ddnsking.com/peliculas/ATaleofTwoKitchens', NULL, 'A Tale of Two Kitchens', 'Mexico City restaurant star Gabriela Cámara opens sister eatery Cala in San Francisco, with a similar menu and unusually welcoming kitchen culture.', 'United States, Mexic', NULL, '', 'Trisha Ziff', 0, 'admin1@gmail.com', 'Documentaries'),
	(240, 'https://www.streamua.ddnsking.com/peliculas/AThinLineBetweenLove&Hate', NULL, 'A Thin Line Between Love & Hate', 'When a philandering club promoter sets out to woo a rich, glamorous woman, he has no clue just how much mayhem hes about to unleash on his life.', 'United States', NULL, 'Martin Lawrence, Lynn Whitfield, Regina King, Bobby Brown, Della Reese, Daryl Mitchell, Roger Mosley', 'Martin Lawrence', 0, 'admin1@gmail.com', 'Comedies'),
	(241, 'https://www.streamua.ddnsking.com/series/AThousandGoodnights', NULL, 'A Thousand Goodnights', 'To carry out her dads wish and discover her roots, Dai Tian-qing embarks on a journey around Taiwan and finds love and redemption on the way.', 'Taiwan', NULL, 'Cindy Lien, Nicholas Teo, Yao Ai-ning, Li Chung-lin, Chen Bor-jeng, Miao Ke-li', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(242, 'https://www.streamua.ddnsking.com/peliculas/AThousandWords', NULL, 'A Thousand Words', 'When he learns his karma will permit him to speak just a thousand more words before he dies, fast-talking agent Jack must make every syllable count.', 'United States', NULL, 'Eddie Murphy, Kerry Washington, Cliff Curtis, Clark Duke, Allison Janney, Ruby Dee, John Witherspoon', 'Brian Robbins', 0, 'admin1@gmail.com', 'Comedies'),
	(243, 'https://www.streamua.ddnsking.com/series/ATouchofGreen', NULL, 'A Touch of Green', 'Amid the turmoil of Chinas civil war, families of Kuomintang pilots face the pain of leaving their homes but find strength in their shared bonds.', 'Taiwan', NULL, 'Weber Yang, Cheryl Yang, Tien Hsin, Gabriel Lan, Wu Kang-jen, Cindy Lien, Wen Chen-ling, Hans Chung', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(244, 'https://www.streamua.ddnsking.com/peliculas/ATrashTruckChristmas', NULL, 'A Trash Truck Christmas', 'When Santa crash-lands in the junkyard on Christmas Eve, Hank, Trash Truck and their animal friends all have a hand in rescuing the holiday for everyone.', '', NULL, 'Henry Keane, Glen Keane, Lucas Neff, Brian Baumgartner, Jackie Loeb, John DiMaggio', 'Eddie Rosas', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(245, 'https://www.streamua.ddnsking.com/peliculas/ATriptoJamaica', NULL, 'A Trip to Jamaica', 'A newly engaged couples romantic vacation in Jamaica turns into a mischievous adventure that tests their union in wild and unexpected ways.', 'Nigeria', NULL, 'Ayo Makun, Funke Akindele, Nse Ikpe-Etim, Dan Davies, Paul Campbell, Chris Attoh, Rebecca Silvera, E', 'Robert O. Peters', 0, 'admin1@gmail.com', 'Comedies'),
	(246, 'https://www.streamua.ddnsking.com/peliculas/AtruthfulMother', NULL, 'A truthful Mother', 'Facing a drought, a hungry tiger and a noble cow have an extraordinary encounter in this fable based on a children’s book and a Kannada folk song.', 'India', NULL, 'Revathi, Roger Narayanan, Sneha Ravishankar, Vidya Shankar, SR Leela', 'Ravishankar Venkateswaran', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(247, 'https://www.streamua.ddnsking.com/peliculas/ATwelveYearNight', NULL, 'A Twelve Year Night', 'Future Uruguayan president José Mujica and his fellow Tupamaro political prisoners fight to survive 12 years of solitary confinement and torture.', 'Uruguay, Argentina, ', NULL, 'Antonio de la Torre, Chino Darín, Alfonso Tort, Soledad Villamil, César Troncoso, Silvia Pérez Cruz,', 'Álvaro Brechner', 0, 'admin1@gmail.com', 'Dramas'),
	(248, 'https://www.streamua.ddnsking.com/peliculas/AVeryCountryChristmas', NULL, 'A Very Country Christmas', 'When an unfulfilled country music star hides out in his hometown, he meets a budding interior designer who finds her way into his heart.', 'United States, Canad', NULL, 'Bea Santos, Greyston Holt, Greg Vaughan, Deana Carter, Allison Hossack', 'Justin G. Dyck', 0, 'admin1@gmail.com', 'Music&Musicals'),
	(249, 'https://www.streamua.ddnsking.com/peliculas/AVeryMurrayChristmas', NULL, 'A Very Murray Christmas', 'Bill Murray rounds up an all-star cast for an evening of music, mischief and barroom camaraderie in this irreverent twist on holiday variety shows.', 'United States', NULL, 'Bill Murray, Miley Cyrus, George Clooney, Chris Rock, Amy Poehler, Michael Cera, Maya Rudolph, Rashi', 'Sofia Coppola', 0, 'admin1@gmail.com', 'Comedies'),
	(250, 'https://www.streamua.ddnsking.com/series/AVerySecretService', NULL, 'A Very Secret Service', 'At the height of the Cold War in 1960, André Merlaux joins the French Secret Service and contends with enemies both foreign and bureaucratic.', 'France', NULL, 'Hugo Becker, Wilfred Benaïche, Christophe Kourotchkine, Karim Barras, Bruno Paviot, Jean-Édouard Bod', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(251, 'https://www.streamua.ddnsking.com/peliculas/AVerySpecialLove', NULL, 'A Very Special Love', 'After landing a job working for her longtime crush, an optimistic woman realizes that the man of her dreams isnt exactly who she envisioned.', 'Philippines', NULL, 'John Lloyd Cruz, Sarah Geronimo, Dante Rivero, Rowell Santiago, Johnny Revilla, Bing Pimental, Daphn', 'Cathy Garcia-Molina', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(252, 'https://www.streamua.ddnsking.com/peliculas/AWalktoRemember', NULL, 'A Walk to Remember', 'When bad boy Landon is cast opposite campus bookworm Jamie in a high school play, romance blooms — until tragedy threatens to tear them apart.', 'United States', NULL, 'Mandy Moore, Shane West, Peter Coyote, Daryl Hannah, Lauren German, Clayne Crawford, Al Thompson', 'Adam Shankman', 0, 'admin1@gmail.com', 'Dramas'),
	(253, 'https://www.streamua.ddnsking.com/peliculas/AWednesday', NULL, 'A Wednesday', 'After receiving an anonymous tip about a bomb, a police commissioner must negotiate with the terrorist, who demands the release of four militants.', 'India', NULL, 'Anupam Kher, Naseeruddin Shah, Jimmy Shergill, Deepal Shaw, Aamir Bashir, Kali Prasad Mukherjee, Vij', 'Neeraj Pandey', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(254, 'https://www.streamua.ddnsking.com/peliculas/AWeekinWatts', NULL, 'A Week in Watts', 'Los Angeles police officers embark on an innovative program mentoring promising students from the harsh, gang-infested Watts neighborhood.', 'United States', NULL, '', 'Gregory Caruso', 0, 'admin1@gmail.com', 'Documentaries'),
	(256, 'https://www.streamua.ddnsking.com/peliculas/AWitchesBall', NULL, 'A Witches Ball', 'Beatrix cant wait to be inducted as a witch, but an unfortunate incident threatens to take her pending title away if she doesnt act fast.', 'Canada', NULL, 'Morgan Neundorf, Karen Slater, Loukia Ioannou, Will Ennis, Renee Stein, Keith Cooper, Paul Mason, Li', 'Justin G. Dyck', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(257, 'https://www.streamua.ddnsking.com/peliculas/AWrinkleinTime', NULL, 'A Wrinkle in Time', 'Years after their father disappears, Meg and her younger brother Charles Wallace cross galaxies on a quest to save him from the heart of darkness.', 'United States', NULL, 'Storm Reid, Oprah Winfrey, Reese Witherspoon, Mindy Kaling, Deric McCabe, Levi Miller, Chris Pine, G', 'Ava DuVernay', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(258, 'https://www.streamua.ddnsking.com/series/AYearInSpace', NULL, 'A Year In Space', 'Two astronauts attempt to brave a life in Earths orbit on a record-setting mission to see if humans have the endurance to survive a flight to Mars.', 'United States', NULL, 'Scott Kelly', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(259, 'https://www.streamua.ddnsking.com/peliculas/AYellowBird', NULL, 'A Yellow Bird', 'In Singapore, a homeless ex-convict hoping to reunite with his family forms a bond with a Chinese sex worker while serving as her bodyguard.', 'Singapore, France', NULL, 'Sivakumar Palakrishnan, Huang Lu, Seema Biswas, Udaya Soundari, Nithiyia Rao, Indra Chandran', 'K. Rajagopal', 0, 'admin1@gmail.com', 'Dramas'),
	(260, 'https://www.streamua.ddnsking.com/series/AYoungDoctorsNotebookandOtherStories', NULL, 'A Young Doctors Notebook and Other Stories', 'Set during the Russian Revolution, this comic miniseries is based on a doctors memories of his early career working in an out-of-the-way village.', 'United Kingdom', NULL, 'Daniel Radcliffe, Jon Hamm, Adam Godley, Christopher Godwin, Rosie Cavaliero, Vicki Pepperdine, Marg', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(261, 'https://www.streamua.ddnsking.com/series/A.D.KingdomandEmpire', NULL, 'A.D. Kingdom and Empire', 'In the wake of Jesus Christs crucifixion, his apostles dedicate themselves to spreading his message, risking their freedom and their lives.', 'United States', NULL, 'Juan Pablo Di Pace, Adam Levy, Chipo Chung, Babou Ceesay, Emmett Scanlan, Will Thorp, Richard Coyle,', '', 0, 'admin1@gmail.com', 'TVDramas'),
	(262, 'https://www.streamua.ddnsking.com/series/A.I.C.O.', NULL, 'A.I.C.O.', 'Everything Aiko knew was a lie. Now shes joining a team of Divers to reach the place where the Burst began to stop it for good and save her family.', 'Japan', NULL, 'Haruka Shiraishi, Yusuke Kobayashi, Makoto Furukawa, Taishi Murata, Kaori Nazuka, M・A・O, Ryota Takeu', 'Kazuya Murata', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(263, 'https://www.streamua.ddnsking.com/peliculas/A.M.I.', NULL, 'A.M.I.', 'After losing her mother, a teenage girl bonds with her phone’s artificial intelligence app, a relationship that soon takes a dark and violent turn.', 'Canada', NULL, 'Debs Howard, Philip Granger, Sam Robert Muik, Havana Guppy, Bonnie Hay, Veronica Hampson, Lori Triol', 'Rusty Nixon', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(264, 'https://www.streamua.ddnsking.com/peliculas/A.X.L.', NULL, 'A.X.L.', 'Young motocross racer Miles Hill helps a top-secret robotic combat dog evade its ruthless creator and the military, who are in hot pursuit.', 'United States', NULL, 'Alex Neustaedter, Becky G., Alex MacNicoll, Dominic Rains, Thomas Jane, Lou Taylor Pucci, Patricia D', 'Oliver Daly', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(265, 'https://www.streamua.ddnsking.com/peliculas/AşkTesadüfleriSever', NULL, 'Aşk Tesadüfleri Sever', 'A series of coincidences brings two star-crossed lovers together, but fate pulls them apart until they encounter each other again in Istanbul.', 'Turkey', NULL, 'Mehmet Günsür, Belçim Bilgin, Ayda Aksel, Altan Erkekli, Sebnem Sönmez, Hüseyin Avni Danyal, Berna K', 'Ömer Faruk Sorak', 0, 'admin1@gmail.com', 'Dramas'),
	(266, 'https://www.streamua.ddnsking.com/peliculas/Aadu2', NULL, 'Aadu 2', 'When Shaji Pappan and his gang of goofy outlaws find themselves low on funds, they plan to once again win a hefty prize in a tug-of-war competition.', 'India', NULL, 'Jayasurya, Vinayakan, Sunny Wayne, Vijay Babu, Saiju Kurup, Vineeth Mohan, Unni Rajan P. Dev, Dharma', 'Midhun Manuel Thomas', 0, 'admin1@gmail.com', 'Comedies'),
	(267, 'https://www.streamua.ddnsking.com/peliculas/AageySeRight', NULL, 'Aagey Se Right', 'A cop full of self-doubt loses his gun five days before hes due to leave the force, and becomes an unexpected hero as he tries to retrieve it.', 'India', NULL, 'Shreyas Talpade, Kay Kay Menon, Shiv Pandit, Sanjay Sharma, Shenaz Treasury, Mahie Gill', 'Indrajit Nattoji', 0, 'admin1@gmail.com', 'Comedies'),
	(268, 'https://www.streamua.ddnsking.com/peliculas/AajchaDivasMajha', NULL, 'Aajcha Divas Majha', 'A conscientious politician helps an elderly singer overcome the obstacles placed in his path a by a powerful bureaucracy.', 'India', NULL, 'Sachin Khedekar, Ashwini Bhave, Mahesh Manjrekar, Hrishikesh Joshi, Satish Alekar, Sunil Tawde, Push', 'Chandrakant Kulkarni', 0, 'admin1@gmail.com', 'Comedies'),
	(269, 'https://www.streamua.ddnsking.com/peliculas/AakhriAdaalat', NULL, 'Aakhri Adaalat', 'An intrepid police inspector forced into a desk job must take matters into his own hands when ruthless criminals are released on a technicality.', 'India', NULL, 'Vinod Khanna, Dimple Kapadia, Jackie Shroff, Sonam, Vinod Mehra, Shafi Inamdar, Gulshan Grover, Roop', 'Rajiv Mehra', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(270, 'https://www.streamua.ddnsking.com/peliculas/Aalorukkam', NULL, 'Aalorukkam', 'When an aging father seeks the help of a doctor and a journalist to look for the son who left him 16 years ago, he learns some surprising truths.', 'India', NULL, 'Indrans, Sreekanth Menon, Vishnu Agasthya, Aliyar, Seethabaala, Shaji John, Sajith Nampiyar, Benny V', 'V C Abhilash', 0, 'admin1@gmail.com', 'Dramas'),
	(271, 'https://www.streamua.ddnsking.com/peliculas/Aamir', NULL, 'Aamir', 'In this high-tension thriller, an anonymous caller on a cell phone threatens to harm a mans family if he doesnt carry out every order.', 'India', NULL, 'Rajeev Khandelwal, Gajraj Rao, Shashanka Ghosh, Jhilmil Hazrika, Gazala Amin, Allauddin Khan', 'Raj Kumar Gupta', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(272, 'https://www.streamua.ddnsking.com/peliculas/AaplaManus', NULL, 'Aapla Manus', 'When a man falls from his balcony, an investigator questions the victim’s family, determined to uncover a darker truth behind the alleged accident.', 'India', NULL, 'Nana Patekar, Sumeet Raghvan, Iravati Harshe, Aashish Kulkarni, Savita Malpekar', 'Satish Rajwade', 0, 'admin1@gmail.com', 'Dramas'),
	(273, 'https://www.streamua.ddnsking.com/peliculas/Aarakshan', NULL, 'Aarakshan', 'The decision by Indias supreme court to establish caste-based reservations for jobs in education causes conflict between a teacher and his mentor.', 'India', NULL, 'Amitabh Bachchan, Saif Ali Khan, Manoj Bajpayee, Deepika Padukone, Prateik, Tanvi Azmi, Saurabh Shuk', 'Prakash Jha', 0, 'admin1@gmail.com', 'Dramas'),
	(274, 'https://www.streamua.ddnsking.com/peliculas/Aashayein', NULL, 'Aashayein', 'When he learns he has terminal cancer, a cynical gambler and chronic smoker ditches his fiancée, snubs doctors and checks into a nursing home to die.', 'India', NULL, 'John Abraham, Sonal Sehgal, Prateeksha Lonkar, Girish Karnad, Farida Jalal, Ashwin Chitale, Anaitha ', 'Nagesh Kukunoor', 0, 'admin1@gmail.com', 'Dramas'),
	(275, 'https://www.streamua.ddnsking.com/peliculas/AashikAwara', NULL, 'Aashik Awara', 'Raised by a kindly thief, orphaned Jimmy goes on the run from goons and falls in love with Jyoti, whose father indirectly caused his parents deaths.', 'India', NULL, 'Saif Ali Khan, Mamta Kulkarni, Mohnish Bahl, Sharmila Tagore, Saeed Jaffrey, Kader Khan', 'Umesh Mehra', 0, 'admin1@gmail.com', 'Dramas'),
	(276, 'https://www.streamua.ddnsking.com/peliculas/AataPita', NULL, 'Aata Pita', 'A municipal clerk with literary ambitions stalks a loan recovery officer on whom he has decided to base his storys central character.', 'India', NULL, 'Sanjay Narvekar, Bharat Jadhav, Satish Phulekar, Ashwini Apte', 'Uttung Shelar', 0, 'admin1@gmail.com', 'Comedies'),
	(277, 'https://www.streamua.ddnsking.com/peliculas/Aaviri', NULL, 'Aaviri', 'After losing their first child in an accident, a couple moves to a palatial home, where their young daughter comes under the spell of an eerie spirit.', 'India', NULL, 'Ravi Babu, Neha Chauhan, Sri Muktha, Bharani Shankar, Mukhtar Khan, Priya', 'Ravi Babu', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(279, 'https://www.streamua.ddnsking.com/peliculas/AbbySen', NULL, 'Abby Sen', 'After losing his seventh job in a row, a TV producer and sci-fi buff travels back in time to 1980, where his employment prospects improve.', 'India', NULL, 'Abir Chatterjee, Raima Sen, Arunima Ghosh, Priyanka Sarkar, Sujan Mukherjee, Kanchan Mullick, Biswan', 'Atanu Ghosh', 0, 'admin1@gmail.com', 'Comedies'),
	(280, 'https://www.streamua.ddnsking.com/peliculas/ABCD2', NULL, 'ABCD 2', 'After being accused of cheating on a reality TV show, a dance troupe seeks to redeem itself by winning the World Hip-Hop Dance Championship.', 'India', NULL, 'Prabhu Deva, Varun Dhawan, Shraddha Kapoor, Lauren Gottlieb, Sushant Pujari, Punit Pathak, Dharmesh ', 'Remo DSouza', 0, 'admin1@gmail.com', 'Dramas'),
	(281, 'https://www.streamua.ddnsking.com/peliculas/ABCD:AnyBodyCanDance', NULL, 'ABCD: Any Body Can Dance', 'Thrown out of the elite dance studio he founded, Vishnus spirits rebound when he sees young street dancers prepping for an annual contest.', 'India', NULL, 'Prabhu Deva, Kay Kay Menon, Ganesh Acharya, Dharmesh Yelande, Salman, Lauren Gottlieb, Noorin Sha, P', 'Remo DSouza', 0, 'admin1@gmail.com', 'Dramas'),
	(282, 'https://www.streamua.ddnsking.com/peliculas/AbdoMota', NULL, 'Abdo Mota', 'Following the mysterious death of his parents, a young man finds himself enmeshed in the dark world of drugs and crime.', 'Egypt', NULL, 'Mohamed Ramadan', '', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(283, 'https://www.streamua.ddnsking.com/peliculas/AbductedinPlainSight', NULL, 'Abducted in Plain Sight', 'In this true crime documentary, a family falls prey to the manipulative charms of a neighbor, who abducts their adolescent daughter. Twice.', 'United States', NULL, '', 'Skye Borgman', 0, 'admin1@gmail.com', 'Documentaries'),
	(284, 'https://www.streamua.ddnsking.com/peliculas/Abdullah,TheFinalWitness', NULL, 'Abdullah, The Final Witness', 'Inspired by real events, this drama follows a trucker jailed after driving five ill-fated travelers across Quetta, and the officer taking on his case.', 'Pakistan', NULL, 'Sajid Hasan, Hameed Sheikh, Habibullah Panezai, Imraan Abbas, Sadia, Imran Tareen, Asal Deen, Yameen', 'Hashim Nadeem Khan', 0, 'admin1@gmail.com', 'Dramas'),
	(285, 'https://www.streamua.ddnsking.com/peliculas/Abhinetri', NULL, 'Abhinetri', 'Due to family pressure, a corporate man reluctantly marries a woman from the village, but in their new home, she abruptly assumes a different persona.', 'India', NULL, 'Tamannaah Bhatia, Prabhu Deva, Sonu Sood, Sapthagiri, Murli Sharma, R.V. Udhaykumar, Joy Mathew, Hem', 'A. L. Vijay', 0, 'admin1@gmail.com', 'Comedies'),
	(286, 'https://www.streamua.ddnsking.com/series/AbnormalSummit', NULL, 'Abnormal Summit', 'Led by a trio of Korean celebs, a multinational panel of men engage in – usually – lighthearted debates on issues that surround Korea and beyond.', 'South Korea', NULL, 'Hyun-moo Jun, Si-kyung Sung, Se-yoon Yoo', 'Jung-ah Im, Seung-uk Jo', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(287, 'https://www.streamua.ddnsking.com/peliculas/AbominableChristmas', NULL, 'Abominable Christmas', 'Two small abominable snowmen flee their mountain to escape a scientist whos trying to capture them and end up spending Christmas with a human family.', 'United States', NULL, 'Isabella Acres, Drake Bell, Emilio Estevez, Nolan Gould, Matthew Lillard, Ray Liotta, Jane Lynch, Ar', 'Chad Van De Keere', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(288, 'https://www.streamua.ddnsking.com/peliculas/AboutaBoy', NULL, 'About a Boy', 'Hip, irresponsible Londoner Will invents an imaginary son and starts attending single-parent meetings to find available women.', 'United Kingdom, Unit', NULL, 'Nicholas Hoult, Toni Collette, Victoria Smurfit, Sharon Small, Natalia Tena, Isabel Brook, Hugh Gran', 'Chris Weitz, Paul Weitz', 0, 'admin1@gmail.com', 'Comedies'),
	(289, 'https://www.streamua.ddnsking.com/peliculas/AboutTime', NULL, 'About Time', 'When Tim learns that the men in his family can travel in time and change their own lives, he decides to go back and win the woman of his dreams.', 'United Kingdom', NULL, 'Domhnall Gleeson, Rachel McAdams, Bill Nighy, Lydia Wilson, Lindsay Duncan, Richard Cordery, Tom Hol', 'Richard Curtis', 0, 'admin1@gmail.com', 'Comedies'),
	(290, 'https://www.streamua.ddnsking.com/series/Abstract:TheArtofDesign', NULL, 'Abstract: The Art of Design', 'Step inside the minds of the most innovative designers in a variety of disciplines and learn how design impacts every aspect of life.', 'United States', NULL, 'Christoph Niemann, Tinker Hatfield, Es Devlin, Bjarke Ingels, Paula Scher, Platon, Ilse Crawford, Ra', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(291, 'https://www.streamua.ddnsking.com/series/AbsurdPlanet', NULL, 'Absurd Planet', 'A cast of quirky critters and Mother Nature herself narrate this funny science series, which peeks into the lives of Earth’s most incredible animals.', 'United States', NULL, 'Afi Ekulona', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(292, 'https://www.streamua.ddnsking.com/series/Abyss', NULL, 'Abyss', 'After meeting an untimely demise in separate incidents, Cha Min and Go Se-yeon discover they’ve come back to life in new bodies they don’t recognize.', 'South Korea', NULL, 'Park Bo-young, Ahn Hyo-seop, Lee Sung-jae, Lee Si-eon, Han So-hee, Kwon Soo-hyun, Kim Sa-rang, Ahn S', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(293, 'https://www.streamua.ddnsking.com/peliculas/Abzurdah', NULL, 'Abzurdah', 'A disenfranchised 16-year-old girl connects to an older man on the internet and after a brief one-sided affair descends into obsession and anorexia.', 'Argentina', NULL, 'Eugenia Suárez, Esteban Lamothe, Gloria Carrá, Rafael Spregelburd, Tomás Ottaviano, Julieta Gullo, Z', 'Daniela Goggi', 0, 'admin1@gmail.com', 'Dramas'),
	(294, 'https://www.streamua.ddnsking.com/peliculas/AcapulcoLavidava', NULL, 'Acapulco La vida va', 'Three lifelong friends travel to Acapulco ostensibly so one of them can find his lost love, but the real reason behind the trip holds some surprises.', 'Mexico', NULL, 'Patricio Castillo, Sergio Bustamante, Alejandro Suárez, Luz María Jerez, Bob Isaacs, Tere Monroy', 'Alfonso Serrano Maturino', 0, 'admin1@gmail.com', 'Comedies'),
	(295, 'https://www.streamua.ddnsking.com/peliculas/Accident', NULL, 'Accident', 'A contract killer skilled at staging lethal accidents fears he may be a victim of his own strategy when an accomplice dies in a mysterious mishap.', 'Hong Kong', NULL, 'Louis Koo, Richie Ren, Stanley Fung Sui-Fan, Michelle Ye, Lam Suet, Alexander Chan, Monica Mok', 'Cheang Pou Soi', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(296, 'https://www.streamua.ddnsking.com/series/AccidentallyinLove', NULL, 'Accidentally in Love', 'Rejecting the demands of her wealthy family, a young woman poses as an ordinary college student and crosses paths with a stoic pop star at school.', 'China', NULL, 'Junchen Guo, Yi Ning Sun, Yi Qin Zhao, Mu Xuan Cheng, Li Ma, Mo Zhou', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(297, 'https://www.streamua.ddnsking.com/peliculas/AcrossGraceAlley', NULL, 'Across Grace Alley', 'A young boy, upset by his parents divorce, becomes infatuated with his grandmothers neighbor, an entrancing dancer he watches through a window.', 'United States', NULL, 'Ben Hyland, Marsha Mason, Karina Smirnoff, Colin Branca, Ralph Macchio, Tricia Paoluccio', 'Ralph Macchio', 0, 'admin1@gmail.com', 'Dramas'),
	(298, 'https://www.streamua.ddnsking.com/peliculas/AcrossTheLine', NULL, 'Across The Line', 'A black high school student sets his sights for the National Hockey League, but rising racial tensions in his community may jeopardize his goals.', 'Canada', NULL, 'Sarah Jeffery, Simon Paul Mutuyimana, Denis Theriault, Jeremiah Sparks, Steven Love, Cara Ricketts, ', 'Julien Christian Lutz', 0, 'admin1@gmail.com', 'Dramas'),
	(299, 'https://www.streamua.ddnsking.com/peliculas/AcrosstheUniverse', NULL, 'Across the Universe', 'An American girl and a British lad fall in love amid the social and political upheaval of the 1960s, in this musical featuring songs by the Beatles.', 'United States, Unite', NULL, 'Evan Rachel Wood, Jim Sturgess, Joe Anderson, Dana Fuchs, Martin Luther, James Urbaniak, T.V. Carpio', 'Julie Taymor', 0, 'admin1@gmail.com', 'Dramas'),
	(300, 'https://www.streamua.ddnsking.com/peliculas/ActofValor', NULL, 'Act of Valor', 'An elite squad of Navy SEALs is tasked with rescuing a kidnapped CIA agent from a lethal terrorist cell.', 'United States', NULL, 'Keo Woolford, Drea Castro, Emilio Rivera, Rorke Denver, Jason Cottle, Ailsa Marshall, Alex Veadov, D', 'Mike McCoy, Scott Waugh', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(301, 'https://www.streamua.ddnsking.com/peliculas/ActofVengeance', NULL, 'Act of Vengeance', 'Two Turkish agents are sent to New York City on a mission to capture a notorious terrorist known only as "Dejjal" (Arabic for Antichrist).', 'Turkey, United State', NULL, 'Haluk Bilginer, Mahsun Kırmızıgül, Mustafa Sandal, Gina Gershon, Robert Patrick, Danny Glover, Engin', 'Mahsun Kırmızıgül', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(302, 'https://www.streamua.ddnsking.com/peliculas/ActionReplayy', NULL, 'Action Replayy', 'Sick of his parents’ constant squabbling, a young man travels back in time to the onset of their romance, with plans to set them up for marital bliss.', 'India', NULL, 'Akshay Kumar, Aishwarya Rai Bachchan, Om Puri, Kiron Kher, Neha Dhupia, Rannvijay Singh, Aditya Roy ', 'Vipul Amrutlal Shah', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(303, 'https://www.streamua.ddnsking.com/peliculas/ActsofVengeance', NULL, 'Acts of Vengeance', 'Devastated by the murder of his wife and child, a formerly fast-talking lawyer takes a vow of silence and trains himself for a mission of revenge.', 'Bulgaria, United Sta', NULL, 'Antonio Banderas, Karl Urban, Paz Vega, Robert Forster, Clint Dyer, Cristina Serafini, Lillian Blank', 'Isaac Florentine', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(304, 'https://www.streamua.ddnsking.com/peliculas/ActsofViolence', NULL, 'Acts of Violence', 'When his future sister-in-law is kidnapped by human traffickers, a military veteran joins forces with his brothers and a world-weary cop to rescue her.', 'Canada', NULL, 'Cole Hauser, Bruce Willis, Shawn Ashmore, Ashton Holmes, Melissa Bolona, Patrick St. Esprit, Sophia ', 'Brett Donowho', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(305, 'https://www.streamua.ddnsking.com/series/AdVitam', NULL, 'Ad Vitam', 'In a future where regeneration technology lets humans live indefinitely, a cop and a troubled young woman investigate a strange wave of youth suicides.', 'France', NULL, 'Yvan Attal, Garance Marillier, Niels Schneider, Victor Assié, Rod Paradot, Anne Azoulay, Adel Benche', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(306, 'https://www.streamua.ddnsking.com/peliculas/Adú', NULL, 'Adú', 'Near a Spanish town in northern Africa, a child takes a painful journey, a father reconnects with his daughter and a coast guard is guilt stricken.', 'Spain', NULL, 'Luis Tosar, Anna Castillo, Álvaro Cervantes, Miquel Fernández, Jesús Carroza, Moustapha Oumarou, Ada', 'Salvador Calvo', 0, 'admin1@gmail.com', 'Dramas'),
	(307, 'https://www.streamua.ddnsking.com/peliculas/AdamDevine:BestTimeofOurLives', NULL, 'Adam Devine: Best Time of Our Lives', 'Frenetic comic Adam Devine talks teen awkwardness, celebrity encounters, his "Pitch Perfect" audition and more in a special from his hometown of Omaha.', 'United States', NULL, 'Adam Devine', 'Jay Karas', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(308, 'https://www.streamua.ddnsking.com/series/AdamRuinsEverything', NULL, 'Adam Ruins Everything', 'Education can be fun – and funny. Comedian Adam Conover bursts misconceptions, deconstructs topics and leaves with positive takeaways.', 'United States', NULL, 'Adam Conover, Adam Lustick, Emily Axford', '', 0, 'admin1@gmail.com', 'TVComedies'),
	(309, 'https://www.streamua.ddnsking.com/peliculas/ADAMSANDLER100%FRESH', NULL, 'ADAM SANDLER 100% FRESH', 'From "Heroes" to "Ice Cream Ladies" – Adam Sandlers comedy special hits you with new songs and jokes in an unexpected, groundbreaking way.', 'United States', NULL, 'Adam Sandler', 'Steve Brill', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(310, 'https://www.streamua.ddnsking.com/peliculas/Adam:HisSongContinues', NULL, 'Adam: His Song Continues', 'After their child was abducted and murdered, John and Reve Walsh fought to raise national awareness of the problem of missing children.', 'United States', NULL, 'Daniel J. Travanti, JoBeth Williams, Richard Masur, Martha Scott, Paul Regina', 'Robert Markowitz', 0, 'admin1@gmail.com', 'Dramas'),
	(311, 'https://www.streamua.ddnsking.com/peliculas/AddictedtoLife', NULL, 'Addicted to Life', 'Chasing extreme challenges, athletic daredevils test their limits in various environments from giant waves to snowy slopes around the world.', 'France', NULL, 'Antoine Bizet, Jesse Richman, Karsten Gefle, Wille Lindberg, Matahi Drollet, Mathias Wyss, Matt Anne', 'Thierry Donard', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(312, 'https://www.streamua.ddnsking.com/peliculas/AdelKaram:LivefromBeirut', NULL, 'Adel Karam: Live from Beirut', 'From Casino du Liban, Lebanese actor and comedian Adel Karam delivers earthy punchlines on kissing norms, colonoscopies and a porn star named Rocco.', 'United States', NULL, 'Adel Karam', '', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(313, 'https://www.streamua.ddnsking.com/peliculas/Adhugo', NULL, 'Adhugo', 'A fast-footed piglet named Bunty becomes an object of desire for rival criminals that want the swift swine for their profitable animal-racing schemes.', 'India', NULL, '', '', 0, 'admin1@gmail.com', 'Comedies'),
	(314, 'https://www.streamua.ddnsking.com/peliculas/AditiMittal:ThingsTheyWouldntLetMeSay', NULL, 'Aditi Mittal: Things They Wouldnt Let Me Say', 'Trailblazing comic Aditi Mittal mixes topical stand-up with frank talk about being single, wearing thongs and the awkwardness of Indian movie ratings.', 'India', NULL, 'Aditi Mittal', 'Fazila Allana', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(315, 'https://www.streamua.ddnsking.com/peliculas/Adore', NULL, 'Adore', 'When lifelong friends Roz and Lil fall in love with each others teenage sons, they must carry out their affairs in relative secrecy.', 'Australia, France', NULL, 'Naomi Watts, Robin Wright, Xavier Samuel, James Frecheville, Ben Mendelsohn, Jessica Tovey, Sophie L', 'Anne Fontaine', 0, 'admin1@gmail.com', 'Dramas'),
	(316, 'https://www.streamua.ddnsking.com/peliculas/Adrift', NULL, 'Adrift', 'A young couple’s sailing adventure becomes a fight to survive when their yacht faces a catastrophic hurricane in this story based on true events.', 'Hong Kong, Iceland, ', NULL, 'Shailene Woodley, Sam Claflin, Jeffrey Thomas, Elizabeth Hawthorne', 'Baltasar Kormákur', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(317, 'https://www.streamua.ddnsking.com/peliculas/Adrishya', NULL, 'Adrishya', 'A family’s harmonious existence is interrupted when the young son begins showing symptoms of anxiety that seem linked to disturbing events at home.', 'India', NULL, 'Ravi Kumar, Ayesha Singh, Nishat Mallick, Archana Kotwal, Rakesh Chaturvedi Om, Nidhi Mahavan, Abhij', 'Sandeep Chatterjee', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(318, 'https://www.streamua.ddnsking.com/peliculas/Advantageous', NULL, 'Advantageous', 'In order to keep her job at a biomedical engineering firm that prizes youth, a middle-aged woman must submit to a drastic experimental procedure.', 'United States', NULL, 'Jacqueline Kim, James Urbaniak, Freya Adams, Ken Jeong, Jennifer Ehle, Samantha Kim, Troi Zee, Olivi', 'Jennifer Phang', 0, 'admin1@gmail.com', 'Dramas'),
	(319, 'https://www.streamua.ddnsking.com/peliculas/AdventuresinPublicSchool', NULL, 'Adventures in Public School', 'After years of home-schooling, an awkward teen decides he wants a public high school experience, but his overbearing mother struggles to let go.', 'Canada, United State', NULL, 'Daniel Doheny, Judy Greer, Siobhan Williams, Russell Peters, Grace Park, Andrew McNee, Alex Barima, ', 'Kyle Rideout', 0, 'admin1@gmail.com', 'Comedies'),
	(320, 'https://www.streamua.ddnsking.com/peliculas/Aerials', NULL, 'Aerials', 'Dubai residents struggle to figure out why a fleet of alien spaceships are hovering over their city when all contact with the outside world is cut off.', 'United Arab Emirates', NULL, 'Saga Alyasery, Ana Druzhynina, Mansour Al Felei, Mohammad Abu Diak, Pascale Matar, Luke Coutts, Abee', 'S.A. Zaidi', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(321, 'https://www.streamua.ddnsking.com/series/Afflicted', NULL, 'Afflicted', 'Baffling symptoms. Controversial diagnoses. Costly treatments. Seven people with chronic illnesses search for answers – and relief.', 'United States', NULL, '', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(322, 'https://www.streamua.ddnsking.com/peliculas/AfonsoPadilha:Classless', NULL, 'Afonso Padilha: Classless', 'Brazilian comedian Afonso Padilha dives into his humble beginnings and digs out hilarious stories about his childhood in this very personal set.', 'Brazil', NULL, 'Afonso Padilha', 'Junior Carelli, Rudge Campos', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(323, 'https://www.streamua.ddnsking.com/series/Africa', NULL, 'Africa', 'This five-part nature series chronicles fascinating stories of survival on the African continent, home to the most diverse animal life on the planet.', 'United Kingdom', NULL, 'David Attenborough', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(324, 'https://www.streamua.ddnsking.com/series/Afronta!FacingIt!', NULL, 'Afronta! Facing It!', 'This docuseries spotlights Afro-Brazilian thinkers sharing their individual journeys and discussing representation, entrepreneurship and community.', 'Brazil', NULL, 'Loo Nascimento, Ingrid Silva, Rincon Sapiência, Batekoo, Gabriel Martins, Benjamin Abras, Daniele Da', 'Juliana Vicente', 0, 'admin1@gmail.com', 'Docuseries'),
	(325, 'https://www.streamua.ddnsking.com/peliculas/After', NULL, 'After', 'Wholesome college freshman Tessa Young thinks she knows what she wants out of life, until she crosses paths with complicated bad boy Hardin Scott.', 'United States', NULL, 'Josephine Langford, Hero Fiennes Tiffin, Selma Blair, Inanna Sarkis, Shane Paul McGhie, Pia Mia, Kha', 'Jenny Gage', 0, 'admin1@gmail.com', 'Dramas'),
	(326, 'https://www.streamua.ddnsking.com/series/AfterLife', NULL, 'After Life', 'Struggling to come to terms with his wifes death, a writer for a newspaper adopts a gruff new persona in an effort to push away those trying to help.', 'United Kingdom', NULL, 'Ricky Gervais, Tom Basden, Tony Way, Diane Morgan, Mandeep Dhillon, David Bradley, Ashley Jensen, Ke', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(327, 'https://www.streamua.ddnsking.com/peliculas/AfterMaria', NULL, 'After Maria', 'Displaced by Hurricane Maria, three Puerto Rican women navigate their families uncertain futures as their federal housing aid in New York expires.', 'United States', NULL, '', 'Nadia Hallgren', 0, 'admin1@gmail.com', 'Documentaries'),
	(328, 'https://www.streamua.ddnsking.com/peliculas/AfterPornEnds', NULL, 'After Porn Ends', 'This documentary explores the careers of some of porns top stars and examines their adjustment to "normal" society after leaving adult entertainment.', 'United States', NULL, '', 'Bryce Wagoner', 0, 'admin1@gmail.com', 'Documentaries'),
	(329, 'https://www.streamua.ddnsking.com/peliculas/AfterPornEnds3', NULL, 'After Porn Ends 3', 'This third installment in a documentary series examines the lives of the adult film genres biggest stars after their industry careers have ended.', 'United States', NULL, '', 'Brittany Andrews', 0, 'admin1@gmail.com', 'Documentaries'),
	(330, 'https://www.streamua.ddnsking.com/peliculas/AftertheRaid', NULL, 'After the Raid', 'A large immigration raid in a small town leaves emotional fallout and hard questions for its churchgoers about what it means to love thy neighbor.', 'United States, Mexic', NULL, '', 'Rodrigo Reyes', 0, 'admin1@gmail.com', 'Documentaries'),
	(331, 'https://www.streamua.ddnsking.com/peliculas/AfterWeCollided', NULL, 'After We Collided', 'Tessa fell hard and fast for Hardin, but after a betrayal tears them apart, she must decide whether to move on — or trust him with a second chance.', 'United States', NULL, 'Josephine Langford, Hero Fiennes Tiffin, Dylan Sprouse, Selma Blair, Louise Lombard, Shane Paul McGh', 'Roger Kumble', 0, 'admin1@gmail.com', 'Dramas'),
	(332, 'https://www.streamua.ddnsking.com/peliculas/Aftermath', NULL, 'Aftermath', 'After an air traffic controllers mistake results in a tragic accident, a man who lost his wife and daughter seeks answers from the man responsible.', 'United Kingdom, Unit', NULL, 'Arnold Schwarzenegger, Scoot McNairy, Maggie Grace, Judah Nelson, Glenn Morshower, Hannah Ware, Mo M', 'Elliott Lester', 0, 'admin1@gmail.com', 'Dramas'),
	(333, 'https://www.streamua.ddnsking.com/peliculas/Afterschool', NULL, 'Afterschool', 'When a prep school loner films two classmates overdosing on cocaine, his footage plays a role in the emotional fallout within the school community.', 'United States', NULL, 'Ezra Miller, Addison Timlin, Jeremy Allen White, Michael Stuhlbarg, Emory Cohen, David Costabile, Ro', 'Antonio Campos', 0, 'admin1@gmail.com', 'Dramas'),
	(334, 'https://www.streamua.ddnsking.com/peliculas/Aftershock', NULL, 'Aftershock', 'An American tourist and his friends are partying in Chile, but a major earthquake devastates the area and forces them to scramble for survival.', 'United States, Chile', NULL, 'Eli Roth, Andrea Osvárt, Ariel Levy, Natasha Yarovenko, Nicolás Martínez, Lorenza Izzo, Marcial Tagl', 'Nicolás López', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(335, 'https://www.streamua.ddnsking.com/series/AgainsttheTide', NULL, 'Against the Tide', 'A detective and a psychologist investigating a string of murders form a crime-solving team with the novelist whose work inspired the killings.', 'Singapore', NULL, 'Christopher Lee, Rui En, Desmond Tan, Zheng Geping, Zhang Zhenhuan, Paige Chua, Xu Bin, Carrie Wong', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(336, 'https://www.streamua.ddnsking.com/peliculas/AgathaandtheTruthofMurder', NULL, 'Agatha and the Truth of Murder', 'In a dramatized depiction of her 11-day disappearance, novelist Agatha Christie solving a real murder amid a crisis in her writing and marriage.', 'United Kingdom', NULL, 'Ruth Bradley, Pippa Haywood, Dean Andrews, Bebe Cave, Blake Harrison, Tim McInnerny, Ralph Ineson, M', 'Terry Loane', 0, 'admin1@gmail.com', 'Dramas'),
	(337, 'https://www.streamua.ddnsking.com/series/AgeGapLove', NULL, 'Age Gap Love', 'Despite the social backlash and challenges that come with intergenerational romance, these couples choose to stick together through thick and thin.', 'United Kingdom', NULL, 'Fay Ripley', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(338, 'https://www.streamua.ddnsking.com/series/AgeofGlory', NULL, 'Age of Glory', 'Amid the thriving nightlife of 1960s Kuala Lumpur, three Chinese friends – a showgirl, her housekeeper and a chanteuse – find love and heartbreak.', '', NULL, 'Debbie Goh, Aenie Wong, Frederick Lee, Leslie Chai', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(339, 'https://www.streamua.ddnsking.com/series/AgeofRebellion', NULL, 'Age of Rebellion', 'At their high school, a group of unruly teens wreak havoc, face bullies and navigate turbulent lives beyond school grounds.', 'Taiwan', NULL, 'Peter Ho, Jeanine Yang, Tammy Chen, Jason Tsou, Chang Ting-hu, Nana Lee, Nien Hsuan Wu', 'Peter Ho', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(340, 'https://www.streamua.ddnsking.com/series/AgeofTanks', NULL, 'Age of Tanks', 'The history of military tanks unfolds in a documentary series that traces their role in history and geopolitics from World War I to the 21st century.', 'Germany, France, Rus', NULL, '', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(341, 'https://www.streamua.ddnsking.com/series/Agent', NULL, 'Agent', 'A former footballer tries to make it as a player agent in the world of African soccer, but a secret from his past threatens to destroy everything.', 'Mauritius, South Afr', NULL, 'Khumbulani Kay Sibiya, Sisanda Henna, Tarynn Wyngaard, Anthony Oseyemi, Virgile Bramly, Manie Malone', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(342, 'https://www.streamua.ddnsking.com/series/AgentRaghav', NULL, 'Agent Raghav', 'A mix of brilliance, erudition and skill enables a modern Sherlock Holmes to solve impossible cases, all while he tries to heal personal wounds.', 'India', NULL, 'Sharad Kelkar, Aahana Kumra, Mahesh Manjrekar, Deepali Pansare, Danish Pandor, Jason Tham, Reena Agg', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(343, 'https://www.streamua.ddnsking.com/series/Aggretsuko', NULL, 'Aggretsuko', 'Frustrated with her thankless office job, Retsuko the Red Panda copes with her daily struggles by belting out death metal karaoke after work.', 'Japan', NULL, 'Kaolip, Komegumi Koiwasaki, Maki Tsuruta, Sohta Arai, Rina Inoue, Shingo Kato, Yuki Takahashi', '', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(344, 'https://www.streamua.ddnsking.com/peliculas/Aggretsuko:WeWishYouaMetalChristmas', NULL, 'Aggretsuko: We Wish You a Metal Christmas', 'While Retsuko desperately makes plans for Christmas Eve, her new obsession with seeking validation through social media spirals out of control.', 'Japan', NULL, 'Kaolip, Shingo Kato, Komegumi Koiwasaki, Maki Tsuruta, Sohta Arai, Rina Inoue, Yuki Takahashi, Rarec', 'Rarecho', 0, 'admin1@gmail.com', 'Movies'),
	(345, 'https://www.streamua.ddnsking.com/peliculas/Agneepath', NULL, 'Agneepath', 'A boy grows up to become a gangster in pursuit of the mobster who killed his innocent father, but revenge and reparation may come at great costs.', 'India', NULL, 'Amitabh Bachchan, Mithun Chakraborty, Danny Denzongpa, Madhavi, Neelam, Alok Nath, Rohini Hattangadi', 'Mukul Anand', 0, 'admin1@gmail.com', 'Dramas'),
	(346, 'https://www.streamua.ddnsking.com/peliculas/AgustínAristarán:SoyRada', NULL, 'Agustín Aristarán: Soy Rada', 'Argentine comedian Agustín "Radagast" Aristarán adds doses of magic, music and acting to his high-energy stand-up routine.', 'Argentina', NULL, 'Agustín Aristarán', 'Mariano Baez', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(347, 'https://www.streamua.ddnsking.com/peliculas/Agyaat', NULL, 'Agyaat', 'A film crew shooting in a remote forested location begins losing members one by one to a mysterious entity that they cannot see or hear.', 'India', NULL, 'Adesh Bhardwaj, Rasika Dugal, Joy Fernandes, Ravi Kale, Ishtiyak Khan, Priyanka Kothari, Kali Prasad', 'Ram Gopal Varma', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(348, 'https://www.streamua.ddnsking.com/peliculas/AhistaAhista', NULL, 'Ahista Ahista', 'Stood up by her groom at the altar, a young woman finds help and healing from another man – until her ex-fiancé returns, hoping to win her back.', 'India', NULL, 'Abhay Deol, Soha Ali Khan, Shayan Munshi, Kamini Khanna, Sohrab Ardeshir, Murad Ali, Shakeel Khan, N', 'Shivam Nair', 0, 'admin1@gmail.com', 'Dramas'),
	(349, 'https://www.streamua.ddnsking.com/peliculas/AiWeiwei:NeverSorry', NULL, 'Ai Weiwei: Never Sorry', 'Chinese artist and activist Ai Weiwei uses social media and art to inspire protests and suffers government persecution for his actions.', 'United States', NULL, 'Ai Weiwei, Lao Ai', 'Alison Klayman', 0, 'admin1@gmail.com', 'Documentaries'),
	(350, 'https://www.streamua.ddnsking.com/series/AinoriLoveWagon:AfricanJourney', NULL, 'Ainori Love Wagon: African Journey', 'To find love, seven strangers leave Japan and embark on a journey through the continent of Africa together. Challenges, adventure and romance await!', 'Japan', NULL, 'Becky, Ryo Kato, Karina Maruyama, Kohei Takeda', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(351, 'https://www.streamua.ddnsking.com/series/AinoriLoveWagon:AsianJourney', NULL, 'Ainori Love Wagon: Asian Journey', 'Seven men and women board a pink bus in search of true love. On a journey through Asia with strangers, their goal is to return to Japan as a couple.', 'Japan', NULL, 'Becky, Audrey, Mayuko Kawakita, Shimon Okura', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(352, 'https://www.streamua.ddnsking.com/series/AinsleyEatstheStreets', NULL, 'Ainsley Eats the Streets', 'Celebrity chef Ainsley Harriott embarks on a journey around the world to explore the relationship between local street foods and cultural identity.', 'United Kingdom', NULL, 'Ainsley Harriott', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(353, 'https://www.streamua.ddnsking.com/peliculas/AinuMosir', NULL, 'Ainu Mosir', 'A sensitive Ainu teen searches for a spiritual connection with his recently deceased dad while navigating his indigenous identity in a changing world.', 'United States, Japan', NULL, 'Kanto Shimokura, Debo Akibe, Emi Shimokura, Toko Miura, Lily Franky', 'Takeshi Fukunaga', 0, 'admin1@gmail.com', 'Dramas'),
	(354, 'https://www.streamua.ddnsking.com/peliculas/AirplaneMode', NULL, 'Airplane Mode', 'When Ana, an influencer, crashes her car while talking on the phone, she’s shipped to her grumpy grandfathers farm – and forced into a digital detox.', 'United States', NULL, 'Larissa Manoela, André Luiz Frambach, Erasmo Carlos, Mariana Amâncio, Amanda Orestes, Eike Duarte, N', 'César Rodrigues', 0, 'admin1@gmail.com', 'Comedies'),
	(355, 'https://www.streamua.ddnsking.com/peliculas/AisaYehJahaan', NULL, 'Aisa Yeh Jahaan', 'During a vacation with her parents, away from her concrete urban existence, a young girl learns to appreciate the joys of connecting with nature.', 'India', NULL, 'Palash Sen, Ira Dubey, Yashpal Sharma, Tinnu Anand, Prisha Dabbas, Kymsleen Kholie, Satish Sharma', 'Biswajeet Bora', 0, 'admin1@gmail.com', 'Dramas'),
	(356, 'https://www.streamua.ddnsking.com/peliculas/Aitraaz', NULL, 'Aitraaz', 'A happily married business executive is forced to deal with an episode from his past that he had long thought was put behind him.', 'India', NULL, 'Akshay Kumar, Kareena Kapoor, Priyanka Chopra, Amrish Puri, Paresh Rawal, Annu Kapoor', 'Abbas Alibhai Burmawalla, Mastan Alibhai Burmawall', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(357, 'https://www.streamua.ddnsking.com/peliculas/Aiyaary', NULL, 'Aiyaary', 'When his protégé goes rogue and poses a grave threat to the government he serves, a veteran officer of the Indian Army tries to stop him at all costs.', 'India', NULL, 'Sidharth Malhotra, Manoj Bajpayee, Rakul Preet Singh, Pooja Chopra, Adil Hussain, Kumud Mishra, Nase', 'Neeraj Pandey', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(358, 'https://www.streamua.ddnsking.com/peliculas/Aiyyaa', NULL, 'Aiyyaa', 'An outspoken, imaginative girl from a conservative family pursues her dream man while fending off the prospect of an arranged marriage.', 'India', NULL, 'Rani Mukerji, Prithviraj Sukumaran, Nirmiti Sawant, Subodh Bhave, Jyoti Subhash, Satish Alekar, Anit', 'Sachin Kundalkar', 0, 'admin1@gmail.com', 'Comedies'),
	(359, 'https://www.streamua.ddnsking.com/series/AJandtheQueen', NULL, 'AJ and the Queen', 'While traveling across the country in a run-down RV, drag queen Ruby Red discovers an unlikely sidekick in AJ: a tough-talking 10-year-old stowaway.', 'United States', NULL, 'RuPaul Charles, Izzy G., Michael-Leon Wooley, Josh Segarra, Katerina Tannenbaum, Tia Carrere', '', 0, 'admin1@gmail.com', 'TVComedies'),
	(360, 'https://www.streamua.ddnsking.com/peliculas/AjabPremKiGhazabKahani', NULL, 'Ajab Prem Ki Ghazab Kahani', 'A young mans obsession with making others happy drives him to help the girl he loves marry someone else, then try to win her heart.', 'India', NULL, 'Ranbir Kapoor, Katrina Kaif, Govind Namdeo, Darshan Jariwala, Zakir Hussain, Smita Jaykar, Navneet N', 'Rajkumar Santoshi', 0, 'admin1@gmail.com', 'Comedies'),
	(361, 'https://www.streamua.ddnsking.com/series/AjaibnyaCinta', NULL, 'Ajaibnya Cinta', 'Upon returning home from his studies abroad, young grad Akif finds himself involved with four women in this continuation of the series "Spain Uoolss."', '', NULL, '', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(362, 'https://www.streamua.ddnsking.com/series/AJIN:Demi-Human', NULL, 'AJIN: Demi-Human', 'A teenager discovers that he is an Ajin and flees before the authorities experiment on him. Other Ajin plan to fight back and he must choose a side.', 'Japan', NULL, 'Mamoru Miyano, Yoshimasa Hosoya, Jun Fukuyama, Hochu Otsuka, Daisuke Hirakawa, Takahiro Sakurai, Mik', '', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(363, 'https://www.streamua.ddnsking.com/peliculas/Ajji', NULL, 'Ajji', 'When her small granddaughter is sexually assaulted by a powerful man and no justice is served, a poor, frail old woman plots her violent revenge.', 'India', NULL, 'Sushama Deshpande, Abhishek Banerjee, Smita Tambe, Sharvani Suryavanshi, Vikas Kumar, Sadiya Siddiqu', 'Devashish Makhija', 0, 'admin1@gmail.com', 'Dramas'),
	(364, 'https://www.streamua.ddnsking.com/peliculas/AKvsAK', NULL, 'AK vs AK', 'After a public spat with a movie star, a disgraced director retaliates by kidnapping the actor’s daughter, filming the search for her in real time.', 'India', NULL, 'Anil Kapoor, Anurag Kashyap', 'Vikramaditya Motwane', 0, 'admin1@gmail.com', 'Comedies'),
	(365, 'https://www.streamua.ddnsking.com/series/AkamegaKill!', NULL, 'Akame ga Kill!', 'Tatsumi sets out on a journey to help his poor village. When hes rescued by a band of assassins, he joins their fight against the corrupt government.', 'Japan', NULL, 'Sora Amamiya, Soma Saito, Yukari Tamura, Yuu Asakawa, Mamiko Noto, Yoshitsugu Matsuoka, Katsuyuki Ko', '', 0, 'admin1@gmail.com', 'AnimeSeries'),
	(367, 'https://www.streamua.ddnsking.com/series/AkulahBalqis', NULL, 'Akulah Balqis', 'A little girl must enter an orphanage after her parents are arrested, but her life takes a dramatic turn when she escapes and meets a model.', '', NULL, 'Puteri Balqis, Aeril Zafrel, Nabila Huda, Nazim Othman, Nadia Brian, Bella Dally', 'Pali Yahya', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(368, 'https://www.streamua.ddnsking.com/peliculas/Alacecho', NULL, 'Al acecho', 'Looking for a fresh start, a park ranger gets a new assignment. When he discovers a network of poachers, survival depends on his lethal instincts.', '', NULL, 'Rodrigo de la Serna, Belen Blanco, Walter Jakob, Facundo Aquinos, Patricia Calisaya', 'Francisco DEufemia', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(369, 'https://www.streamua.ddnsking.com/series/AlHayba', NULL, 'Al Hayba', 'In a village by the Lebanon-Syria border, the head of an arms-smuggling clan contends with family conflicts, power struggles and complicated love.', 'Lebanon', NULL, 'Taim Hasan, Nadine Nassib Njeim, Abdo Chahine, Oweiss Mkhallalati, Mona Wassef', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(370, 'https://www.streamua.ddnsking.com/peliculas/AlaVaikunthapurramuloo', NULL, 'Ala Vaikunthapurramuloo', 'After growing up enduring criticism from his father, a young man finds his world shaken upon learning he was switched at birth with a millionaire’s son.', 'India', NULL, 'Allu Arjun, Pooja Hegde, Tabu, Sushanth, Nivetha Pethuraj, Jayaram, Murli Sharma', 'Trivikram Srinivas', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(371, 'https://www.streamua.ddnsking.com/peliculas/AlakadaReloaded', NULL, 'Alakada Reloaded', 'To cope with her feelings of inferiority, a woman from an impoverished family tells tall tales of her wealth and influence to upgrade her social status.', '', NULL, 'Kehinde Bankole, Lilian Esoro, Bolaji Amusan, Toyin Abraham, Gabriel Afolayan, Bidemi Kosoko, Wumi T', 'Toyin Abraham', 0, 'admin1@gmail.com', 'Comedies'),
	(372, 'https://www.streamua.ddnsking.com/peliculas/AlanSaldaña:Mividadepobre', NULL, 'Alan Saldaña: Mi vida de pobre', 'Mexican comic Alan Saldaña has fun with everything from the pressure of sitting in an exit row to maxing out his credit card in this stand-up special.', 'Mexico', NULL, 'Alan Saldaña', 'Raúl Campos, Jan Suter', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(373, 'https://www.streamua.ddnsking.com/peliculas/AlarmotyintheLandofFire', NULL, 'Alarmoty in the Land of Fire', 'While vacationing at a resort, an ornery and outspoken man is held captive by a criminal organization.', 'Egypt', NULL, '', '', 0, 'admin1@gmail.com', 'Comedies'),
	(374, 'https://www.streamua.ddnsking.com/peliculas/AlaskaIsaDrag', NULL, 'Alaska Is a Drag', 'Tormented by bullies, an aspiring drag star working at an Alaskan cannery becomes a skilled fighter and is tapped for competition by a boxing coach.', 'United States', NULL, 'Martin L. Washington Jr., Maya Washington, Matt Dallas, Christopher OShea, Jason Scott Lee, Margaret', 'Shaz Bennett', 0, 'admin1@gmail.com', 'Dramas'),
	(375, 'https://www.streamua.ddnsking.com/peliculas/AlbertPintoKoGussaKyunAataHai?', NULL, 'Albert Pinto Ko Gussa Kyun Aata Hai?', 'As the police investigate his disappearance, a young man heads to Goa to carry out an act of vengeance fueled by years of pent-up anger toward society.', 'India', NULL, 'Nandita Das, Manav Kaul, Saurabh Shukla, Kishore Kadam, Omkar Das Manikpuri, Amarjeet Amle, Yusuf Hu', 'Soumitra Ranade', 0, 'admin1@gmail.com', 'Dramas'),
	(376, 'https://www.streamua.ddnsking.com/peliculas/Albion:TheEnchantedStallion', NULL, 'Albion: The Enchanted Stallion', 'After a magical horse transports her to a fantasy world ruled by an evil general, a brave girl sets out to save the land once and for all.', 'United States, Bulga', NULL, 'Daniel Sharman, Jennifer Morrison, Debra Messing, Stephen Dorff, John Cleese, Liam McIntyre, Richard', 'Castille Landon', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(377, 'https://www.streamua.ddnsking.com/peliculas/AlejandroRiaño:Especialdestandup', NULL, 'Alejandro Riaño: Especial de stand up', 'Colombian comedian Alejandro Riaño discusses the perks of dating a she-wolf, styles of dancing, the quirks of Bogotá men and soccer game announcers.', 'Colombia', NULL, 'Alejandro Riaño', '', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(378, 'https://www.streamua.ddnsking.com/peliculas/AlejandroSanz:WhatIWasIsWhatIAm', NULL, 'Alejandro Sanz: What I Was Is What I Am', 'A retrospective look at the life and career of Grammy-award winning Spanish musician Alejandro Sanz.', 'Spain', NULL, 'Alejandro Sanz', 'Gervasio Iglesias, Alexis Morante', 0, 'admin1@gmail.com', 'Documentaries'),
	(379, 'https://www.streamua.ddnsking.com/peliculas/Alelí', NULL, 'Alelí', 'Mourning their fathers death, a dysfunctional trio of siblings must face selling their beloved childhood beach house — and dealing with each other.', 'Uruguay, Argentina', NULL, 'Néstor Guzzini, Mirella Pascual, Cristina Morán, Romina Peluffo, Laila Reyes Silberberg, Pablo Tate,', 'Leticia Jorge Romero', 0, 'admin1@gmail.com', 'Comedies'),
	(380, 'https://www.streamua.ddnsking.com/peliculas/AlexFernández:TheBestComedianintheWorld', NULL, 'Alex Fernández: The Best Comedian in the World', 'Comic Alex Fernández performs his familiar autobiographical stories but goes a little deeper this time with a tender tale about one of his six siblings.', 'Mexico', NULL, 'Alex Fernández', 'Alex Díaz', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(381, 'https://www.streamua.ddnsking.com/peliculas/AlexStrangelove', NULL, 'Alex Strangelove', 'High school senior Alex Trueloves plan to lose his virginity to lovable girlfriend Claire goes awry when he meets the equally lovable Elliot.', 'United States', NULL, 'Daniel Doheny, Madeline Weinstein, Antonio Marziale, Daniel Zolghadri, Annie Q., Nik Dodani, Fred He', 'Craig Johnson', 0, 'admin1@gmail.com', 'Comedies'),
	(383, 'https://www.streamua.ddnsking.com/peliculas/Alexandria...Why?', NULL, 'Alexandria ... Why?', 'Living in Alexandria during World War II, an Egyptian teen enamored with American films dreams of making it in Hollywood.', 'Egypt, Algeria', NULL, 'Naglaa Fathi, Farid Shawqy, Mohsen Mohiedine, Ezzat El Alaili, Abdalla Mahmoud, Youssef Wahby, Yehia', 'Youssef Chahine', 0, 'admin1@gmail.com', 'ClassicMovies'),
	(384, 'https://www.streamua.ddnsking.com/peliculas/Alexandria:AgainandForever', NULL, 'Alexandria: Again and Forever', 'At the peak of his career, Yehia joins a hunger strike, becomes smitten and reckons with a creative crisis — but finds a new muse.', 'France, Egypt', NULL, 'Youssef Chahine, Yousra, Hussein Fahmy, Amr Abdel-Geleel, Taheya Cariocca, Hesham Selim, Huda Sultan', 'Youssef Chahine', 0, 'admin1@gmail.com', 'ClassicMovies'),
	(385, 'https://www.streamua.ddnsking.com/peliculas/AlexisViera:AStoryofSurviving', NULL, 'Alexis Viera: A Story of Surviving', 'After being shot during a robbery in Colombia and losing sensation in his legs, Uruguayan soccer star Alexis Viera finds a new sense of purpose.', 'Uruguay', NULL, 'Alexis Viera', 'Luis Ara', 0, 'admin1@gmail.com', 'Documentaries'),
	(386, 'https://www.streamua.ddnsking.com/peliculas/Ali&Alia', NULL, 'Ali & Alia', 'Drugs and addiction endanger the love — and lives — of two childhood sweethearts struggling to survive the perils of a precarious world.', 'United Arab Emirates', NULL, 'Khalifa Albhri, Neven Madi, Talal Mahmood, Sawsan Saad, Fatma Hassan', 'Hussein El Ansary', 0, 'admin1@gmail.com', 'Dramas'),
	(387, 'https://www.streamua.ddnsking.com/peliculas/AliBabave7Cüceler', NULL, 'Ali Baba ve 7 Cüceler', 'A garden gnome vendor and his brother-in-law attend a trade fair in Sofia, where they accidentally stumble into shenanigans involving a mafia boss.', 'Turkey', NULL, 'Cem Yılmaz, Irina Ivkina, Çetin Altay, Zafer Algöz, Can Yılmaz, Bahtiyar Engin, Fevzi Gökçe, Yosi Mi', 'Cem Yılmaz', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(388, 'https://www.streamua.ddnsking.com/peliculas/AliWong:BabyCobra', NULL, 'Ali Wong: Baby Cobra', 'Ali Wongs stand up special delves into her sexual adventures, hoarding, the rocky road to pregnancy, and why feminism is terrible.', 'United States', NULL, 'Ali Wong', 'Jay Karas', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(389, 'https://www.streamua.ddnsking.com/peliculas/AliWong:HardKnockWife', NULL, 'Ali Wong: Hard Knock Wife', 'Two years after the hit "Baby Cobra," Ali Wong is back with another baby bump – and a torrent of hilarious truths about marriage and motherhood.', 'United States', NULL, 'Ali Wong', 'Jay Karas', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(390, 'https://www.streamua.ddnsking.com/peliculas/AlisWedding', NULL, 'Alis Wedding', 'After telling a white lie that spins out of control, the son of an Iraqi-born cleric in Melbourne becomes torn between family duty and his own heart.', 'Australia', NULL, 'Osamah Sami, Don Hany, Helana Sawires, Frances Duca, Majid Shokor, Rodney Afif, Ghazi Alkinani, Ryan', 'Jeffrey Walker', 0, 'admin1@gmail.com', 'Comedies'),
	(391, 'https://www.streamua.ddnsking.com/series/AliasGrace', NULL, 'Alias Grace', 'In 19th-century Canada, a psychiatrist weighs whether a murderess should be pardoned due to insanity. Based on Margaret Atwoods award-winning novel.', 'Canada', NULL, 'Sarah Gadon, Edward Holcroft, Paul Gross, Anna Paquin, Rebecca Liddiard, Zachary Levi, Kerr Logan, D', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(392, 'https://www.streamua.ddnsking.com/peliculas/AliasJJ,lacelebridaddelmal', NULL, 'Alias JJ, la celebridad del mal', 'Witnesses and public figures respond to controversial claims about Pablo Escobar made by the Medellín Cartels sole survivor, John Jairo Velásquez.', '', NULL, '', '', 0, 'admin1@gmail.com', 'Documentaries'),
	(393, 'https://www.streamua.ddnsking.com/peliculas/AlibabaAur40Chor', NULL, 'Alibaba Aur 40 Chor', 'A simple village man is thrown into a web of political intrigue after he takes on a powerful and ruthless gang of bandits.', 'Soviet Union, India', NULL, 'Dharmendra, Hema Malini, Zeenat Aman, Rolan Bykov, Prem Chopra, Yakub Akhmedov, Madan Puri, Sofiko C', 'Latif Faiziyev, Umesh Mehra', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(394, 'https://www.streamua.ddnsking.com/peliculas/AliceDoesntLiveHereAnymore', NULL, 'Alice Doesnt Live Here Anymore', 'A widowed singer and single mother starts over as a diner waitress in Arizona, befriending her coworkers and romancing a ruggedly handsome rancher.', 'United States', NULL, 'Ellen Burstyn, Kris Kristofferson, Billy Green Bush, Diane Ladd, Harvey Keitel, Lelia Goldoni, Lane ', 'Martin Scorsese', 0, 'admin1@gmail.com', 'ClassicMovies'),
	(395, 'https://www.streamua.ddnsking.com/series/AliceinBorderland', NULL, 'Alice in Borderland', 'An aimless gamer and his two friends find themselves in a parallel Tokyo, where theyre forced to compete in a series of sadistic games to survive.', 'Japan', NULL, 'Kento Yamazaki, Tao Tsuchiya, Nijiro Murakami, Yuki Morinaga, Keita Machida, Ayaka Miyoshi, Dori Sak', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(396, 'https://www.streamua.ddnsking.com/peliculas/AliceJunior', NULL, 'Alice Junior', 'In a small town, a trans teen with a vibrant personality shakes up her high schools conservative ways while trying to secure her first kiss.', 'Brazil', NULL, 'Anne Celestino Mota, Emmanuel Rosset, Matheus Moura, Surya Amitrano, Thaís Schier, Cida Rolim, Katia', 'Gil Baroni', 0, 'admin1@gmail.com', 'Comedies'),
	(397, 'https://www.streamua.ddnsking.com/peliculas/AlienContact:OuterSpace', NULL, 'Alien Contact: Outer Space', 'This fact-based account delves into humankinds efforts to gather signals from possible intelligent beings beyond the solar system.', 'United States', NULL, 'J. Michael Long', 'J. Michael Long', 0, 'admin1@gmail.com', 'Documentaries'),
	(399, 'https://www.streamua.ddnsking.com/peliculas/AlienWarfare', NULL, 'Alien Warfare', 'The U.S. Navy Seal team tackles a top-secret mission at a research center where scientists have mysteriously disappeared and another life form awaits.', 'United States', NULL, 'Clayton Snyder, David Meadows, Daniel Washington, Scott C. Roe, Larissa Andrade, Sal Rendino, Jose G', 'Jeremiah Jones', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(400, 'https://www.streamua.ddnsking.com/series/AlienWorlds', NULL, 'Alien Worlds', 'Applying the laws of life on Earth to the rest of the galaxy, this series blends science fact and fiction to imagine alien life on other planets.', 'United Kingdom', NULL, '', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(401, 'https://www.streamua.ddnsking.com/peliculas/AlienXmas', NULL, 'Alien Xmas', 'A young elf mistakes a tiny alien for a Christmas gift, not knowing her new plaything has plans to destroy Earths gravity — and steal all the presents.', 'United States', NULL, 'Keythe Farley, Dee Bradley Baker, Kaliayh Rhambo, Michelle Deco, Barbara Goodson', 'Stephen Chiodo', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(402, 'https://www.streamua.ddnsking.com/peliculas/AliensAteMyHomework', NULL, 'Aliens Ate My Homework', 'Tiny alien lawmen fly into Rods bedroom and recruit him into helping them stop an intergalactic criminal – whos disguised as a very familiar human.', 'United States', NULL, 'William Shatner, Dan Payne, Kirsten Robek, Ty Consiglio, Sean McNamara, Christian Convery, Jayden Gr', 'Sean McNamara', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(403, 'https://www.streamua.ddnsking.com/peliculas/AliveandKicking', NULL, 'Alive and Kicking', 'Take an inside look at swing dancings continued prosperity and the lively and joyous personalities that make the art form so unique.', 'Sweden, United State', NULL, '', 'Susan Glatzer', 0, 'admin1@gmail.com', 'Documentaries'),
	(404, 'https://www.streamua.ddnsking.com/peliculas/AllAboutLove', NULL, 'All About Love', 'An inseparable couple struggles to stay together when betrayal threatens to tear their lives apart.', 'South Africa', NULL, 'Chris Attoh, Katlego Danke, Enyinna Nwigwe, Nomzamo Mbatha, Richard Lukunku, Zenande Mfenyane, Leroy', 'Adze Ugah', 0, 'admin1@gmail.com', 'Dramas'),
	(405, 'https://www.streamua.ddnsking.com/peliculas/AllAboutNina', NULL, 'All About Nina', 'Fearless provocation has fueled stand-up comic Nina Gelds career, but a move to LA and a new love take her to new levels of honesty.', 'United States', NULL, 'Mary Elizabeth Winstead, Common, Kate del Castillo, Chace Crawford, Jay Mohr, Beau Bridges, Clea DuV', 'Eva Vives', 0, 'admin1@gmail.com', 'Comedies'),
	(406, 'https://www.streamua.ddnsking.com/series/AllAbouttheWashingtons', NULL, 'All About the Washingtons', 'Hip-hop icon MC Joe Speed retires from showbiz and finds a new rhythm balancing business, romance and everyday family chaos.', 'United States', NULL, 'Joseph Simmons, Justine Simmons, Kiana Ledé, Nathan Anderson, Leah Rose Randall, Maceo Smedley, Quin', '', 0, 'admin1@gmail.com', 'TVComedies'),
	(407, 'https://www.streamua.ddnsking.com/series/AllAmerican', NULL, 'All American', 'Culture clashes and brewing rivalries test a teen football player from South Los Angeles when he’s recruited to the Beverly Hills High School team.', 'United States', NULL, 'Daniel Ezra, Taye Diggs, Samantha Logan, Bre-Z, Greta Onieogou, Monet Mazur, Michael Evans Behling, ', '', 0, 'admin1@gmail.com', 'TVDramas'),
	(408, 'https://www.streamua.ddnsking.com/peliculas/AllBecauseofYou', NULL, 'All Because of You', 'After falling for a guest, an unsuspecting hotel staff becomes embroiled in a hostage scheme and discovers true love in an unlikely place.', 'Malaysia', NULL, 'Hairul Azreen, Janna Nick, Amerul Affendi, Henley Hii, Nam Ron, Theebaan Govindasamy, Taufiq Hanafi,', 'Adrian Teh', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(409, 'https://www.streamua.ddnsking.com/peliculas/AllDayandaNight', NULL, 'All Day and a Night', 'While serving life in prison, a young man looks back at the people, the circumstances and the system that set him on the path toward his crime.', 'United States', NULL, 'Jeffrey Wright, Ashton Sanders, Regina Taylor, Yahya Abdul-Mateen II, Isaiah John, Kelly Jenrette, S', 'Joe Robert Cole', 0, 'admin1@gmail.com', 'Dramas'),
	(410, 'https://www.streamua.ddnsking.com/peliculas/AllDogsGotoHeaven', NULL, 'All Dogs Go to Heaven', 'When a canine con artist becomes an angel, he sneaks back to Earth and crosses paths with an orphan girl who can speak to animals.', 'Ireland, United King', NULL, 'Dom DeLuise, Burt Reynolds, Daryl Gilley, Candy Devine, Charles Nelson Reilly, Vic Tayback, Melba Mo', 'Don Bluth, Gary Goldman, Dan Kuenster', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(411, 'https://www.streamua.ddnsking.com/series/AllForLove', NULL, 'All For Love', 'A penniless country boy goes in search of his runaway sister in Bogotá, where he falls for an aspiring singer, but gets tangled up in organized crime.', 'Colombia', NULL, 'Ana María Estupiñán, Carlos Torres, Yuri Vargas, Jim Muñoz, Julio Sánchez Cóccaro, Alina Lozano, Val', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(412, 'https://www.streamua.ddnsking.com/peliculas/AllGoodOnesGetAway', NULL, 'All Good Ones Get Away', 'When a mysterious figure blackmails an adulterous couple during a romantic getaway, their secret affair turns into a fight for survival.', 'Spain, Italy', NULL, 'Claire Forlani, Jake Abel, Titus Welliver, Melina Matthews', 'Víctor García', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(415, 'https://www.streamua.ddnsking.com/peliculas/AllHallowsEve', NULL, 'All Hallows Eve', 'Instead of summoning the spirit of her dearly departed mother, a charming teen accidentally awakens a vengeful witch who wants to destroy her town.', 'United States', NULL, 'Lexi Giovagnoli, Ashley Argota, John DeLuca, Diane Salinger, Martin Klebba, Tracey Gold, Dee Wallace', 'Charlie Vaughn', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(416, 'https://www.streamua.ddnsking.com/peliculas/AllInMyFamily', NULL, 'All In My Family', 'After starting a family of his very own in America, a gay filmmaker documents his loving, traditional Chinese familys process of acceptance.', 'United States', NULL, '', 'Hao Wu', 0, 'admin1@gmail.com', 'Documentaries'),
	(417, 'https://www.streamua.ddnsking.com/peliculas/AllLightWillEnd', NULL, 'All Light Will End', 'A horror novelist with a traumatic past returns to her childhood hometown, where she revisits her night terrors and loses sight of reality.', 'United States', NULL, 'Ashley Pereira, Alexandra Harris, Ted Welch, Sam Jones III, Sarah Butler, Andy Buckley, Graham Outer', 'Chris Blake', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(418, 'https://www.streamua.ddnsking.com/peliculas/AllofYou', NULL, 'All of You', 'Two strangers meet on a dating app and experience instant chemistry, but their relationship unravels as jarring differences catch up to them.', 'Philippines', NULL, 'Jennylyn Mercado, Derek Ramsay, Yayo Aguila, Kean Cipriano, Nico Antonio, Enzo Marcos, Via Antonio, ', 'Dan Villegas', 0, 'admin1@gmail.com', 'Comedies'),
	(419, 'https://www.streamua.ddnsking.com/peliculas/AlltheBoysLoveMandyLane', NULL, 'All the Boys Love Mandy Lane', 'During a weekend excursion to a secluded ranch, an unwelcome visitor begins picking off the randy admirers of teenage temptress Mandy Lane.', 'United States', NULL, 'Anson Mount, Edwin Hodge, Michael Welch, Brooke Bloom, Amber Heard, Aaron Himelstein, Whitney Able, ', 'Jonathan Levine', 0, 'admin1@gmail.com', 'HorrorMovies'),
	(420, 'https://www.streamua.ddnsking.com/peliculas/AllTheBrightPlaces', NULL, 'All The Bright Places', 'Two teens facing personal struggles form a powerful bond as they embark on a cathartic journey chronicling the wonders of Indiana.', 'United States', NULL, 'Elle Fanning, Justice Smith, Luke Wilson, Keegan-Michael Key, Alexandra Shipp, Lamar Johnson, Virgin', 'Brett Haley', 0, 'admin1@gmail.com', 'Dramas'),
	(421, 'https://www.streamua.ddnsking.com/peliculas/AlltheDevilsMen', NULL, 'All the Devils Men', 'A battle-scarred Special Ops military vet joins a CIA-funded assignment to take down a Russian terrorist and his trigger-happy comrades.', 'United Kingdom', NULL, 'Milo Gibson, Sylvia Hoeks, Gbenga Akinnagbe, William Fichtner, Joseph Millson, Elliot Cowan, Perry F', 'Matthew Hope', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(422, 'https://www.streamua.ddnsking.com/peliculas/AlltheFrecklesintheWorld', NULL, 'All the Freckles in the World', 'Thirteen-year-old José Miguel is immune to 1994 World Cup fever until he realizes soccer is the only way to win the heart of his crush.', 'Mexico', NULL, 'Hánssel Casillas, Loreto Peralta, Andrea Sutton, Luis De La Rosa, Alejandro Flores, Anajosé Aldrete,', 'Yibrán Asuad', 0, 'admin1@gmail.com', 'Comedies'),
	(423, 'https://www.streamua.ddnsking.com/peliculas/AllTheReasonsToForget', NULL, 'All The Reasons To Forget', 'A Brazilian man tries a myriad of ways to get over his breakup with his girlfriend but is surprised to learn its more difficult than he anticipated.', 'Brazil', NULL, 'Johnny Massaro, Bianca Comparato, Regina Braga, Maria Laura Nogueira, Victor Mendes, Thiago Amaral, ', 'Pedro Coutinho', 0, 'admin1@gmail.com', 'Comedies'),
	(424, 'https://www.streamua.ddnsking.com/peliculas/AllTogetherNow', NULL, 'All Together Now', 'An optimistic, talented teen clings to a huge secret: Shes homeless and living on a bus. When tragedy strikes, can she learn to accept a helping hand?', 'United States', NULL, 'Aulii Cravalho, Justina Machado, Rhenzy Feliz, Fred Armisen, Carol Burnett, Judy Reyes, Taylor Richa', 'Brett Haley', 0, 'admin1@gmail.com', 'Dramas'),
	(425, 'https://www.streamua.ddnsking.com/peliculas/AllsWell,EndsWell(2009)', NULL, 'Alls Well, Ends Well (2009)', 'Bound by a family rule that forbids him from marrying until his stubborn sister gets hitched, a bachelor enlists the help of a love guru to woo her.', 'Hong Kong', NULL, 'Louis Koo, Sandra Ng Kwan Yue, Raymond Wong, Ronald Cheng, Yao Chen, Guo Tao, Heung Kam Lee, Chun Ch', 'Vincent Kok', 0, 'admin1@gmail.com', 'Comedies'),
	(426, 'https://www.streamua.ddnsking.com/peliculas/Allesistgut', NULL, 'Alles ist gut', 'A woman sexually assaulted by her new bosss brother-in-law tries to move on as if nothing happened, but the night weighs heavily on her mind and body.', 'Germany', NULL, 'Aenne Schwarz, Andreas Döhler, Hans Löw, Tilo Nest, Lina Wendel, Lisa Hagmeister', 'Eva Trobisch', 0, 'admin1@gmail.com', 'Dramas'),
	(427, 'https://www.streamua.ddnsking.com/peliculas/AllIWish', NULL, 'AllI Wish', 'Over a series of birthdays, a happy-go-lucky, commitment-averse fashion designer strives to bring a bit of calm to her chaotic love life.', 'United States', NULL, 'Sharon Stone, Tony Goldwyn, Liza Lapira, Ellen Burstyn, Jason Gibson, Famke Janssen, Caitlin Fitzger', 'Susan Walter', 0, 'admin1@gmail.com', 'Dramas'),
	(428, 'https://www.streamua.ddnsking.com/series/AlmostHappy', NULL, 'Almost Happy', 'Sebastián is a radio show host of modest fame, trying to find a way in the world as he deals with his ex-wife (whom he still loves) and two kids.', 'Argentina', NULL, 'Sebastián Wainraich, Natalie Pérez, Santiago Korovsky', 'Hernán Guerschuny', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(429, 'https://www.streamua.ddnsking.com/peliculas/AlmostLove', NULL, 'Almost Love', 'A close crew of striving New Yorkers experiences both joy and heartache in their romantic and professional lives.', 'United States', NULL, 'Scott Evans, Augustus Prew, Kate Walsh, Michelle Buteau, Zoë Chao, Patricia Clarkson, Colin Donnell,', 'Mike Doyle', 0, 'admin1@gmail.com', 'Comedies'),
	(430, 'https://www.streamua.ddnsking.com/series/Alone', NULL, 'Alone', 'Equipped with limited resources, an isolated group of individuals is subjected to the harsh conditions of the wilderness and must survive — or tap out.', '', NULL, '', '', 0, 'admin1@gmail.com', 'RealityTV'),
	(431, 'https://www.streamua.ddnsking.com/peliculas/AloneinBerlin', NULL, 'Alone in Berlin', 'After learning of their sons death on the battlefield, a grieving Berlin couple embark on a quietly dangerous act of resistance against Adolf Hitler.', 'United Kingdom, Fran', NULL, 'Emma Thompson, Brendan Gleeson, Daniel Brühl, Monique Chaumette, Joachim Bissmeier, Katrin Pollitt, ', 'Vincent Perez', 0, 'admin1@gmail.com', 'Dramas'),
	(432, 'https://www.streamua.ddnsking.com/peliculas/Alone/Together', NULL, 'Alone/Together', 'Eight years after their breakup, college sweethearts Christine and Raf reconnect at different points in their lives as feelings from the past resurface.', 'Philippines', NULL, 'Liza Soberano, Enrique Gil, Adrian Alandy, Jasmine Curtis-Smith, Sylvia Sanchez, Nonie Buencamino, X', 'Antoinette Jadaone', 0, 'admin1@gmail.com', 'Dramas'),
	(433, 'https://www.streamua.ddnsking.com/peliculas/AlongCameaSpider', NULL, 'Along Came a Spider', 'When a girl is kidnapped from a prestigious prep school, a homicide detective takes the case, teaming up with young security agent.', 'United States, Germa', NULL, 'Morgan Freeman, Monica Potter, Michael Wincott, Dylan Baker, Mika Boorem, Anton Yelchin, Kim Hawthor', 'Lee Tamahori', 0, 'admin1@gmail.com', 'Thrillers'),
	(434, 'https://www.streamua.ddnsking.com/peliculas/AlphaandOmega2:AHowl-idayAdventure', NULL, 'Alpha and Omega 2: A Howl-iday Adventure', 'In this animated outdoor adventure, wolf couple Humphrey and Kate face a crisis when one of their three cubs disappears without explanation.', 'United States', NULL, 'Ben Diskin, Kate Higgins, Blackie Rose, Lindsay Torrance, Liza West, Tracy Pfau, Bill Lader, Meryl L', 'Richard Rich', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(435, 'https://www.streamua.ddnsking.com/peliculas/AlphaandOmega:TheLegendoftheSawToothCave', NULL, 'Alpha and Omega: The Legend of the Saw Tooth Cave', 'When a wolf pup named Runt sneaks off to explore a mysterious cave, he meets and befriends a wolf driven from her pack because shes blind.', 'United States, India', NULL, 'Debi Derryberry, Ben Diskin, Kate Higgins, Lindsay Torrance, Larry Thomas, Bill Lader, Cindy Robinso', 'Richard Rich', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(437, 'https://www.streamua.ddnsking.com/peliculas/AlphaGo', NULL, 'AlphaGo', 'Seemingly simple but deceptively complex, the game of "Go" serves as the backdrop for this battle between artificial intelligence and man.', 'United States', NULL, '', 'Greg Kohs', 0, 'admin1@gmail.com', 'Documentaries'),
	(438, 'https://www.streamua.ddnsking.com/peliculas/Alt-Right:AgeofRage', NULL, 'Alt-Right: Age of Rage', 'This documentary follows a white power leader and an Antifa activist leading up to the Charlottesville riots in the first year of Trumps presidency.', '', NULL, 'Daryle Lamont Jenkins, Richard Spencer', 'Adam Bhala Lough', 0, 'admin1@gmail.com', 'Documentaries'),
	(439, 'https://www.streamua.ddnsking.com/series/AlteredCarbon', NULL, 'Altered Carbon', 'After 250 years on ice, a prisoner returns to life in a new body with one chance to win his freedom: by solving a mind-bending murder.', 'United States', NULL, 'Joel Kinnaman, James Purefoy, Martha Higareda, Renée Elise Goldsberry, Dichen Lachman, Will Yun Lee,', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(440, 'https://www.streamua.ddnsking.com/peliculas/AlteredCarbon:Resleeved', NULL, 'Altered Carbon: Resleeved', 'On the planet Latimer, Takeshi Kovacs must protect a tattooist while investigating the death of a yakuza boss alongside a no-nonsense CTAC.', 'Japan, United States', NULL, 'Tatsuhisa Suzuki, Rina Satou, Ayaka Asai, Jouji Nakata, Kenji Yamauchi, Kanehira Yamamoto, Koji Ishi', 'Takeru Nakajima, Yoshiyuki Okada', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(441, 'https://www.streamua.ddnsking.com/peliculas/AlwaysaBridesmaid', NULL, 'Always a Bridesmaid', 'Never married but always at weddings, a copy editor finally dives into the dating pool but wonders if her love story involves staying single forever.', 'United States', NULL, 'Javicia Leslie, Jordan Calloway, Richard Lawson, Yvette Nicole Brown, Michelle Mitchenor, Amber Char', 'Trey Haley', 0, 'admin1@gmail.com', 'Comedies'),
	(442, 'https://www.streamua.ddnsking.com/series/AlwaysaWitch', NULL, 'Always a Witch', 'A young 17th-century witch time travels to the future to save the man she loves, but first must adjust to present-day Cartagena and defeat a dark rival.', 'Colombia', NULL, 'Angely Gaviria, Sebastián Eslava, Luis Fernando Hoyos, Verónica Orozco, Lenard Vanderaa, Sofía Arauj', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(443, 'https://www.streamua.ddnsking.com/peliculas/AlwaysBeMyMaybe', NULL, 'Always Be My Maybe', 'After being unexpectedly dumped by their respective lovers, a man and a woman have a chance meeting at a resort and embark on a unique relationship.', 'Philippines', NULL, 'Gerald Anderson, Arci Muñoz, Cacai Bautista, Ricci Chan, Tirso Cruz III, Carlo Aquino, Matt Evans, A', 'Dan Villegas', 0, 'admin1@gmail.com', 'InternationalMovies'),
	(444, 'https://www.streamua.ddnsking.com/peliculas/AmandaKnox', NULL, 'Amanda Knox', 'She was twice convicted and acquitted of murder. Amanda Knox and the people closest to her case speak out in this illuminating documentary.', 'Denmark, United Stat', NULL, '', 'Rod Blackhurst, Brian McGinn', 0, 'admin1@gmail.com', 'Documentaries'),
	(445, 'https://www.streamua.ddnsking.com/peliculas/Amandla!ARevolutioninFourPartHarmony', NULL, 'Amandla! A Revolution in Four Part Harmony', 'This documentary recounts the fascinating and little-known role that music has played in the struggle to eradicate apartheid in South Africa.', 'South Africa, United', NULL, 'Miriam Makeba, Hugh Masekela, Abdullah Ibrahim, Duma Ka Ndlovu, Sibongile Khumalo, Vusi Mahlasela, T', 'Lee Hirsch', 0, 'admin1@gmail.com', 'Documentaries'),
	(446, 'https://www.streamua.ddnsking.com/peliculas/Amar', NULL, 'Amar', 'Young Laura and Carlos experience the intensity and fragility of first love, as life realities gradually tarnish their idealized notions of romance.', 'Spain', NULL, 'María Pedraza, Pol Monen, Natalia Tena, Nacho Fresneda, Greta Fernández, Gustavo Salmerón, Celso Bug', 'Esteban Crespo', 0, 'admin1@gmail.com', 'Dramas'),
	(447, 'https://www.streamua.ddnsking.com/peliculas/AmarAkbar&Tony', NULL, 'Amar Akbar & Tony', 'The brotherly bond between three childhood friends – one Sikh, one Muslim and one Catholic – is tested by the often comic absurdities of adulthood.', 'United Kingdom', NULL, 'Rez Kempton, Sam Vincenti, Martin Delaney, Karen David, Laura Aikman, Goldy Notay, Meera Syal, Nina ', 'Atul Malhotra', 0, 'admin1@gmail.com', 'Comedies'),
	(448, 'https://www.streamua.ddnsking.com/peliculas/AmarAkbarAnthony', NULL, 'Amar Akbar Anthony', 'Abandoned in a park by their father, Amar, Akbar and Anthony grow up independently and have no knowledge of one another. Theyre reunited as adults when, by coincidence, they all give blood at the same hospital.', 'India', NULL, 'Vinod Khanna, Rishi Kapoor, Amitabh Bachchan, Neetu Singh, Parveen Babi, Shabana Azmi, Nirupa Roy, P', 'Manmohan Desai', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(449, 'https://www.streamua.ddnsking.com/peliculas/AmarsHands', NULL, 'Amars Hands', 'To fulfill her husband’s dream to build a home, a widow sends her five children to earn money in Cairo, where their poverty tests them at every turn.', 'Egypt', NULL, 'Ghadah Abdulrazeq, Wafaa Amer, Hassan El Raddad, Houria Farghally, Sabry Fawwaz', 'Khaled Youssef', 0, 'admin1@gmail.com', 'Dramas'),
	(450, 'https://www.streamua.ddnsking.com/peliculas/Amateur', NULL, 'Amateur', 'After hes recruited to an elite prep school, a 14-year-old basketball phenom is confronted by corruption and greed in amateur sports.', 'United States', NULL, 'Michael Rainey Jr., Josh Charles, Brian White, Sharon Leal, Ashlee Brian, Corey Parker Robinson', 'Ryan Koo', 0, 'admin1@gmail.com', 'Dramas'),
	(451, 'https://www.streamua.ddnsking.com/series/AmazingInteriors', NULL, 'Amazing Interiors', 'Meet eccentric homeowners whose seemingly ordinary spaces are full of surprises, from a backyard roller coaster to an indoor aquarium.', 'United Kingdom', NULL, '', '', 0, 'admin1@gmail.com', 'BritishTVShows'),
	(452, 'https://www.streamua.ddnsking.com/peliculas/Amelia:ATaleofTwoSisters', NULL, 'Amelia: A Tale of Two Sisters', 'Eight decades after her disappearance, Amelia Earharts incredible accomplishments are still celebrated, thanks in large part to her sister Muriel.', 'United Kingdom', NULL, 'Rachael Stirling', 'Edward Cotterill', 0, 'admin1@gmail.com', 'Documentaries'),
	(453, 'https://www.streamua.ddnsking.com/series/AmericasBookofSecrets', NULL, 'Americas Book of Secrets', 'This engaging documentary series shares the surprising backstories of familiar institutions like the Pentagon, West Point and the Playboy Mansion.', 'United States', NULL, 'Jonathan Adams', '', 0, 'admin1@gmail.com', 'Docuseries'),
	(454, 'https://www.streamua.ddnsking.com/series/AmericasNextTopModel', NULL, 'Americas Next Top Model', 'Supermodel Tyra Banks created and executive-produced this reality series that chronicles the transformation of young women into potential supermodels.', 'United States', NULL, 'Tyra Banks', '', 0, 'admin1@gmail.com', 'RealityTV'),
	(455, 'https://www.streamua.ddnsking.com/peliculas/AmericanAnarchist', NULL, 'American Anarchist', 'This documentary profiles William Powell, who wrote the "The Anarchist Cookbook" in the early 1970s and spent his later life regretting his actions.', 'United States', NULL, 'William Powell', 'Charlie Siskel', 0, 'admin1@gmail.com', 'Documentaries'),
	(456, 'https://www.streamua.ddnsking.com/peliculas/AmericanAssassin', NULL, 'American Assassin', 'After grad student Mitch Rapp suffers a tragic loss during a terrorist attack, his single-minded thirst for vengeance catches the interest of the CIA.', 'United States', NULL, 'Dylan OBrien, Michael Keaton, Sanaa Lathan, Shiva Negar, Taylor Kitsch, Trevor White, Navid Negahban', 'Michael Cuesta', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(457, 'https://www.streamua.ddnsking.com/peliculas/AmericanBeauty', NULL, 'American Beauty', 'While struggling to endure his tightly wound wife, an unfulfilling job and a surly teen, a man becomes obsessed with one of his daughters friends.', 'United States', NULL, 'Kevin Spacey, Annette Bening, Thora Birch, Wes Bentley, Mena Suvari, Chris Cooper, Peter Gallagher, ', 'Sam Mendes', 0, 'admin1@gmail.com', 'Dramas'),
	(458, 'https://www.streamua.ddnsking.com/peliculas/AmericanCircumcision', NULL, 'American Circumcision', 'With interviews from experts on both sides of the debate, this film questions the routine practice of non-religious infant circumcision in the U.S.', 'United States', NULL, '', 'Brendon Marotta', 0, 'admin1@gmail.com', 'Documentaries'),
	(459, 'https://www.streamua.ddnsking.com/series/AmericanCrime', NULL, 'American Crime', 'This anthology series unfolds a different story arc for each season, with dramas focusing on aspects of American life and the criminal justice system.', 'United States', NULL, 'Felicity Huffman, Timothy Hutton, Elvis Nolasco, Regina King, Lili Taylor, Richard Cabral, Brent And', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(460, 'https://www.streamua.ddnsking.com/series/AmericanCrimeStory:ThePeoplev.O.J.Simpson', NULL, 'American Crime Story: The People v. O.J. Simpson', 'This anthology series dramatizes historic criminal cases in the U.S., including the O.J. Simpson trial and Andrew Cunanans 1997 murder spree.', 'United States', NULL, 'Cuba Gooding Jr., Sarah Paulson, John Travolta, Courtney B. Vance, Sterling K. Brown, Kenneth Choi, ', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(461, 'https://www.streamua.ddnsking.com/peliculas/AmericanExperience:RubyRidge', NULL, 'American Experience: Ruby Ridge', 'A botched attempt to arrest a white supremacist in Idaho results in a gun battle, a standoff and three deaths that galvanize public opinion in 1992.', 'United States', NULL, 'Dave Hunt, Bo Gritz, Sara Weaver', 'Barak Goodman', 0, 'admin1@gmail.com', 'Documentaries'),
	(462, 'https://www.streamua.ddnsking.com/series/AmericanExperience:TheCircus', NULL, 'American Experience: The Circus', 'An exploration of the American circus, as the spectacle evolved from a one-ring show to a cultural event and eventually, a dying breed.', 'United States', NULL, '', 'Sharon Grimberg', 0, 'admin1@gmail.com', 'Docuseries'),
	(463, 'https://www.streamua.ddnsking.com/peliculas/AmericanExperience:TheIslandMurder', NULL, 'American Experience: The Island Murder', 'In 1931, a young Navy wife tore apart Hawaii on racial lines after claiming she was raped by a gang of nonwhite islanders.', 'United States', NULL, 'Blair Brown', 'Mark Zwonitzer', 0, 'admin1@gmail.com', 'Documentaries'),
	(464, 'https://www.streamua.ddnsking.com/peliculas/AmericanFactory', NULL, 'American Factory', 'In this documentary, hopes soar when a Chinese company reopens a shuttered factory in Ohio. But a culture clash threatens to shatter an American dream.', 'United States', NULL, '', 'Steven Bognar, Julia Reichert', 0, 'admin1@gmail.com', 'Documentaries'),
	(465, 'https://www.streamua.ddnsking.com/peliculas/AmericanFactory:AConversationwiththeObamas', NULL, 'American Factory: A Conversation with the Obamas', 'Barack and Michelle Obama talk with directors Steven Bognar and Julia Reichert about the documentary and the importance of storytelling.', 'United States', NULL, 'President Barack Obama, Michelle Obama, Julia Reichert, Steven Bognar', '', 0, 'admin1@gmail.com', 'Documentaries'),
	(466, 'https://www.streamua.ddnsking.com/peliculas/AmericanHangman', NULL, 'American Hangman', 'A judge’s kidnapping is streamed live on social media, as a vengeful loner puts him on trial for supposedly sending an innocent man to his death.', 'Canada', NULL, 'Donald Sutherland, Vincent Kartheiser, Oliver Dennis, Paul Braunstein, Paul Amato, Matt Baram, Dan B', 'Wilson Coneybeare', 0, 'admin1@gmail.com', 'Thrillers'),
	(467, 'https://www.streamua.ddnsking.com/peliculas/AmericanHeist', NULL, 'American Heist', 'An ex-con is just getting his life back on track when his older brother is released from prison and drags him into the underworld for one final heist.', 'Canada, Luxembourg', NULL, 'Hayden Christensen, Adrien Brody, Jordana Brewster, Tory Kittles, Akon, Luis Da Silva Jr., Lance E. ', 'Sarik Andreasyan', 0, 'admin1@gmail.com', 'Action&Adventure'),
	(468, 'https://www.streamua.ddnsking.com/peliculas/AmericanHistoryX', NULL, 'American History X', 'A neo-Nazi gets sent to prison for murder and comes out a changed man. But can he prevent his younger brother from following in his footsteps?', 'United States', NULL, 'Edward Norton, Edward Furlong, Beverly DAngelo, Jennifer Lien, Ethan Suplee, Fairuza Balk, Avery Bro', 'Tony Kaye', 0, 'admin1@gmail.com', 'Dramas'),
	(469, 'https://www.streamua.ddnsking.com/peliculas/AmericanHoney', NULL, 'American Honey', 'A teenage girl leaves her dull life in Oklahoma to join a raucous band of travelling magazine sellers on an alcohol-, drug- and sex-filled road trip.', 'United Kingdom, Unit', NULL, 'Sasha Lane, Shia LaBeouf, Riley Keough, McCaul Lombardi, Arielle Holmes', 'Andrea Arnold', 0, 'admin1@gmail.com', 'Dramas'),
	(471, 'https://www.streamua.ddnsking.com/peliculas/AmericanMasters:TedWilliams', NULL, 'American Masters: Ted Williams', 'Baseball legend Ted Williams fights to become the greatest hitter of all time as he battles family, teammates, the press and even the fans.', 'United States', NULL, 'Ted Williams', 'Nick Davis', 0, 'admin1@gmail.com', 'Documentaries'),
	(472, 'https://www.streamua.ddnsking.com/peliculas/AmericanMurder:TheFamilyNextDoor', NULL, 'American Murder: The Family Next Door', 'Using raw, firsthand footage, this documentary examines the disappearance of Shanann Watts and her children, and the terrible events that followed.', 'United States', NULL, '', 'Jenny Popplewell', 0, 'admin1@gmail.com', 'Documentaries'),
	(473, 'https://www.streamua.ddnsking.com/series/AmericanOdyssey', NULL, 'American Odyssey', 'An elite soldier, a corporate lawyer and a political activist uncover a deadly conspiracy linking terrorists to a powerful American corporation.', 'United States', NULL, 'Anna Friel, Peter Facinelli, Jake Robinson, Jim True-Frost, Treat Williams, Sadie Sink, Omar Ghazaou', '', 0, 'admin1@gmail.com', 'TVDramas'),
	(474, 'https://www.streamua.ddnsking.com/peliculas/AmericanPie9:GirlsRules', NULL, 'American Pie 9: Girls Rules', 'Four tight-knit high school seniors vow to turn their love lives around by homecoming when the arrival of a new student muddles their plans.', 'United States', NULL, 'Madison Pettis, Lizze Broadway, Piper Curda, Natasha Behnam, Darren Barnet, Sara Rue, Zachary Gordon', 'Mike Elliott', 0, 'admin1@gmail.com', 'Comedies'),
	(475, 'https://www.streamua.ddnsking.com/peliculas/AmericanPsycho', NULL, 'American Psycho', 'With chiseled good looks that belie his insanity, a businessman takes pathological pride in yuppie pursuits and indulges in sudden homicidal urges.', 'United States, Canad', NULL, 'Christian Bale, Willem Dafoe, Jared Leto, Reese Witherspoon, Samantha Mathis, Chloë Sevigny, Justin ', 'Mary Harron', 0, 'admin1@gmail.com', 'Comedies'),
	(476, 'https://www.streamua.ddnsking.com/peliculas/AmericanSon', NULL, 'American Son', 'Time passes and tension mounts in a Florida police station as an estranged interracial couple awaits news of their missing teenage son.', 'United States', NULL, 'Kerry Washington, Steven Pasquale, Jeremy Jordan, Eugene Lee', 'Kenny Leon', 0, 'admin1@gmail.com', 'Dramas'),
	(477, 'https://www.streamua.ddnsking.com/series/AmericanVandal', NULL, 'American Vandal', 'A high school is rocked by an act of vandalism, but the top suspect pleads innocence and finds an ally in a filmmaker. A satirical true crime mystery.', 'United States', NULL, 'Tyler Alvarez, Griffin Gluck, Jimmy Tatro, Camille Hyde, Lou Wilson, Eduardo Franco, Jessica Juarez,', '', 0, 'admin1@gmail.com', 'CrimeTVShows'),
	(478, 'https://www.streamua.ddnsking.com/peliculas/AmericanWarfighter', NULL, 'American Warfighter', 'A Navy SEAL haunted by wartime memories tries to rebuild his life at home, even as one last mission threatens to unravel everything.', 'United States', NULL, 'Jerry G. Angelo, Paul Logan, Joshua Santana, Carolina Castro, David Robbins, Michael King, Tom Crisp', 'Jerry G. Angelo', 0, 'admin1@gmail.com', 'Dramas'),
	(479, 'https://www.streamua.ddnsking.com/peliculas/AmitTandon:FamilyTandoncies', NULL, 'Amit Tandon: Family Tandoncies', 'From the death of romance in marriage to the injustices of modern-day parenting, Amit Tandon shares wisdom and wisecracks as a battle-scarred family guy.', 'India', NULL, 'Amit Tandon', '', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(480, 'https://www.streamua.ddnsking.com/series/AMO', NULL, 'AMO', 'Despite the Philippine governments crackdown on narcotics, high schooler Joseph expands his drug running while his cop uncle profits from corruption.', 'Philippines', NULL, 'Derek Ramsay, Vince Rillon, Allen Dizon, Felix Roco, Ruby Ruiz', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(481, 'https://www.streamua.ddnsking.com/peliculas/AmongFamily', NULL, 'Among Family', 'Amid a marital crisis, Fikret befriends songstress Solmaz after a wacky encounter and must fill in as the father of her soon-to-wed daughter.', 'Turkey', NULL, 'Engin Günaydın, Demet Evgar, Erdal Özyagcilar, Su Kutlu, Devrim Yakut, Fatih Artman, Gülse Birsel, S', 'Ozan Açıktan', 0, 'admin1@gmail.com', 'Comedies'),
	(482, 'https://www.streamua.ddnsking.com/peliculas/Amrapali', NULL, 'Amrapali', 'In the age of Buddha and his philosophy of nonviolence, a warmonger king plots the destruction of an enemy kingdom to rescue the woman he loves.', 'India', NULL, 'Vyjayantimala, Sunil Dutt, Prem Nath, Bipin Gupta, Gajanan Jagirdar, Zul Vellani, K.N. Singh, Randhi', 'Lekh Tandon', 0, 'admin1@gmail.com', 'Dramas'),
	(483, 'https://www.streamua.ddnsking.com/peliculas/Amy', NULL, 'Amy', 'Rare home videos and interviews with Amy Winehouses inner circle offer an intimate look at her journey from charismatic teen to troubled star.', 'United Kingdom', NULL, 'Amy Winehouse, Lauren Gilbert', 'Asif Kapadia', 0, 'admin1@gmail.com', 'Documentaries'),
	(484, 'https://www.streamua.ddnsking.com/peliculas/AmySchumerGrowing', NULL, 'Amy Schumer Growing', 'Amy Schumer spills on her new marriage, personal growth, making a baby and her moms misguided advice in a special thats both raunchy and sincere.', 'United States', NULL, 'Amy Schumer', 'Amy Schumer', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(485, 'https://www.streamua.ddnsking.com/peliculas/AmySchumer:TheLeatherSpecial', NULL, 'Amy Schumer: The Leather Special', 'Comic sensation Amy Schumer riffs on sex, dating and the absurdities of fame in a bold and uncensored stand-up set at Denvers Bellco Theater.', 'United States', NULL, 'Amy Schumer', 'Amy Schumer', 0, 'admin1@gmail.com', 'Stand-UpComedy'),
	(486, 'https://www.streamua.ddnsking.com/peliculas/AnAmericaninMadras', NULL, 'An American in Madras', 'Extensive film clips and interviews tell the story of American filmmaker Ellis R. Dungan, who spent 15 years in India and helped define Tamil cinema.', 'India', NULL, '', 'Karan Bali', 0, 'admin1@gmail.com', 'Documentaries'),
	(487, 'https://www.streamua.ddnsking.com/peliculas/AnAmericanTail', NULL, 'An American Tail', 'Fievel, a young Russian mouse, immigrates to America and must make his own way in the strange and sometimes perilous new world.', 'United States', NULL, 'Erica Yohn, Nehemiah Persoff, Amy Green, Phillip Glasser, Christopher Plummer, John Finnegan, Will R', 'Don Bluth', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(488, 'https://www.streamua.ddnsking.com/peliculas/AnAmericanTail:FievelGoesWest', NULL, 'An American Tail: Fievel Goes West', 'Fievel and his family head west for what turns out to be a wild adventure. Deep in cowboy country, the intrepid mouse faces down a nasty feline.', 'United States', NULL, 'Philip Glasser, James Stewart, Erica Yohn, Cathy Cavadini, Nehemiah Persoff, Dom DeLuise, Amy Irving', 'Phil Nibbelink, Simon Wells', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(489, 'https://www.streamua.ddnsking.com/peliculas/AnAmericanTail:TheMysteryoftheNightMonster', NULL, 'An American Tail: The Mystery of the Night Monster', 'When a monster goes on a mouse-napping spree in New York, Fievel and his friends help a reporter get to the bottom of the mystery.', 'United States', NULL, 'Thomas Dekker, Lacey Chabert, Jane Singer, Nehemiah Persoff, Susan Boyd, Robert Hays, Pat Musick, Do', 'Larry Latham', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(490, 'https://www.streamua.ddnsking.com/peliculas/AnAmericanTail:TheTreasuresofManhattanIsland', NULL, 'An American Tail: The Treasures of Manhattan Islan', 'When Fievel and friends go hunting for buried treasure beneath the ruins of an old subway tunnel, they stumble onto something surprising.', 'United States', NULL, 'Thomas Dekker, Dom DeLuise, Pat Musick, Nehemiah Persoff, Erica Yohn, Lacey Chabert, Elaine Bilstad,', 'Larry Latham', 0, 'admin1@gmail.com', 'Children&FamilyMovie'),
	(491, 'https://www.streamua.ddnsking.com/peliculas/AnEasyGirl', NULL, 'An Easy Girl', 'A teen girl is drawn to her cousin’s hedonistic lifestyle when they spend the summer together in Cannes as she learns about herself and her own values.', 'France', NULL, 'Mina Farid, Zahia Dehar, Benoît Magimel, Nuno Lopes, Clotilde Courau, Loubna Abidar, "Riley" Lakdhar', 'Rebecca Zlotowski', 0, 'admin1@gmail.com', 'Comedies'),
	(492, 'https://www.streamua.ddnsking.com/peliculas/AnEgyptianStory', NULL, 'An Egyptian Story', 'While undergoing heart surgery in London, Yehia reflects on his life as his heart chamber becomes a courtroom where hes tried for his mistakes.', 'Egypt', NULL, 'Nour El-Sherif, Magda El-Khatib, Yousra, Mohsen Mohiedine, Oussama Nadir, Layla Hamadah, Mohamed Mou', 'Youssef Chahine', 0, 'admin1@gmail.com', 'ClassicMovies'),
	(493, 'https://www.streamua.ddnsking.com/peliculas/AnEveningwithBeverlyLuffLinn', NULL, 'An Evening with Beverly Luff Linn', 'When an unhappily married woman discovers a man from her past has a role in a local theater production, shell do anything to reconnect with him.', 'United Kingdom, Unit', NULL, 'Aubrey Plaza, Emile Hirsch, Jemaine Clement, Craig Robinson, Matt Berry, Zach Cherry, Maria Bamford,', 'Jim Hosking', 0, 'admin1@gmail.com', 'Comedies'),
	(494, 'https://www.streamua.ddnsking.com/peliculas/AnHourandaHalf', NULL, 'An Hour and a Half', 'Based on the 2002 El Ayyat train accident, this drama begins 90 minutes before the explosion, following the lives of riders in the third-class cars.', 'Egypt', NULL, 'Eyad Nassar, Ahmed Bedir, Fathy Abdel Wahab, Sawsan Badr, Maged El Kedwany, Tarek Abdel Aziz, Karima', 'Wael Ehsan', 0, 'admin1@gmail.com', 'Dramas'),
	(495, 'https://www.streamua.ddnsking.com/peliculas/AnImperfectMurder', NULL, 'An Imperfect Murder', 'Haunted by a nightmare involving her abusive ex-boyfriend, an actress begins to question her reality and whether the incident took place.', 'United States', NULL, 'Sienna Miller, Alec Baldwin, Charles Grodin, Colleen Camp, John Buffalo Mailer, Nick Mathews, Steven', 'James Toback', 0, 'admin1@gmail.com', 'Dramas'),
	(496, 'https://www.streamua.ddnsking.com/series/AnInnocentMistake', NULL, 'An Innocent Mistake', 'Raised by three mothers, a self-assured teen in turmoil meets the father figure she never had. But she also stands to drive the man and his son apart.', 'Taiwan', NULL, 'Jason Wang, Mathilde Lin, Mo Tzu Yi, Xi Man-Ning, Lin Mei-hsiu, Kelly Huang, Joy Pan', '', 0, 'admin1@gmail.com', 'InternationalTVShows'),
	(497, 'https://www.streamua.ddnsking.com/peliculas/AnInterviewwithGod', NULL, 'An Interview with God', 'After an assignment in a war zone, a journalist trying to put his life back together is granted an interview with someone claiming to be God.', 'United States', NULL, 'Brenton Thwaites, David Strathairn, Hill Harper, Charlbi Dean, Yael Grobglas', 'Perry Lang', 0, 'admin1@gmail.com', 'Dramas'),
	(498, 'https://www.streamua.ddnsking.com/peliculas/AnOrdinaryMan', NULL, 'An Ordinary Man', 'A war criminal in hiding begins to suspect that the maid, his only confidant and contact with the outside world, may be hiding something herself.', 'Serbia, United State', NULL, 'Ben Kingsley, Hera Hilmar, Peter Serafinowicz', 'Brad Silberling', 0, 'admin1@gmail.com', 'Dramas'),
	(499, 'https://www.streamua.ddnsking.com/peliculas/AnUnremarkableChristmas', NULL, 'An Unremarkable Christmas', 'An accountant and aspiring magician invites his boss to spend Christmas with his family — unaware that hes one of Colombias most-wanted criminals.', 'Colombia', NULL, 'Antonio Sanint, Luis Eduardo Arango, María Cecilia Sánchez, Mariana Gómez, Julián Cerati, Aura Crist', 'Juan Camilo Pinzon', 0, 'admin1@gmail.com', 'Comedies'),
	(500, 'https://www.streamua.ddnsking.com/peliculas/AnUpperEgyptian', NULL, 'An Upper Egyptian', 'Eager to settle down, Abdullah searches for the right woman to marry – but the one he truly longs for may not feel the same way.', 'Egypt', NULL, 'Mohamed Ramadan, Randa El Behery, Nermin Maher, Inas El Naggar, Mayar El Gheity, Hassan Abdulfattah,', 'Ismail Farouk, Hazem Fouda', 0, 'admin1@gmail.com', 'Comedies'),
	(501, 'https://www.streamua.ddnsking.com/peliculas/AnaeVitória', NULL, 'Ana e Vitória', 'After meeting by chance, two young musicians with differing views on love and life record an album that drastically alters their lives.', 'Brazil', NULL, 'Ana Caetano, Vitória Falcão, Clarissa Müller, Bruce Gomlevsky, Thati Lopes, Caique Nogueira, Érika M', 'Matheus Souza', 0, 'admin1@gmail.com', 'Comedies');
/*!40000 ALTER TABLE `Contenido` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Contenido2` (
  `idContenido` int(11) NOT NULL AUTO_INCREMENT,
  `URL_contenido` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagenPortada` blob DEFAULT NULL,
  `titulo` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `resumen` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `idioma` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `subtitulos` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `actores` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `director` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `puntuacionMedia` int(11) DEFAULT 0,
  `emailAdministrador` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipoGenero` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idContenido`),
  KEY `emailAdministrador` (`emailAdministrador`),
  KEY `tipoGenero` (`tipoGenero`),
  CONSTRAINT `Contenido2_ibfk_1` FOREIGN KEY (`emailAdministrador`) REFERENCES `Administrador` (`email`),
  CONSTRAINT `Contenido2_ibfk_2` FOREIGN KEY (`tipoGenero`) REFERENCES `Genero` (`tipo`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Contenido2` DISABLE KEYS */;
INSERT INTO `Contenido2` (`idContenido`, `URL_contenido`, `imagenPortada`, `titulo`, `resumen`, `idioma`, `subtitulos`, `actores`, `director`, `puntuacionMedia`, `emailAdministrador`, `tipoGenero`) VALUES
	(1, 'fsadf', NULL, 'dfs', 'sdfas', 'sdfdsf', 'sdfadsf', 'erwr', 'jsdfas', 1, 'admin1@gmail.com', 'TERROR'),
	(2, 'S', NULL, 'dfs', 'sdfas', 'sdfdsf', 'sdfadsf', 'erwr', 'jsdfas', 1, 'admin1@gmail.com', 'TERROR');
/*!40000 ALTER TABLE `Contenido2` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Dispositivo` (
  `idContenido` int(11) NOT NULL,
  `emailCliente` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idContenido`),
  UNIQUE KEY `emailCliente` (`emailCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Dispositivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `Dispositivo` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Facturacion` (
  `idFacturacion` int(11) NOT NULL AUTO_INCREMENT,
  `numTarjeta` varchar(16) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaCaducidad` date DEFAULT NULL,
  `CVV` int(3) DEFAULT NULL,
  `diaFacturacion` date DEFAULT NULL,
  `IBAN` varchar(24) COLLATE utf8_spanish_ci DEFAULT '0',
  `BIC` varchar(11) COLLATE utf8_spanish_ci DEFAULT '0',
  `banco` varchar(50) COLLATE utf8_spanish_ci DEFAULT '0',
  PRIMARY KEY (`idFacturacion`) USING BTREE,
  UNIQUE KEY `numTarjeta` (`numTarjeta`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Facturacion` DISABLE KEYS */;
INSERT INTO `Facturacion` (`idFacturacion`, `numTarjeta`, `fechaCaducidad`, `CVV`, `diaFacturacion`, `IBAN`, `BIC`, `banco`) VALUES
	(3, NULL, NULL, NULL, '2021-04-28', '123456789123456789123456', '12345678912', 'Santander');
/*!40000 ALTER TABLE `Facturacion` ENABLE KEYS */;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `filtrarContenido`(
	IN `tipoContenido` VARCHAR(50),
	IN `valorEntrada` VARCHAR(50)

)
BEGIN

	PREPARE stmt FROM CONCAT("SELECT * FROM Contenido WHERE ", tipoContenido,'=', "'",valorEntrada,"';");
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `Genero` (
  `id` int(11) NOT NULL DEFAULT 0,
  `tipo` varchar(20) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Genero` DISABLE KEYS */;
INSERT INTO `Genero` (`id`, `tipo`, `descripcion`) VALUES
	(32, 'Action&Adventure', 'Action&Adventure'),
	(0, 'AnimeSeries', NULL),
	(0, 'BritishTVShows', NULL),
	(0, 'Children&FamilyMovie', NULL),
	(0, 'ClassicMovies', NULL),
	(0, 'Comedies', NULL),
	(37, 'CrimeTVShows', 'CrimeTVShows'),
	(39, 'Documentaries', 'Documentaries'),
	(38, 'Docuseries', 'Docuseries'),
	(29, 'Dramas', 'Dramas'),
	(41, 'FANTASIA', NULL),
	(31, 'HorrorMovies', 'HorrorMovies'),
	(33, 'IndependentMovies', 'IndependentMovies'),
	(30, 'InternationalMovies', 'InternationalMovies'),
	(26, 'InternationalTVShows', 'InternationalTVShows'),
	(0, 'Movies', NULL),
	(0, 'Music&Musicals', NULL),
	(0, 'RealityTV', NULL),
	(34, 'Sci-Fi&Fantasy', 'Sci-Fi&Fantasy'),
	(40, 'SportsMovies', 'SportsMovies'),
	(0, 'Stand-UpComedy', NULL),
	(0, 'Stand-UpComedy&TalkS', NULL),
	(1, 'TERROR', 'TERROR'),
	(36, 'Thrillers', 'Thrillers'),
	(0, 'TVComedies', NULL),
	(27, 'TVDramas', 'TVDramas'),
	(35, 'TVMysteries', 'TVMysteries'),
	(28, 'TVSci-Fi&Fantasy', 'TVSci-Fi&Fantasy'),
	(0, 'TVShows', NULL);
/*!40000 ALTER TABLE `Genero` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Lista` (
  `idContenido` int(11) NOT NULL,
  `emailCliente` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idContenido`,`emailCliente`),
  KEY `emailCliente` (`emailCliente`),
  CONSTRAINT `Lista_ibfk_1` FOREIGN KEY (`emailCliente`) REFERENCES `Cliente` (`email`),
  CONSTRAINT `Lista_ibfk_2` FOREIGN KEY (`idContenido`) REFERENCES `Contenido` (`idContenido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Lista` DISABLE KEYS */;
/*!40000 ALTER TABLE `Lista` ENABLE KEYS */;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `listarNovedades`()
BEGIN

	SELECT * FROM Novedades ORDER BY fecha DESC;
	
END//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `modificarContenido`(
IN id INT,
IN URL VARCHAR(50),
IN titulo VARCHAR(50),
IN resumen TEXT,
IN idioma VARCHAR(20),
IN subtitulos VARCHAR(20), 
IN actores VARCHAR(100),
IN director VARCHAR(50),
IN emailAdministrador VARCHAR(50),
IN tipoGenero VARCHAR(20)
)
BEGIN

UPDATE Contenido SET Contenido.URL_contenido = URL, Contenido.titulo = titulo, Contenido.resumen = resumen, Contenido.idioma = idioma, Contenido.subtitulos = subtitulos, Contenido.actores = actores, Contenido.director = director, Contenido.emailAdministrador = emailAdministrador, Contenido.tipoGenero = tipoGenero WHERE Contenido.idContenido = id;

END//
DELIMITER ;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `modificarUsuario`(
	IN `email` VARCHAR(50),
	IN `nombre` VARCHAR(50),
	IN `apellido1` VARCHAR(50),
	IN `apellido2` VARCHAR(50),
	IN `idioma` VARCHAR(20)
)
BEGIN

DECLARE auxEmail VARCHAR(50);

SELECT Usuario.email into auxEmail FROM Usuario WHERE Usuario.email=email;


if auxEmail IS NOT null then
	
	UPDATE Usuario SET Usuario.nombre = nombre WHERE Usuario.email = email;
	UPDATE Cliente SET Cliente.apellido1 = apellido1, Cliente.apellido2 = apellido2, Cliente.idioma = idioma WHERE Cliente.email = email;

END if;

END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `Novedades` (
  `idNovedades` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `fechaSalida` date DEFAULT curdate(),
  `emailAdministrador` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`idNovedades`),
  KEY `emailAdministrador` (`emailAdministrador`),
  CONSTRAINT `Novedades_ibfk_1` FOREIGN KEY (`emailAdministrador`) REFERENCES `Administrador` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Novedades` DISABLE KEYS */;
INSERT INTO `Novedades` (`idNovedades`, `titulo`, `descripcion`, `fechaSalida`, `emailAdministrador`) VALUES
	(2, 'Novedad2', 'No tan nueva', '2021-04-21', 'admin2@gmail.com'),
	(224, 'NOVEDAD', 'ndwiovbarjvbreiuo', '2021-04-28', 'admin1@gmail.com'),
	(225, 'NOVEDAD', 'ndwiovbarjvbreiuo', '2021-04-28', 'admin1@gmail.com'),
	(226, 'NOVEDAD', 'ndwiovbarjvbreiuo', '2021-04-28', 'admin1@gmail.com'),
	(227, 'NOVEDAD', 'ndwiovbarjvbreiuo', '2021-04-28', 'admin1@gmail.com'),
	(231, 'NO PUEDO MAS', 'JURAO', '2021-06-03', 'admin1@gmail.com'),
	(232, 'hola', 'holi', '2021-05-19', 'admin1@gmail.com'),
	(233, 'Prueba32', 'hola', '2021-05-18', 'admin1@gmail.com');
/*!40000 ALTER TABLE `Novedades` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Pelicula` (
  `idContenido` int(11) NOT NULL,
  PRIMARY KEY (`idContenido`),
  CONSTRAINT `Pelicula_ibfk_1` FOREIGN KEY (`idContenido`) REFERENCES `Contenido` (`idContenido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Pelicula` DISABLE KEYS */;
INSERT INTO `Pelicula` (`idContenido`) VALUES
	(1),
	(2),
	(3),
	(4),
	(5),
	(7),
	(8),
	(9),
	(10),
	(11),
	(14),
	(15),
	(16),
	(18),
	(19),
	(20),
	(21),
	(22),
	(23),
	(24),
	(26),
	(28),
	(29),
	(31),
	(32),
	(33),
	(34),
	(35),
	(36),
	(37),
	(38),
	(40),
	(41),
	(42),
	(43),
	(44),
	(45),
	(47),
	(48),
	(49),
	(50),
	(51),
	(53),
	(55),
	(56),
	(57),
	(58),
	(60),
	(61),
	(63),
	(66),
	(67),
	(68),
	(69),
	(70),
	(71),
	(72),
	(73),
	(74),
	(75),
	(76),
	(77),
	(78),
	(79),
	(80),
	(82),
	(83),
	(84),
	(85),
	(89),
	(90),
	(91),
	(92),
	(93),
	(94),
	(95),
	(97),
	(98),
	(99),
	(100),
	(101),
	(102),
	(103),
	(104),
	(105),
	(106),
	(107),
	(108),
	(111),
	(114),
	(115),
	(116),
	(117),
	(118),
	(119),
	(120),
	(121),
	(122),
	(123),
	(124),
	(125),
	(126),
	(127),
	(128),
	(129),
	(130),
	(132),
	(134),
	(136),
	(137),
	(144),
	(145),
	(146),
	(147),
	(148),
	(149),
	(150),
	(151),
	(152),
	(154),
	(155),
	(156),
	(157),
	(158),
	(159),
	(160),
	(161),
	(162),
	(163),
	(164),
	(165),
	(166),
	(167),
	(168),
	(169),
	(170),
	(171),
	(172),
	(173),
	(174),
	(175),
	(176),
	(177),
	(178),
	(179),
	(180),
	(182),
	(183),
	(184),
	(185),
	(186),
	(187),
	(188),
	(190),
	(191),
	(193),
	(194),
	(195),
	(197),
	(201),
	(202),
	(204),
	(205),
	(206),
	(207),
	(208),
	(209),
	(210),
	(211),
	(212),
	(213),
	(215),
	(216),
	(217),
	(218),
	(220),
	(221),
	(222),
	(223),
	(224),
	(225),
	(228),
	(229),
	(231),
	(232),
	(233),
	(234),
	(235),
	(237),
	(238),
	(239),
	(241),
	(243),
	(244),
	(245),
	(246),
	(247),
	(248),
	(250),
	(251),
	(252),
	(253),
	(254),
	(256),
	(258),
	(262),
	(263),
	(264),
	(265),
	(266),
	(267),
	(268),
	(269),
	(270),
	(271),
	(272),
	(273),
	(274),
	(275),
	(276),
	(279),
	(280),
	(281),
	(282),
	(283),
	(284),
	(286),
	(287),
	(288),
	(292),
	(293),
	(294),
	(296),
	(297),
	(298),
	(299),
	(300),
	(301),
	(302),
	(303),
	(305),
	(306),
	(308),
	(309),
	(310),
	(311),
	(312),
	(313),
	(314),
	(315),
	(316),
	(317),
	(318),
	(319),
	(321),
	(324),
	(326),
	(327),
	(328),
	(329),
	(330),
	(331),
	(332),
	(333),
	(335),
	(343),
	(344),
	(345),
	(346),
	(347),
	(348),
	(352),
	(353),
	(354),
	(355),
	(356),
	(357),
	(359),
	(362),
	(363),
	(367),
	(369),
	(370),
	(371),
	(372),
	(373),
	(374),
	(375),
	(376),
	(377),
	(378),
	(379),
	(380),
	(383),
	(384),
	(385),
	(386),
	(387),
	(388),
	(389),
	(391),
	(392),
	(393),
	(395),
	(396),
	(400),
	(401),
	(402),
	(403),
	(404),
	(407),
	(408),
	(409),
	(411),
	(415),
	(416),
	(417),
	(418),
	(419),
	(420),
	(421),
	(422),
	(423),
	(424),
	(425),
	(426),
	(428),
	(430),
	(431),
	(432),
	(433),
	(434),
	(437),
	(439),
	(440),
	(442),
	(443),
	(444),
	(445),
	(446),
	(447),
	(448),
	(449),
	(451),
	(454),
	(455),
	(456),
	(457),
	(460),
	(462),
	(463),
	(464),
	(465),
	(466),
	(467),
	(468),
	(471),
	(473),
	(474),
	(475),
	(477),
	(478),
	(480),
	(481),
	(482),
	(483),
	(484),
	(485),
	(486),
	(487),
	(488),
	(489),
	(490),
	(491),
	(492),
	(493),
	(494),
	(496),
	(497),
	(498),
	(499),
	(500);
/*!40000 ALTER TABLE `Pelicula` ENABLE KEYS */;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` PROCEDURE `registrarUsuario`(
	IN p_email VARCHAR(50),
	IN p_apellido1 VARCHAR(50),
	IN p_apellido2 VARCHAR(50),
	IN p_idioma VARCHAR(20),
	IN p_permitirDescarga TINYINT,
	IN p_tipoSuscripcion VARCHAR(50),
	IN p_codProm INT,
	IN p_password VARCHAR(30),
	IN p_nombre VARCHAR(20)
)
BEGIN

DECLARE auxEmail VARCHAR(50);

SELECT email into auxEmail FROM Usuario WHERE email=p_email;


if auxEmail is null then

	INSERT INTO Usuario(email,nombre,password) VALUES (p_email,p_nombre,AES_ENCRYPT(p_password,'1234'));
	INSERT INTO Cliente(email,apellido1,apellido2,idioma,permitirDescarga,tipoSuscripcion,codProm) VALUES (p_email,p_apellido1,p_apellido2,p_idioma,p_permitirDescarga,p_tipoSuscripcion,p_codProm);

END if;


END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `Seleccionar` (
  `idContenido` int(11) NOT NULL,
  `emailCliente` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `descargado` tinyint(1) DEFAULT 0,
  `puntuacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`emailCliente`,`idContenido`),
  KEY `idContenido` (`idContenido`),
  CONSTRAINT `Seleccionar_ibfk_1` FOREIGN KEY (`emailCliente`) REFERENCES `Cliente` (`email`),
  CONSTRAINT `Seleccionar_ibfk_2` FOREIGN KEY (`idContenido`) REFERENCES `Contenido` (`idContenido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Seleccionar` DISABLE KEYS */;
INSERT INTO `Seleccionar` (`idContenido`, `emailCliente`, `descargado`, `puntuacion`) VALUES
	(1, 'cliente@email', 0, 3),
	(1, 'nopuedomas@gmail.com', 0, 5),
	(1, 'patriciovaalmedico@gmail.com', 0, 7);
/*!40000 ALTER TABLE `Seleccionar` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Serie` (
  `idContenido` int(11) NOT NULL,
  PRIMARY KEY (`idContenido`),
  CONSTRAINT `Serie_ibfk_1` FOREIGN KEY (`idContenido`) REFERENCES `Contenido` (`idContenido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Serie` DISABLE KEYS */;
INSERT INTO `Serie` (`idContenido`) VALUES
	(3),
	(6),
	(12),
	(13),
	(17),
	(25),
	(27),
	(30),
	(39),
	(46),
	(52),
	(54),
	(59),
	(62),
	(64),
	(65),
	(81),
	(86),
	(87),
	(88),
	(96),
	(109),
	(112),
	(131),
	(133),
	(135),
	(138),
	(139),
	(140),
	(141),
	(142),
	(143),
	(153),
	(181),
	(189),
	(192),
	(196),
	(198),
	(199),
	(200),
	(203),
	(214),
	(219),
	(226),
	(236),
	(240),
	(242),
	(249),
	(257),
	(259),
	(260),
	(261),
	(277),
	(285),
	(289),
	(290),
	(291),
	(295),
	(304),
	(307),
	(320),
	(322),
	(323),
	(325),
	(334),
	(336),
	(337),
	(338),
	(339),
	(340),
	(341),
	(342),
	(349),
	(350),
	(351),
	(358),
	(360),
	(361),
	(364),
	(365),
	(368),
	(381),
	(390),
	(394),
	(397),
	(399),
	(405),
	(406),
	(410),
	(412),
	(427),
	(429),
	(435),
	(438),
	(441),
	(450),
	(452),
	(453),
	(458),
	(459),
	(461),
	(469),
	(472),
	(476),
	(479),
	(495);
/*!40000 ALTER TABLE `Serie` ENABLE KEYS */;

CREATE TABLE IF NOT EXISTS `Suscripcion` (
  `tipo` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `precio` int(11) DEFAULT NULL,
  `descripcion` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `numPantallas` int(11) DEFAULT NULL,
  PRIMARY KEY (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Suscripcion` DISABLE KEYS */;
INSERT INTO `Suscripcion` (`tipo`, `precio`, `descripcion`, `numPantallas`) VALUES
	('premium', 20, 'tarifa premium', 4);
/*!40000 ALTER TABLE `Suscripcion` ENABLE KEYS */;

DELIMITER //
CREATE DEFINER=`gi_streamua`@`%` FUNCTION `tipoUsuario`(email VARCHAR(50)) RETURNS int(11)
BEGIN

DECLARE auxEmail VARCHAR(50);
DECLARE tipo INT DEFAULT 1;

SELECT Administrador.email INTO auxEmail FROM Administrador WHERE Administrador.email = email;

if auxEmail IS NULL then

	SET tipo := 0;

END IF;

RETURN tipo;
END//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `Usuario` (
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `sesion` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` (`email`, `nombre`, `password`, `sesion`) VALUES
	('admin1@gmail.com', 'admin1', '27f237e6b7f96587b6202ff3607ad8', 0),
	('admin2@gmail.com', 'admin2', 'c6bdf6f65f3845da9085e9ae5790b4', 0),
	('chocolate@gmail.com', 'ivan', '???}???j?B?X?', 0),
	('cliente@email', 'ivan', 'ֱl??G?%3ejd?c?', 0),
	('cliente@gmail.com', '1234', '?C0?$a????`i???', 0),
	('nopuedomas@gmail.com', 'alejandro', 'g[<??F%?z>ˈ_!?', 0),
	('patriciovaalmedico@gmail.com', 'PATRICIO', '?B,@?|~Z???}?', 0),
	('sgs@gmail.com', 'ivan', '???}???j?B?X?', 0),
	('trucao@gmail.com', 'ivan', '???}???j?B?X?', 0);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;

SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY';
DELIMITER //
CREATE TRIGGER `actualizarValoracionMedia` AFTER INSERT ON `Seleccionar` FOR EACH ROW BEGIN
     UPDATE Contenido SET puntuacionMedia = ((SELECT SUM(puntuacion) FROM Seleccionar WHERE idContenido = NEW.idContenido)  /  (SELECT COUNT(puntuacion) FROM Seleccionar WHERE idContenido = NEW.idContenido))
			WHERE idContenido = NEW.idContenido;
  END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
