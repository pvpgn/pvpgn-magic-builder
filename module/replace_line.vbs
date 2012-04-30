' replace line in file
' arguments:
'  1 - filename
'  2 - find string at start of line
'  3 - replace string

Const ForReading = 1    
Const ForWriting = 2

strFileName = Wscript.Arguments(0)
strOldText = Wscript.Arguments(1)
strNewText = Wscript.Arguments(2)


' replace quotes in args
strOldText = Replace(strOldText, "[[quote]]", chr(34))
strNewText = Replace(strNewText, "[[quote]]", chr(34))

' new content
dim newText

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileName, ForReading)
' read each line
Do While objFile.AtEndOfStream <> True
    line=objFile.ReadLine    

	if Mid(line, 1, len(strOldText)) = strOldText then
		wscript.echo "ok"
		newText = newText & strNewText
	else
		newText = newText & line
	end if

	newText = newText & vbcrlf
Loop

' write new text to a file
Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.Write newText
objFile.Close