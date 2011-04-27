@echo off

setlocal enabledelayedexpansion

if [1]==[1] (
	@call test_call_vars.bat sky
	echo return is "!return!"
)

if [1]==[1] (
	set var1=test 
	set var2=sometext !var1!
	echo var2 is "!var2!"
)

pause