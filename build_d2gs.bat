@echo off
setlocal enabledelayedexpansion

TITLE D2GS Magic Builder for Windows
color 4f
echo.
echo /-\-/-\-/-\-/-\-/-\-  D 2 G S  M a g i c  B u i l d e r  -\-/-\-/-\-/-\-/-\-/-\
echo \                                                                             /
echo /   Copyright 2012-2017, HarpyWar (harpywar@gmail.com)                        \
echo \   https://pvpgn.pro                                                         /
echo /                                                                             \
echo \-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/-\-/

@call module\config.inc.bat


:: ----------- SETUP ------------
echo.
echo _______________________________[ S E T U P ]____________________________________

call %i18n% 9_1

:choose_version
echo    1) 1.13d (broken uber portals https://github.com/pvpgn/pvpgn-magic-builder/issues/25)
echo    2) 1.13c
echo    3) 1.13c (multithreaded, read https://github.com/pvpgn/pvpgn-magic-builder/issues/17)
echo    4) 1.12a
echo    5) 1.11b
echo    6) 1.10
echo    7) 1.09d
echo.
call %i18n% 1_9
choice /c:1234567
set CHOICE_D2GSVER=%errorlevel%

if [%CHOICE_D2GSVER%]==[1] set D2GSVER=1.13d
if [%CHOICE_D2GSVER%]==[2] set D2GSVER=1.13c
if [%CHOICE_D2GSVER%]==[3] set D2GSVER=1.13c_m
if [%CHOICE_D2GSVER%]==[4] set D2GSVER=1.12a
if [%CHOICE_D2GSVER%]==[5] set D2GSVER=1.11b
if [%CHOICE_D2GSVER%]==[6] set D2GSVER=1.10
if [%CHOICE_D2GSVER%]==[7] set D2GSVER=1.09d

echo.
echo --------------------------------------------------------------------------------
:set_password
call %i18n% 9_2
set /p telnet_pass=:
if [%telnet_pass%]==[] goto :set_password

:: get password hash
for /f "delims=" %%a in ('cscript "%TOOLS_PATH%wget.vbs" /s "%URL_BNHASH_API%%telnet_pass%"') do set PASSHASH=%%a
echo.
call %i18n% 9_3 d2gs.reg
::echo %telnet_pass% = %PASSHASH%

echo.
echo --------------------------------------------------------------------------------
:mpq_download
call %i18n% 9_4
echo (d2data.mpq, d2exp.mpq, d2sfx.mpq, d2speech.mpq)
choice
if %errorlevel%==2 ( set CHOICE_MPQ=n) else ( set CHOICE_MPQ=y)




:: -----------  Download files ------------ 
echo.
echo _____________________________[ D O W N L O A D ]________________________________

if not exist "%D2GS_RELEASE%" mkdir "%D2GS_RELEASE%"

:: Download DLLs to the directory with selected version, so files will cached and not downloaded again next time

pushd module\include\d2gs

:: iterate files from filelist.txt
for /f "tokens=1,2 delims=: " %%a in ('call %EXEC_TOOL% md5sum.exe -c %D2GSVER%\filelist.txt') do (
	:: if checksum is wrong or file does not exists, then download
	if ["%%b"]==["FAILED"] @call :download %%a
)
popd

:: Download MPQs if required

pushd %D2GS_RELEASE%

if not [%CHOICE_MPQ%]==[n] (
	:: iterate files from filelist.txt
	for /f "tokens=1,2 delims=: " %%a in ('call %EXEC_TOOL% md5sum.exe -c ..\module\include\d2gs\filelist.txt') do (
		:: if checksum is wrong or file does not exists, then download
		if ["%%b"]==["FAILED"] @call :download %%a
	)
)
popd


:: -----------  Copy D2GS files ------------
echo.
echo _______________________________[ B U I L D ]____________________________________

:: 1) backup large mpq files
@mkdir "%D2GS_RELEASE%mpq.bkp"
@move /Y "%D2GS_RELEASE%*.mpq" "%D2GS_RELEASE%mpq.bkp"
:: 2) erase release dir
@erase /Q "%D2GS_RELEASE%*.*">nul
:: 3) restore large mpq files
@move /Y "%D2GS_RELEASE%mpq.bkp\*.mpq" "%D2GS_RELEASE%"
@rmdir /S /Q "%D2GS_RELEASE%mpq.bkp"

:: 4) copy d2gs files directory
@copy /Y "module\include\d2gs\%D2GSVER%" "%D2GS_RELEASE%"
@copy /Y "module\include\d2gs\*" "%D2GS_RELEASE%"
@del "%D2GS_RELEASE%filelist.txt"

:: 5) change password hash in d2gs.reg
echo.
set str_find=[[quote]]AdminPassword[[quote]]
set str_replace=[[quote]]AdminPassword[[quote]]=[[quote]]%PASSHASH%[[quote]]
for /f "delims=" %%a in ('cscript "%TOOLS_PATH%replace_line.vbs" "d2gs\d2gs.reg" "!str_find!" "!str_replace!"') do set res=%%a
if ["!res!"]==["ok"] ( echo AdminPassword was updated in %D2GS_RELEASE%d2gs.reg ) else ( echo Error: AdminPassword was not updated in %D2GS_RELEASE%d2gs.reg)

:: 5) if 64-bit OS then change registry path in d2gs.reg
if defined ProgramFiles(x86) (
	echo.
	echo 64-bit OS detected, registry path will changed...
	set str_find=[HKEY_LOCAL_MACHINE\SOFTWARE\D2Server\D2GS]
	set str_replace=[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\D2Server\D2GS]
	for /f "delims=" %%a in ('cscript "%TOOLS_PATH%replace_line.vbs" "d2gs\d2gs.reg" "!str_find!" "!str_replace!"') do set res=%%a
	if ["!res!"]==["ok"] ( echo Registry path was updated in %D2GS_RELEASE%d2gs.reg ) else ( echo Error: Registry path was not updated in %D2GS_RELEASE%d2gs.reg)
)



goto :THEEND

:: downloads a file %1
:download
	:: replace \ to / in remote path dir
	set f_tmp=%URL_MPQ%%1
	set f_remote=%f_tmp:\=/%
	:: get filename from path
	rem for %%x in (%1.META) do set f_name=%%~nx
	
	call %i18n% 3_8 "%f_local%"
	:: download file from the remote url to local file with overwrite
	call %EXEC_TOOL% wget.exe "%f_remote%" -O "%1"

	exit /b 0
	
:THEEND
echo.
echo ___________________________[ C O M P L E T E ]__________________________________
call %i18n% 9_9
echo.
echo.

:: wait for any key
pause
