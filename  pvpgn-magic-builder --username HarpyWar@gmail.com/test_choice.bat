@echo off

setlocal enabledelayedexpansion

:: /c:hiworld - letters to choice
:: /t:30 - timeout
:: /d:h = default value
:: /n - do not show letter list
:: /m - "message in quotes"
choice /c:hiworld /n /t:30 /d:h /m:"Are you sure you want to quit. [y/n]"
echo %errorlevel%
if %errorlevel%==2 echo what ever n does
if %errorlevel%==1 echo what ever y does