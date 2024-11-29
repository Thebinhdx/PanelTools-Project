@echo off
set version=2.5.3_beta3

set "params=%*"
cd /d "%~dp0" && (
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)


:: Delete Old Error Log File
del %temp%\errorv2.log
:menulite
color 07
cls
cls
title Panel V%version%
echo Panel Build by Thebinhdxmod V%version%
echo Welcome to Panel!
echo Enter 'help' For Get Commands
echo:
:menu
set devmode=false
set /p options="Panel\%username%> "

if "%options%"=="activate /product" goto activate
if "%options%"=="clear" cls & goto menu
if "%options%"=="cls" cls & goto menu
if "%options%"=="exit" goto iexit
if "%options%"=="tweaks" goto tweaks1
if "%options%"=="uninapp" goto uninapp
if "%options%"=="powershell" start powershell & goto menu
if "%options%"=="cmd" start cmd & goto menu
if "%options%"=="devmode" goto devmode1
if "%options%"=="downapp" goto next
if "%options%"=="help" goto help
if "%options%"=="about" goto about

echo Wrong Commands Or Type Incorrect!
goto menu
:devmode1
cls
echo WARNING! THIS IS MODE HAVE MANY BUG.
:devmode
color 02
set devmode=true
set /p optionsdev="Developer_Mode\Administrators> "

if "%optionsdev%"=="activate /product" goto activate
if "%optionsdev%"=="clear" cls & goto menu
if "%optionsdev%"=="cls" cls & goto menu
if "%optionsdev%"=="exit" goto iexit
if "%optionsdev%"=="tweaks" goto tweaks1
if "%optionsdev%"=="uninapp" goto uninapp
if "%optionsdev%"=="powershell" start powershell & goto menu
if "%optionsdev%"=="cmd" start cmd & goto menu
if "%optionsdev%"=="downapp" goto next
if "%optionsdev%"=="devmode /off" goto menulite
if "%optionsdev%"=="help" goto help1
if "%optionsdev%"=="about" goto about

echo Wrong Commands Or Type Incorrect!
goto devmode
:backmenuordevmode
if %devmode%==true goto devmode1
if %devmode%==false goto menu
goto backmenuordevmode
:help1
echo:
echo Commands:
echo:
echo cls/clear                Clear Panel.
echo activate /product        Activate Products
echo help                     Help For Get Commands.
echo downapp                  Downloads Apps With Winget Commands.
echo uninapp                  Open Uninstall Tools.
echo tweaks                   Tweaks PC.
echo cmd                      Open Command Prompt.
echo powershell               Open Powershell.
echo devmode /off             Sign Out Developer Mode
echo exit                     Closing Panel.
echo about                    About OS, Batch File.
echo:
goto devmode
:help
echo:
echo Commands:
echo:
echo cls/clear                Clear Panel.
echo activate /product        Activate Products
echo help                     Help For Get Commands.
echo downapp                  Downloads Apps With Winget Commands.
echo uninapp                  Open Uninstall Tools.
echo tweaks                   Tweaks PC.
echo devmode                  Open Developer Mode.
echo cmd                      Open Command Prompt.
echo powershell               Open Powershell.
echo exit                     Closing Panel.
echo about                    About OS, Batch File.
echo:
goto menu

:about
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
echo Batch File: TestPanel Made By Thebinhdxmod
echo Version Batch File: %version%.
goto backmenuordevmode

:uninapp
cd /d %~dp0
start Extensions\UninstallTool.exe
goto backmenuordevmode

:next
cls
set versionnetwork=1.2
title Checking Internet Connection Requirements! %versionnetwork%
echo Checking Internet Connection...
Ping www.google.nl -n 1 -w 1000
set network=%errorlevel%

if %network%==1 goto stop
if %network%==0 goto next1

:stop
cls
echo Can't Connect With Internet. Please Try Again!
echo:
echo Press Any Key To Go Back Panel...
pause >nul
goto backmenuordevmode

