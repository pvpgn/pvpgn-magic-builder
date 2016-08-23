Google translate: CN -> EN:

1. Prevent from sending large number of packets to server. 
	Need to add to registry dword value: MaxPacketPerSecond = 1200

2. (Pickup body after dead if You don't have enough attribute points fix)
	"One can use the attribute points to amend inadequate equipment and goods, pick up the body after death caused by correction of the items to copy or server bug."

3. (You will no longer get any item from body if You don't have enough space in inventory for full pick up)
	"Increasing the body pick up and equipment are prohibited items to determine, avoid burst 109 dead. That can no longer pick up the body before the error occurs click on the items on the ground after the death of the body caused by pick-up items broke.
	When the player who is equipped to pick up the body after item, the pick-up action fails, and will receive a warning line of a red font."

---

installation in Windows NT/2k

1. copy the files in this package to a diretory;
2. copy all the Diablo II 1.09c files(DLLs and MPQs) to the same directory;
3. double click the file "install.bat" to install the D2GS server
4. use "regedit" tool to edit some parameters in the system registry,
   in \\HKEY_LOCAL_MACHINE\Software\D2Server\D2GS\, mainly change the "D2CSIP"
   and "D2DBSIP" to your specified IP address, others can remain to default value;
5. start the service "Diablo II Close Game Server" in the system service controler,
   or run "net start d2gs" command.

now you can telnet to the game server's port 8888 to do some administration job.
the default password is "abcd123", and you can changed in the administration console.

enjoy yourself!


LAST CHANGE:

1. add "MOTD" (Message of The Day) in the registry. when a charater enter a game, he
will see the message. you can change MOTD in the administration console with command
"setmotd"

2. add a administration console command "kick", with which you can kick a player out 
of the game.

3. add a administration console command "msg", with which you can send a message to 
a player in the game.
MessageType can be "SYS", "C", "MT", "MC", "SC"
Target can be "#all", "#{GameId}", "CharName"

4. add command "maxuser", when online user number reach the setting, the maxgame will
automatically set to zero. and when the online user number reduce to (maxuser-8), the
maxgame will restore.

5. enable maxgamelife parameter. when game life reach the setting, the Game Server will
tell the online to quit. and one minute later, the player in that game will be kicked 
out, and the game will be destroy soon. set the value to zero to disable this feature.
