@echo off
REM 便携模式启动 Vim（纯 CMD，无需 PowerShell）
REM 使用：在仓库根目录执行 scripts\windows\run_portable_windows_nops1.cmd
REM 或双击此文件（需先 cd 到仓库根目录）

setlocal
set "REPO=%~dp0..\.."
cd /d "%REPO%"

if exist "%REPO%\tools\llvm\bin" set "PATH=%REPO%\tools\llvm\bin;%PATH%"
if exist "%REPO%\tools\win-runtime" set "PATH=%REPO%\tools\win-runtime;%PATH%"
if exist "%REPO%\tools\sdcv" set "PATH=%REPO%\tools\sdcv;%PATH%"
if exist "%REPO%\tools\git\bin" set "PATH=%REPO%\tools\git\bin;%PATH%"
if exist "%REPO%\data\fzf\bin" set "PATH=%REPO%\data\fzf\bin;%PATH%"
if exist "%REPO%\tools\python" set "PATH=%REPO%\tools\python;%PATH%"
if exist "%REPO%\tools\ripgrep" set "PATH=%REPO%\tools\ripgrep;%PATH%"

if exist "%REPO%\tools\win-runtime" set "LIB=%REPO%\tools\win-runtime;%LIB%"
if exist "%REPO%\tools\stardict\dic" set "STARDICT_DATA_DIR=%REPO%\tools\stardict\dic"

vim -u "%REPO%\_vimrc" %*
