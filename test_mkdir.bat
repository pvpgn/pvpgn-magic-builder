@echo off

@set PVPGN_SOURCE=source\
@set PVPGN_BUILD=build\
@set PVPGN_RELEASE=release\

@mkdir %PVPGN_RELEASE%conf
copy %PVPGN_SOURCE%conf %PVPGN_RELEASE%conf
@del %PVPGN_RELEASE%conf\CMakeLists.txt
@del %PVPGN_RELEASE%conf\Makefile.am

@mkdir %PVPGN_RELEASE%files
@copy %PVPGN_SOURCE%files %PVPGN_RELEASE%files
@del %PVPGN_RELEASE%files\CMakeLists.txt
@del %PVPGN_RELEASE%files\Makefile.am