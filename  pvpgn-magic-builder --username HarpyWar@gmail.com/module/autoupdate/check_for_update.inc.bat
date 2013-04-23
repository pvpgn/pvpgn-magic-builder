@echo off

:: remote url where update files stored (svn trunk)
set URL_UPDATE=%1
set REMOTE_PATH=%URL_UPDATE%module/autoupdate/
set LOCAL_PATH=module\autoupdate\

call %i18n% 3_1

:: get local version
for /f %%a in (%LOCAL_PATH%version.txt) do set l_version=%%a
call %i18n% 3_2 %l_version%

:: get remote version
for /f "delims=" %%a in ('cscript "%LOCAL_PATH%wget.vbs" /s "%REMOTE_PATH%version.txt"') do set r_version=%%a
set error=%r_version:~0,5%
if [%error%]==[error] call %i18n% 3_6_1 & goto :eof

call %i18n% 3_3 %r_version%
echo.

:: compare versions, exit if they are equals
if ["%l_version%"]==["%r_version%"] call %i18n% 3_4 & goto :eof

:: if versions are not equals, ask user to update or not
call %i18n% 3_5
module\choice 
if %errorlevel%==2 set CHOICE_UPDATE=n & call %i18n% 3_6 & goto :eof

call %i18n% 3_7
echo.


:: download filelist.txt
for /f "delims=" %%a in ('cscript "%LOCAL_PATH%wget.vbs" /f "%REMOTE_PATH%filelist.txt" "%LOCAL_PATH%filelist.txt"') do set res=%%a
if not ["%res%"]==["ok"] echo   %res% & goto :eof

:: iterate filelist.txt
for /f "tokens=1,2 delims=: " %%a in ('%LOCAL_PATH%md5sum.exe -c %LOCAL_PATH%filelist.txt') do (
	:: if checksum is wrong or file does not exists, do update
	if ["%%b"]==["FAILED"] @call :download %%a
)

:: download version.txt 
for /f "delims=" %%a in ('cscript "%LOCAL_PATH%wget.vbs" /f "%REMOTE_PATH%version.txt" "%LOCAL_PATH%version.txt"') do set res=%%a
if not ["%res%"]==["ok"] echo   %res% & goto :eof

call %i18n% 3_9
call %i18n% 3_10 "version-history.txt"
echo.

pause
exit 0

:: downloads a file %1
:download
	:: replace \ to /
	set f_local=%1
	set f_tmp=%URL_UPDATE%%f_local%
	set f_remote=%f_tmp:\=/%

	call %i18n% 3_8 "%f_local%"
	:: download file from the remote url to local url
	for /f "delims=" %%a in ('cscript "%LOCAL_PATH%wget.vbs" /f "%f_remote%" "%f_local%"') do set f_res=%%a
	echo    %f_res%
	echo.
	
	exit /b 0
	
