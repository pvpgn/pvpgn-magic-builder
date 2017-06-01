欢迎使用D2GS软件！
当前版本为D2GS 1.10 beta6

◇ 安装（NT/2k/XP/2k3）
1. 将本软件包里的所有文件都复制到一个目录下；
2. 将D2 1.10客户端所有文件（DLLs和MPQs等等）都复制到这个目录下；
3. 双击install.bat将D2GS以服务的形式安装到系统中；
4. 修改注册表"\\HKEY_LOCAL_MACHINE\Software\D2Server\D2GS\"下的
   相关配置，主要是D2DBSIP和D2CSIP，以及MaxGames的数值；
5. 在系统服务的控制台启动"Diablo II Close Game Server"服务，或者
   在命令行窗口下执行"net start d2gs"启动d2gs；
6. 可以开始测试了！

◇ 控制台
    D2GS启动以后，可以用telnet方式连到D2GS的8888端口上（端口可以
在注册表中修改"AdminPort"来设置）进行管理。初始密码是"abcd123"。
具体命令可以用"help"来查看。
    控制台增加了简单的history功能，可以通过上、下箭头键来调出以前
使用过的命令。

◇ 关于Diablo Clone
从beta6版本以后，开始支持World Event，即Diablo Clone事件。事件的触发
是通过配置文件d2server.ini来设置的。为了使全realm的D2GS的DC事件配置
一致，bnetd-thread-110里增加了统一发放配置的接口。具体可以在安装时
设置配置d2cs.conf关于d2gsconffile一项。把本软件包里的d2server.ini按
照您的需求设置好了以后，去掉所有被";"注释掉的行即空行（一定要记得哦），
然后按照d2cs.conf中设置的路径放好即可。

◇ D2GS 1.10 beta6后新增加的控制台命令
1. "we"
    可以查看本台D2GS上World Event的状态，看了就知道了。
2. "au"
    可以查看本台D2GS自动更新的状态。
3. "reload"
    要求D2GS重新加载World Event的配置信息。
4. "st"
    其实就是"status"命令的简写，这命令用得多，少敲点好，指头不累。
其他命令想来大家比较熟悉了，就不多说了。

◇ 其他
    新的D2GS在显示游戏列表和游戏中角色列表的时候，增加了用户的IP、帐号、
游戏密码等信息（大家一看就知道了），可能有助于管理，抓bot啥的。如果有
好的抓bot的想法，可以告诉我，呵呵。另外，由于加了这些信息，所以新的D2GS
与d2cs的通信协议也做了一些修改，具体可以看同期发布的bnetd-thread-110代码，
可能PvPGN等软件需要支持的话还得麻烦他们改了，真对不起！如果需要的话，可
以和我联系 :)

最近工作比较忙，所以新的D2GS发布得比较仓促，应该是缺了不少说明的文档，以
后再补上吧。大家要写了的话也可以发给我，我加到发布包里，先谢了！

Enjoy yourself!