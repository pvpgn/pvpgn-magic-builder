@echo off
setlocal enabledelayedexpansion

set LOCAL_PATH=module\autoupdate\

for /f "delims=" %%a in ('cscript module\autoupdate\wget.vbs /f http://harpywar.com/test/json.php json.php') do set DOS_VAR=%%a

echo %DOS_VAR%
echo "%ERRORLEVEL%"