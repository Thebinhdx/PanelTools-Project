@echo off
:: Define variables
set "update_url="
set "temp_file=%TEMP%\update_script.bat"

:: Notify user
echo Checking for updates...

:: Download the updated script
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%update_url%', '%temp_file%')"

:: Check if the download was successful
if exist "%temp_file%" (
    echo Update downloaded successfully.
    
    :: Replace the current script with the updated one
    copy /Y "%temp_file%" "%~f0" >nul
    echo Script updated. Restarting...
    
    :: Restart the script
    start "" "%~f0"
    exit
) else (
    echo Failed to download the update. Continuing with the current version.
    timeout /t 3 /nobreak >nul
)

:: Main script logic

set link=https://github.com/thebinhdx/Paneltools-Project
set version=3.8 Release Candidate 2
set sversion=3.7431.5_RC
title Checking Administrator Requirements!

echo Checking Administrator Requirements...

net session >nul 2>&1
if %errorlevel% == 0 (
  goto continue
) else (
  cls
  echo Administrator privileges required.  Please run this script as administrator.
  pause
  exit /b 1
)

::Settings
:continue
cls
title PanelTools %version%
echo Checking Extensions...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\Extensions\UninstallTool.exe" (
    goto menu
) ELSE (
    cls
    echo Error! Not Found Extensions.
    echo:
    echo:
    echo Troubleshoot Here: %link%
    echo Error Code:1
    echo Press Any Key To Exit...
    pause >nul
    exit
)

:menu
mode 102,30
color 07
cls
cls
title PanelTools
echo:
echo                                           --Paneltools--
echo:
echo ==================MENU================== =============-NOTE-============= =========-Credits-=========
echo:
echo   [1] Download Apps and Install Apps       [*]: third party software or        Thebinhdx [Owner]
echo:                                         other software not created by me                   
echo          [2] Uninstall App [*]
echo:
echo            [3] Tweaks [Beta]             =============-About-============ ========-Donation-=========
echo:
echo    [4] Activate Windows and Office [*]   -Name: PanelTools                     [Coming Soon...]
echo:                                         -Version: %version%
echo                [0] Exit                           [%sversion%]
echo:
echo ======================================== ================================ ===========================
echo:
set /p menu="Enter Your Options: "

if "%menu%"=="0" exit
if "%menu%"=="1" goto next
if "%menu%"=="2" goto uninapp
if "%menu%"=="3" goto tweaks1
if "%menu%"=="4" goto activate

goto menu

goto error

:uninapp
cd /d %~dp0
start Extensions\UninstallTool.exe
goto menu

goto error

:next
cls
set versionnetwork=1.2
title Checking Internet Connection Requirements! %versionnetwork%
echo Checking Internet Connection...
Ping www.google.nl -n 1 -w 1000
set network=%errorlevel%

if %network%==1 goto stop
if %network%==0 goto next2_1

goto error

:stop
cls
echo Can't Connect With Internet. Please Try Again!
echo:
echo Press Any Key To Go Back Panel...
pause >nul
goto menu

goto error

::=================================================================
:: Coming Soon...
:next1
cls
mode 45,30
echo:
echo         -Choose Way To Install Apps-
echo:
echo ===========================================
echo:
echo               [1] Use Winget
echo:
echo                 [2] Soon...
echo:
echo                 [3] Soon...
echo:
echo                  [0] Exit
echo:
echo ===========================================
echo:
set /p opdown="Choose Your Options: "

if "%opdown%"=="0" goto menu
if "%opdown%"=="1" goto next2_1
if "%opdown%"=="2" goto next1
if "%opdown%"=="3" goto next1

goto next1

goto error

::==================================================================

