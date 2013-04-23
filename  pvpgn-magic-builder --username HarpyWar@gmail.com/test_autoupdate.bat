@echo off
setlocal enabledelayedexpansion

:: remote url where update files stored (svn trunk)
set URL_UPDATE=http://pvpgn-magic-builder.googlecode.com/svn/trunk/
set REMOTE_PATH=%URL_UPDATE%module/autoupdate/
set LOCAL_PATH=module\autoupdate\

echo Checking for update ...

:: get local version
for /f %%a in (%LOCAL_PATH%version.txt) do set l_version=%%a
echo "v%l_version%" is your version
:: get remote version
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /s %REMOTE_PATH%version.txt') do set r_version=%%a
echo "v%r_version%" is remote version
echo.

:: compare versions, exit if they are equals
if [%l_version%]==[%r_version%] echo  You have the latest PvPGN Magic Builder & goto :eof

:: if versions are not equals, ask user to update or not
set /p CHOICE_UPDATE=Remote version of PvPGN Magic Builder is not equals with yours. Do you want to automatically update to the new version? (y/n): 
if [%CHOICE_UPDATE%]==[n] ( echo  Update was cancelled by user &  goto :eof )

echo Starting update ...

:: download version.txt
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %REMOTE_PATH%version.txt %LOCAL_PATH%version.txt') do set res=%%a
if not [%res%]==[ok] echo   %res% & exit /b 1

:: download filelist.txt
for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %REMOTE_PATH%filelist.txt %LOCAL_PATH%filelist.txt') do set res=%%a
if not [%res%]==[ok] echo   %res% & exit /b 1

:: iterate filelist.txt
for /f "tokens=1,2 delims=: " %%a in ('%LOCAL_PATH%md5sum.exe -c %LOCAL_PATH%filelist.txt') do (
	:: if checksum is wrong or file is not exists, do update
	if [%%b]==[FAILED] @call :download %%a
)

echo Update finished
echo Please, check versionhistory.txt for more information

goto :eof

:: downloads a file %1
:download
	:: replace \ to /
	set f_local=%1
	set f_tmp=%URL_UPDATE%%f_local%
	set f_remote=%f_tmp:\=/%

	echo Downloading file "%f_local%" ...
	:: download file from the remote url to local url
	for /f "delims=" %%a in ('cscript %LOCAL_PATH%wget.vbs /f %f_remote% %f_local%') do set f_res=%%a
	echo   %f_res%
	echo.
	
	exit /b 0
	
