@echo off



if not ["%VS80COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS80COMNTOOLS%& set GENERATOR=Visual Studio 8 2005
if not ["%VS90COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS90COMNTOOLS%& set GENERATOR=Visual Studio 9 2008
if not ["%VS100COMNTOOLS%"]==[""] set VSCOMNTOOLS=%VS100COMNTOOLS%& set GENERATOR=Visual Studio 10

if ["%GENERATOR%"]==[""] echo Visual Studio C++ environment was not found! & exit /B 1



echo %VSCOMNTOOLS%hello