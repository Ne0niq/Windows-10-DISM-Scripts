mode con:cols=50 lines=1
title Clear.bat work...

call :Clear >> Z:\Clear.log 2>&1
EXIT /b 0

:Clear
C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -File  Z:\Clear.ps1
reg load HKEY_LOCAL_MACHINE\WIM_SOFTWARE Z:\Windows\Windows\System32\config\SOFTWARE
reg load HKEY_LOCAL_MACHINE\WIM_SYSTEM Z:\Windows\Windows\System32\config\SYSTEM
reg load HKEY_LOCAL_MACHINE\WIM_CURRENT_USER Z:\Windows\Users\Default\NTUSER.DAT
TIMEOUT /T 1 /NOBREAK >nul
C:\Windows\regedit.exe /S Z:\Clear.reg
TIMEOUT /T 1 /NOBREAK >nul
reg unload HKEY_LOCAL_MACHINE\WIM_CURRENT_USER
reg unload HKEY_LOCAL_MACHINE\WIM_SYSTEM
reg unload HKEY_LOCAL_MACHINE\WIM_SOFTWARE
rd /s /q "Z:\Windows\Program Files (x86)\Microsoft\EdgeUpdate"
rd /s /q "Z:\Windows\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67\Installer"
del /f /q "Z:\Windows\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67\elevation_service.exe"
del /f /q "Z:\Windows\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67\notification_helper.exe"
del /f /q "Z:\Windows\Program Files (x86)\Microsoft\Edge\Application\92.0.902.67\notification_helper.exe.manifest"
set SCRIPT="Z:\TEMP.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
set SCRIPT="Z:\TEMP.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Включить поддержку Appx.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ProgramData%\PostClear\AppxON.reg" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
set SCRIPT="Z:\TEMP.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Выключить поддержку Appx.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%ProgramData%\PostClear\AppxOFF.reg" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
rd /s /q "Z:\Windows\ProgramData\Microsoft\Windows\Start Menu\Programs\Maintenance"
rd /s /q "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Maintenance"
del /f /q "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
takeown /f Z:\Windows\Windows\SysWOW64\OneDriveSetup.exe
icacls Z:\Windows\Windows\SysWOW64\OneDriveSetup.exe /grant "%username%":f /c /l /q
del /f /q Z:\Windows\Windows\SysWOW64\OneDriveSetup.exe
takeown /f Z:\Windows\Windows\System32\upfc.exe
icacls Z:\Windows\Windows\System32\upfc.exe /grant "%username%":f /c /l /q
del /f /q Z:\Windows\Windows\System32\upfc.exe
copy Z:\upfc.exe Z:\Windows\Windows\System32
icacls Z:\Windows\Windows\System32\upfc.exe /inheritance:d
icacls Z:\Windows\Windows\System32\upfc.exe /setowner "NT SERVICE\TrustedInstaller" /c /l /q
icacls Z:\Windows\Windows\System32\upfc.exe /grant:r "NT SERVICE\TrustedInstaller":f
icacls Z:\Windows\Windows\System32\upfc.exe /grant:r "*S-1-5-18":rx
icacls Z:\Windows\Windows\System32\upfc.exe /grant:r "*S-1-5-32-544":rx
takeown /f Z:\Windows\Windows\WinSxS\wow64_microsoft-windows-onedrive-setup_31bf3856ad364e35_10.0.19041.1_none_e585f901f9ce93e6
icacls Z:\Windows\Windows\WinSxS\wow64_microsoft-windows-onedrive-setup_31bf3856ad364e35_10.0.19041.1_none_e585f901f9ce93e6 /grant "%username%":f /c /l /q
rd /s /q Z:\Windows\Windows\WinSxS\wow64_microsoft-windows-onedrive-setup_31bf3856ad364e35_10.0.19041.1_none_e585f901f9ce93e6
takeown /f Z:\Windows\Windows\WinSxS\amd64_microsoft-windows-upfc_31bf3856ad364e35_10.0.19041.1_none_5d169326bbc0abdb
icacls Z:\Windows\Windows\WinSxS\amd64_microsoft-windows-upfc_31bf3856ad364e35_10.0.19041.1_none_5d169326bbc0abdb /grant "%username%":f /c /l /q
rd /s /q Z:\Windows\Windows\WinSxS\amd64_microsoft-windows-upfc_31bf3856ad364e35_10.0.19041.1_none_5d169326bbc0abdb
mkdir Z:\Windows\ProgramData\PostClear
xcopy Z:\PostClear Z:\Windows\ProgramData\PostClear
for /f "tokens=*" %%i in ('dir Z:\Windows\Windows\WinSxS\Backup /b /a:-d') do (
	takeown /f "Z:\Windows\Windows\WinSxS\Backup\%%~i"
	icacls "Z:\Windows\Windows\WinSxS\Backup\%%~i" /grant "%username%":f /c /l /q
	del /f /q "Z:\Windows\Windows\WinSxS\Backup\%%~i"
)
dism /unmount-wim /mountdir:Z:\Windows /commit
rd /s /q Z:\PostClear
del /f /q Z:\DISM.Scripts.rar
del /f /q Z:\Clear.ps1
del /f /q Z:\Clear.reg
del /f /q Z:\upfc.exe
del /f /q Z:\Clear.bat
