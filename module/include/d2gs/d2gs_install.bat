@echo off
rem ------------------------------------
rem D2GS Installer Script
rem (c) 2017 HarpyWar (https://pvpgn.pro)
rem ------------------------------------

title Diablo 2 Game Server - INSTALL

echo You have to run this script as administrator.
echo (otherwise it may fail without a result).
echo It will execute [d2gs.reg] and install [D2GSSVC.exe] as
echo a Windows Service called "Diablo II Closed Game Server".
echo.
echo Please, confirm to continue.
choice
if "%errorlevel%"=="2" goto :eof

:: 1) import d2gs.reg
start %~dp0d2gs.reg
:: 2) install D2GS service
%~dp0d2gssvc.exe -i
:: 3) start D2GS service
net start D2GS

pause
