@echo off
setlocal enabledelayedexpansion

:: remote url where update files stored (svn trunk)
set URL_UPDATE=http://pvpgn-magic-builder.googlecode.com/svn/trunk/
set REMOTE_PATH=%URL_UPDATE%module/autoupdate/
set LOCAL_PATH=module\autoupdate\

:: get local version
for /f %%a in (%LOCAL_PATH%version.txt) do set l_version=%%a

:: get remote version
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /s %REMOTE_PATH%version.txt') do set r_version=%%a
:: version check, exit if versions are equals
if [l_version]==[r_version] goto :eof

:: download version.txt
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %REMOTE_PATH%version.txt %LOCAL_PATH%version.txt') do 
if not [%res%]==[ok] exit 1

:: download filelist.txt
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %REMOTE_PATH%filelist.txt %LOCAL_PATH%filelist.txt') do set res=%%a
if not [%res%]==[ok] exit 1

:: iterate filelist.txt
for /f "tokens=1,2 delims=: " %%a in ('%LOCAL_PATH%md5sum.exe -c %LOCAL_PATH%filelist.txt') do (
	:: if checksum is wrong or file is not exists, do update
	if [%%b]==[FAILED] @call :download %%a
)


goto :eof

:: downloads a file %1
:download
	:: replace \ to /
	set f_local=%1
	set f_tmp=%URL_UPDATE%%v_local%
	set f_remote=%f_tmp:\=/%
	
	echo Downloading file "%f_local%"...
	:: download file from the remote url to local url
	for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %f_remote% %f_local%') do set f_res=%%a
	echo   %f_res%
	echo.
	
	exit /b 0
	
