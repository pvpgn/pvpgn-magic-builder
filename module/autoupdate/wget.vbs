' Downloads a file from arg0 to arg1
'  Copyright 2011 HarpyWar (harpywar@gmail.com)
'  http://harpywar.com
'
' examples:
'  wget.vbs /s http://example.com/test.txt
'  wget.vbs /f [source] [destination]
' if local path not exists, wget.vbs will create it.
On Error Resume Next

Dim args
args = wscript.Arguments.Count

if args < 2 then
  wscript.Echo "usage: wget.vbs [flag] [remote_url] {destination_file}" & vbcrlf & " flag = /s - download and return string" & vbcrlf & " flag = /f download file to destination"
  wscript.Quit 1
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
	if client.Status = 200 then
		wscript.Echo HTMLEncode(client.responseText)
		wscript.Quit
	else
		wscript.Echo "error code: " & client.Status
		wscript.Quit 1
	end if
end if

if args < 2 then
	wscript.Echo "Destination location was not initialize"
	wscript.Quit 1
end if
Destination = wscript.Arguments.Item(2)
CreatePathDirs(Destination)

' download file
If client.Status = 200 Then 
	

	Set stream = CreateObject("ADODB.Stream") 
	Const adTypeBinary = 1
	Const adSaveCreateOverWrite = 2
	Const adSaveCreateNotExist = 1 ' save only if file non exists, otherwise error

	stream.Open 
	stream.Type = adTypeBinary 
	stream.Write client.responseBody 
	stream.SaveToFile Destination, adSaveCreateOverWrite
	stream.Close 
	wscript.Echo "ok"
	wscript.Quit
else
	wscript.Echo "error code: " & client.Status
	wscript.Quit 9009
End If 

' any exception
if  Err.Number <> 0  then   
	wscript.Echo "unknown error: " & err.Number
	wscript.Quit 1
end if

' creates directories in each section of path, if not exists
Sub CreatePathDirs(ByVal path)
	Dim objFSO, strPath
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	sections=Split(path,"\")
	
	if UBound(sections) > 0 then
		For i = 0 To UBound(sections) - 1
			strPath = strPath & sections(i) & "\" 
			If Not objFSO.FolderExists(strPath) Then
			   objFSO.CreateFolder(strPath)
			End If
		Next
	end if
End sub


' encode html symbols to "_" (for batch)
Function HTMLEncode(ByVal sVal)

    sReturn = ""

    If ((TypeName(sVal)="String") And (Not IsNull(sVal)) And (sVal<>"")) Then
    
        For i = 1 To Len(sVal)
        
            ch = Mid(sVal, i, 1)

            Set oRE = New RegExp : oRE.Pattern = "[ a-zA-Z0-9.+_]"

            If (Not oRE.Test(ch)) Then
                'ch = "&#" & Asc(ch) & ";"
				ch = "_"
            End If

            sReturn = sReturn & ch
            
            Set oRE = Nothing
        Next
    End If
    
    HTMLEncode = sReturn
End Function