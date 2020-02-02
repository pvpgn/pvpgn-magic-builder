@echo off

setlocal enabledelayedexpansion
set TOOL_NAME=%1
set EXEC_PATH=%*

if %TOOL_NAME%==wget.exe call :download_wget
if %TOOL_NAME%==md5sum.exe call :download_md5sum
if %TOOL_NAME%==unzip.exe call :download_unzip
if %TOOL_NAME%==cmake.exe call :download_cmake
if %TOOL_NAME%==vswhere.exe call :download_vswhere

if errorlevel 5 (
	exit /b 5
)

:: execute tool
%TOOLS_PATH%%EXEC_PATH%

goto :eof



:download_wget

	:: download if not exists
	if not exist "%TOOLS_PATH%wget.exe" (
		echo Downloading wget...
		:: download wget silently using vbs because we still not have wget.exe
		for /f "delims=" %%a in ('cscript "%TOOLS_PATH%wget.vbs" /f "%URL_TOOL_WGET%" "%TOOLS_PATH%wget.exe"') do set res=%%a
		if not ["!res!"]==["ok"] echo   !res! & goto :failed
		:: download also dll dependencies for wget
		rem for /f "delims=" %%a in ('cscript "%TOOLS_PATH%wget.vbs" /f "%URL_TOOL_WGET_DEP%" "%TOOLS_PATH%wget_dep.zip"') do set res=%%a
		rem if not ["!res!"]==["ok"] echo   !res! & goto :failed
		
		:: extract only bin directory to %TOOLS_PATH%
		rem call %EXEC_TOOL% unzip.exe -o %TOOLS_PATH%wget.zip -d %TOOLS_PATH% -C bin\*
		:: extract only bin directory to %TOOLS_PATH%
		rem call %EXEC_TOOL% unzip.exe -o %TOOLS_PATH%wget_dep.zip -d %TOOLS_PATH% -C bin\*
		:: rename bin to wget
		rem ren "%TOOLS_PATH%bin" wget
		
		:: remove downloaded archives to save disk space
		rem del "%TOOLS_PATH%wget.zip"
		rem del "%TOOLS_PATH%wget_dep.zip"
	)
	rem if not exist "%TOOLS_PATH%wget\wget.exe" goto :failed
	rem if not exist "%TOOLS_PATH%wget\libssl32.dll" goto :failed
	if not exist "%TOOLS_PATH%wget.exe" goto :failed

	:: update executable path
	rem set EXEC_PATH=wget\%EXEC_PATH%
	
	exit /b 0


:download_md5sum

	:: download if not exists
	if not exist "%TOOLS_PATH%md5sum.exe" (
		:: download silently without using wget.exe, because output handled directly in batch "for"
		for /f "delims=" %%a in ('cscript "%TOOLS_PATH%wget.vbs" /f "%URL_TOOL_MD5SUM%" "%TOOLS_PATH%md5sum.exe"') do set res=%%a
		if not ["!res!"]==["ok"] echo   !res! & goto :failed
	)
	if not exist "%TOOLS_PATH%md5sum.exe" goto :failed

	exit /b 0
	
	
:download_unzip

	:: download if not exists
	if not exist "%TOOLS_PATH%unzip.exe" (
		echo Downloading unzip...
		for /f "delims=" %%a in ('cscript "%TOOLS_PATH%wget.vbs" /f "%URL_TOOL_UNZIP%" "%TOOLS_PATH%unzip.exe"') do set res=%%a
	)
	if not exist "%TOOLS_PATH%unzip.exe" goto :failed

	exit /b 0

	
:download_cmake

	cmake.exe --version
	:: first find in PATH and don't download if found
	call :run_installed cmake.exe
	echo.
	if errorlevel 5 (
		exit /b 5
	)

	:: download if not exists
	if not exist "%TOOLS_PATH%%CMAKE_VERSION%\bin\cmake.exe" (
		echo Downloading CMake...
		:: download archive
		call %EXEC_TOOL% wget.exe -O %TOOLS_PATH%%CMAKE_VERSION%.zip %URL_TOOL_CMAKE% --no-check-certificate 
		:: extract files to %TOOLS_PATH%
		call %EXEC_TOOL% unzip.exe -o %TOOLS_PATH%%CMAKE_VERSION%.zip -d %TOOLS_PATH%
		:: remove downloaded archive to save disk space
		del "%TOOLS_PATH%%CMAKE_VERSION%.zip"
	)
	if not exist "%TOOLS_PATH%%CMAKE_VERSION%\bin\cmake.exe" goto :failed
	
	:: update executable path
	set EXEC_PATH=%CMAKE_VERSION%\bin\%EXEC_PATH%
	
	exit /b 0

	
	
:download_vswhere

	:: download if not exists
	if not exist "%TOOLS_PATH%vswhere.exe" (
		echo Downloading vswhere...
		:: download silently
		call %EXEC_TOOL% wget.exe -O %TOOLS_PATH%vswhere.exe %URL_TOOL_VSWHERE% --no-check-certificate -q 2>nul
	)
	if not exist %TOOLS_PATH%vswhere.exe goto :failed

	exit /b 0
	

:: find & run installed program if exists in %PATH%
:run_installed <filename.exe>

	where /q %1
	if not errorlevel 1 (
		echo Use installed application from:
		where %1
		:: execute
		%EXEC_PATH%
		exit /b 5
	)
	exit /b 0

	
:failed
	echo Download failed. Aborting.
	exit /b 5
