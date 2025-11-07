# Vimspector 调试 UI 快速修复指南

## 🐛 问题：调试窗口不显示

### ✅ 立即测试（5 步骤）

1. **安装 Vimspector 适配器**
```bash
vim
:PlugInstall
:VimspectorInstall debugpy
```

2. **打开测试文件**
```bash
cd /tmp
vim test_debug.py
```

3. **设置断点**
```vim
" 跳到第 4 行
:4
" 按 F9 设置断点
F9
```

4. **启动调试**
```vim
" 按 F5 启动
F5
" 选择 "Python - Launch"
```

5. **如果 UI 没有自动显示**
```vim
" 手动打开
:call vimspector#ShowOutput('Console')
:call vimspector#ShowOutput('Telemetry')
```

## 🔧 常见问题解决

### 问题 1：没有任何窗口打开

**原因**：Vimspector 映射模式可能不正确

**解决**：
```vim
" 在调试前执行
:let g:vimspector_enable_mappings = 'HUMAN'

" 然后启动调试
F5
```

### 问题 2：只显示代码窗口，没有变量窗口

**原因**：需要手动打开侧边栏

**解决**：
```vim
" 按 Space + d + u
<Space>du

" 或手动执行
:VimspectorShowOutput Variables
:VimspectorShowOutput StackTrace
:VimspectorShowOutput Console
```

### 问题 3：UI 布局混乱

**原因**：窗口配置问题

**解决**：重置 Vimspector
```vim
:VimspectorReset
F5  " 重新启动
```

## 📋 调试 UI 手动打开命令

如果自动 UI 不工作，使用这些命令手动打开：

```vim
" 显示变量窗口
:VimspectorShowOutput Variables

" 显示调用栈
:VimspectorShowOutput StackTrace

" 显示控制台
:VimspectorShowOutput Console

" 显示监视窗口
:VimspectorShowOutput Watches

" 显示所有输出
:VimspectorShowOutput
```

## 🎯 推荐的调试工作流

### 步骤 1：准备工作

```bash
# 进入项目目录
cd /tmp

# 打开 Vim
vim test_debug.py
```

### 步骤 2：设置断点

```vim
" 移动到要设置断点的行
:4

" 按 F9（或 Space + d + u）
F9
```

### 步骤 3：启动调试

```vim
" 方式 1：使用 F5
F5

" 方式 2：使用命令
:call vimspector#Launch()

" 方式 3：使用 Leader 键
<Space>dc
```

### 步骤 4：查看 UI

```vim
" 如果 UI 没有自动显示，执行：
:VimspectorShowOutput Variables
:VimspectorShowOutput Console
```

### 步骤 5：调试操作

```
F5  - 继续执行
F10 - 单步跨越（不进入函数）
F11 - 单步进入（进入函数）
F12 - 单步跳出（退出函数）
F9  - 切换断点
F3  - 停止调试
```

## 🛠️ 如果还是不行

### 检查清单

- [ ] Vimspector 已安装：`:PlugStatus` 查看
- [ ] 适配器已安装：`:VimspectorInstall debugpy`
- [ ] 配置文件正确：`.vimspector.json` 存在
- [ ] 启用了 HUMAN 映射：`let g:vimspector_enable_mappings = 'HUMAN'`
- [ ] 尝试手动打开 UI：`:VimspectorShowOutput Variables`

### 完整重新安装

```vim
" 1. 重新安装插件
:PlugClean
:PlugInstall

" 2. 安装适配器
:VimspectorInstall debugpy vscode-cpptools

" 3. 重启 Vim
:qa
vim test_debug.py

" 4. 设置断点并启动
:4
F9
F5
```

## 📝 最小可用配置

如果你想要最简单的配置，在项目目录创建 `.vimspector.json`：

```json
{
  "configurations": {
    "Launch": {
      "adapter": "debugpy",
      "configuration": {
        "request": "launch",
        "program": "${file}"
      }
    }
  }
}
```

## 💡 调试技巧

### 1. 使用日志查看问题

```vim
" 启用详细日志
:let g:vimspector_log_to_file = 1

" 查看日志
:VimspectorShowOutput Telemetry
```

### 2. 强制打开所有窗口

创建一个自定义函数：

```vim
function! OpenDebugUI()
  call vimspector#ShowOutput('Console')
  call vimspector#ShowOutput('Variables')
  call vimspector#ShowOutput('StackTrace')
  call vimspector#ShowOutput('Watches')
endfunction

" 使用
:call OpenDebugUI()
```

### 3. 使用简单的调试配置

不使用 `.vimspector.json`，直接在 Vim 中：

```vim
" Python 调试
:VimspectorDebug python ${file}
```

## 🎬 完整演示流程

```bash
# 1. 打开测试文件
vim /tmp/test_debug.py

# 在 Vim 中：
:PlugInstall                    # 确保插件安装
:VimspectorInstall debugpy      # 安装 Python 调试器

# 2. 设置断点
:4                              # 跳到第 4 行
F9                              # 设置断点（应该看到断点标记）

# 3. 启动调试
F5                              # 启动（选择配置）

# 4. 如果 UI 不显示
:VimspectorShowOutput Variables
:VimspectorShowOutput Console

# 5. 调试
F10                             # 单步执行
F11                             # 进入函数
F5                              # 继续
F3                              # 停止
```

## 📞 需要更多帮助？

如果以上都不行，请告诉我：

1. `:PlugStatus` 的输出（Vimspector 那一行）
2. `:VimspectorInstall` 执行后的结果
3. 按 F5 后看到什么？（有没有错误信息）
4. `:messages` 显示什么？

我会根据具体情况帮你解决！

---

**快速测试命令**：
```bash
cd /tmp && vim test_debug.py
# 然后在 Vim 中：:4, F9, F5
```
