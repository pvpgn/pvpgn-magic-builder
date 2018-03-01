@echo off
:: This script outputs variable %BRANCH% with pvpgn github branch name


set BRANCH=master

echo.
call %i18n% 1_3_1
echo.


:: fetch branch list
for /f "delims=" %%a in ('cscript //nologo %TOOLS_PATH%fetch_json.vbs "https://api.github.com/repos/pvpgn/pvpgn-server/branches" "name" "1" "0"') do set branches=%%a


:: iterate through comma delimited string of branches
set _choice=
set /a b_counter=0
for %%b in (%branches:,= %) do (
	
	:: get branch date
	for /f "delims=" %%d in ('cscript //nologo %TOOLS_PATH%fetch_json.vbs "https://api.github.com/repos/pvpgn/pvpgn-server/branches/%%b" "date" "4" "1"') do set b_date=%%d

	set /a b_counter+=1
	set _choice=!_choice!!b_counter!
	
	set b_title=%%b
	:: for "master" branch append "stable" note
	if [!b_title!]==[master] (
		set b_title=!b_title! [stable]
	)
	echo   !b_counter!^) !b_date:~0,10! / !b_title!
)
echo.

:: let user choose branch number
choice /c:!_choice!
set /a _t=!errorlevel!-1

:: find branch name by chosen id
set /a b_counter=0
for %%b in (%branches:,= %) do (
	set /a b_counter+=1
	if !errorlevel!==!b_counter! (
		set BRANCH=%%b
	)
)
