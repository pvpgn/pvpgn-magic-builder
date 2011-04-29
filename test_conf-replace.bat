@echo off

setlocal enabledelayedexpansion


:: 1. FILL VARS WITH USER INPUT

@call module\i18n.inc.bat
set DB_ENGINE=mysql

set DB_HOST=127.0.0.1
set DB_USER=pvpgn
set DB_PASSWORD=
set DB_NAME=pvpgn
set DB_PREFIX=

call module\i18n.inc.bat 2_5 %DB_ENGINE%
set /p CHOICE_DB_CONF=(y/n): 

if not [%CHOICE_DB_CONF%]==[y] goto :eof

call module\i18n.inc.bat 2_6
set /p DB_HOST=: 

echo.
call module\i18n.inc.bat 2_7 
set /p DB_USER=: 

echo.
call module\i18n.inc.bat 2_8
set /p DB_PASSWORD=: 

echo.
call module\i18n.inc.bat 2_9
set /p DB_NAME=: 

echo.
call module\i18n.inc.bat 2_10
set /p DB_PREFIX=: 

echo.
call module\i18n.inc.bat 2_11 %DB_ENGINE%


:: 2. SET CONFIG VARS
:: new string
set CONF_storage_path=storage_path = sql:mode=mysql;host=%DB_HOST%;name=%DB_NAME%;user=%DB_USER%;pass=%DB_PASS%;default=0;prefix=%DB_PREFIX%
:: sqlite
if [%DB_ENGINE%]==[SQLite] set storage_path=storage_path = sql:mode=sqlite3;name=var\%DB_NAME%;default=0;prefix=%DB_PREFIX%



:: 3. REPLACE CONF AT THE END OF SCRIPT
set str_file=release\conf\bnetd.conf

:: replace "storage_path"
for /f "delims=" %%a in ('cscript module\replace_line.vbs "%str_file%" "storage_path" "%CONF_storage_path%"') do set res=%%a
if ["%res%"]==["ok"] ( echo storage_path updated in bnetd.conf ) else ( echo Error: storage_path was not updated in bnetd.conf )

