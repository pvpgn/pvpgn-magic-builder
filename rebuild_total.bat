@echo off
call build_pvpgn.bat rebuild_total 4 1 1
move release\PvPGNConsole.exe build\PvPGNConsole.exe
call build_pvpgn.bat rebuild_total 4 2 1
move build\PvPGNConsole.exe release\PvPGNConsole.exe
Pause