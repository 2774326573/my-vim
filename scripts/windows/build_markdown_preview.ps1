# 构建 markdown-preview.nvim 插件
# 适用于 Win7 离线环境，使用 Node.js 12

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "构建 markdown-preview.nvim" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# 设置路径
$repoRoot = "C:\Users\jinxi\my-vim"
$pluginPath = Join-Path $repoRoot "data\plugged\markdown-preview.nvim"
$appPath = Join-Path $pluginPath "app"
$nodePath = Join-Path $repoRoot "tools\node"
$nodeExe = Join-Path $nodePath "node.exe"
$npxCli = Join-Path $nodePath "node_modules\npm\bin\npx-cli.js"

# 检查插件
Write-Host "`n[1/4] 检查插件目录..." -ForegroundColor Yellow
if (!(Test-Path $pluginPath)) {
    Write-Host "✗ 插件未安装！" -ForegroundColor Red
    Write-Host "  请先在 Vim 中执行: :PlugInstall" -ForegroundColor Yellow
    Write-Host "  或执行: vim +PlugInstall +qall" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ 插件目录存在: $pluginPath" -ForegroundColor Green

# 检查 app 目录
Write-Host "`n[2/4] 检查 app 目录..." -ForegroundColor Yellow
if (!(Test-Path $appPath)) {
    Write-Host "✗ app 目录不存在！" -ForegroundColor Red
    Write-Host "  插件可能未完整安装" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ app 目录存在" -ForegroundColor Green

# 检查 Node.js
Write-Host "`n[3/4] 检查 Node.js..." -ForegroundColor Yellow
if (!(Test-Path $nodeExe)) {
    Write-Host "✗ Node.js 未找到！" -ForegroundColor Red
    exit 1
}

$nodeVersion = & $nodeExe --version 2>&1
Write-Host "✓ Node.js 版本: $nodeVersion" -ForegroundColor Green

# 构建插件
Write-Host "`n[4/4] 开始构建..." -ForegroundColor Yellow
Write-Host "命令: npx --yes yarn install" -ForegroundColor Gray
Write-Host "位置: $appPath" -ForegroundColor Gray
Write-Host ""

# 设置环境变量
$env:PATH = "$nodePath;$env:PATH"

# 切换到 app 目录
Push-Location $appPath

try {
    # 执行构建
    & $nodeExe $npxCli --yes yarn install 2>&1 | ForEach-Object {
        Write-Host $_ -ForegroundColor Gray
    }
    
    $exitCode = $LASTEXITCODE
    
    if ($exitCode -eq 0) {
        Write-Host "`n=====================================" -ForegroundColor Green
        Write-Host "✓ 构建成功！" -ForegroundColor Green
        Write-Host "=====================================" -ForegroundColor Green
        
        Write-Host "`n使用方法:" -ForegroundColor Cyan
        Write-Host "1. 在 Vim 中打开 Markdown 文件: :e test.md"
        Write-Host "2. 按 \mp 或执行: :MarkdownPreview"
        Write-Host "3. 浏览器将自动打开预览"
        Write-Host "4. 按 \ms 停止预览: :MarkdownPreviewStop"
        
    } else {
        Write-Host "`n=====================================" -ForegroundColor Red
        Write-Host "✗ 构建失败！退出码: $exitCode" -ForegroundColor Red
        Write-Host "=====================================" -ForegroundColor Red
        exit $exitCode
    }
} finally {
    Pop-Location
}
