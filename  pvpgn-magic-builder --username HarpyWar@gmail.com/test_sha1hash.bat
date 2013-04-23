@echo off


for /f "delims=" %%a in ('module\sha1hash.exe abcd123') do @set myvar=%%a

echo hello with "%myvar%"

set admin_password=[[quote]]AdminaPassword[[quote]]=[[quote]]%myvar%[[quote]]

:: replace "d2gs.reg"
for /f "delims=" %%a in ('cscript "module\replace_line.vbs" "d2gs\d2gs.reg" "[[quote]]AdminPassword[[quote]]" "!admin_password!"') do set res=%%a
if ["!res!"]==["ok"] ( echo storage_path updated in bnetd.conf ) else ( echo Error: storage_path was not updated in bnetd.conf )