:next2_1
cls
mode 80,30
echo:
echo                                 --WARNING!--
echo:
echo =============================================================================
echo        -If you are in second situation, you should choose the first one-
echo:
echo       1. This way will use winget [Windows Package Manager] to download
echo          but to use this need windows 10 v1709 and later to use this way
echo       2.     If you have just downloaded the operating system and 
echo                     are logging in for the first time or 
echo                 have never downloaded [Windows Package Manager]
echo       3. If you install this way but is so slow you need to download
echo                                  manually
echo:
echo                    [1] Install Package, Repair, Update
echo:
echo                            [2] Already Install
echo:
echo                                  [0] Exit
echo:
echo =============================================================================
echo:
set /p options1="Enter Your Options: "

if "%options1%"=="0" goto menu
if "%options1%"=="2" goto next2
if "%options1%"=="1" goto install
goto next1

goto error
:install
cls
echo:
echo -Don't Close this windows-
echo:
echo Installing Packages... (You Need Wait Some Minutes After Install)
timeout /nobreak /t 3 >nul
powershell "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
cls
echo:
echo -Don't Close this windows-
echo:
echo Fix Problem Install Manually...
echo Link Problem Report:https://github.com/microsoft/winget-cli/discussions/3258#discussioncomment-5939793
timeout /nobreak /t 3 >nul
powershell "Add-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix"
cls
echo:
echo -Don't Close this windows-
echo:
echo Completed! You Can Use Now.
echo:
echo Press Any Key To Go Back...
pause >nul
goto next1

goto error

:next2
cls
mode 168,60
echo:
echo                                                                     -Winget Install-
echo                                                                      [By Microsoft]
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
echo       [32] OBS Studio       [34] 7-Zip               [44] Malwarebytes            [54] Driver Booster                             [!WARNING!]
echo:
echo       [33] Bandicam         [35] AnyDesk             [45] MSI Afterburner         [55] Capcut                     Winget only support some applications not all
echo:
echo                             [36] CPU-Z               [46] Nilesoft Shell          [56] IObit Uninstaller
echo:
echo                             [37] Crystal Disk        [47] OPAutoClicker           [57] Geforce Now
echo:
echo                             [38] File-Converter      [48] Rainmeter               [58] CCleaner
echo:
echo                             [39] GPU-Z               [49] Oracle VirtualBox       [59] IObit Unlocker
echo:
echo                             [40] HWiNFO              [50] WinRAR                  [60] Custom Install App
echo:
echo                             [41] HWMonitor           [51] Office 365              [61] Update All App
echo:
echo                             [42] JDownloader         [52] Java                    [0] Back
echo:
echo                             [43] Lively Wallpaper    [53] Adoptium
echo:
echo ========================================================================================================================================================================
echo:
set /p options2="Enter Your Options: "

if "%options2%"=="0" goto next2_1
if "%options2%"=="61" goto update
if "%options2%"=="60" goto custom
if "%options2%"=="59" goto iobitunlock
if "%options2%"=="58" goto ccleaner
if "%options2%"=="57" goto nvidia
if "%options2%"=="56" goto iobitunin
if "%options2%"=="55" goto capcut
if "%options2%"=="54" goto drvboot
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

goto error

:update
cls
echo Waiting... Checking Applications
timeout /t 3 /nobreak >nul
winget update --all
goto next2

goto error

:custom
cls
echo WARNING! THIS IS CUSTOM INSTALL. PLEASE ENTER YOUR CORRECTLY APP NAME AND YOUR APP YOU WANT INSTALL HAVE SUPPORT THIS INSTALL METHOD!
echo:
echo Commands:
echo search                            For Searching App Or Commands is available.
echo install                           Install App.
echo Example: From mssstore: 9NF8XXXXWMLT [ID NVIDIA Control Panel] [X for hide]
echo          From 3rd Program: Nvidia.CUDA [NVIDIA CUDA Toolkit]
echo back                              Exit This Custom Method.
echo:
:custom1
set /p custom="Commands> "

if "%custom%"=="search" goto search
if "%custom%"=="install" goto installcustom
if "%custom%"=="back" goto next2

goto custom

goto error

