@echo off
setlocal enabledelayedexpansion

:: LOG=false output cmake and vs output to console
:: LOG=true logs cmake and vs output to cmake.log, visualstudio.log
set LOG=false

TITLE PvPGN Magic Builder for Windows
color 1f
echo.
echo ******************* P v P G N  M a g i c  B u i l d e r ***********************
echo *                                                                             *
echo *   Copyright 2011, HarpyWar (harpywar@gmail.com)                             *
echo *   http://harpywar.com                                                       *
echo *                                                                             *
echo *******************************************************************************
cd /D %~dp0

:: localization
@call module\i18n.inc.bat
set i18n=module\i18n.inc.bat

:: ----------- VARIABLES ------------
@set URL_UPDATE=http://pvpgn-magic-builder.googlecode.com/svn/trunk/

:: path where this batch placed
@set CUR_PATH=%~dp0%~1

@set PVPGN_SOURCE=source\
@set PVPGN_BUILD=build\
@set PVPGN_RELEASE=release\

@set PVPGN_SVN=svn://svn.berlios.de/pvpgn/trunk/pvpgn

@set ZLIB_PATH=module\include\zlib\125\
@set SUPPORTFILES_PATH=module\include\pvpgn-support-1.2\
@set VCEXPRESS_INCLUDE_PATH=%CUR_PATH%module\include\vsexpress_include\



:: try to find a visual studio
::  cmake generator name (Visual Studio 7 .NET 2003, Visual Studio 8 2005, Visual Studio 9 2008, Visual Studio 10)
::  visual studio version to build (v71 (2003), v80 (2005), v90 (2008), v100 (2010))
::  2003 is not supported, 2005 is full version required (express is not supported), 2008 and 2010 fully supports
::    If you want to use VSExpress 2005, you should follow this instructions http://social.msdn.microsoft.com/forums/en-US/Vsexpressvc/thread/c5c3afad-f4c6-4d27-b471-0291e099a742/
if not ["%VS71COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS71COMNTOOLS%& set GENERATOR=Visual Studio 7 .NET 2003& set VSVER=v71
if not ["%VS80COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS80COMNTOOLS%& set GENERATOR=Visual Studio 8 2005& set VSVER=v80
if not ["%VS90COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS90COMNTOOLS%& set GENERATOR=Visual Studio 9 2008& set VSVER=v90
if not ["%VS100COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS100COMNTOOLS%& set GENERATOR=Visual Studio 10& set VSVER=v100

if ["%VSCOMNTOOLS%"]==[""] call %i18n% 1_1 & goto THEEND



if ["%GENERATOR%"]==[""] call %i18n% 1_2 & goto THEEND

:: ----------- SETUP ------------
echo.
echo ______________________________[ U P D A T E ]___________________________________

:: check for update 
@call module\autoupdate\check_for_update.inc.bat %URL_UPDATE%

echo.


:: ----------- SETUP ------------
echo.
echo _______________________________[ S E T U P ]____________________________________

call %i18n% 1_3
choice
if %errorlevel%==2 set CHOICE_SVN=n

:: if not "n", set to "y"
if not [%CHOICE_SVN%]==[n] ( 
	set CHOICE_SVN=y
	call %i18n% 1_4
) else (
	call %i18n% 1_5
)

echo.
echo --------------------------------------------------------------------------------



:choose_interface
call %i18n% 1_6
call %i18n% 1_7
call %i18n% 1_8
echo.
call %i18n% 1_9
choice /c:12
set CHOICE_INTERFACE=%errorlevel%

:: gui or console has choosen
if not [%CHOICE_INTERFACE%]==[2] (
	call %i18n% 1_10
) else (
	call %i18n% 1_11
)
echo.
echo --------------------------------------------------------------------------------

:choose_dbtype
call %i18n% 1_12
call %i18n% 1_13
echo     2) MySQL
echo     3) PostgreSQL
echo     4) SQLite
echo     5) ODBC
echo.
call %i18n% 1_9
choice /c:12345
set CHOICE_DBTYPE=%errorlevel%

:: if not any db selected, use plain
if not [%CHOICE_DBTYPE%]==[2] if not [%CHOICE_DBTYPE%]==[3] if not [%CHOICE_DBTYPE%]==[4] if not [%CHOICE_DBTYPE%]==[5] set CHOICE_DBTYPE=1

:: Plain
if [%CHOICE_DBTYPE%]==[1] (
	set CMAKE_DB_VARS=WITH_ANSI=true
	call %i18n% 1_15
)

