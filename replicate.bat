@Echo Off
 
REM codeblock providing brief instructions to user for list mode.
eventcreate /id 555 /D "the user %Username% executed the replication script, %~fsp0" /T Information /L Application /so PVS
CLS
Echo ---Listing changes to be made please verify correct copy actions will be performed---
timeout 5
 
REM Run's Robocopy in list mode and provides choice to confirm correct replication will be performed
Color 0C
ROBOCOPY /L /XC /XO /XN D:\vDisks\ \\%ComputerName&\D$\vDisks /XF *.LOK /XD D:\vDisks\WRITECACHE
Choice.exe /C YN /M "Do you want to proceed and copy the vDisks [Y/N]"
if errorlevel 2 goto :End
Color 07
 
REM Copies vDisks to target PVS Servers
CLS
Echo ---Copying vDisks to target---
Timeout 10
eventcreate /id 555 /D "the user %Username% began replication of the vDisk" /T Information /L Application /so PVS
ROBOCOPY /XC /XO /XN D:\vDisks\ \\%ComputerName%\D$\vDisks /XF *.LOK /XD D:\vDisks\WRITECACHE
eventcreate /id 555 /D "the user %Username% completed replication of the vDisks" /T Information /L Application /so PVS
Pause 
Exit
 
REM if No is chosen by above choice the script exits after displaying a short message
: End
Color 07
eventcreate /id 555 /D "the user %Username% quit a replication script, %~fsp0 without copying data" /T Information /L Application /so PVS
CLS
Echo ---you have chosen to not copy the vDisks, goodbye---
Timeout 10
Exit
