@echo off
setlocal enabledelayedexpansion

TITLE PvPGN Magic Builder for Windows
color 1f
echo.
echo *:*:*:*:*:*:*:*:*-  P v P G N  M a g i c  B u i l d e r  -*:*:*:*:*:*:*:*:*:*:*
echo *                                                                             *
echo *   Copyright 2011-2020, HarpyWar (harpywar@gmail.com)                        *
echo *   https://pvpgn.pro                                                         *
echo *                                                                             *
echo *:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*:*

@call module\config.inc.bat


:: disallow invalid characters in the path (otherwise cmake fails configuration)
for /f "delims=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:\-_." %%a in ("%CURRENT_PATH%") do set invalid_path=true
if [%invalid_path%]==[true] (
	echo.
	call %i18n% 0_0
	echo.
	call %i18n% 0_1
	echo.
	call %i18n% 0_2 C:\pvpgn-magic-builder\
	goto THEEND
)



:: PARAMETERS TO REBUILD
::  !order is important!
set PARAM_REBUILD=%1
set PARAM_VS=%2
set PARAM_INTERFACE=%3
set PARAM_DBTYPE=%4
set PARAM_LUA=%5
set PARAM_BUILDTYPE=%6

:: build type can be Debug or Release
if "%PARAM_BUILDTYPE%"=="Debug" (
	@set PVPGN_RELEASE=debug\
	echo.
	echo    Debug build type is selected
	echo.
) else ( 
	set PARAM_BUILDTYPE=Release
	:: directory with ready files
	set PVPGN_RELEASE=release\
)


:: {PARAMETER}, if not empty, skip autoupdate
if not [%PARAM_REBUILD%]==[] goto :select_vs

:: ----------- SETUP ------------
echo.
echo ______________________________[ U P D A T E ]___________________________________

:: check for update 
@call module\autoupdate\check_for_update.inc.bat %URL_UPDATE%

echo.


:: ----------- SETUP ------------
echo.
echo _______________________________[ S E T U P ]____________________________________

:select_vs
:: try to find a visual studio
@call module\select_generator.inc.bat
if [%VS_NOT_INSTALLED%]==[true] call %i18n% 1_0 & goto THEEND


echo.
echo --------------------------------------------------------------------------------

:: {PARAMETER}, if not empty, skip GIT update
if not [%PARAM_REBUILD%]==[] goto :choose_interface

call %i18n% 1_3 "source"
choice
if %errorlevel%==2 ( set CHOICE_GIT=n) else ( set CHOICE_GIT=y)

:: if not "n", set to "y"
if not [%CHOICE_GIT%]==[n] ( 
	@call module\select_branch.inc.bat
	call %i18n% 1_4 "!BRANCH!"
) else (
	call %i18n% 1_5
)

echo.
echo --------------------------------------------------------------------------------

:choose_interface
:: {PARAMETER}, if not empty replace value and skip choice
if not [%PARAM_INTERFACE%]==[] set CHOICE_INTERFACE=%PARAM_INTERFACE%& goto :interface_chosen


call %i18n% 1_6
call %i18n% 1_7
call %i18n% 1_8
echo.
call %i18n% 1_9
choice /c:12
set CHOICE_INTERFACE=%errorlevel%
set PARAM_INTERFACE=%CHOICE_INTERFACE%

:: gui or console has choosen
:interface_chosen
if not [%CHOICE_INTERFACE%]==[2] (
	call %i18n% 1_10
) else (
	call %i18n% 1_11
)

echo.
echo --------------------------------------------------------------------------------

:: {PARAMETER}, if not empty replace value and skip choice
if not [%PARAM_DBTYPE%]==[] set CHOICE_DBTYPE=%PARAM_DBTYPE%& goto :dbtype_chosen

:choose_dbtype
call %i18n% 1_12
call %i18n% 1_13
echo    2) MySQL
echo    3) PostgreSQL
echo    4) SQLite3
echo    5) ODBC
echo.
call %i18n% 1_9
choice /c:12345
set CHOICE_DBTYPE=%errorlevel%
set PARAM_DBTYPE=%CHOICE_DBTYPE%

