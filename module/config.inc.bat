@echo off

:: current path with a slash \
for %%A in ("%~dp0\..") do set "CURRENT_PATH=%%~fA\"

:: change path to where script was run (root dir)
cd /D "%CURRENT_PATH%"

:: localization
@call module\i18n.inc.bat
set i18n=module\i18n.inc.bat

set TOOLS_PATH=%CURRENT_PATH%module\tools\
set EXEC_TOOL=%TOOLS_PATH%exec_tool.bat
set URL_TOOL_WGET=https://kent.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-bin.zip
set URL_TOOL_WGET_DEP=https://kent.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-dep.zip
set URL_TOOL_MD5SUM=http://www.etree.org/cgi-bin/counter.cgi/software/md5sum.exe
set URL_TOOL_UNZIP=https://fossies.org/windows/misc/unz600xn.exe/unzip.exe
set URL_TOOL_VSWHERE=https://github.com/Microsoft/vswhere/releases/download/1.0.58/vswhere.exe

set CMAKE_VERSION=cmake-3.8.0-rc4-win32-x86
set URL_TOOL_CMAKE=https://cmake.org/files/v3.8/%CMAKE_VERSION%.zip


:: ----------- build_pvpgn VARIABLES ------------

:: LOG=false output cmake and vs output to console
:: LOG=true logs cmake and vs output to cmake.log, visualstudio.log
set LOG=false


set PVPGN_SOURCE=source\
set PVPGN_BUILD=build\

set URL_UPDATE=https://raw.githubusercontent.com/pvpgn/pvpgn-magic-builder/master/

set PVPGN_ZIP=https://github.com/pvpgn/pvpgn-server/archive/master.zip

set ZLIB_PATH=module\include\zlib\1.2.11\
set LUA_PATH=module\include\lua\5.1\
:: FIXME: important full path?
set ATLMFC_INCLUDE_PATH=%CURRENT_PATH%module\include\atlmfc\


:: ----------- build_d2gs VARIABLES ------------
set URL_MPQ=http://cdn.pvpgn.pro/diablo2/

set D2GS_RELEASE=d2gs\
set URL_BNHASH_API=http://harpywar.pvpgn.pl/api.php?method=hash^&password=

:: ----------- build_pvpgn_dev VARIABLES ------------

:: current path with a backslash /
set CURRENT_PATH_BACKSLASH=%CURRENT_PATH:\=/%

:: root dir for any project
set PROJECT_ROOT_DIR=..\..\..\

set PVPGN_DEVKIT=dev\

