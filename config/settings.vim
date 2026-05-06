" =============== 基础设置 ===============
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936,ucs-bom,default,latin1
" 24 位真彩；部分终端/环境不支持会报 E954，用 try 静默跳过
try
  set termguicolors
catch /E954/
  " 此环境不支持 24 位彩色，使用默认配色
endtry
set helplang=cn,en
set number relativenumber
set cursorline
set cursorcolumn
set signcolumn=yes
set nowrap
set tabstop=2 shiftwidth=2 expandtab smartindent autoindent
set ignorecase smartcase
set splitbelow splitright
set updatetime=200
set timeoutlen=500
" =============== 剪贴板设置（跨平台兼容）===============
" 根据系统类型设置剪贴板
if has('win32') || has('win64')
  " Windows 系统使用 unnamed（与系统剪贴板集成）
  if has('clipboard')
    set clipboard=unnamed
  endif
elseif has('mac') || has('macunix')
  " macOS 系统
  if has('clipboard')
    set clipboard=unnamed
  endif
else
  " Linux/Unix 系统使用 unnamedplus（需要 xclip 或 xsel）
  if has('clipboard')
    set clipboard=unnamedplus
  endif
endif

set noerrorbells visualbell t_vb=
set mouse=a
set scrolloff=8
set sidescrolloff=8
set hidden
set nobackup
set nowritebackup
set noswapfile
set undofile

" =============== 代码折叠 ===============
set foldmethod=syntax     " 基于语法的折叠（更智能）
set foldlevelstart=99     " 打开文件时所有折叠都展开
set foldnestmax=10        " 最大折叠嵌套层级
set foldenable            " 启用折叠功能
set foldlevel=2           " 折叠级别
set foldcolumn=1          " 左侧显示折叠列

" undo 文件保存在当前配置目录下（跨平台兼容）
" Vim 会自动处理路径分隔符，使用 simplify() 规范化路径

if exists('g:my_vim_config_dir')
  if exists('g:myvim_data_dir')
    let s:undodir = myvim#path#join(g:myvim_data_dir, 'undodir')
  else
    let s:undodir = myvim#path#join(g:my_vim_config_dir, 'undodir')
  endif
else
  " 回退到当前脚本目录（如果 settings.vim 被独立加载）
  let s:undodir = myvim#path#join(fnamemodify(resolve(expand('<sfile>')), ':p:h'), 'undodir')
endif
call myvim#path#ensure_dir(s:undodir)
execute 'set undodir=' . fnameescape(s:undodir)

" 便携/离线模式：将 viminfo 文件也放到仓库目录内（避免写入用户目录）。
if exists('g:myvim_data_dir')
  let s:viminfofile = simplify(g:myvim_data_dir . '/viminfo')
  execute 'set viminfofile=' . fnameescape(s:viminfofile)
elseif exists('g:my_vim_config_dir')
  let s:viminfofile = simplify(g:my_vim_config_dir . '/viminfo')
  execute 'set viminfofile=' . fnameescape(s:viminfofile)
endif
set hlsearch
set incsearch
set showmode
set showcmd
set wildmenu
set wildmode=longest:full,full
" 补全选项：menuone=总是显示菜单，noinsert=不自动插入（需按键确认）
" 移除 noselect，让补全菜单自动选中第一项，这样 Enter/<C-y> 才能确认
set completeopt=menuone,noinsert
set pumheight=10
set laststatus=2
set backspace=indent,eol,start
set shortmess+=I  " 不显示启动信息
set shortmess+=c  " 不显示补全菜单消息
filetype plugin indent on
syntax enable

" 禁用 netrw (防止自动分屏)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" 禁用启动时的映射显示
set shortmess+=F

" WSL 剪贴板集成
if has("wsl")
  let g:clipboard = {
  \ "name": "WslClipboard",
  \ "copy": { "+": "clip.exe", "*": "clip.exe" },
  \ "paste": {
  \   "+": "powershell.exe -NoProfile -Command Get-Clipboard",
  \   "*": "powershell.exe -NoProfile -Command Get-Clipboard"
  \ },
  \ "cache_enabled": 0
  \}
endif

" Leader 键设置
let mapleader=" "
let maplocalleader=" "

" 文件类型特定设置
augroup FileTypeSettings
  autocmd!
  autocmd FileType python setlocal tabstop=4 shiftwidth=4
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab
  autocmd FileType c,cpp setlocal tabstop=4 shiftwidth=4
  autocmd FileType markdown setlocal wrap linebreak
  autocmd BufWritePre * :%s/\s\+$//e  " 保存时删除行尾空格
augroup END

" =============== 启动窗口清理（避免 vim file 多出分屏） ===============
" 目标：当用 `vim <file>` 启动时，只保留文件窗口；
"       避免出现额外的空白分屏/侧栏（例如名为 <CR> 的神秘空 buffer）。
function! s:MyVimCleanupStartupWindows() abort
  if argc() <= 0
    return
  endif
  if winnr('$') <= 1
    return
  endif

  let l:curwin = winnr()
  for l:win in reverse(range(1, winnr('$')))
    if l:win == l:curwin
      continue
    endif

    let l:bn = winbufnr(l:win)
    let l:ft = getbufvar(l:bn, '&filetype')
    let l:bt = getbufvar(l:bn, '&buftype')
    let l:name = bufname(l:bn)

    let l:is_sidebar = index(['nerdtree', 'tagbar', 'startify'], l:ft) >= 0
    let l:is_mystery_cr = (l:name ==# '<CR>' && empty(l:ft) && empty(l:bt))

    if l:is_sidebar || l:is_mystery_cr
      execute l:win . 'wincmd w'
      silent! close
    endif
  endfor

  " 回到原始窗口（如果仍存在）
  if l:curwin <= winnr('$')
    execute l:curwin . 'wincmd w'
  endif
endfunction

augroup MyVimStartupWindowCleanup
  autocmd!
  autocmd VimEnter * call s:MyVimCleanupStartupWindows()
  " 一些环境/插件会在 VimEnter 之后才制造额外窗口；
  " 用首次 BufReadPost 再清理一次，避免影响后续用户手动分屏。
  autocmd BufReadPost * ++once call s:MyVimCleanupStartupWindows()
augroup END
