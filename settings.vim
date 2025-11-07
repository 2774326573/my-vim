" =============== 基础设置 ===============
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,cp936,ucs-bom,default,latin1
set termguicolors
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
set clipboard=unnamedplus
set noerrorbells visualbell t_vb=
set mouse=a
set scrolloff=8
set sidescrolloff=8
set hidden
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.vim/undodir
set hlsearch
set incsearch
set showmode
set showcmd
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect
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
