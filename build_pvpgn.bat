rem Сделать локализацию на рус и англ
rem Проверялка новой версии
rem Логирование cmake и msbuild в папку log (создать в начале)


@echo off
TITLE PvPGN Magic Builder for Windows
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo  Copyright 2011, HarpyWar (harpywar@gmail.com)
echo  http://harpywar.com
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setlocal enabledelayedexpansion
@call module\i18n.bat

:: ----------- VARIABLES ------------
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

if ["%VSCOMNTOOLS%"]==[""] echo   Visual Studio was not found & goto THEEND



if ["%GENERATOR%"]==[""] echo Visual Studio C++ environment was not found! & goto THEEND


:: ----------- SETUP ------------
echo.
echo _______________________________[ S E T U P ]____________________________________

set /p CHOICE_SVN=Download/update the latest PvPGN source from the SVN? (y/n): 

:: if not "n", set to "y"
if not [%CHOICE_SVN%]==[n] ( 
	set CHOICE_SVN=y
	echo   PvPGN will update from the SVN
) else (
	echo   PvPGN will not update
)

echo.
echo -------------------------------------------------------------------------------



:choose_interface
echo Select a PvPGN interface: 
echo    1) Console (defaut)
echo    2) GUI
echo.
set /p CHOICE_INTERFACE=Choose a number: 

:: if not gui, set a console
if not [%CHOICE_INTERFACE%]==[2] (
	set CHOICE_INTERFACE=1
	echo   Set PvPGN interface as Console
) else (
	echo   Set PvPGN interface as GUI (Graphical User Interface)
)
echo.
echo --------------------------------------------------------------------------------

:choose_dbtype
echo Select a database type: 
echo    1) Plain (default)
echo    2) MySQL
echo.
set /p CHOICE_DBTYPE=Choose a number: 

:: if not any db selected, use plain
if not [%CHOICE_DBTYPE%]==[2] set CHOICE_DBTYPE=1

:: Plain
if [%CHOICE_DBTYPE%]==[1] (
	set CMAKE_DB_VARS=WITH_ANSI=true
	echo   PvPGN will build without database support
)

:: MySQL
if [%CHOICE_DBTYPE%]==[2] (
	echo.
	@call module\dbchoice.bat MySQL module\include\mysql\
	:: set user's choice as version
	set DB_VERSION=!CHOICE_DB!
	:: path to directory with db headers and libs
	set DB_PATH=module\include\mysql\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=libmysql

	:: cmake vars to add to command line
	set CMAKE_DB_VARS=-D MYSQL_INCLUDE_DIR=!DB_PATH! -D MYSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_MYSQL=true -D WITH_ANSI=false
)
echo.
echo _____________________________[ S T A R T ]______________________________________

:: ----------- DOWNLOAD ------------

@mkdir %PVPGN_SOURCE%

:: download latest pvpgn from the svn
if [%CHOICE_SVN%]==[y] module\tortoisesvn\svn.exe checkout %PVPGN_SVN% %PVPGN_SOURCE%


:: ----------- MAKE ------------
echo.
echo ______________________[ C M A K E  C O N F I G U R E ]__________________________

@mkdir %PVPGN_BUILD%

:: use win32 configs
@call :rename_conf

:: delete cmake cache
@del %PVPGN_BUILD%CMakeCache.txt

:: configure and generate solution
module\cmake\bin\cmake.exe -Wno-dev -G "%GENERATOR%" -D ZLIB_INCLUDE_DIR=%ZLIB_PATH% -D ZLIB_LIBRARY=%ZLIB_PATH%zlibwapi.lib %CMAKE_DB_VARS% -D WITH_WIN32_GUI=false -D SYSCONF_INSTALL_DIR="" -D CMAKE_INSTALL_PREFIX="" -H%PVPGN_SOURCE% -B%PVPGN_BUILD%

echo -Wno-dev -G "%GENERATOR%" -D ZLIB_INCLUDE_DIR=%ZLIB_PATH% -D ZLIB_LIBRARY=%ZLIB_PATH%zlibwapi.lib %CMAKE_DB_VARS% -D WITH_WIN32_GUI=false -H%PVPGN_SOURCE% -B%PVPGN_BUILD%

:: restore unix configs
@call :restore_conf

:: ----------- BUILD ------------
echo.
echo ______________[ B U I L D  W I T H  V I S U A L  S T U D I O ]__________________
:: check solution for exists 
IF NOT EXIST "%PVPGN_BUILD%pvpgn.sln" echo. & echo CMake failed & goto THEEND

