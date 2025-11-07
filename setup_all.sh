#!/usr/bin/env bash
set -euo pipefail

# ==========================================
#   WSL Ubuntu 一键开发环境 & 编辑器栈安装
#   - zsh + Oh My Zsh + powerlevel10k
#   - zsh-autosuggestions / zsh-syntax-highlighting / fzf / zoxide / neofetch
#   - neovim, vim, clang/clangd, cmake, gdb, python3/pip/venv, lua5.4
#   - nvm + Node.js LTS
#   - ❌ 不再安装 VS Code CLI
#   - ✅ 安装 Claude CLI（保留）
#   - ✅ 安装 Codex CLI（新增）
#   - vim-plug + copilot.vim
#   - my-vim（~/.vim）与 nvim（~/.config/nvim）配置自动拉取
#   - 写入完整 ~/.zshrc（WSL 增强 + Vim 键位 + 光标/标题栏指示）
# ==========================================

# ---- 0) 预检 ----
if ! command -v apt >/dev/null 2>&1; then
  echo "❌ 需要 Ubuntu/Debian (apt)。"; exit 1
fi
if ! grep -qi microsoft /proc/version 2>/dev/null; then
  echo "⚠️ 非 WSL 环境可继续使用，WSL 专属增强将部分失效。"
fi
mkdir -p "$HOME/.config" "$HOME/.local/bin"

# ---- 1) 基础更新 & 软件安装 ----
sudo apt update
sudo apt -y install \
  ca-certificates gnupg lsb-release software-properties-common \
  build-essential git curl wget unzip tar \
  zsh neofetch fzf ripgrep fd-find bat lsd btop zoxide \
  vim neovim \
  clang clangd cmake gdb pkg-config \
  python3 python3-pip python3-venv \
  lua5.4

# ---- 2) Oh My Zsh ----
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ---- 3) powerlevel10k 主题 ----
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# ---- 4) zsh 插件 ----
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# ---- 5) nvm + Node LTS ----
if ! command -v nvm >/dev/null 2>&1; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi
bash -lc '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install --lts
nvm alias default "lts/*"
'

# ---- 6) 安装 my-vim 与 nvim 配置 ----
echo "📦 拉取 my-vim 与 nvim 配置……"
# Vim -> ~/.vim
if [ -d "$HOME/.vim/.git" ]; then
  git -C "$HOME/.vim" pull --ff-only || true
else
  if [ -d "$HOME/.vim" ] && [ "$(ls -A "$HOME/.vim" | wc -l)" -ne 0 ]; then
    mv "$HOME/.vim" "$HOME/.vim.bak.$(date +%Y%m%d-%H%M%S)"
  fi
  git clone https://github.com/2774326573/my-vim.git "$HOME/.vim"
fi
# 链接 .vimrc（若仓库提供）
if [ -f "$HOME/.vim/.vimrc" ] && [ ! -e "$HOME/.vimrc" ]; then
  ln -s "$HOME/.vim/.vimrc" "$HOME/.vimrc"
fi
# Neovim -> ~/.config/nvim
NVIM_DIR="$HOME/.config/nvim"
if [ -d "$NVIM_DIR/.git" ]; then
  git -C "$NVIM_DIR" pull --ff-only || true
else
  if [ -d "$NVIM_DIR" ] && [ "$(ls -A "$NVIM_DIR" | wc -l)" -ne 0 ]; then
    mv "$NVIM_DIR" "$NVIM_DIR.bak.$(date +%Y%m%d-%H%M%S)"
  fi
  git clone https://github.com/2774326573/nvim.git "$NVIM_DIR"
fi

# ---- 7) 安装 vim-plug（Vim/Neovim）----
mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/plugged"
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  -o "$HOME/.vim/autoload/plug.vim"
mkdir -p "$HOME/.local/share/nvim/site/autoload"
curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
  -o "$HOME/.local/share/nvim/site/autoload/plug.vim"

