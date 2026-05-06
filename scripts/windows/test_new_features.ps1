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
