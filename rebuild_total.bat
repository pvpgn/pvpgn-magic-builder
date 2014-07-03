@echo off
::
:: Rebuild PvPGN, D2CS and D2DBS with both "GUI" and "Console" versions
::

call build_pvpgn.bat rebuild_total 4 1 1
move release\PvPGNConsole.exe build\PvPGNConsole.exe
move release\D2CSConsole.exe build\D2CSConsole.exe
move release\D2DBSConsole.exe build\D2DBSConsole.exe
call build_pvpgn.bat rebuild_total 4 2 1
move build\PvPGNConsole.exe release\PvPGNConsole.exe
move build\D2CSConsole.exe release\D2CSConsole.exe
move build\D2DBSConsole.exe release\D2DBSConsole.exe
Pause