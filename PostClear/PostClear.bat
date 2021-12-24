mode con:cols=50 lines=1
title Start work...

IF EXIST %programdata%\PostClear\PostClearM.reg (
	call :PostClearM >> C:\PostClear.log 2>&1
) else (
	call :PostClearU
)

EXIT /b 0

:PostClearM
title Deleting EdgeUpdate
taskkill /f /im MicrosoftEdgeUpdate.exe
taskkill /im msedge.exe
taskkill /f /im elevation_service.exe
taskkill /f /im notification_helper.exe
TIMEOUT /T 1 /NOBREAK >nul
rd /s /q "%programfiles(x86)%\Microsoft\EdgeUpdate"
rd /s /q "%programfiles(x86)%\Microsoft\Edge\Application\92.0.902.67\Installer"
del /f /q "%programfiles(x86)%\Microsoft\Edge\Application\92.0.902.67\elevation_service.exe"
del /f /q "%programfiles(x86)%\Microsoft\Edge\Application\92.0.902.67\notification_helper.exe"
del /f /q "%programfiles(x86)%\Microsoft\Edge\Application\92.0.902.67\notification_helper.exe.manifest"
if exist "%programfiles(x86)%\Microsoft\EdgeUpdate" Goto PostClearM
:StartMenu
title Replacing StartMenu
taskkill /f /im StartMenuExperienceHost.exe
taskkill /f /im explorer.exe
taskkill /f /im backgroundTaskHost.exe
taskkill /f /im TextInputHost.exe
taskkill /f /im SearchApp.exe
TIMEOUT /T 2 /NOBREAK >nul
move %windir%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy %windir%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy.disable
move %windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy %windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy.disable
move %windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy %windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy.disable
if not exist %windir%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy.disable Goto StartMenu
if not exist %windir%\SystemApps\MicrosoftWindows.Client.CBS_cw5n1h2txyewy.disable Goto StartMenu
if not exist %windir%\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy.disable Goto StartMenu
%programdata%\PostClear\ClassicShell.msi /qn ADDLOCAL=ClassicStartMenu
xcopy /y "%programdata%\PostClear\Classic Shell" "%programfiles%\Classic Shell"
title Stopping Orchestrator
net stop UsoSvc
TIMEOUT /T 1 /NOBREAK >nul
title Applying PostClearM.reg
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\regedit.exe /CommandLine "/S %programdata%\PostClear\PostClearM.reg" /RunAs 4 /WaitProcess 1 /Run
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}" /v location /t REG_SZ /d "%programfiles(x86)%\Microsoft\Edge\Application"
TIMEOUT /T 1 /NOBREAK >nul
title Deleting Edge services
sc delete MicrosoftEdgeElevationService
sc delete edgeupdate
sc delete edgeupdatem
title Deleting tasks
schtasks /delete /tn MicrosoftEdgeUpdateTaskMachineCore /f
schtasks /delete /tn MicrosoftEdgeUpdateTaskMachineUA /f
schtasks /delete /tn Microsoft\XblGameSave\XblGameSaveTask /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\PcaPatchDbTask" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\ProgramDataUpdater" /f
schtasks /delete /tn "Microsoft\Windows\Application Experience\StartupAppTask" /f
schtasks /delete /tn Microsoft\Windows\Autochk\Proxy /f
schtasks /delete /tn Microsoft\Windows\CloudExperienceHost\CreateObjectTask /f
schtasks /delete /tn "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f
schtasks /delete /tn "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f
schtasks /delete /tn Microsoft\Windows\Defrag\ScheduledDefrag /f
schtasks /delete /tn Microsoft\Windows\DiskCleanup\SilentCleanup /f
schtasks /delete /tn Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector /f
schtasks /delete /tn "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /f
schtasks /delete /tn Microsoft\Windows\Feedback\Siuf\DmClient /f
schtasks /delete /tn Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload /f
schtasks /delete /tn "Microsoft\Windows\FileHistory\File History (maintenance mode)" /f
schtasks /delete /tn Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures /f
schtasks /delete /tn Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing /f
schtasks /delete /tn Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting /f
schtasks /delete /tn Microsoft\Windows\Flighting\OneSettings\RefreshCache /f
schtasks /delete /tn Microsoft\Windows\HelloFace\FODCleanupTask /f
schtasks /delete /tn "Microsoft\Windows\International\Synchronize Language Settings" /f
schtasks /delete /tn Microsoft\Windows\Maintenance\WinSAT /f
schtasks /delete /tn Microsoft\Windows\Maps\MapsToastTask /f
schtasks /delete /tn Microsoft\Windows\Maps\MapsUpdateTask /f
schtasks /delete /tn Microsoft\Windows\MemoryDiagnostic\ProcessMemoryDiagnosticEvents /f
schtasks /delete /tn Microsoft\Windows\MemoryDiagnostic\RunFullMemoryDiagnostic /f
schtasks /delete /tn Microsoft\Windows\NetTrace\GatherNetworkInfo /f
schtasks /delete /tn "Microsoft\Windows\Offline Files\Background Synchronization" /f
schtasks /delete /tn "Microsoft\Windows\Offline Files\Logon Synchronization" /f
schtasks /delete /tn Microsoft\Windows\PI\Sqm-Tasks /f
schtasks /delete /tn "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /f
schtasks /delete /tn Microsoft\Windows\PushToInstall\LoginCheck /f
schtasks /delete /tn Microsoft\Windows\PushToInstall\Registration /f
schtasks /delete /tn Microsoft\Windows\RetailDemo\CleanupOfflineContent /f
schtasks /delete /tn Microsoft\Windows\Setup\SetupCleanupTask /f
schtasks /delete /tn Microsoft\Windows\Shell\FamilySafetyMonitor /f
schtasks /delete /tn Microsoft\Windows\Shell\FamilySafetyRefreshTask /f
schtasks /delete /tn Microsoft\Windows\Speech\SpeechModelDownloadTask /f
schtasks /delete /tn "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /f
schtasks /delete /tn "Microsoft\Windows\Time Synchronization\SynchronizeTime" /f
schtasks /delete /tn "Microsoft\Windows\Time Zone\SynchronizeTimeZone" /f
schtasks /delete /tn Microsoft\Windows\UNP\RunUpdateNotificationMgr /f
schtasks /delete /tn "Microsoft\Windows\User Profile Service\HiveUploadTask" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /f
schtasks /delete /tn "Microsoft\Windows\Windows Defender\Windows Defender Verification" /f
schtasks /delete /tn "Microsoft\Windows\Windows Error Reporting\QueueReporting" /f
schtasks /delete /tn "Microsoft\Windows\WindowsUpdate\Scheduled Start" /f
schtasks /create /tn "Microsoft\Windows\WindowsUpdate\Scheduled Start" /tr %windir%\explorer.exe /sc once /sd 30/11/1999 /st 00:00 /ru SYSTEM
schtasks /change /tn "Microsoft\Windows\WindowsUpdate\Scheduled Start" /disable
%windir%\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy remotesigned -Command "& Get-Acl -Path $env:windir\System32\control.exe | Set-Acl -Path $env:windir\System32\Tasks\Microsoft\Windows\WindowsUpdate\Scheduled` Start"
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn "Microsoft\Windows\UpdateOrchestrator\Report policies" /f' /RunAs 4 /WaitProcess 1 /Run
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f' /RunAs 4 /WaitProcess 1 /Run
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /f' /RunAs 4 /WaitProcess 1 /Run
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn "Microsoft\Windows\UpdateOrchestrator\Schedule Work" /f' /RunAs 4 /WaitProcess 1 /Run
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn Microsoft\Windows\UpdateOrchestrator\UpdateModelTask /f' /RunAs 4 /WaitProcess 1 /Run
%programdata%\PostClear\AdvancedRun.exe /EXEFilename %windir%\System32\schtasks.exe /CommandLine '/delete /tn Microsoft\Windows\UpdateOrchestrator\USO_UxBroker /f' /RunAs 4 /WaitProcess 1 /Run
TIMEOUT /T 1 /NOBREAK >nul
title Applying GroupPolicy
%programdata%\PostClear\LGPO.exe /m %programdata%\PostClear\GPm.pol
TIMEOUT /T 1 /NOBREAK >nul
%programdata%\PostClear\LGPO.exe /u %programdata%\PostClear\GPu.pol
TIMEOUT /T 1 /NOBREAK >nul
title Updating GroupPolicy
gpupdate /force
title Stopping SuperFetch
net stop SysMain
TIMEOUT /T 1 /NOBREAK >nul
title Deleting SuperFetch cache
for /f "tokens=*" %%i in ('dir /b /s %windir%\Prefetch\*.pf') do (
	del /f /q "%%~i"
)
title Stopping WindowsSearch
net stop WSearch
TIMEOUT /T 1 /NOBREAK >nul
title Deleting WindowsSearch cache
rd /s /q %programdata%\Microsoft\Search
title Disable ReservedStorage
Dism /Online /Set-ReservedStorageState /State:Disabled
title Copy Edge icons
move %programdata%\PostClear\Assets %windir%\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\Assets
title Finality PostClearM part
rd /s /q "%programdata%\PostClear\Classic Shell"
del /f /q %programdata%\PostClear\AdvancedRun.exe
del /f /q %programdata%\PostClear\ClassicShell.msi
del /f /q %programdata%\PostClear\GPm.pol
del /f /q %programdata%\PostClear\GPu.pol
del /f /q %programdata%\PostClear\LGPO.exe
del /f /q %programdata%\PostClear\PostClearM.reg
:PostClearU
title Deleting Edge shortcut
del /f /q "%userprofile%\Desktop\Microsoft Edge.lnk"
title Applying PostClearU.reg
%windir%\regedit.exe /S %programdata%\PostClear\PostClearU.reg
TIMEOUT /T 1 /NOBREAK >nul
title Rebooting...
SHUTDOWN -r -t 3
TIMEOUT /T 3 /NOBREAK >nul