# ---- 8) 安装 copilot.vim（pack 方式保证启用）----
if [ ! -d "$HOME/.vim/pack/copilot/start/copilot.vim" ]; then
  mkdir -p "$HOME/.vim/pack/copilot/start"
  git clone https://github.com/github/copilot.vim "$HOME/.vim/pack/copilot/start/copilot.vim"
else
  git -C "$HOME/.vim/pack/copilot/start/copilot.vim" pull --ff-only || true
fi
if [ ! -d "$HOME/.local/share/nvim/site/pack/copilot/start/copilot.vim" ]; then
  mkdir -p "$HOME/.local/share/nvim/site/pack/copilot/start"
  git clone https://github.com/github/copilot.vim "$HOME/.local/share/nvim/site/pack/copilot/start/copilot.vim"
else
  git -C "$HOME/.local/share/nvim/site/pack/copilot/start/copilot.vim" pull --ff-only || true
fi

# ---- 9) 写入 ~/.zshrc（备份后覆盖）----
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
  cp -f "$ZSHRC" "$ZSHRC.bak.$(date +%Y%m%d-%H%M%S)"
fi
cat > "$ZSHRC" <<"EOF"
# ===================== 🔕 关闭终端响铃 =====================
setopt NO_BEEP
unsetopt BEEP

# ===================== 🌈 基础设置（WSL 优化） =====================
export ZDOTDIR="$HOME"
export LANG="en_US.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
export LANGUAGE="zh_CN.UTF-8"

