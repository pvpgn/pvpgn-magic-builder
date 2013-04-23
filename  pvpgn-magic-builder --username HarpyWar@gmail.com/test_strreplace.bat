@echo off

setlocal enabledelayedexpansion



SET v_test=123abcd
Set v_replacement=xy
SET v_result=%v_test:ab=!v_replacement!%
ECHO %v_result%=123xycd

