#!/usr/bin/env pwsh
# 清理 Node.js 目录中不必要的文件

$ErrorActionPreference = "Stop"
$NodeDir = "C:\Users\jinxi\my-vim\tools\node"

Write-Host "=== Node.js 目录清理 ===" -ForegroundColor Cyan
Write-Host ""

# 计算当前大小
$beforeSize = (Get-ChildItem $NodeDir -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
Write-Host "清理前大小: $([math]::Round($beforeSize, 2)) MB" -ForegroundColor Yellow
Write-Host ""

$removed = @()
$savedSpace = 0

# 1. 删除文档文件
Write-Host "[1] 删除文档文件..." -ForegroundColor Green
$docs = @("CHANGELOG.md", "README.md", "LICENSE")
foreach ($file in $docs) {
    $path = Join-Path $NodeDir $file
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        Remove-Item $path -Force
        $removed += $file
        $savedSpace += $size
        Write-Host "  ✓ 已删除 $file" -ForegroundColor Gray
    }
}

# 2. 删除安装工具
Write-Host ""
Write-Host "[2] 删除安装工具..." -ForegroundColor Green
$tools = @("install_tools.bat", "nodevars.bat")
foreach ($file in $tools) {
    $path = Join-Path $NodeDir $file
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        Remove-Item $path -Force
        $removed += $file
        $savedSpace += $size
        Write-Host "  ✓ 已删除 $file" -ForegroundColor Gray
    }
}

# 3. 删除 ETW 文件
Write-Host ""
Write-Host "[3] 删除 Windows 事件追踪文件..." -ForegroundColor Green
$etw = "node_etw_provider.man"
$path = Join-Path $NodeDir $etw
if (Test-Path $path) {
    $size = (Get-Item $path).Length
    Remove-Item $path -Force
    $removed += $etw
    $savedSpace += $size
    Write-Host "  ✓ 已删除 $etw" -ForegroundColor Gray
}

# 4. 删除系统 DLL（Win7 通常已包含）
Write-Host ""
Write-Host "[4] 删除系统 DLL..." -ForegroundColor Green
Write-Host "  (Win7 系统通常已包含这些 DLL)" -ForegroundColor Gray

$systemDlls = @(
    "advapi32.dll", "comctl32.dll", "comdlg32.dll", "gdi32.dll",
    "imm32.dll", "kernel32.dll", "msimg32.dll", "netapi32.dll",
    "ole32.dll", "oleacc.dll", "oleaut32.dll", "rpcrt4.dll",
    "shell32.dll", "shlwapi.dll", "user32.dll", "version.dll",
    "winmm.dll", "ws2_32.dll", "winspool.drv"
)

foreach ($dll in $systemDlls) {
    $path = Join-Path $NodeDir $dll
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        Remove-Item $path -Force
        $removed += $dll
        $savedSpace += $size
        Write-Host "  ✓ 已删除 $dll" -ForegroundColor Gray
    }
}

# 5. 计算清理后大小
Write-Host ""
Write-Host "[5] 清理完成" -ForegroundColor Green
$afterSize = (Get-ChildItem $NodeDir -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
$saved = $beforeSize - $afterSize

Write-Host ""
Write-Host "=== 清理结果 ===" -ForegroundColor Cyan
Write-Host "清理前: $([math]::Round($beforeSize, 2)) MB" -ForegroundColor Yellow
Write-Host "清理后: $([math]::Round($afterSize, 2)) MB" -ForegroundColor Green
Write-Host "节省空间: $([math]::Round($saved, 2)) MB" -ForegroundColor Green
Write-Host "删除文件数: $($removed.Count)" -ForegroundColor White
Write-Host ""
Write-Host "保留的关键文件:" -ForegroundColor Cyan
Write-Host "  ✓ node.exe" -ForegroundColor White
Write-Host "  ✓ npm, npx" -ForegroundColor White
Write-Host "  ✓ typescript-language-server" -ForegroundColor White
Write-Host "  ✓ html-languageserver, css-languageserver" -ForegroundColor White
Write-Host "  ✓ node_modules/" -ForegroundColor White
Write-Host "  ✓ msvcp140.dll, vcruntime140.dll (运行时必需)" -ForegroundColor White