:search
set /p search="Enter Your Name Apps: "

winget search "%search%"
echo Enter Any Key To Go Back...
pause >nul
goto custom1

goto error

:installcustom
set /p installc="Enter Your ID Apps: "

winget install "%installc%"
echo Press Any Key To Go Back...
pause >nul
goto custom1

goto error

:iobitunlock
cls
winget install IObit.IObitUnlocker
goto next2

goto error
:ccleaner
cls
winget install Priform.CCleaner
goto next2

goto error

:nvinow
cls
winget install Nvidia.GeForceNow
goto next2

goto error

:iobitunin
cls
winget install IObit.Uninstaller
goto next2

goto error
:capcut
cls
winget install ByteDance.CapCut
goto next2

goto error
:drvboot
cls
winget install IObit.DriverBooster
goto next2

goto error
:java
cls
winget install Oracle.JavaRuntimeEnvironment
goto next2

goto error
:office
cls
winget install Microsoft.Office
goto next2

goto error
:opera
cls
winget install Opera.Opera
goto next2

goto error
:operagx
cls
winget install Opera.OperaGX
goto next2

goto error
:brave
cls
winget install Brave.Brave
goto next2

goto error
:chrome
cls
winget install Google.Chrome
goto next2

goto error
:firefox
cls
winget install Mozilla.Firefox
goto next2
:cent
cls
winget install CentStudio.CentBrowser
goto next2

goto error
:chromium
cls
winget install ungoogled-chromium
goto next2

goto error
:edge
cls
winget install Microsoft.Edge
goto next2

goto error
:tor
cls
winget install TorProject.TorBrowser
goto next2

goto error
:supermium
cls
winget install win32ss.Supermium
goto next2

goto error
:discord
cls
winget install Discord.Discord
goto next2

goto error
:zoom
cls
winget install Zoom.Zoom
goto next2

goto error
:zalo
cls
winget install VNGCorp.Zalo
goto next2

goto error
:skype
cls
winget install Microsoft.Skype
goto next2

goto error
:team
cls
winget install Microsoft.Teams
goto next2

goto error
:clink
cls
winget install chrisant996.Clink
goto next2

goto error
:git
cls
winget install git.git
goto next2

goto error
:ohmyposh
cls
winget install JanDeDobbeleer.OhMyPosh
goto next2

goto error
:nodejs
cls
winget install OpenJS.NodeJS
goto next2

goto error
:python
cls
winget install Python.Python.3.13
goto next2

goto error
:unity
cls
winget install Unity.Unity.2020
goto next2

goto error
:vs22
cls
winget install Microsoft.VisualStudio.2022.Community
goto next2

goto error
:vscode
cls
winget install Microsoft.VisualStudioCode
goto next2

goto error
:pdfe
cls
winget install Foxit.PhantomPDF
goto next2

goto error
:pdfr
cls
winget install Foxit.FoxitReader
goto next2

goto error
:notepad
cls
winget install Notepad++.Notepad++
goto next2

goto error
:steam
cls
winget install Valve.Steam
goto next2

goto error
:autorun
cls
winget install Microsoft.Sysinternals.Autoruns
goto next2

goto error
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

goto error

:net31
cls
winget install Microsoft.DotNet.DesktopRuntime.3_1
goto net

goto error
:net5
cls
winget install Microsoft.DotNet.DesktopRuntime.5
goto net

goto error
:net6
cls
winget install Microsoft.DotNet.DesktopRuntime.6
goto net

goto error
:net7
cls
winget install Microsoft.DotNet.DesktopRuntime.7
goto net

goto error
:net8
cls
winget install Microsoft.DotNet.DesktopRuntime.8
goto net

goto error
:net9
cls
winget install Microsoft.DotNet.DesktopRuntime.9
goto net

goto error
:netpre
cls
winget install Microsoft.DotNet.DesktopRuntime.Preview
goto net

goto error

:onedrive
cls
winget install Microsoft.OneDrive
goto next2

