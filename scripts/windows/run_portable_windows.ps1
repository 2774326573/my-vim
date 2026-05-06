# 便携模式启动 Vim：设置 PATH/LIB 等环境变量后启动，确保 clangd、pylsp、fzf、sdcv 可被找到
# 使用：在仓库根目录执行 pwsh -ExecutionPolicy Bypass -File .\scripts\windows\run_portable_windows.ps1

param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$VimArgs = @()
)

$ErrorActionPreference = 'Stop'
$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$Vimrc = Join-Path $RepoRoot '_vimrc'

# 构建 PATH 追加项
$pathAdds = @()
if (Test-Path (Join-Path $RepoRoot 'tools\llvm\bin')) {
  $pathAdds += Join-Path $RepoRoot 'tools\llvm\bin'
}
if (Test-Path (Join-Path $RepoRoot 'tools\win-runtime')) {
  $pathAdds += Join-Path $RepoRoot 'tools\win-runtime'
}
if (Test-Path (Join-Path $RepoRoot 'tools\sdcv')) {
  $pathAdds += Join-Path $RepoRoot 'tools\sdcv'
}
if (Test-Path (Join-Path $RepoRoot 'tools\git\bin')) {
  $pathAdds += Join-Path $RepoRoot 'tools\git\bin'
}
if (Test-Path (Join-Path $RepoRoot 'data\fzf\bin')) {
  $pathAdds += Join-Path $RepoRoot 'data\fzf\bin'
}
if (Test-Path (Join-Path $RepoRoot 'tools\python')) {
  $pathAdds += Join-Path $RepoRoot 'tools\python'
}
if (Test-Path (Join-Path $RepoRoot 'tools\ripgrep')) {
  $pathAdds += Join-Path $RepoRoot 'tools\ripgrep'
}

$env:PATH = ($pathAdds + $env:PATH) -join [System.IO.Path]::PathSeparator

# LIB（clangd 链接时可能用到）
$libAdd = Join-Path $RepoRoot 'tools\win-runtime'
if (Test-Path $libAdd) {
  $env:LIB = if ($env:LIB) { "$libAdd;$env:LIB" } else { $libAdd }
}

# StarDict 离线词典目录（vim-translator sdcv）
$stardictDir = Join-Path $RepoRoot 'tools\stardict\dic'
if (Test-Path $stardictDir) {
  $env:STARDICT_DATA_DIR = $stardictDir
}

# 指定 _vimrc，启动 Vim
Push-Location $RepoRoot
try {
  $cmd = @('vim', '-u', $Vimrc) + $VimArgs
  & $cmd
} finally {
  Pop-Location
}