:dbtype_chosen

:: if not any db selected, use plain
if not [%CHOICE_DBTYPE%]==[2] if not [%CHOICE_DBTYPE%]==[3] if not [%CHOICE_DBTYPE%]==[4] if not [%CHOICE_DBTYPE%]==[5] set CHOICE_DBTYPE=1

:: Plain
if [%CHOICE_DBTYPE%]==[1] (
	call %i18n% 1_15
)

:: MySQL
if [%CHOICE_DBTYPE%]==[2] (
	echo.
	@call module\dbchoice.inc.bat MySQL module\include\mysql\
	:: path to directory with db headers and libs
	set DB_PATH=module\include\mysql\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=libmysql

	:: cmake vars to add to command line
	set CMAKE_VARS=-D MYSQL_INCLUDE_DIR=!DB_PATH! -D MYSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_MYSQL=true -D WITH_ANSI=false
)
:: PostgreSQL
if [%CHOICE_DBTYPE%]==[3] (
	echo.
	@call module\dbchoice.inc.bat PostgreSQL module\include\pgsql\
	:: path to directory with db headers and libs
	set DB_PATH=module\include\pgsql\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=libpq

	:: cmake vars to add to command line
	set CMAKE_VARS=-D PGSQL_INCLUDE_DIR=!DB_PATH! -D PGSQL_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_PGSQL=true
)
:: SQLite
if [%CHOICE_DBTYPE%]==[4] (
	echo.
	@call module\dbchoice.inc.bat SQLite module\include\sqlite\
	:: path to directory with db headers and libs
	set DB_PATH=module\include\sqlite\!DB_VERSION!\
	:: lib filename without extension (.lib and .dll)
	set DB_LIB=sqlite3

	:: cmake vars to add to command line
	set CMAKE_VARS=-D SQLITE3_INCLUDE_DIR=!DB_PATH! -D SQLITE3_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_SQLITE3=true
)
:: ODBC
if [%CHOICE_DBTYPE%]==[5] (
	echo.
	@call module\dbchoice.inc.bat ODBC module\include\odbc\
	:: path to directory with db headers and libs
	set DB_PATH=module\include\odbc\!DB_VERSION!\
	:: lib filename without extension (.lib, ODBC does not need a dll, because it already exists in the system32)
	set DB_LIB=odbc32

	:: cmake vars to add to command line
	set CMAKE_VARS=-D ODBC_INCLUDE_DIR=!DB_PATH! -D ODBC_LIBRARY=!DB_PATH!!DB_LIB!.lib -D WITH_ODBC=true
)

echo.
echo --------------------------------------------------------------------------------

:: {PARAMETER}, if not empty replace value and skip choice
if not [%PARAM_LUA%]==[] set CHOICE_LUA=%PARAM_LUA%& goto :lua_chosen

call %i18n% 4_1
choice
if %errorlevel%==2 ( set CHOICE_LUA=n) else ( set CHOICE_LUA=y)
set PARAM_LUA=%CHOICE_LUA%

:: lua has choosen or not
:lua_chosen
if not [%CHOICE_LUA%]==[n] ( 
	call %i18n% 4_2
	set CMAKE_VARS=%CMAKE_VARS% -D LUA_INCLUDE_DIR=%LUA_PATH% -D LUA_LIBRARY=%LUA_PATH%lua5.1.lib -D WITH_LUA=true
) else (
	call %i18n% 4_3
)



echo.
echo _____________________[ P V P G N  S O U R C E  C O D E]_________________________


:: ----------- DOWNLOAD ------------

