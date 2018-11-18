@echo off
rem ------------------------------------
rem D2GS Uninstaller Script
rem (c) 2018 HarpyWar (https://pvpgn.pro)
rem ------------------------------------

title Diablo 2 Game Server - UNINSTALL

echo You have to run this script as administrator.
echo (otherwise it may fail without a result).
echo It will uninstall a Windows Service
echo called "Diablo II Closed Game Server".
echo.
echo Please, confirm to continue.
choice
if "%errorlevel%"=="2" goto :eof

:: 1) start D2GS service
net stop D2GS
:: 2) uninstall D2GS service
%~dp0d2gssvc.exe -u

pause
