function Show-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "         POWERSHELL COMMAND MENU        " -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host " [1] Chạy License Info (license.info.vn)"
    Write-Host " [2] Chạy GetIWC (getiwc.online)"
    Write-Host " [3] Kiểm tra bản quyền Windows (slmgr /dli)"
    Write-Host " [4] Xem Serial Number BIOS"
    Write-Host " [Q] Thoát"
    Write-Host "========================================" -ForegroundColor Cyan
}

do {
    Show-Menu
    $selection = Read-Host "Nhập lựa chọn của bạn (1-4 hoặc Q)"
    switch ($selection) {
        '1' {
            Write-Host "`nĐang chạy License Info..." -ForegroundColor Green
            irm https://license.info.vn | iex
            Pause
        }
        '2' {
            Write-Host "`nĐang chạy GetIWC..." -ForegroundColor Green
            irm getiwc.online | iex
            Pause
        }
        '3' {
            Write-Host "`nĐang kiểm tra bản quyền Windows..." -ForegroundColor Green
            slmgr /dli
            Pause
        }
        '4' {
            Write-Host "`nĐang lấy Serial Number BIOS..." -ForegroundColor Green
            Get-CimInstance -ClassName Win32_BIOS | Select-Object SerialNumber
            Pause
        }
        'Q' {
            Write-Host "`nĐang thoát..." -ForegroundColor Yellow
            break
        }
        Default {
            Write-Host "`nLựa chọn không hợp lệ, vui lòng thử lại!" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($selection -ne 'Q')
