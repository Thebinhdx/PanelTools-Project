# launcher.ps1
# ------------------------------------------
# PowerShell bootstrapper
# ------------------------------------------

$batUrl = "https://raw.githubusercontent.com/yourname/YourRepo/main/run.bat"

$tempBat = "$env:TEMP\paneltools.bat"

Write-Host "Installing File" -ForegroundColor Cyan
Invoke-WebRequest -Uri $batUrl -OutFile $tempBat -UseBasicParsing

if (!(Test-Path $tempBat)) {
    Write-Host "Error: Can't Install File, Code:404" -ForegroundColor Red
    exit 1
}

# Chạy file batch
Write-Host "Starting File" -ForegroundColor Yellow
Start-Process "cmd.exe" -ArgumentList "/c", "`"$tempBat`"" -Wait

# Xoá file tạm sau khi chạy
Remove-Item $tempBat -Force

Write-Host "Succesfully" -ForegroundColor Green

