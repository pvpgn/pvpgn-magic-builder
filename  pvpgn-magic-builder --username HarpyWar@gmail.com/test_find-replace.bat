@echo off

SetLocal EnableDelayedExpansion

set str_file=DefineInstallationPaths.cmake

set str_find=/etc
set str_replace=conf

:: backup file
copy /Y %str_file% %str_file%.bak

:: replace str_find -> str_replace
for /f "delims=" %%a in ('cscript module\replace.vbs "%str_file%" "%str_find%" "%str_replace%"') do set res=%%a

:: restore original file
move /Y %str_file%.bak %str_file%