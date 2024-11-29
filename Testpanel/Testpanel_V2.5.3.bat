@echo off
title Checking Administrator Requirements!

echo Checking Administrator Requirements...

set "params=%*"
cd /d "%~dp0" && (
    if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"
) && fsutil dirty query %systemdrive% 1>nul 2>nul || (
    echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B
)

::Settings
cls
echo Loading Settings...
set /p uimenu=<"%~dp0\Settings\UIMenuOFF.txt" >nul
set /p skipcheck=<"%~dp0\Settings\SkipCheckFile.txt" >nul
timeout /t 3 /nobreak >nul
if "%uimenu%"=="false" set false=1 & goto check2
if "%skipcheck%"=="true" goto start

goto check2

::Checking File Is Exist Not Missing!
:check2
del %temp%\errorv2.log >nul
cls
echo Checking Scripts...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\Scripts\run.bat" (
    goto check1
) ELSE (
    cls
    echo Create By Testpanel [Error Log] >%temp%\errorv2.log
    echo Check PATH >>%temp%\errorv2.log
    echo Error1: Not Exist In Scripts File In Folder >>%temp%\errorv2.log
    echo run.bat Not Exist >>%temp%\errorv2.log
    echo Error! Not Found Script.
    echo More Info In File %temp%\error.log...
    echo NOTE: All File Error Will Be Delete After Open This File Again!
    echo:
    echo Error Code:1
    echo Press Any Key To Exit...
    pause >nul
    exit
)

:check1
del %temp%\errorv2.log >nul
cls
echo Checking UI...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\UI\UIMenu.bat" (
    goto check
) ELSE (
    cls
    echo Create By Testpanel [Error Log] >%temp%\errorv2.log
    echo Check PATH >>%temp%\errorv2.log
    echo Error1: Not Exist In UI Folder >>%temp%\errorv2.log
    echo UIMenu.bat Not Exist >>%temp%\errorv2.log
    echo Error To Loading! Not Found UI.
    echo More Info In File %temp%\error.log...
    echo NOTE: All File Error Will Be Delete After Open This File Again!
    echo:
    echo Error Code:1
    echo Press Any Key To Continue Without UI...
    pause >nul
    goto check
)

:check
del %temp%\errorv2.log >nul
cls
echo Checking Extensions...
timeout /t 3 /nobreak >nul
cls
IF EXIST "%~dp0\Scripts\Extensions\UninstallTool.exe" (
    goto start
) ELSE (
    cls
    echo Create By Testpanel [Error Log] >%temp%\errorv2.log
    echo Check PATH >>%temp%\errorv2.log
    echo Error1: Not Exist In Tools Folder >>%temp%\errorv2.log
    echo UninstallTool.exe Not Exist >>%temp%\errorv2.log
    echo Error! Not Found Extensions.
    echo More Info In File %temp%\error.log...
    echo NOTE: All File Error Will Be Delete After Open This File Again!
    echo:
    echo Error Code:1
    echo Press Any Key To Exit...
    pause >nul
    exit
)

:start
cd /d %~dp0
if "%false%"=="1" goto startnotui
start UI\UIMenu.bat
timeout /t 4 /nobreak >nul
:startnotui
start Scripts\run.bat
exit