:next1
cls
echo:
echo =============================================================================
echo          WARNING! THIS IS DOWNLOADS APPS WILL USING WINGET COMMANDS
echo             IF THIS PC RUN WINDOWS 10 OR FIRST LOGON NEW WINDOWS 
echo                      YOU NEED TO RUNNING THIS PACK FIRST
echo            AND THIS COMMANDS ONLY SUPPORT WINDOWS 10 1709 AND LATER.
echo:
echo                      [1] Install Package, Repair
echo:
echo                          [2] Already Install
echo:
echo                                [0] Exit
echo:
echo =============================================================================
echo:
set /p options1="Enter Your Options: "

if "%options1%"=="0" goto backmenuordevmode
if "%options1%"=="2" goto next2
if "%options1%"=="1" goto install
goto next1
:install
cls
echo Installing Packages... (You Need Wait Some Minutes After Install)
timeout /nobreak /t 3 >nul
powershell "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
cls
echo Fixed Problem Installing Manually...
echo Link Problem Report:https://github.com/microsoft/winget-cli/discussions/3258#discussioncomment-5939793
timeout /nobreak /t 3 >nul
powershell "Add-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix"
cls
echo Completed! You Can Use Now.
echo:
echo Press Any Key To Go Back...
pause >nul
goto next1
:next2
cls
title Downloads App Menu!
mode 168,60
echo:
echo                                                                 -Winget Install Command-
echo:
echo ========================================================================================================================================================================
echo:
echo        -Browsers-            -Communications-            -Development-            -Document-                  -Games-            -MS Tools-
echo:
echo        [1] Opera               [11] Discord               [16] Clink             [24] Foxit PDF Editor       [27] Steam        [28] Autoruns
echo:
echo        [2] Opera GX            [12] Zoom                  [17] Git               [25] Foxit PDF Reader                         [29] .NET Desktop Runtime
echo:
echo        [3] Brave               [13] Zalo                  [18] Oh My Posh        [26] Notepad++                                [30] OneDrive
echo:
echo        [4] Chrome              [14] Skype                 [19] NodeJS                                                          [31] Visual C++
echo:
echo        [5] Firefox             [15] Teams                 [20] Python 3.13
echo:
echo        [6] Cent                                           [21] Unity Game Engine
echo:
echo        [7] Chromium                                       [22] Visual Studio 2022
echo:
echo        [8] Edge                                           [23] VS Code
echo:
echo        [9] Tor
echo:
echo       [10] Supermium
echo:
echo       -Record Tools-                                                                  -Utilities-
echo:
echo       [32] OBS Studio       [34] 7-Zip               [44] Malwarebytes            [0] Exit
echo:
echo       [33] Bandicam         [35] AnyDesk             [45] MSI Afterburner
echo:
echo                             [36] CPU-Z               [46] Nilesoft Shell
echo:
echo                             [37] Crystal Disk        [47] OPAutoClicker                                            Coming Soon...
echo:
echo                             [38] File-Converter      [48] Rainmeter
echo:
echo                             [39] GPU-Z               [49] Oracle VirtualBox
echo:
echo                             [40] HWiNFO              [50] WinRAR
echo:
echo                             [41] HWMonitor           [51] Office 365
echo:
echo                             [42] JDownloader         [52] Java
echo:
echo                             [43] Lively Wallpaper    [53] Adoptium
echo:
echo ========================================================================================================================================================================
echo:
set /p options2="Enter Your Options: "

