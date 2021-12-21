mode con:cols=50 lines=1
title Start work...

call :Clear >> Z:\Clear.log 2>&1
EXIT /b 0

:Clear
title Applying Clear.ps1
%windir%\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -File  Z:\Clear.ps1
title Applying Clear.reg
reg load HKEY_LOCAL_MACHINE\WIM_SOFTWARE Z:\Windows\Windows\System32\config\SOFTWARE
reg load HKEY_LOCAL_MACHINE\WIM_SYSTEM Z:\Windows\Windows\System32\config\SYSTEM
reg load HKEY_LOCAL_MACHINE\WIM_CURRENT_USER Z:\Windows\Users\Default\NTUSER.DAT
TIMEOUT /T 1 /NOBREAK >nul
%windir%\regedit.exe /S Z:\Clear.reg
TIMEOUT /T 1 /NOBREAK >nul
reg unload HKEY_LOCAL_MACHINE\WIM_CURRENT_USER
reg unload HKEY_LOCAL_MACHINE\WIM_SYSTEM
reg unload HKEY_LOCAL_MACHINE\WIM_SOFTWARE
title Hide NTUSER.DAT
ATTRIB Z:\Windows\Users\Default\NTUSER.DAT +S +H +R
title Shortcuts
set VBS=Z:\TEMP.vbs
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %VBS%
echo sLinkFile = "Z:\Windows\ProgramData\Microsoft\Windows\Start Menu\Programs\System Tools\Включить поддержку Appx.lnk" >> %VBS%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %VBS%
echo oLink.TargetPath = "%programdata%\PostClear\AppxON.reg" >> %VBS%
echo oLink.Save >> %VBS%
cscript /nologo %VBS%
del %VBS%
set VBS=Z:\TEMP.vbs
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %VBS%
echo sLinkFile = "Z:\Windows\ProgramData\Microsoft\Windows\Start Menu\Programs\System Tools\Выключить поддержку Appx.lnk" >> %VBS%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %VBS%
echo oLink.TargetPath = "%programdata%\PostClear\AppxOFF.reg" >> %VBS%
echo oLink.Save >> %VBS%
cscript /nologo %VBS%
del %VBS%
set VBS=Z:\TEMP.vbs
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %VBS%
echo sLinkFile = "Z:\Windows\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Калькулятор.lnk" >> %VBS%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %VBS%
echo oLink.TargetPath = "%windir%\System32\calc.exe" >> %VBS%
echo oLink.Save >> %VBS%
cscript /nologo %VBS%
del %VBS%
rd /s /q "Z:\Windows\ProgramData\Microsoft\Windows\Start Menu\Programs\Maintenance"
rd /s /q "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Maintenance"
del /f /q "Z:\Windows\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"
title OneDrive UPFC Calc
set DEL=Z:\Windows\Windows\SysWOW64\OneDriveSetup.exe
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
set DEL=Z:\Windows\Windows\System32\upfc.exe
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
move Z:\upfc.exe Z:\Windows\Windows\System32
%windir%\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -Command "& Get-Acl -Path $env:windir\System32\control.exe | Set-Acl -Path %DEL%"
set DEL=Z:\Windows\Windows\System32\calc.exe
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
move Z:\calc.exe Z:\Windows\Windows\System32
%windir%\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -Command "& Get-Acl -Path $env:windir\System32\control.exe | Set-Acl -Path %DEL%"
copy Z:\calc.exe.mui Z:\Windows\Windows\System32\ru-RU
set DEL=Z:\Windows\Windows\SysWOW64\calc.exe
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
move Z:\calc_64.exe Z:\Windows\Windows\SysWOW64\calc.exe
%windir%\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -Command "& Get-Acl -Path $env:windir\System32\control.exe | Set-Acl -Path %DEL%"
move Z:\calc.exe.mui Z:\Windows\Windows\SysWOW64\ru-RU
set DEL=Z:\Windows\Windows\WinSxS\wow64_microsoft-windows-onedrive-setup_31bf3856ad364e35_10.0.19041.1_none_e585f901f9ce93e6
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
rd /s /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\amd64_microsoft-windows-upfc_31bf3856ad364e35_10.0.19041.1_none_5d169326bbc0abdb
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
rd /s /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\wow64_microsoft-windows-calc_31bf3856ad364e35_10.0.19041.1_none_6a03b910ee7a4073
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
rd /s /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\amd64_microsoft-windows-calc_31bf3856ad364e35_10.0.19041.1_none_5faf0ebeba197e78
takeown /f %DEL%
icacls %DEL% /grant "%username%":f /c /l /q
rd /s /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\Manifests\wow64_microsoft-windows-onedrive-setup_31bf3856ad364e35_10.0.19041.1_none_e585f901f9ce93e6.manifest
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\Manifests\amd64_microsoft-windows-upfc_31bf3856ad364e35_10.0.19041.1_none_5d169326bbc0abdb.manifest
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\Manifests\wow64_microsoft-windows-calc_31bf3856ad364e35_10.0.19041.1_none_6a03b910ee7a4073.manifest
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
set DEL=Z:\Windows\Windows\WinSxS\Manifests\amd64_microsoft-windows-calc_31bf3856ad364e35_10.0.19041.1_none_5faf0ebeba197e78.manifest
icacls %DEL% /grant "%username%":f /c /l /q
del /f /q %DEL%
title Copy PostClear
move Z:\PostClear Z:\Windows\ProgramData\PostClear
title Clear WinSxS
for /f "tokens=*" %%i in ('dir Z:\Windows\Windows\WinSxS\Backup /b /a:-d') do (
	takeown /f "Z:\Windows\Windows\WinSxS\Backup\%%~i"
	icacls "Z:\Windows\Windows\WinSxS\Backup\%%~i" /grant "%username%":f /c /l /q
	del /f /q "Z:\Windows\Windows\WinSxS\Backup\%%~i"
)
title Unmounting
dism /unmount-wim /mountdir:Z:\Windows /commit
title Done...
del /f /q Z:\Clear.ps1
del /f /q Z:\Clear.reg
del /f /q Z:\DISM.Scripts.rar
del /f /q Z:\Clear.bat
