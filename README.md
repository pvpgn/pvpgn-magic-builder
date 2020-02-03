
PvPGN Magic Builder
=====

PvPGN Magic Builder gives you an easy way to build your own PvPGN binaries from the latest
source code for Windows.

Let's see how it works in one-minute video: 
http://www.youtube.com/watch?v=70KYeFqG34M

Use Magic Builder to build Visual Studio solution:
https://www.youtube.com/watch?v=98of8yEQt6o

[![PvPGN Builder](http://i.imgur.com/7VVSjji.png)](http://i.imgur.com/ySKCB8G.png) [![D2GS Builder](http://i.imgur.com/c5YaCs3.png)](http://i.imgur.com/0ezOHmm.png)


Features
--
 * Builds [PvPGN](https://github.com/pvpgn/pvpgn-server) with one of the databases support: [MySQL](http://wikipedia.org/wiki/MySQL), [PostgreSQL](http://wikipedia.org/wiki/PostgreSQL), [SQLite3](http://wikipedia.org/wiki/SQLite) or [ODBC](http://wikipedia.org/wiki/Open_Database_Connectivity). Feature to enable [Lua](http://en.wikipedia.org/wiki/Lua_(programming_language)) scripting. Feature to choose Git branch to download source code from.
 * Builds any version of [D2GS](http://harpywar.com/?a=articles&b=2&c=2&d=21), feature to download all DLL and MPQ that are necessary to start your server
 * Doesn’t require additional files - all built in
 * Has a multilanguage command line interface: Russian, English, Dutch, German, Polish, Serbian, Spanish, Ukrainian (please, translate [this file](https://github.com/pvpgn/pvpgn-magic-builder/blob/master/module/i18n/ENU.bat) if you know others)
 * (optional) [Auto updates](https://code.google.com/p/pvpgn-magic-builder/wiki/AutoUpdate)
 * (optional) Auto downloads actual PvPGN source code from the GIT
 * Auto configurates and compilates PvPGN source code
 * Auto create `release\` directory with a PvPGN binaries and support files that are ready to use immediately
 * Auto create Visual Studio projects and `pvpgn.sln`, with it you can immediately start a development (use `build_pvpgn_dev.bat`)

Requirements
--
 * Visual C++ 2015 (Community is supported)
 * Visual C++ 2017 (Community is supported)
 * Visual C++ 2019 (Community is supported)

"Community" is the light edition of Visual Studio. It's free to [download](https://www.visualstudio.com/downloads/).

*Note: Visual Studio doesn't install C++ by default. If you already have it installed then you have to rerun the setup and check `Desktop development with C++`.*

![Visual Studio 2017 C++ Installation](http://i.imgur.com/otoT4qe.png)

*Without C++ installed Magic Builder throws an error `The CXX compiler identification is unknown`*


Downloads
--
Go to [Release](https://github.com/pvpgn/pvpgn-magic-builder/releases) section and download the latest release.

[![Github Downloads](https://img.shields.io/github/downloads/pvpgn/pvpgn-magic-builder/total.svg?maxAge=2592000)](https://github.com/pvpgn/pvpgn-magic-builder/releases)


Discussions
--
 * (Русский) http://forums.harpywar.com/viewtopic.php?id=448
 * (English) http://forums.pvpgn.org/index.php?topic=4460
