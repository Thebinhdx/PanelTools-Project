@echo off
set link=https://github.com/Thebinhdx/PanelTools-Project/blob/main/Troubleshoot.md

setlocal EnableDelayedExpansion

for /f "tokens=6 delims=[]. " %%a in ('ver') do set /a winbuild=%%a
set "nul1=>nul"
set "nul2=>nul"
set "ps=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
set "psc=%ps% -NoLogo -NoProfile -ExecutionPolicy Bypass -Command"

set "_NCS=1"
if %winbuild% LSS 10586 set "_NCS=0"
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 %nul2% | find /i "0x0" %nul1% && (set "_NCS=0")

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set    "Gray="100;97m""
set   "Green="42;97m""
set    "Blue="44;97m""
set   "White="107;91m""
set    "_Red="40;91m""
set  "_White="40;37m""
set  "_Green="40;92m""
set "_Yellow="40;93m""
) else (
set     "Red="Red" "white""
set    "Gray="Darkgray" "white""
set   "Green="DarkGreen" "white""
set    "Blue="Blue" "white""
set   "White="White" "Red""
set    "_Red="Black" "Red""
set  "_White="Black" "Gray""
set  "_Green="Black" "Green""
set "_Yellow="Black" "Yellow""
)

echo Checking Administrator Requirements...

net session >nul 2>&1
if %errorlevel% == 0 (
  goto continue
) else (
  cls
  call :dk_color %Red% "===Error==="
  echo Administrator privileges required.  Please run this script as administrator.
  echo Press Any Key to Exit...
  pause >nul
  exit /b 1
)

:continue
cls
if %winbuild% LSS 22000 (
%eline%
call :dk_color %Red% "===Error==="
echo Unsupported OS version detected [%winbuild%].
echo Error Code: 1207
echo:
call :dk_color %Blue% "Only supported on Windows 11."
echo Press Any Key to Exit...
pause >nul
exit /b 1
)

set "%errorlevel%= "
ping -n 1 google.com >nul 2>&1
if errorlevel 1 (
    cls
    call :dk_color %Red% "===Error==="
    echo Can't connect to Internet. Please check your connection.
    echo Error Code: 404
    echo:
    call :dk_color2 %Blue% "Check this webpage for help - " %_Yellow% " %link%"
    echo:
    echo Press any key to exit...
    pause >nul
    exit /b 1
)
set version=4.0
set "current_version=3.9003.2"
set "update=  Not Update Available"
set "developermode=0"
set "updatelink=https://github.com/Thebinhdx/PanelTools-Project/releases/latest"
set "version_url=https://raw.githubusercontent.com/Thebinhdx/PanelTools-Project/refs/heads/main/version.txt"
set "tmpfile=%temp%\latest_version.txt"

cls
echo Checking for updates...

powershell -Command ^
    "(New-Object System.Net.WebClient).DownloadFile('%version_url%', '%tmpfile%')" ^
    2>nul

if not exist "%tmpfile%" (
    cls
    call :dk_color %Red% "===Error==="
    echo Unable to check for updates.
    echo Error Code: 506
    echo:
    call :dk_color2 %Blue% "Check this webpage for help - " %_Yellow% " %link%"
    echo:
    echo Press any key to continue...
    pause >nul
    set "update=Error to update"
    goto menu
)

for /f "usebackq tokens=* delims=" %%a in ("%tmpfile%") do set "latest_version=%%a"
del "%tmpfile%" >nul 2>&1

set "%errorlevel%= "

call :compareVersion "%current_version%" "%latest_version%"
if %errorlevel%==0 (
    goto menu
) else (
    cls
    goto updaterr
)

:updaterr
set "update=Update Available"
set "updatever=%latest_version%"
:updatermenu
set "updater= "
cls
call :dk_color %Green% "A new version is available"
call :dk_color2 %Blue% "Download it here:" %_Yellow% " %updatelink%"
echo:
echo [0] Install Update
echo [1] Update Soon...
echo:
echo NOTE: ENTER YOUR OPTIONS TWICE, this error will be fix soon
set /p updater="Enter Your Options: "

if "%updater%"=="0" goto :update
if "%updater%"=="1" goto :menu