goto error
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

goto error
:2005
cls
winget install Microsoft.VCRedist.2005.x64
goto visualc

goto error
:2008
cls
winget install Microsoft.VCRedist.2008.x64
goto visualc

goto error
:2010
cls
winget install Microsoft.VCRedist.2010.x64
goto visualc

goto error
:2012
cls
winget install Microsoft.VCRedist.2012.x64
goto visualc

goto error
:2013
cls
winget install Microsoft.VCRedist.2013.x64
goto visualc

goto error
:20152022
cls
winget install Microsoft.VCRedist.2015+.x64
goto visualc

goto error

:obs
cls
winget install OBSProject.OBSStudio
goto next2

goto error
:bandicam
cls
winget install BandicamCompany.Bandicam
goto next2

goto error
:7z
cls
winget install 7zip.7zip
goto next2

goto error
:anydesk
cls
winget install AnyDeskSoftwareGmbH.AnyDesk
goto next2

goto error
:cpuz
cls
winget install CPUID.CPU-Z
goto next2

goto error
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

goto error
:info
cls
winget install CrystalDewWorld.CrystalDiskInfo
goto crydisk

goto error
:mark
cls
winget install CrystalDewWorld.CrystalDiskMark
goto crydisk

goto error

:fileconv
cls
winget install AdrienAllard.FileConverter
goto next2

goto error
:gpuz
cls
winget install TechPowerUp.GPU-Z
goto next2

goto error
:hwinfo
cls
winget install REALiX.HWiNFO
goto next2

goto error
:hwmonitor
cls
winget install CPUID.HWMonitor
goto next2

goto error
:jdownload
cls
winget install AppWork.JDownloader
goto next2

goto error
:livewallpaper
cls
winget install rocksdanister.LivelyWallpaper
goto next2

goto error
:malwarebytes
cls
winget install Malwarebytes.Malwarebytes
goto next2

goto error
:msi
cls
winget install Guru3D.Afterburner
goto next2

goto error
:shell
cls
winget install nilesoft.shell
goto next2

goto error
:autoclick
cls
winget install OPAutoClicker.OpAutoClicker
goto next2

goto error
:rainmeter
cls
winget install Rainmeter.Rainmeter
goto next2

goto error
:virtualbox
cls
winget install Oracle.VirtualBox
goto next2

goto error
:rar
cls
winget install RARLab.WinRAR
goto next2

goto error

:tweaks1
cls
mode 78,20
echo:
echo                                 --WARNING!--
echo:
echo =============================================================================
echo               BEFORE TWEAKS PC YOU NEED TO CREATE RESTORE POINT
echo                              TO SAVE YOUR PC!
echo:
echo                   [1] Create Restore Point (Recommended)
echo:
echo                    [2] Already Create Or ACCEPT RISK
echo:
echo                                  [0] Exit
echo:
echo =============================================================================
echo:
set /p options7="Enter Your Options: "

if "%options7%"=="0" goto menu
if "%options7%"=="2" goto tweaks
if "%options7%"=="1" goto crepoint
goto tweaks1

goto error

:crepoint
cls
echo Creating System Restore... (If Restore Point Not Create So Doing This Manually)
powershell ""Enable-ComputerRestore -Drive "C:\"""
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Nothing", 100, 7
goto tweaks1

goto error

:tweaks
cls
mode 102,30
echo:
echo                                               -Tweaks-
echo                                         [Version: 1.4_beta]
echo:
echo ======================================================================================================
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
echo      [8] Prefer IPv4 Over IPv6           [16] Debloat Edge [Wifi Only/Open Sources]
echo ======================================================================================================
echo                                               -Note-
echo:
echo                             Something Tweaks will need reboot or sign out.
echo                                Some tweak will only work with regedit!
echo                        =======================================================
echo:
set /p options6="Enter Your Options: "

if "%options6%"=="0" goto menu
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

