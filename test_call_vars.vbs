Dim objShell
Dim objEnv

Set objShell = WScript.CreateObject("WScript.Shell")
Set objEnv = objShell.Environment("User")

Dim varName
varName = Wscript.Arguments.Item(0)

objEnv(varName) = "This new value is 2"
