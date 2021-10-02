mode con:cols=50 lines=1
title PostClear.bat work...

IF EXIST C:\ProgramData\PostClear\PostClearM.reg (
	call :PostClearM >> C:\PostClear.log 2>&1
) else (
	call :PostClearU
)

EXIT /b 0

:PostClearM
taskkill /f /im StartMenuExperienceHost.exe
taskkill /f /im explorer.exe
taskkill /f /im backgroundTaskHost.exe
taskkill /f /im TextInputHost.exe
taskkill /f /im SearchApp.exe
TIMEOUT /T 2 /NOBREAK >nul
move C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy.disable
move C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy.disable
move C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy.disable
if not exist C:\Windows\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy.disable Goto PostClearM
if not exist C:\Windows\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy.disable Goto PostClearM
if not exist C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy.disable Goto PostClearM
C:\ProgramData\PostClear\ClassicShell.msi /qn ADDLOCAL=ClassicStartMenu
net stop UsoSvc
TIMEOUT /T 1 /NOBREAK >nul
C:\ProgramData\PostClear\AdvancedRun.exe /EXEFilename C:\Windows\regedit.exe /CommandLine "/S C:\ProgramData\PostClear\PostClearM.reg" /RunAs 4 /WaitProcess 1 /Run
TIMEOUT /T 1 /NOBREAK >nul
schtasks /delete /tn Microsoft\XblGameSave\XblGameSaveTask /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\PcaPatchDbTask" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\ProgramDataUpdater" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\StartupAppTask" /f
schtasks /delete /tn Microsoft\Windows\CloudExperienceHost\CreateObjectTask /f
schtasks /delete /tn "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f
schtasks /delete /tn "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f
schtasks /delete /tn Microsoft\Windows\Defrag\ScheduledDefrag /f
schtasks /delete /tn Microsoft\Windows\DiskCleanup\SilentCleanup /f
schtasks /delete /tn "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /f
schtasks /delete /tn Microsoft\Windows\HelloFace\FODCleanupTask /f
schtasks /delete /tn "Microsoft\Windows\International\Synchronize Language Settings" /f
schtasks /delete /tn Microsoft\Windows\Maintenance\WinSAT /f
schtasks /delete /tn Microsoft\Windows\Maps\MapsToastTask /f
schtasks /delete /tn Microsoft\Windows\Maps\MapsUpdateTask /f
schtasks /delete /tn Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents /f
schtasks /delete /tn Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic /f
schtasks /delete /tn "Microsoft\Windows\Offline Files\Background Synchronization" /f
schtasks /delete /tn "Microsoft\Windows\Offline Files\Logon Synchronization" /f
schtasks /delete /tn Microsoft\Windows\PushToInstall\LoginCheck /f
schtasks /delete /tn Microsoft\Windows\PushToInstall\Registration /f
schtasks /delete /tn Microsoft\Windows\RetailDemo\CleanupOfflineContent /f
schtasks /delete /tn Microsoft\Windows\Setup\SetupCleanupTask /f
schtasks /delete /tn Microsoft\Windows\Speech\SpeechModelDownloadTask /f
schtasks /delete /tn Microsoft\Windows\UNP\RunUpdateNotificationMgr /f
schtasks /delete /tn "Microsoft\Windows\User Profile Service\HiveUploadTask" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f
schtasks /delete /tn "Microsoft\Windows\Windows Error Reporting\QueueReporting" /f
schtasks /delete /tn "Microsoft\Windows\WindowsUpdate\Scheduled Start" /f
C:\ProgramData\PostClear\LGPO.exe /m C:\ProgramData\PostClear\GPm.pol
C:\ProgramData\PostClear\LGPO.exe /u C:\ProgramData\PostClear\GPu.pol
gpupdate /force
net stop SysMain
TIMEOUT /T 1 /NOBREAK >nul
for /f "tokens=*" %%i in ('dir /b /s C:\Windows\Prefetch\*.pf') do (
	del /f /q "%%~i"
)
net stop WSearch
TIMEOUT /T 1 /NOBREAK >nul
rd /s /q C:\ProgramData\Microsoft\Search
rd /s /q C:\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator
del /f /q C:\ProgramData\PostClear\AdvancedRun.exe
del /f /q C:\ProgramData\PostClear\ClassicShell.msi
del /f /q C:\ProgramData\PostClear\GPm.pol
del /f /q C:\ProgramData\PostClear\GPu.pol
del /f /q C:\ProgramData\PostClear\LGPO.exe
del /f /q C:\ProgramData\PostClear\PostClearM.reg
:PostClearU
C:\Windows\regedit.exe /S C:\ProgramData\PostClear\PostClearU.reg
TIMEOUT /T 1 /NOBREAK >nul
del /f /q "%userprofile%\Desktop\Microsoft Edge.lnk"
SHUTDOWN -r -t 3
title Done. Rebooting...
TIMEOUT /T 3 /NOBREAK >nul
