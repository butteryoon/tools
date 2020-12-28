Set WshShell = CreateObject("WScript.Shell")

argCnt = WScript.arguments.count 

WshShell.Sleep(5000)
WshShell.Echo("5 seconds have passed.")


for i=1 to argCnt	
    arg = WshShell.arguments.item(i-1)
    WshShell.echo (arg)
    next i


intReturn = WshShell.Run("C:\IIOT-LIVEVIEW\LIVEVIEW.exe IP=106.240.249.74 PORT=15221 ID=softroom PW=NULL TITLE=m+CAM SITE=LS PLAYMODE=0 BASEGRID=1 GRIDMENU=16 PLAYLIST=1 INFO=1 INSTANCE=1 RESIZE=0 FULLSCREEN=1 TIMEMACHINE=1 ROLLING=1 SETTING=1 CAPTURE=1" & WScript.ScriptFullName, 1, TRUE)

Set WshShell = Nothing



