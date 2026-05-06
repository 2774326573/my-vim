#!/usr/bin/env pwsh
# 安装新增的插件并验证

$ErrorActionPreference = "Stop"
$VimRoot = "C:\Users\jinxi\my-vim"

Write-Host "=== 安装新增插件 ===" -ForegroundColor Cyan
Write-Host ""

# 列出新增插件
$newPlugins = @(
    "luochen1990/rainbow - 彩虹括号",
    "Yggdroot/indentLine - 缩进线",
    "kshenoy/vim-signature - 标记可视化",
    "tpope/vim-dadbod - 数据库接口",
    "kristijanhusak/vim-dadbod-ui - 数据库UI",
    "kristijanhusak/vim-dadbod-completion - 数据库补全"
)

Write-Host "新增插件列表:" -ForegroundColor Yellow
foreach ($plugin in $newPlugins) {
    Write-Host "  ✓ $plugin" -ForegroundColor Green
}
Write-Host ""

Write-Host "新增功能:" -ForegroundColor Yellow
Write-Host "  ✓ 彩虹括号 - 不同层级括号显示不同颜色" -ForegroundColor Green
Write-Host "  ✓ 缩进线 - 显示代码缩进层级" -ForegroundColor Green
Write-Host "  ✓ 代码折叠 - 使用 <Space>zz 切换折叠" -ForegroundColor Green
Write-Host "  ✓ 数据库支持 - <Space>db 打开数据库UI" -ForegroundColor Green
Write-Host "  ✓ UltiSnips优化 - 使用Tab展开代码片段" -ForegroundColor Green
Write-Host ""

Write-Host "安装命令:" -ForegroundColor Cyan
Write-Host "  在 Vim 中执行: :PlugInstall" -ForegroundColor White
Write-Host ""

# 创建快速启动脚本
$quickStart = @"
@echo off
cd /d %~dp0..\..
echo === 启动 Vim 并安装新插件 ===
echo.
echo 步骤:
echo 1. Vim 启动后会自动进入命令模式
echo 2. 输入 :PlugInstall 并回车
echo 3. 等待插件安装完成
echo 4. 输入 :q 关闭安装窗口
echo 5. 重启 Vim
echo.
pause
tools\vim\vim.exe -Nu _vimrc
"@
$quickStart | Set-Content "$VimRoot\scripts\windows\install_new_plugins.cmd" -Encoding ASCII

Write-Host "快速安装:" -ForegroundColor Cyan
Write-Host "  运行: scripts\windows\install_new_plugins.cmd" -ForegroundColor White
Write-Host ""

# 创建功能测试文件
$testFeatures = @"
#!/usr/bin/env pwsh
# 测试新增功能

Write-Host "=== 功能测试指南 ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "[1] 彩虹括号测试" -ForegroundColor Green
Write-Host "  打开任意代码文件，括号应显示不同颜色" -ForegroundColor White
Write-Host "  切换: :RainbowToggle" -ForegroundColor Gray
Write-Host ""

Write-Host "[2] 缩进线测试" -ForegroundColor Green
Write-Host "  打开 Python/C++ 文件，应看到垂直缩进线" -ForegroundColor White
Write-Host "  切换: :IndentLinesToggle" -ForegroundColor Gray
Write-Host ""

Write-Host "[3] 代码折叠测试" -ForegroundColor Green
Write-Host "  快捷键:" -ForegroundColor White
Write-Host "    <Space>zz - 切换当前折叠" -ForegroundColor Gray
Write-Host "    <Space>zm - 关闭所有折叠" -ForegroundColor Gray
Write-Host "    <Space>zr - 打开所有折叠" -ForegroundColor Gray
Write-Host "    <Leader>uf - 切换折叠功能" -ForegroundColor Gray
Write-Host ""

Write-Host "[4] UltiSnips 测试" -ForegroundColor Green
Write-Host "  1. 打开 .cpp 文件" -ForegroundColor White
Write-Host "  2. 输入 'main' 然后按 Tab" -ForegroundColor White
Write-Host "  3. 应该展开为 main 函数模板" -ForegroundColor White
Write-Host "  4. 使用 Tab/Shift+Tab 在占位符间跳转" -ForegroundColor White
Write-Host ""

Write-Host "[5] 数据库插件测试" -ForegroundColor Green
Write-Host "  1. 按 <Space>db 打开数据库UI" -ForegroundColor White
Write-Host "  2. 按 <Space>dba 添加连接" -ForegroundColor White
Write-Host "  示例: sqlite:///test.db" -ForegroundColor Gray
Write-Host ""

Write-Host "查看完整文档:" -ForegroundColor Cyan
Write-Host "  docs\数据库插件使用指南.md" -ForegroundColor White
"@
$testFeatures | Set-Content "$VimRoot\scripts\windows\test_new_features.ps1" -Encoding UTF8

Write-Host "测试脚本已创建: scripts\windows\test_new_features.ps1" -ForegroundColor Green
