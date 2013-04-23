@echo off

setlocal enabledelayedexpansion

::setlocal enableextensions enabledelayedexpansion

set /p CHOICE_DBTYPE=Choose a number: 
if [%CHOICE_DBTYPE%]==[2] (

	@call module\dbchoice.bat MySQL module\include\mysql\
	set DB_VERSION=!CHOICE_DB!

		:: path to directory with db headers and libs
	set DB_PATH=module\include\mysql\!DB_VERSION!\
		:: lib filename without extension (.lib and .dll)
	set DB_LIB=libmysql
		:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D MYSQL_INCLUDE_DIR=!DB_PATH! -D MYSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_MYSQL=true -D WITH_ANSI=false
)

echo %CMAKE_DB_VARS%


pause