:: load visual studio variables
@call "%VSCOMNTOOLS%vsvars32.bat"

:: vcexpress include dir
set INCLUDE=%VCEXPRESS_INCLUDE_PATH%;%INCLUDE%
:: use environments is different on each visual studio
if ["%VSVER%"]==["v100"] ( set useEnv=UseEnv=true ) else ( set useEnv=VCBuildUseEnvironment=true )


if ["%FrameworkDir%"]==[""] set FrameworkDir=%FrameworkDir32% & set FrameworkVersion=%FrameworkVersion32%
:: add slash if not vs2010
if not ["%VSVER%"]==["v100"] set FrameworkDir=%FrameworkDir%\
:: use framework 3.5 with vs2008
if ["%VSVER%"]==["v90"] set FrameworkVersion=%Framework35Version%
:: INFO: each environment should compile with own framework (e.g. 2010 can't compile with 3.5)


:: compile the solution
:: FIXME:  /maxcpucount is supports only vs2010
"%FrameworkDir%\%FrameworkVersion%\MSBuild.exe" %PVPGN_BUILD%pvpgn.sln /t:Rebuild /p:Configuration=Release;%useEnv%;PlatformToolset=%VSVER% /consoleloggerparameters:Summary;PerformanceSummary;Verbosity=minimal



:: ----------- RELEASE ------------
echo.
echo ______________________________[ R E L E A S E ]_________________________________
@mkdir %PVPGN_RELEASE%

:: copy binary files to release directory, without prompt
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


:: copy conf directory
@mkdir %PVPGN_RELEASE%conf
@copy %PVPGN_BUILD%conf\*.conf %PVPGN_RELEASE%conf
@copy %PVPGN_BUILD%conf\*.plain %PVPGN_RELEASE%conf
@copy %PVPGN_BUILD%conf\*.txt %PVPGN_RELEASE%conf
@copy %PVPGN_SOURCE%conf\d2server.ini %PVPGN_RELEASE%conf

:: copy files directory
@mkdir %PVPGN_RELEASE%files
@copy %PVPGN_SOURCE%files %PVPGN_RELEASE%files
@del %PVPGN_RELEASE%files\CMakeLists.txt
@del %PVPGN_RELEASE%files\Makefile.am

:: copy pvpgnsupport to files directory
@copy %SUPPORTFILES_PATH% %PVPGN_RELEASE%files

:: copy var directories (they're empty)
@xcopy %PVPGN_BUILD%\files\var\* %PVPGN_RELEASE%\var\ /E


goto THEEND

:rename_conf
	:: erase build and release directories
	@erase %PVPGN_RELEASE%
	@erase %PVPGN_BUILD%

	:: rename .in to .in.bak
	@ren %PVPGN_SOURCE%conf\bnetd.conf.in bnetd.conf.in.bak
	@ren %PVPGN_SOURCE%conf\d2cs.conf.in d2cs.conf.in.bak
	@ren %PVPGN_SOURCE%conf\d2dbs.conf.in d2dbs.conf.in.bak
	:: copy .win32 to .in
	@copy %PVPGN_SOURCE%conf\bnetd.conf.win32 %PVPGN_SOURCE%conf\bnetd.conf.in
	@copy %PVPGN_SOURCE%conf\d2cs.conf.win32 %PVPGN_SOURCE%conf\d2cs.conf.in
	@copy %PVPGN_SOURCE%conf\d2dbs.conf.win32 %PVPGN_SOURCE%conf\d2dbs.conf.in
	exit /b 0

:restore_conf
	:: delete .in
	@del %PVPGN_SOURCE%conf\bnetd.conf.in
	@del %PVPGN_SOURCE%conf\d2cs.conf.in
	@del %PVPGN_SOURCE%conf\d2dbs.conf.in
	:: rename .in.bak to .in
	@ren %PVPGN_SOURCE%conf\bnetd.conf.in.bak bnetd.conf.in
	@ren %PVPGN_SOURCE%conf\d2cs.conf.in.bak d2cs.conf.in
	@ren %PVPGN_SOURCE%conf\d2dbs.conf.in.bak d2dbs.conf.in
	exit /b 0

:THEEND
echo.
echo ___________________________[ C O M P L E T E ]__________________________________
:: wait for any key
Pause