@echo off
:: This script output variable %DB_CHOICE% with db version

:: ARGUMENTS

:: database title
set DB_NAME=%1
:: directory where to list directories
set DB_DIR=%2

call %i18n% 2_1 %DB_NAME%


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

call %i18n% 2_4 %DB_NAME% %CHOICE_DB%