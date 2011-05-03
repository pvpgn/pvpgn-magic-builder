@echo off

setlocal enabledelayedexpansion

set PATCH_DIR=patches\
set SOURCE=source\

echo Do you want to apply patch(es) to your PvPGN source code?
module\choice
if [%errorlevel%]==[2] goto :eof

:: create patches directory, if not exists
if not exist %PATCH_DIR% @mkdir %PATCH_DIR%

echo.
echo Please, first put your SVN patch files to the "patches" directory. You could download patches from the url: http://developer.berlios.de/patch/?group_id=2291
echo [Attention]
echo Paths into your *.patch files should set to relative of the root to the source code (it placed in the SVN at "trunk/pvpgn/")
echo For example: you want to apply patch to "message.cpp", so path to this file should be "src/bnet/message.php"
echo.
echo Do you want to continue?
module\choice
if ["%errorlevel%"]==["2"] goto :eof


:: iterate all the files in the directory
for /f "tokens=* delims= " %%v in ('dir /B /A-D-H "%PATCH_DIR%"') do (
	@call :apply_patch "%PATCH_DIR%%%v"
)

echo.
echo.
echo Finished. Please, check for conflicts.
echo.
echo Do you want to continue building a PvPGN?
module\choice
if %errorlevel%==2 goto :eof



goto :eof

:apply_patch
	echo.
	echo Applying patch %* ...
	:: cleanup source
	module\tortoisesvn\svn.exe cleanup %SOURCE%
	:: apply downloaded patch
	module\tortoisesvn\svn.exe patch %* %SOURCE%
	exit /b 0
