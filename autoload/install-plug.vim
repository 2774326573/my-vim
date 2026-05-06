" =============== 自动安装 vim-plug ===============
" 功能：自动检测并安装 vim-plug 插件管理器
" 使用：在 _vimrc 中取消注释 "source .../install-plug.vim" 来启用
"
" 安装位置：项目目录/autoload/plug.vim
" 支持：Windows (PowerShell), Linux/Mac (curl/wget)

" 安全开关：默认禁用自动下载，避免在离线环境误触发网络请求。
" 如需启用：在 _vimrc 里设置 let g:myvim_disable_plug_autoinstall = 0
if exists('g:myvim_disable_plug_autoinstall') && g:myvim_disable_plug_autoinstall
  finish
endif

" 需要先定义全局变量 g:my_vim_config_dir（项目目录）
if !exists('g:my_vim_config_dir')
  echohl ErrorMsg
  echom 'install-plug.vim: g:my_vim_config_dir 未定义，请先加载 _vimrc'
  echohl None
  finish
endif

" ===== 自动安装 vim-plug（插件管理器） =====
let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:autoload_dir = myvim#path#join(g:my_vim_config_dir, 'autoload')
let s:plug_file = myvim#path#join(s:autoload_dir, 'plug.vim')

" ---- 自动下载 plug.vim（如果未安装） ----
if !filereadable(s:plug_file)
  " 确保 autoload 目录存在
  if !isdirectory(s:autoload_dir)
    call mkdir(s:autoload_dir, 'p')
  endif

  " 优先用 curl，其次 PowerShell（Win），再次 wget
  if executable('curl')
    " curl （全平台通用）
    silent! call system('curl -fLo ' . shellescape(s:plug_file) . ' --create-dirs ' . shellescape(s:plug_url))
  elseif (has('win32') || has('win64')) && executable('powershell')
    " PowerShell（Windows 特有）
    let s:plug_file_ps = substitute(s:plug_file, '/', '\', 'g')
    let s:ps_cmd = 'powershell -NoProfile -Command "try { (New-Object System.Net.WebClient).DownloadFile(''' . s:plug_url . ''', [System.IO.Path]::GetFullPath(''' . s:plug_file_ps . ''')) } catch { Write-Host $_.Exception.Message }"'
    silent! call system(s:ps_cmd)
  elseif executable('wget')
    " wget（最后兜底，类Unix系统）
    silent! call system('wget -O ' . shellescape(s:plug_file) . ' ' . shellescape(s:plug_url))
  endif
endif

" ---- 加载 plug.vim（安装完成后自动加载） ----
if filereadable(s:plug_file)
  " 安装成功，加载 plug.vim
  execute 'source ' . fnameescape(s:plug_file)
else
  " 安装失败，尝试从标准位置加载
  let s:standard_plug_locations = []
  if has('win32') || has('win64')
    call add(s:standard_plug_locations, expand('~/vimfiles/autoload/plug.vim'))
  endif
  if has('unix')
    call add(s:standard_plug_locations, expand('~/.vim/autoload/plug.vim'))
  endif

  let s:found = 0
  for s:location in s:standard_plug_locations
    if filereadable(s:location)
      execute 'source ' . fnameescape(s:location)
      let s:found = 1
      break
    endif
  endfor

  " 若都找不到：提示手动安装方法和命令
  if !s:found
    echohl WarningMsg
    echom 'vim-plug 安装失败，请手动安装:'
    echom '  项目目录: ' . g:my_vim_config_dir
    echom '  目标文件: ' . s:plug_file
    if executable('curl')
      echom '  命令: curl -fLo ' . s:plug_file . ' --create-dirs ' . s:plug_url
    elseif (has('win32') || has('win64')) && executable('powershell')
      echom '  或使用 PowerShell 手动下载到: ' . s:plug_file
    else
      echom '  请访问: https://github.com/junegunn/vim-plug'
    endif
    echohl None
  endif
endif

