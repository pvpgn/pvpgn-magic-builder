@echo off
:: -----------------------------------------------
:: Language:    Spanish
:: Author:      Joaquin Cabrera (jmcc3001@gmail.com)
:: -----------------------------------------------
:: Code Page:   850
:: Encoding:    OEM 850


set PHRASE_0_0=^^!^^!^^! PELIGRO ^^!^^!^^!
set PHRASE_0_1=Magic Builder tiene que estar ubicado en una ruta sin espacios, letras unicode y caracteres especiales (_.- están permitidos).
set PHRASE_0_2=Por ejemplo: %2

set PHRASE_1_0=  Visual Studio no está instalado
set PHRASE_1_1=Seleccione una versión de Visual Studio para construir PvPGN:
set PHRASE_1_2=%2 ha sido seleccionado como entorno de construcción
set PHRASE_1_3=¿Le gustaría descargar/reemplazar la ultima fuente de PvPGN desde Git (dentro del directorio %2)?
set PHRASE_1_4=   El código de fuente PvPGN será reemplazado desde Git sucursal %2
set PHRASE_1_5=   El código de fuente PvPGN no será actualizado
set PHRASE_1_6=Seleccione interfaz PvPGN: 
set PHRASE_1_7=   1) Consola (Predeterminado)
set PHRASE_1_8=   2) Interfaz de Usuario Gráfica
set PHRASE_1_9=Seleccione un número
set PHRASE_1_10=   Establecer interfaz PvPGN como Consola
set PHRASE_1_11=   Establecer interfaz PvPGN como IUG (Interfaz de Usuario Gráfica)
set PHRASE_1_12=Seleccione un tipo de base de datos: 
set PHRASE_1_13=   1) Simple / CDB (Predeterminado)
set PHRASE_1_14=
set PHRASE_1_15=   PvPGN será construido sin soporte de base de datos
set PHRASE_1_16=Configuración CMake ha fallado

set PHRASE_2_1=%2 versiones disponibles (Puedes añadir las tuyas en %3):
set PHRASE_2_2=   Ingrese un número
set PHRASE_2_3=   Número incorrecto... Intente de nuevo
set PHRASE_2_4=   PvPGN será compilado con %2 soporte v%3 
set PHRASE_2_5=¿Quieres configurar ajustes para %2 ahora (bnetd.conf ^> ruta_de_almacenamiento)?
set PHRASE_2_6=    Anfitrión de Conexión
set PHRASE_2_7=    Usuario de Conexión
set PHRASE_2_8=    Contraseña de Conexión
set PHRASE_2_9=    Nombre de Base de Datos
set PHRASE_2_10=    Prefijo de tabla (Predeterminado es %2)
set PHRASE_2_11=La configuración de %2 será guardada en %2.conf.bat

set PHRASE_3_1=Buscando actualización ...
set PHRASE_3_2="v%2" es tu versión
set PHRASE_3_3="v%2" es la versión remota
set PHRASE_3_4= Tienes el último PvPGN Magic Builder
set PHRASE_3_5=La versión remota de PvPGN Magic Builder no es igual a la tuya. ¿Quieres actualizar a la última version automaticamente?
set PHRASE_3_6= La actualización ha sido cancelada por el usuario
set PHRASE_3_6_1= No hay conexión con el servidor de actualización
set PHRASE_3_7=Comenzando actualización ...
set PHRASE_3_8= Descargando archivo %2 ...
set PHRASE_3_9=Actualización completada
set PHRASE_3_10=Por favor, revise el archivo %2 para más información sobre los cambios

set PHRASE_4_1=¿Habilitar soporte Lua scripting ?
set PHRASE_4_2=   PvPGN será compilado con Lua
set PHRASE_4_3=   PvPGN será compilado sin Lua

set PHRASE_9_1=Seleccione su versión de D2GS:
set PHRASE_9_2=Establezca contraseña administrativa para conexión Telnet (Escuchando en puerto 8888), será guardado en d2gs.reg
set PHRASE_9_3=Contraseña hash será guardada en %2
set PHRASE_9_4=¿Quieres descargar archivos MPQ esenciales y originales? (size 1GB)
set PHRASE_9_9=^^!^^!^^! Para terminar configurando D2GS editar d2gs.reg y ejecutar install.bat ^^!^^!^^!
