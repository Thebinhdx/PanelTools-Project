@echo off

echo Checking Administrator Requirements...

net session >nul 2>&1
if %errorlevel% == 0 (
  goto continue
) else (
  cls
  echo "===Error==="
  echo Administrator privileges required.  Please run this script as administrator.
  echo Press Any Key to Exit...
  pause >nul
  exit /b 1
)

title Updater
cls
echo Remove Old Version.
del /f /q "%~dp0\PanelTools.cmd"

echo Install New Version.
powershell -command ^
"Invoke-WebRequest 'https://raw.githubusercontent.com/Thebinhdx/PanelTools-Project/refs/heads/main/PanelTools.cmd' -OutFile '%~dp0\PanelTools.cmd'"

echo Starting the New Version.
start PanelTools.cmd
echo Closing in 3 seconds
timeout /nobreak /t 3 >nul
exit