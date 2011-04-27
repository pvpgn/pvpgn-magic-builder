@echo off

set DB_NAME=mysql
set DB_DIR=module\include\mysql\


setlocal enabledelayedexpansion


echo Available %DBNAME% versions (you can add your own into modules\include\%DB_NAME%):

set version[0]=0

:loop
set /A count=0
for /F %%v in ('dir /B /AD-H %DB_DIR%') do call :DIR_LIST %%v

echo.
set /p choice=Select %DBNAME% version number to compile: 

call module\array.bat getitem version %choice% CHOICE_DB

if [%CHOICE_DB%]==[] goto wrong_choice
if [%CHOICE_DB%]==[0] goto wrong_choice

echo %DB_NAME% v%CHOICE_DB%

goto end

:DIR_LIST
	set /A count+=1 

	if not [%1]==[""] echo    !count!) %1

	if [!count!]==[2] set MYSQL_VERSION=%1
	::set mysqlArray.!count!=%1
	call module\array.bat add version %1
	goto end

:wrong_choice
	echo Wrong version... try again 
	echo. 
	goto loop


:end