goto updatermenu

    :update
    del /q /f %~dp0\updater.cmd
    cls
    powershell -command ^
    "Invoke-WebRequest 'https://raw.githubusercontent.com/Thebinhdx/PanelTools-Project/refs/heads/main/updater.cmd' -OutFile '%~dp0\updater.cmd'"
    timeout /nobreak /t 3 >nul
    start "" "%~dp0\updater.cmd"
    timeout /nobreak /t 3 >nul
    cls
    echo App in closing. DON'T PRESS ANY BUTTON.
    echo:
    timeout /nobreak /t 3 >nul
    exit

:menu
mode 103,30
cls
cls
title PanelTools
echo:
call :dk_color %_Green% "                                           --Paneltools--                                           "
echo:
echo ==================-MENU-================== =============-NOTE-============= =========-Credits-=========
echo:
echo        [1] Download/Install Apps             [*]: third party software or        Thebinhdx [Owner]
echo:                                           other software not created by me                   
echo            [2] Tweaks [Beta]
echo:
echo    [3] Activate Windows and Office [*]     =============-About-============ =========-Update-==========
echo:
echo                                            -Version: %version%               %update%
echo:                                                    [%current_version%]
echo                [0] Exit                                                                       %updatever%
echo:
echo ========================================== ================================ ===========================
echo:
set /p menu="Enter Your Options: "

if "%menu%"=="0" exit
if "%menu%"=="1" goto next2_1
if "%menu%"=="2" goto tweaks1
if "%menu%"=="3" goto activate

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
call :dk_color %_Yellow% "                                --WARNING--                                "
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
echo                        Auto Checking Update Soon...
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
set link1=https://github.com/microsoft/winget-cli/discussions/3258#discussioncomment-5939793
echo:
call :dk_color %_Yellow% "-Don't Close this windows-"
echo:
echo Installing Packages... (You Need Wait Some Minutes After Install)
timeout /nobreak /t 3 >nul

powershell "Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
echo Fix Problem Install Manually...

echo Link Problem Report: %link1%
timeout /nobreak /t 3 >nul
powershell "Add-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix"

echo Completed! You Can Use Now.
call :dk_color %_Yellow% "NOTE: I dont know this can fix properly this. So you need to check."
echo:
echo Press Any Key To Go Back...
pause >nul
goto next1

goto error

:next2
cls
mode 168,60
echo:
call :dk_color %_Green% "                                                                    -Winget Install-                                                                    "
call :dk_color %_Green% "                                                                     [By Microsoft]                                                                     "
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
echo       -Record Tools-                                      -Utilities-
echo:
echo       [32] OBS Studio       [34] 7-Zip               [44] Malwarebytes            [54] Driver Booster                              [WARNING]
echo:
echo       [33] Bandicam         [35] AnyDesk             [45] MSI Afterburner         [55] Capcut                     Winget only support some applications not all
echo:
echo                             [36] CPU-Z               [46] Nilesoft Shell          [56] IObit Uninstaller                            -Custom-
echo:
echo                             [37] Crystal Disk        [47] OPAutoClicker           [57] Geforce Now                          [100] Install Custom App
echo:
echo                             [38] File-Converter      [48] Rainmeter               [58] CCleaner                             [101] Update All
echo:
echo                             [39] GPU-Z               [49] Oracle VirtualBox       [59] IObit Unlocker
echo:
echo                             [40] HWiNFO              [50] WinRAR                  [0] Back
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

set "id="

