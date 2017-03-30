@echo off
:: STANDALONE SCRIPT THAT READ OR REPLACES PVPGN VERSION AND
:: SET a NEW ENVIRONMENT VARIABLE %PVPGN_VERSION%

setlocal enabledelayedexpansion
set CURRENT_PATH=%~dp0
set PVPGN_VERSION_BUILD=%1
set VERSION_FILE=%CURRENT_PATH%..\..\source\src\common\version.h

:: read version string from version.h
for /f "delims=" %%i in (%VERSION_FILE%) do (
	set line=%%i
	if "!line:~0,22!" equ "#define PVPGN_VERSION " (
		set PVPGN_VERSION=!line:~23,-1!
	)
)

:: replace if given var is not empty
if not "%PVPGN_VERSION_BUILD%"=="" (
	set PVPGN_FULL_VERSION=%PVPGN_VERSION%-%PVPGN_VERSION_BUILD%

	:: replace old version string with the new
	for /f "delims=" %%a in ('cscript "%CURRENT_PATH%replace_line.vbs" "%VERSION_FILE%" "#define PVPGN_VERSION " "#define PVPGN_VERSION [[quote]]!PVPGN_FULL_VERSION![[quote]]"') do set res=%%a
	if ["!res!"]==["ok"] ( echo Version string updated)
)

endlocal & set PVPGN_VERSION=%PVPGN_VERSION%