#!/usr/bin/env bash
set -euo pipefail

# ===== 可通过环境变量覆盖 =====
NAME="${NAME:-吴兴松}"
EMAIL="${EMAIL:-wuxingsong4509@gmail.com}"
KEY_NAME="${KEY_NAME:-id_ed25519}"            # 也可设为 id_ed25519_work
SSH_DIR="${HOME}/.ssh"
KEY_PATH="${SSH_DIR}/${KEY_NAME}"
GITCONFIG="${HOME}/.gitconfig"
GITIGNORE_GLOBAL="${HOME}/.gitignore_global"

# ===== 检测并安装 git / openssh =====
install_pkgs() {
  if command -v git >/dev/null 2>&1 && command -v ssh >/dev/null 2>&1; then
    echo "✓ git 与 ssh 已可用，跳过安装"
    return
  fi

  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew >/dev/null 2>&1; then
      echo "未检测到 Homebrew，请先安装：https://brew.sh"
      exit 1
    fi
    brew install git openssh
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y
    sudo apt-get install -y git openssh-client
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y git openssh
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman --noconfirm -S git openssh
  else
    echo "未识别的包管理器，请手动安装 git 与 openssh。"
    exit 1
  fi
  echo "✓ 安装完成"
}

# ===== 生成 SSH 密钥（如不存在） =====
gen_ssh_key() {
  mkdir -p "${SSH_DIR}"
  chmod 700 "${SSH_DIR}"

  if [[ -f "${KEY_PATH}" || -f "${KEY_PATH}.pub" ]]; then
    echo "✓ 检测到已存在 SSH 密钥：${KEY_PATH}，跳过生成"
  else
    echo "→ 正在生成 SSH 密钥（ed25519）..."
    ssh-keygen -t ed25519 -C "${EMAIL}" -f "${KEY_PATH}" -N ""
    echo "✓ 密钥生成完成：${KEY_PATH}"
  fi

  # 启动/检测 ssh-agent 并添加密钥
  if ! pgrep -u "$USER" ssh-agent >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
  fi
  ssh-add -l >/dev/null 2>&1 || true
  if ! ssh-add -l | grep -q "${KEY_PATH}"; then
    ssh-add "${KEY_PATH}" || true
  fi

  echo "你的公钥如下（可复制到 GitHub/GitLab）："
  echo "--------------------------------------"
  cat "${KEY_PATH}.pub"
  echo "--------------------------------------"
}

# ===== 写入全局 .gitignore（幂等） =====
setup_gitignore_global() {
  if [[ ! -f "${GITIGNORE_GLOBAL}" ]]; then
    cat > "${GITIGNORE_GLOBAL}" <<'EOF'
# Common
.DS_Store
Thumbs.db
*.log
*.tmp
*.swp
*.swo

# Env / Build
.env
.env.*
dist/
build/
out/
coverage/

# Node
node_modules/

# Python
__pycache__/
*.pyc
.venv/

# Others
.idea/
.vscode/
EOF
    echo "✓ 已创建 ${GITIGNORE_GLOBAL}"
  else
    echo "✓ 检测到 ${GITIGNORE_GLOBAL}，跳过创建"
  fi
  git config --global core.excludesfile "${GITIGNORE_GLOBAL}"
}

# ===== 写入 ~/.gitconfig（幂等覆盖写入） =====
write_gitconfig() {
  cat > "${GITCONFIG}" <<EOF
[user]
    name = ${NAME}
    email = ${EMAIL}
    # 如需用 SSH 做提交签名，取消下列注释并确保 Git>=2.34
    # signingkey = ${KEY_PATH}.pub

[core]
    editor = nvim
    autocrlf = input
    ignorecase = false
    whitespace = fix,-indent-with-non-tab,trailing-space,cr-at-eol

[alias]
    st = status
    co = checkout
    br = branch
    cm = commit -m
    ca = commit -am
    df = diff
    lg = log --oneline --graph --decorate --all
    last = log -1 HEAD
    unstage = reset HEAD --
    undo = reset --soft HEAD~1

[color]
    ui = auto
    branch = auto
    diff = auto
    status = auto

[push]
    default = simple

[pull]
    rebase = false

[merge]
    tool = nvimdiff
    conflictstyle = diff3

[credential]
    helper = store

[init]
    defaultBranch = main

[ssh]
    # 如有多套密钥，可在此显式指定
    command = "ssh -i ${KEY_PATH}"

# 若希望启用 SSH 提交签名，请取消以下注释：
# [gpg]
#     format = ssh
# [commit]
#     gpgsign = true
EOF

  echo "✓ 已写入 ${GITCONFIG}"
}

# ===== 可选：GitHub/GitLab 快速测试（不强制） =====
test_hosts() {
  echo "→ 可选测试：尝试连通 github.com 和 gitlab.com（不影响配置）"
  ssh -o StrictHostKeyChecking=accept-new -T git@github.com 2>/dev/null || true
  ssh -o StrictHostKeyChecking=accept-new -T git@gitlab.com 2>/dev/null || true
  echo "✓ 测试完成（若看到欢迎/提示信息即为通）"
}

# ===== 执行流程 =====
install_pkgs
gen_ssh_key
setup_gitignore_global
write_gitconfig
test_hosts

echo
echo "🎉 全部完成！常用检查："
echo "  git config --global --list | sed 's/: /= /'"
echo "  ssh -T git@github.com    # 添加公钥后可测试"

