Multithreaded Game Server for Diablo II 1.13c Closed Battle.Net
https://github.com/tesseract2048/d2gs
---------------------------------------------------------------

D2GS for 1.13c
========================
based on the work of marsgod & onlyer & faster

optimized D2GS & D2GE in C++ (used in production for 91D2.cn)


Features
========================
support multi D2GE process
global DC counter
firewall to prevent item hacking

Components
[D2GS]
========================
Diablo II Game Server, designed for handling clients and s2s communications.

[D2GE]
========================
Diablo II Game Engine, designed for really handling game logic. Based on Diablo II binaries, depending on LibD2Server.

LibD2Server
========================
Library designed to patch Diablo II binaries and make them ready to serve.

Build Instruction
D2GS & D2GE
========================
Use Visual Studio 2010 or later IDE to build. Nothing special.

Deployment
D2GS & D2GE
========================
These components should be deployed into a Diablo II 1.13c game folder, so that libraries and MPQs can be used.

Run
========================
Start D2GS.exe, and one or more D2GE.exe will be automatically started.

Config
========================
All configurations are stored in registry: HKEY_LOCAL_MACHINE\Software\D2Server\D2GS13

LICENSE
========================
This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.