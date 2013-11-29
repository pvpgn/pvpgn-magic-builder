@echo off
setlocal enabledelayedexpansion

TITLE PvPGN Code Patcher
color 70
echo.
echo ^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<  P v P G N  C o d e  P a t c h e r  ^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>
echo -                                                                             -
echo +   Copyright 2013, HarpyWar (harpywar@gmail.com)                             +
echo +   http://harpywar.com                                                       +
echo -                                                                             -
echo ^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^<^|^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>
set CURRENT_PATH=%~dp0
:: change path to where script was run
cd /D "%CURRENT_PATH%"


:: localization
@call module\i18n.inc.bat
set i18n=module\i18n.inc.bat


@set PVPGN_SOURCE=source\

echo.
:: ----------- RUN ------------
echo.
echo ________________________________[ P A T C H]____________________________________


:: do you want to apply patches? 
call %i18n% 4_1
module\choice
if %errorlevel%==2 ( set CHOICE_PATCH=n) else ( set CHOICE_PATCH=y)

:: applying patches
if [%CHOICE_PATCH%]==[y] @call module\tortoisesvn\patch_source.inc.bat

	
:THEEND
echo.
echo ___________________________[ C O M P L E T E ]__________________________________
echo.

:: wait for any key
pause