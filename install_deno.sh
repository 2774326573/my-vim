#!/usr/bin/env bash
#
# 脚本功能:
#   1. 检查系统是否已经安装 Deno
#   2. 若未安装, 自动下载官方安装脚本并安装到 ~/.deno
#   3. 自动向 ~/.bashrc 与 ~/.zshrc 追加 PATH 配置 (若尚未追加)

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { printf "%b[INFO]%b %s\n"    "$BLUE"  "$NC" "$1"; }
warn()    { printf "%b[WARN]%b %s\n"    "$YELLOW" "$NC" "$1"; }
success() { printf "%b[SUCCESS]%b %s\n" "$GREEN" "$NC" "$1"; }
error()   { printf "%b[ERROR]%b %s\n"   "$RED"   "$NC" "$1"; }

echo "======================================"
echo "        Deno 自动安装脚本             "
echo "======================================"
echo

if command -v deno >/dev/null 2>&1; then
    success "已检测到 Deno: $(deno --version | head -n 1)"
    exit 0
fi

if ! command -v curl >/dev/null 2>&1; then
    error "curl 未安装, 无法下载官方安装脚本, 请先安装 curl 再重试。"
    exit 1
fi

INSTALL_DIR="${DENO_INSTALL:-$HOME/.deno}"
info "安装目录: $INSTALL_DIR"

TMP_SCRIPT="$(mktemp)"
cleanup() {
    rm -f "$TMP_SCRIPT"
}
trap cleanup EXIT

info "下载官方 Deno 安装脚本..."
curl -fsSL https://deno.land/install.sh -o "$TMP_SCRIPT"

info "执行安装..."
export DENO_INSTALL="$INSTALL_DIR"
sh "$TMP_SCRIPT"

BIN_PATH="$INSTALL_DIR/bin/deno"
if [[ ! -x "$BIN_PATH" ]]; then
    error "安装失败, 未找到 $BIN_PATH"
    exit 1
fi

append_path_config() {
    local target="$1"
    local marker="# >>> deno-path >>>"
    if [[ -f "$target" ]] && grep -Fq "$marker" "$target"; then
        info "$target 已包含 Deno PATH 配置, 跳过写入。"
        return
    fi

    info "向 $target 追加 PATH 配置..."
    mkdir -p "$(dirname "$target")"
    touch "$target"
    cat >> "$target" <<'EOF'

# >>> deno-path >>>
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# <<< deno-path <<<
EOF
    success "已写入 $target"
}

append_path_config "$HOME/.bashrc"
append_path_config "$HOME/.zshrc"

echo
success "Deno 安装完成!"
"$BIN_PATH" --version

echo
warn "若当前终端仍无法使用 deno, 请执行:"
echo "  exec \$SHELL -l"
echo "或重新打开一个新的终端窗口, 让 PATH 生效。"