:: {PARAMETER}, if empty then download source code
if [%PARAM_REBUILD%]==[] (
	if [%LOG%]==[true] set _zip_log=^>download.log
	if not exist %PVPGN_SOURCE% mkdir %PVPGN_SOURCE%

	if not [%CHOICE_GIT%]==[n] ( 
		set PVPGN_ZIP=%PVPGN_PATH%!BRANCH!.zip
	
		:: download source.zip
		call %EXEC_TOOL% wget.exe -O source.zip --no-check-certificate !PVPGN_ZIP! %_zip_log%

		:: extract files into current directory (pvpgn-server-master directory is in archive)
		call %EXEC_TOOL% unzip.exe -o source.zip %_zip_log%

		:: copy files from pvpgn-master to source
		xcopy /E /R /K /Y pvpgn-server-!BRANCH! source\ %_zip_log%
		:: remove pvpgn-master
		rmdir /Q /S pvpgn-server-!BRANCH!\
		:: remove downloaded zip
		del /F /Q source.zip
	)
)

:: replace custom source code files
@call :backup_conf


:: {PARAMETER}, if not empty | "auto" | "cmake_only" then skip CMake configuration
if not [%PARAM_REBUILD%]==[] if not [%PARAM_REBUILD%]==[auto] if not [%PARAM_REBUILD%]==[cmake_only] goto :build


:: ----------- MAKE ------------
echo.
echo ______________________[ C M A K E  C O N F I G U R E ]__________________________

:: show visual studio paths to get more details
call %EXEC_TOOL% vswhere.exe

if [%LOG%]==[true] set _cmake_log= ^>cmake.log
if not exist "%PVPGN_BUILD%" mkdir "%PVPGN_BUILD%"

@call :clean_build_release

:: delete cmake cache
if exist "%PVPGN_BUILD%CMakeCache.txt" del %PVPGN_BUILD%CMakeCache.txt

if [%CHOICE_INTERFACE%]==[1] ( set _with_gui=false) else ( set _with_gui=true)

:: set cmake compiler flags
if "%PARAM_BUILDTYPE%"=="Debug" (
	set CMAKE_FLAGS=-D CMAKE_CXX_FLAGS_DEBUG="/MTd"
) else (
	set CMAKE_FLAGS=-D CMAKE_CXX_FLAGS_RELEASE="/MT /Od"
)
set CMAKE_VARS=%CMAKE_VARS% %CMAKE_FLAGS%

:: configure and generate solution
call %EXEC_TOOL% cmake.exe -Wno-dev -G "%GENERATOR%" -A "Win32" -D ZLIB_ROOT=%ZLIB_PATH% -D ZLIB_INCLUDE_DIR=%ZLIB_PATH% -D ZLIB_LIBRARY=%ZLIB_PATH%zdll.lib %CMAKE_VARS% -D CMAKE_CONFIGURATION_TYPES="Debug;Release" -D CMAKE_SUPPRESS_REGENERATION=true -D WITH_WIN32_GUI=%_with_gui% -H%PVPGN_SOURCE% -B%PVPGN_BUILD% %_cmake_log%


:: Stop after cmake and setting env vars (feature for appveyor)
:: Example: build_pvpgn.bat cmake_only 6 2 1 y
if [%PARAM_REBUILD%]==[cmake_only] exit
 

:: ----------- BUILD ------------
echo.
echo ______________[ B U I L D  W I T H  V I S U A L  S T U D I O ]__________________
:build

if [%LOG%]==[true] set _vs_log=^>visualstudio.log

:: check solution for exists 
IF NOT EXIST "%PVPGN_BUILD%pvpgn.sln" echo. & call %i18n% 1_16 & goto THEEND

:: load visual studio variables (new and old vs has different batch files with vars)
if not ["%VSVER%"]==["v100"] if not ["%VSVER%"]==["v110"] if not ["%VSVER%"]==["v120"] if not ["%VSVER%"]==["v140"] (
 	@call "%VSCOMNTOOLS%vcvars32.bat"
) else (
	@call "%VSCOMNTOOLS%vsvars32.bat"
)

:: atlmfc include dir for VC Express version
set INCLUDE=%ATLMFC_INCLUDE_PATH%;%INCLUDE%

set msbuild_exec=MSBuild.exe "%PVPGN_BUILD%pvpgn.sln" /t:Rebuild /p:Configuration=%PARAM_BUILDTYPE% /p:Platform="Win32" /p:UseEnv=true /consoleloggerparameters:Summary;PerformanceSummary;Verbosity=minimal /maxcpucount %_vs_log%

