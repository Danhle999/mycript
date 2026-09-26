function Show-Menu {
    Clear-Host
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host "                   CÔNG CỤ QUẢN TRỊ & KIỂM TRA MÁY TÍNH                   " -ForegroundColor Yellow
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  MENU CHỨC NĂNG:" -ForegroundColor Green
    Write-Host "    [1] Chạy License Info (license.info.vn)"
    Write-Host "    [2] Chạy GetIWC (getiwc.online)"
    Write-Host "    [3] Kiểm tra bản quyền Windows (slmgr /dli)"
    Write-Host "    [4] Xem Serial Number BIOS"
    Write-Host "    [0] Thoát"
    Write-Host ""
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host "Lựa chọn của bạn [1-4, 0]: " -NoNewline -ForegroundColor Yellow
}

do {
    Show-Menu
    
    # Đọc phím bấm trực tiếp từ bàn phím
    $key =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    $char =$key.Character
    Write-Host $char -ForegroundColor Cyan
    Start-Sleep -Milliseconds 150

    switch ($char) {
        '1' {
            Write-Host "`n[>] Đang chạy License Info..." -ForegroundColor Green
            irm https://license.info.vn | iex
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '2' {
            Write-Host "`n[>] Đang chạy GetIWC..." -ForegroundColor Green
            irm getiwc.online | iex
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '3' {
            Write-Host "`n[>] Đang kiểm tra bản quyền Windows (slmgr /dli)..." -ForegroundColor Green
            Start-Process cscript.exe -ArgumentList "$env:SystemRoot\System32\slmgr.vbs /dli" -Wait
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '4' {
            Write-Host "`n[>] Đang truy xuất Serial Number BIOS..." -ForegroundColor Green
            $serial = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
            Write-Host "--> Serial Number: $serial" -ForegroundColor Yellow
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '0' {
            Write-Host "`n[!] Đang thoát..." -ForegroundColor Red
            break
        }
        Default {
            Write-Host "`n[!] Phím bấm không hợp lệ, vui lòng bấm phím từ 0 đến 4!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($char -ne '0')
