@echo off

set PATCH_ID=2950
set PATCH_URL=http://developer.berlios.de/patch/?func=detailpatch^&patch_id=%PATCH_ID%^&group_id=2291
SET PATCH_RAW_URL=http://developer.berlios.de/patch/download.php?id=%PATCH_ID%
SET PATCH_FILE=release\patches\%PATCH_ID%.patch
set SOURCE=source\

echo.
echo Downloading patch #%PATCH_ID% ...
:: download patch
for /f "delims=" %%a in ('cscript "module\autoupdate\wget.vbs" /f "%PATCH_RAW_URL%" "%PATCH_FILE%"') do set res=%%a
echo   %res%

:: print patch header


echo.
echo Applying patch #%PATCH_ID% ...
:: cleanup source
module\tortoisesvn\svn.exe cleanup %SOURCE%
:: apply downloaded patch
module\tortoisesvn\svn.exe patch %PATCH_FILE% %SOURCE%


:: ask user to iterate process