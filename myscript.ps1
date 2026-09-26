function Show-Menu {
    Clear-Host
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host "                    CÔNG CỤ QUẢN TRỊ & KIỂM TRA MÁY TÍNH                   " -ForegroundColor Yellow
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  MENU CHỨC NĂNG:" -ForegroundColor Green
    Write-Host "    [1] Chạy License Info (license.info.vn)"
    Write-Host "    [2] Chạy GetIWC (getiwc.online)"
    Write-Host "    [3] Kiểm tra bản quyền Windows (slmgr /dli)"
    Write-Host "    [4] Xem Serial Number BIOS"
    Write-Host "    [5] Tải & chạy ShowKeyPlus"
    Write-Host "    [0] Thoát"
    Write-Host ""
    Write-Host "==========================================================================" -ForegroundColor Cyan
    Write-Host "Chọn chức năng [1-5, 0]: " -NoNewline -ForegroundColor Yellow
}

do {
    Show-Menu
    
    # Lắng nghe phím gõ trực tiếp (không cần nhấn Enter)
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    $char = $key.Character
    Write-Host $char -ForegroundColor Cyan
    Start-Sleep -Milliseconds 150

    switch ($char) {
        '1' {
            Write-Host "`n[>] Đang chạy License Info..." -ForegroundColor Green
            irm https://license.info.vn | iex
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '2' {
            Write-Host "`n[>] Đang chạy GetIWC..." -ForegroundColor Green
            irm getiwc.online | iex
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '3' {
            Write-Host "`n[>] Đang kiểm tra bản quyền Windows (slmgr /dli)..." -ForegroundColor Green
            slmgr /dli
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '4' {
            Write-Host "`n[>] Đang truy xuất Serial Number BIOS..." -ForegroundColor Green
            $serial = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
            Write-Host "--> Serial Number: $serial" -ForegroundColor Yellow
            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '5' {
            Write-Host "`n[>] Đang tải bộ cài ShowKeyPlus..." -ForegroundColor Green
            
            # Cấu hình TLS 1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $ProgressPreference = 'SilentlyContinue'
            
            # Đường dẫn lưu file
            $savePath = "$env:USERPROFILE\Downloads\ShowKeyPlus_Installer.exe"
            
            # Link tải trực tiếp từ GitHub Raw
            $downloadUrl = "https://raw.githubusercontent.com/Danhle999/myscript/main/ShowKeyPlus%20Installer.exe"
            
            try {
                # Tải file sử dụng System.Net.WebClient để đạt tốc độ tối đa
                $webClient = New-Object System.Net.WebClient
                $webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
                $webClient.DownloadFile($downloadUrl,$savePath)

                Write-Host "--> Tải thành công! File lưu tại: $savePath" -ForegroundColor Yellow
                
                # Mở file bộ cài sau khi tải xong
                Write-Host "--> Đang mở bộ cài đặt..." -ForegroundColor Cyan
                Start-Process -FilePath $savePath
            }
            catch {
                Write-Host "`n[!] LỖI TẢI FILE: $_" -ForegroundColor Red
            }
            finally {
                $ProgressPreference = 'Continue'
            }

            Write-Host "`nNhấn phím bất kỳ để quay lại menu..." -ForegroundColor Gray
            $null =$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
        '0' {
            Write-Host "`n[!] Đang thoát chương trình..." -ForegroundColor Red
            break
        }
        Default {
            Write-Host "`n[!] Lựa chọn không hợp lệ!" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
} while ($char -ne '0')