if "%options2%"=="0" goto backmenuordevmode
if "%options2%"=="53" goto adoptium
if "%options2%"=="52" goto java
if "%options2%"=="51" goto office
if "%options2%"=="50" goto rar
if "%options2%"=="49" goto virtualbox
if "%options2%"=="48" goto rainmeter
if "%options2%"=="47" goto autoclick
if "%options2%"=="46" goto shell
if "%options2%"=="45" goto msi
if "%options2%"=="44" goto malwarebytes
if "%options2%"=="43" goto livewallpaper
if "%options2%"=="42" goto jdownload
if "%options2%"=="41" goto hwmonitor
if "%options2%"=="40" goto hwinfo
if "%options2%"=="39" goto gpuz
if "%options2%"=="38" goto fileconv
if "%options2%"=="37" goto crydisk
if "%options2%"=="36" goto cpuz
if "%options2%"=="35" goto anydesk
if "%options2%"=="34" goto 7z
if "%options2%"=="33" goto bandicam
if "%options2%"=="32" goto obs
if "%options2%"=="31" goto visualc
if "%options2%"=="30" goto onedrive
if "%options2%"=="29" goto net
if "%options2%"=="28" goto autorun
if "%options2%"=="27" goto steam
if "%options2%"=="26" goto notepad
if "%options2%"=="25" goto pdfr
if "%options2%"=="24" goto pdfe
if "%options2%"=="23" goto vscode
if "%options2%"=="22" goto vs22
if "%options2%"=="21" goto unity
if "%options2%"=="20" goto python
if "%options2%"=="19" goto nodejs
if "%options2%"=="18" goto ohmyposh
if "%options2%"=="17" goto git
if "%options2%"=="16" goto clink
if "%options2%"=="15" goto team
if "%options2%"=="14" goto skype
if "%options2%"=="13" goto zalo
if "%options2%"=="12" goto zoom
if "%options2%"=="11" goto discord
if "%options2%"=="10" goto supermium
if "%options2%"=="9" goto tor
if "%options2%"=="8" goto edge
if "%options2%"=="7" goto chromium
if "%options2%"=="6" goto cent
if "%options2%"=="5" goto firefox
if "%options2%"=="4" goto chrome
if "%options2%"=="3" goto brave
if "%options2%"=="2" goto operagx
if "%options2%"=="1" goto opera
goto next2

:java
cls
winget install Oracle.JavaRuntimeEnvironment
goto next2
:office
cls
winget install Microsoft.Office
goto next2
:opera
cls
winget install Opera.Opera
goto next2
:operagx
cls
winget install Opera.OperaGX
goto next2
:brave
cls
winget install Brave.Brave
goto next2
:chrome
cls
winget install Google.Chrome
goto next2
:firefox
cls
winget install Mozilla.Firefox
goto next2
:cent
cls
winget install CentStudio.CentBrowser
goto next2
:chromium
cls
winget install ungoogled-chromium
goto next2
:edge
cls
winget install Microsoft.Edge
goto next2
:tor
cls
winget install TorProject.TorBrowser
goto next2
:supermium
cls
winget install win32ss.Supermium
goto next2
:discord
cls
winget install Discord.Discord
goto next2
:zoom
cls
winget install Zoom.Zoom
goto next2
:zalo
cls
winget install VNGCorp.Zalo
goto next2
:skype
cls
winget install Microsoft.Skype
goto next2
:team
cls
winget install Microsoft.Teams
goto next2
:clink
cls
winget install chrisant996.Clink
goto next2
:git
cls
winget install git.git
goto next2
:ohmyposh
cls
winget install JanDeDobbeleer.OhMyPosh
goto next2
:nodejs
cls
winget install OpenJS.NodeJS
goto next2
:python
cls
winget install Python.Python.3.13
goto next2
:unity
cls
winget install Unity.Unity.2020
goto next2
:vs22
cls
winget install Microsoft.VisualStudio.2022.Community
goto next2
:vscode
cls
winget install Microsoft.VisualStudioCode
goto next2
:pdfe
cls
winget install Foxit.PhantomPDF
goto next2
:pdfr
cls
winget install Foxit.FoxitReader
goto next2
:notepad
cls
winget install Notepad++.Notepad++
goto next2
:steam
cls
winget install Valve.Steam
goto next2
:autorun
cls
winget install Microsoft.Sysinternals.Autoruns
goto next2
:net
cls
echo:
echo =================================================================
echo                      -NET Desktop Runtime-
echo:
echo                   [1] NET Desktop Runtime 3.1
echo:
echo                   [2] NET Desktop Runtime 5.0
echo:
echo                   [3] NET Desktop Runtime 6.0
echo:
echo                   [4] NET Desktop Runtime 7.0
echo:
echo                   [5] NET Desktop Runtime 8.0
echo:
echo                   [6] NET Desktop Runtime 9.0
echo:
echo                 [7] NET Desktop Runtime Preview
echo:
echo                          [0] Go Back
echo =================================================================
echo:
set /p options3="Enter Your Options: "