:: MySQL
if [%CHOICE_DBTYPE%]==[2] (
	echo.
	@call module\dbchoice.inc.bat MySQL module\include\mysql\
	:: set user's choice as version
	set DB_VERSION=!CHOICE_DB!
	:: path to directory with db headers and libs
	set DB_PATH=module\include\mysql\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=libmysql

	:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D MYSQL_INCLUDE_DIR=!DB_PATH! -D MYSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_MYSQL=true -D WITH_ANSI=false
)
:: PostgreSQL
if [%CHOICE_DBTYPE%]==[3] (
	echo.
	@call module\dbchoice.inc.bat PostgreSQL module\include\pgsql\
	:: set user's choice as version
	set DB_VERSION=!CHOICE_DB!
	:: path to directory with db headers and libs
	set DB_PATH=module\include\pgsql\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=libpq

	:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D PGSQL_INCLUDE_DIR=!DB_PATH! -D PGSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_PGSQL=true
)
:: SQLite
if [%CHOICE_DBTYPE%]==[4] (
	echo.
	@call module\dbchoice.inc.bat SQLite module\include\sqlite\
	:: set user's choice as version
	set DB_VERSION=!CHOICE_DB!
	:: path to directory with db headers and libs
	set DB_PATH=module\include\sqlite\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=sqlite3

	:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D SQLITE3_INCLUDE_DIR=!DB_PATH! -D SQLITE3_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_SQLITE3=true
)
:: ODBC
if [%CHOICE_DBTYPE%]==[5] (
	echo.
	@call module\dbchoice.inc.bat ODBC module\include\odbc\
	:: set user's choice as version
	set DB_VERSION=!CHOICE_DB!
	:: path to directory with db headers and libs
	set DB_PATH=module\include\odbc\!DB_VERSION!\
	:: lib filename without extension (.lib, ODBC does not need a dll, because it already exists in the system32)
	set DB_LIB=odbc32

	:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D ODBC_INCLUDE_DIR=!DB_PATH! -D ODBC_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_ODBC=true
)

echo.
echo _____________________________[ S T A R T ]______________________________________

:: ----------- DOWNLOAD ------------
if [%LOG%]==[true] set _svn_log=^>svn.log
mkdir %PVPGN_SOURCE%

:: download latest pvpgn from the svn
if [%CHOICE_SVN%]==[y] module\tortoisesvn\svn.exe checkout %PVPGN_SVN% %PVPGN_SOURCE% %_svn_log%


:: ----------- MAKE ------------
echo.
echo ______________________[ C M A K E  C O N F I G U R E ]__________________________
if [%LOG%]==[true] set _cmake_log= ^>cmake.log
mkdir %PVPGN_BUILD%

:: use win32 configs
@call :backup_conf

:: delete cmake cache
del %PVPGN_BUILD%CMakeCache.txt

if [%CHOICE_INTERFACE%]==[1] ( set _with_gui=false) else ( set _with_gui=true)

:: configure and generate solution
module\cmake\bin\cmake.exe -Wno-dev -G "%GENERATOR%" -D ZLIB_INCLUDE_DIR=%ZLIB_PATH% -D ZLIB_LIBRARY=%ZLIB_PATH%zlibwapi.lib %CMAKE_DB_VARS% -D WITH_WIN32_GUI=%_with_gui% -D CMAKE_INSTALL_PREFIX="" -H%PVPGN_SOURCE% -B%PVPGN_BUILD% %_cmake_log%


:: ----------- BUILD ------------
echo.
echo ______________[ B U I L D  W I T H  V I S U A L  S T U D I O ]__________________
:build
if [%LOG%]==[true] set _vs_log=^>visualstudio.log

:: check solution for exists 
IF NOT EXIST "%PVPGN_BUILD%pvpgn.sln" echo. & call %i18n% 1_16 & goto THEEND

:: load visual studio variables
@call "%VSCOMNTOOLS%vsvars32.bat"

:: vcexpress include dir
set INCLUDE=%VCEXPRESS_INCLUDE_PATH%;%INCLUDE%
:: use environments is different on each visual studio
if ["%VSVER%"]==["v100"] ( set useEnv=UseEnv=true) else ( set useEnv=VCBuildUseEnvironment=true)


