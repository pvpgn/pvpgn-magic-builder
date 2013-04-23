@echo off
:: This script output variable %DB_CHOICE% with db version

:: ARGUMENTS

:: database title
set DB_ENGINE=%1
:: directory where to list directories
set DB_DIR=%2
:: database configuration file with preset values
set config_file=%DB_ENGINE%.conf.bat

:: if db configuration file exists, call it
if exist %config_file% @call %config_file%

:: {PARAMETER}, if not empty skip db configuration choice
if not [%DB_VERSION%]==[] set CHOICE_DB_CONF=y& goto :db_configured

call %i18n% 2_1 %DB_ENGINE% "module\include\%DB_ENGINE%"

:choose_db
:: iterate and display directories, filling array
set numbers=
set /A counter=0
for /F %%v in ('dir /B /AD-H %DB_DIR%') do (
	set /A counter+=1
	set numbers=!numbers!!counter!
	if not [%%v]==[""] echo    !counter!^) %%v
)

echo.
:: user input is number of directory 
call %i18n% 2_2
module\choice /c:%numbers%
set _db_choice=%errorlevel%

:: iterate again to search chosen number of directory
set /A counter=0
for /F %%v in ('dir /B /AD-H %DB_DIR%') do (
	set /A counter+=1
	if [%_db_choice%]==[!counter!] set DB_VERSION=%%v
)

:: check for wrong input
::  FIXME: it's not need, because choice.exe don't allow wrong input
if [%DB_VERSION%]==[] call %i18n% 2_3  &  echo.  &  goto choose_db

call %i18n% 2_4 %DB_ENGINE% %DB_VERSION%



:: -----------------------------------
:: Ask user for a database configuration
:: -----------------------------------

:: default values
set _db_host=127.0.0.1
set _db_user=pvpgn
set _db_password=
set _db_name=pvpgn
set _db_prefix=

echo.
call module\i18n.inc.bat 2_5 %DB_ENGINE%
module\choice 
if %errorlevel%==2 ( set CHOICE_DB_CONF=n & goto :db_configured) else ( set CHOICE_DB_CONF=y)

:: SQLite and ODBC has not connection settings
if not [%DB_ENGINE%]==[SQLite] if not [%DB_ENGINE%]==[ODBC] (
	:: connection host
	echo.
	call module\i18n.inc.bat 2_6
	set /p _db_host=:
	
	:: connection username
	echo.
	call module\i18n.inc.bat 2_7 
	set /p _db_user=:

	:: connection password
	echo.
	call module\i18n.inc.bat 2_8
	set /p _db_password=:
)
:: (sqlite uses var\users.db)
if not [%DB_ENGINE%]==[SQLite] (
	:: database name
	echo.
	call module\i18n.inc.bat 2_9
	set /p _db_name=:
)


:: database tables prefix
echo.
call module\i18n.inc.bat 2_10 "pvpgn_"
set /p _db_prefix=:

echo.
call module\i18n.inc.bat 2_11 %DB_ENGINE%


:db_configured
if [%DB_ENGINE%]==[MySQL] set _db_mode=mysql
if [%DB_ENGINE%]==[PostgreSQL] set _db_mode=pgsql
if [%DB_ENGINE%]==[SQLite] set _db_mode=sqlite3
if [%DB_ENGINE%]==[ODBC] set _db_mode=odbc

:: SET CONFIG VAR 
set CONF_storage_path=storage_path = sql:mode=%_db_mode%;host=%_db_host%;name=%_db_name%;user=%_db_user%;pass=%_db_password%;default=0;prefix=%_db_prefix%

:: SQLite
if [%DB_ENGINE%]==[SQLite] set CONF_storage_path=storage_path = sql:mode=%_db_mode%;name=var\users.db;default=0;prefix=%_db_prefix%
:: ODBC
if [%DB_ENGINE%]==[ODBC] set CONF_storage_path=storage_path = sql:mode=%_db_mode%;name=%_db_name%;default=0;prefix=%_db_prefix%


:: SAVE DATABASE CONFIGURATION TO FILE

:: first delete previous config file
if exist %config_file% del /Q %config_file%

echo @echo off>%config_file%
echo set DB_VERSION=%DB_VERSION%>>%config_file%
if not [%DB_ENGINE%]==[SQLite] if not [%DB_ENGINE%]==[ODBC] (
	echo set _db_host=!_db_host!>>!config_file!
	echo set _db_user=!_db_user!>>!config_file!
	echo set _db_password=!_db_password!>>!config_file!
)
if not [%DB_ENGINE%]==[SQLite] (
	echo set _db_name=!_db_name!>>!config_file!
)
echo set _db_prefix=!_db_prefix!>>!config_file!



