# 下载 Universal Ctags for Windows
Write-Host "正在下载 Universal Ctags..." -ForegroundColor Cyan

$ctagsDir = "C:\Users\jinxi\my-vim\tools\ctags"
# 使用最新版本（2026-03-02）
$version = "2026-03-02/p6.2.20260222.0-3-g8c3f63b"
$downloadUrl = "https://github.com/universal-ctags/ctags-win32/releases/download/$version/ctags-$version-x64.zip"
$zipFile = "C:\Users\jinxi\my-vim\tools\ctags.zip"

# 创建目录
if (-not (Test-Path $ctagsDir)) {
    New-Item -ItemType Directory -Path $ctagsDir -Force | Out-Null
}

# 下载文件
Write-Host "下载地址: $downloadUrl"
try {
    # 使用 .NET WebClient 下载（Win7 兼容）
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("User-Agent", "PowerShell")
    
    Write-Host "正在下载..." -ForegroundColor Yellow
    $webClient.DownloadFile($downloadUrl, $zipFile)
    
    Write-Host "下载完成！" -ForegroundColor Green
    
    # 解压
    Write-Host "正在解压..." -ForegroundColor Yellow
    
    # Win7 需要使用 Shell.Application 解压
    $shell = New-Object -ComObject Shell.Application
    $zip = $shell.NameSpace($zipFile)
    $dest = $shell.NameSpace($ctagsDir)
    
    # 复制文件（4 = 不显示对话框，16 = 自动重命名）
    $dest.CopyHere($zip.Items(), 20)
    
    # 删除 zip 文件
    Remove-Item $zipFile -Force
    
    Write-Host "`n解压完成！" -ForegroundColor Green
    
    # 验证安装
    $ctagsExe = Join-Path $ctagsDir "ctags.exe"
    if (Test-Path $ctagsExe) {
        Write-Host "`nCtags 安装成功！" -ForegroundColor Green
        Write-Host "路径: $ctagsExe" -ForegroundColor Cyan
        
        # 显示版本
        $version = & $ctagsExe --version 2>&1 | Select-Object -First 1
        Write-Host "版本: $version" -ForegroundColor Cyan
        
        # 添加到 PATH（可选）
        Write-Host "`n提示: Vim 配置已自动识别此路径，无需手动配置" -ForegroundColor Yellow
    } else {
        Write-Host "错误: ctags.exe 未找到" -ForegroundColor Red
    }
    
} catch {
    Write-Host "下载失败: $_" -ForegroundColor Red
    Write-Host "`n备用方案：" -ForegroundColor Yellow
    Write-Host "1. 手动下载: https://github.com/universal-ctags/ctags-win32/releases" -ForegroundColor White
    Write-Host "2. 解压到: $ctagsDir" -ForegroundColor White
    Write-Host "3. 确保 ctags.exe 在该目录下" -ForegroundColor White
}

Write-Host "`n按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