if "%options3%"=="0" goto next2
if "%options3%"=="7" goto netpre
if "%options3%"=="6" goto net9
if "%options3%"=="5" goto net8
if "%options3%"=="4" goto net7
if "%options3%"=="3" goto net6
if "%options3%"=="2" goto net5
if "%options3%"=="1" goto net31

goto net

:net31
cls
winget install Microsoft.DotNet.DesktopRuntime.3_1
goto net
:net5
cls
winget install Microsoft.DotNet.DesktopRuntime.5
goto net
:net6
cls
winget install Microsoft.DotNet.DesktopRuntime.6
goto net
:net7
cls
winget install Microsoft.DotNet.DesktopRuntime.7
goto net
:net8
cls
winget install Microsoft.DotNet.DesktopRuntime.8
goto net
:net9
cls
winget install Microsoft.DotNet.DesktopRuntime.9
goto net
:netpre
cls
winget install Microsoft.DotNet.DesktopRuntime.Preview
goto net

:onedrive
cls
winget install Microsoft.OneDrive
goto next2
:visualc
cls
echo:
echo =================================================================
echo                       -Visual C++ Redist-
echo:
echo                      [1] Visual C++ 2005
echo:
echo                      [2] Visual C++ 2008
echo:
echo                      [3] Visual C++ 2010
echo:
echo                      [4] Visual C++ 2012
echo:
echo                      [5] Visual C++ 2013
echo:
echo                     [6] Visual C++ 2015-2022
echo:
echo                           [0] Go Back
echo =================================================================
echo:
set /p options4="Enter Your Options: "
if "%options4%"=="0" goto next2
if "%options4%"=="6" goto 20152022
if "%options4%"=="5" goto 2013
if "%options4%"=="4" goto 2012
if "%options4%"=="3" goto 2010
if "%options4%"=="2" goto 2008
if "%options4%"=="1" goto 2005
goto visualc
:2005
cls
winget install Microsoft.VCRedist.2005.x64
goto visualc
:2008
cls
winget install Microsoft.VCRedist.2008.x64
goto visualc
:2010
cls
winget install Microsoft.VCRedist.2010.x64
goto visualc
:2012
cls
winget install Microsoft.VCRedist.2012.x64
goto visualc
:2013
cls
winget install Microsoft.VCRedist.2013.x64
goto visualc
:20152022
cls
winget install Microsoft.VCRedist.2015+.x64
goto visualc

:obs
cls
winget install OBSProject.OBSStudio
goto next2
:bandicam
cls
winget install BandicamCompany.Bandicam
goto next2
:7z
cls
winget install 7zip.7zip
goto next2
:anydesk
cls
winget install AnyDeskSoftwareGmbH.AnyDesk
goto next2
:cpuz
cls
winget install CPUID.CPU-Z
goto next2
:crydisk
cls
echo:
echo =================================================================
echo                         -Crystal Disk-
echo:
echo                      [1] Crystal Disk Mark
echo:
echo                      [2] Crystal Disk Info
echo:
echo                           [0] Go Back
echo =================================================================
echo:
set /p options5="Enter Your Options: "

if "%options5%"=="0" goto next2
if "%options5%"=="2" goto mark
if "%options5%"=="1" goto info
goto crydisk
:info
cls
winget install CrystalDewWorld.CrystalDiskInfo
goto crydisk
:mark
cls
winget install CrystalDewWorld.CrystalDiskMark
goto crydisk

