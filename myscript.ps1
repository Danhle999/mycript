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
    Write-Host "    [5] Tải & chạy ShowKeyPlus (ShowKeyPlus.exe)"
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
            Write-Host "`n[>] Đang tải ShowKeyPlus.exe từ GitHub..." -ForegroundColor Green
            
            # Cấu hình TLS 1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $ProgressPreference = 'SilentlyContinue'
            
            # Link Direct Raw tới file ShowKeyPlus.exe
            $downloadUrl = "https://raw.githubusercontent.com/Danhle999/mycript/main/ShowKeyPlus.exe"
            
            # Thư mục lưu file
            $downloadFolder = "$env:USERPROFILE\Downloads"
            $savePath = Join-Path -Path$downloadFolder -ChildPath "ShowKeyPlus.exe"
            
            try {
                # Kiểm tra nếu thư mục Downloads chưa tồn tại thì tự động tạo
                if (-not (Test-Path -Path $downloadFolder)) {
                    New-Item -ItemType Directory -Path $downloadFolder -Force | Out-Null
                }

                # Tải file về máy
                irm $downloadUrl -OutFile$savePath -ErrorAction Stop
                Write-Host "--> Tải thành công! File lưu tại: $savePath" -ForegroundColor Yellow
                
                # Mở file ứng dụng
                if (Test-Path -Path $savePath) {
                    Write-Host "--> Đang mở ShowKeyPlus..." -ForegroundColor Cyan
                    Start-Process -FilePath $savePath
                } else {
                    Write-Host "[!] Không tìm thấy file sau khi tải!" -ForegroundColor Red
                }
            }
            catch {
                Write-Host "`n[!] LỖI TẢI FILE: $_" -ForegroundColor Red
                Write-Host "[!] Vui lòng kiểm tra lại link URL trên GitHub (mycript hay myscript)!" -ForegroundColor Yellow
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
