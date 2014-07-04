PvPGN Magic Builder gives you an easy way to build your own PvPGN binaries from the latest
source code for Windows.

Let's see how it works in one-minute video: http://www.youtube.com/watch?v=70KYeFqG34M

[![PvPGN Builder](http://i.imgur.com/7VVSjji.png)](http://i.imgur.com/ySKCB8G.png) [![D2GS Builder](http://i.imgur.com/c5YaCs3.png)](http://i.imgur.com/0ezOHmm.png)



_*Note: use [Development Kit](https://github.com/HarpyWar/pvpgn-magic-builder/wiki/PvPGN-Development-Kit) to modify and debug your source code.*_

 
Features
--
 * Builds a [PvPGN](https://github.com/HarpyWar/pvpgn) with one of the databases support: [MySQL](http://wikipedia.org/wiki/MySQL), [PostgreSQL](http://wikipedia.org/wiki/PostgreSQL), [SQLite3](http://wikipedia.org/wiki/SQLite) or [ODBC](http://wikipedia.org/wiki/Open_Database_Connectivity). Feature to enable [Lua](http://en.wikipedia.org/wiki/Lua_(programming_language)) scripting
 * Builds any version of [D2GS](http://harpywar.com/?a=articles&b=2&c=2&d=21), feature to download all DLL and MPQ that are necessary to start your server
 * Doesn’t require additional files - all built in
 * Has a multilanguage command line interface: Russian, English, Dutch, German, Polish, Serbian (please, translate [this file](https://github.com/HarpyWar/pvpgn-magic-builder/blob/master/module/i18n.inc.bat) if you know others)
 * (optional) [Auto updates](https://code.google.com/p/pvpgn-magic-builder/wiki/AutoUpdate)
 * (optional) Auto downloads the latest PvPGN source code from the GIT
 * Auto configurates and compilates PvPGN source code
 * Auto create `release\` directory with a PvPGN binaries and support files that are ready to use immediately

Requirements
--
 * Visual C++ 2005 (Express is not supported)
 * Visual C++ 2008 (Express is supported)
 * Visual C++ 2010 (Express is supported)
 * Visual C++ 2012 (Express is supported)
 * Visual C++ 2013 (Express is supported)

("Express" is the light edition of Visual Studio. It's free to [download](http://www.microsoft.com/visualstudio/downloads))

Issues
--
 * Check write/modify permissions of the directory where Magic Builder is placed.
 * Put modified files into `source\` directory to build your own source code

 Do you have a trouble? Please, follow these steps:
 
  1) Open `build_pvpgn.bat` and change var "`set LOG=true`" at beginning of the file. 
  
  2) Start `build_pvpgn.bat` and then `.log` files will appear in the same directory when the process is finished. 
  
  3) Attach logs to your message in the [https://github.com/HarpyWar/pvpgn-magic-builder/issues Issues list]:
    * cmake.log
    * svn.log
    * visualstudio.log
    * build\CMakeCache.txt
    * build\CMakeFiles\CMakeError.log
    * build\CMakeFiles\CMakeOutput.log

_*Note: Magic Builder can't build PvPGN 1.8.5. It works with [PvPGN 2.x](https://github.com/HarpyWar/pvpgn) only.*_

Discussions
--
 * (Русский) http://forums.harpywar.com/viewtopic.php?id=448
 * (English) http://forums.pvpgn.org/index.php?topic=4460