:fileconv
cls
winget install AdrienAllard.FileConverter
goto next2
:gpuz
cls
winget install TechPowerUp.GPU-Z
goto next2
:hwinfo
cls
winget install REALiX.HWiNFO
goto next2
:hwmonitor
cls
winget install CPUID.HWMonitor
goto next2
:jdownload
cls
winget install AppWork.JDownloader
goto next2
:livewallpaper
cls
winget install rocksdanister.LivelyWallpaper
goto next2
:malwarebytes
cls
winget install Malwarebytes.Malwarebytes
goto next2
:msi
cls
winget install Guru3D.Afterburner
goto next2
:shell
cls
winget install nilesoft.shell
goto next2
:autoclick
cls
winget install OPAutoClicker.OpAutoClicker
goto next2
:rainmeter
cls
winget install Rainmeter.Rainmeter
goto next2
:virtualbox
cls
winget install Oracle.VirtualBox
goto next2
:rar
cls
winget install RARLab.WinRAR
goto next2

:tweaks1
cls
echo:
echo =============================================================================
echo           WARNING! BEFORE TWEAKS PC YOU NEED TO CREATE RESTORE POINT
echo                              TO SAVE YOUR PC!
echo:
echo           [1] Create Restore Point (Recommended/Only Create 1 Times)
echo:
echo                    [2] Already Create Or ACCEPT RISK
echo:
echo                                  [0] Exit
echo:
echo =============================================================================
echo:
set /p options7="Enter Your Options: "

if "%options7%"=="0" goto backmenuordevmode
if "%options7%"=="2" goto tweaks
if "%options7%"=="1" goto crepoint
goto tweaks1

:crepoint
cls
echo Creating System Restore... (If Restore Point Not Create So Doing This Manually)
powershell ""Enable-ComputerRestore -Drive "C:\"""
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Nothing", 100, 7
goto tweaks1

:tweaks
cls
title Tweaks PC!
echo:
echo:
echo                        ======================================================
echo                                              -Tweaks-
echo:
echo      [1] Delete Temp Files               [9] Disable Location Tracking                     [0] Exit
echo:
echo      [2] Disable ConsumerFeatures        [10] Disable Storage Sense
echo:
echo      [3] Disable Activity History        [11] Disable Wifi Sense
echo:
echo      [4] Disable Telemetry               [12] Enable End-Task with Right-Click
echo:
echo      [5] Disable GameDVR                 [13] Run Disk Cleanup [Manual]
echo:
echo      [6] Disable Hibernation             [14] Disable Windows 7 Telemetry
echo:
echo      [7] Disable Homegroup               [15] Set Hibernation as default
echo:
echo      [8] Prefer IPv4 Over IPv6           [16] Debloat Edge [Wifi Only]
echo                        =======================================================
echo                                               -Note-
echo:
echo                             Something Tweaks will need reboot or sign out.
echo                        =======================================================
echo:
set /p options6="Enter Your Options: "

