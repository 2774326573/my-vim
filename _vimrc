" =============== Vim 主配置文件 ===============
" 本文件负责加载所有配置模块
"
" 配置文件结构说明：
"   - plugins.vim      : 插件列表声明（vim-plug）
"   - settings.vim     : Vim 基础设置
"   - plugin-config.vim: 插件特定配置
"   - keymaps.vim      : 所有快捷键映射
"
" 更多信息请参考: docs/配置结构说明.md

" =============== 跨平台路径处理 ===============
" Vim 会自动处理路径分隔符（Windows 使用 '\'，Unix 使用 '/'）
" 使用 '/' 在所有平台上都能正常工作，Vim 会自动转换
" ===== 路径处理函数（跨平台） =====
"[[[
function! s:JoinPath(...)
  " 使用 simplify() 规范化路径，自动处理路径分隔符
  return simplify(join(a:000, '/'))
endfunction

" ===== 获取配置文件目录 =====
" 1. 获取 _vimrc 文件实际路径（resolve 处理符号链接）
let s:vimrc_file = resolve(expand('<sfile>'))
" 2. 获取 _vimrc 所在目录
let s:config_dir = fnamemodify(s:vimrc_file, ':p:h')

" ===== 查找项目根目录（包含 config/ 子目录） =====
let s:project_dir = s:config_dir
if !isdirectory(s:JoinPath(s:config_dir, 'config'))
  " 向上递归最多3层寻找 config/ 目录
  let s:parent = s:config_dir
  for s:i in range(3)
    let s:parent = fnamemodify(s:parent, ':h')
    if isdirectory(s:JoinPath(s:parent, 'config'))
      let s:project_dir = s:parent
      break
    endif
    " 已到达文件系统根目录，终止查找
    if s:parent == fnamemodify(s:parent, ':h')
      break
    endif
  endfor
endif

" ===== 设置全局变量，供插件/配置使用 =====
let g:my_vim_config_dir = s:project_dir

" ===== 便携/离线：统一数据目录（插件、undo、session、viminfo 等） =====
let g:myvim_data_dir = simplify(g:my_vim_config_dir . '/data')
if !isdirectory(g:myvim_data_dir)
  call mkdir(g:myvim_data_dir, 'p')
endif

" ===== 将项目目录加入 runtimepath（用于 autoload/ 与 pack/） =====
execute 'set runtimepath^=' . fnameescape(s:project_dir)

" ===== 禁用 vim-plug 自动下载（推荐：离线/可控） =====
" 说明：install-plug.vim 是可选功能；为避免误触发网络下载，这里默认禁用。
" 如确实需要自动下载，把它改成 0，并在下方取消注释 source install-plug.vim。
let g:myvim_disable_plug_autoinstall = 1

" ===== 自动安装 vim-plug（可选功能） =====
" 方式1：启用自动安装（推荐）
" 取消下面的注释以启用自动安装功能，install-plug.vim 会负责下载安装和加载 vim-plug
" execute 'source ' . fnameescape(s:JoinPath(s:project_dir, 'autoload/install-plug.vim'))

" 方式2：手动加载 vim-plug（如果未启用自动安装或自动安装后仍未加载）
" 只有在 vim-plug 尚未加载的情况下才执行
if !exists('g:loaded_plug')
  let s:plug_file = s:JoinPath(s:project_dir, 'autoload/plug.vim')
  if filereadable(s:plug_file)
    execute 'source ' . fnameescape(s:plug_file)
  else
    " 尝试系统标准位置
    if has('win32') || has('win64')
      let s:standard_plug = expand('~/vimfiles/autoload/plug.vim')
    else
      let s:standard_plug = expand('~/.vim/autoload/plug.vim')
    endif
    if filereadable(s:standard_plug)
      execute 'source ' . fnameescape(s:standard_plug)
    else
      echohl WarningMsg
      echom 'vim-plug 未找到。请手动安装或启用自动安装功能。'
      echom '  启用自动安装: 取消注释第 52 行的 install-plug.vim'
      echom '  查看帮助: 见 docs/vim-plug自动安装说明.md'
      echohl None
    endif
  endif
endif
"]]]
" =============== 加载配置模块 ===============
" 配置文件现在位于项目目录的 config/ 子目录中（工程化目录结构）
let s:config_subdir = s:JoinPath(s:project_dir, 'config')

" 按顺序加载：插件 -> 设置 -> 插件配置 -> 快捷键
" 1. 插件列表（必须在最前面，以便 vim-plug 正确初始化）
execute 'source ' . fnameescape(s:JoinPath(s:config_subdir, 'plugins.vim'))

" 2. 基础设置
execute 'source ' . fnameescape(s:JoinPath(s:config_subdir, 'settings.vim'))

" 3. 插件配置
execute 'source ' . fnameescape(s:JoinPath(s:config_subdir, 'plugin-config.vim'))

" 4. 快捷键映射
execute 'source ' . fnameescape(s:JoinPath(s:config_subdir, 'keymaps.vim'))

" =============== 配置加载完成 ===============
" 提示：使用 :scriptnames 可以查看所有已加载的脚本

