@echo off

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
if "%~1" neq "4b9d2Dc0aK2l9Xs0" (
	cls
  	call :dk_color %Red% "===Error==="
  	echo Only run with main scripts. Not open manually.
  	echo Press Any Key to Exit...
  	pause >nul
  	exit /b 1
) else (
	title Updater
	cls
	timeout /nobreak /t 10 >nul
	echo Remove Old Version.
	del /f /q "%~dp0\PanelTools.cmd"

	echo Install New Version.
	powershell -command ^
	"Invoke-WebRequest 'https://raw.githubusercontent.com/Thebinhdx/PanelTools-Project/refs/heads/main/PanelTools.cmd' -OutFile '%~dp0\PanelTools.cmd'"

	echo Starting the New Version.
	cmd /c start "" "%~dp0\PanelTools.cmd"
	echo Closing in 3 seconds
	timeout /nobreak /t 3 >nul
	exit
)

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