@echo off
:: This script output variable %DB_CHOICE% with db version

:: ARGUMENTS

:: database title
set DB_ENGINE=%1
:: directory where to list directories
set DB_DIR=%2

call %i18n% 2_1 %DB_ENGINE%


:choose_db
:: iterate and display directories, filling array
set version_list[0]=0
set /A counter=0
for /F %%v in ('dir /B /AD-H %DB_DIR%') do (
	set /A counter+=1
	if not [%%v]==[""] echo    !counter!^) %%v
)

echo.
:: user input is number of directory 
call %i18n% 2_2
set /p choice=: 

:: iterate again to search chosen number of directory
set /A counter=0
for /F %%v in ('dir /B /AD-H %DB_DIR%') do (
	set /A counter+=1
	if [%choice%]==[!counter!] set CHOICE_DB=%%v
)

:: check for wrong input
if [%CHOICE_DB%]==[] call %i18n% 2_3  &  echo.  &  goto choose_db

call %i18n% 2_4 %DB_ENGINE% %CHOICE_DB%



:: -----------------------------------
:: Ask user for a database configuration
:: -----------------------------------

:: default values
set _db_host=127.0.0.1
set _db_user=pvpgn
set _db_password=pvpgnrocks
set _db_name=pvpgn
set _db_prefix=pvpgn_

echo.
call module\i18n.inc.bat 2_5 %DB_ENGINE%
set /p CHOICE_DB_CONF=(y/n): 

if not [%CHOICE_DB_CONF%]==[y] goto :eof

:: SQLite has not connection settings
if not [%DB_ENGINE%]==[SQLite] (
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
	
	:: database name (sqlite uses var\users.db)
	echo.
	call module\i18n.inc.bat 2_9
	set /p _db_name=: 
)


:: database tables prefix
echo.
call module\i18n.inc.bat 2_10
set /p _db_prefix=: 

echo.
call module\i18n.inc.bat 2_11 %DB_ENGINE%


if [%DB_ENGINE%]==[MySQL] set _db_mode=mysql
if [%DB_ENGINE%]==[PostgreSQL] set _db_mode=pgsql
if [%DB_ENGINE%]==[SQLite] set _db_mode=sqlite3

:: SET CONFIG VAR 
set CONF_storage_path=storage_path = sql:mode=%_db_mode%;host=%_db_host%;name=%_db_name%;user=%_db_user%;pass=%_db_password%;default=0;prefix=%_db_prefix%

:: SQLite
if [%DB_ENGINE%]==[SQLite] set CONF_storage_path=storage_path = sql:mode=%_db_mode%;name=var\users.db;default=0;prefix=%_db_prefix%