goto error
:dtf
cls
del /q/f/s %TEMP%\*
goto tweaks

goto error
:dcf
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /f /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1
goto tweaks

goto error
:dah
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /f /v PublishUserActivities /t REG_DWORD /d 0
goto tweaks

goto error
:dt
cls
sc config DiagTrack start= disabled
sc config dmwappushservice start= disabled
goto tweaks

goto error
:dg
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f /v AllowgameDVR /t REG_DWORD /d 0
goto tweaks

goto error
:dh
cls
Powercfg.exe /hibernate off
goto tweaks

goto error
:dhg
cls
reg add "HKEY_LOCAL_MACHINE\Software\Classes\clsID\{B4FB3F98-C1EA-428d-A78A-D1F5659CBA93}" /f /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0
goto tweaks

goto error
:p4o6
cls
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /f /v DisabledComponents /t REG_DWORD /d 20
goto tweaks

goto error
:dlt
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /f /v Value /t REG_SZ /d Deny
goto tweaks

goto error
:dss
cls
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /f /v 01 /t REG_DWORD /d 0
goto tweaks

goto error
:dws
cls
echo This Tweaks need name your wifi! (Required And Correctly)
set /p wifi="Enter Here: "
netsh interface set interface name="%wifi%" admin=DISABLED
goto tweaks

goto error
:et
cls
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f /v TaskbarEndTask /t REG_DWORD /d 1
goto tweaks

goto error
:shad
cls
Powercfg.exe /hibernate on
goto tweaks

goto error
:dedge
cls
echo WARNING! THIS IS OPEN SOURCE FROM OTHERS NOT ME CREATE
echo Credit by TheBobPony
powershell "iex(irm https://fixedge.today)"
goto tweaks

goto error

:advanced
cls
echo ==============================================================================
echo:
echo                             ADVANCED SETTINGS
echo:
echo ==============================================================================
echo:
echo    1.Delete MS Store [Not Recommended]
echo:
echo    2.
echo:
echo    3.
echo:
echo    4.
echo:
echo Press Any Key To Go Back...
pause >nul
goto tweaks

goto error

:activate
cls
echo:
echo                       --WARNING!--
echo:
echo ==========================================================
echo             THIS ACTIVATE PRODUCTS IS ILLEGAL
echo          NOT USING THIS TO ENTERPRISE AND BUSINESS
echo           IF YOU WANT TO GET THE LEGAL PRODUCTS
echo            YOU NEED TO BUY THIS FROM MICROSOFT!
echo             (ONLY WORK ON WINDOWS 8 And Later)
echo              [!OPEN-SOURCES NOT ME CREATE!]
echo ==========================================================
echo:
echo         [1] Accept                  [2] Decline
echo      [NOT RECOMMNEDED]
echo:
set /p warning="Enter Your Options: "

if "%warning%"=="1" goto activate1check
if "%warning%"=="2" goto menu
goto activate

goto error

:activate1check
cls
set versionnetwork=1.2
title Checking Internet Connection Requirements! %versionnetwork%
echo Checking Internet Connection...
Ping www.google.nl -n 1 -w 1000
set network=%errorlevel%

if %network%==1 goto stop1
if %network%==0 goto activate1

goto error

:stop1
cls
echo Can't Connect With Internet. Please Try Again!
echo:
echo Press Any Key To Go Back Panel...
pause >nul
goto menu

goto error

:activate1
cls
title Activation Products
echo Activation Scripts (Project Massgrave, Offical Website:https://massgrave.dev/credits)
echo Open-Sources From Others NOT ME CREATE!
powershell "irm https://get.activated.win | iex"
goto menu

goto error

goto error

:error
cls
title ERROR!
echo Unknown Error. Please report this!
echo:
echo Troubleshoot Here: %link%
echo Error Code:3
echo:
echo Auto Exit in 3 seconds...
timeout /t 3 /nobreak >nul
exit

:: LEAVE EMPTY BLANK HERE [%sversion%]
