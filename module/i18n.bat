@echo off
:: Gets localization strings depending user's system locale
:: Batch files encoding should be "OEM 866"


set Key="HKEY_CURRENT_USER\Control Panel\International"
for /F "tokens=3" %%a in ('reg query %Key%  ^| find /i "sLang"') do set LANGUAGE=%%a

:: default is English
goto ENG

:switch
:: switch languages
if [%LANGUAGE%]==[RUS] goto RUS
::if [%LANGUAGE%]==[POL] goto POL





:ENG
	set LANG_QUESTION_1=Where the mammy?
	set LANG_PRESSANYKEY=Press any key to exit ...
	goto switch
	
:RUS
	set LANG_QUESTION_1=Где мама?
	set LANG_PRESSANYKEY=Нажмите любую клавишу для выхода ...
	goto :eof
