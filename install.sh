#!/bin/bash
# Vim 配置自动安装脚本

set -e

echo "======================================"
echo "  Vim 配置安装脚本 (LazyVim 风格)   "
echo "======================================"
echo

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查 vim 是否安装
if ! command -v vim &> /dev/null; then
    echo -e "${RED}✗ Vim 未安装！请先安装 Vim${NC}"
    echo "  Ubuntu/Debian: sudo apt install vim"
    echo "  CentOS/RHEL:   sudo yum install vim"
    echo "  macOS:         brew install vim"
    exit 1
fi

echo -e "${GREEN}✓ Vim 已安装${NC}"
vim --version | head -n 1

# 检查 vim-plug
echo
echo "检查 vim-plug..."
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo -e "${YELLOW}→ 安装 vim-plug...${NC}"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "${GREEN}✓ vim-plug 安装完成${NC}"
else
    echo -e "${GREEN}✓ vim-plug 已安装${NC}"
fi

# 检查并安装依赖工具
echo
echo "检查依赖工具..."

# 检查 Node.js (coc.nvim 需要)
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗ Node.js 未安装 (coc.nvim 需要)${NC}"
    echo "  请安装 Node.js >= 14.14"
    echo "  Ubuntu/Debian: sudo apt install nodejs npm"
    echo "  或访问: https://nodejs.org/"
else
    echo -e "${GREEN}✓ Node.js: $(node --version)${NC}"
fi

# 检查 fzf
if ! command -v fzf &> /dev/null; then
    echo -e "${YELLOW}→ fzf 未安装，推荐安装${NC}"
    echo "  安装: git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install"
else
    echo -e "${GREEN}✓ fzf: $(fzf --version)${NC}"
fi

# 检查 ripgrep
if ! command -v rg &> /dev/null; then
    echo -e "${YELLOW}→ ripgrep 未安装，推荐安装 (用于全文搜索)${NC}"
    echo "  Ubuntu/Debian: sudo apt install ripgrep"
    echo "  macOS:         brew install ripgrep"
else
    echo -e "${GREEN}✓ ripgrep: $(rg --version | head -n 1)${NC}"
fi

# 创建必要的目录
echo
echo "创建配置目录..."
mkdir -p ~/.vim/undodir
mkdir -p ~/vimfiles
echo -e "${GREEN}✓ 目录创建完成${NC}"

# 安装插件
echo
echo "======================================"
echo "开始安装插件..."
echo "======================================"
echo
echo "请在 Vim 中执行以下命令安装插件："
echo
echo -e "${YELLOW}  :PlugInstall${NC}"
echo
echo "然后安装语言服务器 (可选)："
echo -e "${YELLOW}  :CocInstall coc-clangd coc-pyright coc-tsserver coc-json${NC}"
echo

# 显示主题切换
echo "======================================"
echo "主题切换命令："
echo "======================================"
echo "  :ThemeTokyoNight    - Tokyo Night (默认)"
echo "  :ThemeCatppuccin    - Catppuccin Latte"
echo "  :ThemeOneDark       - OneDark"
echo "  :ThemeDracula       - Dracula"
echo "  :ThemeKanagawa      - Kanagawa"
echo

# 显示文档位置
echo "======================================"
echo "文档位置："
echo "======================================"
echo "  完整指南: ~/vimfiles/快捷键指南.md"
echo "  速查卡:   ~/vimfiles/速查卡.md"
echo
echo "  查看方式: cat ~/vimfiles/快捷键指南.md"
echo "           vim ~/vimfiles/快捷键指南.md"
echo

# 显示下一步
echo "======================================"
echo "下一步操作："
echo "======================================"
echo "1. 打开 Vim: vim"
echo "2. 安装插件: :PlugInstall"
echo "3. 等待安装完成（可能需要几分钟）"
echo "4. 重启 Vim"
echo "5. 安装语言服务器: :CocInstall coc-pyright coc-tsserver"
echo "6. 查看快捷键: cat ~/vimfiles/速查卡.md"
echo
echo -e "${GREEN}✓ 配置文件已就绪！${NC}"
echo

# 快速测试
echo "======================================"
echo "快速测试 (按 Enter 继续，Ctrl+C 跳过)："
read -p ""
vim -c "echo '测试 Vim 配置...' | PlugStatus" || true

echo
echo -e "${GREEN}安装完成！享受你的 Vim 之旅！${NC} 🎉"
