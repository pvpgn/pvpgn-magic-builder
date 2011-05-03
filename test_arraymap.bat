@echo off
setlocal enabledelayedexpansion

:: fill array-map with vs names
set _vs_map=1-Visual Studio 2003;2-Visual Studio 2005;3-Visual Studio 2008;4-Visual Studio 2010
:: array with installed vs
set _vs_installed=
set _vs_choice=0
set /a _vs_count=0

set _vs_num=1& if not ["%VS71COMNTOOLS%"]==[""] set _vs_installed=%_vs_installed%!_vs_num! & set /a _vs_count+=1 & set _vs_choice=!_vs_num!
set _vs_num=2& if not ["%VS80COMNTOOLS%"]==[""] set _vs_installed=%_vs_installed%!_vs_num! & set /a _vs_count+=1 & set _vs_choice=!_vs_num!
set _vs_num=3& if not ["%VS90COMNTOOLS%"]==[""] set _vs_installed=%_vs_installed%!_vs_num! & set /a _vs_count+=1 & set _vs_choice=!_vs_num!
set _vs_num=4& if not ["%VS100COMNTOOLS%"]==[""] set _vs_installed=%_vs_installed%!_vs_num! & set /a _vs_count+=1 & set _vs_choice=!_vs_num!


:: if no vs found
if %_vs_count% equ 0 echo Visual Studio is not installed & goto :eof

:: if more then one vs installed, give user to choose it
if %_vs_count% gtr 1 (
	echo.
	echo Select a Visual Studio version to build PvPGN:
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
	module\choice /c:!_choice!
	:: redeclare choice with user input
	set /a _t=!errorlevel!-1
	@call :_substr !_c! !_t! 1
	set _vs_choice=!_result!
)

:: set VS VARS
if [%_vs_choice%]==[1] set VSCOMNTOOLS=%VS71COMNTOOLS%& set GENERATOR=Visual Studio 7 .NET 2003& set VSVER=v71
if [%_vs_choice%]==[2] set VSCOMNTOOLS=%VS80COMNTOOLS%& set GENERATOR=Visual Studio 8 2005& set VSVER=v80
if [%_vs_choice%]==[3] set VSCOMNTOOLS=%VS90COMNTOOLS%& set GENERATOR=Visual Studio 9 2008& set VSVER=v90
if [%_vs_choice%]==[4] set VSCOMNTOOLS=%VS100COMNTOOLS%& set GENERATOR=Visual Studio 10& set VSVER=v100

echo.
echo %GENERATOR% chosen as a build environment

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
	
	