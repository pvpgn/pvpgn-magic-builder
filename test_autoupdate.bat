@echo off


for /f "delims=" %%a in ('cscript module\wget.vbs /s http://harpywar.com/test/json.php') do set DOS_VAR=%%a

echo %DOS_VAR%