for %%a in (
    "1:Opera.Opera" "2:Opera.OperaGX" "3:Brave.Brave" "4:Google.Chrome" "5:Mozilla.Firefox"
    "6:CentStudio.CentBrowser" "7:ungoogled-chromium" "8:Microsoft.Edge" "9:TorProject.TorBrowser" "10:win32ss.Supermium"
    "11:Discord.Discord" "12:Zoom.Zoom" "13:VNGCorp.Zalo" "14:Microsoft.Skype" "15:Microsoft.Teams"
    "16:chrisant996.Clink" "17:git.git" "18:JanDeDobbeleer.OhMyPosh" "19:OpenJS.NodeJS" "20:Python.Python.3.13"
    "21:Unity.Unity.2020" "22:Microsoft.VisualStudio.2022.Community" "23:Microsoft.VisualStudioCode"
    "24:Foxit.PhantomPDF" "25:Foxit.FoxitReader" "26:Notepad++.Notepad++" "27:Valve.Steam"
    "28:Microsoft.Sysinternals.Autoruns" "30:Microsoft.OneDrive"
    "32:OBSProject.OBSStudio" "33:BandicamCompany.Bandicam" "34:7zip.7zip" "35:AnyDeskSoftwareGmbH.AnyDesk"
    "36:CPUID.CPU-Z" "38:AdrienAllard.FileConverter" "39:TechPowerUp.GPU-Z" "40:REALiX.HWiNFO"
    "41:CPUID.HWMonitor" "42:AppWork.JDownloader" "43:rocksdanister.LivelyWallpaper" "44:Malwarebytes.Malwarebytes"
    "45:Guru3D.Afterburner" "46:nilesoft.shell" "47:OPAutoClicker.OpAutoClicker" "48:Rainmeter.Rainmeter"
    "49:Oracle.VirtualBox" "50:RARLab.WinRAR" "51:Microsoft.Office" "52:Oracle.JavaRuntimeEnvironment"
    "54:IObit.DriverBooster" "55:ByteDance.CapCut" "56:IObit.Uninstaller" "57:Nvidia.GeForceNow"
    "58:Priform.CCleaner" "59:IObit.IObitUnlocker"
) do (
    for /f "tokens=1,2 delims=:" %%b in (%%a) do (
        if "%options2%"=="%%b" set "id=%%c"
    )
)

if defined id (
    call :install_app %id%
    goto next2
)

if "%options2%"=="31" goto visualc
if "%options2%"=="29" goto net
if "%options2%"=="100" goto custom
if "%options2%"=="101" goto update
if "%options2%"=="37" goto crydisk

echo Option invalid! & timeout /t 2 >nul & goto next2
goto next2

goto error

:install_app
cls
echo Installing: %1...
call :dk_color %_Yellow% "WARNING: NOT CLOSE THIS WINDOWS"
winget install %1 --silent
echo Done. Press any key to exit...
call :dk_color %_Yellow% "WARNING: If you have error with your app. Please take screenshot and find instruction in Internet"
pause >nul

goto next2

goto error

:update
cls
echo Update All...
call :dk_color %_Yellow% "WARNING: NOT CLOSE THIS WINDOWS"
winget update --all
echo Done. Press any key to exit...
call :dk_color %_Yellow% "WARNING: If you have error with your app. Please take screenshot and find instruction in Internet"
goto next2

goto error

:custom
cls
mode 100,30
:help
call :dk_color %Red% "                              WARNING: THIS IS CUSTOM INSTALL.                                     "
call :dk_color %Red% "PLEASE ENTER YOUR CORRECTLY APP NAME AND YOUR APP YOU WANT INSTALL HAVE SUPPORT THIS INSTALL METHOD"
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
if "%custom%"=="install" goto install_custom
if "%custom%"=="back" goto next2
if "%custom%"=="help" goto help

echo Unknown Command
goto custom1

:search
echo --- Search ---
set /p csearch="Enter Name: "
winget search %csearch%
echo Done. Press any key to exit...
pause >nul

goto custom1

goto error

:install_custom
echo --- Search ---
set /p cid="Enter App ID: "
call :dk_color %_Yellow% "WARNING: NOT CLOSE THIS WINDOWS"
winget install %cid%
echo Done. Press any key to exit...
call :dk_color %_Yellow% "WARNING: If you have error with your app. Please take screenshot and find instruction in Internet"
pause >nul

goto custom1

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
echo                   [6] NET Desktop Runtime 10.0
echo:
echo                 [7] NET Desktop Runtime Preview
echo:
echo                          [0] Go Back
echo =================================================================
echo:
set /p options3="Enter Your Options: "

if "%options3%"=="0" goto next2
if "%options3%"=="7" goto netpre call :install_app Microsoft.DotNet.DesktopRuntime.Preview
if "%options3%"=="7" goto net10 call :install_app Microsoft.DotNet.DesktopRuntime.10
if "%options3%"=="6" goto net9 call :install_app Microsoft.DotNet.DesktopRuntime.9
if "%options3%"=="5" goto net8 call :install_app Microsoft.DotNet.DesktopRuntime.8
if "%options3%"=="4" goto net7 call :install_app Microsoft.DotNet.DesktopRuntime.7
if "%options3%"=="3" goto net6 call :install_app Microsoft.DotNet.DesktopRuntime.6
if "%options3%"=="2" goto net5 call :install_app Microsoft.DotNet.DesktopRuntime.5
if "%options3%"=="1" goto net31 call :install_app Microsoft.DotNet.DesktopRuntime.3_1

