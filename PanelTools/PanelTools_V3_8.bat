@echo off
title Checking Administrator Requirements!

echo Checking Administrator Requirements...

net session >nul 2>&1
if %errorlevel% == 0 (
  goto continue
) else (
  echo Administrator privileges required.  Please run this script as administrator.
  pause
  exit /b 1
)

::Settings
:continue
cls
title PanelTools V3.8 BETA1
echo Loading Settings...
set /p data=<"%~dp0\Settings\settings_data.txt" >nul
if "%data%"=="0" (
 set skipcheck=false
 goto continue
)
if "%data%"=="1" (
 set skipcheck=true
 goto continue
)

cls
echo Error! To Set Settings.
echo:
echo System will use default settings!
timeout /t 2 /nobreak >nul
set skipcheck=false
goto continue

:continue
echo:
echo Skip Check: %skipcheck%
timeout /t 3 /nobreak >nul
if "%skipcheck%"=="true" goto start

goto check2

:check2
cls
echo Checking Scripts...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\Scripts\run.bat" (
    goto check1
) ELSE (
    cls
    echo Error! Not Found Script.
    echo:
    echo:
    echo Troubleshoot Here: [github.com/Thebinhdx/PanelTools-Project/blob/main/Troubleshoot.md]
    echo Error Code:1
    echo Press Any Key To Exit...
    pause >nul
    exit
)

:check
cls
echo Checking Extensions...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\Scripts\Extensions\UninstallTool.exe" (
    goto start
) ELSE (
    cls
    echo Error! Not Found Extensions.
    echo:
    echo:
    echo Troubleshoot Here: [github.com/Thebinhdx/PanelTools-Project/blob/main/Troubleshoot.md]
    echo Error Code:1
    echo Press Any Key To Exit...
    pause >nul
    exit
)

:start
cd /d %~dp0
start Scripts\run.bat
exit