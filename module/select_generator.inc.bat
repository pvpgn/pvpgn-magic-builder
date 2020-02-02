@echo off
:: This script outputs variable %GENERATOR% with a visual studio name
:: if more then one VS found, user can choose the one
::
::  cmake generator name (Visual Studio 7 .NET 2003, Visual Studio 8 2005, Visual Studio 9 2008, Visual Studio 10)
::  visual studio version to build (v71 (2003), v80 (2005), v90 (2008), v100 (2010))
::  2003 is not supported, 2005 is full version required (express is not supported), 2008 and 2010 fully supports


:: fill array-map with vs names
set _vs_map=1-Visual Studio 2010;2-Visual Studio 2012;3-Visual Studio 2013;4-Visual Studio 2015;5-Visual Studio 2017

:: array with installed vs
set _vs_installed=
set _vs_choice=0
set /a _vs_count=0


:: fill array with installed vs (OLD versions end with 2015)
set VSCOMNTOOLS=%VS100COMNTOOLS%& @call :init_vs 1
set VSCOMNTOOLS=%VS110COMNTOOLS%& @call :init_vs 2
set VSCOMNTOOLS=%VS120COMNTOOLS%& @call :init_vs 3
set VSCOMNTOOLS=%VS140COMNTOOLS%& @call :init_vs 4
set VSCOMNTOOLS=NOTFOUND&         @call :init_vs 5
set VSCOMNTOOLS=NOTFOUND&         @call :init_vs 6
set VSCOMNTOOLS=NOTFOUND&         @call :init_vs 7
set VSCOMNTOOLS=NOTFOUND&         @call :init_vs 8
rem // TODO: add new Visual Studio versions here

:: if no vs found
if %_vs_count% equ 0 set VS_NOT_INSTALLED=true& goto :eof

:: {PARAMETER}, if not empty replace value and skip choice
if not [%PARAM_VS%]==[] (
	rem value "auto" automatically selects an available generator
	if [%PARAM_VS%]==[auto] set PARAM_VS=%_vs_choice%

	set _vs_choice=!PARAM_VS!& goto :select_vs
)

:: if more then one vs installed, give user to choose it
if %_vs_count% gtr 1 (
	call %i18n% 1_1
	echo.

	set /a _counter=0
	set _choice=
	:: iterate installed vs
	for %%n in (%_vs_installed%) do (
		set /a _counter+=1
		set _choice=!_choice!!_counter!
		@call :_value_by_key %%n
		echo   !_counter!^) !_result!
	)

	:: remove spaces
	set _c=!_vs_installed: =!
	echo.
	choice /c:!_choice!
	:: redeclare choice with user input
	set /a _t=!errorlevel!-1
	@call :_substr !_c! !_t! 1
	set _vs_choice=!_result!
	echo.
)

:: set VS VARS
:select_vs
if [%_vs_choice%]==[1] set VSCOMNTOOLS=%VS100COMNTOOLS%& set GENERATOR=Visual Studio 10 2010& set VSVER=v100
if [%_vs_choice%]==[2] set VSCOMNTOOLS=%VS110COMNTOOLS%& set GENERATOR=Visual Studio 11 2012& set VSVER=v110
if [%_vs_choice%]==[3] set VSCOMNTOOLS=%VS120COMNTOOLS%& set GENERATOR=Visual Studio 12 2013& set VSVER=v120
if [%_vs_choice%]==[4] set VSCOMNTOOLS=%VS140COMNTOOLS%& set GENERATOR=Visual Studio 14 2015& set VSVER=v140
:: NEW versions start from 2017
if [%_vs_choice%]==[5] set VSCOMNTOOLS=%VSNEWCOMNTOOLS%& set GENERATOR=Visual Studio 15 2017& set VSVER=v141
if [%_vs_choice%]==[6] set VSCOMNTOOLS=%VSNEWCOMNTOOLS%& set GENERATOR=Visual Studio 16 2019& set VSVER=v142
if [%_vs_choice%]==[7] set VSCOMNTOOLS=%VSNEWCOMNTOOLS%& set GENERATOR=Visual Studio 17 2021& set VSVER=v143
if [%_vs_choice%]==[8] set VSCOMNTOOLS=%VSNEWCOMNTOOLS%& set GENERATOR=Visual Studio 18 2023& set VSVER=v144
rem // TODO: add new Visual Studio versions here

set PARAM_VS=%_vs_choice%

call %i18n% 1_2 "%GENERATOR%"

goto :eof

:: get value by key (array-map)
:_value_by_key
	call set _result=%%_vs_map:*%1-=%%
	set _result=%_result:;=&rem.%
	exit /b 0
	
:: substring
:_substr
	set _str=%1
	set _result=!_str:~%2,%3!
	exit /b 0
	
:init_vs
	set found=false

	if not !VSCOMNTOOLS!==NOTFOUND (
		rem check for exist full visual studio ...
		if exist "!VSCOMNTOOLS!..\IDE\devenv.exe" set found=true
		rem ... or express version
		if exist "!VSCOMNTOOLS!..\IDE\VCExpress.exe" set found=true
		if exist "!VSCOMNTOOLS!..\IDE\WDExpress.exe" set found=true
	) else (
		rem ... or newer versions (since 2017)
		rem vswhere return directories of all installed versions and then we try to find VC++ directory there
		for /f "usebackq tokens=*" %%i in (`call %EXEC_TOOL% vswhere.exe -products * -requires Microsoft.Component.MSBuild -property installationPath`) do (
			if exist "%%i\Common7\IDE\devenv.exe" if exist "%%i\VC\Auxiliary\Build\vcvars32.bat" (
				set find_ver=0000
				if [%1]==[5] set find_ver=2017
				if [%1]==[6] set find_ver=2019
				if [%1]==[7] set find_ver=2021
				if [%1]==[8] set find_ver=2023
				rem // TODO: add new Visual Studio versions here
				
				:: find in path
				call :_find_substr "%%i" !find_ver!
				if [!_result!]==[true] (
					set found=true& set VSNEWCOMNTOOLS=%%i\VC\Auxiliary\Build\
				)
			)
		)
	)

	if %found%==true (
		set _vs_installed=!_vs_installed!%1 
		set /a _vs_count+=1 & set _vs_choice=%1
	)
	exit /b 0
	
:_find_substr
	echo.%1 | findstr /C:"%2" 1>nul
	if errorlevel 1 (
	  set _result=false
	) else (
	  set _result=true
	)
	exit /b 0