@echo off

set PATCH_DIR=patches\

:: create patches directory, if not exists
if not exist %PATCH_DIR% @mkdir %PATCH_DIR%

echo.
echo.
call %i18n% 4_2 "patches" "http://developer.berlios.de/patch/?group_id=2291"
echo.
call %i18n% 4_3
call %i18n% 4_4 "trunk/pvpgn/"
call %i18n% 4_5 "message.cpp" "src/bnet/message.cpp"
echo.
call %i18n% 4_6
module\choice
if %errorlevel%==2 goto :eof


:: iterate all the files in the directory
for /f "tokens=* delims= " %%v in ('dir /B /A-D-H "%PATCH_DIR%"') do (
	@call :apply_patch "%PATCH_DIR%%%v"
)

echo.
echo.
call %i18n% 4_8

:: ask for continue building or not (exit program if not)
echo.
call %i18n% 4_9
module\choice
if %errorlevel%==2 exit 1

goto :eof

:apply_patch
	echo.
	call %i18n% 4_7 %1
	:: cleanup source
	module\tortoisesvn\svn.exe cleanup %PVPGN_SOURCE% %_svn_log%
	:: apply downloaded patch
	module\tortoisesvn\svn.exe patch %1 %PVPGN_SOURCE% %_svn_log%
	exit /b 0