if "%options6%"=="0" goto backmenuordevmode
if "%options6%"=="soon" goto advanced
if "%options6%"=="16" goto dedge
if "%options6%"=="15" goto shad
if "%options6%"=="14" goto d7t
if "%options6%"=="13" start cleanmgr & goto tweaks
if "%options6%"=="12" goto et
if "%options6%"=="11" goto dws
if "%options6%"=="10" goto dss
if "%options6%"=="9" goto dlt
if "%options6%"=="8" goto p4o6
if "%options6%"=="7" goto dhg
if "%options6%"=="6" goto dh
if "%options6%"=="5" goto dg
if "%options6%"=="4" goto dt
if "%options6%"=="3" goto dah
if "%options6%"=="2" goto dcf
if "%options6%"=="1" goto dtf
goto tweaks
:dtf
cls
del /q/f/s %TEMP%\*
goto tweaks
:dcf
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1
goto tweaks
:dah
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /f /v PublishUserActivities /t REG_DWORD /d 0
goto tweaks
:dt
cls
sc config DiagTrack start= disabled
sc config dmwappushservice start= disabled
goto tweaks
:dg
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f /v AllowgameDVR /t REG_DWORD /d 0
goto tweaks
:dh
cls
Powercfg.exe /hibernate off
goto tweaks
:dhg
cls
reg add "HKEY_LOCAL_MACHINE\Software\Classes\clsID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}" /f /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0
goto tweaks
:p4o6
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /f /v DisabledComponents /t REG_DWORD /d 20
goto tweaks
:dlt
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /f /v Value /t REG_SZ /d Deny
goto tweaks
:dss
cls
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /f /v 01 /t REG_DWORD /d 0
goto tweaks
:dws
cls
echo This Tweaks need name your wifi! (Required And Correctly)
set /p wifi="Enter Here: "
netsh interface set interface name="%wifi%" admin=DISABLED
goto tweaks
:et
cls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarEndTask /t REG_DWORD /d 1
goto tweaks
:shad
cls
Powercfg.exe /hibernate on
goto tweaks
:dedge
cls
powershell "iex(irm https://fixedge.today)"
goto tweaks
:advanced
cls
if %devmode%==true goto advanced2

echo DEVMODE Only! You Need Active First.
echo Error Code: DEV_MODE_ONLY
echo Press Any Key To Go Back...
pause >nul
goto tweaks
:advanced2
powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter Dev Key To Continue:', 'Developer Keys', 'Enter Key Here')}" > %TEMP%\key.tmp
set /p key=<%TEMP%\key.tmp
if "%key%"=="B1Zh3nCr7T3d" goto advanced1
echo Wrong Key! Only Developer Key Can Continue.
echo Error Code: KEY_DEV_ONLY
echo Press Any Key To Go Back...
pause >nul
goto tweaks
:advanced1
cls
echo ==================================================
echo:
echo              TESTING PURPOSES ONLY!
echo          ADVANCED SETTINGS (V0.1_beta2)
echo:
echo ==================================================
echo:
echo Advanced
echo NOT RECOMMENDED TO DO THIS!
echo:
echo    1.Delete MS Store [Not Recommended]
echo:
echo    2.NONE!
echo:
echo    3.NONE!
echo         [IN BUILD]
echo:
echo Press Any Key To Go Back...
pause >nul
goto tweaks

:activate
cls
echo ==========================================================
echo                        -WARNING!-
echo             THIS ACTIVATE PRODUCTS IS ILLEGAL
echo          NOT USING THIS TO ENTERPRISE AND BUSINESS
echo           IF YOU WANT TO GET THE LEGAL PRODUCTS
echo            YOU NEED TO BUY THIS FROM MICROSOFT!
echo             (ONLY WORK ON WINDOWS 8 And Later)
echo ==========================================================
echo:
echo         [1] Accept                  [2] Decline
echo      [NOT RECOMMNEDED]
echo:
set /p warning="Enter Your Options: "

if "%warning%"=="1" goto activate1check
if "%warning%"=="2" goto backmenuordevmode

goto activate

:activate1check
cls
set versionnetwork=1.2
title Checking Internet Connection Requirements! %versionnetwork%
echo Checking Internet Connection...
Ping www.google.nl -n 1 -w 1000
set network=%errorlevel%

if %network%==1 goto stop1
if %network%==0 goto activate1

:stop1
cls
echo Can't Connect With Internet. Please Try Again!
echo:
echo Press Any Key To Go Back Panel...
pause >nul
goto backmenuordevmode

:activate1
cls
title Activation Products
echo Activation Script (Project Massgrave, Offical Website:https://massgrave.dev/credits)
powershell "irm https://get.activated.win | iex"
goto backmenuordevmode

:iexit
cls
taskkill /f /im timeout.exe
exit