# Oh My Zsh 路径 & 主题
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# 常用路径优先
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ===================== ⚙️ 插件（WSL/开发常用） =====================
plugins=(
  git
  web-search
  extract
  sudo
  colored-man-pages
  command-not-found
  ssh-agent
  z
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source "$ZSH/oh-my-zsh.sh"

# ssh-agent 插件配置
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_ed25519 id_rsa

# ===================== 🌐 WSL 专属增强 =====================
if grep -qi microsoft /proc/version 2>/dev/null; then
  open_command() { cmd.exe /C start "$1" >/dev/null 2>&1; }
else
  open_command() { xdg-open "$1" >/dev/null 2>&1 & }
fi

alias open.='explorer.exe .'
open() {
  local target="${1:-.}"
  if [[ "$target" =~ ^https?:// ]]; then
    open_command "$target"
  else
    local winp; winp="$(wslpath -w "$target" 2>/dev/null || printf "%s" "$target")"
    explorer.exe "$winp" >/dev/null 2>&1
  fi
}
pbcopy()  { clip.exe; }
pbpaste() { powershell.exe -NoProfile -Command "Get-Clipboard" | tr -d '\r'; }
winpath()   { wslpath -w "${1:-.}"; }
linuxpath() { wslpath -u "${1:-.}"; }

alias search='web_search google'
alias baidu='web_search baidu'
alias bing='web_search bing'

# ===================== 🧰 常用别名（含优雅降级） =====================
if command -v lsd >/dev/null 2>&1; then
  alias ls='lsd'
  alias ll='lsd -alh --group-dirs=first'
  alias la='lsd -A'
else
  alias ll='ls -alh --color=auto'
  alias la='ls -A --color=auto'
fi

if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --style=plain --paging=never'
  alias bat='batcat'
elif command -v bat >/dev/null 2>&1; then
  alias cat='bat --style=plain --paging=never'
fi

alias top='btop'; command -v btop >/dev/null 2>&1 || alias top='top'
alias cls='clear'
alias please='sudo $(fc -ln -1)'
alias update='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias ip='ip -c'
mkcd() { mkdir -p "$1" && cd "$1"; }

# ===================== 🧭 历史/补全/性能 =====================
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS SHARE_HISTORY AUTO_CD CORRECT
autoload -Uz compinit && compinit -C
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# 彩色 man
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# ===================== 🚀 启动画面（可注释） =====================
command -v neofetch >/dev/null 2>&1 && neofetch

# ===================== 🎨 Powerlevel10k =====================
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# —— extract/x 冲突处理 ——
unalias x 2>/dev/null
alias x='extract'

# ===================== 📦 Node / nvm =====================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ===================== 🧑‍💻 Vim 模式 & UI 指示 =====================
if [[ $- == *i* ]]; then
  bindkey -v
  export KEYTIMEOUT=1
  bindkey -M viins 'jk' vi-cmd-mode
  bindkey -M viins '^?' backward-delete-char
  bindkey -M viins '^[[3~' delete-char

  function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
      print -n "\e]0;NORMAL\a"
      echo -ne '\e[1 q'   # 方块光标
    else
      print -n "\e]0;INSERT\a"
      echo -ne '\e[5 q'   # 竖线光标
    fi
  }
  zle -N zle-keymap-select

  function zle-line-init { zle -K viins; zle-keymap-select }
  zle -N zle-line-init

  autoload -Uz add-zsh-hook
  enforce_vi_mode() { zle -K viins 2>/dev/null || true; }
  add-zsh-hook precmd enforce_vi_mode

  preexec() { echo -ne '\e[5 q'; }
fi
echo -ne '\e[5 q'
EOF

# ---- 10) 安装 Codex CLI（新增）----
echo "🤖 安装 Codex CLI（@openai/codex）……"
bash -lc '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
if command -v npm >/dev/null 2>&1; then
  npm i -g @openai/codex || true
else
  echo "⚠️ 未检测到 npm，Codex CLI 跳过。"
fi
'

# ---- 11) 安装 Claude CLI（保留，多策略尝试）----
echo "🤖 安装 Claude CLI……"
CLAUDE_OK=0
if command -v npm >/dev/null 2>&1; then
  set +e
  npm i -g @anthropic-ai/cli  && CLAUDE_OK=1
  if [ $CLAUDE_OK -eq 0 ]; then npm i -g @anthropic-ai/claude && CLAUDE_OK=1; fi
  if [ $CLAUDE_OK -eq 0 ]; then npm i -g claude && CLAUDE_OK=1; fi
  set -e
fi
if [ $CLAUDE_OK -eq 0 ]; then
  if ! command -v pipx >/dev/null 2>&1; then
    sudo apt -y install pipx || true
    pipx ensurepath || true
  fi
  set +e
  pipx install claude && CLAUDE_OK=1
  if [ $CLAUDE_OK -eq 0 ]; then pipx install anthropic && CLAUDE_OK=1; fi
  set -e
fi
[ $CLAUDE_OK -eq 1 ] && echo "✅ Claude CLI 安装完成（或已可用）。" || echo "⚠️ Claude CLI 未确认安装成功，可手动 npm/pipx 安装。"

# ---- 12) headless 安装 Vim/Neovim 插件 ----
echo "⚙️ 安装 Vim/Neovim 插件（headless）……"
set +e
command -v nvim >/dev/null 2>&1 && nvim --headless +PlugInstall +qall || true
command -v vim  >/dev/null 2>&1 && vim +PlugInstall +qall </dev/tty || true
set -e

# ---- 13) 完成提示 ----
echo
echo "✅ 完成！"
echo "   - 已安装 Codex CLI（运行 'codex' 首次登录/配置）"
echo "   - 已保留并尝试安装 Claude CLI（如需手动：npm i -g @anthropic-ai/cli）"
echo "   - my-vim 已安装到 ~/.vim（并在需要时链接 ~/.vimrc）"
echo "   - nvim 配置已拉取到 ~/.config/nvim"
echo "   - zsh 主题/插件、vim-plug、copilot.vim 就绪"
echo
echo "👉 现在关闭并重新打开终端，或执行：exec zsh"
echo "👉 首次使用 Copilot：在 Vim/Neovim 内执行 :Copilot setup"
echo "👉 Codex：直接运行 codex 查看帮助；Claude：claude --help（若安装成功）"

