' Fetch json data from url and return extracted values
' If return many values then it concat with comma delimeter
' input arguments = url, keyToFind, nodeLevel, maxValueCount
'
' Two used examples:
' input: "https://api.github.com/repos/pvpgn/pvpgn-server/branches" "name" "1" "0"
' output: develop, master
'
' input: "https://api.github.com/repos/pvpgn/pvpgn-server/branches/master" "date" "4" "1"
' output: 2018-02-11



call render( wscript.Arguments.Item(0), wscript.Arguments.Item(1), wscript.Arguments.Item(2), wscript.Arguments.Item(3) )




sub render(url, keyToFind, nodeLevel, maxOutputCount)

	' fetch json string
	Dim objShell
	Set objShell = Wscript.CreateObject("WScript.Shell")
	json = objShell.Exec("cscript //nologo %TOOLS_PATH%wget.vbs /s " & url & " /raw").StdOut.ReadAll()

	' remove quotes
	json = Replace(json,"""","")

	'WScript.Echo json + " ------------ "

	Dim chr, tmpKey, tmpValue, output, bracketNum, braceNum, keyFound, valueFound, lastValueFound
	bracketNum = 0
	braceNum = 0
	valueCount = 0
	keyFound = valueFound = lastValueFound = 0
	tmpValue = ""
	output = ""

	For i=1 To Len(json)-1
		chr = Mid(json,i,1)
		if chr = "[" then
			bracketNum = bracketNum+1
			valueFound = keyFound = 0
		end if
		if chr = "{" then
			braceNum = braceNum+1
			valueFound = keyFound = 0
		end if
		if chr = "]" then
			bracketNum = bracketNum-1
			valueFound = keyFound = 0
		end if
		if chr = "}" then
			braceNum = braceNum-1
			valueFound = keyFound = 0
		end if
		if chr = "," then
			valueFound = keyFound = 0
		end if
		
			
		''' KEY
		if braceNum = Int(nodeLevel) then ' int because nodeLevel passed as string argument
			tmpKey = readKey(json,i,Len(keyToFind))
			if tmpKey = keyToFind then
				keyFound = 1
				'wscript.echo "key found " + keyToFind
			end if
		end if
		

		if valueFound = 1 then
			tmpValue = tmpValue + chr
		end if
		
		' end read value
		if (lastValueFound = 1) and (valueFound <> 1) then 
		
			valueCount = valueCount + 1
			
			if valueCount > 1 then
				output = output & ","
			end if
			
			output = output & tmpValue
			tmpValue = ""
			keyFound = 0
			
			' limit found values
			if Int(maxOutputCount) <> 0 and valueCount >= Int(maxOutputCount) then
				exit for
			end if
		end if
		
		lastValueFound = valueFound

		
		''' VALUE
		if (keyFound = 1) and (valueFound <> 1) and (chr = ":") then
			valueFound = 1
			'wscript.echo "value found " + chr + cstr(i)
		end if
		
	Next 
	
	WScript.Echo Trim(output)
	
	Set objShell = Nothing

end sub


function readKey(data, i, length)
	if i + length > Len(data)-1 then
		exit function
	end if
	readKey = Mid(data, i, length)
end function
