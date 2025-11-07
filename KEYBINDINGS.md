# Vim 快捷键提示 (Leader = Space)

## 🚀 基础操作
| 快捷键 | 功能 |
|--------|------|
| `<leader>w` | 保存文件 |
| `<leader>q` | 退出 |
| `<leader>Q` | 强制退出所有 |
| `<leader>x` | 保存并退出 |
| `<leader>h` | 清除搜索高亮 |

## 📂 文件浏览
| 快捷键 | 功能 |
|--------|------|
| `<leader>e` | 打开/关闭 NERDTree |
| `<leader>nf` | 在 NERDTree 中定位当前文件 |
| `<leader>ff` | FZF 搜索文件 |
| `<leader>fg` | FZF 全文搜索 (Ripgrep) |
| `<leader>fb` | FZF 搜索 Buffer |
| `<leader>fh` | FZF 搜索帮助文档 |

## 🪟 窗口管理
| 快捷键 | 功能 |
|--------|------|
| `Ctrl+h/j/k/l` | 切换到左/下/上/右窗口 |
| `<leader>=` | 平衡所有窗口大小 |
| `<leader>-` | 减小窗口高度 |
| `<leader>+` | 增加窗口高度 |
| `<leader><` | 减小窗口宽度 |
| `<leader>>` | 增加窗口宽度 |

## 📑 Buffer 管理
| 快捷键 | 功能 |
|--------|------|
| `<leader>bn` | 下一个 Buffer |
| `<leader>bp` | 上一个 Buffer |
| `<leader>bd` | 删除当前 Buffer |

## 🗂️ Tab 管理
| 快捷键 | 功能 |
|--------|------|
| `<leader>tn` | 新建标签页 |
| `<leader>tc` | 关闭标签页 |
| `<leader>to` | 只保留当前标签页 |
| `<leader>tj` | 下一个标签页 |
| `<leader>tk` | 上一个标签页 |

## ⚡ 快速移动
| 快捷键 | 功能 |
|--------|------|
| `J` | 向下移动 5 行 |
| `K` | 向上移动 5 行 |
| `H` | 跳转到行首 |
| `L` | 跳转到行尾 |
| `s{char}{char}` | EasyMotion 双字符搜索跳转 |
| `<leader>j` | EasyMotion 向下跳转 |
| `<leader>k` | EasyMotion 向上跳转 |

## ✏️ 编辑增强
| 快捷键 | 功能 |
|--------|------|
| `Alt+j` | 向下移动当前行 |
| `Alt+k` | 向上移动当前行 |
| `>` (可视模式) | 缩进并保持选择 |
| `<` (可视模式) | 反缩进并保持选择 |
| `p` (可视模式) | 粘贴不覆盖寄存器 |
| `gc` | 注释/取消注释 |
| `ga` | 对齐工具 (EasyAlign) |
| `ys{motion}{char}` | 添加包围符 (surround) |
| `ds{char}` | 删除包围符 |
| `cs{old}{new}` | 替换包围符 |

## 🔍 LSP / Coc.nvim
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `gi` | 跳转到实现 |
| `gy` | 跳转到类型定义 |
| `K` | 显示悬浮文档 |
| `<leader>rn` | 重命名符号 |
| `<leader>ca` | 代码操作 |
| `<leader>a` | 选中区域代码操作 (可视模式) |
| `<leader>f` | 格式化代码 |
| `[d` | 上一个诊断 |
| `]d` | 下一个诊断 |
| `Tab` | 补全菜单下一项 (插入模式) |
| `Shift+Tab` | 补全菜单上一项 (插入模式) |
| `Enter` | 确认补全 (插入模式) |

## 🐛 调试 (Vimspector)
| 快捷键 | 功能 |
|--------|------|
| `F5` | 继续/启动调试 |
| `F3` | 停止调试 |
| `F4` | 重启调试 |
| `F6` | 暂停 |
| `F9` | 切换断点 |
| `F10` | 单步跨越 |
| `F11` | 单步进入 |
| `F12` | 单步跳出 |
| `<leader>du` | 切换调试 UI |
| `<leader>dr` | 重置 Vimspector |

## 🔨 CMake
| 快捷键 | 功能 |
|--------|------|
| `<leader>cg` | CMake 生成构建文件 |
| `<leader>cb` | CMake 构建项目 |
| `<leader>cr` | CMake 运行 |
| `<leader>ct` | 选择构建类型 |

## 🌳 Git (Fugitive)
| 命令 | 功能 |
|------|------|
| `:Git` / `:G` | Git 状态 |
| `:Git blame` | Git 责任归属 |
| `:Git diff` | Git 差异 |
| `:Git log` | Git 日志 |
| `:Gwrite` | Git add 当前文件 |
| `:Gread` | Git checkout 当前文件 |

## ⏮️ 撤销历史
| 快捷键 | 功能 |
|--------|------|
| `<leader>u` | 打开 UndoTree |
| `u` | 撤销 |
| `Ctrl+r` | 重做 |

## 💡 其他实用功能
- **持久化撤销**: 关闭文件后仍可撤销
- **自动删除行尾空格**: 保存时自动清理
- **多光标编辑**: 按 `Ctrl+n` 选中单词，继续按添加下一个
- **文件类型智能缩进**: Python/C/C++ 自动 4 空格，Go 使用 Tab
- **WSL 剪贴板集成**: 自动与 Windows 剪贴板同步

## 📚 学习资源
- `:help {command}` - 查看帮助文档
- `:Tutor` - Vim 内置教程
- `:CocCommand` - 查看 Coc 可用命令
- `:PlugStatus` - 查看插件状态
- `:PlugInstall` - 安装插件
- `:PlugUpdate` - 更新插件
