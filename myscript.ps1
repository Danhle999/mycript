Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 1. Khởi tạo cửa sổ chính
$form = New-Object System.Windows.Forms.Form
$form.Text = "PowerShell Interactive Toolkit"
$form.Size = New-Object System.Drawing.Size(420, 340)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedSingle"
$form.MaximizeBox = $false
$form.TopMost = $true

# 2. Tiêu đề
$label = New-Object System.Windows.Forms.Label
$label.Text = "Vui lòng chọn nút chức năng cần chạy:"
$label.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$label.Size = New-Object System.Drawing.Size(380, 25)
$label.Location = New-Object System.Drawing.Point(20, 15)
$form.Controls.Add($label)

# Hàm bổ trợ chạy Script nền không làm đơ GUI
function Run-ScriptInBackground ([string]$scriptText) {
    $ps = [powershell]::Create()
    [void]$ps.AddScript($scriptText)
    [void]$ps.BeginInvoke()
}

# Nút 1: License Info
$btn1 = New-Object System.Windows.Forms.Button
$btn1.Text = "1. Chạy License Info (license.info.vn)"
$btn1.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btn1.Size = New-Object System.Drawing.Size(360, 42)
$btn1.Location = New-Object System.Drawing.Point(20, 50)
$btn1.Add_Click({
    Run-ScriptInBackground "irm https://license.info.vn | iex"
})
$form.Controls.Add($btn1)

# Nút 2: Get IWC
$btn2 = New-Object System.Windows.Forms.Button
$btn2.Text = "2. Chạy GetIWC (getiwc.online)"
$btn2.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btn2.Size = New-Object System.Drawing.Size(360, 42)
$btn2.Location = New-Object System.Drawing.Point(20, 105)
$btn2.Add_Click({
    Run-ScriptInBackground "irm getiwc.online | iex"
})
$form.Controls.Add($btn2)

# Nút 3: slmgr /dli
$btn3 = New-Object System.Windows.Forms.Button
$btn3.Text = "3. Kiểm tra bản quyền Windows (slmgr /dli)"
$btn3.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btn3.Size = New-Object System.Drawing.Size(360, 42)
$btn3.Location = New-Object System.Drawing.Point(20, 160)
$btn3.Add_Click({
    Start-Process cscript.exe -ArgumentList "$env:SystemRoot\System32\slmgr.vbs /dli" -NoNewWindow
})
$form.Controls.Add($btn3)

# Nút 4: Get BIOS Serial
$btn4 = New-Object System.Windows.Forms.Button
$btn4.Text = "4. Xem Serial Number BIOS"
$btn4.Font = New-Object System.Drawing.Font("Segoe UI", 9.5)
$btn4.Size = New-Object System.Drawing.Size(360, 42)
$btn4.Location = New-Object System.Drawing.Point(20, 215)
$btn4.Add_Click({
    $serial = (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
    [System.Windows.Forms.MessageBox]::Show("Serial Number BIOS: $serial", "Thông tin BIOS", "OK", "Information")
})
$form.Controls.Add($btn4)

# Hiển thị Form
[void]$form.ShowDialog()
