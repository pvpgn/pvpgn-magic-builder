Dim objShell
Dim objEnv

Set objShell = WScript.CreateObject("WScript.Shell")
Set objEnv = objShell.Environment("User")

objEnv("var1") = "This is value x"
objShell.Run "test_call_vars.vbs var1"


MsgBox objShell.ExpandEnvironmentStrings("%var1%")