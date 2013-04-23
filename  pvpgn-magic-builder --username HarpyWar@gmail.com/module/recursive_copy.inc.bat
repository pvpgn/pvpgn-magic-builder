@echo off
:: Copying files recursively from one directory to other
::  Copyright 2011, HarpyWar (harpywar@gmail.com)
::  http://harpywar.com

:: where to get files
::  for example: module\include\source_replace\
set SRC=%1
:: where to copy these files with .bak ext
::  for examle: ..\..\..\source\
set DST=%2
::  backup || restore
set ACTION=%3


set dir=module\include\source_replace\

rem 1) set dir
pushd %SRC%

rem 2) iterate dir recursively
@call :iterate_files
@call :iterate_dirs

rem 3) set dir to current, where script run (should do it in the parent script)
popd

goto :eof
:iterate_dirs
	:: iterate directory %1
	for /F "tokens=* delims= " %%v in ('dir /B /AD-H "%1"') do (
		@call :iterate_dirs %1%%v\
		@call :iterate_files %1%%v\
	)
	exit /b 0
	
:iterate_files
	:: iterate files in the directory %1
	for /f "tokens=* delims= " %%v in ('dir /B /A-D-H "%1"') do (
		set _dir=%1
		set _file=%%v
		if [%ACTION%]==[backup] (
			ren "!DST!!_dir!!_file!" !_file!.bak
			copy /Y "!_dir!!_file!" "!DST!!_dir!!_file!"
		)
		if [%ACTION%]==[restore] (
			move /Y "!DST!!_dir!!_file!.bak" "!DST!!_dir!!_file!"
		)
	)
	exit /b 0

	