goto net

goto error

:netpre
cls
winget install Microsoft.DotNet.DesktopRuntime.Preview
goto net

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
if "%options4%"=="6" goto 20152022 call :install_app Microsoft.VCRedist.2015+.x64
if "%options4%"=="5" goto 2013 call :install_app Microsoft.VCRedist.2013.x64
if "%options4%"=="4" goto 2012 call :install_app Microsoft.VCRedist.2012.x64
if "%options4%"=="3" goto 2010 call :install_app Microsoft.VCRedist.2010.x64
if "%options4%"=="2" goto 2008 call :install_app Microsoft.VCRedist.2008.x64
if "%options4%"=="1" goto 2005 call :install_app Microsoft.VCRedist.2005.x64
goto visualc

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
if "%options5%"=="2" call :install_app CrystalDewWorld.CrystalDiskInfo
if "%options5%"=="1" call :install_app CrystalDewWorld.CrystalDiskMark
goto crydisk

goto error

:tweaks1
cls
mode 78,20
echo:
call :dk_color %_Yellow% "                                 --WARNING--                                 "
echo:
echo =============================================================================
echo               BEFORE TWEAKS PC YOU NEED TO CREATE RESTORE POINT
echo                              TO SAVE YOUR PC
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
call :dk_color %_Green% "                                              -Tweaks-                                              "
call :dk_color %_Green% "                                        [Version: 1.4_beta]                                       "
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

:activate
cls
echo:
call :dk_color %_Yellow% "                      --WARNING--                      "
echo:
echo ==========================================================
echo             THIS ACTIVATE PRODUCTS IS ILLEGAL
echo          NOT USING THIS TO ENTERPRISE AND BUSINESS
echo           IF YOU WANT TO GET THE LEGAL PRODUCTS
echo            YOU NEED TO BUY THIS FROM MICROSOFT!
echo             (ONLY WORK ON WINDOWS 8 And Later)
echo              [OPEN-SOURCES NOT ME CREATE]
echo ==========================================================
echo:
echo         [1] Accept                  [2] Decline
echo      [NOT RECOMMNEDED]
echo:
set /p warning="Enter Your Options: "

if "%warning%"=="1" goto activate1
if "%warning%"=="2" goto menu
goto activate

goto error

:activate1
cls
title Activation Products
echo Activation Scripts (Project Massgrave, Offical Website:https://massgrave.dev/credits)
call :dk_color %_Yellow% "Open-Sources From Others NOT ME CREATE"
powershell "irm https://get.activated.win | iex"
goto menu

goto error

:error
cls
call :dk_color %Red% "===Error==="
echo:
echo Unknown Reason
echo Error Code:0
echo:
call :dk_color2 %Blue% "Check this webpage for help - " %_Yellow% " %link%"
echo:
echo Auto Exit in 3 seconds...
timeout /t 3 /nobreak >nul
exit

:dk_color
if %_NCS% EQU 1 (
  echo %esc%[%~1%~2%esc%[0m
) else (
  if exist "%ps%" (
    %psc% write-host -back '%1' -fore '%2' '%3'
  ) else (
    echo %~3
  )
)
exit /b

:dk_color2
if %_NCS% EQU 1 (
  echo %esc%[%~1%~2%esc%[%~3%~4%esc%[0m
) else (
  if exist "%ps%" (
    %psc% write-host -back '%1' -fore '%2' '%3' -NoNewline; write-host -back '%4' -fore '%5' '%6'
  ) else (
    echo %~3 %~6
  )
)
exit /b

:compareVersion
setlocal
set "v1=%~1"
set "v2=%~2"

for /f "tokens=1-3 delims=." %%a in ("%v1%") do (
    set /a v1a=%%a, v1b=%%b, v1c=%%c
)
for /f "tokens=1-3 delims=." %%a in ("%v2%") do (
    set /a v2a=%%a, v2b=%%b, v2c=%%c
)

if %v1a% GTR %v2a% exit /b 0
if %v1a% LSS %v2a% exit /b 1

if %v1b% GTR %v2b% exit /b 0
if %v1b% LSS %v2b% exit /b 1

if %v1c% GEQ %v2c% exit /b 0
exit /b 1


:: LEAVE EMPTY BLANK HERE