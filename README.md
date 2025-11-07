# Vim 配置 (LazyVim 风格)

现代化的 Vim 配置，融合了 LazyVim 的优秀设计理念，支持 LSP、调试、Git 集成等功能。

## ✨ 特性

- 🎨 **多主题支持**: TokyoNight, Catppuccin, OneDark, Dracula, Kanagawa
- 📝 **中文文档**: 完整的中文帮助系统和快捷键文档
- ⚡ **LSP 支持**: 基于 coc.nvim 的代码智能补全
- 🔍 **模糊查找**: FZF 快速文件查找和全文搜索
- 🐛 **调试功能**: Vimspector 图形化调试
- 🌳 **Git 集成**: Fugitive + GitGutter 完整 Git 工作流
- 🎯 **LazyVim 快捷键**: 现代化的快捷键映射
- 📚 **快捷键提示**: Which-Key 实时提示

## 🚀 快速开始

### 安装

1. 确保已安装 Vim 和 Node.js：
```bash
# Ubuntu/Debian
sudo apt install vim nodejs npm ripgrep

# macOS
brew install vim node ripgrep
```

2. 配置已经就绪，只需安装插件：
```bash
vim
# 在 Vim 中执行
:PlugInstall
```

3. 安装语言服务器（可选）：
```vim
:CocInstall coc-pyright coc-tsserver coc-json coc-clangd
```

### 或使用安装脚本

```bash
~/vimfiles/install.sh
```

## 📖 文档

- **完整快捷键指南**: [快捷键指南.md](./快捷键指南.md)
- **速查卡**: [速查卡.md](./速查卡.md)
- **英文版**: [KEYBINDINGS.md](./KEYBINDINGS.md)

### 快速查看
```bash
# 查看速查卡
cat ~/vimfiles/速查卡.md

# 查看完整指南
cat ~/vimfiles/快捷键指南.md

# 在 Vim 中查看
vim ~/vimfiles/快捷键指南.md
```

## ⌨️ 核心快捷键

**Leader 键 = 空格 (Space)**

### 最常用操作
| 快捷键 | 功能 | 快捷键 | 功能 |
|--------|------|--------|------|
| `<leader>w` | 保存 | `<leader>q` | 退出 |
| `<leader>e` | 文件树 | `<leader>ff` | 查找文件 |
| `<leader>fg` | 全文搜索 | `Shift+h/l` | 切换 Buffer |
| `gd` | 跳转定义 | `gr` | 查找引用 |
| `K` | 文档 | `<leader>ca` | 代码操作 |
| `gcc` | 注释 | `<leader>cf` | 格式化 |

更多快捷键请查看 [速查卡.md](./速查卡.md)

## 🎨 主题切换

配置包含多个精美主题，默认使用 TokyoNight：

```vim
:ThemeTokyoNight    " Tokyo Night (默认)
:ThemeCatppuccin    " Catppuccin Latte
:ThemeOneDark       " OneDark
:ThemeDracula       " Dracula
:ThemeKanagawa      " Kanagawa
```

要更改默认主题，编辑 `~/vimfiles/config.vim`：
```vim
silent! colorscheme tokyonight  " 改成你喜欢的主题
```

## 🔧 配置结构

```
~/.vimrc                  # 主配置文件
~/vimfiles/
├── plugins.vim           # 插件列表
├── config.vim            # 核心配置和快捷键
├── 快捷键指南.md         # 完整中文文档
├── 速查卡.md             # 快速参考
├── KEYBINDINGS.md        # 英文文档
└── install.sh            # 安装脚本
```

## 📦 插件列表

### 核心功能
- **vim-plug**: 插件管理器
- **coc.nvim**: LSP 客户端
- **fzf / fzf.vim**: 模糊查找
- **NERDTree**: 文件树浏览器

### 编辑增强
- **vim-surround**: 包围符操作
- **vim-commentary**: 快速注释
- **auto-pairs**: 自动配对括号
- **vim-easy-align**: 对齐工具
- **vim-visual-multi**: 多光标编辑
- **targets.vim**: 增强文本对象

### Git 集成
- **vim-fugitive**: Git 命令集成
- **vim-gitgutter**: Git 更改实时显示

### 导航与移动
- **vim-easymotion**: 快速跳转
- **which-key.nvim**: 快捷键提示

### 主题
- **tokyonight.nvim**: Tokyo Night
- **catppuccin/vim**: Catppuccin
- **onedark.nvim**: OneDark
- **dracula.nvim**: Dracula
- **kanagawa.nvim**: Kanagawa
- **nightfox.nvim**: Nightfox
- **github-nvim-theme**: GitHub 主题

### 工具
- **undotree**: 可视化撤销历史
- **vimspector**: 调试器
- **vim-cmake**: CMake 集成
- **vimcdoc**: Vim 中文文档

## 🎯 推荐工作流

1. **打开项目**: `<leader>e` 打开文件树
2. **查找文件**: `<leader>ff` 模糊查找
3. **全文搜索**: `<leader>fg` 搜索内容
4. **代码导航**: `gd` 跳转定义，`gr` 查找引用
5. **代码编辑**: `<leader>rn` 重命名，`<leader>ca` 代码操作
6. **格式化**: `<leader>cf` 格式化代码
7. **Git 操作**: `<leader>gg` 查看状态，`<leader>gc` 提交

## 🆘 帮助

### 内置帮助
```vim
:help {topic}      " 查看帮助（支持中文）
:Tutor             " Vim 教程
:h index           " 快捷键索引
```

### Coc 帮助
```vim
:CocCommand        " Coc 命令列表
:CocConfig         " 编辑 Coc 配置
:CocList           " Coc 列表
```

### 插件管理
```vim
:PlugInstall       " 安装插件
:PlugUpdate        " 更新插件
:PlugClean         " 清理未使用的插件
:PlugStatus        " 查看插件状态
```

## 💡 技巧

### 文件类型智能缩进
- Python: 4 空格
- C/C++: 4 空格
- Go: Tab 字符
- JavaScript/HTML/CSS: 2 空格

### 自动功能
- ✅ 保存时删除行尾空格
- ✅ 持久化撤销
- ✅ WSL 剪贴板同步
- ✅ 自动补全括号
- ✅ Git 更改实时显示

## 🔗 相关资源

- [LazyVim](https://www.lazyvim.org/) - 灵感来源
- [vimcdoc](https://github.com/yianwillis/vimcdoc) - Vim 中文文档
- [coc.nvim](https://github.com/neoclide/coc.nvim) - LSP 客户端
- [vim-plug](https://github.com/junegunn/vim-plug) - 插件管理器

## 📝 自定义

### 修改 Leader 键
编辑 `~/vimfiles/config.vim`：
```vim
let mapleader=" "        " 改成你想要的键
let maplocalleader=" "
```

### 添加插件
编辑 `~/vimfiles/plugins.vim`：
```vim
call plug#begin("~/.vim/plugged")
Plug 'author/plugin-name'  " 添加这行
call plug#end()
```
然后运行 `:PlugInstall`

### 添加快捷键
编辑 `~/vimfiles/config.vim`：
```vim
nnoremap <leader>键 :命令<CR>
```

## 🤝 贡献

欢迎提出问题和建议！

## 📄 许可

MIT License

---

**享受你的 Vim 之旅！** 🎉
