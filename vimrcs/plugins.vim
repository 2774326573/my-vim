" 启用插件
set nocompatible
filetype on
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件列表
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('/root/my-vim/.vim/plugged')

Plug 'chxuan/cpp-mode'
Plug 'chxuan/vim-edit'
"Plug 'chxuan/change-colorscheme'
"Plug 'chxuan/prepare-code'
Plug 'chxuan/vim-buffer'
Plug 'chxuan/vimplus-startify'
Plug 'preservim/tagbar'
"Plug 'neoclide/coc.vim',{'branch':'release'}
"Plug 'ycm-core/YouCompleteMe',
"Plug 'Yggdroot/LeaderF'
"Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
"Plug 'junegunn/vim-slash'
"Plug 'junegunn/gv.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function'
Plug 'sgur/vim-textobj-parameter'
" Plug 'Shougo/echodoc.vim'
" Plug 'terryma/vim-smooth-scroll'
" Plug 'rhysd/clever-f.vim'
" Plug 'vim-scripts/indentpython.vim'
"Plug 'ferrine/md-img-paste.vim'
Plug 'godlygeek/tabular' "必要插件，安装在vim-markdown前面
Plug 'craigmac/vim-mermaid' 
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
Plug 'morhetz/gruvbox'
" Plug 'iamcco/markdown-preview.vim'
"Plug 'instant-markdown/vim-instant-markdown',{'for':'markdown','do': 'yarn install'}
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'skywind3000/vim-auto-popmenu'
Plug 'skywind3000/vim-dict'
Plug 'SirVer/ultisnips'
Plug 'keelii/vim-snippets'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsSnippetDirectories = ['/root/my-vim/.vim/plugged/vim-snippets/UltiSnips', 'UltiSnips','Mysnippets']
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit= "vertical"

" vim-markdown-composer
"function! BuildComposer(info)
"  if a:info.status != 'unchanged' || a:info.force
"    if has('nvim')
"      !cargo build --release --locked
"    else
"      !cargo build --release --locked --no-default-features --features json-rpc
"    endif
"  endif
"endfunction
"Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
"Plug 'suan/vim-instant-markdown'
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'alpertuna/vim-header-hard-things'
" Plug 'pbondoer/vim-42header'


Plug 'lervag/vimtex'

let g:tex_flavor= 'latex'

let g:vimtex_view_method= 'zathura'

let g:vimtex_quickfix_mode=0

set conceallevel=1

let g:tex_conceal= 'abdmg'
"
"加载自定义插件
if filereadable(expand($HOME . '/.vimrc.custom.plugins'))
    source $HOME/.vimrc.custom.plugins
endif

call plug#end()
autocmd vimenter * nested colorscheme gruvbox