if ["%FrameworkDir%"]==[""] set FrameworkDir=%FrameworkDir32% & set FrameworkVersion=%FrameworkVersion32%
:: add slash if not vs2010
if not ["%VSVER%"]==["v100"] set FrameworkDir=%FrameworkDir%\
:: use framework 3.5 with vs2008
if ["%VSVER%"]==["v90"] set FrameworkVersion=%Framework35Version%
:: INFO: each environment should compile with own framework (e.g. 2010 can't compile with 3.5)


:: compile the solution
:: FIXME:  /maxcpucount is supports only vs2010
"%FrameworkDir%\%FrameworkVersion%\MSBuild.exe" "%PVPGN_BUILD%pvpgn.sln" /t:Rebuild /p:Configuration=Release;%useEnv% /consoleloggerparameters:Summary;PerformanceSummary;Verbosity=minimal %_vs_log%



:: ----------- RELEASE ------------
echo.
echo ______________________________[ R E L E A S E ]_________________________________

:: restore unix configs (only after build! because it uses source directory while compile)
@call :restore_conf

@mkdir %PVPGN_RELEASE%

:: copy conf directory
@mkdir %PVPGN_RELEASE%conf
@copy /Y %PVPGN_BUILD%conf\*.conf %PVPGN_RELEASE%conf
@copy /Y %PVPGN_BUILD%conf\*.plain %PVPGN_RELEASE%conf
@copy /Y %PVPGN_BUILD%conf\*.txt %PVPGN_RELEASE%conf
@copy /Y %PVPGN_SOURCE%conf\d2server.ini %PVPGN_RELEASE%conf


:: copy libraries to release directory, without prompt
@copy /B /Y %ZLIB_PATH%*.dll %PVPGN_RELEASE%
if not [%DB_LIB%]==[] @copy /B /Y %DB_PATH%*.dll %PVPGN_RELEASE%

if [%CHOICE_INTERFACE%]==[1] set postfix=Console

:: copy release binaries
@copy /B /Y %PVPGN_BUILD%src\bnetd\Release\bnetd.exe %PVPGN_RELEASE%PvPGN%postfix%.exe
@copy /B /Y %PVPGN_BUILD%src\d2cs\Release\d2cs.exe %PVPGN_RELEASE%d2cs%postfix%.exe
@copy /B /Y %PVPGN_BUILD%src\d2dbs\Release\d2dbs.exe %PVPGN_RELEASE%d2dbs%postfix%.exe
@copy /B /Y %PVPGN_BUILD%src\bniutils\Release\bni2tga.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bniutils\Release\bnibuild.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bniutils\Release\bniextract.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bniutils\Release\bnilist.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bniutils\Release\tgainfo.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bnpass\Release\bnpass.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\bnpass\Release\sha1hash.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\client\Release\bnbot.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\client\Release\bnchat.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\client\Release\bnftp.exe %PVPGN_RELEASE%
@copy /B /Y %PVPGN_BUILD%src\client\Release\bnstat.exe %PVPGN_RELEASE%

:: copy files directory
@mkdir %PVPGN_RELEASE%files
@copy /Y %PVPGN_SOURCE%files %PVPGN_RELEASE%files
@del %PVPGN_RELEASE%files\CMakeLists.txt
@del %PVPGN_RELEASE%files\Makefile.am

:: copy pvpgnsupport to files directory
@copy /Y %SUPPORTFILES_PATH% %PVPGN_RELEASE%files

:: copy var directories (they're empty)
@xcopy %PVPGN_BUILD%\files\var\* %PVPGN_RELEASE%\var\ /E

:: create bnmotd from the determined language
@copy /Y %PVPGN_RELEASE%conf\bnmotd-%MOTD_LANGUAGE%.txt %PVPGN_RELEASE%conf\bnmotd.txt

:: replace "storage_path"
if ["%CHOICE_DB_CONF%"]==["y"] (
	for /f "delims=" %%a in ('cscript "module\replace_line.vbs" "release\conf\bnetd.conf" "storage_path" "!CONF_storage_path!"') do set res=%%a
	if ["!res!"]==["ok"] ( echo storage_path updated in bnetd.conf ) else ( echo Error: storage_path was not updated in bnetd.conf )
)

goto THEEND

:backup_conf
	:: erase build and release directories
	erase /S /Q %PVPGN_RELEASE%*.*>nul
	erase /S /Q %PVPGN_BUILD%*.*>nul
	::@rmdir /s /q %PVPGN_RELEASE%*.*
	::@rmdir /s /q %PVPGN_RELEASE%*.*
	
	@call module\recursive_copy.inc.bat module\include\source_replace\ ..\..\..\source\ backup
	exit /b 0

:restore_conf
	@call module\recursive_copy.inc.bat module\include\source_replace\ ..\..\..\source\ restore
	exit /b 0

	
:THEEND
echo.
echo ___________________________[ C O M P L E T E ]__________________________________
:: wait for any key
Pause