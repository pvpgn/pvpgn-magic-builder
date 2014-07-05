@echo off
:: Gets localization strings depending user's system locale
::  Windows Language abbreveations - http://msdn.microsoft.com/en-us/library/ms903928.aspx
::	DOS Codepage identifiers - http://msdn.microsoft.com/en-us/library/windows/desktop/dd317756(v=vs.85).aspx

if [!Key!]==[] (
	set Key="HKEY_CURRENT_USER\Control Panel\International"
	for /F "tokens=3" %%a in ('reg query !Key!  ^| find /i "sLang"') do set LANGUAGE=%%a
)


:: initialize English as default
call module\i18n\ENU.bat %1 %2 %3 %4 %5

:: switch to another language, if found
if exist module\i18n\%LANGUAGE%.bat call module\i18n\%LANGUAGE%.bat %1 %2 %3 %4 %5


:: print phrase
if not [%1]==[] echo !PHRASE_%1!
