# Required cmake version
cmake_minimum_required(VERSION 2.4.3)

if(COMMAND cmake_policy)
	cmake_policy(SET CMP0003 NEW)
endif(COMMAND cmake_policy)

# Put the include dirs which are in the source or build tree
# before all other include dirs, so the headers in the sources
# are prefered over the already installed ones
# since cmake 2.4.1
set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

project(pvpgn)

option(WITH_BNETD "compile the bnetd target" ON)
option(WITH_D2CS "compile the d2cs target" ON)
option(WITH_D2DBS "compile the d2dbs target" ON)
option(WITH_ANSI "enforce strict ISO C++ conforming" ON)
if(WIN32)
  option(WITH_WIN32_GUI "enable GUI building (default on)" ON)
endif(WIN32)

#storage backends flags
option(WITH_MYSQL "include MySQL user accounts support" OFF)
option(WITH_SQLITE3 "include SQLite3 user accounts support" OFF)
option(WITH_PGSQL "include PostgreSQL user accounts support" OFF)
option(WITH_ODBC "include ODBC user accounts support" OFF)
include(ConfigureChecks.cmake)

subdirs(src conf man files)
ENABLE_TESTING()
