@echo off

set PATCH_ID=2950
set PATCH_URL=http://developer.berlios.de/patch/?func=detailpatch&patch_id=%PATCH_ID%&group_id=2291
SET PATCH_RAW_URL=http://developer.berlios.de/patch/download.php?id=%PATCH_ID%


:: download patch


:: print patch header



:: cleanup source
svn.exe cleanup %SOURCE%

:: apply downloaded patch
svn.exe patch %SOURCE% %PATCH%


:: ask user to iterate process