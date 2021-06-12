# StreamUA

![alt text](https://github.com/ivanmmurciaua/streamua/blob/main/img/streamua.png?raw=true)

## Índice

* [Integrantes del grupo](#team-members)
* [Descripción](#description)
* [Parte Pública](#public-part)  
* [Parte Privada](#private-part)
* [Parte Privada](#private-part-admin)
* [Instrucciones para el funcionamiento de la aplicación](#Instrucctions)
* [Presentación](#presentation)
* [Problemas Asociados](#asociated-problems)

## <a name="team-members"></a>Integrantes del grupo
* Iván Mañús Murcia
* Lucía Fernández Marín
* Jose María Muela Bernabeu
* Pedro Pelegrín Mateo
* Alejandro Ureña Blasco
* Rafael Sanchez Segura

## <a name="description"></a>Descripción
Plataforma de Streaming de contenido por suscripción, tendencia que se ha establecido para luchar contra la piratería y la desaparición de los videoclubs.

## <a name="public-part"></a>Parte Pública
Los clientes **no-registrados** podrán:
* Visualizar el index
* Visualizar el listado de las novedades
* Visualizar el listado de las series
* Visualizar el listado de las peliculas
* Visualizar el detalle de todo el contenido
* Buscar en el buscador
* Registrarse
* Iniciar sesión

## <a name="private-part"></a>Parte Privada
Los clientes **registrados** podrán:
* Añadir contenido a "Mi lista"
* Valorar el contenido
* Cerrar sesión

## <a name="private-part-admin"></a>Parte Privada Admin
Los **admins** podrán:
* Añadir contenido
* Añadir código promoción
* Añadir novedades
* Añadir una carátula al contenido
* Listar novedades
* Listar contenido
* Listar codigos de promoción

## <a name="Instrucctions"></a> Instrucciones para el funcionamiento de la aplicación:
  * Clonar repositorio en un servidor web
  * Abrir los puertos del DLSI de la Universidad de Alicante ( https://bbdd.dlsi.ua.es/abrirpuertomysql.php )
  * Iniciar el servidor web y acceder a la página
  
  Para nuestra aplicación en concreto, como tenemos sistema de **inicio de sesión** y de **registro** aportamos dos _cuentas_ para pruebas en la correccion, una de administrador y otra de usuario:

### Cliente estándar
  
  - Usuario : **cliente@gmail.com**
  - Contraseña: **1234**
  
### Administrador

  - Usuario: **admin1@gmail.com**
  - Contraseña: **ivan**

## <a name="presentation"></a> La presentación realizada en clase se encuentra en la carpeta /presentacion/streamUA.pdf

## <a name="asociated-problems"></a>Problemas asociados:

  -La mayoría de los cambios se han dado en el esquema inicial, ya que en un primer momento debido a no pensar mucho en la implementación cometimos fallos de concepto.
  -En menor medida, algunos problemas asociados a la base de datos como rediseño de procedures, functions y triggers.