:: print command
echo %msbuild_exec%
:: compile the solution
%msbuild_exec%

:: ----------- RELEASE ------------
echo.
echo ______________________________[ R E L E A S E ]_________________________________

:: restore unix configs (only after build! because it uses source directory while compile)

:: restore custom source files
@call :restore_conf

:: check pvpgn exe for exists 
if not exist "%PVPGN_BUILD%src\bnetd\%PARAM_BUILDTYPE%\bnetd.exe" goto :FAIL


@call :save_rebuild_config

if not exist "%PVPGN_RELEASE%" mkdir "%PVPGN_RELEASE%"

:: copy conf directory
if not exist "%PVPGN_RELEASE%conf" mkdir "%PVPGN_RELEASE%conf"
@copy /Y "%PVPGN_BUILD%conf\*.conf" "%PVPGN_RELEASE%conf"
@copy /Y "%PVPGN_BUILD%conf\*.txt" "%PVPGN_RELEASE%conf"
@copy /Y "%PVPGN_BUILD%conf\*.json" "%PVPGN_RELEASE%conf"
@copy /Y "%PVPGN_BUILD%conf\bnetd_default_user.plain" "%PVPGN_RELEASE%conf"
@copy /Y "%PVPGN_SOURCE%conf\bnetd_default_user.cdb" "%PVPGN_RELEASE%conf"
:: replace main configs with win32 versions
@copy /Y "%PVPGN_SOURCE%conf\bnetd.conf.win32" "%PVPGN_RELEASE%conf\bnetd.conf"
@copy /Y "%PVPGN_SOURCE%conf\d2cs.conf.win32" "%PVPGN_RELEASE%conf\d2cs.conf"
@copy /Y "%PVPGN_SOURCE%conf\d2dbs.conf.win32" "%PVPGN_RELEASE%conf\d2dbs.conf"



:: copy libraries to release directory, without prompt
@copy /B /Y "%ZLIB_PATH%*.dll" "%PVPGN_RELEASE%"
if not [%DB_LIB%]==[] @copy /B /Y "%DB_PATH%*.dll" "%PVPGN_RELEASE%"
if not [%CHOICE_LUA%]==[n] (
	@copy /B /Y "%LUA_PATH%*.dll" "%PVPGN_RELEASE%"
	@xcopy /E /R /K /Y "%PVPGN_SOURCE%lua" "%PVPGN_RELEASE%lua\"
)

if [%CHOICE_INTERFACE%]==[1] set postfix=Console

:: copy release binaries
@copy /B /Y "%PVPGN_BUILD%src\bnetd\%PARAM_BUILDTYPE%\bnetd.exe" "%PVPGN_RELEASE%PvPGN%postfix%.exe"
@copy /B /Y "%PVPGN_BUILD%src\bnetd\%PARAM_BUILDTYPE%\bnetd.pdb" "%PVPGN_RELEASE%PvPGN%postfix%.pdb"
@copy /B /Y "%PVPGN_BUILD%src\d2cs\%PARAM_BUILDTYPE%\d2cs.exe" "%PVPGN_RELEASE%D2CS%postfix%.exe"
@copy /B /Y "%PVPGN_BUILD%src\d2cs\%PARAM_BUILDTYPE%\d2cs.pdb" "%PVPGN_RELEASE%D2CS%postfix%.pdb"
@copy /B /Y "%PVPGN_BUILD%src\d2dbs\%PARAM_BUILDTYPE%\d2dbs.exe" "%PVPGN_RELEASE%D2DBS%postfix%.exe"
@copy /B /Y "%PVPGN_BUILD%src\d2dbs\%PARAM_BUILDTYPE%\d2dbs.pdb" "%PVPGN_RELEASE%D2DBS%postfix%.pdb"

@copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bni2tga.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bni2tga.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bnibuild.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bnibuild.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bniextract.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bniextract.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bnilist.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\bnilist.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\tgainfo.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bniutils\%PARAM_BUILDTYPE%\tgainfo.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bnpass\%PARAM_BUILDTYPE%\bnpass.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bnpass\%PARAM_BUILDTYPE%\bnpass.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bnpass\%PARAM_BUILDTYPE%\sha1hash.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bnpass\%PARAM_BUILDTYPE%\sha1hash.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnbot.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnbot.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnchat.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnchat.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnftp.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnftp.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnstat.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\client\%PARAM_BUILDTYPE%\bnstat.pdb" "%PVPGN_RELEASE%"
@copy /B /Y "%PVPGN_BUILD%src\bntrackd\%PARAM_BUILDTYPE%\bntrackd.exe" "%PVPGN_RELEASE%"
if "%PARAM_BUILDTYPE%"=="Debug" @copy /B /Y "%PVPGN_BUILD%src\bntrackd\%PARAM_BUILDTYPE%\bntrackd.pdb" "%PVPGN_RELEASE%"


:: copy var directories (they're empty)
@xcopy "%PVPGN_BUILD%\files\var\*" "%PVPGN_RELEASE%\var\" /E

:: copy files directory
if not exist "%PVPGN_RELEASE%files" mkdir "%PVPGN_RELEASE%files"
@copy /Y "%PVPGN_SOURCE%files" "%PVPGN_RELEASE%files"
@del "%PVPGN_RELEASE%files\CMakeLists.txt"

:: copy i18n and lua files with subdirectories
@xcopy /E /R /K /Y "%PVPGN_SOURCE%conf\i18n" "%PVPGN_RELEASE%conf\i18n\"
@del "%PVPGN_RELEASE%lua\CMakeLists.txt"
@del "%PVPGN_RELEASE%conf\i18n\CMakeLists.txt"

:: replace "storage_path"
if ["%CHOICE_DB_CONF%"]==["y"] (
	for /f "delims=" %%a in ('cscript "%TOOLS_PATH%replace_line.vbs" "%PVPGN_RELEASE%conf\bnetd.conf" "storage_path" "!CONF_storage_path!"') do set res=%%a
	if ["!res!"]==["ok"] ( echo storage_path updated in bnetd.conf ) else ( echo Error: storage_path was not updated in bnetd.conf )
)

goto THEEND

:: erase build and release directories
:clean_build_release
	@erase /S /Q "%PVPGN_RELEASE%*.*">nul
	@erase /S /Q "%PVPGN_BUILD%*.*">nul
	exit /b 0
	
:backup_conf
	@call %TOOLS_PATH%recursive_copy.bat module\include\source_replace\ ..\..\..\source\ backup
	exit /b 0

:restore_conf
	@call %TOOLS_PATH%recursive_copy.bat module\include\source_replace\ ..\..\..\source\ restore
	exit /b 0


:save_rebuild_config
	set fileName=rebuild_pvpgn.bat
	:: if DB_ENGINE is not empty
	if not [%DB_ENGINE%]==[] set fileName=rebuild_pvpgn_with_%DB_ENGINE%.bat
	
	:: save to file
	echo @echo off>!fileName!
	echo build_pvpgn.bat rebuild !PARAM_VS! !PARAM_INTERFACE! !PARAM_DBTYPE! !PARAM_LUA!>>!fileName!
	
	rem *** the same for debug ***
	set fileName=rebuild_pvpgn_debug.bat
	:: if DB_ENGINE is not empty
	if not [%DB_ENGINE%]==[] set fileName=rebuild_pvpgn_with_%DB_ENGINE%_debug.bat
	
	:: save to file
	echo @echo off>!fileName!
	echo build_pvpgn.bat rebuild !PARAM_VS! !PARAM_INTERFACE! !PARAM_DBTYPE! !PARAM_LUA! Debug>>!fileName!

	exit /b 0

:FAIL
	echo SOMETHING GONE WRONG :-(
	if not [%PARAM_REBUILD%]==[auto] pause
	exit /b 1
	goto :eof
	
	
	
:THEEND
echo.
echo ___________________________[ C O M P L E T E ]__________________________________
:: wait for any key

if not [%PARAM_REBUILD%]==[auto] pause
