@echo off
:: Gets localization strings depending user's system locale
::  Windows Languages http://www.microsoft.com/resources/msdn/goglobal/default.mspx

if [!Key!]==[] (
	set Key="HKEY_CURRENT_USER\Control Panel\International"
	for /F "tokens=3" %%a in ('reg query !Key!  ^| find /i "sLang"') do set LANGUAGE=%%a
)

:: initialize English as default
call module\i18n\ENU.bat %1 %2 %3 %4 %5

:: Russian
if [%LANGUAGE%]==[UZB] set LANGUAGE=RUS
if [%LANGUAGE%]==[KKZ] set LANGUAGE=RUS
if [%LANGUAGE%]==[TTT] set LANGUAGE=RUS
if [%LANGUAGE%]==[AZE] set LANGUAGE=RUS
:: Serbian
if [%LANGUAGE%]==[SRL] set LANGUAGE=SRL
if [%LANGUAGE%]==[SRB] set LANGUAGE=SRL
if [%LANGUAGE%]==[HRV] set LANGUAGE=SRL
:: Chinese
if [%LANGUAGE%]==[CHS] set LANGUAGE=CHS
if [%LANGUAGE%]==[CHT] set LANGUAGE=CHT
if "!LANGUAGE:~0,2!"=="ZH" set LANGUAGE=CHS
:: Portuguese
if "!LANGUAGE:~0,2!"=="PT" set LANGUAGE=PTB
:: Swedish
if "!LANGUAGE:~0,2!"=="SV" set LANGUAGE=SVF
:: German
if "!LANGUAGE:~0,2!"=="DE" set LANGUAGE=DEU
:: Dutch
if "!LANGUAGE:~0,2!"=="NL" set LANGUAGE=NLD
:: Spanish
if "!LANGUAGE:~0,2!"=="ES" set LANGUAGE=ESN


:: switch to another language, if found
if exist module\i18n\%LANGUAGE%.bat call module\i18n\%LANGUAGE%.bat %1 %2 %3 %4 %5

:: print phrase
if not [%1]==[] echo !PHRASE_%1!
