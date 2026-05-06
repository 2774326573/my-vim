" Plugin management (vim-plug)
" 插件安装在当前配置目录下的 plugged 文件夹
" Vim 会自动处理路径分隔符（Windows 使用 '\'，Unix 使用 '/'），使用 '/' 在所有平台都能正常工作

" vim-polyglot 的 autoindent 子功能会在无文件启动时触发 <afile> 报错。
let g:polyglot_disabled = ['autoindent']

" 语言服务器客户端：默认使用 coc.nvim；可改为 'vim-lsp' 回退到旧方案。
let g:myvim_lsp_engine = get(g:, 'myvim_lsp_engine', 'coc')

" coc.nvim 需要在插件加载前知道 Node 和数据目录。
if g:myvim_lsp_engine ==# 'coc'
  if exists('g:my_vim_config_dir')
    let g:coc_node_path = simplify(g:my_vim_config_dir . '/tools/node/node.exe')
  endif
  if exists('g:myvim_data_dir')
    let g:coc_data_home = simplify(g:myvim_data_dir . '/coc-data')
  endif
  let g:coc_disable_startup_warning = 1
  let g:coc_disable_mappings_check = 1
endif

" 优先使用 _vimrc 中定义的配置目录，否则使用当前脚本所在目录
if exists('g:my_vim_config_dir')
  if exists('g:myvim_data_dir')
    let s:plug_dir = simplify(g:myvim_data_dir . '/plugged')
  else
    let s:plug_dir = simplify(g:my_vim_config_dir . '/plugged')
  endif
else
  " 如果未定义，使用当前脚本所在目录
  let s:plug_dir = simplify(fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/plugged')
endif
call plug#begin(s:plug_dir)

" 主题和外观 (Vim 兼容版本)
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

" Git 集成（需要 git 命令，无 git 环境请禁用）
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'

" 编辑增强
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'

" 文件浏览
" fzf 安装在当前配置目录下（跨平台兼容）
function! s:myvim_is_windows7() abort
  if !(has('win32') || has('win64'))
    return 0
  endif
  let l:ver = system('cmd /c ver')
  return l:ver =~# '6\.1\.'
endfunction

" Windows/Win7 下 fzf.exe 和 fzf.vim 的 shell 探测容易不兼容；默认禁用。
" 如确认当前系统可用，可在 _vimrc 加载插件前设置：let g:myvim_use_fzf = 1
let g:myvim_use_fzf = get(g:, 'myvim_use_fzf', (has('win32') || has('win64') || s:myvim_is_windows7()) ? 0 : 1)

if exists('g:my_vim_config_dir')
  if exists('g:myvim_data_dir')
    let g:myvim_fzf_dir = simplify(g:myvim_data_dir . '/fzf')
  else
    let g:myvim_fzf_dir = simplify(g:my_vim_config_dir . '/fzf')
  endif
else
  let g:myvim_fzf_dir = simplify(fnamemodify(resolve(expand('<sfile>')), ':p:h') . '/fzf')
endif
" 根据平台选择安装脚本
if g:myvim_use_fzf
  if has('win32') || has('win64')
    Plug 'junegunn/fzf', { 'dir': g:myvim_fzf_dir, 'do': 'powershell -ExecutionPolicy Bypass -File install.ps1' }
  else
    Plug 'junegunn/fzf', { 'dir': g:myvim_fzf_dir, 'do': './install --all' }
  endif
  Plug 'junegunn/fzf.vim'
endif
Plug 'preservim/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'  " 需要 git，无 git 环境请禁用
Plug 'preservim/tagbar'              " 传统大纲插件（基于 ctags）
Plug 'liuchengxu/vista.vim'         " 现代化大纲（支持 LSP）

" LSP / 补全
if g:myvim_lsp_engine ==# 'coc'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

" Markdown 编辑增强
Plug 'preservim/vim-markdown'       " Markdown 语法和功能
Plug 'dhruvasagar/vim-table-mode'   " 表格编辑
Plug 'dkarter/bullets.vim'          " 列表自动化
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }  " 实时预览

" Debugging
Plug 'puremourning/vimspector'

" CMake
" vim-cmake 在 Neovim 下工作正常，在传统 Vim 下可能有问题
" 仅在 Neovim 环境启用
if has('nvim')
  Plug 'cdelledonne/vim-cmake'
endif

" Syntax
Plug 'sheerun/vim-polyglot'

" 前端开发增强插件
Plug 'mattn/emmet-vim'              " HTML/CSS 快速编写
Plug 'ap/vim-css-color'             " CSS 颜色预览
Plug 'alvan/vim-closetag'           " HTML 标签自动闭合
Plug 'AndrewRadev/tagalong.vim'     " HTML 标签同步重命名
Plug 'Valloric/MatchTagAlways'      " 高亮匹配的 HTML 标签

" 代码片段 (snipMate - 不需要Python)
Plug 'MarcWeber/vim-addon-mw-utils'  " snipMate依赖
Plug 'tomtom/tlib_vim'               " snipMate依赖
Plug 'garbas/vim-snipmate'           " 代码片段引擎
Plug 'honza/vim-snippets'            " 预定义代码片段集合

" 彩虹括号和颜色增强
Plug 'luochen1990/rainbow'          " 彩虹括号
Plug 'nathanaelkane/vim-indent-guides' " 彩虹缩进
Plug 'kshenoy/vim-signature'        " 标记可视化

" 智能代码折叠
Plug 'Konfekt/FastFold'             " 提高折叠性能
Plug 'tmhedberg/SimpylFold'         " Python 智能折叠

" 数据库支持
Plug 'tpope/vim-dadbod'             " 数据库接口
Plug 'kristijanhusak/vim-dadbod-ui' " 数据库 UI
Plug 'kristijanhusak/vim-dadbod-completion' " 数据库补全

" 其他实用工具
Plug 'mbbill/undotree'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vim-which-key'
Plug 'yianwillis/vimcdoc'
Plug 'voldikss/vim-translator'
Plug 'skywind3000/vim-dict'

call plug#end()
