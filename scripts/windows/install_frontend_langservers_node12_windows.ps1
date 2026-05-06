# Win7 环境 - 兼容 Node.js 12 的前端语言服务器安装脚本
# 安装与 Node 12 兼容的旧版本语言服务器

param(
    [string]$NodePath = "",
    [switch]$Help
)

if ($Help) {
    Write-Host @"
Win7 环境 - Node.js 12 兼容版前端语言服务器安装

用法:
  .\install_frontend_langservers_node12_windows.ps1 [-NodePath <path>]

说明:
  此脚本安装与 Node.js 12 兼容的旧版本语言服务器：
  - vscode-html-languageserver-bin@1.4.0 (HTML)
  - vscode-css-languageserver-bin@1.4.0 (CSS/SCSS/LESS)
  - typescript-language-server@0.5.1 (JavaScript/TypeScript)
  - typescript@4.3.5 (TypeScript 编译器)

  这些版本已验证可在 Node.js 12 上稳定运行。

示例:
  .\install_frontend_langservers_node12_windows.ps1
"@
    exit 0
}

# 获取仓库根目录
$scriptDir = Split-Path -Parent $PSCommandPath
$repoRoot = Split-Path -Parent (Split-Path -Parent $scriptDir)

# 确定 Node 路径
if ([string]::IsNullOrWhiteSpace($NodePath)) {
    $NodePath = Join-Path $repoRoot "tools\node\node.exe"
}

if (-not (Test-Path $NodePath)) {
    Write-Host "错误: 未找到 Node.js: $NodePath" -ForegroundColor Red
    Write-Host "请先下载 Node.js 12.22.12 并解压到 tools\node\" -ForegroundColor Yellow
    Write-Host "下载地址: https://nodejs.org/dist/v12.22.12/node-v12.22.12-win-x64.zip" -ForegroundColor Cyan
    exit 1
}

$nodeDir = Split-Path -Parent $NodePath
$npmCmd = Join-Path $nodeDir "npm.cmd"

if (-not (Test-Path $npmCmd)) {
    Write-Host "错误: 未找到 npm: $npmCmd" -ForegroundColor Red
    exit 1
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Win7 - Node.js 12 兼容版语言服务器安装" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 检查 Node 版本
try {
    $nodeVersion = & $NodePath --version
    Write-Host "Node.js: $nodeVersion" -ForegroundColor Green
    
    if ($nodeVersion -notmatch "v12\.") {
        Write-Host "警告: 检测到 Node $nodeVersion" -ForegroundColor Yellow
        Write-Host "  此脚本针对 Node 12 优化，其他版本可能不兼容" -ForegroundColor Yellow
        Write-Host ""
        $continue = Read-Host "是否继续? (y/N)"
        if ($continue -ne "y" -and $continue -ne "Y") {
            Write-Host "已取消安装" -ForegroundColor Yellow
            exit 0
        }
    }
} catch {
    Write-Host "警告: 无法获取 Node 版本" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "安装目录: $nodeDir" -ForegroundColor Green
Write-Host ""

# 设置工作目录
Push-Location $nodeDir

try {
    Write-Host "正在安装 Node.js 12 兼容版语言服务器..." -ForegroundColor Cyan
    Write-Host ""

    # Node 12 兼容的语言服务器版本
    $packages = @(
        @{name="vscode-html-languageserver-bin"; version="1.4.0"; desc="HTML"},
        @{name="vscode-css-languageserver-bin"; version="1.4.0"; desc="CSS/SCSS/LESS"},
        @{name="typescript-language-server"; version="0.5.1"; desc="JavaScript/TypeScript"},
        @{name="typescript"; version="4.3.5"; desc="TypeScript 编译器"}
    )

    $success = 0
    $failed = 0

    foreach ($pkg in $packages) {
        $fullName = "$($pkg.name)@$($pkg.version)"
        Write-Host "► 安装 $fullName ($($pkg.desc))..." -ForegroundColor Yellow
        
        try {
            $output = & $npmCmd install $fullName --no-save 2>&1 | Out-String
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ 安装成功" -ForegroundColor Green
                $success++
            } else {
                Write-Host "  ✗ 安装失败" -ForegroundColor Red
                if ($output) {
                    Write-Host "  错误信息: $($output.Substring(0, [Math]::Min(200, $output.Length)))" -ForegroundColor Red
                }
                $failed++
            }
        } catch {
            Write-Host "  ✗ 安装异常: $_" -ForegroundColor Red
            $failed++
        }
        Write-Host ""
    }

    Write-Host "================================================" -ForegroundColor Cyan
    if ($failed -eq 0) {
        Write-Host "✓ 所有语言服务器安装成功！" -ForegroundColor Green
    } else {
        Write-Host "安装完成: $success 成功, $failed 失败" -ForegroundColor Yellow
    }
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""

    # 验证安装
    Write-Host "验证安装结果..." -ForegroundColor Cyan
    Write-Host ""

    $verifyPaths = @(
        @{path="node_modules\vscode-html-languageserver-bin\bin\vscode-html-languageserver"; name="HTML Server"},
        @{path="node_modules\vscode-css-languageserver-bin\bin\vscode-css-languageserver"; name="CSS Server"},
        @{path="node_modules\typescript-language-server\lib\cli.js"; name="TS Server"},
        @{path="node_modules\typescript\bin\tsc"; name="TypeScript"}
    )

    foreach ($item in $verifyPaths) {
        $fullPath = Join-Path $nodeDir $item.path
        if (Test-Path $fullPath) {
            Write-Host "  ✓ $($item.name)" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $($item.name) - 未找到" -ForegroundColor Red
        }
    }

    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "下一步操作:" -ForegroundColor Yellow
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. 更新 Vim 配置以使用旧版本服务器" -ForegroundColor White
    Write-Host "   运行: .\scripts\windows\update_vim_config_for_node12_windows.ps1" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "2. 在 Vim 中安装前端插件" -ForegroundColor White
    Write-Host "   :PlugInstall" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "3. 打开 HTML/CSS/JS 文件测试" -ForegroundColor White
    Write-Host "   :e test.html" -ForegroundColor Cyan
    Write-Host "   :LspStatus" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "离线部署:" -ForegroundColor Yellow
    Write-Host "  将整个 tools\node 目录拷贝到 Win7 目标机器" -ForegroundColor White
    Write-Host ""

} catch {
    Write-Host "错误: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}
