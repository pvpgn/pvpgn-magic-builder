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


rem ----------- THIRD PARTY TOOLS ------------

:: http://gnuwin32.sourceforge.net/packages/wget.htm
::set URL_TOOL_WGET=https://kent.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-bin.zip
::set URL_TOOL_WGET_DEP=https://kent.dl.sourceforge.net/project/gnuwin32/wget/1.11.4-1/wget-1.11.4-1-dep.zip
set URL_TOOL_WGET=https://eternallybored.org/misc/wget/1.20.3/32/wget.exe

:: http://www.etree.org/md5com.html
:: (url must be http, because it can be downloaded with wget.vbs which does not support https)
set URL_TOOL_MD5SUM=http://web.archive.org/web/20170430031141/http://www.etree.org:80/cgi-bin/counter.cgi/software/md5sum.exe

:: https://fossies.org/windows/misc/unz600xn.exe/
set URL_TOOL_UNZIP=https://fossies.org/windows/misc/unz600xn.exe/unzip.exe

:: https://github.com/Microsoft/vswhere
set URL_TOOL_VSWHERE=https://github.com/microsoft/vswhere/releases/download/3.0.1/vswhere.exe

:: https://cmake.org
set CMAKE_VER=3.23.1
set CMAKE_VERSION=cmake-%CMAKE_VER%-windows-i386
set URL_TOOL_CMAKE=https://github.com/Kitware/CMake/releases/download/v%CMAKE_VER%/%CMAKE_VERSION%.zip
set CMAKE_VERSION_64=cmake-%CMAKE_VER%-win64-x64
set URL_TOOL_CMAKE_64=https://github.com/Kitware/CMake/releases/download/v%CMAKE_VER%/%CMAKE_VERSION_64%.zip

:: ----------- build_pvpgn VARIABLES ------------

:: LOG=false output cmake and vs output to console
:: LOG=true logs cmake and vs output to cmake.log, visualstudio.log
set LOG=false


set PVPGN_SOURCE=source\
set PVPGN_BUILD=build\

set URL_UPDATE=https://raw.githubusercontent.com/pvpgn/pvpgn-magic-builder/master/

set PVPGN_PATH=https://github.com/pvpgn/pvpgn-server/archive/

:: http://gnuwin32.sourceforge.net/packages/zlib.htm
set ZLIB_PATH=%CURRENT_PATH%module\include\zlib\1.2.11\
set ZLIB_PATH_64=%CURRENT_PATH%module\include\zlib\x64\1.2.11\
:: http://luabinaries.sourceforge.net/download.html
set LUA_PATH=module\include\lua\5.1.5\
set LUA_PATH_64=module\include\lua\x64\5.1.5\
:: https://curl.se/windows/
set CURL_PATH=%CURRENT_PATH%module\include\curl\7.74.0\
set CURL_PATH_64=%CURRENT_PATH%module\include\curl\x64\7.74.0\

:: FIXME: important full path?
set ATLMFC_INCLUDE_PATH=%CURRENT_PATH%module\include\atlmfc\


:: ----------- build_d2gs VARIABLES ------------
set URL_MPQ=http://cdn.pvpgn.pro/diablo2/

set D2GS_RELEASE=d2gs\
set URL_BNHASH_API=http://harpywar.pvpgn.pl/api.php?method=hash^&password=

:: ----------- build_pvpgn_dev VARIABLES ------------

:: full path to the magic builder directory separated and ends with a backslash "/"
set CURRENT_PATH_BACKSLASH=%CURRENT_PATH:\=/%

:: root dir for any project
set PROJECT_ROOT_DIR=..\..\..\

set PVPGN_DEVKIT=dev\

