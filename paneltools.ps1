# launcher.ps1
# ------------------------------------------
# PowerShell bootstrapper
# ------------------------------------------

$batUrl = "https://raw.githubusercontent.com/Thebinhdx/PanelTools-Project/refs/heads/main/PanelTools.bat"

$tempBat = "$env:TEMP\PanelTools.bat"

Write-Host "Installing File" -ForegroundColor Yellow
Invoke-WebRequest -Uri $batUrl -OutFile $tempBat -UseBasicParsing

if (!(Test-Path $tempBat)) {
    Write-Host "Error: Can't Install File, Code:404" -ForegroundColor Red
    exit 1
}

# Chạy file batch
Write-Host "Starting File" -ForegroundColor Green
Start-Process "cmd.exe" -ArgumentList "/c", "`"$tempBat`"" -Wait

# Xoá file tạm sau khi chạy
Remove-Item $tempBat -Force -ErrorAction SilentlyContinue

Write-Host "Succesfully" -ForegroundColor Green




