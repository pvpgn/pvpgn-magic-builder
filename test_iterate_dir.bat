@echo off

setlocal enabledelayedexpansion

:: where to get files
::  for example: module\include\source_replace\
set DIR_1=%1
:: where to copy these files with .bak ext
::  for examle: ..\..\..\source\
set DIR_2=%2

set dir=module\include\source_replace\

rem 1) set dir
cd %dir%

rem 2) iterate dir recursively
@call :iterate_files
@call :iterate_dirs

rem 3) set dir to current
cd %~dp0

goto :eof
:iterate_dirs
	:: iterate directory %1
	for /F %%v in ('dir /B /AD-H %1') do (
		@call :iterate_dirs %1%%v\
		@call :iterate_files %1%%v\
	)
	exit /b 0
	
:iterate_files
	:: iterate files in the directory %1
	for /f %%v in ('dir /B /A-D-H %1') do (
		rem copy file
		rem echo %1%%v
		copy /Y %1%%v ..\..\..\source\%1%%v.bak
	)
	exit /b 0

	