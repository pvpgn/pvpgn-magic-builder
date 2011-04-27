' Downloads a file from arg0 to arg1
'  Copyright 2011 HarpyWar (harpywar@gmail.com)
'  http://harpywar.com

Dim args
args = wscript.Arguments.Count

if args < 2 then
  wscript.Echo "usage: wget.vbs [flag] [remote_url] {destination_file}" & vbcrlf & " flag = /s - download and return string" & vbcrlf & " flag = /f download file to destination"
  wscript.Quit
end if

Flag = wscript.Arguments.Item(0)
Source = wscript.Arguments.Item(1)

Dim client 
Dim stream 
Set client = CreateObject("MSXML2.XMLHTTP.3.0") 
client.Open "GET", Source, False 
client.Send ""

' echo string and quit
if Flag = "/s" then
	wscript.Echo client.responseText
	wscript.Quit
end if

if args < 2 then
	wscript.Echo "Destination location was not initialize"
	wscript.Quit
end if
Destination = wscript.Arguments.Item(2)

' download file
If client.Status = 200 Then 
	Set stream = CreateObject("ADODB.Stream") 
	stream.Open 
	stream.Type = 1 
	stream.Write client.responseBody 
	stream.SaveToFile Destination 
	stream.Close 
	wscript.Echo "ok"
else
	wscript.Echo "error code: " & client.Status
End If 